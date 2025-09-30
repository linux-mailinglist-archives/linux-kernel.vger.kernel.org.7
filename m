Return-Path: <linux-kernel+bounces-837571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD2BACA3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71543C7F76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CD823D287;
	Tue, 30 Sep 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmSJ6fQn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CIqWt6cI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E162343C0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230602; cv=fail; b=InIEeWZNf/818o2OQjftnGJCT/JldJg+tWmsna982cj5JYgCYDl7zepam5rR4H0z6WqvLqVp4q+IKGj6Q08NrS07djWQftEvW+TWUYmIMyG7PV0whNF72kIPVylI5xsfveMeh9Ehd0c5jmTQugkjWt9kHCAWHTzBGATuvoIaugM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230602; c=relaxed/simple;
	bh=ggRmYURsPF2o0HlNajfjkLZihIW1yI8C7y00iDQ44cE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmPm9PRrnj3nX85M/uLBsWdVyNn4PvDQ/KeCLj9zKFODOM8noh1UJJ6obhinoHw21jMCxNJ8Xr8WpK8GhpeKXlQzDO3vhku5MQYVyQbKBrfeqpi0OZgpLwweVQhUji7/+FXWtRRUkNUvA5qIpj8FpXA/9Uz3Wt6MonZfvl9iNKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmSJ6fQn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CIqWt6cI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U9YqsR022297;
	Tue, 30 Sep 2025 11:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hcCFCHZiWvTi/p6xHJ
	MGZA3ylrOjP1jPF/JvLbXK8RI=; b=PmSJ6fQneQ2JHDq4Y/kafaXEaUx+ADbezU
	3bcDauwoCGS91tt1lMIn61ssvXOTK7GrbuLiyzIo0yWMsbpGLtg8Jy0jIqTRrRka
	CyfyuYtf932ZzOXQzihlDr2DeXl1AmBLa9CkfrL4/1M8CP3HR7ZIu/U9L7sGe53N
	s4FJFn2DxLL0buxSE+NePMv65QOe4VWHxqCJkpaxIwDQVUWMGuU+6KJTp3uKNIA5
	jNIvE3TtdfOLrLu/pbUfhTOOGX9uHBRja23xGxjWI0vz41eVI29y1cyNaZSsN4lG
	EYRG2EkQnO8M9PIqYCClPRUV3XX8Ja0rZ+firw6rtY00epCjiUcQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gcpm05av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:09:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58UA3LLw011745;
	Tue, 30 Sep 2025 11:09:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c866m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:09:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A48RZOflgtWfJGTWDQrSH/hv6YWQrq2SFwkQsbypIRJ7HTM2r5XBvmlwigRBYsP1FYzMeZmaJjWFckErCcJJZF10Xz0W9TSfu3l20oFpFHBCg9a8gydRiZhkjJRfXV7Km5x9C7JfaE0dMoQTsUzv276MhJFSvks5oBOGy5PGVy7JK6DEKvcjqtxrHB+XtOC2uHLCqrp9AWaLruPGNnoCGIEmnC280Rqp8QSmJFMwImv6teiFVHAtJp8oLrKeflfnjxfOkDRk+4mmyU+VEAgfYiqMBBMo3itQOUEd+xwUn3ywvDC60a+mYqXaBv72qHR9qpXpj66ARSiMSD7FUWrkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcCFCHZiWvTi/p6xHJMGZA3ylrOjP1jPF/JvLbXK8RI=;
 b=Pbmf4mSdr9coX/6CAIlJhOWnnLO6oyNBPSq7NRrVm6ZTZj6AFk0Owe+4xR+ieZ8dhA7AV8Uk0tjmwYom+1ASUDAcKtexKQwXxnRgMcNqg36fv0Qehj9xhk4PAzbfYfKEV4dryI26GXDeUlhu+uE4cMk+mG8Es4IAprWbAjeEUuPRfsznMiasU64iedLHr89fXdKfiLIUVcSrys7H5EmdrSKHzH6L9DP687g7lDMbyCgZ1DV2CkbNBknG+jnh2mHYspd+zh5UeoUg6MgQB+TZ2jwBgRVfAgovq8mZOMu7UQxfZjAepf5jpmOxRDXcDkdSztN8UgmtpzK+VWwHhMraYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcCFCHZiWvTi/p6xHJMGZA3ylrOjP1jPF/JvLbXK8RI=;
 b=CIqWt6cIHqLYs44IBEUptr6z3ac4ZyKPKOHJc5X72Q+WzoqVi2QvHrHMJ/vdNT49MNpCiRuIfCZkS6ZzCjxc3UjohY0U85BWaKRVN4vtsOjPCVCv/chkvWbLt1xMI3KDUAxI/A47njR8DRtD4AXb+NExaaLjBpRUx1Igcg7eGP0=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH8PR10MB6339.namprd10.prod.outlook.com (2603:10b6:510:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 11:09:50 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 11:09:50 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer can
 contain the reserved report ID
Thread-Topic: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Thread-Index: AQHcMfq9VYEMNtaRDUmDruBjTglyuw==
Date: Tue, 30 Sep 2025 11:09:50 +0000
Message-ID: <883ad6064549f85dc56b2669bc3f395191b3da9b.camel@oracle.com>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
	 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
	 <2025093000-shrank-vending-2bd1@gregkh>
	 <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
	 <2025093001-petted-boney-29c2@gregkh>
In-Reply-To: <2025093001-petted-boney-29c2@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|PH8PR10MB6339:EE_
x-ms-office365-filtering-correlation-id: efb35d52-7f72-4061-0639-08de0011dff4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7053199007|4053099003|4013099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N09FN3FmRTh1c2E4bzNlaFdxU1h0MFdueFZQQmgxYm5rTGp6dnRvb3RYd2xR?=
 =?utf-8?B?SjREYVhXbjRqL3ExOE1DTFNieWovaTBOTzVFbng1aGNtSTVpN2htaFhHWHd4?=
 =?utf-8?B?RlRsUDQ3dlBldjBFUTk4UEw5UkdxbVpmT1NWZ3gyT2RWWmJ1MjduQ1dXTVRC?=
 =?utf-8?B?bXZmMGxLMnlMTmRDYWRlM3pIY0JPN0NiejhlZWx6MngrdHVIdWxJWjA4VU90?=
 =?utf-8?B?UnJQTVhUZlJkVC9icWtXQi94UEtZWW15SzBaTUdvckExZ3JkSmsrTGNuQWlL?=
 =?utf-8?B?Y3ZGdDJsMVNVMzdWNFlUVXk0WEFRdUJIcTdFNHI2K1pvNFFDaVBrZTFLSjds?=
 =?utf-8?B?V3pOQXh2K3E5S3RySUdHT2NHSXZhK00wdTRyajhMczluK0xKQzh4RnU1YW1P?=
 =?utf-8?B?SUhCMWZsd2xZM3JKcFliYlNFVjdqNVZHTzl6ZXB1S2ozWm5ZUzhsRFpaTGND?=
 =?utf-8?B?bnZwODBZUXRVVmxZV1Q2NUp3SWJWMVM2ZDVSRUJvTVdQUGlwY3Y3eG9ybkZh?=
 =?utf-8?B?OWJQb2pHa1I1WHRQZjFnSUxBSjFXYU9HTGN2K1RGdGVoZzBjcCsxOXZCc1lC?=
 =?utf-8?B?S1JwK2FPdTRIcEdTVE9iOURyUkEwVEpmdUVxbWRCd2ZxOGtsajVHeDhNODZQ?=
 =?utf-8?B?amxxeXp2MWY0dmVyeExHYXFkVVovNXR2ZEVZa2Q3Q3BsT3JNZ013NkJSWW45?=
 =?utf-8?B?WmZLZ3NaaHpOYmI5bVdyWk9yNXkrZFNjMW9XMTBHMklpY3FYSkNMRFRjaytD?=
 =?utf-8?B?Z0dCVTdMeU1YU2ZkYzF0bDZDUHViNktCVmhORlJZMVhtRGhoZnVZS2NJSWlq?=
 =?utf-8?B?cG8zS3dXcTlQdjdxTWZsRE53M05ocGJEVWNDU0JJMUg1VlRpN09KK0N2Z1NV?=
 =?utf-8?B?M2lzekhiV1FOQmdxdXlsQmMvcGYvQ2JBaEVVWkJlUEhiaTJWRmZMRFhtT01Z?=
 =?utf-8?B?L2VUVTJuYm5uK2dOZ0t5S1QvRUdibmh1Z3N1K0pSRk1yVS8wclJSb1Bzck05?=
 =?utf-8?B?ZVoyN2J2VHBYckVOcWpCSWxzL1ZGT3JLdDdJTEswek9NWHZkRWJlL253bXBL?=
 =?utf-8?B?L2k1VFZ3bkpWL3Rwc1NNMTZ1bks3Y1pxWCtGbkt4UEk0MkNiS2w0dFNuenFY?=
 =?utf-8?B?VUE3SGQ3VEdrWk42WjVGOHBhdWVsSDFJZzc1eXpZemRucVZja2tWeDBsYXcx?=
 =?utf-8?B?TUhOa2pyaFJyK2lRWjVRbDJBTWw3SVlFY2hpRlUxT2tHcElOQzlCSjhwVS9S?=
 =?utf-8?B?aW5ydFZweGhESEgyeWRxQWpWcVoxTDcyS0tpVVdRNUZ2WEkrSG9DWGtFVkFm?=
 =?utf-8?B?dUhDV2tUN0hKVzFkcWZQSkxVVm9vZStERjVvMCt6cS9icTJWUDFXRjFOcEZX?=
 =?utf-8?B?T2d1WHNmTStKRjBkblV5Zjc5NmdUbE14QXNNNDFjRUF0czlySmxZZTBYaS9X?=
 =?utf-8?B?RnNWdTFYdmhtekZGa1ZVZ096NFhxem5RNDluRW03TjJmM1BsLzd6TFB2d084?=
 =?utf-8?B?d3lxZFVLVHVqUkhWcTE4N1B3REp4TjJ5TnF6L2JPQU4rQm1oblFzcVRBT08y?=
 =?utf-8?B?a2lkK2FkLzJuTkFzVjFaQzVteUJXMmwxcjkwK0pPVGljU2J0OGxxUkVCL3pC?=
 =?utf-8?B?TFZBUGgrUitNd0VXQzE0cEgySUFDcFQxaWN6TzNzYXU3K2ZRYlFSRHR2MmI1?=
 =?utf-8?B?L3pWU2lvR3ZIaE91bXVYNDdUeEY2UFYxM3BNV1U1QWRuQmV2U0xwNWplc0ZR?=
 =?utf-8?B?TXpWaGkxazVCaC9DZU5uZnJQODZUa250cjJ2ak55VE9ldDVtODZ3dkdSV0Jp?=
 =?utf-8?B?Y0k2UmpwWEpiYis3eTNUZWllMFJGb2tQRE9JakorTC9PRUdVNkk4UzY4Nk1Q?=
 =?utf-8?B?RUJXalVtcVQ4dXNTZHNaUlVxNXVqdHlUWHM1MTRpVE56K1RFNmZvYUk5bUph?=
 =?utf-8?B?SHI1WU5MempKUXcwZUgxQlVYWHN5c2NHMnFWUitPQ0pGYzlndHArQ09NZjhO?=
 =?utf-8?B?ZVFzQ2g2SElSY3c5dG9XajVtTmVrZUZMbGV0ZmsyWWJJK05jaFozUW5oSHRo?=
 =?utf-8?Q?6mjOkY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007)(4053099003)(4013099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVZCY0RmSnRQaytJaC91VnZCUVg0aTJWOVYxdzBLb3RiSUZVWmlJZXRFUmEy?=
 =?utf-8?B?K1RwUGNSWElDK2hnVG5aOTJBVjB1NTlOYjRoOEUxYXJ5bC93dnVSS3QvMWls?=
 =?utf-8?B?cFlWSUI1MGdwK2xoeElwT2pTdDRPeHBqT2puREtkbE9mRUM0UlN1TE5kV05W?=
 =?utf-8?B?OWVvNTJQNjkzV242VzhQT2pHbUNEZzRqZHJwQ1VxYUNjNkRJcSsxZktVOHZp?=
 =?utf-8?B?bGlzWENtUjJCcXNNMjJXVzREMnc5VEZsMm1DU2dnMkdzc2Iwa1BiTDZjU2po?=
 =?utf-8?B?Q28xNjN2bWh6VEpxekgwZEZnQWJ0QnZjSCtSZi9RNm5ONitKM3VTUVZnM3pE?=
 =?utf-8?B?T0s4eUZ2M3IxTWZPbU12YkN3ZkFzaC85NXFnd0RjSTkrYTBiTmVNeU9nTDdE?=
 =?utf-8?B?T0loa1NLSS9ISG1GcC9CcU5pdUZiZ2R4MG9KaWFtbXYydFEyK3d1eXU0cWtt?=
 =?utf-8?B?WHFUWGtObTdEK0I1eWFaSkUxaFZiWlBlcE9wbCtiOWRWUWlnQTdmYzFxbXla?=
 =?utf-8?B?Rm9Ta3ZpVllmbzdDRlBURG9LRDhCWTVTa1VKNmhsbDZuTk5SRUN3WjJUUDhD?=
 =?utf-8?B?NW5JSDUyeDVxYlBoU0M2U0IrRG5uTDBUMGhNMVdha0owRlZaYSsxYTJJTWlB?=
 =?utf-8?B?T3lXUXZ3KzBnM3RFUzVCSkxTT05kdmVCWEZOa0RZUXFMWkxWUmtxeUFIVkFw?=
 =?utf-8?B?UDgyQklwVGplMzJXSkF4YS82RCt2VE13cnFQR2xsYWVMWHF0RW5raHNZTDJS?=
 =?utf-8?B?Q29jeW43R3N3RWE0cHR3ejRDcFB3VW1JN1JINm9oQTNPMHJ0dThnbDJMeXlz?=
 =?utf-8?B?R0xYUUhaTVcwcTIxamwxOGpLT09PVndSZmhjaURobHorVWJTcW1EYkZkY2Yr?=
 =?utf-8?B?UlZ1NlM3Z2lKa0pSRUIwZXZMSGN3UDZVdTA5UXd2RWNmaTBwZjZRS0JNbEEx?=
 =?utf-8?B?aFVTVzdyUGYvQ2tUQ1M5c2Qwd1BkMFN6TldNNURWc056eDdGQXo5ZEdpRncw?=
 =?utf-8?B?RUlaaDJYVEJ1SFhXQ0tCWTR0bGRlUWFZczVTSjFidXhhK09uZkg2UHZJQlg2?=
 =?utf-8?B?R1VaZktiT0p6QVdaVlJ1RWxEQ29rQ3h3T2NYV0dXYlRwNzVraWlsd2tuY3dL?=
 =?utf-8?B?SnlseTVKeDdrWi9HMktyd292ZURnd0Y5RUs3d0toT3YvRnJ4RmRZOVdBWU5k?=
 =?utf-8?B?N2Y2QlcvRHNwTDZqN0poWjlRdWRZUkp4SFRFeWRod28zc2Y1Mmo0VENYZTdy?=
 =?utf-8?B?Q2ZPSkRDZHJWdGZOZUdBYzJvQjB1akpCVWQ5NE9CaFZuRUt3dG16WE43Ujg2?=
 =?utf-8?B?cG1tanZJUEJBaDBmUXFXYThicnJiZ25XTHZuZjU0Z3lqV1lZVVE0V3RoSUhz?=
 =?utf-8?B?aG9ieTdialM2aEs3ZVRzeUFrNHFRam14YUkxbmhxaHB1T3FJdkRnQmVyZnVT?=
 =?utf-8?B?M01qOWorKzZIV2IxM3k1V2gvOE9zYUN2WVVmU1FldU0xNG5obE1NS2dHOHZw?=
 =?utf-8?B?TVM4OE4yVk1QR2hUZFJMUHg4SjlaUW1IdGF3VHVCRERLcm9xM3VaTkRReEZp?=
 =?utf-8?B?b1d3MytrT1BLQXZTUytjWmNGR2N5V2tZZjk4RkNrZWxKb294WCtmYWNBbS9y?=
 =?utf-8?B?UUg5cmtnaDZyS2lrVkVkTWdPWm5hMWxuQXB4bXVwc0U4NEVIWW5RdzdPcFND?=
 =?utf-8?B?MFYrSVlnZFRLdFBlOHVPR0FER2pvSVhXVXFyczdIcXZFKzdwNVdZUUxMc0hO?=
 =?utf-8?B?WDZTYnQyd1BSWldsN3JzSldUYkpRTXZCajI2cVRMT2dZZWNlV3NkelhQWUc0?=
 =?utf-8?B?T1FjbXZSUVhFbXpMb0E0YitjaDdqb2NBZm9BMTVOYW81ZlRsdjJKMXZvdzFU?=
 =?utf-8?B?YVRlSWJzMlQ3ODJyeXRwVmQ4eEo2dU9zMDZZR3gvemlhRGo2a2FjS1dWVEJP?=
 =?utf-8?B?dmJwZkVzU1QwbEhzaXpGT2FZVWhpMGFtTW0yTmpVbHZ3RWp0NzFINmhHNzJ4?=
 =?utf-8?B?bEsvNVdOMnFGajh0VmkyOWRiQ2FyUTJYNlFPL0NFSVh6eTJnYlBWeHFzdnZY?=
 =?utf-8?B?ZXBFOTJ2OWg3SEtBSVd5M05OdXY1M0kxSE9FUHI2OW03eWxadThzblJwN0p1?=
 =?utf-8?B?RC9VZlk1TzlKQzVFNXZSNklmQkZkdkc3M0V4V2NlekoxVDFOa0ZPL0hWaU85?=
 =?utf-8?B?NlE5b1hxNS81WHlReDlob3d1emk1M3pSSERqeldTM3o1RzYzSWJIRDFlNlRD?=
 =?utf-8?B?NEtiUVJiMkxudGFFN1Rla1RQVlpRPT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-V7BlGJ6b6qrzRt9Wk5iY"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	53EImBLIOQoPhedlkwYTlsZ/u4EfUOIc3f3kqAxH1RiMCRl9hAtqesEtq84KVGm4x0JW+cvFgWZHpqDJ12hZwmOc7HFIZQhdz3E922D6eaSQ8JQjNJpdgqqYGhJ+nWg3ri6jNU+JNbkxhHW2LHly2Ls7nNV+SvpEcg03grBjKBkX/4bzEQlKfl3DdUyDTwy565PMPSx8ZA7hvrZSaUxT7ZuC8oHuyUdpfv5/7WmOGkbWf2TU5YZhltfg/qB6+9M5cGYKzc8Ny9mbWp/9p7tnFBixiZz+MUaQ5mwTNRsQEN/seeOoYgwMlI8kXO+oJ3ZgdswkkBvvnGHz9IBUzwlo7VTkeCjDxjzKqW7AMEuH0NMctuyddwWNBTIfO2G9Io8h3tR45DSUlTo7gOdaHXqBJ67ON39tsfpBzqDpKYKpOaEuZFuRiH4nO0ykKaLFhaC3/A7gkWctKDNQ5BD+MW7d4W2JjTSzgbLBlVJsOfUQqHhy3Drmx2I09Kl9xeqwr8/477vmuGnaMpK55F7pthR0pt8ZTrL8R+F2r9XZPCxBZGPwNT62dPhi24jiUnF4psan3YtmkDsKbJiEGu3Pk7w1A+KFL/M+PeaYE6SX74RPbeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb35d52-7f72-4061-0639-08de0011dff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 11:09:50.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6ZI8EkJR/weZM+uO/92leMFTOHkloC/0Nc8RuCdHVzOaZGAk38UVb501Dy9WLBgVm1cTADMCNnwxKUimCmcRJSe0V4oIeo6JaiHWAXfiZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=898 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300099
X-Authority-Analysis: v=2.4 cv=H9/WAuYi c=1 sm=1 tr=0 ts=68dbba85 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ag1SF4gXAAAA:8
 a=yYCgjXmb0VazeWf8254A:9 a=QEXdDO2ut3YA:10 a=B0_5_XSGY_cA:10
 a=yQ5YkIHWDTLsodhdD2wA:9 a=FfaGCDsud1wA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=ntf
 awl=host:13622
X-Proofpoint-GUID: S08ZcBYkeEbTkoaYIqELvcve_aweRbOD
X-Proofpoint-ORIG-GUID: S08ZcBYkeEbTkoaYIqELvcve_aweRbOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDA4NSBTYWx0ZWRfX0in2UH8a6bDq
 jZtJ1NdLg7hy71TrH/YFCo4y0Gj+HpwgAF67rSuIDigi24x/ihFybiUnJnP/tsQ3pObbqPEt2qn
 tf7wDROJqzEbnldvRtm7/32Vq9UWEOJQfYkbFv1i/AawdtWy7s5OWgNcXiJG9FDcWLUSlVhW0Lo
 nEJRGQcpRr2c5gIassaBliS27yBbO4LCV2msKZq/DkjcMo+dRLvwtg2asYVumjrDJKk3T9BhcbF
 We68sbpxq73dS4oPf6QGg2duHbEeDGD6dQPw/uPvMNZVk8f4VDx+7q1TbXLn3/A9ocFsON7W/yd
 DmKYcoWjg/Dwx8JA4H5HrnLgGVLKC3i4z0ELnevj/aX5/aBYg1SEdY+USfJhyuoIw+fbalAX3tw
 /GoxxOmEl+RsH58vVPWuGJsc4ICBQEZM1iss8IcgfEY8TEAKBRk=

--=-V7BlGJ6b6qrzRt9Wk5iY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30 2025 at 16:29:03 +0530, gregkh@linuxfoundation.org
wrote:
> Then the second change is the one that gets the CVE.  Any "previous"
> commits in a series that were preparing for the real fix are not called
> out.  As each CVE entry says, do NOT cherry-pick, but rather always take
> all of the commits in the stable release.

IMO it won't be nice to change an identifier now and a new ID should be
assigned instead.

Thanks,
Siddh

--=-V7BlGJ6b6qrzRt9Wk5iY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjbunYACgkQBwq/MEwk
8iqELw//WV7tbqlcaK8VUJ9DBZxWNzl5lc63mfroFoRjQ+pgN+pNsLnabyFIN2a6
7V9qF7qGoKaxpIy74t/tW1NyoS3+D7/DtSdKLMEaAQVpBOzBrI32i2/zEFEoyVLC
OFvOcIV7Y+8BIMuxJBIHhwbzg3CCcMq4NmgHATAbdcdRnTLrenZHb6Lshe35ZpK/
0K9sMvr6i5RjzKPMzN7BbhwX7nAnY4RimGf81mLFu4ocyaWMl5H855WdiKLwKErW
qBJkepJa+XG5vJljRciCraC2Lc1H9omFMqK7Uu4Jmf/FpWU5Vl2OPhKjWWomoemT
usHI+CbKjtYUKv01g74SCnuw/A/3iMqvJenB0tpINrhUF/dVVF0k6pVZ8OpBwh5R
7ltOFpwa6QOdFzvWdovALzW0EhiU4ck/7tEV5haEYRuOXxrhETLYrFmV8ILaYIEv
jMldtoB3+Zysbha3iWU9fZSgwBMVW7ttR3mPjgFPO6RHJ0RVUT7Zmn1XjGkqpksZ
HcBjjq3FhaS/JBX2+Kom9RLGED+PzktupjnujxoDHNkdlogUZkeRFy9HKOsg/lBd
Df53Qgld1qPdVfY9aLVtxI9RU+yDS8RrBhJWPTo5rMo2dHtbIc/3xnpQvHV0HtEH
Urjc8E0fKL8G/QZUENTCq/b1892Kc+oRmkXS/Lj9SEsQFipUdys=
=/yTY
-----END PGP SIGNATURE-----

--=-V7BlGJ6b6qrzRt9Wk5iY--

