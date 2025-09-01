Return-Path: <linux-kernel+bounces-795219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40660B3EE70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BF620082F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C1C2FB;
	Mon,  1 Sep 2025 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Er7CzXhL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DmfZw8Ql"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC572405ED
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755095; cv=fail; b=CH2cuJAUQcQMRRcqYuw7X2FkNHm5qEZI3PhoBub+XqS6faTrGBbCO+AbNtQS0laLLYM2WZl8ZFJyMK9yaeMLKBEX8Fb4ZdHRdpKBbVawbj/MNeuK2Kw9KFezgHFO/rVZS5m5hs+5aBnUdlLwFPa0sYwLgskkq8Y/jA0aQF8phmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755095; c=relaxed/simple;
	bh=3/z3+7Jz5HQjKATlOWXu2odbN7+PT7NX6Mosx3VMLQA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1jIdvUxrJMyTcTuQmwincl3xmxz7HsWdffAUT3PMp2cKhu2glGjV0MG4nxMakZoKeWkOjNRse/xnW1UrCqGK/qLyD2DWybhHRO3AzqZdTNC4Tt7tMthv7H7dYBaSjskOxmXuadV6Dxcjblno3ZyMrSyI4iZqKx/GFHS0p4I8Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Er7CzXhL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DmfZw8Ql; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581FNSlK022222;
	Mon, 1 Sep 2025 19:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3/z3+7Jz5HQjKATlOWXu2odbN7+PT7NX6Mosx3VMLQA=; b=
	Er7CzXhLncALnIdJyVy21+rdvQ1aNKzdnd4OTVyWlsNW90jv3GTFGAhSXxKTQdaJ
	V0lauXsggy3lcVutzWCaPq0vmOcrUfxwyMmahDVZjWqGY2yQE6KnRuJrO1Oia6AL
	Bpb0qORv0qPxG8dPS8LmUcDmi4zcd4lbwMUUWnZQOkJlDz5idZ/kvs5hF6+e4pt8
	VznQwtvoZzSYQAL4Un0irhbGLzXG0d3XK0bg91T2aqV4gevH2YusAJqKVNz+hrrx
	/cTXdoHFPi0WAdo0AgugrWNPpsDMIJQZs7gLTMDhIjMronNbDvAOad6wCUd0cJnt
	jf+SJ6bfAgE7JMrGXeMrUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgtu3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 19:30:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581I08W6028695;
	Mon, 1 Sep 2025 19:30:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8d8un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 19:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCXcKCWroAkpb5hhoXnnWKdpEPs0JTg1uiRrSTF2UlzWuZlYkZS7E2Y/n4VT4T9dIticx8beTMALT1T4IFpSD4xo253czo2posopAmgJmBEKPhh0tmH9N6ShoGdx5PCDaYXt5CdK25A2Uk//RQXZz8X8lN/luY1WkfNWYZ8E71mfqNoKBrq947/Uemii0nLDAUitxsjT5dgxoiXzo5wmkKh/03MYCwTWC4j5RY0HtRKV06REMrzlXvdOTho9feUjXlJrgtDMJg43yXxS3kAUwcM0ZeEfBm4pkkSBviWlYOk64/A8S37/aw/orvDSf8rZH5ZM5DsrlKZJeOtwtwjsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/z3+7Jz5HQjKATlOWXu2odbN7+PT7NX6Mosx3VMLQA=;
 b=N/6ymSmy5XAKqwy0l0QsmbNNAiTtr9Ebs+SQ2VzB2HCNFaoaBIose5WdIhISxlqutGEg3TMMo+skf5nwH0fkmj5Rk78JcfL3klCKSZRUQHPGyYrRJZhK0bF3jTYZGx53L+RmHK6dDuWpyiow6ewB1IZj4ZmI7yqd1bAOEUqttL1CIfYmUohtPlHOCDGG6MC/yeEjB2jsWRC6lECo5Hk1r+pInmOGRFkYqOVtenR35GafQOeW6yKe9UtEoZl0zbO/XW/Qv2icshmwgJlh/B4hddZZ2yZuBy7NKvzendjoGHG1sjpOjhAbNC0Xh/rAdUFEQ5a8YclCU9AIhW2G2MwG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/z3+7Jz5HQjKATlOWXu2odbN7+PT7NX6Mosx3VMLQA=;
 b=DmfZw8QlXSHnRThYCBuBlvQHqBSD1xwH5GiRYIyePmy2dJL2+7FU0X7t+4AbCDidzK6QgiLwEjtcvy6nuD3mN+CSs0hT+PqfScLAr6xadW+D7Gpps6y2vpZW+v61oTkaZwntBI3knLV0mNZ/c6404p7eCUBRO98W4dbedwYOdfo=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by IA0PR10MB7182.namprd10.prod.outlook.com (2603:10b6:208:403::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 19:30:42 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 19:30:42 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Florian Weimer <fweimer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        Michael
 Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul
 E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Wei Liu
	<wei.liu@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Samuel
 Thibault <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
Thread-Topic: BUG: rseq selftests and librseq vs. glibc fail
Thread-Index: AQHcGRT6xxcx/EnjgESs64c8pjMFrbR5+YgAgATCEIA=
Date: Mon, 1 Sep 2025 19:30:42 +0000
Message-ID: <B2B42839-864B-4146-A378-1CC3D15160E1@oracle.com>
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <F9DBABAD-ABF0-49AA-9A38-BD4D2BE78B94@oracle.com>
 <9fd284e6-f3aa-456b-b91d-44d4ff5c55b1@efficios.com>
In-Reply-To: <9fd284e6-f3aa-456b-b91d-44d4ff5c55b1@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|IA0PR10MB7182:EE_
x-ms-office365-filtering-correlation-id: a506bade-8c07-4423-0f83-08dde98e0a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODQ3SDY2UFAxakY0T043SlNkR09pYmRHZWJ4MzcvbFl0dkVtdGl4M3dLRTla?=
 =?utf-8?B?QWFvTVJQYUhIM1VlL3QxWnBMRWJFb2lvYWYxNUh2Z3UxVHBRZ2lvSmdnY3p1?=
 =?utf-8?B?c1h6eWtFaHhzZkZzYVJBTXJKajFSL0MzSSt4RGlTUVdzZmFpTlEwc2ZFMGFk?=
 =?utf-8?B?YWdPZFpnKy9SRXEwNnNoODkrZXh4dVltRVVtVVFwSFl6Y2U0NzRWRFNSYTN5?=
 =?utf-8?B?N0Z6YytBUTdZeEViNG5SVStaTGdaTjROU3ZJY3ZxUUJ3OWFMa3J1Rk1JTVow?=
 =?utf-8?B?RDk2bE9ma05GVzd4eFlSUndrbWFiSXhOMUlhSmVFTCsxM2h1NHFRaTMvYUdR?=
 =?utf-8?B?QUhkWjV1OERqT3ZUSDVOLzhmQ3dPYXpmSnNwY2VHdlg3MzViaDZEM2dvSHRw?=
 =?utf-8?B?Z2ZHc0crOFVSWXlLZUcyUUJLSkdVclZITFl3KzF0VmRWVXA5Vi82NlV4Vy81?=
 =?utf-8?B?LzZIUWFkM0oxUFFUMDlQdllDckRHV08rUXVGcTdQcWE4MW1hMlEyUUVGTTVJ?=
 =?utf-8?B?OUhYZENGUVd2d1RHUDhESXNxbXRtZ29PR0lmank1NE82UzJqM1k2TFFQM2VY?=
 =?utf-8?B?aUk2elJPVkI1Z0JnU2ZFY2ZTOXg0eWZ5YUJMS3c2OWl3Um1FSVB4aXRUUktz?=
 =?utf-8?B?NXpYYTExaUplc3BQWFRVN2JKODNvbXVZMStDUW5aR3F0ZU1DY0l1MmZWUTdC?=
 =?utf-8?B?WFNxRlpSWGkvTHpHcVR5SmM1Y0ZhN29HTGpka01HL1hBU1JhdmJwOGcwTUc3?=
 =?utf-8?B?M2svSTU3dkdyeFFUejkvOTFWRVlRMDZiMEVUeW5naHNGUkZXSktjUzU0NHdF?=
 =?utf-8?B?Y1NnVFY4Tm5HdDNQcU1MWWcwc0I0OFpJbGpPUTBjdC9SdVhpN3JUclhvckU2?=
 =?utf-8?B?MC9vSGJMdUJHRG5YRDQ2WXVrVk0vcTE0UVcxTnhXdHFmSjdiaTVTVU44aGpn?=
 =?utf-8?B?Y0x4REg1MTkvcHV6aC9tb2M1S2p4VEVWL21NcWR1L1QvUVQzWW5wdmNaTXBK?=
 =?utf-8?B?c213a04xQ2dWZXFNdkFKWm4vODM0L3B4bER0Y3BhS1JncHdTRVkrVTZCRkhp?=
 =?utf-8?B?aFB1ZFkxdWVDZDZkQXc1clFPSHhTeENZbzIxWEFtK1pXc0VYdWhuZWh5S3Fk?=
 =?utf-8?B?OUgyVWhXWUJLQlBXMzFpTnQ0QlE1cTNRUVh5VUNZUFFxTGUyMXZVTHBSQ205?=
 =?utf-8?B?MGx1dE9LaTFXbGlBWmRyMHJ2amNqMmdROXlQc29JWVRVUm54SzcvT2VVSFB2?=
 =?utf-8?B?V1plUCtJM2xKRGlGSkZIcGhrZDdUOGJadFNVeDZxSkFxUDlGNXRBVkhFVlln?=
 =?utf-8?B?dk9ubU91eTVnMzBRRkRBQ01ZWTJ0WjROYXd2SnpSckM1TmkxRWlwVnJkdnJu?=
 =?utf-8?B?dzdNTzVlTlF3ckZGZHdJRm1HTkJSd0RUNUtKU09YVzNmNkxvczVIWlpoMmQ1?=
 =?utf-8?B?WkRXd0tuTGJIaEFBdFVpS1J3UzFVbnp0VDhHTUxIWGYweVM2Y1RIYTJBWTRE?=
 =?utf-8?B?cGdpQzZnVW11ZzF5cVhkOUVKTjN6blkwd3B2MGljODlKTVJISUF1TEU2Z0po?=
 =?utf-8?B?V0xaZXBMMDBxcWxncG40cmY1am5sNWh1VmYzWVBjQlVyVnpCRFgweUZLMVZp?=
 =?utf-8?B?dEUxMWdQR3VKY0RBbzhieTlPN2NLa3JBSnJBbFRDL0tHZUI0UXhoSmk1by9x?=
 =?utf-8?B?TG9nUk45UGU0enJMdXA5U29uTTRpSlBPaWxISlRPYytXVGdYamJBYzI5a1dP?=
 =?utf-8?B?bmNrb29VbFgzSlg5c1NhVjVMYThocGVIUW9scmlZWFJHQU9odGZjaVZBcThB?=
 =?utf-8?B?b2lSVWJKUGF3dituK1k4QTlpS0hCOVh6dFErdGpTV0VWRVlQYVA3RlBGTTNu?=
 =?utf-8?B?cmt6cEFIQ2QwUGVSeG56eDJ3S3pyaU9GUy9XM1oxK2UrTnFvSDViSGZKeFI1?=
 =?utf-8?Q?tkhSBSCYtB4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnpwSmFUNEt1cXRPaVRPWlY3L0ZqSDQxOWxIeUFiVXRySFVuNG1henZQT2xQ?=
 =?utf-8?B?ZEttOG5BSkRqYnFxRVVhOEF4OXluYmZSaE9xejRjZStvVzVZdEtRVElhOGhk?=
 =?utf-8?B?Y1FibEtLdU10Um56YVozRVJYVDRJVFFuK3pWcDNnRU9uRTh1RlQzdEV5Z2tQ?=
 =?utf-8?B?Rk1XRTFHSW80UlZMVGpuWmppbnBPTjdGekZ1RDhrVGlwdG81LzZqcENZY2Ur?=
 =?utf-8?B?TnV5a3ZQbWFFZXBoREI3VFZkd2RuQXQxOHB4UVpPU2I1R2ZXVlBja0dLRFRv?=
 =?utf-8?B?eXdBY2xPMk5jMzFaSmZTZ2d3bUNWODNQSy9xMzMvMUtpd3BxNVQ3Qk16MkJu?=
 =?utf-8?B?RExvL1ZVTHI0a3FERDUxcTR4Z1EzTytrb1dHWHdHWVp2ZHEyZ1V0MEZaQkFR?=
 =?utf-8?B?U0EzcTJXTWhQK0RWWHBTTzRwVnAzTWFGRlVwRkRDT0c2ajQ2djhnS0dFOXFH?=
 =?utf-8?B?NVExdy84a1kvY3g0N1hUT2dJUmNpUFQxdU5acHZlK1lxZmhWM2V1MVFpUWZL?=
 =?utf-8?B?aC9UZzAxVm1ZTmIyTWRnM3lPR2ExZHByMWdRdHljSW9OZDA1Yk5tSGdsM2xz?=
 =?utf-8?B?RkdsSWJmRHZKQk1vOXJNWXptNlo3YnpIekRVOHJCeFFHUUIreGpOeHQ3Ulln?=
 =?utf-8?B?eEpKMzNyaWFERzNKeis1a3lPdjlJQ3I4cEh6NktwMDN2SjE4dG5KTmNTTHNK?=
 =?utf-8?B?MlhwdUNCS2RuVlhnbE1rRVF0aENtWTY4U3dQaGU3OVpLQjhpV0NKNURQbHA4?=
 =?utf-8?B?dVdxS1RxVk93TW10WVVTTjN4cnJIbVRyRjhUenByRDVRN1FhREQ2a0NWWlFX?=
 =?utf-8?B?YkZDcW9lMkxzeHZxVlBhUEVIVmZUTzZRY0srYXNhczVaRnEwK00ydFF0dllD?=
 =?utf-8?B?MTM0ekhiVSt4THVBakVLeEd2L01vQlJheENLdXlkNG5BTVM1OWxvUmpWSm93?=
 =?utf-8?B?ZjFUV1dFcndXUmxSc2hWS2U3c1c5d2JsTDVqODdGU2x0RXFtcndjZjlEdTRP?=
 =?utf-8?B?T0NLZisyeXpoUVk4dFBlMGR3bzZJVHZVaXdkajZqeFFQSXl1YURBbUhIZ2JD?=
 =?utf-8?B?SVB4Q2lRdGQxc2dYdk00NlZRbmVPalo3bTlMUis3Uyt4MWZKcHl1clBwRVZ6?=
 =?utf-8?B?d0VCWjYvbmlhRW9SMW9SNmZBRERKTWRGb2xxUEFjRXZqV2JIdzlCS0tBLzIw?=
 =?utf-8?B?eitxQ1BhNDVmRDBwN3g2T2phdHlNRjlKS0ozdFRyc3hxMnBac1JOdUVBM0R3?=
 =?utf-8?B?Q1FWb1ZrZlBtWklxZENhRWNmakJOYStlZS9uSDdRL1dOQW1CWTVZRjNOUEN4?=
 =?utf-8?B?SktvUjN1QjQ2N1E5SWNUSktyb3VuUVhjcE1BbjE0UkIxSkYwUDhtRXFRTldi?=
 =?utf-8?B?b2hWZ2VxWTFyWVM2ZUdsS2UvZC9neUZ1RjAyY0xXMmlUT3I5Y1dtSnNiaUFC?=
 =?utf-8?B?d3l6QUMyUzRCeVBjalVKR1o5OUY5aG1SRm9kVjFYN0E0dXlReXdVM2JYeHYy?=
 =?utf-8?B?RnlIcWp0VWtXZVdiNzZrNG00dklqdjhta09rYnhFOGZGaGUxNFVEaEFpZjI5?=
 =?utf-8?B?SDlkZmJIMHF2bjlGQ1BUckVXSko3VzlpekdyUTEzZ1BXd2NvbFlBWVB1R3ZQ?=
 =?utf-8?B?Vk5hSFJqWW1WbkxTUm9keFJpNkkxcjc1YnFma0krRmt6QkNpR1pvYUR2QTVk?=
 =?utf-8?B?TWp2eTlmVDBOUDd0Rnp1aWlkeGx2dHpoUmMyeVZDRmplbDh5dmFoMy93WElH?=
 =?utf-8?B?ZlF2WHp4ZHNNV3RMbEc5YnRaU0MybmhmbDRGT21Yb2NxeW84S21YQjFEdmRO?=
 =?utf-8?B?MmRVZVZrTXdReThzanVOMlZiZG9nbmtYUkoxRytPZ2RlNTg3M08wVGp1ZzZk?=
 =?utf-8?B?bGYxNkVsdC9UWDdrK0l3ZDJhZDRPcm5Ja3BJYkk0OHYzUXUycHpBaUVORU9W?=
 =?utf-8?B?Z20zb2U2ZTJvTklranRBMG1iMVBhOFRwalR4ZkFFaUxWbDNFenhqUjVKbVNs?=
 =?utf-8?B?eDRpcDJER0srZzlFeHNLd0NyMjhCWEVIaGttdDU3S2swWmVsa0U4bUxNajJq?=
 =?utf-8?B?SDhhbVM2VDdlZ0tKTHdNQ2VscG40ZjNWYzFzZVc5RVU0eDFzODAyK0ptMmlG?=
 =?utf-8?B?YW5SRCtoMnh2V3dZUm1SdzAxREF2TFJhL3V5L2YzK0xzUzZmZUo1V2VBYUgx?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B075E4818663E48A41E9672888FDBF4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ckCed/0pywLMwlTU1lN4eufj1pruQxzmgoKZ/qYaqeQYZn+D5HVy9F64o3MNwFkVJfZDPQb7Is1BUutkQ+chJzKHNvSxGxSw5H2cFwMV5nvaICRPYWgvcPxojtTn9kSFbJ0xuSCfKlskp+zTYSLGh1fEdJVy+dhDdaGjAH0yRokpibReuQZ4W20iRXhAD/IqkBSgCoXsSWRqC/awtoW8loYXoi0+xR7uYDadahW/TFIwfLPukYaXoz3fuvqLWwOEJd3/SMWdErwoM1IR/4XGn3cUGAF4Z018yIp2jkzAFVda7jIic8NCMDx1OlrjTJvCmm9Zg717e6UD4BydllAGooEaXxWtLBgM+Z9ASFHb4KpOMSJ0nG0bP+apPggr9umJM8SBiBVV/YVcyA+x2V7LYG6GwDV/HfjdPpwUCvyeIKPuWQrrHlY4BWvOMDbIll2ajGSigkzTXMgcC/bPG/XRHiooA5+/PGssKSRr9zwMdDqjvU2uosaS/0KwayyNcnJQrx1PiKgbkLqbnRHXG0IYN/h+b1tNL0TZkoo8qWd+u89j3dy/wcGz12U2SKSB1m1Y8FdOTiCsGVomFJCemWz44aa/+B5cgeYdVo9qB5Ktcsc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a506bade-8c07-4423-0f83-08dde98e0a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 19:30:42.2052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnOgn1uzkeRZrK03s0HlghazjYKe5jbXUaYfsT0VwnNIIMICCyN1z1Yusff2StYH2Uen72x2xVngul7c/pB3IRCGEOrBOha90304Q3RnVTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010204
X-Proofpoint-ORIG-GUID: CQRfSl9_vgYfU6WGHRrShrdhoKW6AJzA
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b5f466 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=7d_E57ReAAAA:8 a=JtNTMLeaqTO4HBnjA9wA:9 a=QEXdDO2ut3YA:10
 a=jhqOcbufqs7Y1TYCrUUU:22 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/nYbCX5fxJ2J
 6RuZYBDzw4JUHGFHf6g6RwEE1lqVAsxPf4GQxL8ZoBliqbADnX7gRqreMc0Tb2sQKQWRFjSNppb
 d790Zz0hf60MvlENVJMARZYjaNrNu+8zSqnaEud1Gsn9Rcwm+0lsgDNaN02TRgOpimh/D/fSJTQ
 Slgqk8Vbc+9dJXEyY+XxGEhNZNqvA4gymyJXv4wZHblpAUEEcCXEsRy/eZxyF1puujPO8A3lEac
 k/ytEit0bvNURgULAmnaiLzy9WvPKH964YOC0uOWWD9KnnXte/ScBusmDfSZqCmitx7k+eJcOEe
 K0PodZTUNBfJbrRjvoeAUx0tv2ZBtbgBuDd6sjl1Ht4jzRtHVnad//WzszOegEQMtZ4nJ/Eab6j
 h8r5U8EuV092IQUxfw5gtgOD+ZBZcw==
X-Proofpoint-GUID: CQRfSl9_vgYfU6WGHRrShrdhoKW6AJzA

DQoNCj4gT24gQXVnIDI5LCAyMDI1LCBhdCAxMTo1MOKAr0FNLCBNYXRoaWV1IERlc25veWVycyA8
bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToNCj4gDQo+IE9uIDIwMjUtMDgt
MjkgMTQ6NDQsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gT24gQXVnIDE4LCAyMDI1LCBh
dCAxMDoxM+KAr0FNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4gd3JvdGU6
DQo+Pj4gDQo+Pj4gT24gTW9uLCBBdWcgMTggMjAyNSBhdCAxNjoxNSwgRmxvcmlhbiBXZWltZXIg
d3JvdGU6DQo+Pj4+ICogVGhvbWFzIEdsZWl4bmVyOg0KPj4+Pj4gSXQncyB0cml2aWFsIHRvIHJl
cHJvZHVjZS4gQWxsIGl0IG5lZWRzIGlzIHRvIGhhdmUgaW4gdGhlIHNvdXJjZToNCj4+Pj4+IA0K
Pj4+Pj4gX193ZWFrIHB0cmRpZmZfdCBfX3JzZXFfb2Zmc2V0Ow0KPj4+Pj4gDQo+Pj4+PiB3L28g
ZXZlbiBiZWluZyByZWZlcmVuY2VkIGFuZCBjcmVhdGluZyBhIHB0aHJlYWQuIFJlcHJvZHVjZXIg
YmVsb3cuDQo+Pj4+IA0KPj4+PiBXZWxsLCB0aGF0J3Mgc29ydCBvZiBleHBlY3RlZC4gIFlvdSBj
YW4ndCBkZWZpbmUgZ2xpYmMgc3ltYm9scyB0aGF0IGFyZQ0KPj4+PiBub3QgaW50ZW5kZWQgZm9y
IGludGVycG9zaXRpb24gYW5kIGV4cGVjdCB0aGluZ3MgdG8gd29yay4gIEl0J3Mga2luZCBvZg0K
Pj4+PiBsaWtlIHdyaXRpbmc6DQo+Pj4+IA0KPj4+PiBpbnQgX3J0bGRfZ2xvYmFsOw0KPj4+PiAN
Cj4+Pj4gVGhhdCdzIGdvaW5nIHRvIGZhaWwgcmF0aGVyIHNwZWN0YWN1bGFyeSwgdG9vLiAgV2Ug
bWFrZSBhbiBleGNlcHRpb24gZm9yDQo+Pj4+IHN5bWJvbHMgdGhhdCBhcmUgbm90IHJlc2VydmVk
ICh5b3UgY2FuIGJ1aWxkIGluIElTTyBDIG1vZGUgYW5kIGRlZmluZQ0KPj4+PiBvcGVuLCBjbG9z
ZSwgZXRjLiwgYXQgbGVhc3QgYXMgbG9uZyBhcyB5b3UgbGluayB0byBnbGliYyBvbmx5KS4gIEJ1
dA0KPj4+PiBfX3JzZXFfb2Zmc2V0IGlzIGEgcmVzZXJ2ZWQgbmFtZSwgc28gdGhhdCBpcyBub3Qg
YXBwbGljYWJsZSBoZXJlLg0KPj4+PiANCj4+Pj4gVGhlIHJlYWwgY2hhbmdlIGhlcmUgaXMgR0ND
IGNoYW5naW5nIGZyb20gLWZjb21tb24gKHdoaWNoIG1hZGUgYSBsb3Qgb2YNCj4+Pj4gdGhlc2Ug
dGhpbmdzIHdvcmsgaW4gdGhlIHBhc3QpIHRvIC1mbm8tY29tbW9uLg0KPj4+IA0KPj4+IFRoYW5r
cyBmb3IgdGhlIGV4cGxhbmF0aW9uIQ0KPj4+IA0KPj4+IFNvIHRoZSBvbmx5IHdheSB0byBtYWtl
IHRoaXMgYWN0dWFsbHkgd29yayBpcyB0byByZXZlcnQgdGhhdCBjb21taXQgYW5kDQo+Pj4gdGhl
IGZvbGtzIHdobyB3YW50IHRvIGxpbmsgdGhhdCBzdGF0aWNhbGx5IG5lZWQgdG8gY29tZSB1cCB3
aXRoOg0KPj4+IA0KPj4+ICNpZmRlZiBfQlVJTERfU1RBVElDQUxMWQ0KPj4+IGV4dGVybiAuLi4u
DQo+Pj4gDQo+Pj4gI2Vsc2UNCj4+PiAgICAgICAgcHRyID0gZGxzeW0oLi4uKTsNCj4+PiAjZW5k
aWYNCj4+PiANCj4+PiBvciBzb21ldGhpbmcgZGFmdCBsaWtlIHRoYXQuIEEgcHJvcGVyIGZ1bmN0
aW9uIGludGVyZmFjZSB3b3VsZCBhdm9pZCBhbGwNCj4+PiB0aGF0IG5vbnNlbnNlLCBidXQgd2Ug
Y2FuJ3QgaGF2ZSBuaWNlIHRoaW5ncyBvciBjYW4gd2U/DQo+PiBDb3VsZCB0aGUgcnNlcSgyKSBz
eXNjYWxsIGl0c2VsZiByZXR1cm4gdGhlIGFscmVhZHkgcmVnaXN0ZXJlZCByc2VxIHN0cnVjdHVy
ZSBhZGRyZXNzPw0KPj4gUGVyaGFwcyBhIG5ldyBmbGFnIGFyZ3VtZW50IHRvIHRoZSByc2VxKDIp
IHN5c2NhbGwgdG8gcXVlcnkgdGhlIHJlZ2lzdGVyZWQgcnNlcSBhZGRyZXNzDQo+PiBvciByZXR1
cm4gdGhlIGFkZHJlc3Mgb2YgdGhlIGFscmVhZHkgcmVnaXN0ZXJlZCByc2VxIHN0cnVjdHVyZSB3
aGVuIGl0IGZhaWxzIHRvIHJlZ2lzdGVyIGEgbmV3IG9uZS4NCj4+IEFwcGxpY2F0aW9uIGNhbiBj
YWxsIGl0IHdoZW4gdGhlIGNhbGwgdG8gcmVnaXN0ZXIgYSByc2VxIHN0cnVjdHVyZSBmYWlscy4N
Cj4gDQo+IFRoZXJlIGlzIGEgcHRyYWNlKDIpIFBUUkFDRV9HRVRfUlNFUV9DT05GSUdVUkFUSU9O
IHRvIGFjaGlldmUNCj4gc29tZXRoaW5nIHNpbWlsYXIuIEkgZG9uJ3Qga25vdyBpZiBhIGRlcGVu
ZGVuY3kgb24gcHRyYWNlIHdvdWxkDQo+IGJlIGFjY2VwdGFibGUgZm9yIHRoYXQgdXNlLWNhc2Ug
dGhvdWdoLg0KDQpDYW4gYSB0aHJlYWQgY2FsbCBwdHJhY2UoUFRSQUNFX0dFVF9SU0VRX0NPTkZJ
R1VSQVRJT04sLi4pIG9uIGl0c2VsZj8gDQoNCk1heSBiZSBzb21ldGhpbmcgc2ltaWxhciBjYW4g
YmUgYWRkZWQgdG8gcnNlcSgyKSAuDQoNClRoYW5rcywNCi1QcmFrYXNoLiANCg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gTWF0aGlldQ0KPiANCj4gDQo+IA0KPj4gLVByYWthc2gNCj4+PiANCj4+PiBU
aGFua3MsDQo+Pj4gDQo+Pj4gICAgICAgIHRnbHgNCj4+PiANCj4gDQo+IA0KPiAtLSANCj4gTWF0
aGlldSBEZXNub3llcnMNCj4gRWZmaWNpT1MgSW5jLg0KPiBodHRwczovL3d3dy5lZmZpY2lvcy5j
b20NCg0K

