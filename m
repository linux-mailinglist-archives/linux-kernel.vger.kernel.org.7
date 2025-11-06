Return-Path: <linux-kernel+bounces-887869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93FC39458
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A24E18C27EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F72DAFD6;
	Thu,  6 Nov 2025 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pg0MqkIr"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A227FB28
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762410498; cv=fail; b=P0d2xkc6k0JGc5rJNC8yr2LhfqyI9EacFlteiQ/JIHw15Ju2YBKGdrpfDG3nVyTDiA2b/p2c7VRQW0kRVfkHjJIIWBY4TcM4Exazc6W8J2xwyJu2FuouajT/NM+0M6wqDP32GCSvgGqHdlvhc983x4ToIyoKQQjit+ehCcDn5fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762410498; c=relaxed/simple;
	bh=TnzcHlBTfy9a+WsUxxnSqbek5HBRI2O6qE4SPc5Y6w0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nLiE8xrIW+Lm577kyBdNDtl0Ou8DKCceYKpKjjtqua3S4saEVEMgCy5/tyBFR/Eio4JPnMyapCROrDIswrYqTj23R9c6Akf3gwXMIauas1u2GwTczW1d7MAxtzPd7UJk5RevzAAuAQjR84QzcUdDQ5d8obW4xIXcMKCNf/arRCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pg0MqkIr; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWKhxiNim9mTpmcpDyxOlaV/VH4hwj48O9BIGl3mimKAZUVV7WR5Qd4H12tWiQjWYUyABtQEri+iHrM3sZgGxto5sRGAdEwGmnsNW6Gn2U8sT7algSjTxneY66xAYqlDuHwEtgys94KL/kXy1nelhIWjnGYGs86JnPdxs/XprFosYHqxZain0gzKSspyOHDToXFTOFRoebha5W/gKnMTu52Cf9KgE9mqgfPB+obm9342Q2y/Ei3v6wl5nZ8NgNrygAVYMyU/uEA89PqnD6bmqt8svnVBbUIJ9soHnclYELnMPAWDOrpKmujX+1oWedH30fesDbTT0ShklfOhilyFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hfiKXw+Qv5kW5xi2S3iwBxJZGAAwyAkcNbncs/rzZg=;
 b=PVo9+QscVyCOSKEp8/LZ7u0OQh8wPAzDHkx3/msvEEJfmPFWtvwohKRFwUgE4iWW67Wv25Zxn5TmBTaVN6iWEvFl8Jz5uiqP5pJ5+WykJDGCnABk2t2iDXZJdzain0W0bNM3lMaN+uod6ExUyY4D8BYL4sbRR8X0wAJ7n+tzLQS/NMruOZINs8vVeopSLwGql8LomisvWJr2/cvim2Atr5SH6ouZIGc0W5i5ys7M/tFkypBjdD5NGFQOekl2sOI6/5PbuQjOQVcAZjzupYbfgt6Tp866CS5V8NfCL2j4+EhaK9f5YxYGo8iUxluAvP6jsuWQDI+0jIKPq7nDCWp/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hfiKXw+Qv5kW5xi2S3iwBxJZGAAwyAkcNbncs/rzZg=;
 b=pg0MqkIrwJV/R9ktQ99Aka+XLrAYcp/oCG/kri6fKl4H7SNIuK2aIJ9kXmFw3+Bxs5WtK0evUyUKuu/9L2W7Xz54mkkiHnnqasrMg4bs4rZoEMbcoQDVSdOA3Sq7TWv1XOo5OSQP5A3vx0Y/9oyxmprRRq4tGEJhK570EKrjgmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 06:28:09 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 06:28:09 +0000
Message-ID: <88ae0dfb-b10f-4829-8aa7-a681612704fa@amd.com>
Date: Thu, 6 Nov 2025 11:57:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 6/9] mtcopy: introduce multi-threaded page copy routine
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 willy@infradead.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 vkoul@kernel.org, lucas.demarchi@intel.com, rdunlap@infradead.org,
 jgg@ziepe.ca, kuba@kernel.org, justonli@chromium.org, ivecera@redhat.com,
 dave.jiang@intel.com, Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
 rientjes@google.com, Raghavendra.KodsaraThimmappa@amd.com, bharata@amd.com,
 alirad.malek@zptcorp.com, yiannis@zptcorp.com, weixugc@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-7-shivankg@amd.com>
 <20251020082800.GA28427@system.software.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20251020082800.GA28427@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2894c8-6c45-42e1-fea2-08de1cfda76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVhaOFlmckpaRVNlK0ZNUlJSSEtxNlg3QzdHUWs0MUFZSS90d2gyYjlCMDNn?=
 =?utf-8?B?dTRYWi9UOUp1SDk1Qzh0QmFkZWIvM3BURUMzeGJvelowRU90d012ZzNXUW0w?=
 =?utf-8?B?TXVGSHBIdGJhWGoxWHhWeG9sMkE0MkhNeTJOaWdPWTJ1dzdQVHF2QUZJVHRF?=
 =?utf-8?B?dThsZEQzU3ZSQjJtWXRzYmp6K1ZMVFBZNGhaQ00rR3JNVXZSbWIxVkpuaklN?=
 =?utf-8?B?NXhrREJoVlh6byt5eXZBS0N5emJ4aHlSQ2U5K01EOXptUnpyTFFtNG9nZkRu?=
 =?utf-8?B?QTB6UnR1YWhibHdaOTlhbzlZYUpZalRVNmtBWW9oamhtajUwWDErdlQxek9V?=
 =?utf-8?B?SHIzYnpqZDBVMy9sS1RZZ3pBMWdPdmJXYVVHUXoxaWloS2dQMXhEL05ZZW1o?=
 =?utf-8?B?U3hYODJyWStPVzdFeDlTQTMwdGxsS0FNK1FqQm93eU85Q1pMN0trTE9zSXRn?=
 =?utf-8?B?ZnV2WE1WVkZGZUZMYkpEUnc1SEVTWTlKQ3NqMHpZV3lFTkIxcU8rSmZaN0pk?=
 =?utf-8?B?N1J4eU0yMW1nZGl5TzNsNElkY1ZtZ3U1RGQwSzBnVVBESkNvWjZyTnNtUHd5?=
 =?utf-8?B?RFZaMDZ0a1k4NGhkcE43UWN1ZFM3Tk50SGxUMnU0QlhiOUZFR09wY2J2aTlx?=
 =?utf-8?B?NnJiU0g1WnQ0TnNLUVI1VFkxSlhuMjBtbWZwT2xhYllyejZEYjVybjhxbXg1?=
 =?utf-8?B?Tjh6RTAyL2xTUExpb1FxTzJYVE1IWXZKYzB6MTdoaWJCVkZnR0ZyR1RENmps?=
 =?utf-8?B?TTVtQW42a1FaL0k3d1RVN1BjM08zaXlXT04zcmxGM0laL1J1bUQ5WVozalVO?=
 =?utf-8?B?VTNCK3JLdlNSaVZ2VmtleElSRFAvYkc2ZmthQnBtM29wdlcreGpGd1I2aXlX?=
 =?utf-8?B?WGFnSHZZY1ZsbGVTWE91MmlHaE4xeUFMRGNUdUxUeEd3TmNOb29qQm52bkpK?=
 =?utf-8?B?WjhoYVQ5UjlFeENkVWRsVlNDbllOd3ZZSWVqczZVTmEyN2UwNHNreFRUUmo3?=
 =?utf-8?B?NTFWYTQwZVZZQmhuTlNsSEllVkkyRjh5dGttTnVJYlpvSXhnOVluRGYyWDJJ?=
 =?utf-8?B?dC8rUkp0blpLV2hYOGNyZy9DTG40R1diSG1EWjB5d3J2SXpzNDZhVVU2VnQz?=
 =?utf-8?B?MXNPUGdKZ2plcnd3VDJTdTQrOG1haXNnQmpwWW5QU2RDOC9JU2gyNGI0SWJT?=
 =?utf-8?B?aFNtUFhUaXJXZGFjU0ZVTW1hV0d2eVdodXBYamNHdThOcUhSL2J4RXEreHFZ?=
 =?utf-8?B?QnM3NVROV2xxZUd4ZWdPQ2Q1VG82aFFjaDNzdWdUTExkbkp5aUo2RUE1ZVdw?=
 =?utf-8?B?UHB5NUM3ZlAxQloyU29PUDdySFd0aThaekZjWXdYZzBZSGtUYTg2THd0UXJx?=
 =?utf-8?B?cGVGaG1wVEpYblJCSlAzYVNOekxaOGU1MW5GVldBL1NUbncrUHVPdkd3WGZG?=
 =?utf-8?B?NlVIR0V3RFllMVFna1pOSDZpQ2I5TkpxZkdLdngxdFZRY1JDM0hvak5PUERx?=
 =?utf-8?B?VHJ4T2hvNkdjUHpuTkI1OFNRK0VMQXJEMld3ei9KZWZKQUswSmh0TlFFY1Y4?=
 =?utf-8?B?TEgyU1MzZW9kc3pzdkdzYXpMdEppOFlQbnU4T3R4MldsWU8rNkhCNW5zY29M?=
 =?utf-8?B?MWtLamlkUjdWOFVKeWZNTHdMYzJJUGs2WXpJdnVmb3JmV0hPVVZwVzB4ZW9x?=
 =?utf-8?B?U0V1SlJvZkpJa1RUbkJ2UWxBbXl1SWxzUGpndExhbEpiRGp1RW93NjlDRm5a?=
 =?utf-8?B?Z29XaVQ5M1NTU3owS1hoQjNKOXIwbVVLWUJzdXJ2RTQ1M2tUT003WS8rUWVr?=
 =?utf-8?B?aXFXN3BnTkF5V1JZV1V1WnM0cEhFcFJMM3pQOFNTL0pRWHBLNUtmdG9tMUNE?=
 =?utf-8?B?R0JhekxsN09JV0lxUjBDc0pPL2ZxcDkvcXZGOHp3WHlGU3dUY0QyN1VWTmZm?=
 =?utf-8?B?ZzBNVWt3cWVOSkFYQWk4TjVsaGJtSmptMzQxR1V2WHBvUGpuMmpIU0Q0MVR0?=
 =?utf-8?B?NkVQWHBYZ0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFQ4Y1pCRWtvR3MzNTBTS015Ni9iMU82MXhNN0lpOVZ6a3JDanpXL1hET2p6?=
 =?utf-8?B?M1hOT1BQb2xGR3dtVjZhWitML2VxSW80b0VtNzFJMFZkbWYvMWhHUk85NHJv?=
 =?utf-8?B?WWt3c09zODlFdmdwSTVCek1IeHkxRHJha2tXeXFnOGk3VStmZ3ROMDA4eVFh?=
 =?utf-8?B?WWd6T09sRThyQk04VzlBWllmbG9sWXRSMVhUYzl0Zm01KzdNWTM3YXZtMGFX?=
 =?utf-8?B?Tnc0eDNRSzI1ckEvNTB3UDdkL2Z1WVA1TDNNU3lLZDJ4NXQzeHRwSXFXZUh6?=
 =?utf-8?B?MnhrSXRrQ2kvT0JYNUFPcHhsSWUrZ28yMGplTGplK2VYYVdnVzliT2tTQ3Ux?=
 =?utf-8?B?d0FsMUVIZVJCcnFhWVpqaHJXY3A2TEdsd2tyTkJvbXM1cHh3WndFMExZYXBH?=
 =?utf-8?B?VXhUN1NUK2JpRzFlTXRjVmdxODA0S3dXVzQ1YkRtQXRyRytTa1F2Q0U2dWFB?=
 =?utf-8?B?WTN2cCtaZWYvWDRJQ1ZHODV1ZVZRQUV2dUxMTWF5Q1l4azJwN0FqR1MrdC9O?=
 =?utf-8?B?SGxaeitYZDRLd2tkaVJVUWFEZG95blQ5bjQySm02alJKTjg5dXU1b3VYZ3lq?=
 =?utf-8?B?TFBxQUp2NnpMNE1tYzlSV3JUU09XbnpFLzZLZGxNSmVYNWNBYmlvUTVvTUFM?=
 =?utf-8?B?ZTZWR0RIQ2t2U3kxSUhNYmFvL3VHeEdmSE1kT3ZBeitsQmhsMW4xd3Fma254?=
 =?utf-8?B?bzFrRDZUTWN4cGxHTFd5MFRiWW9iYXdtMEJGRU5CS2dPUVlEbHBDc3UxNGZQ?=
 =?utf-8?B?L21XOGtyeXlOU1N6VWxzZlZST1Q2ZnlYWXlKN2Nrc1lSK2lPSWxicFVqcGdT?=
 =?utf-8?B?cVFEUEZnTGcvRG42Y2xvYVVXdEY5R0NVZVRraHZrSTZqTU9IRld0QVZvMzkv?=
 =?utf-8?B?Tkd5Vzd6UWl4Y3NoMHB4aEkvYlphSmE3SFJLYnRDQVRTbGVVWnlPSGdaSXBX?=
 =?utf-8?B?aWU4UThEdWYySDFlcGxVUVVqNDdwSVVJQ0ExaFhUMDR6TXVNdG1CdDk4SWhu?=
 =?utf-8?B?Y09HNlpJV3ByUkFjWFdBSWdCc2Y2UnpuTWNPTVVPYzVnT0RQTWcxaXkwOXdx?=
 =?utf-8?B?L2hVTzJhYjQ5THFsbHUxQW9mUm1nS01WbTBhQUIwdEkzbnhzVkUrRHlkcFY2?=
 =?utf-8?B?YWRCS3JUbmNTUjRJZU51QlJ6d3BLU1BPY1NZdllXY2g5eU9JQ0I2eDBCbllG?=
 =?utf-8?B?cHUyZVJ4Y2J3bThPT3hzY29hT1IzbnZVTmNNMWNGMG9TSGFmQVdFTXBmaU9o?=
 =?utf-8?B?aGlIOGxUbGpqaElOZ093YlpsVzlRczRnOEZzQ3NKMTFkL01IbkxXU3UwZjlJ?=
 =?utf-8?B?RFVVNG03WldOS1NBZE9Tb2xkVFhOaktQdFdRbHRpaEVTT1NzS3RIMlVSb25E?=
 =?utf-8?B?QVllTEVEejdHZTVHQ2JBYzR6ekprdUhLOHVnc3MzNUl5V1N3L2w4Nml2Wnh1?=
 =?utf-8?B?S2EvZW9XYnBuaUtFSHZCQjVEMTdQVXZBaXNEZjU3NVNlOEtmd0VmWnJyWmNE?=
 =?utf-8?B?ZFF0elM4U2tPc0plTU55UE83T2NIYmRacThEb2RwVkIxM3lrZ3lrRXU0MGdt?=
 =?utf-8?B?Nmc1aWdtcDU0VVpkT0szeGh0UlBqSmNTaXZzeCs2ODlUc0dYY1dsWGNBOGdW?=
 =?utf-8?B?QlJLTXBlTXNjb3Y5b2QzeGFCNVNhSGYwQmYzVmw1dkpzb2lnUUJTY3JnVWZq?=
 =?utf-8?B?UDdFVVVtVGNnV3dYVWJ6cnZlSWdHaHJQZnJDVDM5V2p2TXJNaG53c3ZERGtV?=
 =?utf-8?B?Smc5UmZHdTNzR0FqOGVkZ2xJREliZVMzMDZseFIxdVdGRURNZ2Fodm5GdElk?=
 =?utf-8?B?NENjZmpjNVdtMXd1L3g5OElzVUE5N3N0RDROSjNoVGNFMlFyWmE5bUxOT21x?=
 =?utf-8?B?SGRWSXVTbVZWUHhuZzJEVFFLcUdxSmY2dTVHS25OZG00Q3gzY3VwSm9aSDV1?=
 =?utf-8?B?SERuRXFyVnRlcjRaOTdqQ2lpNE85emdaaEd4Vkw5a0x4TlZIOHYxS0Y5VkZx?=
 =?utf-8?B?Z05jZHFjSE1CNjZJZW03S0R3UEVmbWdNd2o4TkpQUVRQZkFNSnVITzB3Y0hi?=
 =?utf-8?B?TFVoSGdEMWdibzVOUnhHa0QwVlMvYXBLTENSUllBUjdROGlwWmVlSVZSNVRj?=
 =?utf-8?Q?jZB5Pp0I3IaoInYRwhs4yjtUr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2894c8-6c45-42e1-fea2-08de1cfda76f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:28:09.6574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NezobGiYpDUfjmcUZc2gZUZzZdWRezRRpIvZ+XfE69WIoeH2xesOzN7D9x981uwCIzn4VW/82GQphKzd0KH8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556



On 10/20/2025 1:58 PM, Byungchul Park wrote:
> On Tue, Sep 23, 2025 at 05:47:41PM +0000, Shivank Garg wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Now page copies are batched, multi-threaded page copy can be used to
>> increase page copy throughput.
>>
>> Enable using:
>> echo 1 >  /sys/kernel/cpu_mt/offloading
>> echo NR_THREADS >  /sys/kernel/cpu_mt/threads
>>
>> Disable:
>> echo 0 >  /sys/kernel/cpu_mt/offloading
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Co-developed-by: Shivank Garg <shivankg@amd.com>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  drivers/Kconfig                        |   2 +
>>  drivers/Makefile                       |   3 +
>>  drivers/migoffcopy/Kconfig             |   9 +
>>  drivers/migoffcopy/Makefile            |   1 +
>>  drivers/migoffcopy/mtcopy/Makefile     |   1 +
>>  drivers/migoffcopy/mtcopy/copy_pages.c | 327 +++++++++++++++++++++++++
>>  6 files changed, 343 insertions(+)
>>  create mode 100644 drivers/migoffcopy/Kconfig
>>  create mode 100644 drivers/migoffcopy/Makefile
>>  create mode 100644 drivers/migoffcopy/mtcopy/Makefile
>>  create mode 100644 drivers/migoffcopy/mtcopy/copy_pages.c
>>
>> diff --git a/drivers/Kconfig b/drivers/Kconfig
>> index 4915a63866b0..d2cbc97a7683 100644
>> --- a/drivers/Kconfig
>> +++ b/drivers/Kconfig
>> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
>>
>>  source "drivers/cdx/Kconfig"
>>
>> +source "drivers/migoffcopy/Kconfig"
>> +
>>  endmenu
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index b5749cf67044..5326d88cf31c 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -42,6 +42,9 @@ obj-y                         += clk/
>>  # really early.
>>  obj-$(CONFIG_DMADEVICES)       += dma/
>>
>> +# Migration copy Offload
>> +obj-$(CONFIG_OFFC_MIGRATION)   += migoffcopy/
>> +
>>  # SOC specific infrastructure drivers.
>>  obj-y                          += soc/
>>  obj-$(CONFIG_PM_GENERIC_DOMAINS)       += pmdomain/
>> diff --git a/drivers/migoffcopy/Kconfig b/drivers/migoffcopy/Kconfig
>> new file mode 100644
>> index 000000000000..e73698af3e72
>> --- /dev/null
>> +++ b/drivers/migoffcopy/Kconfig
>> @@ -0,0 +1,9 @@
>> +config MTCOPY_CPU
>> +       bool "Multi-Threaded Copy with CPU"
>> +       depends on OFFC_MIGRATION
>> +       default n
>> +       help
>> +         Interface MT COPY CPU driver for batch page migration
>> +         offloading. Say Y if you want to try offloading with
>> +         MultiThreaded CPU copy APIs.
>> +
>> diff --git a/drivers/migoffcopy/Makefile b/drivers/migoffcopy/Makefile
>> new file mode 100644
>> index 000000000000..0a3c356d67e6
>> --- /dev/null
>> +++ b/drivers/migoffcopy/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_MTCOPY_CPU) += mtcopy/
>> diff --git a/drivers/migoffcopy/mtcopy/Makefile b/drivers/migoffcopy/mtcopy/Makefile
>> new file mode 100644
>> index 000000000000..b4d7da85eda9
>> --- /dev/null
>> +++ b/drivers/migoffcopy/mtcopy/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_MTCOPY_CPU) += copy_pages.o
>> diff --git a/drivers/migoffcopy/mtcopy/copy_pages.c b/drivers/migoffcopy/mtcopy/copy_pages.c
>> new file mode 100644
>> index 000000000000..68e50de602d6
>> --- /dev/null
>> +++ b/drivers/migoffcopy/mtcopy/copy_pages.c
>> @@ -0,0 +1,327 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Parallel page copy routine.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/printk.h>
>> +#include <linux/init.h>
>> +#include <linux/sysctl.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/highmem.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/slab.h>
>> +#include <linux/migrate.h>
>> +#include <linux/migrate_offc.h>
>> +
>> +#define MAX_NUM_COPY_THREADS 64
>> +
>> +unsigned int limit_mt_num = 4;
>> +static int is_dispatching;
>> +
>> +static int copy_page_lists_mt(struct list_head *dst_folios,
>> +               struct list_head *src_folios, unsigned int nr_items);
>> +
>> +static DEFINE_MUTEX(migratecfg_mutex);
>> +
>> +/* CPU Multithreaded Batch Migrator */
>> +struct migrator cpu_migrator = {
>> +       .name = "CPU_MT_COPY\0",
>> +       .migrate_offc = copy_page_lists_mt,
>> +       .owner = THIS_MODULE,
>> +};
>> +
>> +struct copy_item {
>> +       char *to;
>> +       char *from;
>> +       unsigned long chunk_size;
>> +};
>> +
>> +struct copy_page_info {
>> +       struct work_struct copy_page_work;
>> +       int ret;
>> +       unsigned long num_items;
>> +       struct copy_item item_list[];
>> +};
>> +
>> +static unsigned long copy_page_routine(char *vto, char *vfrom,
>> +       unsigned long chunk_size)
>> +{
>> +       return copy_mc_to_kernel(vto, vfrom, chunk_size);
>> +}
>> +
>> +static void copy_page_work_queue_thread(struct work_struct *work)
>> +{
>> +       struct copy_page_info *my_work = (struct copy_page_info *)work;
>> +       int i;
>> +
>> +       my_work->ret = 0;
>> +       for (i = 0; i < my_work->num_items; ++i)
>> +               my_work->ret |= !!copy_page_routine(my_work->item_list[i].to,
>> +                                       my_work->item_list[i].from,
>> +                                       my_work->item_list[i].chunk_size);
>> +}
>> +
>> +static ssize_t mt_offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
>> +               const char *buf, size_t count)
>> +{
>> +       int ccode;
>> +       int action;
>> +
>> +       ccode = kstrtoint(buf, 0, &action);
>> +       if (ccode) {
>> +               pr_debug("(%s:) error parsing input %s\n", __func__, buf);
>> +               return ccode;
>> +       }
>> +
>> +       /*
>> +        * action is 0: User wants to disable MT offloading.
>> +        * action is 1: User wants to enable MT offloading.
>> +        */
>> +       switch (action) {
>> +       case 0:
>> +               mutex_lock(&migratecfg_mutex);
>> +               if (is_dispatching == 1) {
>> +                       stop_offloading();
>> +                       is_dispatching = 0;
>> +               } else
>> +                       pr_debug("MT migration offloading is already OFF\n");
>> +               mutex_unlock(&migratecfg_mutex);
>> +               break;
>> +       case 1:
>> +               mutex_lock(&migratecfg_mutex);
>> +               if (is_dispatching == 0) {
>> +                       start_offloading(&cpu_migrator);
>> +                       is_dispatching = 1;
>> +               } else
>> +                       pr_debug("MT migration offloading is already ON\n");
>> +               mutex_unlock(&migratecfg_mutex);
>> +               break;
>> +       default:
>> +               pr_debug("input should be zero or one, parsed as %d\n", action);
>> +       }
>> +       return sizeof(action);
>> +}
>> +
>> +static ssize_t mt_offloading_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%d\n", is_dispatching);
>> +}
>> +
>> +static ssize_t mt_threads_set(struct kobject *kobj, struct kobj_attribute *attr,
>> +               const char *buf, size_t count)
>> +{
>> +       int ccode;
>> +       unsigned int threads;
>> +
>> +       ccode = kstrtouint(buf, 0, &threads);
>> +       if (ccode) {
>> +               pr_debug("(%s:) error parsing input %s\n", __func__, buf);
>> +               return ccode;
>> +       }
>> +
>> +       if (threads > 0 && threads <= MAX_NUM_COPY_THREADS) {
>> +               mutex_lock(&migratecfg_mutex);
>> +               limit_mt_num = threads;
>> +               mutex_unlock(&migratecfg_mutex);
>> +               pr_debug("MT threads set to %u\n", limit_mt_num);
>> +       } else {
>> +               pr_debug("Invalid thread count. Must be between 1 and %d\n", MAX_NUM_COPY_THREADS);
>> +               return -EINVAL;
>> +       }
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t mt_threads_show(struct kobject *kobj,
>> +               struct kobj_attribute *attr, char *buf)
>> +{
>> +       return sysfs_emit(buf, "%u\n", limit_mt_num);
>> +}
>> +
>> +int copy_page_lists_mt(struct list_head *dst_folios,
>> +               struct list_head *src_folios, unsigned int nr_items)
>> +{
>> +       struct copy_page_info *work_items[MAX_NUM_COPY_THREADS] = {0};
>> +       unsigned int total_mt_num = limit_mt_num;
>> +       struct folio *src, *src2, *dst, *dst2;
>> +       int max_items_per_thread;
>> +       int item_idx;
>> +       int err = 0;
>> +       int cpu;
>> +       int i;
>> +
>> +       if (IS_ENABLED(CONFIG_HIGHMEM))
>> +               return -EOPNOTSUPP;
>> +
>> +       /* Each threads get part of each page, if nr_items < totla_mt_num */
>> +       if (nr_items < total_mt_num)
>> +               max_items_per_thread = nr_items;
>> +       else
>> +               max_items_per_thread = (nr_items / total_mt_num) +
>> +                               ((nr_items % total_mt_num) ? 1 : 0);
>> +
>> +
>> +       for (cpu = 0; cpu < total_mt_num; ++cpu) {
>> +               work_items[cpu] = kzalloc(sizeof(struct copy_page_info) +
>> +                                               sizeof(struct copy_item) *
>> +                                                       max_items_per_thread,
>> +                                         GFP_NOWAIT);
>> +               if (!work_items[cpu]) {
>> +                       err = -ENOMEM;
>> +                       goto free_work_items;
>> +               }
>> +       }
>> +
>> +       if (nr_items < total_mt_num) {
>> +               for (cpu = 0; cpu < total_mt_num; ++cpu) {
>> +                       INIT_WORK((struct work_struct *)work_items[cpu],
>> +                                         copy_page_work_queue_thread);
>> +                       work_items[cpu]->num_items = max_items_per_thread;
>> +               }
>> +
>> +               item_idx = 0;
>> +               dst = list_first_entry(dst_folios, struct folio, lru);
>> +               dst2 = list_next_entry(dst, lru);
>> +               list_for_each_entry_safe(src, src2, src_folios, lru) {
>> +                       unsigned long chunk_size = PAGE_SIZE * folio_nr_pages(src) / total_mt_num;
>> +                       char *vfrom = page_address(&src->page);
>> +                       char *vto = page_address(&dst->page);
>> +
>> +                       VM_WARN_ON(PAGE_SIZE * folio_nr_pages(src) % total_mt_num);
>> +                       VM_WARN_ON(folio_nr_pages(dst) != folio_nr_pages(src));
>> +
>> +                       for (cpu = 0; cpu < total_mt_num; ++cpu) {
>> +                               work_items[cpu]->item_list[item_idx].to =
>> +                                       vto + chunk_size * cpu;
>> +                               work_items[cpu]->item_list[item_idx].from =
>> +                                       vfrom + chunk_size * cpu;
>> +                               work_items[cpu]->item_list[item_idx].chunk_size =
>> +                                       chunk_size;
>> +                       }
>> +
>> +                       item_idx++;
>> +                       dst = dst2;
>> +                       dst2 = list_next_entry(dst, lru);
>> +               }
>> +
>> +               for (cpu = 0; cpu < total_mt_num; ++cpu)
>> +                       queue_work(system_unbound_wq,
>> +                                  (struct work_struct *)work_items[cpu]);
>> +       } else {
>> +               int num_xfer_per_thread = nr_items / total_mt_num;
>> +               int per_cpu_item_idx;
>> +
>> +
>> +               for (cpu = 0; cpu < total_mt_num; ++cpu) {
>> +                       INIT_WORK((struct work_struct *)work_items[cpu],
>> +                                         copy_page_work_queue_thread);
>> +
>> +                       work_items[cpu]->num_items = num_xfer_per_thread +
>> +                                       (cpu < (nr_items % total_mt_num));
>> +               }
>> +
>> +               cpu = 0;
>> +               per_cpu_item_idx = 0;
>> +               item_idx = 0;
>> +               dst = list_first_entry(dst_folios, struct folio, lru);
>> +               dst2 = list_next_entry(dst, lru);
>> +               list_for_each_entry_safe(src, src2, src_folios, lru) {
>> +                       work_items[cpu]->item_list[per_cpu_item_idx].to =
>> +                               page_address(&dst->page);
>> +                       work_items[cpu]->item_list[per_cpu_item_idx].from =
>> +                               page_address(&src->page);
>> +                       work_items[cpu]->item_list[per_cpu_item_idx].chunk_size =
>> +                               PAGE_SIZE * folio_nr_pages(src);
>> +
>> +                       VM_WARN_ON(folio_nr_pages(dst) !=
>> +                                  folio_nr_pages(src));
>> +
>> +                       per_cpu_item_idx++;
>> +                       item_idx++;
>> +                       dst = dst2;
>> +                       dst2 = list_next_entry(dst, lru);
>> +
>> +                       if (per_cpu_item_idx == work_items[cpu]->num_items) {
>> +                               queue_work(system_unbound_wq,
>> +                                       (struct work_struct *)work_items[cpu]);
> 
> Thanks for the great work.
> 
> By the way, is it okay to use work queue?  When the system is idle, this
> patch will improve the migration performance, but when there are a lot
> of other runnable tasks in the system, it might be worse than the
> current one.  That's gonna be even worse if there are some other tasks
> that wait for the migration to end.  It's worth noting that
> padata_do_multithreaded() also uses work queue internally.
> 
> I think, at worst, the performance should be same as is.  Or am I
> missing something?
> 
> 	Byungchul

Hi Byungchul,

This was addressed by Zi in the mail:
https://lore.kernel.org/linux-mm/61F6152C-A91E-453B-9521-34B7497AE532@nvidia.com

So, there are some specific use cases that can benefit significantly when CPU cores are idle
while GPUs or accelerators handle most of the workload.
In such scenarios, migrating pages to and from device memory (GPU or AI accelerator) quickly
is critical and ensure hot data is always available for accelerators.

Thanks,
Shivank

> 
>> +                               per_cpu_item_idx = 0;
>> +                               cpu++;
>> +                       }
>> +               }
>> +               if (item_idx != nr_items)
>> +                       pr_warn("%s: only %d out of %d pages are transferred\n",
>> +                               __func__, item_idx - 1, nr_items);
>> +       }
>> +
>> +       /* Wait until it finishes  */
>> +       for (i = 0; i < total_mt_num; ++i) {
>> +               flush_work((struct work_struct *)work_items[i]);
>> +               /* retry if any copy fails */
>> +               if (work_items[i]->ret)
>> +                       err = -EAGAIN;
>> +       }
>> +
>> +free_work_items:
>> +       for (cpu = 0; cpu < total_mt_num; ++cpu)
>> +               kfree(work_items[cpu]);
>> +
>> +       return err;
>> +}
>> +
>> +static struct kobject *mt_kobj_ref;
>> +static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
>> +               mt_offloading_show, mt_offloading_set);
>> +static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
>> +               mt_threads_show, mt_threads_set);
>> +
>> +static int __init cpu_mt_module_init(void)
>> +{
>> +       int ret = 0;
>> +
>> +       mt_kobj_ref = kobject_create_and_add("cpu_mt", kernel_kobj);
>> +       if (!mt_kobj_ref)
>> +               return -ENOMEM;
>> +
>> +       ret = sysfs_create_file(mt_kobj_ref, &mt_offloading_attribute.attr);
>> +       if (ret)
>> +               goto out_offloading;
>> +
>> +       ret = sysfs_create_file(mt_kobj_ref, &mt_threads_attribute.attr);
>> +       if (ret)
>> +               goto out_threads;
>> +
>> +       is_dispatching = 0;
>> +
>> +       return 0;
>> +
>> +out_threads:
>> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
>> +out_offloading:
>> +       kobject_put(mt_kobj_ref);
>> +       return ret;
>> +}
>> +
>> +static void __exit cpu_mt_module_exit(void)
>> +{
>> +       /* Stop the MT offloading to unload the module */
>> +       mutex_lock(&migratecfg_mutex);
>> +       if (is_dispatching == 1) {
>> +               stop_offloading();
>> +               is_dispatching = 0;
>> +       }
>> +       mutex_unlock(&migratecfg_mutex);
>> +
>> +       sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
>> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
>> +       kobject_put(mt_kobj_ref);
>> +}
>> +
>> +module_init(cpu_mt_module_init);
>> +module_exit(cpu_mt_module_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zi Yan");
>> +MODULE_DESCRIPTION("CPU_MT_COPY"); /* CPU Multithreaded Batch Migrator */
>> --
>> 2.43.0


