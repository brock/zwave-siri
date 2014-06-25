var regex = /turn\s(on|off)\s(the)?\s(.*)\slights/g;
var match = regex.exec(phrase);
consoleLog(match);

respondWithTextAndURL('Turning '+match[1]+' the '+match[3]+' lights', 'http://YOUR.DUCKDNS.ORG/lights/'+match[3]+'/'+match[1]);
                                                                                                            