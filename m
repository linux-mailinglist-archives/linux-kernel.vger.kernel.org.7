Return-Path: <linux-kernel+bounces-760599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D5B1ED89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E83F166F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97394287514;
	Fri,  8 Aug 2025 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HA/4aaM9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zCuMYXYz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7F70808
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672463; cv=fail; b=a/7CPp9mRk2Akhjsu7bDy59JEdGXLVkvvgHkWS8k2nArNSoi8kJiBq85dJUpXEuAXsNYhl1Cm4NGO/N4YHRUH2InQJIIFGeMjfBbczlQNUI6Is7J3wylHJvz50aWhtLmLiCy1JuEdspcOEUwPUJU3M7ddA3tJdOHfYREjmK5s18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672463; c=relaxed/simple;
	bh=1GfII2I6NOCKKUsT9pmDGvNbEUFsYvbNewbQH6zcLVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qJBDLY3DB4qlsov6XFKwjHeNdEdGlNFK0NdkCNbjBOhnom0bY6WWu12jg34yq0SKktLy8tvyAcR3Rlrzca+JWwf87N9W6QuN0/1A8/GHztwrZ+cfErYgK3LFHk5+wtlBMU59qBXhuRQAJ/+Ims2Z0AaKkMDqbFaO4W5pN4Kfj78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HA/4aaM9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zCuMYXYz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNSPn028710;
	Fri, 8 Aug 2025 17:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1GfII2I6NOCKKUsT9pmDGvNbEUFsYvbNewbQH6zcLVg=; b=
	HA/4aaM91RfAMQx6IhEyfDZcZTi64dH0sVRYvws0EOKELsTUtmSnh01x3X2KGYRH
	9y2aW1EEeyF2SMIXdoO+c+0U2D04w1vJzyiHW92KhFXa4LyRvf03j4LzNEqN3Zf/
	beSlmuNBz9rZCHfEM58P5van4eKla3a8OVS9eGFrmpoUbJXamBRIrnO7HpG6G5vR
	wMM8e3wLPmkLkUZMW8aJhl/WYIIxk8lXJ0j4cEEkDsDccD4/of+Lzt4wcP9al038
	vly8K/3xLJEp63RcjSUduKVGMmHGOCnaCmsZTg4Lu01XslfgRUOCaZqrk2KctJeK
	sbm2iNADHXBlEm4d9wsu/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd6tuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:00:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578G2fu4009798;
	Fri, 8 Aug 2025 17:00:30 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpyk2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 17:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNOzIE13XMnf8cd+mfG4qKTvMafv2Vjp6xc0AnB55bCqTF/M8kQDIpG+kyxfl+4AlUGUgNLZNyWZN8SFLbZHpYxP6v1PsvrHECJrT2y/Grw+IQpoG1UgN0IxA6NP8saPN/TRl0nMxApb/1hofTj8BRdNvq37BQ99CU8r1CsJCVMoIXtI3XO11SZ+qulF9I/eIuw22gMY8W8kAX4JtatokE2hwSds6NGBbUOpQAHOk9jdt8IeSlJfzJhyY48E3Y1v4wlIY2uj9tWFpDnXlRfP6ahDjUPzQVnha28WrnqMx5ECxZLpSJZ4nneqbBFEIvZHnphxCCT5hF6nHhpH9RFBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GfII2I6NOCKKUsT9pmDGvNbEUFsYvbNewbQH6zcLVg=;
 b=libWtV2vyXUdas2AKuBwtV1MpGsLfjOn1FcZQu6sDie3Ez59pC+IlAfqtc5UBB/gXL2VgqS3ppptev6cccKjFgI+vffJyYRBww0kImkBlMd+fFEK3npDgQLHkKyP108QrLem2B1I7YcJJ7YVaSlA06NuEELKeg4J5aqAjfuiMPou5U84ZZEBdqUptH0WZArx8DmoEf2sd7FOLSP5nOUR6ZgrKPYYlKGwfzmDDVTsWjeXIYzk8Oli/npCd/GP32YFS5CS9/xpHRda6iAevzjK5yOSklpGUc8qqL0ZrJFq8PEt4GS7ziL3lBkQnCTMCNntykZBxv9z4vvoO+xY3LiSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GfII2I6NOCKKUsT9pmDGvNbEUFsYvbNewbQH6zcLVg=;
 b=zCuMYXYzazibZdQxzTpA6l3bFJrwyAypno0bYn2G4HiPauYSKMZH6mcWI4cNU8rLHDjVRhP/TyoWKDOZWnJxLLN9J1Zx9la8JDhBhpW5gDarZC2K36tQaIw2Z6aqm8faM8Qw+A/kGbetDTubDdyA8ny8hEN6IS8jFYEW7WGYZA0=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 17:00:27 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:00:27 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com"
	<vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Topic: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Index: AQHb/LZRoohaxDA/AkO7zPAZBTuqUbRWKXQAgAFC14CAABKwAIABHdiAgAB1lYA=
Date: Fri, 8 Aug 2025 17:00:27 +0000
Message-ID: <4380C53B-CFF9-48CB-B209-806D4BBC6F56@oracle.com>
References: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
 <87ms8cchqf.ffs@tglx> <20250807154929.4Wpr6V4N@linutronix.de>
 <BCFBCCEA-8D24-4835-8C28-74D93F5EF38B@oracle.com>
 <20250808095927.cS9gMdhp@linutronix.de>
In-Reply-To: <20250808095927.cS9gMdhp@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|LV3PR10MB8156:EE_
x-ms-office365-filtering-correlation-id: 294cfaf3-37b1-4070-c5fb-08ddd69d1346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3ZLYXdGZ0xJWUZaU1FOQ25LNUlLYzdzZEp2bHVPQWRVV3JRWE9EREJqbk5z?=
 =?utf-8?B?WloyR0RySjlGRWtXY2wwWlluN21KQlZGOUtuM3ptdmxGSzVkWVVJN0FGRGZa?=
 =?utf-8?B?aUR0V1NJL1NWTDJQd1NsVURlNVZEd0IwcFk4MUJTRU1Xa0ZUY0Z4NjBBTTJJ?=
 =?utf-8?B?alhzaWNBZXNLMUFsM05EQW5mK0NyRzZlYTAzQXB2RXRtZkROaHkrbXpuZWZz?=
 =?utf-8?B?YzA0a2NjbTBXR0tQY0czMFdrR3JrV0J0UUR2R2xOU3Frb3dCKzJlSHdIUlJt?=
 =?utf-8?B?YzRId0JjcFlXWDczdk1Bb3J2Q3FsUXQvRUpyR2pacSs0Zm5UenR4eFFnNUZE?=
 =?utf-8?B?alpNTVhOUldIeFd1Q3lFYzBpcFJoOVRSa3JuSldwcElJUUFtUUxCR05mcUpj?=
 =?utf-8?B?d045YTVxRkZpSUZvSUdYQTRUNHFGMVQvN3lPdU1rOEVQQ0trQW1mdk4rbHNE?=
 =?utf-8?B?S3pMcDkzeThtYWFKd1poRnYyME84NDFUVG5YWUppcmNHbFdQWWRzUlZwYjRR?=
 =?utf-8?B?YTJ1WE8vMUVBSnVSSXJnODlyT3BxSlVkTDltMDhsWENGNFc5MUpxdHQyOWN6?=
 =?utf-8?B?Q2k4em5VQ2RQa3VoZFVPY0YyUi9rZDBaV0xRQUg1MkFXNjRiRDI3OU1jSUUy?=
 =?utf-8?B?VmhOQmlrNVk1R3h3NHV4M0IrK3dsQWt5UEtGd0FCeXFUQU81bDBrVHd2NjRh?=
 =?utf-8?B?WTNzRTlwZ2lNSEo3NGZqNG9vL2pyL1NKNlpib2JjWXgzWi8zVXVxc0M5ek5x?=
 =?utf-8?B?b1VtczE4V3pWVTRVT0l2aTNoMnhxbmNEUzJ4S3FIT2h2R0JqcWR0Z2wwMFRm?=
 =?utf-8?B?YmtyNFp0WGtsc1JnYURwMDZqN3FrYnpGa0FxT3l2YXczVEdmM29KTEViQUNM?=
 =?utf-8?B?Nko0Vi9hMVpWMVVkZXpTUm1HeENqakxwSGZ3dkVKeEtVTmxNNStQbFFzOTZY?=
 =?utf-8?B?Z3FWRU5zcjY4VFNFVkI2dklTUGdrem5ZSzM2MU5qVVhnRFBjb2RTakZFVWE5?=
 =?utf-8?B?Wmp1VHdFR25va00zb01Ic0ZKaDJldmtiS09FdS8vTlBiRi9HRjlxQUVZOVRs?=
 =?utf-8?B?NllwNE9TTHZOVytqeks1QVJEL3pPdUJjZGpWMGZ6MzAyQVZid2hlWThvR0VQ?=
 =?utf-8?B?aW91N0IwU0lkRWVkT3c4ZW9OL2ZRQmZ3azlvbjZXdGRCc1pQRDJQUUsyelJk?=
 =?utf-8?B?UkRBRkUrUWJBRVdpVmR4cVNNMVR1ei8rQnl6SlROdVJ2WnIyUlFNVW5Ta1lj?=
 =?utf-8?B?MjBlNjNTbXpXODU2cnRJeHoxaVhLang2aS8zZTd5SUVPdk9SYXJYc3pGTWRU?=
 =?utf-8?B?MXF5YlgwQUtHSUpYODcrRDNkMzFsc0xBOGs2bnJpZ3Jlb09tYjE4NWxuVTRt?=
 =?utf-8?B?WWU3VHd1a3NsYUQ0alVzT3AxNmsrZVNYTTVlSUtHYXFpbEdpWWYvai8wY3BR?=
 =?utf-8?B?MWt1a3pLTGZ3UlZVdEdTdnpVYUZycEtTUVFGVFdGNXgrTEhWRTd6aDFVdkwv?=
 =?utf-8?B?Yi9mS2NodGNrQmZ2MmhDQkFDY1hxaTBrS1lhWk1takxjbG52MmdMZGpldGow?=
 =?utf-8?B?eDc4L0x5YmZjUlpxb0NBOHFiVk1ocG12WVNGVGkraXEvVmlLRXRJVjVEZTJr?=
 =?utf-8?B?TVgvQ3JnV0xDSGVkM1Y4TXJQQlRreVFpeERVd3JaR0NrYUFZVDEvZmx3aFhl?=
 =?utf-8?B?TndvM0J3Smg2SWZCZVpCNkkwSGdFVTFwSFpqcEFKUmlSRXZGY1NUdGdsQmFX?=
 =?utf-8?B?azJjc2NiTGNqUStVMEJSVkxpZGhFTkZ6bDYxL1JZZElndXdTam5GZjRRZHR2?=
 =?utf-8?B?aloxTkYrTFZqNnl6akJRVnJJdnRtTUN4TkRjeGI0NllkNWhEMituUllnVTk0?=
 =?utf-8?B?VGNBK2ZWNE5ML2I4M1F2azJNNUxxbU5CUWhjRUtnR0dQN2dqbU9QWVpnSEJ4?=
 =?utf-8?B?RXVQNjdwL01oQkQ3V3RpV1NKOU90bGsxTHNTSmlKTnVyUmYzU0xNSWxJNjc2?=
 =?utf-8?B?RVJOQThEbitBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NG81c25QUDAyRkVOM2hwQ25oa0xqWHJLRUhSc1RFM1NLeHdleWhWaDBneEFP?=
 =?utf-8?B?ZXUxcWxvTndIaGhFSnVUNHJOdjFYeFVkeWxpbVVnNEpEaWE0SHhuOFRvSkI1?=
 =?utf-8?B?YzB2MldrYXJlaU1nMDRmaWlOUlBJUDlTcytFOTVVa1B2b1JhZCtSTzhUZnR6?=
 =?utf-8?B?T2xKNEd1NGw5MnRoZDYzZ2hhT25GQXViREl2MVRuVU1lNCtJdk9KWU4yL2xD?=
 =?utf-8?B?T0MyR2FrekdCNzllRm9iSVBZU2lrTWNCcXEzM2ErVXZlbUZaWHVaTVlpSVFI?=
 =?utf-8?B?RUN6blU4aVRrVzBqY0kzelc1U3VxdmRyL0tuS0x0Mjk5ZGN0bWtaZ1R1RVJ0?=
 =?utf-8?B?SEVHNHhSOUJCWFRkZGN3VjFhOHphbEZFZ1RaUW91ZjhqQnFpaFRldENmQW9k?=
 =?utf-8?B?YjdGNURoa1p1WE1md0xyWFpzcktvVjMyRjV0SHdsRDBzZ0FvN1dpNEY1enh4?=
 =?utf-8?B?UzFnSGQ2V1lPMm5RU1EwRnNXaEd2ZkUrdHdCVVZQdUM5Vnl4UWhHYzNvY2lz?=
 =?utf-8?B?dVdGZjJzTmZucGh3YXJ0M2MvNGRzSFhhWGJZSGxpYUpVc2V3NDVNTGlnc3Fr?=
 =?utf-8?B?d21wbEdySFdQNUNMSkRsL21NekdMVjhKZVREdWgxY3oySUF2M0p4eHZ5TDNl?=
 =?utf-8?B?NW9hbnFCaDlaK0pleHg1MkxFTDFIeHhQbzVUUWpuWGcxWmlUWlRhTCtVdkZP?=
 =?utf-8?B?enpwWWoreDBFN04wdHNGTlR0MEJ4UGtPaUpOOFY1SitTUTVvbm56MWlrQ1A4?=
 =?utf-8?B?eUduL3BrU1dFdUlNSW5qbkJscTNOU2VMLzNSMzlSaEZsN21qRm8zc2VJOTVx?=
 =?utf-8?B?cEtKdDJoT3VxVTMzN3Zja1IxaHJ0MG5CVE1XbW1XbE9UdVg4dkQ3bVdaOHJX?=
 =?utf-8?B?SUlaV2xQeE9MUHdXeWZGVUp5WWNuc3NuaWdLMVMrWUV6bTFUSVVoT2VrZFNo?=
 =?utf-8?B?NFBVSzNFUTJoa3BFeVMyMzd2d0JXZ3FXNE5kczM3T1lpM0RMcURIQ2ZLZWtw?=
 =?utf-8?B?VDB4Z2lweDZLM3VJaWVESVNmUThoNEhjY1BvVlZyRGNzc1ZBS3hiRjlBUTVq?=
 =?utf-8?B?eHlGdXR4a0tPOXdWQzduajlBSHpMejFQMEQzclIyZzBSSGZkWU9XMkpCL1Vk?=
 =?utf-8?B?RFJEbXFEaStiUzN4RHE2eHJmTzdvbXhScElHSTBQSmdyQ1JIdVVOTE5uQys1?=
 =?utf-8?B?NkZwck1PRCt0bTZlSzV4dldqMTlDVVpTbW10bVZLazVWdHA5ZkVZaFkwTlF0?=
 =?utf-8?B?L296LzA5YS9veTZ5NDBRRFlwNFJLL3RsWlJkd1VtSTczbkQvZURvT1R1SFNq?=
 =?utf-8?B?VTlRK2FPRHJJa3dvbHJQa0E5aDd4dUFkYXV3eVUrU3ZZYTl3WEVFMmtxSXdi?=
 =?utf-8?B?b0NvWVRhd3U5Rk1lV0FmanBubVpkdjRDQVRvNWg3eTRvTkw0NUdvNXRTd1M1?=
 =?utf-8?B?VkZ2UDc3aEZzSzZsVFQ1TWFYSzJtODBxbTM2dG5PYmZVakZ3RXJGMHFxWXNM?=
 =?utf-8?B?ZTdoc1JGam5WQ1pGSlkzTDNnVXd4MUU2WlR2ZXl0QmRRY3dmeUZSUXdMbmxz?=
 =?utf-8?B?QmJSV29nS0hxK0Z5aXBBOFlxME5TQ2xDMFdDRjJHODlKTlgwS0R4K3pYcmRN?=
 =?utf-8?B?VGl6QzJFRmNwZUFlemJRS21WaXBadWx1enpxOUZmZVVoZlZTd1RNaFZIN3Bq?=
 =?utf-8?B?aEtYK2o3bndBUG5zcEpFMDBvQ0U3VzdSdHk2YkloT2ZrL1Z0dmpCaVB5bldG?=
 =?utf-8?B?YUNuZWlHUW1Kckdhd2ZPMmNtYzcxcFZudjUvcDJQcEVGS1RVdVJVQlFTVHYz?=
 =?utf-8?B?NzRQdVhURGV4aTdhbC9vL2Q1bTNjbmllV0QxaEppQ3RoSXh6dGNsVmlqZzBM?=
 =?utf-8?B?V2JjQTNHYzVHaDc3eFk2eFhwTlpMSko0S2xhT1hMaDR1NmZYbDBtdC9qNjJ2?=
 =?utf-8?B?NnZ6QW41WFJYOElORmoweWFnbEJkV3pSNTVLaWRVZVcrcXdpeWJsc0QvRjVO?=
 =?utf-8?B?NkpzUzdPSGVsMk9hYXowYURMV2VZQ2NiRC8wWDN0Tms0TGpJa0ZKU2FKSitD?=
 =?utf-8?B?R0VBcHgzb1ZZTjc4WTg4azFFTmFoa0gwZFBqMHhxbjFBQm5HUGw4U3JlWjRP?=
 =?utf-8?B?VXUya2V0bjdUcWV4N243dUVIMnQxaHJQN21qSjBXUmRTQVVjNDJZYVVua0JG?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F26C3EDA62D3CF48AC9885F3E5F23100@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j/npGvPo9jf12bHWLYDbbLRGQdZwJVPmyqiWLrONdNHbo+AwIUJ9van8wDK5Q4lB+vWEyEukod0bSyvw/JvcTpPFrCW79EyUIQjhdbn+4pO2SJi6XQ4M0X4/03KZKXZ3dp3a3nS7bEhJDDDlCmHXiQQYuDqqRx3rUgWC24HvYcyqGMjuJXG42Qz34o9MBmmLI5JTnoVVqr2NNypMW4DihRIrdWYWX5QngCPjxoBnDYkI8FqVM1sXLMl5YS2rvLAGI0CK4AmrVbhJ+6hT6VYRbbigaCJvqHdhyKs+KEl83C9w99kYvqSL7xGNM84/66nUFpgzPMb8HrNSlJu7YRYlPtAMv0cS8WVvZWlxPSbJ4nIZy2u9tfGLWMlA0A796BQRjxzBLOHdmMjRc9yMG2ONet0tGygudhQR8teozpFHGm/s8g8cgEXpbtGjvjsLCd9Pge2Y+8AOOQJ3LbavO/MD1oElb6QBlUIF28TpDioAxTlotEIS4aBGr13QpzjbNz/oR5xXV/jMjVmHeB8AeCS1eZU3kX2U9BLCMfCvEte17dCaQ2dI9eiMeh3t2YGGIM7du8a4gcGyWHPHcVPj5Bi2YYb1hudxl51llgpM5SGeOwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294cfaf3-37b1-4070-c5fb-08ddd69d1346
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 17:00:27.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZEZBUHCaXR/fL/Z8RTs6XVdmGyAvUimWIinFVKmoYtjsPkRDv5J/LtJcU3eH2SikJhHpRz61uaehKFWb/1voHKJT1azndUdFVvC3eo7IcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080138
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68962d2f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=oAKbGvDZCqTSNkm2c5gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x0PSTGAV3xAuWMtj2k3fHynmntfjbzJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEzOCBTYWx0ZWRfX2Tg8ZlfFoUBm
 kITSlm4s8TF1LsZFDEINYCNN46PJygi3/JYCE7utOdpX03fwUKw5lOFMqj8hN0ILtlkBlY6Z+VJ
 +TiG/QRI7vSCb/xRxjMoe8XsX2NeeIuIHAz8sc4Ei7NRj+dRd5P0VSRbTtYF+pEYrtiKHkCy1Qh
 +k7Ymg08u4dYn4YVHXibwTXFTr1b4YEsXu5wDGmZjilq9o6a1dMKjjM4Y2RG+gbkFoCJcKbMVQ/
 j3q+laAl65LzofQWxRKu83w6gfhtuMQg6zZG6Ct1TQEatxcwYnM4/qvxbVk8mqcoG9+V7d7N7m+
 QGLokqzwvSFzXQ/Pb6n7m8f+zJYexAnTFAuxNBjDcUD95XkU6jAqfD2bMGED/6I1QIEIxwhr4tT
 /Rd2kHHqRdglugtQ/+EBIRv75ovfTKTrOkSYBedITHb2/PCzokxJKuFVMGik5sClF4pNoY+e
X-Proofpoint-GUID: x0PSTGAV3xAuWMtj2k3fHynmntfjbzJp

DQoNCj4gT24gQXVnIDgsIDIwMjUsIGF0IDI6NTnigK9BTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIDIwMjUtMDgtMDcg
MTY6NTY6MzMgWyswMDAwXSwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+Pj4+ICsgaWYgKF9f
cnNlcV9kZWxheV9yZXNjaGVkKCkpIHsNCj4+Pj4+ICsgY2xlYXJfdHNrX25lZWRfcmVzY2hlZChj
dXJyZW50KTsNCj4+Pj4gDQo+Pj4+IFdoeSBoYXMgdGhpcyB0byBiZSBpbmxpbmUgYW5kIGlzIG5v
dCBkb25lIGluIF9fcnNlcV9kZWxheV9yZXNjaGVkKCk/DQo+Pj4gDQo+Pj4gQSBTQ0hFRF9PVEhF
UiB3YWtlIHVwIHNldHMgX1RJRl9ORUVEX1JFU0NIRURfTEFaWSBzbw0KPj4+IGNsZWFyX3Rza19u
ZWVkX3Jlc2NoZWQoKSB3aWxsIHJldm9rZSB0aGlzIGdyYW50aW5nIGFuIGV4dGVuc2lvbi4NCj4+
PiANCj4+PiBUaGUgUlQvREwgd2FrZSB1cCB3aWxsIHNldCBfVElGX05FRURfUkVTQ0hFRCBhbmQN
Cj4+PiBjbGVhcl90c2tfbmVlZF9yZXNjaGVkKCkgd2lsbCBhbHNvIGNsZWFyIGl0LiBIb3dldmVy
IHRoaXMgb25lDQo+Pj4gYWRkaXRpb25hbGx5IHNldHMgc2V0X3ByZWVtcHRfbmVlZF9yZXNjaGVk
KCkgc28gdGhlIG5leHQgcHJlZW1wdA0KPj4+IGRpc2FibGUvIGVuYWJsZSBjb21ibyB3aWxsIGxl
YWQgdG8gYSBzY2hlZHVsaW5nIGV2ZW50LiBBIHJlbW90ZSB3YWtldXANCj4+PiB3aWxsIHRyaWdn
ZXIgYW4gSVBJIChzY2hlZHVsZXJfaXBpKCkpIHdoaWNoIGFsc28gZG9lcw0KPj4+IHNldF9wcmVl
bXB0X25lZWRfcmVzY2hlZCgpLg0KPj4+IA0KPj4+IElmIEkgdW5kZXJzdGFuZCB0aGlzIGNvcnJl
Y3QgdGhlbiBhIFJUL0RMIHdha2UgdXAgd2hpbGUgdGhlIHRhc2sgaXMgaW4NCj4+PiBrZXJuZWwt
bW9kZSBzaG91bGQgbGVhZCB0byBhIHNjaGVkdWxpbmcgZXZlbnQgYXNzdW1pbmcgd2UgcGFzcyBh
DQo+Pj4gc3BpbmxvY2tfdCAoaWdub3JpbmcgdGhlIGlycSBhcmd1bWVudCkuDQo+Pj4gU2hvdWxk
IHRoZSB0YXNrIGJlIGluIHVzZXItbW9kZSB0aGVuIHdlIHJldHVybiB0byB1c2VyIG1vZGUgd2l0
aCB0aGUgVElGDQo+Pj4gZmxhZyBjbGVhcmVkIGFuZCB0aGUgTkVFRC1SRVNDSEVEIGZsYWcgZm9s
ZGVkIGludG8gdGhlIHByZWVtcHRpb24NCj4+PiBjb3VudGVyLg0KPj4+IA0KPj4+IEkgYW0gb25j
ZSBhZ2FpbiBhc2tpbmcgdG8gbGltaXQgdGhpcyB0byBfVElGX05FRURfUkVTQ0hFRF9MQVpZLg0K
Pj4gDQo+PiBXb3VsZCB0aGUgcHJvcG9zYWwocGF0Y2hlcyA3LTExKSB0byBoYXZlIGFuIEFQSS9N
ZWNoYW5pc20sIGFzIFRob21hcyBzdWdnZXN0ZWQsDQo+PiBmb3IgUlQgdGhyZWFkcyB0byBpbmRp
Y2F0ZSBub3QgdG8gYmUgZGVsYXllZCBhZGRyZXNzIHRoZSBjb25jZXJuPy4gIA0KPj4gQWxzbyB0
aGVyZSBpcyB0aGUgcHJvcG9zYWwgdG8gaGF2ZSBhIGtlcm5lbCBwYXJhbWV0ZXIgdG8gZGlzYWJs
ZSBkZWxheWluZyANCj4+IFJUIHRocmVhZHMgaW4gZ2VuZXJhbCwgd2hlbiBncmFudGluZyBleHRy
YSB0aW1lIHRvIHRoZSBydW5uaW5nIHRhc2suDQo+IA0KPiBXaGlsZSBJIGFwcHJlY2lhdGUgdGhl
IGVmZm9ydCBJIGRvbid0IHNlZSB0aGUgbmVlZCBmb3IgdGhpcw0KPiBmdW5jdGlvbmFsaXR5IGF0
bS4gSSB3b3VsZCBzYXkganVzdCBnZXQgdGhlIGJhc2ljIGluZnJhc3RydWN0dXJlDQo+IGZvY3Vz
aW5nIG9uIExBWlkgcHJlZW1wdCBhbmQgaWdub3JlIHRoZSB3YWtlcyBmb3IgdGFza3Mgd2l0aCBl
bGV2YXRlZA0KPiBwcmlvcml0eS4gSWYgdGhpcyB3b3JrcyByZWxpYWJseSBhbmQgcGVvcGxlIGlu
ZGVlZCBhc2sgZm9yIGRlbGF5ZWQNCj4gd2FrZXMgZm9yIFJUIHRocmVhZHMgdGhlbiB0aGlzIGNh
biBiZSBhZGRlZCBhc3N1bWluZyB5b3UgaGF2ZSBlbm91Z2gNCj4gZmxleGliaWxpdHkgaW4gdGhl
IEFQSSB0byBhbGxvdyBpdC4gVGhlbiB5b3Ugd291bGQgYWxzbyBoYXZlIGEgdXNlLWNhc2UNCj4g
b24gaG93IHRvIGltcGxlbWVudCBpdC4NCj4gDQo+IExvb2tpbmcgYXQgMDcvMTEsIHlvdSBzZXQg
YSB0YXNrX3NjaGVkOjpzY2hlZF9ub2RlbGF5IGlmIHRoaXMgaXMNCj4gcmVxdWVzdGVkLiBJbiAw
OS8xMSB5b3Ugc2V0IFRJRl9ORUVEX1JFU0NIRURfTk9ERUxBWSBpZiB0aGF0IGZsYWcgaXMNCj4g
c2V0LiBJbiAwOC8xMSB5b3UgdXNlIHRoYXQgZmxhZyBhZGRpdGlvbmFsbHkgZm9yIHdha2UgdXBz
IGFuZCBwcm9wYWdhdGUNCj4gaXQgZm9yIHRoZSBhcmNoaXRlY3R1cmUuIFB1aC4NCj4gSWYgYSB0
YXNrIG5lZWRzIHRvIHNldCB0aGlzIGZsYWcgZmlyc3QgaW4gb3JkZXIgdG8gYmUgZXhjbHVkZWQg
ZnJvbSB0aGUNCj4gZGVsYXllZCB3YWtlIHVwcyB0aGVuIEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGNh
biB3b3JrIGZvciBrZXJuZWwgdGhyZWFkcw0KPiBzdWNoIGFzIHRoZSB0aHJlYWRlZCBpbnRlcnJ1
cHRzIG9yIGEgdXNlciB0aHJlYWQgd2hpY2ggaXMgUEktYm9vc3RlZCBhbmQNCj4gaW5oZXJpdHMg
dGhlIFJUIHByaW9yaXR5Lg0KPiANCj4gT24gdGhlIG90aGVyIGhhbmQgbGV0cyBhc3N1bWUgeW91
IGNoZWNrIGFuZCBjbGVhciBvbmx5DQo+IFRJRl9ORUVEX1JFU0NIRURfTEFaWS4gTGV0cyBzYXkg
cGVvcGxlIGFzayB0byBleHRlbmQgdGhlIGRlbGF5ZWQgd2FrZXMNCj4gdG8gY2VydGFpbiB1c2Vy
bGFuZCBSVCB0aHJlYWRzLiBUaGVuIHlvdSBjb3VsZCBhZGQgYSBwcmN0bCgpIHRvIHR1cm4NCj4g
VElGX05FRURfUkVTQ0hFRCBpbnRvIFRJRl9ORUVEX1JFU0NIRURfTEFaWSBmb3IgdGhlICJtYXJr
ZWQiIHRocmVhZHMuDQo+IFNheWluZyBJIGRvbid0IG1pbmQgaWYgdGhpcyBwYXJ0aWN1bGFyIHRo
cmVhZCBnZXRzIGRlbGF5ZWQuDQo+IElmIHRoaXMgaXMgbmVlZGVkIGZvciBhbGwgdGhyZWFkcyBp
biBzeXN0ZW0geW91IGNvdWxkIGRvIGEgc3lzdGVtIHdpZGUNCj4gc3lzY3RsIGFuZCBzbyBvbi4N
Cj4gWW91IHdvdWxkIGdldCBhbGwgdGhpcyB3aXRob3V0IGFub3RoZXIgVElGIGJpdCBhbmQgdHJh
Y2luZyB3b3VsZCBrZWVwDQo+IHNob3dpbmcgcmVsaWFibHkgYSBOIG9yIEwgZmxhZy4NCg0KT2ss
IFdpbGwgIGRyb3AgdGhlc2UgcGF0Y2hlcyBuZXh0IHJvdW5kLg0KDQpTaG91bGQgd2UganVzdCBj
b25zaWRlciBhZGRpbmcgYSBzeXNjdGwgdG8gdG8gY2hvb3NlIGlmIHdlIHdhbnQgdG8gZGVsYXkg
aWYgDQpUSUZfTkVFRF9SRVNDSEVEIElzIHNldD8NCg0KLVByYWthc2gNCg0KDQoNCg0KDQo+IA0K
Pj4gVGhhbmtzLA0KPj4gLVByYWthc2gNCj4+IA0KPiBTZWJhc3RpYW4NCg0K

