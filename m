Return-Path: <linux-kernel+bounces-638496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D79BAAE6C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C0A188BBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AF28BABD;
	Wed,  7 May 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P1WD4yKv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97B28B7E2
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635406; cv=fail; b=N/COKfZLRIK8p/JTizcC9+hUJ136py5JZgXQg2Muygwab86j8YN2zNKQ9DBVEjIOqqKstJjnZJ8sit4Dq/JKpFDAs1v0aHu2vo4LMD0NCOx1LyYHwg8vtUh40IEduaivpd85RPRwQ+jk5WKTd/O9SKCJYFkB0GvNEd7nAtbfkFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635406; c=relaxed/simple;
	bh=9dJLK1WWYQfmCSUBS75VNSgt9qq8Ws32zCZY46PRRjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9wMyv6bfcmlpHjk+O1KmxZ7w+M+jltbAatQbdGpj1EgNYHQ87qwgLL1kTiLVDXp8VDZLVWpxkYFqGBSrY9zYYwtG3mHmCX9U5Q1rnVGsy7KLAc81cfNP3BtcP4dSBm3vto/BUtit0NOaDCSPnGE/zPnEjN93/Sg2uX6Ry3DOvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P1WD4yKv; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqSqRVu9cDeaOk4ue2c4PuOy2Z0LIa3dtu4rin6LJ0Q98PaJDxRtIBvgKG4tK7Dk1y5cRurBDPy0COCYI59W6xD/gyyvSwQ/8vg+9M8zX6AtrGYTQu/BsVVUbIfxWTBI3xdXBFWOI2Ruw2LarD6o5nSskVxYFpnUEUuLTSZPGjJLrym0R+W3H3Q+FrHwT+Lx6PTeoEVdBIMRrHEnV9pvxaqgqaI0OOAloMGG4mJ5+zmltmcU0Zc24MZnlLl/0wTV975vWXvV1ObPwk7fs5xeycCS7rgflYIRzXwDilXs2Buttai3zaSBMx7TT8Zcr2zHe8KqYwZCu0XV0/y4rKhl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8j5vyAoUzbnUK3GU43fenxDiY/ICRHiHHmjYtw12sM=;
 b=aS6ip50sDpKlqLJinj+55bXvnMlg8Q7C2X3dXApYSC9Z/He2Ogq2AmjE4MZtpNgXUTCVcfcsmxolCoj8Mcr55BMnid3nFINZcZ4wNT9BHFxnTpYgd5e7LD1qzCwvIh1MIroJ1TB9sew9redwn62Tb6/aaqElZxVis7QyhJAkJh5CbFWeDsV4trSiFp5cPl96DfpupKZ7EDJwKOVD49ERUfka7xX2Nqc5P0xuDsxE6RgsgcZ9+tbuj7dQaeFKIFsn/QEaHHB6/7JTJzkrUdrZUtJt3L3XByWtN+mZl4HEP8A9Kn4WGkDf0kRCDOClwbw7czFd54d/MNSUijkzqgefMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8j5vyAoUzbnUK3GU43fenxDiY/ICRHiHHmjYtw12sM=;
 b=P1WD4yKvGZxl99iYTuM3SIPms+hW3+9Na+mUApEr46srGY6hASmgkhU0e9XGSYUs06tyc4FOZ7S/cpOgwpj4gz5NJkuYspZ2xOVAb5gUzsWhIiwPGMhigjOCTVhsC4u5NqXCLD8XGBXv5GVSraGeJDazZbPayRmVffbpxytBXwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 7 May
 2025 16:29:59 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 16:29:59 +0000
Message-ID: <4534597b-70a0-4c6b-9ff5-950e69ca7b37@amd.com>
Date: Wed, 7 May 2025 11:29:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support submit commands without
 arguments
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, min.ma@amd.com, max.zhen@amd.com,
 sonal.santan@amd.com, king.tam@amd.com
References: <20250507161500.2339701-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250507161500.2339701-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6477fd-c1bc-4033-2230-08dd8d8468d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFhTbDZGcitBVmkxRlcwVnlUQW1yK1FPTnk1L0pQS1cvN0JWMWlhN3BqME9q?=
 =?utf-8?B?dnJWdG14ZHIxRGhTaHRGbTc3REp5cGt3L09FN2thWWEvakhtZVp2ZGFmUnB6?=
 =?utf-8?B?aW03dTdqNFNuNFQvNkUzSVNzOHh3OFJ1L2xVaTQ4TndQb1Zvd1ZBcUcrWXl6?=
 =?utf-8?B?M3JFd3ErSGM0dkVhWFg1VGFwSHJBV3U0UTZjTVBwZ1dUTVdXT3ZOZ1NYdVdM?=
 =?utf-8?B?eFg5eERucytiZ0hvWmxyenUwTE5GR1hoR2wxSUxvVFRhWlVkNGh6djBISWcr?=
 =?utf-8?B?dm9iQ2dCM1h0Mi8zR2hjeTBoU0RyUDY3VVRDY1dCYnV2VVpQamhTZnQxblpC?=
 =?utf-8?B?UzNPYXViMlg5QVFYSUc0M0kzdEYxNzV3bzIxdFo0Zks5RDI1Q21VNzd0OHZI?=
 =?utf-8?B?MHJManJjeGxwT0tJd1BOdUtlTmNyMHB4OFpxcGJEcFRjSS9HNGUzanFtUVlt?=
 =?utf-8?B?aU1OMzFjVGgvM1V4Smp0SGQ1NWtROExoV2psR0JBMXNJWldkSE9tWDc1NktM?=
 =?utf-8?B?ZWxMWkFWTFpOc2xwbFJYdXFLNFdlcXhuZWpDNUlWeGR1bENvV1VMUms3TWE2?=
 =?utf-8?B?Zks0QVUxTXVRdVlaZ0hEb0xYMHBlL0Q3dWNBLzNrN0hXZ0pvS3EycVYwa2Zo?=
 =?utf-8?B?azY0M1RreEtDMU9WNXF2QVAzb3dCaHJXdjFCQlQrU3V4VmUxL1NJVXBxdkE2?=
 =?utf-8?B?c0VCbTNEZ1QyTUJNTU00U3FoQklsRkl1YktKNHJRdHpmSlJIK0tyMXJkeG1N?=
 =?utf-8?B?OEpTS3o3ajFZM1p0OVkxSHdtZEhZemZ4dWtvWGp2eis5ODlnUlBTZGEvbjNY?=
 =?utf-8?B?dGJ4dU5hYU9zQ0Rndk13cHZ2SzhRemJKcm5JeStwRHBqbkhCWVFYaytiRHFP?=
 =?utf-8?B?ZlJvN2RQOEw4K3puR2kzdTVXVVZGTmxqTFJrdVJaTGp1SlhMOU9YdXA3Y3cz?=
 =?utf-8?B?SWNTdm9Cb0NPbkF4U3RxV1hDUVNuUUFNcGtIRDExMGt3aCtIY2psVjZwWDBu?=
 =?utf-8?B?cTVLTmpTWGxOZWxDaEJXcFdlaFU1bjV0bHp3TEpPMHhsV0pzQkkxSDJyL3B0?=
 =?utf-8?B?SVZXemZabUhoTCtKS1RWTzZpR3huMDBQb0w1OFE4cW9mTzBGT1EzWUFNVVdC?=
 =?utf-8?B?UGwvOUczZ1BkVWtuZy9Nbk1ySG9GTFZ1Vmovb0tnUFFXVEh0Q2RCNW9sTTlP?=
 =?utf-8?B?ZjdOc0Ixa0JFdXZuZVVsTTAzLzV5Ni9HRmNsUXFSWngzb1BBYWhWalBKRFNm?=
 =?utf-8?B?NGUrY3V5UDBhSGlxZ2l6aTVnaE1sOGdmRnQyc1ZXQ25OQi9wQTlpMy9YenlO?=
 =?utf-8?B?VmRJVXBpaDZ5WXp6V2p2ajlRR2d0SHExT2tBaE5JYS8wL3E2UHJJa0FVNG5n?=
 =?utf-8?B?Vi92YjlubTBXM1I5ZGVsMTRsUWhTM0hIS0dMbVJSYmlhSjNia04zMlU0aWN3?=
 =?utf-8?B?NUdqMk5vdEh6U3AwNm9BNVVPZ3JRaTVwMEh1TnUraVVnNDBjRWVWa3JEY1ds?=
 =?utf-8?B?dTFKRU5XR3F5eUZjdmVmQjJqTUVXbFFHNm0zakFmeXM0aTNUM3p4TDZxK25M?=
 =?utf-8?B?YUdLaWZiQTlFRGx1aEI1MGlSNkg0ZnIxNk50RmpDbENJaUlRNDBadlROUHJp?=
 =?utf-8?B?K2FSMkpBZWZ4UzdJaFJrdHhmY2k1SlNLSGcxbCtFWGUzTUR5RVk0amdzOVZw?=
 =?utf-8?B?eCtFOWsrMFBURXQ2WENVYjZpSnc0bWlkZ0VuTmQ3RDhyYWNaeGRSMlpHVmJj?=
 =?utf-8?B?MXlES2w5eWlSL1QvVVlQYjlHaEtpRFZINjRqbUxyMmJ6UzhDbW1vNVlFQ0hS?=
 =?utf-8?B?dVlualp0T3hwcnNiak5OVTJDVkUzNGZVQk9ibysxMnJndnp4Wm9EWmZUQ2Nx?=
 =?utf-8?B?Wk9Rb2JET1ZYMG5RekxnMng3N0xnOGQ1ZldvMlhUN0NFT2lranozOXNZdVh4?=
 =?utf-8?Q?eLf4495QbmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFpXclJqOXIwMDZFL2dEL0tWOGx4Yi9zOWszdkl3UlRlalc1UkhoMnJlMm1t?=
 =?utf-8?B?M2JESTJPNzIvOXhsbUFKaHNKYzlhN3dqSkl6cjRCOG9zNXZkYXYyelZnR1Zz?=
 =?utf-8?B?NEhPVjhaeGZOR2d0SUtoRlZIelRIMVpNVndpNnNsd0ptS25SbVozNmVteVl0?=
 =?utf-8?B?Z2QzVnlENmV1S1MxUlNnbmRCc3Brdmhabk1mWlhMUEExMkxFNjI5MFhyMnpN?=
 =?utf-8?B?clF1V3pCZHErMXQ1TFh6TFByTXZUWnN5T2RPVmlzZkVHSDE5ZDIwY0ZCRktN?=
 =?utf-8?B?L2M3N2E1bis4Q2ZYRWlmeVhuVDB4ZktRQVRPcWdJT3VFOFVrdnZaQmNQS3M4?=
 =?utf-8?B?MjY0eFM1MXJ0c09neTlzbnZWVVlZeWVablJBdHFvTlpSd3FJcysySys0NDhw?=
 =?utf-8?B?VUE4RVBOL2tFUTUxZUtZck9YVGhOeXdQWDdKTDRCNlFmSllUSGxNYmkrTDBD?=
 =?utf-8?B?c0VWamczUmllSVIrKzZjTmkxclBlOFB1UDFjSFA3aXBuTDFmMVFxRERCV2Za?=
 =?utf-8?B?MncwVEx2L1AwT2xpYTFxdHd3N2gyUTJhQVV0d01wSFgxM0ZMWlhTdmxUd1Bs?=
 =?utf-8?B?N1dnSWc4SzQrOXBxdDlBcGVlSUtrTk83QTZWc0dnM0kwdTZENjBWZGg2U0RB?=
 =?utf-8?B?VS9uUXFSNG10eCtJM2YwMXltZnN0K1AwYUErV0tYem1zVWVOOFllV2d5K09J?=
 =?utf-8?B?bVZFNDJ2SVBZTnhLZ204bWR2NGZndXBkQis0djBBKzl5SjRabmJ3Wm10NDMw?=
 =?utf-8?B?SDR2WmgwWG9uZHM4aENjSk1la05YbGZIRlZMSWFrdm9Gb0o3N0lsMWZHTFpu?=
 =?utf-8?B?WGJLTEJzYlRpZjkrUkQzY0gvamE4Z2hzOXdNK2U4TWlPZVdyMi9LT2RvVXlp?=
 =?utf-8?B?SlpVcm90R2xpcWcxN2J4blNYRXl0WTk4MXFXL3VxUEs4MHlpUElRKzJweUZ2?=
 =?utf-8?B?anlvSVpMVlp0NjQwTnhqekFqYytKRERqKzBNQUNVT2lLWXo3WEhGWG0wK21x?=
 =?utf-8?B?bksyWityQ2xxbDVtbTRNdW05T0hOaWtZR0ZPbWFGYTB3YUFQNjhnekEzZ3pM?=
 =?utf-8?B?VGZzZkZXcXNURENWeXJLYTZ6TlRQNmhVUzhxaFIwbVlydDBDVWhjVWFkeGZP?=
 =?utf-8?B?MEEzVGpDK1Nibmh1U0Q4allmVjhaNmh5b2JLRWpkRGIxVnFyalZCOWRmVmlh?=
 =?utf-8?B?eDFhUGk4SUZHZGo0a0ZBcEd0TnhYSXJiaVlERUxRT0QyNUY1dzlWOUVlRkpW?=
 =?utf-8?B?T2tZdGMxK01BV0tXL1dXT1ZZY3ZVU1MrYmFvQUVTWElDUlNGYksydEtWajEr?=
 =?utf-8?B?R1NYWVowN0FVM1JyZUpMRjVYdUNEdC92em9ZZldFUGN2N3Fma0FzaFRWN1ho?=
 =?utf-8?B?ZUkrSkw2QlBBWktWbmF4dVV4T1o5TVJZMUsyKytWanRMbEk3MFdaZlA3OU84?=
 =?utf-8?B?TTRDSjNKVVowV2xPMXNvVDdpV0ZCckNNNnd1allzZll6TVMrWk9DYkMvVEll?=
 =?utf-8?B?T3N3cnVzQW1EVzhwaG9xOG5UdFl1bVhqZUtmaE1WSFE3bkpNaXJWUFNaNmZP?=
 =?utf-8?B?eTA3OU9HVVp3SUkzRS9BK3NWanpneXlMRWFmclQrQUtVQmJpNEZrOGNPS2tp?=
 =?utf-8?B?SCtNVEZEYk9iRmFpWVZIRnhJaEdTRW5QUWd2VjNLVmlqQ0VnSmp2N2FwTFRu?=
 =?utf-8?B?R21ZNFJ1M2l0bFNISndwSmxEbXFxMHJQWWlKRnlZdVBxck5OTzNsblhDNDQ5?=
 =?utf-8?B?TFVyMHJtQmsyM2xxZVF5YTRzcGsvNkRNeFVERzVqeUdGQmpUZENlUk9VS2c4?=
 =?utf-8?B?UTVJVitGN3V5bUdaMlFtU3JhWmZUaFBMRUxKR0xNNnVNaDJJRk5lSXNUbm54?=
 =?utf-8?B?bWhxY05LL3V4ZTRxOXV1OUdDaDdGZGVLa09wOHZ0Mk9pSGt2ejdVUDgxS2Ur?=
 =?utf-8?B?bm5KbmdlZDlFQllFVmdUNjdULzRDem0yRWR6ZnhrWElySGVNejBaUUNNR3d4?=
 =?utf-8?B?RGtIWWJIVFhLc0R1dGErYUlkdzZ2ZEpDVWxVZXFUdzVtbUt2eFJJV3B0c25a?=
 =?utf-8?B?SWRUVEpwTEYyUTBma1pkV0NtTGdLUHRxanBqVjA5elBXUmFVd0psbzlNMWRW?=
 =?utf-8?Q?bBf7e4h6YLD2DBzByIhjM+Ros?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6477fd-c1bc-4033-2230-08dd8d8468d4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:29:59.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80jwBGMkh+3rOU/cenWgHfuS/MOgPplneVJqwyjq5HWSth0DdGH1paVsfu0RSq4/hxEU8GmnNlxKdOA9Nf9CCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC

On 5/7/2025 11:15 AM, Lizhi Hou wrote:
> The latest userspace runtime allows generating commands which do not
> have any argument. Remove the corresponding check in driver IOCTL to
> enable this use case.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Can the userspace handle discovery of the difference?  Or does this need 
any sort of ABI discovery command introduced too?

The code change itself below looks good to me though.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/accel/amdxdna/amdxdna_ctx.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 43442b9e273b..be073224bd69 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -496,11 +496,11 @@ static int amdxdna_drm_submit_execbuf(struct amdxdna_client *client,
>   				      struct amdxdna_drm_exec_cmd *args)
>   {
>   	struct amdxdna_dev *xdna = client->xdna;
> -	u32 *arg_bo_hdls;
> +	u32 *arg_bo_hdls = NULL;
>   	u32 cmd_bo_hdl;
>   	int ret;
>   
> -	if (!args->arg_count || args->arg_count > MAX_ARG_COUNT) {
> +	if (args->arg_count > MAX_ARG_COUNT) {
>   		XDNA_ERR(xdna, "Invalid arg bo count %d", args->arg_count);
>   		return -EINVAL;
>   	}
> @@ -512,14 +512,16 @@ static int amdxdna_drm_submit_execbuf(struct amdxdna_client *client,
>   	}
>   
>   	cmd_bo_hdl = (u32)args->cmd_handles;
> -	arg_bo_hdls = kcalloc(args->arg_count, sizeof(u32), GFP_KERNEL);
> -	if (!arg_bo_hdls)
> -		return -ENOMEM;
> -	ret = copy_from_user(arg_bo_hdls, u64_to_user_ptr(args->args),
> -			     args->arg_count * sizeof(u32));
> -	if (ret) {
> -		ret = -EFAULT;
> -		goto free_cmd_bo_hdls;
> +	if (args->arg_count) {
> +		arg_bo_hdls = kcalloc(args->arg_count, sizeof(u32), GFP_KERNEL);
> +		if (!arg_bo_hdls)
> +			return -ENOMEM;
> +		ret = copy_from_user(arg_bo_hdls, u64_to_user_ptr(args->args),
> +				     args->arg_count * sizeof(u32));
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto free_cmd_bo_hdls;
> +		}
>   	}
>   
>   	ret = amdxdna_cmd_submit(client, cmd_bo_hdl, arg_bo_hdls,


