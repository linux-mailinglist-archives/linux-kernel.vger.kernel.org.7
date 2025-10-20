Return-Path: <linux-kernel+bounces-861771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D282BF3A30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FAB54188C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C92EC0AD;
	Mon, 20 Oct 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fy5Lkqt8";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Q1Yz1QII"
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53122E6CBE;
	Mon, 20 Oct 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994203; cv=fail; b=mBqnhx/bbhwrHF/Rav0kFQR1x1xGMI4IEFZlecjDY9iJwBlokkPsuAZ3c41Kl428mKzhscEE0Nzghnc805evtCexjy75RZi7QZdqBlG9GDl+R02BuRPqTY8LoBjSP2axtbSkdSaYV/OXWvUqh9lx5UZ6vVRWVcUFYumHbCrfoEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994203; c=relaxed/simple;
	bh=3Tq32k1XrCcbVswn3vmMh6TO1ahCB3MRgQG/x/pKLzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKjRfKA3PNYDPvaSCJT3C+6a8WkIf1NEZcm/H6o5yfei9IaoF0u9rCe19IdLlkL+4ZbCHs7eQMXIQwQAWk5G3ZI+VpvDuZiAUd4D2hda/GTJcxp0TCd4dcpBapGfjE5qDKyvSQqUrcEjdPnhiz/EAdKkW18/qRjKBQj5QG40Pt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=fy5Lkqt8; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Q1Yz1QII; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KDBUip1534669;
	Mon, 20 Oct 2025 14:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=3Tq32k1XrCcbVswn3vmMh6TO1ahCB3MRgQG/x/pKL
	zQ=; b=fy5Lkqt84RK+pymhzc8IpcWELPsMDZ87jzPNfwVuFt5r6lZ9k/1WczRqz
	GN2pQID1MPMi/eO4TUddmEENZeSfXNUI3rHeKKQYoxFuYvRpVFiRV5geiAUZnUUf
	ukY84Ir8VmqYARjQlFgH8C/uHmquUoAqBk86SjYoAHfnRyLcLvGqf0U94Xjss4Qv
	cqR4hi6fnhdXmDbRoCVCZK7cH/wJOe/Bjo9u1vi63vZelrElUdqPFkJt5c4/yH86
	+dqKzorTTE+csa0ferJR2ik3G4cIO6wSPCb8N8Oqe3Z75mjc3k9emaRk+31A0vuj
	hLBjfyVXtV8Ko3hwaryTHcR2K8z0w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020119.outbound.protection.outlook.com [52.101.193.119])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49v90gc390-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 14:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSw5oB5roiDEzQhWD4oHsGYyIWd7NZj6rwpOhNB2jM02/Bx4skGF7O6wZpxkNotorwI/Ywyi6lIdJMO2LAIUogw8qKaTy/Yh2mGyvid4HNDHcOO5kYxikMNJm/IMH3cKq5+BVNeEy6M+bQAMvZ/gfmnIYaXq3CF4Xr9eq64GZ8yJeilD6W+RbQnj4Au1+5vFVo6FhmgBDJZiyqdxVbBL0/cvvTg+nfXRLKB8we1yPY8U2YttDAiYVwVLwWZDKMvUoGTmpTzfJ/zaCt5nCAeGBl50F2wsuGmMk6O2LYjJ1ZWaPdeDut2muZKb+/FaLvh+kZxWanzLIgoLIGfR2y3kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tq32k1XrCcbVswn3vmMh6TO1ahCB3MRgQG/x/pKLzQ=;
 b=qtj3UzeNOsvdU3Jj91GHVoUqQ7E9NrnMkPa333r7tCoX1jyFO+t4BxEsJ40toLSBbRYBVX7sMQFW6GHDcsyRUsEdVxUCpR0BCgY5yLka1OnZ8G1vsYBNfOjhyhX7SedU/x5PRhDlEeIMtkvpBQNCgy+eN4v54lLBf+ZBh7I5fbKLJHcj70ll5d6mTdppfIeceY+2htaFzwn9o72jlgusrDIiQDODACfAG8J7oTGy7hZ0g2s0ZiktjBrbGqPYp9Hl9qvywup9AATlIVnH/ySC7zfH7vyl3kiB2tnsm0qbLNym8kt1UfnPIvZHnSV61F8TBNf73levL1EeL5jwExkayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tq32k1XrCcbVswn3vmMh6TO1ahCB3MRgQG/x/pKLzQ=;
 b=Q1Yz1QIIPDBqANbKwVGB/VMq1BTyYvJ1KB89m7yRT5ChfJj/DJwkf5z3yk651CsBoG/WxnQEubkpYlrWRSt0XIehn5Ge7qMO1FdzWu35U+mRy6uBPAF1KC2CRM2Ax5d1ZfIZGdAD60N4hj3IlW2SQFqX28q3pdi5BvXF7olOfQhAWLbBC1J1/0STsplO9r009PoUo/0nCWyNsn+mMOSi0zGBCg8Lm6VNez9Jr07ZgJYRMPqGQgM1pSuC20jSf1HpsFX8b/oo2I/ikt80hNmRESG5p5s0xzOTSZnyRf0tg7AQ196uUP5JNZ2GS1EcVnlmdx932u24PTzpINj0SmnCxQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH3PR02MB9209.namprd02.prod.outlook.com
 (2603:10b6:610:150::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 21:02:50 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:02:50 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman
	<jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre
 Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index: AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgCAAAzWAIAABjQA
Date: Mon, 20 Oct 2025 21:02:50 +0000
Message-ID: <D409ECAE-049E-4DE7-9B1B-D639BC344F37@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
In-Reply-To: <20251020204026.a7xuhnagsqo4otpx@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CH3PR02MB9209:EE_
x-ms-office365-filtering-correlation-id: c9dfaa81-3640-4672-d628-08de101c0790
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Skdwb21XaWVoYXAvRmpVWTNTWU5GM2RJekgzaWZKQVAwYjhlVXNOUHlyQkdh?=
 =?utf-8?B?Z0RLKzlZZ1RKVU1HK21EMjZoOHJjZGNMaHBXV1Y3VFIyS0xobXI5cUVKdDlV?=
 =?utf-8?B?c1R1MFZvR3RJd09WSTRQYm10M1g0eXNZN1FESUYzKzEyNXRSRFdud3E2MDli?=
 =?utf-8?B?STltUWt3VVVMQ2prSDZ2TUhiLzkrYjJwK2MxRnpONHlEVWY0ak9Nd2JVcVYz?=
 =?utf-8?B?SFR5MHZvZzdiUCtRRHJWNUxsVUJGL1NPNjVtSVZ2ODNMVWZ5WFpLVWQ5bjkv?=
 =?utf-8?B?K1piUXQ3UHZjYzU4eEE3Z0UvWmVvcHlhT01uL2JCNDRVQk1ZTG4wSUk2Q3Ey?=
 =?utf-8?B?ckMwdTZGeXI3NGJJazlpTm5rU2lKakVuNGhVRlJ0Z1ZZZnl4ZVI2eDZzTmFU?=
 =?utf-8?B?ekF6NENtblBBajhiYXkrTnh6MW5Zc2RBaTMyLzZjRmltUGtOZFp1WS8vUG1o?=
 =?utf-8?B?KzBZa1MrblBrRnFXUkUrN2c4Tlh6YkU2eVJ4emlPYzZRK2lRTlNLUkpqUFFU?=
 =?utf-8?B?TldLaWdrYVJwRzRLS3A5UXFQc2VvQnhsTXNyVFJodFRQVCt2NkxNNlFlR3E1?=
 =?utf-8?B?TDA5ZVZsRmVBYTRGRk03M3FCRVRWc1VNRWFGeFRZMGZyL3IxbUxUTzRsVk1T?=
 =?utf-8?B?eGlxTEUrTUlzMjZyQzdPbmFKYjZRZWphZHF1cHdFZm03MS9tWFJ3LytCOHla?=
 =?utf-8?B?WUdnMFFtckZ1NlRzamthWmlDa1oxSDhYcldDWHBOYWFWMFNyQnI1UWpYclVi?=
 =?utf-8?B?K1ZjSEp0bkY1ZWdjeUtOU1dSanFRait6eEFPMEowOVllTDZIZHFMSGFTWDdy?=
 =?utf-8?B?V3VJc3NiT01wOHBtWng1S3dqYitnci9Ddi9UZis2aVRPdzhOVlRlVkVYcTdy?=
 =?utf-8?B?TWtaQjJWYVZiM0duQTV1cXUzMWNxZjZCRnJZUnRDbUNLeUlvYzdIT3dXZzZi?=
 =?utf-8?B?a2o3cXRKTmNOWWNaRk1mcTZ3K3dBMnZwaU1POGU0TUVocGxQb1oxaXRLdXJJ?=
 =?utf-8?B?cERvU0VmcG1PUFU5U0ZTVGNVUXFXK05Gc0FieE42VVBMUWVNU1hiWUozeFJB?=
 =?utf-8?B?RVY3Zkw1YXBRdTVsVGRWZkJyRHIrQ1UrVjcydjcyV2grNWJkUzFiU2JtelNa?=
 =?utf-8?B?ZlVBRCs2QjdWU2RNSXB3UmlYWTNBeE03SkIyVkdUdWRNaW5hYXRaK095T2Uv?=
 =?utf-8?B?M1RQNDNaTm14bXovRkFDLzlweGVnQlZ3VmtMcFRJN093SlJCSGZTblQyNEJ3?=
 =?utf-8?B?a1N1ZW1FMytjY0tESHZ4UkZZVHQxbEFPU0lBOWlvQzNRN09WcVFPZmhabEdG?=
 =?utf-8?B?ZlVOa3AwYzZkSHdYMzFuQ3M4amljMjlqUzJRQzFmVEQybVlnOURST2UzNUcr?=
 =?utf-8?B?K1ZZUkU0bkplWmZKMjVESFh1S0FGb3lYSk9TVjVScDJWdXVhUkdNQlorczZK?=
 =?utf-8?B?T0dGYVZVaGloU2p5TFlmRnpNWVhDZHZSUFJmUlpiY2hhNEUzVmNiZTBDK3FD?=
 =?utf-8?B?WVQrSVJUeHJQSlJIK1FTT3RjVkdJc0dCVzg4dngrRWdiZzlMbDJab3djWE5w?=
 =?utf-8?B?bEhOOVdKZVV1bGNEajhTcWlYNlVJRzhid2tZaC9lNVB0R3lWODhISVV3UEVZ?=
 =?utf-8?B?bkprVzFSOXhMWkk5cTNJWEMwTE9IMEs4Vyt0TW1haS9uUGJEQkVFdHRxc1Vu?=
 =?utf-8?B?UGlkN0RtclRxejlYL1FLODR3eW1HZkQ4UEV5eEcyVXg5VWhuVmNNZ1A2eCtp?=
 =?utf-8?B?Tm9Pb3JZOXNOOVJSeFJJRmk1aXJsa3p6NGpDc1JxNUhweVNmV1QxN3VDWERo?=
 =?utf-8?B?Q0YrdjE1dkdzVjFIUE5QRVg4YzB6WHBJMExVZ0Vndy9RaytDamdKU01PSEJw?=
 =?utf-8?B?YThWUXlJZGtETlp0NTVqMmNMY2JVdXVxY2txNXgyN3dCaHgrQlo1NlBONTRL?=
 =?utf-8?B?eUxSQVdVVTQ5eUhFMUJxRWJ3N2JJMVdVcElhREQyNXZxMS9MREl5QXVXaEk5?=
 =?utf-8?B?ZDI2eEdnT1ZraXkxQ0xIVFB6eW54M1ZWT1FXOEUyQjZTWDdCb3p4bWpQREVB?=
 =?utf-8?Q?zg8tyW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhZTGI2cFdacTVPbHpTb0liazgyNFowV2w0eFRVQVJhWmVhQXdlaE40dUFM?=
 =?utf-8?B?ZmRjM2RpMTNiNzc4b0tLeFNma3JpWGI2S0o5NUpyQm10RlNNRnptb3NzL1ZH?=
 =?utf-8?B?WTBjd2V4emZVRVZaSnpjNjlHNCtRckNLbVNEOUFkZWg4dmxFUHpOcnYreGc1?=
 =?utf-8?B?NGpmY0Y4dEFmOXcyUkZIdlJZTDdZS2Y1RDcwajkvNS96QldTOU03a1RucGVG?=
 =?utf-8?B?cjl2cnZSRGsrMW0ybzNIVXcyL3JiUHdOdktLT3BvZDA5RjRjai93MDdFelkr?=
 =?utf-8?B?UEd5QllwNzVONzk1QTYxQ1R6Vmo1elAyWVMyVER0YTAvWDNUbS8xVTNIQWxR?=
 =?utf-8?B?cUFNcEk5dHduZXd4azNOcVNvYlhJSExXRHU0SE1qaU5pdnRsMjZHeE5udE0z?=
 =?utf-8?B?c0JRNVp2VkxtYU9RS3ZiV1I1MDVadTJrQzVxZ2F6a1Z1MjFTNHdGRU52cWxW?=
 =?utf-8?B?eUsxZ0FOOWJBaitYR2pGTmxSSHJpNEVOdFBTLzlsSHhwWDllMXQ0V0UwVVNn?=
 =?utf-8?B?OCtvTXgwQ09TUC95emlRbTdxN1F5di9hQkhOcit4MkhFVXhaZkQ3ZDNGNlA5?=
 =?utf-8?B?clU5YXczQXJCYVB6MXZaMHFHOW8wdFUwZlNkT0xvOGdPWk9mMGNIcG9uUFBl?=
 =?utf-8?B?Y2s3WndwcUlBaFZpdHRLVWUxKzRhcHl0amkvNVhNMGI4eXlWU3I4M0tvMThT?=
 =?utf-8?B?d01UQmFtb1BrVzF3c3VIZS9sZHBPRGlrUi9SUlpqVXM3cjYxcXc2TmtndjFE?=
 =?utf-8?B?N0p5dDNpQVNWUldQeFh5cXJLSU9nQUdjMnkyeWhqcnlwVFRteWkrdmZaM0tV?=
 =?utf-8?B?WFlJUVpyK2t5aldBWVJPR1M2ZUVxZGhOeTNDZHE0ZUQwcjdLMy92OGc2UTdt?=
 =?utf-8?B?YzZIaG8zYjE4eWpielkyQmY2WjFYdUdyN29Xa3NDY0FtOWNWK1dsaE15RW8v?=
 =?utf-8?B?TURGL1l4QWpCUnFDR09qRDJwOHNaRGxmeUFlS2EwblVWamM1cks5eDFScUZu?=
 =?utf-8?B?VURWak9sSzNIYjNFaDhsUmZUOE13RG5nUjM2QjBOeFB1blhFVkRIenVRcmc3?=
 =?utf-8?B?cjN4dU5UVkdFOFRIVmsyVUpVS3pHUFdsNi9MeU10Q1lsZmZlSVlnQUJaNW1I?=
 =?utf-8?B?dFZmVWhZNmtST3ptNGk4OVlPbnBzQWZFODJmTkNwNkpOc0lZdWpnZVFrOHY5?=
 =?utf-8?B?SXM4dHVBc0FtdEh2ckk2U0p6ZjlhVmNvc09wV0RwQ0Q5N25CbjNRazB2Vlhn?=
 =?utf-8?B?dWlBeE1nSG82YWJOWkNXRzNsVUlzSWNuVm9LMjlOU2NGUGNKazhrT200eTVE?=
 =?utf-8?B?TUxPQXIzNVNsSCtvM3gzc2FCZFpmSmNCWlRZSndYRXhuOTA5azBKVm1uTGI4?=
 =?utf-8?B?UWhCZVM2clJQODl5Ti9YSnVSM1FGc0twK0Y0Z2ROR2YrU3U2cGEzdWQ3Vmdl?=
 =?utf-8?B?SzV6YTU3NDBCQm52VThNVWE1RlozRnNmUWlkWkp6RGtrS2RTMTc1UmFtK3E0?=
 =?utf-8?B?NjNpeEpiQno3TmhWT0pOTnI1d1ZBdnRkdUM1SDJtZXZVQjRGQXI2MVhmbEhw?=
 =?utf-8?B?alQrUnhjU1p3WkdEZTdPNjN2RlhtaXZkUlppN3hqU1NqVmxWMjY2OFVDeGJ1?=
 =?utf-8?B?SEVaK0lvWHcwOHNMeUM2UnpXdTN3dC9zZ3dNMWtYa2Rhc2R4NDdoQXc1MXJY?=
 =?utf-8?B?UFd2QTNJUWxYMEdwd0dHMlFHWVJ5dWFTOWhKcnFoWXZyWjF4QzJta2NOeG9r?=
 =?utf-8?B?RHhnczdiV3FheFV6YVIvT0preGwvQnZYdm43b2oyemQvbUcvOTBSNlNSazFD?=
 =?utf-8?B?UUxaVjNHUTYxSUNEcmJiclA4RHQ1Ky9OOHRlSXZTZ05yWEhvVWwwU2NRVUdR?=
 =?utf-8?B?dVlQKzNxMlNyVE1JWjZHeGlZY29sTStmYXFneDRmUVMyTGY3V2lyTmlLNEJz?=
 =?utf-8?B?NllUUEwxVldWL0FieFVKY3EvS3J5dTFTV0Q0ejl1VlYzOGVWcFJ4bVVlMHdI?=
 =?utf-8?B?QzZoRDIwaENmVnR6UG90eEEvbjEvMlMyejc2MGFNaVI1MzdpL09YMkpBUCtz?=
 =?utf-8?B?M2RMUVd2VUN0bzgrV2pUdUJwTkwyZ0JwOWdjdDhFUkdHOXZPd3hJVC9aY28z?=
 =?utf-8?B?UFdtWXRiNWlpamQrT0xqVlJmUGNFR2tLZkcwZDFnWDA3V3NPZzFTZS92K2xh?=
 =?utf-8?B?S2JOWkNQYUU3Q1EvUWtwYkJjSHh6RnVjUDkzWU5DL1pGclNSWUxKMURJOHgr?=
 =?utf-8?B?cmFISFdFVWZqYUd0SVdFWHBZLzFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06A205EC63F4674391AC29BA6A09034F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dfaa81-3640-4672-d628-08de101c0790
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 21:02:50.5074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65JxfiaTycAZl2e4a3DN4siTwXEnsJCAmNPQvl2Crv286aNKDyZrnWTk9D0n+BgwY4mJPcgaX7/2k9/1C8MiIrA8AX5rm+UibHZClpp57ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9209
X-Authority-Analysis: v=2.4 cv=Es/fbCcA c=1 sm=1 tr=0 ts=68f6a37c cx=c_pps
 a=tDId93ursMd3H6XzuY9MuQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=ofF5VYgSQ-M-nUfqx3EA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: b0BU6kFOOHPH-k_itxOc0RdLCdEpxmb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE3NSBTYWx0ZWRfXy5I69yS1fdDQ
 GQa24dmyV3joCr9DqkwBiBXFvne08A/rEICS39yydzgjwqlT4Nuixv5qYNml9Owstb6tVSch7HC
 qSNaStQiejldr4HFXDoMJdSFZvB2K0SPXdeMrYVxl1+q2RiLo7rI1Pg94IlunBzkKkuQjddMXnm
 5jQqujQ//U/yMNEBj9SRf+2CMr8TUWRfZrFqYb03exdIpRlagJzmxzIulR+rpFW7UyiJOQolS7k
 f1FEzkwYKzOqs5TUQo+6ncHfv8jd0vMHnceM1V0b6Q7xJZC9wF5JuMtzIsedvEVPYz27HkO6VPM
 C8QMx5p9rIpj2WQw6oB8syfErnJwz6XrQIXh0HE1guAoUq4GZY5uQ0NPkBba9cb97zVnygoxRdA
 Pj4yOF+o8d1CZiRMRlK5LO0v3loRHw==
X-Proofpoint-ORIG-GUID: b0BU6kFOOHPH-k_itxOc0RdLCdEpxmb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIwLCAyMDI1LCBhdCA0OjQw4oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiANCj4gfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0hDQo+IA0KPiBPbiBN
b24sIE9jdCAyMCwgMjAyNSBhdCAwNzo1NDo0MVBNICswMDAwLCBKb24gS29obGVyIHdyb3RlOg0K
Pj4gDQo+PiANCj4+PiBPbiBPY3QgMjAsIDIwMjUsIGF0IDM6NDTigK9QTSwgUGF3YW4gR3VwdGEg
PHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gIS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQo+Pj4gQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4+PiANCj4+PiB8LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSENCj4+PiANCj4+PiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAwNjoxMjo0OVBNIC0wNzAw
LCBKb24gS29obGVyIHdyb3RlOg0KPj4+PiBBIFZNTSBtYXkgbm90IGV4cG9zZSBJVFNfTk8gb3Ig
QkhJX0NUTCwgc28gZ3Vlc3RzIGNhbm5vdCByZWx5IG9uIHRob3NlDQo+Pj4+IGJpdHMgdG8gZGV0
ZXJtaW5lIHdoZXRoZXIgdGhleSBtaWdodCBiZSBtaWdyYXRlZCB0byBJVFMtYWZmZWN0ZWQNCj4+
Pj4gaGFyZHdhcmUuIFJhdGhlciB0aGFuIGRlcGVuZGluZyBvbiBhIGNvbnRyb2wgdGhhdCBtYXkg
YmUgYWJzZW50LCBkZXRlY3QNCj4+Pj4gSVRTLXVuYWZmZWN0ZWQgaG9zdHMgdmlhIGEgQ1BVIGZl
YXR1cmUgdGhhdCBpcyBleGNsdXNpdmUgdG8gU2FwcGhpcmUNCj4+Pj4gUmFwaWRzIGFuZCBuZXdl
ciBwcm9jZXNzb3JzLg0KPj4+IA0KPj4+IEJISV9DVFJMIGlzIGFsc28gZXhjbHVzaXZlIHRvIFNh
cHBoaXJlIFJhcGlkcyBhbmQgbmV3ZXIgcHJvY2Vzc29ycy4gV2h5DQo+Pj4gd291bGRuJ3QgaXQg
YmUgZXhwb3NlZCB0byBndWVzdHMgYnV0IEJVU19MT0NLX0RFVEVDVCB3b3VsZCBiZT8NCj4+PiAN
Cj4+PiBOb3QgZXhwb3NpbmcgQkhJX0NUUkwgaGFzIGFub3RoZXIgZGlzYWR2YW50YWdlIHRoYXQg
Z3Vlc3RzIHdvdWxkIGRlcGxveSB0aGUNCj4+PiBCSEItY2xlYXIgc2VxdWVuY2Ugd2hlbiB0aGV5
IGNvdWxkIGhhdmUgdXNlZCBjaGVhcGVyIGhhcmR3YXJlIG1pdGlnYXRpb24NCj4+PiBmb3IgQkhJ
Lg0KPj4gDQo+PiBZZXMsIEkga25vdywgYnV0IGdpdmVuIHRoYXQgQkhJX0NUUkwgY29tZXMgdmlh
IGEgc3BlY19jdHJsIHZhbHVlIGNoYW5nZSwgaXQNCj4+IGhhcyBhIG5lZ2F0aXZlIGVmZmVjdCBh
dCBhbnkgZ3Vlc3RzIGxpdmUgbWlncmF0ZWQgaW4gdGhhdCBuZXZlciBBKSB1cGRhdGVkIHRoZWly
DQo+PiBndWVzdCBrZXJuZWwgdG8ga25vdyBhYm91dCB0aGUgbmV3IHNwZWN1bGF0aW9uIGNvbnRy
b2xzIGFuZC9vciBCKSBoYXZlIHVwZGF0ZWQNCj4+IGJ1dCBoYXZlIG5vdCB5ZXQgc29mdCByZWJv
b3RlZCBhbmQvb3INCj4gDQo+IFNpbmNlIElUUyBpcyBuZXdlciB0aGFuIEJISV9DVFJMLCBkZXBs
b3lpbmcgSVRTIG1pdGlnYXRpb24gdW5uZWNlc3NhcmlseQ0KPiBzaG91bGRuJ3QgYmUgYSBwcm9i
bGVtIGZvciBBKSBhbmQgQiksIHJpZ2h0Pw0KDQoxMDAlLCB0aGlzIGlzIG11Y2ggZWFzaWVyIGlu
IHRoYXQgcmVnYXJkIGJlY2F1c2UgaXQgaXMgbm90IHRvdWNoaW5nIFNQRUNfQ1RSTA0KDQo+IA0K
Pj4gQykgaGF2ZSB1cGRhdGVkLCBoYXZlIHNvZnQgcmVib290ZWQsIGJ1dCB0aGUgQkhJX0NUUkwg
aXNu4oCZdCBhY3R1YWxseQ0KPj4gYXZhaWxhYmxlIGJlY2F1c2UgdGhlIHN5c3RlbSBoYXNu4oCZ
dCBjb2xkLWJvb3RlZCB0aGUgVk0ocykgKHNlZSBjb21tZW50cw0KPj4gYmVsb3cpLg0KPiANCj4g
VGhpcyBsb29rcyB0byBiZSB0aGUgbWFpbiBwcm9ibGVtIHNjZW5hcmlvLg0KDQpZZXMNCg0KPj4g
SW4gYW55IG9mIHRob3NlIHRocmVlIHNpdHVhdGlvbnMsIHN1YnNlcXVlbnQgZ3Vlc3QvaG9zdCB0
cmFuc2l0aW9ucyBiZWNvbWUNCj4+IHBlbmFsaXplZC4gTm93LCBmcm9tIGEgc2VjdXJpdHkgcGVy
c3BlY3RpdmUsIHRoYXRzIGlycmVsZXZhbnQgYmVjYXVzZSBvbmUNCj4+IGNvdWxkIHNheSB0aGF0
IGlmIHlvdSByZWFsbHkgd2FudCB0byBiZSBzZWN1cmUsIHlvdSBoYXZlIHRvIGRvIHRoZSB3b3Jr
IHRvIG1ha2UNCj4+IHN1cmUgYWxsIHRoZXNlIGNvbGQgYm9vdHMgYXJlIGRvbmUsIGJ1dCB0aGF0
IGlzIGZhciBlYXNpZXIgc2FpZCB0aGFuIGRvbmUgaW4gZ2VuZXJhbA0KPj4gZW50ZXJwcmlzZSB2
aXJ0dWFsaXphdGlvbiB3b3JrbG9hZHMuDQo+PiANCj4+IE1lYW5pbmcsICppZiogYSBob3N0IG9w
dHMgaW50byBlbmFibGluZyBCSEkgYXQgYWxsLCB0aGV5IHdpbGwgcGVuYWxpemUgYW55IGd1ZXN0
DQo+PiB3b3JrbG9hZCB0aGF0IGhhc27igJl0IGRvbmUgdGhlIHdvcmsgdG8gZG8gdGhlIHByb3Bl
ciBlbmFibGVtZW50IGNvdmVyIHRvIGNvdmVyLg0KPj4gTGVzcyBvZiBhIHByb2JsZW0gZm9yIGh5
cGVyc2NhbGVyIHdobyBjb3VsZCBjb250cm9sIHdoYXQgbGF1bmNoL3doZXJlLCBtdWNoDQo+PiBt
dWNoIGhhcmRlciBmb3Igbm9uLWh5cGVyc2NhbGVycyB3aG8gbWlnaHQgbGl2ZSBtaWdyYXRlIGlu
IGV4dHJlbWVseSBsb25nIHRhaWxlZA0KPj4gd29ya2xvYWRzIHRoYXQgZmVlbCBsaWtlIGEgZmVk
ZXJhbCBwcm9qZWN0IGp1c3QgdG8gZ2V0IGEgZ3Vlc3QgcmVib290LCBub3QgdG8gbWVudGlvbg0K
Pj4gYSBndWVzdCBjb2xkIGJvb3QuDQo+IA0KPiBUaGF0IHNlZW1zIG9ydGhvZ29uYWwgdG8gdGhl
IHByb2JsZW0gYXQgaGFuZCwgYnV0IEkgZmVlbCB0aGUgcGFpbi4gSUlVQywNCj4geW91IGFyZSBy
ZWZlcnJpbmcgdG8gdGhlIHdybXNyKFNQRUNfQ1RSTCkgYXQgZ3Vlc3QgZW50cnkvZXhpdCBiZWNh
dXNlIHRoYXQNCj4gaGF2ZSBkaWZmZXJlbnQgTVNSIHZhbHVlcy4gSG9zdCB3aXRoIEJISV9ESVNf
Uz0xIGFuZCBndWVzdCB3aXRob3V0IGl0PyBEbw0KPiB5b3UgdGhpbmsgYWRkaW5nIHN1cHBvcnQg
Zm9yIHZpcnR1YWwtU1BFQ19DVFJMIGluIFFFTVUgd291bGQgaGVscCBoZXJlPw0KPiANCj4+Pj4g
VXNlIFg4Nl9GRUFUVVJFX0JVU19MT0NLX0RFVEVDVCBhcyB0aGUgY2FuYXJ5OiBpdCBpcyBwcmVz
ZW50IG9uDQo+Pj4+IFNhcHBoaXJlIFJhcGlkcysgcGFydHMgYW5kIHByb3ZpZGVzIGEgcmVsaWFi
bGUgaW5kaWNhdG9yIHRoYXQgdGhlIGd1ZXN0DQo+Pj4+IHdvbid0IGJlIG1vdmVkIHRvIElUUy1h
ZmZlY3RlZCBoYXJkd2FyZS4NCj4+PiANCj4+PiBJIGFtIHB1enpsZWQgd2h5IEJVU19MT0NLX0RF
VEVDVCBpcyBtb3JlIHJlbGlhYmxlIHRoYW4gQkhJX0NUUkw/DQo+PiANCj4+IEJlY2F1c2UgQlVT
X0xPQ0tfREVURUNUIChvciBhbnkgb3RoZXIgZmVhdHVyZSBmcm9tIGNvbW1pdCBbMV0pIHdhcw0K
Pj4gYXZhaWxhYmxlIGRheSAxIG9mIHRoZSBTUFIgUUVNVSBtb2RlbCwgd2hlcmVhcyBCSElfQ1RS
TCB3YXNu4oCZdCBhZGRlZA0KPj4gdW50aWwgY29tbWl0IFsyXS4gVGhhdCBtZWFucyBhbnkgVk1N
IHRoYXQgYWRkZWQgU1BSIHN1cHBvcnQg4oCcZGF5IDHigJ0gaGFzDQo+PiB0aGUgZmVhdHVyZSBz
ZXQgZnJvbSBbMV0gYXQgbWluaW11bSwgYW5kIGl0IGFsc28gbWVhbnMgdGhhdCBpZiBhIGd1ZXN0
IFZNIHdhcw0KPj4gKnN0YXJ0ZWQqIG9uIHRoYXQgUUVNVSB2ZXJzaW9uLCBidXQgbmV2ZXIgcG93
ZXIgY3ljbGVkLCBpdCB3aWxsIG5ldmVyIHNlZSANCj4+IEJISV9DVFJMLCBldmVuIGlmIGl0IGlz
IGF2YWlsYWJsZSB0byBiZSBwaWNrZWQgdXAgaW4gdGhlIGxhdGVzdCBtb2RlbCBzY2hlbWUuDQo+
PiANCj4+IEkgY2Fu4oCZdCBzcGVhayB0byBvdGhlciBWTU1zIChlLmcuIHZtdywgaHlwZXJ2LCBo
eXBlcnNjYWxlcnMpIGFuZCBob3cgdGhleSBkbw0KPj4gaXQsIGJ1dCBJIHN1c3BlY3QgdGhlcmUg
YXJlIHNpbWlsYXIgY2hhbGxlbmdlcyBhcm91bmQgcG9zdC1sYXVuY2ggZmVhdHVyZS9iaXQNCj4+
IGFkZGl0aW9ucyB0aGF0IHJlcXVpcmUgdGhlIFZNIHRvIGJlIGNvbXBsZXRlbHkgY29sZC1ib290
ZWQuDQo+IA0KPiBPaywgdGhhdCBtYWtlcyBCVVNfTE9DS19ERVRFQ1QgYSBiZXR0ZXIgY2hvaWNl
IHRoYW4gQkhJX0NUUkwuIEkgdGhpbmsgaXQNCj4gYmUgYmV0dGVyIHRvIHJlcGxhY2UgQkhJX0NU
Ukwgd2l0aCBCVVNfTE9DS19ERVRFQ1QuDQo+IA0KPiAtLS0NCj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+
IGluZGV4IDE3NTVmOTFhNTY0My4uZThmYzRhNDA1NWJmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9u
LmMNCj4gQEAgLTEzNTUsOCArMTM1NSw4IEBAIHN0YXRpYyBib29sIF9faW5pdCB2dWxuZXJhYmxl
X3RvX2l0cyh1NjQgeDg2X2FyY2hfY2FwX21zcikNCj4gaWYgKGJvb3RfY3B1X2RhdGEueDg2X3Zl
bmRvciAhPSBYODZfVkVORE9SX0lOVEVMKQ0KPiByZXR1cm4gZmFsc2U7DQo+IA0KPiAtIC8qIE5v
bmUgb2YgdGhlIGFmZmVjdGVkIENQVXMgaGF2ZSBCSElfQ1RSTCAqLw0KPiAtIGlmIChib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfQkhJX0NUUkwpKQ0KPiArIC8qIE5vbmUgb2YgdGhlIGFmZmVjdGVk
IENQVXMgaGF2ZSBCVVNfTE9DS19ERVRFQ1QgKi8NCj4gKyBpZiAoYm9vdF9jcHVfaGFzKFg4Nl9G
RUFUVVJFX0JVU19MT0NLX0RFVEVDVCkpDQo+IHJldHVybiBmYWxzZTsNCj4gDQo+IC8qDQoNCk9r
LCB0aGFuayB5b3UgZm9yIHRoZSBiYWNrIGFuZCBmb3J0aC4gSeKAmWxsIGRvIHNvbWUgbW9yZSBw
b2tpbmcgYXJvdW5kIGFuZCBzZWUNCmlmIEkgY2FuIGRvdWJsZSBjaGVjayB0aGlzIGFwcHJvYWNo
IG9uIG90aGVyIHBsYXRmb3JtcywgdG8gc2VlIGlmIEkgY2FuIHNtb2tlIG91dA0KYW55IG90aGVy
IG9kZGJhbGwgZWRnZSBjYXNlcy4NCg0K

