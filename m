Return-Path: <linux-kernel+bounces-728193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA484B02481
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61671892BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7751E0DE8;
	Fri, 11 Jul 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avQ8EG+d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SEnCT/Yz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C01DE4E0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261834; cv=fail; b=HzfDiQr0E/+AczyTfrNRJ8GwWHbCI4wAZXGF4xaW9Kly+AcyKMuwn15TiCzC3I8t9gx7VtpTJLSxy1NLGF4CBg2gkEid38G1UjtNxkmRacTCvjiA/Vy9BaPeYqswMnIrLn16mpNYstxUG5jNANQ9c8168DpsczUxhKnNptexeWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261834; c=relaxed/simple;
	bh=5tpb4hs8QquOGlOci2LKl6aaiC7sOe2w2CU5sE+yh+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBXgntG/nZrNmuVAn61yDUSt4flBiWZVdk6SGQ83G4qGsyoFqZWTkRfPbSIwninvCu/Vm99n8kOOJKEH/IFh5YoMd6dPUFT8i/63HgDrPaicVgbxiWgRHqoPd3CINQoJIDUTvPkpPWcuztaA6zbkGwj35NISJzE78FhsODv7IQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=avQ8EG+d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SEnCT/Yz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIq5bI003779;
	Fri, 11 Jul 2025 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wO4bm5HBRYXKyMWNbBsZmtxayuONzIC54aQW0ZMDT40=; b=
	avQ8EG+d/4OOmzYWfs/+oMwHX5GRxnrEj3gFRvny89kkedMbatzzaLCMGPoDgCmJ
	DI229Nvmb6HMigsQykIOkwLjR1XajCLWTo4EPn82HyE6gK6/HATb5b7m/QV8Ch7n
	cuAYQrumtGjSOPJ/kOcEzXskgTU7gzyiDbqTRdCNd/EbIUuy1LYXv9QOwsiJFX3O
	8lPFiYRGVcJ03+oatpHtQMYvdcTf+fEXKAnC+nDAVOc0M3aOkbLF+Nw8wz0259vc
	MVAsu5Vds5t9IIGMtUCzl0US7jgxDNIy6mWyqy3bNy5iN8byuxfRyga4qVBcZPVt
	iYP7TB/H/Bu4+af9wugudg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u88x01rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:23:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJFn2X013590;
	Fri, 11 Jul 2025 19:23:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptger11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feqNFNUWznwmT3MgVIhiw8xfrBHspuc7Ou21m26Q86LLKy1A/UDqPrftSoc+q8rodG6juAZhcOW9T6i2YMSEQok4SAv6TjeTYp6e05PcrroRqb1BSgFo3oRJyRnid/5DIqiUp31H1FI+pDbcVOn+P+ANKXxe1KqavyKOxPeeWzSRe45aS/b+fi0x1XG4KFrmfUQUw6eHdDZH+jWHP+mkhft8npqSAXpwB6g4uouCz5RArUZdFRxqJOkZFHKTQK8xwY2aN5rFWHtK38ZV6D5jOPXLSQ33RsvyH4oZI15p9ab69rlzmPTD8sbKAzuZxm3NsecT9mEV0eM9i/YaAJlLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO4bm5HBRYXKyMWNbBsZmtxayuONzIC54aQW0ZMDT40=;
 b=ykMs1zbEUGoPWyL7iqL/ERPV7ft3IXFxbm58mj9AXYOOvRZsvunLB01TE2afmbd2cTkDFyCXscDM4m9VzT+VpiC86r1wGPQS6YY8wo4T++sEJbhmE2F3SlWCyqY7PW2Z1lRh1mY+u8Ad7lLRO1zocjc1kGb2tTL0zCH2p5EpdvSXo1vZrbLm+ahOm9eJdHdDyVHIA91d02EemH2myRICVGy8yEOzvrh9SNIihsjLjiqeJK6u2+8aeC9mK0imiLZLd+H4RZ+fTcA/OHJJXoDNbv8FpOOvN4QH9+9pZDuvuUlH8ABxvsJaLbmDcCNu2a5kXYdoft9HDYiuU7o7iyhJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wO4bm5HBRYXKyMWNbBsZmtxayuONzIC54aQW0ZMDT40=;
 b=SEnCT/Yzn3CrQmnJUK1+e1U1Z8tudn2kut4Tws7VwU57cQ93q38B1Y4UqUISewhMX88J4Bv9AHpDI1o10C2pGFnRtRDmJBFiD9pzz/NPxv6vk9WCa9PaKCIVaYXe9nDpXrTkHXN1qsp4U3/TvAcXs5SofJ+bmfFNbG43PIVMyZw=
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d) by DS0PR10MB8053.namprd10.prod.outlook.com
 (2603:10b6:8:1f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 19:23:29 +0000
Received: from PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4]) by PH3PPF517B7003F.namprd10.prod.outlook.com
 ([fe80::943c:5ede:5076:73d4%6]) with mapi id 15.20.8922.025; Fri, 11 Jul 2025
 19:23:29 +0000
Message-ID: <e7b79c66-22b4-4d01-be5f-adfc5ba7e50b@oracle.com>
Date: Fri, 11 Jul 2025 14:23:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: upper bound check of tree index in
 dbAllocAG
To: Arnaud Lecomte <contact@arnaud-lcm.com>, Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
        syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250424-ubsan-jfs-v1-1-2eab57c1ac50@arnaud-lcm.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20250424-ubsan-jfs-v1-1-2eab57c1ac50@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:610:54::23) To PH3PPF517B7003F.namprd10.prod.outlook.com
 (2603:10b6:518:1::79d)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF517B7003F:EE_|DS0PR10MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b64f14-5df2-4ac7-a4cd-08ddc0b06ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0lNUm1vRU53aVRMUUZLM2NsR0ZyWkc5SnNaeFk3WnMxWVJ1Y21lOTEvY2ZK?=
 =?utf-8?B?dWdLaElPT1lWNUtWRDRSNG1MendBWWRjb1ZUazl0ZnMrdnQ1d0F1RHNmeTJn?=
 =?utf-8?B?RlNYNEx4OFlxaGJXQTFWbE5SbW92Y1pKNVplcjZwL3pvQjVPbG44cFlQd3pV?=
 =?utf-8?B?UXUwTmxYUms2djRlUEtnR2R3ZjJRZXQ5NXJ2UkQ1NVNGUWE5SzdRM0VLT1NN?=
 =?utf-8?B?aWhvRnVLcjdTNEpYTFlrVkx0Sm5YV0NhTmVBUi83SEdodnVoM2tiMFV5eUh3?=
 =?utf-8?B?ZGx0V1JJa1YrTG1ISDFPOHB0WmUwaERZQkRBZ0pMeEtJb3FsLzZ5RlZYREZ6?=
 =?utf-8?B?TVpvcHZqM0tYaEdhMlg2QkZtT3Y0WHFycTY4cTl6NnM1c2xyZDZFZEIrM1lV?=
 =?utf-8?B?d1ZnU3IxY0FhMmh3UHpRelJnWkswSi9FNG9JN2xpTStyaGdPbDN1MFcreGYx?=
 =?utf-8?B?MDNLUW1uTDhzSElVN2VNWHBBMmZ3WVdoY1oxZDNKR2dxQVQ5V0k3cjNocUdv?=
 =?utf-8?B?UVo1WEpVQnV5bExtT0R0MEl4R0E0NUx5akc0MDBwNHNrTWU1U2lzWkN2Z0ox?=
 =?utf-8?B?bktVaW5GcDg3L3RMZFBEaVYrQTN3dUQvS0N6WmRlVWNaeDYwS0FhNkNFYkZv?=
 =?utf-8?B?U0FRUVduRkZNQm9aRUVXRFdSY3dabmFjRENJYUJ4bFhzUWNwZ3RCZTJ4aVlM?=
 =?utf-8?B?VHgzdlVWOHY2VWhCZmFIb0pmTDJqYkNTaEhuZm1pakdqUUxjRFJteEJYRzcy?=
 =?utf-8?B?NEpFREVidUc3UTY2TFlyOWZEeWFBVjM1T2QrQzF2RDRMQURSTkVRMkhScU1R?=
 =?utf-8?B?ODdXbjRtNGFxN2U2M2xIMk1VVVNhT1grOHZvT3haMU0zVDdpUkQ2MzlrQkN5?=
 =?utf-8?B?Rk1pSDhzMDZFNkZodkhScVd1d1VhdCsxRUZIK0lGRXlXMzI0cWRxMkxqREdM?=
 =?utf-8?B?VGFra0VmbXlJL3hhUVdqN0QrWHNEN3ZPemxielc0N21pWG5qcFBWcFhwM2Zy?=
 =?utf-8?B?ZGJpV1dBbHJPZ1NpYk5SYm5EUmd5MXdUNUtGUUhWeE1nZ2F2cEFXcU85eTFu?=
 =?utf-8?B?SHlBcTFtNElKODU2OC9HWm5ubjRzVXg1ekw3VmRGbXNwTndJdnBPWDBmNi9M?=
 =?utf-8?B?QXBkSEJLM1E4ejdkZlJRQnFKSmFGNXBvT3FFc25qTDlmekdyMHNjdHowS0VH?=
 =?utf-8?B?a0I4eHU5ZDJaRXJNZHVFdU4xWTE1VGEyemwrcXk2ZEdteUF6Nyt3NnhtQVJI?=
 =?utf-8?B?bmNLTnlDMkZnYmVLMCtmd3JxS2J3MUZNaHhVUzRQNFBvaUxLZjZDU3E4Qmty?=
 =?utf-8?B?c3F6NWcwb1VjZXFKanJhUy9NYjliN0xhaHU1dzdmZVNQK1VtYVdsNXRaeUU2?=
 =?utf-8?B?eW9JUk1jRWpuNVE4MHFGclZsOW1BWm1MNS9abXAydnQwTlhoZm5DYkRzVFMr?=
 =?utf-8?B?eGJ5dU5rc1dQUEdZUzA0MG43Z2ZQdXBjR2luTXpWVUkraFhBR3V1cmlIeG82?=
 =?utf-8?B?OC9id3FYMXVKVTA4azZybFRUV1pwQnM1M0xKQXd3YVdDNVBmS3IweEwzZ2hx?=
 =?utf-8?B?NkcrUWtVWCs4VllOVXl4TVZPK3l6ZmFuRFZYZUQ4OVlTYnpVMy9USlFqQjhh?=
 =?utf-8?B?Qk5UQUpHN21DTy90ZEJoM3plV3BGVlNIN1JyOU4vaENDL0pVTlpUMHJvT1A0?=
 =?utf-8?B?RHNONzJNRVZWTHZNVjVHR0g2TXExeEg2ZkxObXdoSGFrQWhSU1BWV1JsUzJ4?=
 =?utf-8?B?Ulord09wMkhrajA5SVRlYk5Fdlg0ZHVEOWxvR0pPbmNzSWU1dDd0UWt3aTRJ?=
 =?utf-8?Q?rhQ7bPCS1r96c4CbfIrIfQEu5tOmDHABd9RPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF517B7003F.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TCtzNWZCS0JYdnphUDF2c2VtYjB0RFJVejQ5eXNjanNnVkluUEs2d2NvNVdP?=
 =?utf-8?B?RWg5MFhIU09kaWtCRitQUWlLSGh2RlRQNzJWZm1nSXlIZmgwNnQ2bjIrUk1H?=
 =?utf-8?B?ZGVSUTArVDRya0NSUWRkVDVha1JaVnVTeExzQzRUU2pnbTdYbmk3V3lRbzFB?=
 =?utf-8?B?bHFMT2NycUNoTlZLVXNhRExaV3B6UHVQVFNwQXBBRyt0Zkh2ZDMzcE12OGNV?=
 =?utf-8?B?bG1keXlyLy9NWGNGaks4NFdYdVFPc0xIY0NGMlZFSVFzcHRGSlVYYWcyUk5E?=
 =?utf-8?B?TE1VdlJsSXUzaTFqU2tpZkFLanl4bHhVNVQyVkVEUEdITWxuTS9xZ1RESEVq?=
 =?utf-8?B?Q2Jwd002WWJBTURBWEVrQzFqZUZ1SWRadDR2Wktqd3M4K3lKbWRLbzdSNGRB?=
 =?utf-8?B?c1NYRUVodWVmNFZVTGNIdXZCeDEvZHlwVVB5b09jWmZVbTJjVTFPQmh3d1hK?=
 =?utf-8?B?L1dncmxCODZGVnFOUzZRZjBPb3VZZ1BReUI5WTZYazhqNkJEZXdnTm4rUHlr?=
 =?utf-8?B?SXlCSmxFWWZoWUhoYnFaT29HTE9McHc5WFptN2NWMjFmQi9jK2tlSHdpQWgy?=
 =?utf-8?B?YlhrQW5EMnRqUVNOclNITmdTSFcwWEJtcFgvamhOeHNDQVk0Qzl1MnJhVGVs?=
 =?utf-8?B?RlJPQVRyNWxzRld5MjEvZ29ncXh5aUNPMTJDVVQzcXRub3RFYTRpTUNhbkpY?=
 =?utf-8?B?akNwcUVkVHlpaHVmckxXNEREVGVxbVMzOHlUZ2RpU3UvZTlQZERqdGIrdVlz?=
 =?utf-8?B?dnY3NTg4VDY0WXBUK0l0eFBuZ24zOEZ0TTN1U3h3V1F2dysxM1duV2wrT1Zy?=
 =?utf-8?B?N2Zid2M3R1hZQzM3MUtwNi9BeEM0M0R4SkxraFAvbzhacVBXajQ1ZU40TG8z?=
 =?utf-8?B?UXF6UUtpR054b0EyVjVXQm5FMmtjS3RmNVJ4aUJNSTBhV0hCNFdpWGJCUWJs?=
 =?utf-8?B?RGJsN25yZDcwbHlSdjlGV3VEMnV3T2VTRmg2N2lVV3d4NlRSM0g0bWxyZlRq?=
 =?utf-8?B?TXUzbWtpaUVTcjA0N0tZNVgrcjNTUlhiam0xK1FYRExlMGprZ2I4S0VOeGxL?=
 =?utf-8?B?N2VBa29vbFUvZWh6emxuWjNPeDBMYVp5MnhEcWxTQS9CNWdNbzVERktPVkpw?=
 =?utf-8?B?TFNENFZIcnZJNGFaMDZzYnVnbVZTN3U5MUZwSCs1eXJDcXlRS0p5T2t3bUxo?=
 =?utf-8?B?RGhYYVA4R1JNMkRMVGZJZks1Q1NGWGozZTBMZzF5ZmwwMjJrV1VSU0Rwcm9u?=
 =?utf-8?B?QS9CeU5yWWttelFMZEVDalQ3Wnh0NnVCWkNjRWd2VXhCSW5uZW8vVERiSGU1?=
 =?utf-8?B?ZjM4d010K1ZFVnFibUFtdjR1dWErcjVYTkJubVlySWhPMFFoeUhkelJyTENO?=
 =?utf-8?B?SEZRazZ2Nis2MUF5eUlES0lPMno5L1Q4cmpqU2xDMHFhdjRuTjNnR1BOWXpi?=
 =?utf-8?B?dnRubTM4TUFSVWxJMUtCOVVTVjBZdFNHQ0hNRlg3K05TaWkrVk9NRDNLKzdP?=
 =?utf-8?B?cjQrNmNaaU0zb0lDVi9DNy9nL3Nma1JabG4wM2JJNkVPa01vQUpBMk5vcnpy?=
 =?utf-8?B?WGVsRkxoNGFweVVGc0RoeTA2N2xLOW1ndFZuTUJyUGNuL1NrUnpaUndaSCty?=
 =?utf-8?B?SnJWT1grRS95U0hML1c2QWZKcEttYXdyOHhRMlhsM2RFNlUzS21INS9hdDZ1?=
 =?utf-8?B?clZaNS9ZZjlISFJrNm1ZNW1WUDFMV0Y0SEJGUGhkQkE2QjBuN1NkSExLWito?=
 =?utf-8?B?Qi9aYTVOMFV3UVFoNnYzaXRWMVB2UmxZRWtpeXlPMHdVcmxLK2VnSEUrV0t3?=
 =?utf-8?B?U2piNkxBT2JzWE1BZmxNcjhkb0tTZFdBK2l1VEFYSU1IUHFCNXJxbUlySGhy?=
 =?utf-8?B?U0RNOEdWODE4ZFJ4c3dYZnFZT2xGUjlPdW5rSndKVkk3bTlzZ2J0Zi9TZWQr?=
 =?utf-8?B?VEN3NllvUjR6dUJ0TzlIZHpKcVBTN1Zab0MzUFRma1FReUxGRGtxUWFFcTBU?=
 =?utf-8?B?MlBvRFFmYjlZMU5KY2JweTAvUGhQNWQydnNnNWtkWkZid0ZzdDdMY0tPa1hh?=
 =?utf-8?B?YWh0YitqSVl0NFNaMTMvelpIdGhYc3FpOE5YQ1ZzOVhUaVpPNit3QlYvSXpB?=
 =?utf-8?B?bXAzVDB4UCttUXdXbTdJZFZGN2lKWGdtQkRhZmlwMWUrdGxycXhQVmJIbERv?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3UGALXttvyKjQSMo7dUzMl2WhrtjpufG/dyK2Qrf+2rE40xKP5WgyJMzJdugMrV7YtKiZSdllaO4TS7vm8ewN1s3TyoU1Yw6TDrGfGE04rGJKqJ7giTbldXbmJBc5ABmR4ZOjUz8/ZlVqg1wc8HX2xmttIXU2o929ieN1MXFxr1p+OSwvm+CplQiYiQn+aJakBlIa6rUsxiSSlXaejRFMTy3XWvAjkvSDjPLUMEAPhkIb1OshjWCFspTivIrsWoeZN6cdb0r8Z4uqwJf/0XddQFNEDLTsxit4q7RZVeQj8LRk7TAqAjNaT4pR4m23xL9imHdAyUuev8PHxQ8UIQoaIqvzoZLaS9KgfBsaOdEWiV+GnhTbUVorMcj6qYhHpIZAvPJxFLXkBUDQG9tDGkM3HS8pN+CI8gULHzPtm8BGaZqtQs1KMtnGvXgHhCoTqIO14ZZPsHs/BdNYiRAPOXGpUCUTWs9vl2nX+vylpbylvcX6DomNwp+LK4SEzMT3TYTF/7JGFXbzIjEr3D6nWnwk9p8iFZg9xCy14tNl0EmCFc/TlXTF6X7WJBpDvifqVXU4yd7ufsjVgFwa8XAmDHAhY91zuTTz+LZId3CpHv/X7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b64f14-5df2-4ac7-a4cd-08ddc0b06ad6
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF517B7003F.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:23:29.7543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvKeUoMiyCr8bcqNqtGx2PwuSWhd1DXhzlZxI3B5KOBg0AbiY1hf2pzLLLcRqUTx/Rb71/nJBwvJkJmRrWiYKKDNhtYWYt57MiAaD48oAJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110144
X-Authority-Analysis: v=2.4 cv=BYbY0qt2 c=1 sm=1 tr=0 ts=687164b5 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=WWoXvQQ0AAAA:8 a=XdHHFyE6wWtMDUGmxncA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=jSEAb1kaveHxcfb6UDw8:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: gJMofpak9O-B45JT-LcMeSL7SWW6Mg8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0NCBTYWx0ZWRfX8VdnPMbVKgeM gWGMHagbdCQ8vnka+zP0sccw9boa75+d26WA2BYjXEzPN7zppnLECcN2CTMczRo4JSRKK4yXStD YSH6H6DRxrg95c46g26ZohoCoAqxTI3yGFtDwEDRqd6Nntq5ofUzlNcLWR17Q1OnAieT+Z3ogWO
 SYk7BpwhN+X4QsKcfeytXP2FyUl2AM5WOFEKHzmfVIGySDzWWAD3sTT2U4XqK/g1Yk1ATx+WtCG b5zaCNhRh5RYOWfqyeX+NYshZPcHu1InD2ybL+EeuIZl7bqSRvu7rHsxHcA7PKQa5Ti8R1UHBcC K7Bdj0weqlyeEfdAi+dzRL2ahKTwXNxQWXp0Q4PF5+TZSan5fdYRZVJZutv3LOYDa2LJapkLt7d
 8PXAjQyE91s8/gk3b+JWRcKjuXyuRrM/fRdxgFmTd03RBqW8Vhgs3ZPqc/eaIiAPRiw8cSzC
X-Proofpoint-ORIG-GUID: gJMofpak9O-B45JT-LcMeSL7SWW6Mg8q

I'm finally trying to catch up.

On 4/23/25 5:13PM, Arnaud Lecomte via Jfs-discussion wrote:
> When computing the tree index in dbAllocAG, we never check we are not
> out of bounds from the size of the stree.
> This could happen in a scenario where the filesystem metadata are
> corrupted.

Looks good. I'll apply and test this.

> 
> Reported-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cffd18309153948f3c3e
> Tested-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
> Fixes: 263e55949d89 ("x86/cpu/amd: Fix workaround for erratum 1054")

Removing the Fixes: line. This doesn't make sense.

> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
> ---
>   fs/jfs/jfs_dmap.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 26e89d0c69b6..7acebb9a21b0 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1385,6 +1385,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
>   	    (1 << (L2LPERCTL - (bmp->db_agheight << 1))) / bmp->db_agwidth;
>   	ti = bmp->db_agstart + bmp->db_agwidth * (agno & (agperlev - 1));
>   
> +	if (ti < 0 || ti >= le32_to_cpu(dcp->nleafs)) {
> +		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page: ti out of bounds\n");
> +		release_metapage(mp);
> +		return -EIO;
> +	}
> +
>   	/* dmap control page trees fan-out by 4 and a single allocation
>   	 * group may be described by 1 or 2 subtrees within the ag level
>   	 * dmap control page, depending upon the ag size. examine the ag's
> 
> ---
> base-commit: 8560697b23dc2f405cb463af2b17256a9888129d
> change-id: 20250423-ubsan-jfs-3a58acae5e57
> 
> Best regards,


