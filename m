Return-Path: <linux-kernel+bounces-759321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E4B1DC07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1977B08DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A71270571;
	Thu,  7 Aug 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebqapog3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="soLjerPf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3D186A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585816; cv=fail; b=SE7x89IvGzERDbJYAB7gpnIch7CdmiOlEElhJ0WveUiZpufOw8/3wZ9uhJSWtQjncOTH+QRUrxqnSGD8oX89fyb9stK9tbUfDWYtwydlpNxlg7ohSBLr2LoGXq6i2hRPhS5BItKddeCL42Bx3zIYQj2oTv35GnwkTsDGuRPgMEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585816; c=relaxed/simple;
	bh=F8klo7Cdv0FwbfTRwLLlDysBl3nft5i1p/ga1C7a8RE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXgu4t+sl2+e8R87B/QuNUnC7xR+eDZdfvnJNUSoCSyWdErg/2+IW/ul9ODex8VjiTFIlPmLBFhd+zP9T9wQahlVDkoduNdqaMGq5KmFPnZogyN1M9w3HuLaWqV4F8XXAN9lJAWHRizeSnweJEcSs9WfIAOzARKx99baESqFIHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebqapog3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=soLjerPf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577GgJtd023228;
	Thu, 7 Aug 2025 16:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F8klo7Cdv0FwbfTRwLLlDysBl3nft5i1p/ga1C7a8RE=; b=
	ebqapog3JEkne39LmWOfrlhdtuHjZlfFeX2V5OBVe3jDlA4QTI/2sNI+t4qI8O1K
	lVqFLqGr2Mon9ldt310KkZ9yXmNvMQEb0OnFPoLkoh3visNSW27/qoMalNZ9HmEe
	SqtEN33YcQPXEU7RtxRW1OXFhQbPJHMZbv7VwDnbATNzIgkJ69GhI8cUtSlRiqOx
	mNtMaCis2dKDTVSvnbQOLknWj0JCP1T3HmDrZhiGKi/6ZK6bKrI5qT0KgHhyTnUe
	j0uiS8YmCsFbXdbruhUnYCzRWUQBPUtH5/Nn+F2FQInw+DHz45tvfKsil9Pl5nZw
	Tr/uZjc4ooe3xcwKFLktng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh4j9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:56:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FMl9t005693;
	Thu, 7 Aug 2025 16:56:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwypxgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:56:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uufbnJsmxUWVK7fBGz2/BkExibq/zJgrXMBgyG3qV2v8c0dbGvnQiQPpeMjRhj+rsp7tRo2O7VG8mSPeomT/aJ03idHUVFWnEx0qdRvQWjvBovhxFxNlInYch3xC4FpxLymI2mzWQMGguvDbPZGWQGqvSe8+TqRXmB3dSlCMrR/TJs0xfNjBAkQauTYAORHWTcL0/rmzsE2uanNr+i8Avgcd/ADyHASH+eqzIP0SRoZHok2bm9m5NteZmAVjApl+wIaVbE7Dlhq3+Qg9QlXhV6kVeXOskqw7cHHZqVwCkDAhpqGGWfsIq3Ai8pTG7gjCacrdK3vDrSIGPAY8Pf9aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8klo7Cdv0FwbfTRwLLlDysBl3nft5i1p/ga1C7a8RE=;
 b=RInxoEOigFuRD7Zg+RhpJ1pga2d+SLcZhYJr7Pr10jH0gt0Lq8Ygh8cg/tMKZNDDCHUEqhiHmP6QoOxqh608DVl8f11BdXjjFw3ajj0GW8PIHUZT5HjQP49nmqORXWFDc68YsKThrUXNoFOtnjknt8zxFyafvu5Epo7fM7twM4oAxbidlAf5yY7qw6H8SP4M1KuESehJxF/4o+BMAC1JUxF+H0Zrm/KzEZ2ER/0fOn72y4bFzmNyfviniPTQNo8ykyJdWki4EQi8YYcKkrbFQoXC5CrMMpR11ZqA7Sr9wHAkHccVOfQhS82KbkgXWUywkBzmzO7ATX00ioPkaLZlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8klo7Cdv0FwbfTRwLLlDysBl3nft5i1p/ga1C7a8RE=;
 b=soLjerPfAFd6KinWXF+4QiSrxksWcHDWlVDL5VphvNQGUPkCoL6Si9q1xQPVHeNWHhqn/CKbVbJP6z9dewVu5klmrUYv3df4/q7Ww/MpncjYQyzzFPDbehTlrfgNk+pLxN+v5VFnJ6wPFJOJamSh9nY/U2nb7pzX9oA6oRB55pc=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 7 Aug
 2025 16:56:33 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:56:33 +0000
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
Thread-Index: AQHb/LZRoohaxDA/AkO7zPAZBTuqUbRWKXQAgAFC14CAABKwAA==
Date: Thu, 7 Aug 2025 16:56:33 +0000
Message-ID: <BCFBCCEA-8D24-4835-8C28-74D93F5EF38B@oracle.com>
References: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
 <87ms8cchqf.ffs@tglx> <20250807154929.4Wpr6V4N@linutronix.de>
In-Reply-To: <20250807154929.4Wpr6V4N@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|CH0PR10MB7440:EE_
x-ms-office365-filtering-correlation-id: 1718027d-5c50-4f38-4d48-08ddd5d35d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aHhNUEF0OHBCNXlRUUFvUTZsSDZ4dExsbFFpUHZUMmg3eFg3UktRMCttMVo3?=
 =?utf-8?B?QlJxVEh4bWxNTHlYZXJySGt3WVY5TXRZYjV2QkliYVNiQlF3L05sME5sV3ha?=
 =?utf-8?B?bVhlYzJjTDhmeWo2NWs2dUZoUHp3RTdoVDhOMEQvQjRFcExCa2dOU2daa1hU?=
 =?utf-8?B?ZnhDaFZVRThuSms0RHJoS3ZNeXFMOTBjVFdYYXBvSENYbVBteG5KVEFCN3lO?=
 =?utf-8?B?dFVCMldUNGt4SDIwZWNUVThNaFdLaW42T3pHUW5XWm1aVGc0ZDF6NTlOMWVs?=
 =?utf-8?B?OUEyQnN2N203TWRPWHlCeFZtTDZFdEtYMDB5M0UvUGo5T3VwMnJDMTZEMG5k?=
 =?utf-8?B?RENqdnpOTHg0VjRmN1NZTDVpelFMMzlnNHI3WGFDQlhPbWc2UzJadzk2SHZZ?=
 =?utf-8?B?eTNTcWErK3F2T0NFUi9vTml3N3dKVEQ2QkpxS2ZGRTlSLzZ4cVZ4aVo0c0tw?=
 =?utf-8?B?MW9aTG5HYnFZUlBKdFlXcTlPOEF0b0dQanoxQ2syZ0pPNmpSdm9BekxKQlZ1?=
 =?utf-8?B?YUYrdDNWVSthSnRPOWl2bTh5dm4yRU5jSFpWTk90dUh4WGFsVzU2VzBaSVZ6?=
 =?utf-8?B?YWtuMVJNWkZWcTRsemNLZFhRUDYzYS9Zc2pGSHVlR2J4Z3Q3SUhDMVhxOVd1?=
 =?utf-8?B?b0hwS1RmNzRtTkw2a3dSbGUwTTNrbHJyemQ0YzQ1NkFFdVYxcTljSHhIRUd4?=
 =?utf-8?B?TUtLcWhxMzNLQmtTNk9jU282OHZ5U2hDZmEzUFBLZmRZNHppSkgwMnF4dDJE?=
 =?utf-8?B?ZXc2UWU1VWtURjV4MVlsam5vL0RDS1BCMUpTeXNyNHRwdUw2b0dkbkZkQ2ph?=
 =?utf-8?B?QlVmMzMrcm4vTmJtOXBSNXE1dVVOTlVrbUYvaHg3ZkRoWFRwZGJuUlJLeDlk?=
 =?utf-8?B?eWVRZlhjWW9BNS8vK256RkkwNUdOUEtzRWNyd1FyeU1ZczBIa2ZkYjlMU0g4?=
 =?utf-8?B?SXZXaGc3TkhsYkY0b3QrSHJpQ3VjcmxpazRPcVM3UDViR3dOQjlvWlhoNDJV?=
 =?utf-8?B?S3FaNFlPRGRuUEo2a3A2Ym93TWRNMUlJWFZBRFpldXFTc2hmZU5IWWRWRkJJ?=
 =?utf-8?B?eHdoNll3b05GZnUvbXY0bkRIeHRTN0taYlZEblZHa0FldjAvVkxReUhrYjRD?=
 =?utf-8?B?Tmc5TFpMMkdwUkxHYjBDR2FoQmd4cDdiMEZrYTZYY3BCbHBLUXk0MmNtY0V3?=
 =?utf-8?B?T09qRnhjMUlpeHVhT2psSVIwaDBCSk03YS85SThGb1VDN1IzTnM0cks5UTht?=
 =?utf-8?B?TVlleWRNRXFVMFNlanNORWp2NVRMZ0NyNXhubitoZ1lmZUZIRnh5OWJ0VHc1?=
 =?utf-8?B?QVhQMjFFUUZ5UGxPaGdVWExpS0xrWm9Yc0huZmNRajd3QVFHVDRreTcwYWtr?=
 =?utf-8?B?OUs1MFhsQys4dFJ6dWp6NVlKRXM1QjhsYVNRQm9tTVFoSFpsWEh0dG9Ka2Q4?=
 =?utf-8?B?dXVVR2JEY0NIbU1TNlcraHFQN2x0T0c3NWJPTGNRb3N1V2c1YjlYY0dVTm1j?=
 =?utf-8?B?dDFlOVZJY1NMUEJsTzZQVGxFMXI1ZGpHV2xBWUptWDFRWDM3M0FLa2svMmh1?=
 =?utf-8?B?THRQWnkxR3NDR0pscGpKaWdxV3VJeklrdlNUZEpBem9wNlNIZlh6QXk3TXJa?=
 =?utf-8?B?eEtIOWZqTU5xT3JRUVBPUHorTmVnZ0c4VGMzemNqdnNwcnFtWXhnaGdpNVBu?=
 =?utf-8?B?SktDV0hxTVlGbU5SaDhjTGYyZG5Rdmp0Wi9TU2FrUS9rM3lEVUdUM2JaK2xt?=
 =?utf-8?B?UjAzcXF5N1lvMmtPZUNYZXRLdFpCL3ptK0tySUl5UlluakwxR1phUlR5N1BO?=
 =?utf-8?B?M2liS1F1VlExazJ4WFJMM1crL0Zvd1RtUGdKYkJldWhCZ1p4QzdmQ0pnbjBl?=
 =?utf-8?B?VkEzdzdFZnZycHk3ZFp1RFdQRzlpM1Y1UkVWNEJtNUovWTRhNTZxY2R5Mi9P?=
 =?utf-8?B?MHUzcVNEVjYxU0lmNGxFVkhKbExSOFF1ZHFhRWhMR2VaUU9nZldvT0luVXo1?=
 =?utf-8?B?dEVmME5FTFdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDQ1dkE1RUpMR1ZFTFFwRURFbEY0dG5leHo5cElnbkhGblVGanI2Mks1Uk0w?=
 =?utf-8?B?S3hoS0xiTVVZSG9DQkVTZFU4S2h2eHB1UnphNFlvei9CbGY1QjFUb2F5S210?=
 =?utf-8?B?MWZmbTJRMGFNM1d5RENNMEs3T0x3TmZnNmNYcFAzYmhrTlpuNzViTW1DRFYr?=
 =?utf-8?B?cC90UVZrWFNSZ1UwakxZeVN0azRiZnpHYjIvUk8wRlVvZkxmUlZzU09sbm1S?=
 =?utf-8?B?QVNUQ2xaV2d5V0lHY2FYemF2dE0zcnkwWklXRTRsUXBlbnpkUXl5bHhpVXNy?=
 =?utf-8?B?MjRBOHlKMGZIL2tWeHVPaEMrK3ZzL2piV0RBaTd4Wk1DcjB5Q2dzWDJVQUtD?=
 =?utf-8?B?NU5aY3dhcjNXV2szRkNYZnAxbSs3ZE1xM0hsOTlRMnJHdTJ5NjJmOXBZTnBN?=
 =?utf-8?B?VTF0eVV4Qy9TNnFhU1hBT2VQNHFpbU9JeEFJY0ZicDU4UzlZd2pGdEl1M1hF?=
 =?utf-8?B?MmhTTGEyWjMwWDRIeDJwYUJpblc1U2FtODJuMFZySnRKeGJaWjZvRXlMZWUy?=
 =?utf-8?B?Z0ZIbEthbTRQdk5hREYvOW5qeDBKRUN3RTRWLythMXY5Wk5xODIvWHZVTVB0?=
 =?utf-8?B?WThoWmlSblJjTXRMNVh2L1MrUlJPOHZHTTZTd1lmblVzSDFnZDhmRzUyM3VL?=
 =?utf-8?B?UTNJZjJzam1vdGptd01RNjZMRGdEc1lmbU9OYlhpTVlZQnJicitXMHltSjFk?=
 =?utf-8?B?aS9TUXczSjlPaEdIS2ZDeXVNQWhwVnhJNEFPVDE4UmdpWERpMVNNSUF4ZzBv?=
 =?utf-8?B?bGR0Z0ZteFFLUHpzZ0ZKVFAvUHpOOTZMWWxmU2E2ZlF2OE0xNzcxdVVnWlhy?=
 =?utf-8?B?bzFoTU01NlgwMHJ3cTF6TmNLM2MwbDNjcEFxM09TMmNnUEFEeXV1cC9RZWFu?=
 =?utf-8?B?MVJGYlpOVmJEMzd4Mi9Raithbnd5L0VoYnBFTzYvYXlzM3ovNG5HMUxpaDRD?=
 =?utf-8?B?RWxxdDlRYnBqR2pLU2pKVWZEV1owM2VYbXZuS0VFeS9jUVBaM0ovNFBkSGtn?=
 =?utf-8?B?Y1NmSWZHSTVScHk1UGxuSFhLdVBkRnJUb0YrbTAwZDRUMzFZcUY1bDBTcll2?=
 =?utf-8?B?ZHF3QU5xbjZheC9LdXRnN0wycGgyNXlmbGsxM3FkQ01zTktOR1RuQ09WTkZB?=
 =?utf-8?B?V2tabjJXTVRWNzV0emtCb2JxSFhHMlVadmdtNGIrME5Nbk85NzljSGZ2SkNv?=
 =?utf-8?B?QTdaeUdNTVM3YzJqUTc5aCsyWnNuL0IvRmtvaldSQ2tOemVZQVBCSGRvMXcr?=
 =?utf-8?B?SjBoM3NhZlRSUnV0dlJObHlnS3N0Tjd0UkdCUWZaTjhHS1JLZUEyUFRTVkxZ?=
 =?utf-8?B?TFJpUFZUNjdqbDdBSyt5WmJXUDhyV0dyQWNNTVZ5V3pOenV4YnI0N3hRTUpw?=
 =?utf-8?B?V0hBa0NKSThQSU5RU3doejJMTVlzYmg5UDQ1Y0VnaWl4YXpwS294ZklLSkVT?=
 =?utf-8?B?NWtmYXNiNnE0OHB2YjJxTXQ3MXFPWk9waVpYVWNCTVlMdUFwUzdlYkdYU0Rz?=
 =?utf-8?B?ek9MMU5pWHlvcGJ6YlBDYVQ3bkNDTnM0ZFAwbGlHWFhUbjBrZE4xQStxWGdy?=
 =?utf-8?B?a0taL1ZVSWVkTGdlbU9DaEdkWXhyc0RhN1Q2TDFFaHFOQnJIZjVNRTFLaTF4?=
 =?utf-8?B?eDdaU0pLMlVmTy8zYnFTYzNtSTM4VG5iYmRyTXUyYWJIVDllTFlxYVZLSHFy?=
 =?utf-8?B?N0tvd2k2UldIQm5RaEo2SklCRnVLTVF6dEFUbEdoL1lzaG1BQ1kwQUx6ZHRL?=
 =?utf-8?B?L3U1ZmF0UlNxZGNMMVU5Q1dJMG1KMDJQNmRmQ1YzWThYbk1vYjFiOVJMaEd4?=
 =?utf-8?B?VkpKUWRYNEZyVXFiRlNzcjNwYWpPL0pqOW1LdHBkUDRlK0U5b0NMNzY4RElX?=
 =?utf-8?B?dllVcjF6WVNvcDVQODV4RFhuSjAwYnVqR1ZBWmNTUnVDaThkUmlZTVFYaExX?=
 =?utf-8?B?MzJrc3lEOHhmeGdqSm5SQkI0cDJXaWlYRXRpUTVMZ1hvYjZ1d1RNbzVxMXE1?=
 =?utf-8?B?L003bGtqOGFDT0l0K3IyV20xRnpMSGNscTNxNnZmbnN4bTBqQkt5dktmd2NK?=
 =?utf-8?B?ZHBHcHBqQVEyTkVXUDVTT0xjM3ZkN0h0MlZwT21mMlU5dW9tQzA2ZmkxYkU5?=
 =?utf-8?B?S3Z3c2xENUJiOWE3YjRVRmpFdVFLWS9tdjRmZ2t3SlZIVEI2MENuMUxMcXZ0?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21502527C00C794CA54BDA2A90097541@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h7XF/OgpMJ6M7BiAHYqD/oMVhx6J6Z6j2LEMHuJwf2cKZJiN50IyYq5LD8ll+BkpwWnh9sPuQlkNjtrLdn0B+KuL0xzVhlJzKn7ZG/GqeipjDzER535lDEm3pcuMmYtLAvu462uVt4md/WJFNdI5ZGDlXaOEIBEl1ixnDQHFXKiMgrY7mmo/IXDiTS5/QB/M8dgZhahZl9LT/J+YbFfIneYgX8hrXBZ5oTPa8JROHCPSgleBtNla6m2pDNekuO1+Yymma+tpU0s3tHxnrD3azZzM1uW2tJGjhvhsWCTCQKiB+SyfG0mMTFM1NKO9YcwY4jdL9A3x0wr8roCZcrp9ABDXKgSATI5LGRco9UbQZh9eP7+t3Xt2K4Go73Hb+JqsTMpflkRXJwJMctRzwe3U1z/h+Iodr069tIzeVLHeXpAFd7N6p4qYtn9PdNHbiPZHeuxyjChz054cfwZblVAq5/DvYOmqkNy47JWnwdXv/2d4av98WLWB5Tdb9Td8AUgP+KWJYoFrvmtHHmV4kzdjCyGKavK6UFOzui5TL71BDadKF7V0JZtWZ2yVjnoM289D2/bb9EV7YV7/brXiqBZpqGRdSzO5aNzXkaaIrbuHXQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1718027d-5c50-4f38-4d48-08ddd5d35d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 16:56:33.3957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tamtd6IaXT1d11tGlbnoCh4PGC5tU6+rVhlO1CTAw8iWiAwiBqjQCMNfFhSa+r0+b6xSN9/GLwDjumNlldXBCI0VH0IlSagatx/kn+0Oc24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzOCBTYWx0ZWRfX1JieA38IObNw
 mQ+0eOB2Ck5T7PFrg3PL2839B+VgeaT9IjaAuxCpipWs90eg/O+SxmDQRJmk2SuroI0PWEengKH
 auicudlaQ/hoZk2xo8gDDNqxpW7SNBRi0eWAYiTZ6Exw0uBHywPwfSNvWqU7p8nx80+QRspxWx6
 oEMFhJI3i3aBVNSUgoHT1waMOimpFP/RdAjksEO+vaXsYuYRHQLKx4NA6O7BV7cDjxmvP+rx/5g
 3vVxN94nKSZQ6gFyJZ/iNwtAQ7p7hpypjy58hDL3SjWcgoLYigOJv9mpZGCqiz+Cf7xR5kNtXrY
 Sglic9piRzwLwPeU2Rq0ihh2l/RpiJ+UVXboHmrN3CD4Tv2i1/+VJgB7qO/G5kgaP4GJktgUVSR
 ON720uc/DCS/wrE/UMSZkoR5tPKpNS9omJ1WQMLZ0ZItZIe5KPejwQC3ceiXniv5FUxOpicq
X-Proofpoint-ORIG-GUID: liIkTm2QbR7nd8GN2ftqxxiVgVfAGDaH
X-Proofpoint-GUID: liIkTm2QbR7nd8GN2ftqxxiVgVfAGDaH
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894dac4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=P5uwj6P1RRTDrlaIB9UA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069

DQoNCj4gT24gQXVnIDcsIDIwMjUsIGF0IDg6NDnigK9BTSwgU2ViYXN0aWFuIEFuZHJ6ZWogU2ll
d2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIDIwMjUtMDgtMDYg
MjI6MzQ6MDAgWyswMjAwXSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gT24gVGh1LCBKdWwg
MjQgMjAyNSBhdCAxNjoxNiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+IA0KPj4gVGhlIG9i
dmlvdXMgd2F5IHRvIHNvbHZlIGJvdGggaXNzdWVzIGlzIHRvIGNsZWFyIE5FRURfUkVTQ0hFRCB3
aGVuDQo+PiB0aGUgZGVsYXkgaXMgZ3JhbnRlZCBhbmQgdGhlbiBkbyBpbiBzeXNjYWxsX2VudGVy
X2Zyb21fdXNlcl9tb2RlX3dvcmsoKQ0KPj4gDQo+PiAgICAgICAgcnNlcV9kZWxheV9zeXNfZW50
ZXIoKQ0KPj4gICAgICAgIHsNCj4+ICAgICAgICAgICAgIGlmICh1bmxpa2VseShjdXJyZW50LT5y
c2VxX2RlbGF5X3Jlc2NoZWQgPT0gR1JBTlRFRCkpIHsNCj4+ICAgIHNldF90c2tfbmVlZF9yZXNj
aGVkKGN1cnJlbnQpOw0KPj4gICAgICAgICAgICAgICAgICAgIHNjaGVkdWxlKCk7DQo+PiAgICAg
ICAgICAgICB9ICAgICAgIA0KPj4gICAgICAgIH0gICAgICANCj4+IA0KPj4gTm8/DQo+PiANCj4+
IEl0J3MgZGViYXRhYmxlIHdoZXRoZXIgdGhlIHNjaGVkdWxlKCkgdGhlcmUgaXMgbmVjZXNzYXJ5
LiBSZW1vdmluZyBpdA0KPj4gd291bGQgYWxsb3cgdGhlIHRhc2sgdG8gZWl0aGVyIGNvbXBsZXRl
IHRoZSBzeXNjYWxsIGFuZCByZXNjaGVkdWxlIG9uDQo+PiBleGl0IHRvIHVzZXIgc3BhY2Ugb3Ig
Z28gdG8gc2xlZXAgaW4gdGhlIHN5c2NhbGwuIEJ1dCB0aGF0J3MgYSB0cml2aWFsDQo+PiBkZXRh
aWwuDQo+IA0KPiBFaXRoZXIgc2NoZWR1bGUoKSBvciBzZXR0aW5nIE5FRURfUkVTQ0hFRCBpcyBl
bm91Z2guDQo+IA0KPj4gVGhlIGltcG9ydGFudCBwb2ludCBpcyB0aGF0IHRoZSBORUVEX1JFU0NI
RUQgc2VtYW50aWNzIHN0YXkgc2FuZSBhbmQgdGhlDQo+PiBwcm9ibGVtIGlzIHNvbHZlZCByaWdo
dCBvbiB0aGUgbmV4dCBzeXNjYWxsIGVudHJ5Lg0KPj4gDQo+IOKApg0KPj4+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgcnNlcV9kZWxheV9yZXNjaGVkKHVuc2lnbmVkIGxvbmcgdGlfd29yaykNCj4+PiAr
ew0KPj4+ICsgaWYgKCFJU19FTkFCTEVEKENPTkZJR19SU0VRX1JFU0NIRURfREVMQVkpKQ0KPj4+
ICsgcmV0dXJuIGZhbHNlOw0KPj4+ICsNCj4+PiArIGlmICh1bmxpa2VseShjdXJyZW50LT5yc2Vx
X2RlbGF5X3Jlc2NoZWQgIT0gUlNFUV9SRVNDSEVEX0RFTEFZX1BST0JFKSkNCj4gDQo+IFRoZSBm
dW5jdGlvbnMgYW5kIHRoZSB0YXNrX3N0cnVjdCBtZW1iZXIgZmllbGQgc2hhcmUgdGhlIHNhbWUu
DQoNCkkgY2FuIGxvb2sgYXQgbW9kaWZ5aW5nIG5hbWVzIG9mIHRoZSBmdW5jdGlvbnMuIA0KDQo+
IA0KPj4+ICsgcmV0dXJuIGZhbHNlOw0KPj4gDQo+PiBXaHkgdW5saWtlbHk/IFRoZSBtYWpvcml0
eSBvZiBhcHBsaWNhdGlvbnMgZG8gbm90IHVzZSB0aGlzLg0KPj4gDQo+Pj4gKw0KPj4+ICsgaWYg
KCEodGlfd29yayAmIChfVElGX05FRURfUkVTQ0hFRHxfVElGX05FRURfUkVTQ0hFRF9MQVpZKSkp
DQo+Pj4gKyByZXR1cm4gZmFsc2U7DQo+PiANCj4+IFRoZSBjYWxsZXIgYWxyZWFkeSBlc3RhYmxp
c2hlZCB0aGF0IG9uZSBvZiB0aGVzZSBmbGFncyBpcyBzZXQsIG5vPw0KPiANCj4gY29ycmVjdCwg
YW5kIGlmIHRoZXkgYXJlIHNldCwgdGhpcyBuZXZlciBnZXRzIHRvIGZhbHNlLg0KDQpXaWxsIGZp
eCBpdC4NCg0KPiANCj4+PiArIGlmIChfX3JzZXFfZGVsYXlfcmVzY2hlZCgpKSB7DQo+Pj4gKyBj
bGVhcl90c2tfbmVlZF9yZXNjaGVkKGN1cnJlbnQpOw0KPj4gDQo+PiBXaHkgaGFzIHRoaXMgdG8g
YmUgaW5saW5lIGFuZCBpcyBub3QgZG9uZSBpbiBfX3JzZXFfZGVsYXlfcmVzY2hlZCgpPw0KPiAN
Cj4gQSBTQ0hFRF9PVEhFUiB3YWtlIHVwIHNldHMgX1RJRl9ORUVEX1JFU0NIRURfTEFaWSBzbw0K
PiBjbGVhcl90c2tfbmVlZF9yZXNjaGVkKCkgd2lsbCByZXZva2UgdGhpcyBncmFudGluZyBhbiBl
eHRlbnNpb24uDQo+IA0KPiBUaGUgUlQvREwgd2FrZSB1cCB3aWxsIHNldCBfVElGX05FRURfUkVT
Q0hFRCBhbmQNCj4gY2xlYXJfdHNrX25lZWRfcmVzY2hlZCgpIHdpbGwgYWxzbyBjbGVhciBpdC4g
SG93ZXZlciB0aGlzIG9uZQ0KPiBhZGRpdGlvbmFsbHkgc2V0cyBzZXRfcHJlZW1wdF9uZWVkX3Jl
c2NoZWQoKSBzbyB0aGUgbmV4dCBwcmVlbXB0DQo+IGRpc2FibGUvIGVuYWJsZSBjb21ibyB3aWxs
IGxlYWQgdG8gYSBzY2hlZHVsaW5nIGV2ZW50LiBBIHJlbW90ZSB3YWtldXANCj4gd2lsbCB0cmln
Z2VyIGFuIElQSSAoc2NoZWR1bGVyX2lwaSgpKSB3aGljaCBhbHNvIGRvZXMNCj4gc2V0X3ByZWVt
cHRfbmVlZF9yZXNjaGVkKCkuDQo+IA0KPiBJZiBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0IHRo
ZW4gYSBSVC9ETCB3YWtlIHVwIHdoaWxlIHRoZSB0YXNrIGlzIGluDQo+IGtlcm5lbC1tb2RlIHNo
b3VsZCBsZWFkIHRvIGEgc2NoZWR1bGluZyBldmVudCBhc3N1bWluZyB3ZSBwYXNzIGENCj4gc3Bp
bmxvY2tfdCAoaWdub3JpbmcgdGhlIGlycSBhcmd1bWVudCkuDQo+IFNob3VsZCB0aGUgdGFzayBi
ZSBpbiB1c2VyLW1vZGUgdGhlbiB3ZSByZXR1cm4gdG8gdXNlciBtb2RlIHdpdGggdGhlIFRJRg0K
PiBmbGFnIGNsZWFyZWQgYW5kIHRoZSBORUVELVJFU0NIRUQgZmxhZyBmb2xkZWQgaW50byB0aGUg
cHJlZW1wdGlvbg0KPiBjb3VudGVyLg0KPiANCj4gSSBhbSBvbmNlIGFnYWluIGFza2luZyB0byBs
aW1pdCB0aGlzIHRvIF9USUZfTkVFRF9SRVNDSEVEX0xBWlkuDQoNCldvdWxkIHRoZSBwcm9wb3Nh
bChwYXRjaGVzIDctMTEpIHRvIGhhdmUgYW4gQVBJL01lY2hhbmlzbSwgYXMgVGhvbWFzIHN1Z2dl
c3RlZCwNCmZvciBSVCB0aHJlYWRzIHRvIGluZGljYXRlIG5vdCB0byBiZSBkZWxheWVkIGFkZHJl
c3MgdGhlIGNvbmNlcm4/LiAgDQpBbHNvIHRoZXJlIGlzIHRoZSBwcm9wb3NhbCB0byBoYXZlIGEg
a2VybmVsIHBhcmFtZXRlciB0byBkaXNhYmxlIGRlbGF5aW5nIA0KUlQgdGhyZWFkcyBpbiBnZW5l
cmFsLCB3aGVuIGdyYW50aW5nIGV4dHJhIHRpbWUgdG8gdGhlIHJ1bm5pbmcgdGFzay4NCg0KVGhh
bmtzLA0KLVByYWthc2gNCg0KPiANCj4+PiArIHJldHVybiB0cnVlOw0KPj4+ICsgfQ0KPj4+ICsg
cmV0dXJuIGZhbHNlOw0KPj4gDQo+IA0KPiDigKYNCj4gDQo+PiBUaGFua3MsDQo+PiANCj4+ICAg
ICAgICB0Z2x4DQo+IA0KPiBTZWJhc3RpYW4NCg0K

