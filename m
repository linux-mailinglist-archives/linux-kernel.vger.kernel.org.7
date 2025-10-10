Return-Path: <linux-kernel+bounces-848501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFABCDE40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 685074FEF95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA425FA2C;
	Fri, 10 Oct 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KfqdaD9s"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022127.outbound.protection.outlook.com [52.101.48.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1D82561A7
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111543; cv=fail; b=JGbZfadK4TyavBR679WbisPL2HXlX2No2hiOd2XEHmsyZ7rWfbBG4eYlJhiSKRqlNZmhay09wJEvs+yikFCfrUFHpKWSKwdDOPq27sIKBdeQgm34KZbfIVqO2JgpN0fVWh1qOOUCrKIzirnIe8gWbjT60W9a2/LHHbEXlEi/byo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111543; c=relaxed/simple;
	bh=Y/tyxlrJIBADQnuAyxT4jyVUr1vYc6RKJrv1v7vYow0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+r7hGxyr5WorZ2N91a3cb0dSpTdmQgytU9jxOh0xSf70bAoV+hG7Jybwr1bjjXtZbLTg4MAvQzuhkFSFhqDuTg6lVymu51G55Ziuch9mESej4gMMqN09ERKicBbAqBBKJa85Ojyv2s9guOkxpPr/e6B85vsC9wis0yXXRZrZY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KfqdaD9s; arc=fail smtp.client-ip=52.101.48.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvMVMU1J9IbjGE6FIv98gjjmKm/hM3HDJumbNXooCBmbdJRr4SpyC8bQr93hCy5IfBZogF/GJ37ZMGz4vTG8LIFdYVV6tUP9SefNguHWOWxLHXEWpK+ZsmJ8OqJ85mLpfXZF9qCSyoPLum8/hb0eov+8WGCk2R1nqD4sNinTDHo6h1e8fIZKdYC5FVEV7MTjqOoTk5w9S9k0PkRQojPCzd4SfikBGV6x7Buoc1YS1f6BvpK3MiUTwrK6BDVwSXjY3Wrp1fGwgy/z3Wy7CeFeT73d38jAOk+q+ixfTAqYqnmQIDCAt/BRQ25DjSGszy8SN/4R+isrK3SRd9jwP2YYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwouJto+YYIBvYAnaXluBWKm1OJ8cLIoTk195ZIbn+k=;
 b=V3xevQPJfIP7VL2JeyX3A1c6ZOnjCAxUX51+hXIVvh+2doefmy984Be7fkKHLnmVDmLh/FOn1GmlqEUu2d1zSM6hIsXRn4iB9312md6/z2PQAx5koJFxoLlzjhGyKcjtyfEL2lp0NuRDYAVvQqiMwBkS8yVa0+sc9dkLLyqVQ8YeCsFYGtSDLGGycOHSxehpfmzor7XK06OCj1j8j/0m+vsIjpkynEZYqNXZWweRMBQMXu0zF9IKr4chc+es9NSLC4iSUKo3Dol7PIoVkcDKvDRUaNT03yqavpgqQbA9bq3QreIe9EanL4tNjpW58hMjAm1IonuwyD7aUGtTuCI+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwouJto+YYIBvYAnaXluBWKm1OJ8cLIoTk195ZIbn+k=;
 b=KfqdaD9sq/rBrM+oG05kExTYfJ5rPiPnw0vtOVV+fSfW11hnTOgvvT/MzoH7EKqg0+aY5b+nkpVapHbs0m+w8uVCnFqWn0M7zvbeRGdDPb4X+PJDUVmD96/JYnYUykAZAzBgwHFaW2aVL+p7TIO4hkU9HVLO6J2aulMFxQSAyIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB8190.prod.exchangelabs.com (2603:10b6:510:291::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 15:52:18 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 15:52:18 +0000
Message-ID: <c1afa431-ef27-40da-a15b-06674a72f7d3@os.amperecomputing.com>
Date: Fri, 10 Oct 2025 08:52:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: pageattr: Explicitly bail out when changing
 permissions for vmalloc_huge mappings
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 catalin.marinas@arm.com, will@kernel.org
Cc: gshan@redhat.com, rppt@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, tianyaxiong@kylinos.cn, ardb@kernel.org,
 david@redhat.com, urezki@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250328062103.79462-1-dev.jain@arm.com>
 <831e9e0c-a61b-40d8-a8d2-747b760ba6b3@os.amperecomputing.com>
 <6f40ee64-6ef6-4741-8319-ae330df881a9@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <6f40ee64-6ef6-4741-8319-ae330df881a9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:930:1e::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 766f21cc-90ea-4d36-720c-08de0814fda5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3dhWUFtNmdOT3NHMWplSG9tQnNZZDVwUzdYeFN3bVlsMEZ5bko0YnhUODdm?=
 =?utf-8?B?WEU3WnBjcitKck5ySWZuMGpMZitTRW0yU2orcklOMkFkVjExWEtmS0gxNnlD?=
 =?utf-8?B?RXNqQUNWS1VMcXErQmVDcE9Fa1JxYS9uTWM0YXFFdzc1QS9janFlRDUwaFg5?=
 =?utf-8?B?a3dEVmdPSWdWVFRFNTN6MS9qaEhxYjlqenFJVk1JcUpYRWozVG9UNUJPQjlh?=
 =?utf-8?B?NERWLzVoWGptMlNxNjNMdHJTYzdjNGhQVkhWNXkwbnNiSmp4M3lVRlRhUE5n?=
 =?utf-8?B?Vm5LMm5RS1YxVmlPTGoxWTROOUFMd3pXSU9hV3BTMklaUjgrT1k0Zm1BTk9K?=
 =?utf-8?B?VXFBZkFPSnAyMVIweVZXZ2hhQk4wMkpLVnpWclhzVUFWNndBa3ZSVUtYRisz?=
 =?utf-8?B?UlZER3RzbEVEYzd1dkRuckZxZW9vTVZwNENSMU8xN2dwdzJ6a0NTa3ROOG54?=
 =?utf-8?B?ZXpuNlYrRmJ2aXg1VTJ4VlFaMmFrRUpmcGh3VGo5Z3l5R2RZUU9LVHlrVXVX?=
 =?utf-8?B?aENVQVpPcUw2bXBLb25jcDh6aGVPVDVwVHp6clBKbGZYb3ZCOER3ZDhKSEsx?=
 =?utf-8?B?TnlmbTh2anNSQ2lRazZ2MHlWWGIzZU92QU5TNGlrQWxpT21TaXE0NWF1b08w?=
 =?utf-8?B?UnNkVkl4MU03L3Y5ek5Dbi9BQWNGeVhiTytBWmk0VW9nb0lueGcxQ0pzTzc5?=
 =?utf-8?B?K2hKdEtjTVhFbUlHNGYzLzRKb2hDUjhZYXNTc2ltblRlWVRqVXBuUkZKcmF6?=
 =?utf-8?B?Mk93eHM2R0RudVlOa1ZkbEh3UnhnZEZnMDF4QUc2a2xxVG1DS2lhYjU4blVY?=
 =?utf-8?B?Y3ZHeld0L0lQeGdrSE5qdDl1SE5NdVkxU2UwTTBSSFlFREpITzlYNnRBa2lz?=
 =?utf-8?B?Q0wxdWZXV2RqclZtMHJKNklNMEU0YzJYY2dTeW5HYnVZUkl4K3hYSFhkZ0pq?=
 =?utf-8?B?ZXNVcU82NzVVN2RVNDh4U0dNSThiUVlOZEhmcXVDMkxLK1czNVVuYTcvZ29M?=
 =?utf-8?B?TmlWWDdKQ2RxaTJ1bkx2RUVzQ1gycmhyK1RzU202VXNkTk9GeTVBRlF5STJL?=
 =?utf-8?B?R0Z4NHQ0RUVXK3NIeklFT2Q4dlVYbVcxVVYrMTRrdHgvYkZyL2NUT3hsU3o0?=
 =?utf-8?B?Zlk0TjNVY2J6amhZYW01TnVvTDNvNHA3UTV3RlIwSUZiV0JET09XdTZzNk1H?=
 =?utf-8?B?L3ZQWWEyM0p1M1NzTTI4STZsUjltYTY0Qk9vSlNLdVB6dGJnVWRpam50MXNT?=
 =?utf-8?B?VGE2YXAzMnNud3VRd21oVDM5eWVjWldIVUIzd1o1cW5WVUVCb09RdXp1akRF?=
 =?utf-8?B?MTY2bUw4Q3NENkdvZk5sNEVhL2xZUjBoZSsvcGoycG15eVQxTDJSUjVRSHlK?=
 =?utf-8?B?Z1RPUUEvMzl6MlFyUC9MV1ZJN2FsZzN0cnRTdnhnYnNaMzVZbFFLU21rUVZW?=
 =?utf-8?B?WTlUYXBrU1RKRVI0YVdwTDFvRWdFdHE0ZmUyRXZPTDRHVGtPQ1NtQW9IMFh0?=
 =?utf-8?B?MVFHRmZZcEQzQ3EvZ2sxQXVyenZyZzB5bUE2bGRGWml2WVhQcWN6VFpaUXJ6?=
 =?utf-8?B?L2dTd3VpRFlOUnpSMStCbmM5VlNRNnYwTzMyYWNzeDI5cjUvWTdDUGY4dFRu?=
 =?utf-8?B?OFM0OWdwMlNNRVVIdVJRT0ZIaksxRmpjbUZSaEFDRzA1VlFEemJxNnlIY04x?=
 =?utf-8?B?NnhydEtDbkhpbFJFUkd2TjRRY3NlU0x4aHV2aXcvS3d5eUR4YzFzbUR4bER3?=
 =?utf-8?B?YytNTFJVK1FGTUthTXRCeFdNZGxMenkrOGh4SHp5Rk1pK2V1NndUT0ZhQTRr?=
 =?utf-8?B?TkR5SkJVVFlxbEFPQzk3YUhTMDlDVGN4emJPK1E0NSs5c013ZkV3YlREeGZL?=
 =?utf-8?B?ZVpIZTAwNGhPYmNid2wxR0hUd0hKSzI2ZW1xUTFPbFBmeTNuZnJqekFkcVlu?=
 =?utf-8?Q?b9/5pVXgow13OCGtCymqHDzJIFNrMPg2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ei9YaUJJdmJTb2JhSlFoODRLeEtlbVR3YlJpaFVXVnZhRGtwWDFxYTVtckNr?=
 =?utf-8?B?aDI0UzJCeHUrdHZBRlFvaHpuR3VjWThEOEV6VEYrQSt5Tk8zQkQ3eDhyelZr?=
 =?utf-8?B?UkQ3N3E0K05rbHYwWEJBSVRDdEgvUC9SbC9PeTA2UlN3WFlRRlIzZ1ZZMGJn?=
 =?utf-8?B?Y3ZKREMrQU4rQmpjaTh2bHJMdFk5bzJTM2FLWkE0Ym84NFJNZWo3bEx6UURH?=
 =?utf-8?B?ZWxsS1MxdFU0R25FVUNKaWpzQVpnVGhXc1h3UlZhNTRKOFRqQk9tRVdQNC9j?=
 =?utf-8?B?VWQrTU15S1RXS1JNcXlsa29RR2h0b3k2K0tkUkFLMUlvOHU3NVk4djNzRVQw?=
 =?utf-8?B?V2w2WVVnMUtDRUJKaDBKejJKWWY4U0ZYN2xsVXJOcEJDZEpxK0Njd2l2bzRm?=
 =?utf-8?B?ZzduZlc1cGl4NmFZTXdseUZNUHJLdm1KczNuMGhJNk5mSzVEdy96TEN6V3da?=
 =?utf-8?B?S2VHTE9QL0dySmNyUzRHb2U0dExIVWZFajczcE93VlJMUGdQRk94UnExMGwz?=
 =?utf-8?B?Z3BjdkEyekdFUHhaOUhheFRoNjRCMFVFUzlUSDVEVzJKK0gySjEwa0ZJWHJi?=
 =?utf-8?B?M21raG56cWhYZER2am1BZWt1cDJLVmVZQUJnN1VpTVdKMDRiMW5HZE44RHR3?=
 =?utf-8?B?NGFqQVdMVUJrYWlMYXg4UFFOdEhVZFRsNGR0RTZqZ1lGMmpHZWJOUHNRbFFJ?=
 =?utf-8?B?M3dMT2l1dHZLcXVLSHdiK1Y5T2tLM2lDVThDNDZQMURFTE43Ni9hZDhqOFhP?=
 =?utf-8?B?eWFQU2JOMllzWDhDSmg1OW1KS3J3cFNrU1VvYXBaNUNPUTdlcThmcGFpendE?=
 =?utf-8?B?MEpWQ1kzWW5kQlFkbEVqSVAvZWIzZDNxcThoQXZFdGlKcGw5bHZSU1U1TytN?=
 =?utf-8?B?OFgzZDJFczg3aDkzY3laOXBQUUM2WFFMVTdFeWhXcHFJdE5wUVgwU3g3TnFJ?=
 =?utf-8?B?WGF6Rld5NmdrbUhRemljSlFmT0VyeDh0NGdMWGZsRDY2aGd5d1E5d1RhNlJW?=
 =?utf-8?B?OUs4OCtncGRRdGc4THliQzVpdkd2VU5tTzJwRFhIYzg4emxkNUJZaUk1aDVU?=
 =?utf-8?B?dkNmNXZuaTZBU2UvcFdPSGNlSTRNU3FrVHZaY3hPWXBMVTA2OHBBa1hwMXpS?=
 =?utf-8?B?eVVYc0JuSldvVmlyWGhCeE5xS1A0Z3plQXMycE9uQ21CSkpFWkM5anR0SHNB?=
 =?utf-8?B?N3FwTklBT0ZqVmJ6MFZkY1pFV3RtcU1kRkZSSGpmVjI4RVdQTWZQRk4wcmQ4?=
 =?utf-8?B?OFNpTjllZmVIcXFyTzRtN0x6MkVSTXdFV1hkbW1LSFpCWExZZkVGZXRGTUdO?=
 =?utf-8?B?MXJ1ZndITlpFc3pGRjJqMlNDbThDY0tlV0dhazJhc3ZrKzhrRjZUVDF2Z0cy?=
 =?utf-8?B?dmRvSkJnTDVSWFFXV3E0K3Q0eWZ0bHZxajZZV2Vad3hsU3VnMVRDQ1ZGZEdO?=
 =?utf-8?B?eVZXdG9mZlk4T3d6cW9iR1JCYjZqaTZ5MVBCelJPMTB4TlZmQklWY1ByeXB0?=
 =?utf-8?B?eElCVVo1L1JFK1c2cGdnTzhkS1NzbzJnQVNsWEhEM2h5MUdDWFpKdElhZWVp?=
 =?utf-8?B?NEtXaU1pY1dPVUxkdGpsMzVLSW8rd2l1MnVWdmJkS3E3bmNZeEtBSUJCYjg5?=
 =?utf-8?B?UFRjSUZIemljWXNkSkd5eXY4Qm01QzNjbThkMStrM1JZcy8yWUFtVnhXcXRt?=
 =?utf-8?B?UXRiVkxySFdjbFJtQmZPaXdPbXF0WmVETGFPMURHM0d4eEExam90ZU9TcVVC?=
 =?utf-8?B?VEtxNWhRWWpsUzFYTC9wZWp1R01Vd2w0ZnZ3S0ptajYxQXRSNkZyYUdHekZ1?=
 =?utf-8?B?OS9QUjljUmY0Rmx4RUZQQmNvZ2hTc2orT1NnTUVaMXFzZmZzSS9SK2YvbHk0?=
 =?utf-8?B?WXhlOHlBTTBKMWg2WE52cFpmS3VVRTFlT1VLbnNjT29GMWsvT1NlNXAzdEp4?=
 =?utf-8?B?U0pMbHVYaUhVTC93WDZzb3hIeEQ2QStTSGpjYThaYkt5WXEyMC9TLzM1OWdr?=
 =?utf-8?B?V0pFU1hrZ0dYeEdWaElpN2lHNW9uV2U5N2Y4QnNvVXBXbkJvWFFjVkF1Q1FH?=
 =?utf-8?B?R0NaOHlGMDdVYmhJTUZYdlJFOWU4aForeFNrTW9oWmJ0OHpJZUVMaWM3dk96?=
 =?utf-8?B?NUcrS1lDVVM1SXJHRTJEMWhOVzZ4UHRqZ1hpdm5td3ljNzNYMTZuRUdLRnky?=
 =?utf-8?Q?aL1tcx0zljjSyJHGl7jRiFk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766f21cc-90ea-4d36-720c-08de0814fda5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:52:18.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PrX6PuMN83QE2g/HvO/kUheeH0JZClV8rrQPXSQMzXZkP+minDq3lzFF9MMqnUxYznOjgDROqL7+wuoThkGCDPA0R7Jv3mmtUAAN2DN/SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8190



On 10/10/25 2:52 AM, Ryan Roberts wrote:
> Hi Yang,
>
>
> On 09/10/2025 21:26, Yang Shi wrote:
>>
>> On 3/27/25 11:21 PM, Dev Jain wrote:
>>> arm64 uses apply_to_page_range to change permissions for kernel VA mappings,
>>> which does not support changing permissions for leaf mappings. This function
>>> will change permissions until it encounters a leaf mapping, and will bail
>>> out. To avoid this partial change, explicitly disallow changing permissions
>>> for VM_ALLOW_HUGE_VMAP mappings.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>    arch/arm64/mm/pageattr.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 39fd1f7ff02a..8337c88eec69 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -96,7 +96,7 @@ static int change_memory_common(unsigned long addr, int
>>> numpages,
>>>         * we are operating on does not result in such splitting.
>>>         *
>>>         * Let's restrict ourselves to mappings created by vmalloc (or vmap).
>>> -     * Those are guaranteed to consist entirely of page mappings, and
>>> +     * Disallow VM_ALLOW_HUGE_VMAP vmalloc mappings so that
>>>         * splitting is never needed.
>>>         *
>>>         * So check whether the [addr, addr + size) interval is entirely
>>> @@ -105,7 +105,7 @@ static int change_memory_common(unsigned long addr, int
>>> numpages,
>>>        area = find_vm_area((void *)addr);
>>>        if (!area ||
>>>            end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
>>> -        !(area->flags & VM_ALLOC))
>>> +        ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>>>            return -EINVAL;
>> I happened to find this patch when I was looking into fixing "splitting is never
>> needed" comment to reflect the latest change with BBML2_NOABORT and tried to
>> relax this restriction. I agree with the justification for this patch to make
>> the code more robust for permission update on partial range. But the following
>> linear mapping permission update code seems still assume partial range update
>> never happens:
>>
>> for (i = 0; i < area->nr_pages; i++) {
>>
>> It iterates all pages for this vm area from the first page then update their
>> permissions. So I think we should do the below to make it more robust to partial
>> range update like this patch did:
> Ahh so the issue is that [addr, addr + numpages * PAGE_SIZE) may only cover a
> portion of the vm area? But the current code updates the permissions for the
> whole vm area? Ouch...

Yes. I didn't see anyone actually does partial range update as the 
earlier discussion said, but this is another "footgun waiting to go off" 
too. We'd better to get aligned with this patch.

>
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -185,8 +185,9 @@ static int change_memory_common(unsigned long addr, int
>> numpages,
>>           */
>>          if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>                              pgprot_val(clear_mask) == PTE_RDONLY)) {
>> -               for (i = 0; i < area->nr_pages; i++) {
>> -  __change_memory_common((u64)page_address(area->pages[i]),
>> +               unsigned long idx = (start - (unsigned long)area->addr) >>
>> PAGE_SHIFT;
>> +               for (i = 0; i < numpages; i++) {
>> +  __change_memory_common((u64)page_address(area->pages[idx++]),
>>                                                 PAGE_SIZE, set_mask, clear_mask);
>>                  }
>>          }
>>
>> Just build tested. Does it look reasonable?
> Yes that looks correct to me! Will you submit a patch?

Yes. I will prepare the patches once -rc1 is available.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> Thanks,
>> Yang
>>
>>
>>>          if (!numpages)


