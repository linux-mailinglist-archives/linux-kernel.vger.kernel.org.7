Return-Path: <linux-kernel+bounces-836798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B80BAA95C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A345C3A7A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDC91CDFAC;
	Mon, 29 Sep 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eShUf25T"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8A2BAF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176939; cv=fail; b=gn/oE4Z6z0uTJm3Tez0tjlYiknMUtj7V5nMkVV5NUlwW8ezUfJUtG1+WKu1pnRobi2ZD3hcsb/r197FqjPIZLcBTSXtw0w8wA2Ct5TJiEl+IEgdM6jcFivTFrzu5HkED1qCJPyPx3ZRPkh8oUZ7p479xz4Ly0ofMco++fRmI+gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176939; c=relaxed/simple;
	bh=5ndlx3fhw+lkkhdAubNIbcPHc2k7UM/ogDQHdNAz150=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hplEMDHKqc8V7V1JgGfG3PDzCfgYoCbxD9FP80eQvxMaOeMbpNjiU4P3sq6a9sYkjFDW1bh2fGOATfAaatZfGjgf1ghHX0rOwIwLX9x7h0Hb+qQFBVAqGFJCrn0DXtdTWeoM3eNyNWwInyKb+VY7zGRanofNTI4QAlyvj2X68KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eShUf25T; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHex5BWXBjCNsklAXfG1ZKzq3wMA4mBc7djPjizgFDDqxriTdOSI+r0wz+uHH9itqKO+4ed6ot057Bcz0dHgccRyGeqdmXv0toViaDK5gZWPVKeo/Ou7SVvkUm7FVG7MV25ZT8NF2cfWtnbDNlakIk043xcPfVWRKUhvrx0RpeUCCKCk2gPvdfEW1ALYduk4jxB81hy0tCsRpJBprWjtp8dzaBjQQSUsofbCvzxLT6l6kRhvFae8tfxJoex+2mUGe9vvdz3B1ib3GLOxrDfjwqwbFskWna+UUWjxn0nIbOQopensnhIqHnzCmD66/oVSR218P1iEP6DJi0kJtXw2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP7dE6KgjnLyOzkWzEVCroBnpKRUiJUCOiBRM4MZ1t8=;
 b=I2vmut6OTfTk9ba/02rdFznJkLjTrXMQqIZRyugPTbUQmyFG79GgtPkQAEdBK2zxxlypN5bvXysLsSPrFyEmW+ufj5yWD5kG5/lkRGDWN67kFg0Z3VpXZ3bGvO8QeyqbJPS5JTDDhrsusEGt0jGkVn+V+6Ya7k4HNn0nvjs/xBSUdESnzrO4o05GPL6BwdPbfOqfAdvVklKcqdpnKlY8WYgEbZxZ5RdjVh/5XtM2PxGfwV5wSmJF0eEuXMX1WQQ9Kl9Rh/7YC2FjRN8mYt0GTboqpwbjv/jTwHKr4znkbRFTsZOjf/t4cx3z1hYcS+aJBK5i/cotg13rC5yIh6O1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP7dE6KgjnLyOzkWzEVCroBnpKRUiJUCOiBRM4MZ1t8=;
 b=eShUf25TXsxwyDgPLBVG8w5gDaSCLj138AnAJXjxmVXg/xA/GC+iLiKPUxzmBTfPPDNzoQihl3uhvv9ec4J3G5kQR3L2s8innFf/Oy53VpR+IQX54sKq4HaQhe6Jp6ngEGZcMZKJRCldactIKWXZw2xWb0klf/VXdlzFTHcU7W6+fSzlg0hzktEYJSWUxCIRUsLA7GNhw01cbvRWF4dDfjOsJA8xYQU3upZdByUbCcJpssGQy+k5OH5DOgkdqbVI6Me7oEBoASJYi0qM+VZcBzM86zW4IJ1ZpkjLVSRdhpoDnZAdh+KULXmo8LczDGdDnL4ffuFK2mLyZhD13hY7HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 29 Sep
 2025 20:15:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 20:15:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: jane.chu@oracle.com
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 David Hildenbrand <david@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linmiaohe@huawei.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nao.horiguchi@gmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Mon, 29 Sep 2025 16:15:30 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <92AF859E-AA5F-4470-B1F9-0DEC3F7030B8@nvidia.com>
In-Reply-To: <c61ca94b-5b19-4c69-b2a1-d11a5301c6bb@oracle.com>
References: <68d2c943.a70a0220.1b52b.02b3.GAE@google.com>
 <ce93b55c-75a7-4b4d-a68b-9d80baf1578b@redhat.com>
 <DB0E39CD-36A9-4929-BCC6-33F27E387AEA@nvidia.com>
 <70522abd-c03a-43a9-a882-76f59f33404d@redhat.com>
 <B0781266-D168-4DCB-BFCE-3EA01F43F184@nvidia.com>
 <cad74ef8-3543-4fc5-a175-8fc23a88776a@redhat.com>
 <E82638DD-9E5D-4C69-AA0F-7DDC0E3D109B@nvidia.com>
 <fzfcprayhtwbyuauld5geudyzzrslcb3luaneejq4hyq2aqm3l@iwpn2n33gi3m>
 <80D4F8CE-FCFF-44F9-8846-6098FAC76082@nvidia.com>
 <w2kwxcd6br6h4tdn6xigtuf73qklt6jhxvhtcwp7idugycgxlv@vqjx26vrnwu5>
 <594350a0-f35d-472b-9261-96ce2715d402@oracle.com>
 <7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com>
 <c61ca94b-5b19-4c69-b2a1-d11a5301c6bb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b0b310-70fe-446b-5018-08ddff94f207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JadkIyRkFvdGVueTlLSkNJT0tjQU5HREVqUitYbTJLamhkWmtQZDhJMmdB?=
 =?utf-8?B?NTFpL05wTDlobGxKaytWRDNkaGhIdjdRSXlrQ3VXdSt2VWhabUVVdm1pSzEw?=
 =?utf-8?B?WkI4SnRtRGg2OVg4aEIvVVIrTFVXZlVGSDQwS3VNejV3NnZucHRONlBhbU1X?=
 =?utf-8?B?dUZuUXEyTXRkT01KNWZzU05OMW9yQmdUUm5keEM5L1lkcHQ2NFNLeG95QThH?=
 =?utf-8?B?V3J1cmFDcEdzUzdkalVBME9VeGMyZXFmemhCQWFRdE45dVVCYmIvbEpscjJ1?=
 =?utf-8?B?NFpDMkpQY0RUeG5OWHRvQnh0bnhNckFvSHRNUDNnQzJBdE51K1c3TmNBWFRG?=
 =?utf-8?B?eS9IOG55QzU5N3lzMm8reWFXc0NTVDZ3d0xzakE1TUFNSGV6bmk0QU9OS0hO?=
 =?utf-8?B?UFUwQWFZQ01pQXhhZVF4aFlSSXV0SmhBSWRDaS9lcGVoaEFXaVZjeU9mSGlU?=
 =?utf-8?B?dHZoWWpEcnlQRkFtR1krbWQ4bGpsOTlwUnpZeXAyT3dTd2oycmsrTk1MOVor?=
 =?utf-8?B?LzZRelJ1dDJaT2JsbDlwamRvZEdlK3pBN0d3akhWYS9HeDU1ald4ckRITk82?=
 =?utf-8?B?RURsODQzVmVwdEgvZSswTGlzQ1ZDUTdQaG9tWnJ3RnNqK2NRbjM0dkVYQno0?=
 =?utf-8?B?K2tjRk55V0w1TnhxRnpCU1dENjVQMWp0eVpBZ25IUGZHaDFTUXVIRSsrb2oz?=
 =?utf-8?B?ZTZTbGkwUWNpTmRzTi9WQ3BrL2NaNkw3VjNROVpCZmUweFhtbUwzV0pkSk5j?=
 =?utf-8?B?bE5SRFh3NzJXNDAyVktzd3AxTmdIU3NGRi9tMmlwdEFjKzNPbjd6SDNoYkta?=
 =?utf-8?B?eGtjTzhJOFpycWdnU1Z5RVhOUEJiaDZ5N2RaUllIazBnOW1MdzhPcDNpNk1U?=
 =?utf-8?B?aTEwejZnUDFxZmJsNFdFWDZUeG4rNkR5RUttV1hRZ1BaRHZPUXFFdTVXSS9o?=
 =?utf-8?B?bmwxWkVKOUJTMjZzb2g0QWdsS1ZvZHE2NkZEUjY4K2VMQUhpMFdHcGRtOWRP?=
 =?utf-8?B?clMwVzlMRFNCdGk5MTUxbjltTUxWSS9jRmRsdSs4NUtnUFpkc0h1aWs5NExX?=
 =?utf-8?B?bzE1dU1DTkozYU5OT0xYYTNndVFyaWY0WXNKUjJwWnd3Y1VxanFoR1g3dEwr?=
 =?utf-8?B?US9KUXQxL1FlOFQvMzlEdVRmdWwvN3VWdWUyMzNWcjdGTUl1OCtCQWVlZ1E0?=
 =?utf-8?B?b3VNOEZreFFCLzFueUNFd21BOXRCVmJCRXhjY3FjTEhPcWRrL3ZGc1JWUmow?=
 =?utf-8?B?UFlwRHhScFN3aklLRTFvL3J6ZmFGenBzbDcyUnVGZUE2T29Eb295bS9XQWJO?=
 =?utf-8?B?cW9Jem9hRGdwb0pCVWk0SmU4ZG9LK3R1Q3ZzRFU3ZDdPaStpY3ZlcjMzQmt5?=
 =?utf-8?B?ZXRVMG9kYytRem0zZ1hXMVh0VUVHWXUvTmp3eDFFb1NKdVY3Rmd0bTJFNUtv?=
 =?utf-8?B?cU9VeGxDMFdrUnFaMy9iWFRkcjA5WUVCNm1WSGN2cjArai9DR1N5a0g1ZFZp?=
 =?utf-8?B?dy9uQUduaWJQbk4rL0E5Z25mdzFhRjBDc2M1VU1WZlV4dDJqMVdSMEM5N0Rq?=
 =?utf-8?B?U1RyNjRseVJhVFVKRWJXQmd3Ty80NjB1QUZIMW93Q1h1azVIOHc3VUdTUHlI?=
 =?utf-8?B?TitTT0tGTWJsR3RHRzB2dnZIZlY1SERLOGpsNGdFaFNlMGNYVENZRXpybEk1?=
 =?utf-8?B?VjI4eE9Bc2NTTmppTWZFdGZpeWtUM25SeHNpdFlRVUM4c2RtR2t5OFFLUG9Z?=
 =?utf-8?B?WDFKbmNvVHEyeXVMUDRiVTZNS0xMMFdzN0pkaFFZLzdXd3ZvNklqM0Fna05U?=
 =?utf-8?B?WnVTV2cwR1A3UkFhWVl5ODRUc28rdWVNMzZ0K2hmOVZNSVRGZ1hkdDF4Nzdo?=
 =?utf-8?B?aUQ3RXZKWTNoUDBxNlR6by9qYnB2Q3BZd2lOMXlRU3Z0aU81cXRlQWMzUDUz?=
 =?utf-8?Q?6vXNUxMM8OTMqKeD+nhtGfHCs9ZHQjUd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylc3WDJOdHNQcnBZWVA5WjJkMUVsM2xXK2p4UUN2UitQbHdnR214eWpST2xi?=
 =?utf-8?B?VHIwdWVzRDdCbk90S2FDUVBVbWJIeDIwRTdneU9NLzI3SlF2aDVsSWk5RUR1?=
 =?utf-8?B?RHhCa2ZrNy96NmoxSzRTdTdDeXhhOXVGV3lpUk4wWHNQN2d4YnBoMWdSQnNo?=
 =?utf-8?B?YjZ5WnZlMTM4ZzY4c21HemdJSHN5STg3V0Q3S2loVnRkYzBUdzNJTThkUDJ1?=
 =?utf-8?B?b211NVJxeDZXdUhabndUQXgzT2xVUDdSbG1HSFhKS0hUeDlYd21NNU5qOXdQ?=
 =?utf-8?B?OVJvTUUxN0RsYWEzdU5FTXJBRW1RdkN4cTN6dUE3RzR6cmpoVHdxMHFLSnFi?=
 =?utf-8?B?MUxxT0ptYlJ0UW5WbHlxMml3TkN0VDFrWXlBcXJZTE1qOVE0S2RvTVpqdVFo?=
 =?utf-8?B?djJnNWNvaHVmU2FVWGw1ZXhPSEIzVjBwTDF1WHZtZW1kRnZIY3dwSVFibW4x?=
 =?utf-8?B?TWtnSFJSbkppaE1PaVBsR0FHVE1EWmFjUStpUDIxSkQ4ek5tcGYyS3RwL2JY?=
 =?utf-8?B?NzliU1JkeERRbGJjUlovbEVvQU5DNnUxZVJMOWIyZ0V3bFVWSGdoeWZxY3FE?=
 =?utf-8?B?RElvRHhnaXBKQ0EzRjZXWjFrT0xHQVp2QzZRNHdPZXFKNWl2QnRwdXM5WVNG?=
 =?utf-8?B?aHlJNmZsWHE4RzVTVjRldjMyMis1b1BuMUR4VUVIMjdMd000UERqc1NLb0xt?=
 =?utf-8?B?THBwei8yQW5uLzJiR3YreUdmeHZ5UlQwekRLaG51ekZsRGlqNVBqNklwbFZN?=
 =?utf-8?B?QWxEclNDWmsydk9wVUltTVh1QmpjZUp6Z0xFL1RYYWpUaWdxV3hGSkgyYUpX?=
 =?utf-8?B?MUREZ0pMalMxMVdkVGJrQ2J2MWU0MjRnSXNaUGxEaWFEMXhsQWlpRjU0ZHdw?=
 =?utf-8?B?WndPQXJKM2loS0RFM3Z1b3RCcGpYZU9MaDJ4VHI4VllJSWN1UlRlakg5TVBP?=
 =?utf-8?B?alFqeFlnd3pBejNDRVdpMHRCYyt3RklENkc5SzFJS2hzSlhrRW1OdDEzRmxN?=
 =?utf-8?B?Y0h6VjF4ZDUwUXdncWhlaC9qSXM1V3FhSkovUDZHR29WcEt5YVAzNEtsRFNy?=
 =?utf-8?B?eTI1ZVRFUGVLQ1JWeHFKaWhzOFJ1SkxwK0s5eUkvb1NNK1pZN2hkcXA4QmFX?=
 =?utf-8?B?NER3R3pqTG5iU1BhVW4wTEVRVkx3YW9zb1FDR08ram1acGdSYWpqeFBUaHV1?=
 =?utf-8?B?VHpuMkRocFlDVXpQRFducm0rUVpXQkx2d2lWOVVESWJoUWdibDJNTjRtNjhF?=
 =?utf-8?B?ZU92eGZmb3pVdnNrZWp0bjFZSWxUZHlWdGJGTkQ4TTJYdjVuc3RiYlNzOVhM?=
 =?utf-8?B?c2xsTjkxWDR6SzRZbUNTeEJvM1dETURLckFmaW5RQldoaEwrdHZqQ0QwWG43?=
 =?utf-8?B?bDFEOXJUV0xGeVNVUU1jd2I1a0VGdjJJUFcra3dockZmREJMSjd6YitNcmw0?=
 =?utf-8?B?OVBVVkhDRCtGQ1AvN2N4RHFPSUgzeWY5YkN5VnpBVnNTdTkrakFnVkxXYm9C?=
 =?utf-8?B?NFdaTHFSOWdpMzlMUUI0a2V6cy85enlhTDBheE4wSlp0MEgybzZYQlFmK3ow?=
 =?utf-8?B?TkhKUDROWG1sNGpmKzgrSlhkb0JzcmFZN2J2TWtxV3JOMEJXSHEwdXZVVnVo?=
 =?utf-8?B?UVdTZ3NQdVdyQWQ5bXR4Tkcyb01QY0dnZDZQMkVHdWVSV1NEWjlqYlJjU0Rs?=
 =?utf-8?B?bTdDaW5wMWovME44NXBsektNQmhLTndML0J4dlhGT1hkU1JUa2IyTWRQa3ZF?=
 =?utf-8?B?WVpXaTJEaXo3bk90Tmh3dnZ2K0tnU1NvRW1IK21EYzJKaDNrbSt5RmN0T3lK?=
 =?utf-8?B?SUtqQkEvcjZveXV0VW5HQlRpWkJDdXFYMHdldGQxeUN6NUkydEZhMk5NUXZC?=
 =?utf-8?B?YTNUbnAyRkNDVGhieEJOakZoSUdJRnNWV2lrakVrS3FvWkJkTi9uQ01aZnJR?=
 =?utf-8?B?di9nb1l0aDlRWUlBb1JJV25HTWEzR3gycUtuNEMrLzdldFNveWlNdUE5NkFC?=
 =?utf-8?B?Si96cnMzMzZtdnM3eDMzU3Z4eE1BR0JaZERuR3EzOXNOVUhNN013c0hRTHpr?=
 =?utf-8?B?anNxN2Q5elI5TEZzZVVwSCs1ZXhweDJsanRucEVXNG1kaE42bmQzdWtSdzd6?=
 =?utf-8?Q?XQ3KlnuoZPUzDnV/+X+o8qiqZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0b310-70fe-446b-5018-08ddff94f207
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 20:15:33.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNq4gRDoaAw3pFpWd8sEP3Aw+/HNrj70imwzSMQQ+mSjw41OJajax9b33JUbC3dC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454

On 29 Sep 2025, at 14:23, jane.chu@oracle.com wrote:

> On 9/29/2025 10:49 AM, jane.chu@oracle.com wrote:
>>
>> On 9/29/2025 10:29 AM, jane.chu@oracle.com wrote:
>>>
>>> On 9/29/2025 4:08 AM, Pankaj Raghav (Samsung) wrote:
>>>>>
>>>>> I want to change all the split functions in huge_mm.h and provide
>>>>> mapping_min_folio_order() to try_folio_split() in truncate_inode_part=
ial_folio().
>>>>>
>>>>> Something like below:
>>>>>
>>>>> 1. no split function will change the given order;
>>>>> 2. __folio_split() will no longer give VM_WARN_ONCE when provided new=
_order
>>>>> is smaller than mapping_min_folio_order().
>>>>>
>>>>> In this way, for an LBS folio that cannot be split to order 0, split
>>>>> functions will return -EINVAL to tell caller that the folio cannot
>>>>> be split. The caller is supposed to handle the split failure.
>>>>
>>>> IIUC, we will remove warn on once but just return -EINVAL in __folio_s=
plit()
>>>> function if new_order < min_order like this:
>>>> ...
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_order =3D mapping_min_f=
olio_order(folio->mapping);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new_order < min_order) =
{
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM=
_WARN_ONCE(1, "Cannot split mapped folio below min- order: %u",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 min_order);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D -EINVAL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> ...
>>>
>>> Then the user process will get a SIGBUS indicting the entire huge page =
at higher order -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_set_has_hwpoisoned(folio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (try_to_split_thp_page(p, false) < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 res =3D -EHWPOISON;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 kill_procs_now(p, pfn, flags, folio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 put_page(p);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto unlock_mutex;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM_BUG_ON_PAGE(!page_count(p), p);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio =3D page_folio(p);
>>>
>>> the huge page is not usable any way, kind of similar to the hugetlb pag=
e situation: since the page cannot be splitted, the entire page is marked u=
nusable.
>>>
>>> How about keep the current huge page split code as is, but change the M=
- F code to recognize that in a successful splitting case, the poisoned pag=
e might just be in a lower folio order, and thus, deliver the SIGBUS ?
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index a24806bb8e82..342c81edcdd9 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -2291,7 +2291,9 @@ int memory_failure(unsigned long pfn, int flags)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * page is a valid handlable page.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_set_has_hwpoisoned(folio);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (try_to_split_thp_page(p, false) < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D try_to_split_thp_page(p, false);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 folio =3D page_folio(p);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0 || folio_test_large(folio)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 res =3D -EHWPOISON;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 kill_procs_now(p, pfn, flags, folio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 put_page(p);
>>> @@ -2299,7 +2301,6 @@ int memory_failure(unsigned long pfn, int flags)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto unlock_mutex;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 VM_BUG_ON_PAGE(!page_count(p), p);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 folio =3D page_folio(p);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> thanks,
>>> -jane
>>
>> Maybe this is better, in case there are other reason for split_huge_page=
() to return -EINVAL.
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a24806bb8e82..2bfa05acae65 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1659,9 +1659,10 @@ static int identify_page_state(unsigned long pfn,=
 struct page *p,
>>  =C2=A0static int try_to_split_thp_page(struct page *page, bool release)
>>  =C2=A0{
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int new_order =3D min_order_for_sp=
lit(page_folio(page));
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_page(page);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D split_huge_page(page);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D split_huge_page_to_list_to=
_order(page, NULL, new_order);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(page);
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret && release)
>> @@ -2277,6 +2278,7 @@ int memory_failure(unsigned long pfn, int flags)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_unlock(folio);
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio_test_large(folio))=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int ret;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /*
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The flag must be set after the refcount is bu=
mped
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * otherwise it may race with THP split.
>> @@ -2291,7 +2293,9 @@ int memory_failure(unsigned long pfn, int flags)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * page is a valid handlable page.
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 folio_set_has_hwpoisoned(folio);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (try_to_split_thp_page(p, false) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D try_to_split_thp_page(p, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 folio =3D page_folio(p);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0 || folio_test_large(folio)) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =
=3D -EHWPOISON;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill_=
procs_now(p, pfn, flags, folio);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_p=
age(p);
>> @@ -2299,7 +2303,6 @@ int memory_failure(unsigned long pfn, int flags)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
unlock_mutex;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 VM_BUG_ON_PAGE(!page_count(p), p);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 folio =3D page_folio(p);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> @@ -2618,7 +2621,8 @@ static int soft_offline_in_use_page(struct page *p=
age)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!huge && folio_test_larg=
e(folio)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (try_to_split_thp_page(page, true)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if ((try_to_split_thp_page(page, true)) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_test_=
large(page_folio(page))) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_in=
fo("%#lx: thp split failed\n", pfn);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -EBUSY;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>

What you are proposing here is basically split_huge_page_to_min_order().
I can add that as a second patch.

> In soft offline, better to check if (min_order_for_split > 0), no need to=
 split, just return for now ...

OK. I can do that too.

Thank you for the input.


Best Regards,
Yan, Zi

