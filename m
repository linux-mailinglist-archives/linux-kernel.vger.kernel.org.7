Return-Path: <linux-kernel+bounces-727678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D65B01DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EBF1C41D49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB82D9EEF;
	Fri, 11 Jul 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="QvtCZ7kc"
Received: from mx08-0063e101.pphosted.com (mx08-0063e101.pphosted.com [185.183.31.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1322D23A8;
	Fri, 11 Jul 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241130; cv=fail; b=HadQ2s4FOLaIOX20litUcBhRs/0XmRDSEtoQ/5a4xj0ANvaOe7lys6t45Z97ucFxPkm5120Q/f8LdSRo+yXBPZwWw7NNB++c5Phml1zZCnBD5Gh5J7d8OYrTU2LErGjjOthVkSfd0px2dJn13D6J5OUsykzDA1e8MpL880fDSQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241130; c=relaxed/simple;
	bh=+CiztTnPk74ji5wfzkvvOCY5vakAAw5wAfkhleuaHrQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Pl3FKk/ilxH7g7wJ9E0bc1ftYDSdcqlGlm+B/74lcXoAwF0uCE1HjrVOkdL6FBwXmJ96upaLNBUCwkNzp3guOqeCZ8gRF0vpv5xoxv8FrvoWw+ufl9c2z54iiqVdOePR6FWb3pVJ9ix+tznoHumAS6eA4xFLOT2JseZBAhh4qz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=QvtCZ7kc; arc=fail smtp.client-ip=185.183.31.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247494.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDaNFR008729;
	Fri, 11 Jul 2025 14:36:23 +0100
Received: from pnypr01cu001.outbound.protection.outlook.com (mail-centralindiaazon11020137.outbound.protection.outlook.com [52.101.225.137])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 47psctjcqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 14:36:23 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0iZUin58uOHS5jsaT34BRtQ3q7oOyOtk+np8oE5h07ljBI3fTgIigv19SgllhzT4/n6VMUwZJ9EesGn5PljAA7761SXjOdeH8FJCn+vLjjafocLvoAj72yEnPBeR3+pEX/M1ExWOYIeSOLGC63IreGv48/E7jbFu/BmGwYLrZQG7hS9Tu++NjbFMsRN+eQOCznskI7g0sTEw1O7Ouz5z8HCcGBujv5o/TIckygSbUjguSyaH0HAJGf/3LeKAwhDBkZAJkIdQrPdLN7kFWI6XjtngKJUjUKwuzTjOvJmT7vls+Ia4mRAXbHEKI+7Ej4UnJjvSg4FYEs75UgkRpoAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CiztTnPk74ji5wfzkvvOCY5vakAAw5wAfkhleuaHrQ=;
 b=dvwuTZh+Ah2FstimWDLIceTI/ojmzk7invfWnzqlSrvtDF7Lpm64E17gc+og+/gKFTcKezp+wCXWej9/6kAQEUoknNECwnNlkCgJadrdsU6dsHz9yaZAc4QUjbvoYe0zqkWpmFvCmh/5yWroDIEGxwCOBGQ0whEZc5N/wwI6xIXZIfGRZQf68ud1VbweuUb+54rcvhtYEXh9865ENVX5XHT0B8yN1Ypr2IgFqyE7DO6R5dvCsMaSx1EAT0efxR6BWulLYaJC9CxY+7S+4bEzzYc0iK2wGh0SrauJE2LkUuHhha9443vL3MjIg6H0Qz08bxLhXKV11oZ2WQMQ0SB/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CiztTnPk74ji5wfzkvvOCY5vakAAw5wAfkhleuaHrQ=;
 b=QvtCZ7kc5jwl7McARwhlGJHtwmmtR8/Z8k7GofAIrgoNPSuTGTVPKkEA4fk50xpVJhH89wMTtxBZY03Bzr9a357wnx5PgfDyZK++n3zZstxkvbEp3F6Sw6tPywG1p38mhkHKDRVEEjmsFPx1SeOdhjmAAmYm7fu4suh0X/eMD8w=
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ab::16) by PN0PR01MB7862.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 13:36:18 +0000
Received: from PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83]) by PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5cd1:bf89:3bb0:5f83%6]) with mapi id 15.20.8835.018; Fri, 11 Jul 2025
 13:36:18 +0000
From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nikolaos
 Pasaloukos <nikolaos.pasaloukos@blaize.com>
Subject: [PATCH 0/2] arm64/blaize: Enable Ethernet to SoC & CB2
Thread-Topic: [PATCH 0/2] arm64/blaize: Enable Ethernet to SoC & CB2
Thread-Index: AQHb8mjHVeaeQluH9U2OP1pPU/X/QQ==
Date: Fri, 11 Jul 2025 13:36:18 +0000
Message-ID:
 <20250711-kernel-upstreaming-add_network_support-v1-0-4a66a17c94b3@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNYPR01MB11172:EE_|PN0PR01MB7862:EE_
x-ms-office365-filtering-correlation-id: 5908fa20-69f3-4103-8767-08ddc07fea53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2pvYTFwS0ZvYnJ2QTVZa01ucEVWMEc1YldZTW9Kd2VZY21yR1hoSG9la3Ex?=
 =?utf-8?B?YkkvcHNybTRzWVFRTWxEbGRSV1hmUjQ3VktaS2pJL1ZCZUNVRjkzeFRXN2h5?=
 =?utf-8?B?TktkUFlzTE14TDE4SkwxZUFxdjJaU2gyOC9GR3NIeUtBeFBma3J3c2hBVCsz?=
 =?utf-8?B?WXRTa0JENk9WbVhFa2hENFRpUzFzVHErSUVEZVlGMEM2dkluVzZBNDlHNTRy?=
 =?utf-8?B?ZjM4aTlTcUV5YlkvSDMzekxlWEZkZlZYOVFqeHYrd1ltcUtMY3dHSnFkWVpR?=
 =?utf-8?B?QUtCblVlQkhsakxaUG53eW1sN2pkc01OeTBJZ29JRUhTcGtQQ3BGbDJURGRn?=
 =?utf-8?B?MzluaGRvSXNuOUMxVVM0T090Yy9FaWI1S01ndTRkZEVuVVVYc3BHa29HRXFL?=
 =?utf-8?B?TGp5U0tJSk9hM0szMlBMOEM0OWVsVkxjSm5UdFN2QW1qL0VkaHhOYm0wS29J?=
 =?utf-8?B?VkVXem9rTFRNVGV3MkZQR3JJQ084emh2c0ZrUGd3VDRGck05VndTbnFrL0pE?=
 =?utf-8?B?aWw1K3ZCWmN1YWtvN1k3K3lxazg3ZG5EOTdubjhRcElDKzNCcjVnTk9LK3hu?=
 =?utf-8?B?a1graG1oZmdEQXVZQ05FVkNQL3YwR3IvVGFJdWRUbzgyek5VTkJGK1lESk9y?=
 =?utf-8?B?Q1llTndaK1BlZDFxTm5EQ1g5QW5WNjU0OXBrUmJ0RUlITW1WNENPZjJ1aWg5?=
 =?utf-8?B?U3lTSlRtSzdLNzNqRzFndXRZMzlmdkhFeUtXNWVWeXRTZ2pMQWpVaUJQczdj?=
 =?utf-8?B?akplU0lMRE1kaXpmQ3pKcnlLYTg1VTRBUzRyMmtxK2xYeVVLeXRScWQxUWQx?=
 =?utf-8?B?aUQrSCtCRGN3aGw0R04zMDA5VkxZZTlWVTVFdDdxYTZXTWhkMkRKZFdubHdL?=
 =?utf-8?B?ZHFTa1JiaHI4WHVjblVxYzlJRkg5dGRiOFRkZ0dxTEo3Mlc2Q1M3WWZlZUFB?=
 =?utf-8?B?MUcwUkFxQ2RiSkEvZzVCWTVlL2tWQlB1Tk5FUzYweitmenMrRlNHQW1sSHRq?=
 =?utf-8?B?dEw1UmtmQVRuOGorai9jcDV0RHg4Z3NjcjhPU1h6cXVFREFDdzNaZ3JWb24v?=
 =?utf-8?B?MC8yb2ZqNEFoWDRhZDJCTXV0QVpKSUtYa3ZzbTZsVFZCY1JYQWZoLzZrWjU0?=
 =?utf-8?B?MURmQzhVSzJoN2xyYkh4Q3IySU1rVDBkMG9maFRTSGJvanJTaEVHendicEMy?=
 =?utf-8?B?UC84dFlsUGJNK1lFVWdONTg2VUpEV3BkTElwSWdIM24wZFQzcE1qNkkxRW9G?=
 =?utf-8?B?dFJGUGx5WnJnSXBOdG5wckxkVHJ4NENGc3ZObDVkM05yaVlZejlwZXdwRWc5?=
 =?utf-8?B?YWdqUW9NalNtemlLNFNuSkZpd3Q5Y28rZ2R1RUplT21DTjBaYkF2MENCbWs3?=
 =?utf-8?B?UThTTEtxNi9CRlN0aGR0Uzd2eFFvc2tIZ0V2ZmFpK3pNVUFWNHdqdlJ3bG9n?=
 =?utf-8?B?T2ZmemJoTlZFejRmUHdmTjhIL05nc3J6Vk82MU5JTG9KRDZWcUMrT0UyTXB1?=
 =?utf-8?B?Y01hVjFYMVpzdFR2bnJBbEplTjJIZUJqVit2alhrWmdkZmYzbmN6RGM3NEZa?=
 =?utf-8?B?TzhYVEJsZURZQkxQQWYvM3lvaXkzaTJNTFlPeG1qbVg0bWg3QWZZSElSSW1N?=
 =?utf-8?B?UWRtZm84dllUSnpsczZXWENpODcxdXNZSDBVenlqcXZ4Y0pGUjNrZ0JmekpH?=
 =?utf-8?B?bGlXZlJFY0lXK0I5ZzlDT2cwU2FVa2xqME1GQ3NJNGVrd0cySGd4NTZSYUdv?=
 =?utf-8?B?QWErNS9qNk03M1BTQTV1Y0VlTk40WXRKTlZSYUZ5a0ZQR2VwUVRqVTdKSkdm?=
 =?utf-8?B?NFU0VHFUeVVvUHJVRDFaaTIxVlFEV0FXdFhxTFFXRHVxcWJYTXcyZ1ZZTXlE?=
 =?utf-8?B?TmgxVVdNT0dzcVVmV28wdVlVREJpcnRSVUZaVkNxWjEvRWRLNjNLcEFrSGdE?=
 =?utf-8?B?elBjVWIzdFNQNmcxK2xYUG1XTjZNL1l2dnE0Z1hpM21FN2UvMXN5REJ0eUtx?=
 =?utf-8?B?dTNyMzAwMTh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmlZVDMzbUFSNzlUVnBidTJRMWRUb2taMk4yN0RVeFQxRXg1YzhQdFQvU1c4?=
 =?utf-8?B?Unc2TlVpQTg3cmF5d3JBbFJtaW9zRGRnRzJmczVvTjExV2VkOHQvRDlsWmdL?=
 =?utf-8?B?d2ZVb1dEUWh2M2puR3RGVzJ0VmdLM2Z6ZGZla3dQZHBDTTZYZWNFZ21pcWhm?=
 =?utf-8?B?ZWNoakJWZXQxeHEyd0RYOXV0cVFLRWI2bUFIVFc1Ym9ybnlSNGhNTGNvQ1FP?=
 =?utf-8?B?NlhOYmRrZENyVEpwNmorNUdFRFhFMVBVYzJudzZGRU9kWFJEUXU2UXBmS3hl?=
 =?utf-8?B?cHA3UHQ0RW1nYzJQMUhvbFBNKytNc2VtMmMxMGJ2K2VOM040ZVIyUzJjN2Mv?=
 =?utf-8?B?YWFaeXNFajE2WlEvQi9hcTFIaG1iSTk1MjNTUzhBZnBIZGNoYSszeG55UitI?=
 =?utf-8?B?elBBZTlubitzMHo3QXhDYWdLaHNDQXdHaFlFa0tRYU1aN3EvS2dTbXNlRUdB?=
 =?utf-8?B?eTVkNGVRYmZvaWsrbEY3blhtU1lBQjdWMktaZWhvNVcyYUVNZVFHZ3ViZHF4?=
 =?utf-8?B?WXFISS9RZk5hc2V1b0lYQ0l1SmR5SGh2SXgzTXcxVFBJZ3VQcE54MjBTWkJy?=
 =?utf-8?B?cTJnN2M1c2VWYkkyd1Q4YUZxYzR1L3J6NnEwc3ZGTk5xQ3NVa0VFSWk5UFM4?=
 =?utf-8?B?eWtoQitOSEtjcXNuL3MyYzRGU3c4ek1mL3NaR2lYVlBZeFU0bkxIbGU2Zjdz?=
 =?utf-8?B?c2V1VEtadEdhSGpvR1oxNWxNYWt5STZ6ejFQbGFGR1orOU15cTJqOVZFcUxh?=
 =?utf-8?B?cFVKYk9yb1NiNlZWOXh1VmZCVitVRzVIRDg1U0sxbHJSbDBtQ3d3SEQ2MkJa?=
 =?utf-8?B?WU1UbGxFUXYyYitFY1o1UnVtWEpOc1JvVWl0R091djdYaytMTi9icWhVZGZD?=
 =?utf-8?B?VXZTK1J1MVh2ZlUyaEUvUTJKaiswOG9tWGNzUmxvQkZJRXVaZXhuTkNOWkcv?=
 =?utf-8?B?UCs1ZFNrYndrUDJrY1N5WmlmUWFHaUtLSWRNdmZYbmVQVFVYTlkrdVJnZElX?=
 =?utf-8?B?Si9rZUFPaWVxcWIzMFdHM25vYnNJYjJpQWprNVBwVUZjUGJzWnZQN09ySGtE?=
 =?utf-8?B?ZlRlUnAxT1l6U2FaWDUxNXQ4VHU0ZksvekhZTEN1cUI2V0QySUNKbnBLckJO?=
 =?utf-8?B?SHlzL0syakpBVEVISGVWM2R1cEJ2aW11NU55Rzd6cHVsN2RPa20wMVBvRG9r?=
 =?utf-8?B?VlhNQTFXbHZwd0ZsOTZVUitCY0RWWHlvbG00USsvVkhvalZEMFh6dzJoUk9h?=
 =?utf-8?B?R0dkWlBwU2NHY2N2cEh4bUZ0Y1Z6S1JGcytmU3hqUjB2ektLVWlNUVE0NFIx?=
 =?utf-8?B?OUZESzRPU2FVTTU3b0QvTHBmS0RLQUUzeFdqSGNDMEsyWTVLcmdZZW9Kckdz?=
 =?utf-8?B?RkpQWUlPRFVUVEluenp0UTZ4ZGpzbmkrZ1NRb09lVk9qK2FUWkIrT2tTVjQv?=
 =?utf-8?B?N1dCY3MvWUdhSTFrcnFTVlhUUmxldTEwRkpBY1FoMlJMOFYyWlBuSk5oTEh6?=
 =?utf-8?B?T01BTGsyQ1duZkkxdEx3YlMrTUNyZlZha2F5bU1lTXJXdWswU3BhZVlnTkVM?=
 =?utf-8?B?TTVQNXR4Y0FzQWo0TnBWZVVybWxUcFF4SjRJWmdaaVJhTTZOeHFyY29rY2pE?=
 =?utf-8?B?bHQwbUNnUlFBQ011cVJnbjNOY0R4ZituV3VZeUZwN0NXQlBMS0hDYTRMQnhN?=
 =?utf-8?B?SHRrVlRLTUlDbG11VkdaSEZOUllVMUovNXFrMk56eEVXR0doQ0Y3VW00Ukdh?=
 =?utf-8?B?RCsvQ1hEaGFxZGpYZHNaeklpeWU1QWVHb3hRMHlvd29PUytUNFpZd1ludFk4?=
 =?utf-8?B?dUE3aVpDTWQ0ZjMzSVUrOG1FZnkzczB1ZjRBa1JWRjdEbnZhcTh6a0djV0sw?=
 =?utf-8?B?YnlrSHdEellncGQ0Tm5rWjlkUk1rZkR1azdaSENlbjMxakE2T2RPVm9ySkdO?=
 =?utf-8?B?UEE2VjgyZFQwcXBad2QzN1ppTmZlbER0aHpWVDlWeDd2TTY4Mk9KTnFYeGZY?=
 =?utf-8?B?R1JUempTM20wZ1dicGsrL2JXL3k4ejNDOHZTeHk5RmMxR1VkYVVlK1R3aUVs?=
 =?utf-8?B?YUhhYkNSRlM0bjY2V2RBQ25YUHp5NmJ0UkxuOUNYUU53Vy9iTVRNdDMreFVp?=
 =?utf-8?B?U1hHRXZmVkpEMEhjTURva3hyazAvMjRPUzJDNUpQZWdKUTJiWHdyUjZjTlhI?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <017DCB434C3EFA4AB2BC1596DCEEFC93@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11172.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5908fa20-69f3-4103-8767-08ddc07fea53
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:36:18.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MFzmf4OptR2qDoGaED+mPQhy6AuW1vYPNNxKlCSXk5wB7UW7J4MiDsST/NA0L2xo5i7ZjgEM14HHHOaEHw6zqGCh5n8Npy8jaXm+fB36iD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7862
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDIwMSBTYWx0ZWRfX1Vzu2M7N5rgD c1oEYwAhM0JolttRE6lELSUrRinczczBFtfDr96PYKt0F3YVZ0EuS2j0C7IWAk2+I6aY/BvHne+ Kor7CcnhxfFRNvUqKTkQjGmODhxiEcda1Gxk8emvc8cPhrCaorUs3jYvUC8w3DEsoPBSxhrN1UV
 vFFK+nNm9nwip1Azv4+gI9n522lXI3fUosHC2msGYq/Th3o2aUzh9WPAyjjfgCyEEhFWG6P87Hf Hg4/m6EDz+1bRD9cynn6sKpVl4qelHNFblCt51FUGiqLYzlbosiflL3BgVZcADlR7VseOaq0UTX H2tOUlx5SF9ZEbtxt7gKd48RTDqqDQq8TPZ2DKvghUBniHBru81qJw9th6qTuWZRYD9G3J3xS1j HccLGh2a
X-Proofpoint-ORIG-GUID: u2UHXoTeyw4KD1HLXIrHKpiSI-kRSjbU
X-Proofpoint-GUID: u2UHXoTeyw4KD1HLXIrHKpiSI-kRSjbU
X-Authority-Analysis: v=2.4 cv=MMVgmNZl c=1 sm=1 tr=0 ts=68711357 cx=c_pps a=oCCLDGIEOjCsJBocmZPjNA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=d08asnFF-j38aQ-J310A:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: orgsafe

QkxaUDE2MDAgU29DIGluY2x1ZGVzIGEgU3lub3BzeXMgZ2lnYWJpdCBFdGhlcm5ldCBjb250cm9s
bGVyIHdoaWNoDQppcyBzdXBwb3J0ZWQgYnkgdGhlIHVwc3RyZWFtICJzbnBzLGR3bWFjIiBkcml2
ZXIuDQpBZGQgYSBkZXZpY2UgdHJlZSBlbnRyeSB0byBlbmFibGUgdGhlIG5ldHdvcmsgY29udHJv
bGxlciB3aXRoDQppdHMgYXNzb2NpYXRlZCBpbnRlcnJ1cHRzLCBjbG9ja3MsIHJlc2V0cyBhbmQg
Y29uZmlndXJhdGlvbnMuDQoNClRoZSBCbGFpemUgQ0IyIGJvYXJkIGNvbnRhaW5zIGEgVEkgRFA4
Mzg2NyBQaHkgY29ubmVjdGluZyB0aGUNCkV0aGVybmV0IGNvbnRyb2xsZXIgdG8gYW4gUko0NSBj
b25uZWN0b3Igb24gdGhlIGJvYXJkLiBBZGQgYQ0KZGV2aWNlIHRyZWUgZW50cnkgZm9yIHRoaXMg
d2l0aCBpdHMgYXNzb2NpYXRlZCByZXNldCB2aWEgYQ0KR1BJTyBzaWduYWwgdG8gZW5hYmxlIEV0
aGVybmV0IGNvbm5lY3Rpdml0eSBvbiB0aGUgYm9hcmQuDQoNClNpZ25lZC1vZmYtYnk6IE5pa29s
YW9zIFBhc2Fsb3Vrb3MgPG5pa29sYW9zLnBhc2Fsb3Vrb3NAYmxhaXplLmNvbT4NCi0tLQ0KTmlr
b2xhb3MgUGFzYWxvdWtvcyAoMik6DQogICAgICBhcm02NC9kdHMvYmxhaXplOiBFbmFibGUgRXRo
ZXJuZXQgc3VwcG9ydCBmb3IgQkxaUDE2MDANCiAgICAgIGFybTY0L2R0cy9ibGFpemU6IEVuYWJs
ZSBFdGhlcm5ldCBvbiBDQjIgYm9hcmQNCg0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvYmxhaXplL2Js
YWl6ZS1ibHpwMTYwMC1jYjIuZHRzIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvYmxhaXplL2JsYWl6ZS1ibHpwMTYwMC5kdHNpICAgIHwgMjIgKysrKysr
KysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KLS0t
DQpiYXNlLWNvbW1pdDogZDk2Yjg4N2NjYjY2NzZmMzY2OTY4YWI2YzdkY2QzMjhlMjY0ZDMzYw0K
Y2hhbmdlLWlkOiAyMDI1MDUzMC1rZXJuZWwtdXBzdHJlYW1pbmctYWRkX25ldHdvcmtfc3VwcG9y
dC05NzkxMjQ4MDAyNjUNCg0KQmVzdCByZWdhcmRzLA0KLS0gDQpOaWtvbGFvcyBQYXNhbG91a29z
IDxuaWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQoNCg==

