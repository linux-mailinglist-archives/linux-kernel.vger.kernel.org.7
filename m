Return-Path: <linux-kernel+bounces-758691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75138B1D2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803B05810F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6342236F4;
	Thu,  7 Aug 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aesW+0Vu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TEq+iId5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1751C862D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754549590; cv=fail; b=Rx23I2+Drwdyswo++knTaB92jbO7JvYD/Gwusg4H6cXA0c2RDHGxQpb7OKthN0XlEPY3GEh3ymluKI1cPrQ+l6gkAmSshEpMNVowCTkxKdoKZIGIQ/avOrOJhemr/sJ9vZQwBF1pmXCi/RFMcTzAFkJu7JACRaUZzlSKXEKOtIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754549590; c=relaxed/simple;
	bh=n1vSuySv/8DTDMLojWuWCRJ79b5YbMeXk+/R7EunkJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lmx+XmOwgfBwqEg5lmRd7l8s3MqNycQvo/C1dtBjBGI4Yu9XpwGTbDSnIt8diCS7myvSUPTtGNT14jq9tmXhOy5HeIIWnaMWAVUUKhQoDQcd8t3Y48+1ReLFkQ2a0WL5zfTRb5DkU3RPziObQib/mz4H5X7omK20GpC7J6zbJyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aesW+0Vu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TEq+iId5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5774Rnlu010761;
	Thu, 7 Aug 2025 06:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n1vSuySv/8DTDMLojWuWCRJ79b5YbMeXk+/R7EunkJM=; b=
	aesW+0VuYQPLlVP7+YlwVDm02yhKid+btxpSM/wJaMIf0kpyd4/zvDerz39jIl/P
	yNoQdhDPkA5qAy9JotVszwKFCvyJhr2et3qeKSArlF9Pp+ddgCknI9y1wwyXGL8i
	z2vlcaKOupuLTAJqklwHvXiCO/aViRgBAvvbYPmGNVH2W2n95nBUwLitzzDccE5W
	Ek/4kGYuNi0G87u/6xMzt0pW9pi5fiLbJ0AOpDhg9YjTUWRnyZwKLUQdjJYGyyJP
	D+Vm9ska73I5UtqMeslYewkp7frxwIV0cHyB0kAL4wPMXwsrjAIInbn3H2YnES27
	2jl+WeQ7Pfhs0cNEkil64w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvd3fjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 06:52:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57756EEG018330;
	Thu, 7 Aug 2025 06:52:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpws22d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 06:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAaqOMVz00AflqKHQTE1VE9f+vNpPfCjkKIsd+kdFUT1tHp7fy9Q1PpFLic5vyWQ7gLCs03bHMG6p/T7L7nUYOd7V7Xp8+2bKVAnITVoHsdFMcVTqwq6OBrz4NvYMXQwSTIxRgPZcpjZND4ooaLTuUj6KIzMa6zEKSRvQ5frlWqe6UH+uWGNgfOUVZ1tfaKJCLGgfD+Ywmzp3QWiKqHo5lBp9tlSAvsjCXxId1d3nQWziDrZc90p+hASlqIDz8CHMMWL2qpPWaFCYJKV3YshyTLjeHMfc89oAdcLLojUcvFgdQLaQLPNue4JPNbgd75J48KlUsrJYRTFE1vABSEL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1vSuySv/8DTDMLojWuWCRJ79b5YbMeXk+/R7EunkJM=;
 b=snVRNzvQ6yidJCBS4TpYo+dhyNmYqO/aWnHrS8xFV6riD2KxIVg+kTdEyahxc7HbKD4Uq+1tyz69DlQut5NERdjDgnaUgQWr3CLLsEVfn+8Ws8MNEGrxHFWUM531EpCo42+sdvp3fiCozPF/br6TmBfs86AxGc0oOlBIoVCUjTaTS/jEEZkeBGch4XIz2eRS5SyG1F+rKaXuJ6e/4tBJpJwaNMz4ZPx+hjtEz6/qaCcLTJcZag/s6J9yj00I5SuSFXvNkcEHlhzQIw1R7nBszkwb2a+sU5zfn832V4k3SSH1nEfcFtV1+NspMbcu2QrO/3yNgpPmiyVw+D64E2eSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1vSuySv/8DTDMLojWuWCRJ79b5YbMeXk+/R7EunkJM=;
 b=TEq+iId5uzutXRsN80dBe/rf42UBpuKZGNHsaOlaSHHXCLfu0qirqInL77hCay9ACQYglFkQ1BP7R5nKDoVc8w6P823BMlg1hu1pPwPayUHGGTp+jNtzeUh76M1rcKzZNkuxU0fJ4aPqVA2ykA3AEGuNSo/UY8t4+b/pcNrR3dg=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ5PPF7E749FEBA.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 06:52:25 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 06:52:25 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 00/11] Scheduler time slice extension
Thread-Topic: [PATCH V7 00/11] Scheduler time slice extension
Thread-Index: AQHb/LZQkHUaM1iND0iVmRxxwK9ebLRV5WwAgADwxAA=
Date: Thu, 7 Aug 2025 06:52:24 +0000
Message-ID: <AAB4A5F9-D334-4C5D-9A7A-8BD7F018FF7B@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <87tt2kct09.ffs@tglx>
In-Reply-To: <87tt2kct09.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ5PPF7E749FEBA:EE_
x-ms-office365-filtering-correlation-id: 2747cec0-d670-47f1-6072-08ddd57ef77b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3JaYm10U0txWE01clVQL01EcXZNTzZGV3ZQRHdqU2FpNGoyUytJM1hsWlZI?=
 =?utf-8?B?QWlTZGhDanZ4ZDVLd3hRSlVrT2xJL2VNYUtuS1RjaEZsWHpOU1NZY1p5MFF5?=
 =?utf-8?B?SEEvYzdNdFVoLzZQZGQ1bjlHWlJHbHpENXlRYlJ1QzE4UUdBL2VXVHR3UTBR?=
 =?utf-8?B?ZWF2alNWSDhONi9CeVFKTmo4UzNmUVVTSmNzZnFiRFJkeW9vKzUxUkZpeW1p?=
 =?utf-8?B?SU9Sa3pNM1JhTXBGMFhlNDh0VjBrUXpxWmVpbFU3cERTWnZCdlo5eXhYbG1Y?=
 =?utf-8?B?SzNlbTd6WnhrTVBwRlh0TjREVzl3dlpmNUI2NndoZzd5a3AvclFiaHlubi80?=
 =?utf-8?B?VGhxSGdUbUI0ZllzT2hER0lHMnZ2Q2FaeEE4QW9BbWVOcml3SXJRY21HRERJ?=
 =?utf-8?B?bkRiNjhMbE4yaWlYZDR1bnh1Y0J2Q2p3am1oR1lVMGN2VjFUcWRIazZNTU15?=
 =?utf-8?B?Q2RqWGNYOU1YM054bENJZDlHVjBJUHdvZnJ6WkpzajkrUDlTTU5LRWNzVmFR?=
 =?utf-8?B?R2pEWVRzcmpjZTJudW1RVlZTTVpEQUJwUCtONGxieGoxS3pEcVdTQ0ZXZSsz?=
 =?utf-8?B?aXZRNm13TFpHU25rdi9SMmpSbmNwSkJHNHVPZkNEMU9ETEdVTTZVWDlBNkkz?=
 =?utf-8?B?aGNIVVN6TUNrbkdSaEkxQVdxSjRQTWxRTUN5NXhqWHhETmdXNVF2VnlNMFpQ?=
 =?utf-8?B?Sk11OC9pNzYwMkFzZ2FPamdsWmd6MVhNbnAxMk1CWWU0c011YXhrckF0T1Vx?=
 =?utf-8?B?Z2cwWkhJUmZLempXaHowTy92VVUveHI5M1lRWExUbEppK0NkamptaGQxNkk1?=
 =?utf-8?B?ZTJ6WVVQS1lzM3lLaXRYVDB6VFJualBKTmRPZnptNklONDRuRmpnOUdFam1n?=
 =?utf-8?B?MzZXSE90NVdDWWsxbW5ZcU42OVdhbFlnYzBZRjVwVnBUQXhPL2I4WDVxeGZL?=
 =?utf-8?B?ZlRsc1pyTGhOZFI4MTdpOTAzcEVkdUNmR1I4Mk1QT0s3VnRlRXZuN0hsckZG?=
 =?utf-8?B?cEFwWUJERGVrYWlmZmNJNUNCZzh5V1R5S1ZiL09SSVlOSVNLaW1PMlF1Qklr?=
 =?utf-8?B?VGN1b0w3bCtXU2pFbnIxUkdEd3BwbnNURU5hZzBOUC9WZmZkaytHbjkxWllL?=
 =?utf-8?B?T1J2bEhDQzdWdEhzajc1cnR6bmJpbzdINyt5azBDOXhJekN6bVpYQzBOZks5?=
 =?utf-8?B?ZkdSUWc1aENRc2N2TmJEZENEcWdHWnJpN211OUdraFdtTWh6L0RjbW96bnYx?=
 =?utf-8?B?R3JpVmNsSlE1SkhGS05QNm43RFVqaGVLa3pwRFJQaEFPWEdjend6M09DSzAv?=
 =?utf-8?B?anJzb1RPd3BNV2FFVXRFMDZDUmFYekgyU3J1VFV2SEgyL1B3ajV4dTk5dHpF?=
 =?utf-8?B?M2NHMVpTMUU2SXpuTjBQWlM5YkltSnlyWTY5WW8vY0Y0ZVk2NVpkZVBvbXhB?=
 =?utf-8?B?QURJWnJHQlZUZUY4Z3hLVytkNmZQUkRKUzNpRHdqSXVPUFdOUFR4UVNHVVFw?=
 =?utf-8?B?ODVWc1Rzc0E0L3EvQzYraG1oZEhGOTAvYVpRd1VpWFh6OXhDblZmYUowVXd1?=
 =?utf-8?B?THlzT3EzVVFwMnRpT1VaQjNydXNJbGgyOVZmM3MxdDU2aWl0dEFwZ0g1RGVH?=
 =?utf-8?B?eW9JUVlaUFlmV0pNSG5RK1F3bkI3RFJJbm9adm9VMjZUY0RmOStlZ2p5M1ZK?=
 =?utf-8?B?bFU4TnRTQy81aG5JQ09LeStXR1BOOXJMNEYzNFdyS0lpZnhhSVJCN1MydEVS?=
 =?utf-8?B?RlM0eEJjV096Ky9uZ29LRUF0cUQra3VjVm5MdVhPYkd6RU5INjRmcGkrTnIz?=
 =?utf-8?B?bGdJa0g4ZG8vd0NZeWg4elBlZFdydU0rZzZ4blhwelNwSllvTDV5cWdYck4x?=
 =?utf-8?B?dVJ1TmNZNlNDb3ZhYkNpQ1hzTjNpc1Q2aEhRVXhBOWNWZkdEdlNBTkJxMlBZ?=
 =?utf-8?B?ZEl2T3I0ejd3blJ0MGJaeEd6WHR5QTJ2dXVsdllZdEJvazV4L0RjT1A0VFhO?=
 =?utf-8?B?K01JaHUwMWxBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnFPMWpkR0tzY0ZFUG1pSzRaaUUrdUJTN1Ezek1jQ0FBdG5HNTZ1U0ptSHhI?=
 =?utf-8?B?U05CNm1uM0FFM0VKMUo2bC9PRVdGSFk5RWJ0U2Y1UFNrUEFTOEtBVTZLZ1JL?=
 =?utf-8?B?WHhtTUhrZlRPbUNTWmJEL1l6blVWYVVqTWU5bkRYM1dOanY0cTI1elloSzhI?=
 =?utf-8?B?TThQOEo5ZlRSS0E2dmlTUVZva08xSTlCUTFCbFQ4QlF4a1hxZHpBSDNqblo2?=
 =?utf-8?B?Qm9VT2RrNDg2anpWK0h0WXJIejhudi91M0Y0NmVKd0FlQmJrZHpVNExEbVM2?=
 =?utf-8?B?ak9VbndDRW9tcjFsdDZuNVNSdXpWVml5MWRLV1lWRFc5TlNiaW5sdVFQUms1?=
 =?utf-8?B?T0JZaWZuWnV4d3lDZ29QSXViZTZVY04rUHh3bUc5QkkrOEFIdXlTaDdDNVpS?=
 =?utf-8?B?V0RuRjc2MkhTRG5mcE92NzBQZlFlbjRJMVlKbUhSL3RLSjBVYWtza3F1VStj?=
 =?utf-8?B?TlRXZk1oUGw5N0R2TTNnOEprRUhpT2hFTmlNSWwrS0N0cWkxdzc2VWlmL2JZ?=
 =?utf-8?B?R3VSMGwxVEQ0Uk1iT0RkNFFhYTZNTzNTdFQvUmNhMXlqY2pacU1BZVgxMkhW?=
 =?utf-8?B?SzVyVGp4eGh0dWNHSVFNaVhYMUpZcDJtR1l0dzhqOExTcUswTTQraWJRR3hZ?=
 =?utf-8?B?NkJjc2h0eGJYamUwVkZYZzFLaDN5b0MyVFhYcXgwZ052cXVhOVZSeDdxWWZB?=
 =?utf-8?B?aXVMbGxQQm9zZnpuVy9GLzdnWTJidnBjZGJlREE1bXMxamFSbjB0cWQ1N1Vl?=
 =?utf-8?B?eVFOclg1ZEpWVWhkSkNKdVdURjBjODRuL255NG84Mm13bkZnaXR4T25iREZr?=
 =?utf-8?B?bnZqV01hUWxyOTAwN3VSZmREUHN6SVNUSmpMZTViZVEyNk91cTVML1UyUFMy?=
 =?utf-8?B?Z1BlSUxkakJLeE1EbE1xZHBGV2VCVHlmV0pORzNVajV4UjB1VWdDbHhCM3JH?=
 =?utf-8?B?QXRBVURTOVNQdUlReElCVHJkc29TWGhHYjI5WEdkSXFOUW9RT0pQZFdiWUlK?=
 =?utf-8?B?NGxPT3ZiamNaMlp5UXQwRklranBlSzAvZXFQUFQrbGplanBnMkRoS2EySmNX?=
 =?utf-8?B?RTYwOVJpN2ZXaFpkSTg1WFlJTWZkS0ZBNXlzZUJkMlFSeWZ5TWVMaDU1SVFW?=
 =?utf-8?B?ajZDTXlEaWZQYXltMjhmaVBmZkxVU05zN1MyblJLVmNhWjNSL1dwWDBLNFJE?=
 =?utf-8?B?cWExSnh5dW11MitxSWJJa1UxOWRGMkVNYlhDbTN1Y2lXOUQrNUpJMWx0UFFj?=
 =?utf-8?B?Ty9sWGV6bHFnYTh4cjdYbEtqL0VDdmpZTWVZd2hmeWRqb3JlbERlRVJLanZW?=
 =?utf-8?B?aXRLdGZPNHVaVlo0Ym9kSVNDc2RHc21KTXQvREllelpKdFo0dkZxRnVZU3lv?=
 =?utf-8?B?cXZCcXlXR3doZzJ1SWJGZTB4eHVnajZ1SnlteW9mVlY2MVIxSnNTSHVoSGZ2?=
 =?utf-8?B?S2tpd2NVM1owdWcxUk5TTWtCSUFSdTNzNDczbXhpYTd6MTNBMzF3S0R4Q3Jh?=
 =?utf-8?B?a3QzV01XQklVeGVMN0xjcElBK3I3NUhJSGdIYWNrZERWQjFEdTRxLzZVYnBk?=
 =?utf-8?B?SjJDTjhaTVU4cllRRzBjZVk4cW9qWGppdEVGcktWbitjRVloOEpjQXVabFV6?=
 =?utf-8?B?bm45Nnk2WEZkQkpNeGNQWnZtcXp1aFg5UEVhcy81N3NPeHRqSjVBU3pnODVY?=
 =?utf-8?B?VjhOUnBZczdSV28wRVVJSWgvMzdEYXpyZmkxWlR4WUFDWXNPREN4Zm8zTUxZ?=
 =?utf-8?B?aUVxTGt0Ty9WSzhUc3NhUjd2UlVCQ04zMTdmNjJmR0VDb1ZGVnIybmtXenVW?=
 =?utf-8?B?WmsyU000SGJmOEpBUGJSelUxLzluNjk5bVNBQmx0NU5CdldLMkRNMW5yQVQw?=
 =?utf-8?B?QkVTd1p4WUc3RlNpT1ZoYW5OWTZkY1BJbDNWRXB0OGtIR3JYOHRScDY5VGlQ?=
 =?utf-8?B?eG1tcFJDMWp6bjYwTUVZRlZodjlNajBJaFJ3aENzV1hxcWRSVlZPNWVPUHcv?=
 =?utf-8?B?d2VyZlNreUVzMTg2VnNpRldINk03Q2ZjaVlEbUtYcFRNQVZDUjlLY2Nwblpa?=
 =?utf-8?B?RWZWNmhFQzlDYVVLUkhBZStBalYvQ1B2Y2F1TlNFdWw0RytBQlNrQ203c3hY?=
 =?utf-8?B?TlgwS2FCTEpVTTB2M05ha0VhSUVRV2poREgrYjhYdC9BSlc5U1M0OHZzck9J?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3048EC80CF719B46B5F4EAF14BA00229@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VGZWtHToMjQ7aoii3YSszcFDvXeewrhU4juyREggMRLp2ic7vnHjkvSgDlrHyxcD6Ibune6JAT67Em/BJP4KOKVOrTFSJTXe2YelDxNccqvh+sRrU+kkiU2rlQBJ0xPAsNDRdT1b5AfVpuNpiYVQNdIBWbygnz4KHG55XXCccaP3r2mFIa52rK01cnaZLABR5fyKlBupPtbh4v//C+5uP/Xdmf4WGF10vkwZIx8us7k/5yPdVrbbfB02yfwPRnw1KO3SAsa4NqjGWh8xO+x57vJ3q71PZ/+ZBX5ebC6FGJ1UpZFwP9Bo9I2RfuBQ4xyQi1qhvE/Rxg6EDtblz/1o9m8eTvs7H9M4VLo9vgeQQ07INHhqetoCm8UixVPJW7lqixLVVJ4I6wFmtYP92tKWERsgKQ+jlmW/LKVYPEr8rD9tymb2LLNqMb5YqAScSEVXL9j6brfitZ7BUV6jAyIcHUPgOUvZbILB11WIZZmufKUOUOyGsmvuguofdk6nEashF4w1DCIgxdZqhM2rgVw87WxsIa8pPp9pRrKRV2A/Gj5YF3X4UNSfmHPbN/OH9/DwULMyrwYb4oWAazkiahrMXIapJASGmkeMzMTey5SgFHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2747cec0-d670-47f1-6072-08ddd57ef77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 06:52:25.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwnfeTjCZVc+5KSsM6CsLlqF/1JBIUJAqMT44x6zEnwnT3AMRLIIqi2EzNRBViqHCWrDgkv7TkZWXWvArlIJVFTCjFHuP/wr5cqMbSUMBTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7E749FEBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070051
X-Authority-Analysis: v=2.4 cv=fYaty1QF c=1 sm=1 tr=0 ts=68944d2d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=o3g13299q7KXgLdiJV4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: kC5QBwqNeS5LrhBGB-YVLmamr6QwJRPU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA1MiBTYWx0ZWRfX/OpjbE6aemy5
 QoOmwDiXluDkdmGSRPHRCRFeCUo2x9PIUEuVwq+6WdkA0LpGYWXYxSrMmTXkIKE1P/bxCDhfq5u
 DBEmJU1CIWAfOVemG2WMlQmPwDTC6Ck/wB27UiCwwvY2t5WESh+05zdtouQIpY+ypd72yn6U92n
 4QLuArAegVcP/8gBRqMJYmLyU9tTFnUT9O75oFM3bKmrA73vxWl6O+fMBYHpkbZt4H9rvSdnSdC
 yHNgQtVWeDNVP1Wree42/1WQSBhgfRsZTpSnj33cYHM6iRmBLI1frOKjkkMUdf8qALdWX+3BFX5
 Gl0VRBpv1g+CbdxL+CJYHvHG/iJn9vp83NPztYZU4+it74aFYXlDy0gQgF/I+S28Wli4gbzsTyv
 bBzmRXLOAL2J3GreY2KSgN4JaqoCeO6ECfbmFqu/QIBLUqSaZ2+eR9ZWYJCqRMHUHwU4hiQB
X-Proofpoint-GUID: kC5QBwqNeS5LrhBGB-YVLmamr6QwJRPU

DQoNCj4gT24gQXVnIDYsIDIwMjUsIGF0IDk6MzDigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjQgMjAyNSBhdCAxNjox
NiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+IEJhc2VkIG9uIHY2LjE2LXJjMy4NCj4gDQo+
IFRoaXMgaXMgdXNlbGVzcy4gQXQgdGhlIHBvaW50IG9mIHBvc3RpbmcsIGEgbWFzc2l2ZSBhbW91
bnQgb2YgY2hhbmdlcw0KPiBoYWQgYmVlbiBxdWV1ZWQgZm9yIHRoZSA2LjE3IG1lcmdlIHdpbmRv
dy4gU28gd2h5IGNhbid0IHlvdSBzdWJtaXQNCj4gYWdhaW5zdCB0aGUgcmVsZXZhbnQgdHJlZSAo
dGlwKSBhcyBhc2tlZCBmb3IgaW4gRG9jdW1lbnRhdGlvbj8NCj4gDQo+IEknbSBnb2luZyB0byBs
b29rIGF0IGl0IGZyb20gYSBjb25jZXB0dWFsIGxldmVsIG5ldmVydGhlbGVzcyB0byBzcGFyZQ0K
PiB5b3UgdGhlIGV4dHJhIHJvdW5kLg0KDQpUaGFua3MsDQotUHJha2FzaC4=

