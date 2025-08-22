Return-Path: <linux-kernel+bounces-782756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649FB324E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A6A07F98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024427FB2D;
	Fri, 22 Aug 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PxrPFpq7"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327C20322;
	Fri, 22 Aug 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755900627; cv=fail; b=CfCHiOzPlI1cvGvqmXH/UZ8asGz6ge0Elf2fLxFO8sWHG626pIRm8TAhjwbunw5O3ryBZCfoAP0XLB+EmQtFRgTPPL82j0MrGEuuLBXWleAcs/96en0sdg1QuerpVvHveFlPidTd0jDQYb6JYiA4ydtuyNahgAr2Pm2T/gpQ0AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755900627; c=relaxed/simple;
	bh=57fimTeWT206jgcn6DyhavDo43C6o/gCSvHF9ODp0kY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tu7GerNXzyFm1X0sQmChhzcNGSHh6GKdxo7UFogJVCDu0aga22GLqHOD/4jpqoP8984ebI5+sf2YOaTRF+Iw4EdQcvLJUnd3+6PLGbV0bDPi4d75sQbjBjCv374odBv/Q7ncBIex0UWxMGKPyeuABtU+6g5i/vJX7UAnZiSZQEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PxrPFpq7; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azSLV66Go5wEk5zUYvAoyp5o9cMba+XdxLHlV937hXx4whFc71SQ+7MjF/HhYnIUyW84qKHYBXlPmojq0V2oRyfRSkdoHkZaAWPWwMrZKBqj8jfY5KFYNJn4hCiqZg5h++0u8KZx80sHU2CanNHkcB39ANpns4A4gizl3XEdCQBw624EszQAU01CHFOQzp30B2FFnd+qMBpJNQtL9EQsCmkH4ov076XFOiVf+TmpKEdD7gBR8ZEr4jVor0aoIvTuIhQstb8vfENEQ9qlcgOukY3NWacS7B38DMyLmlW623D48bRq7mbIf26H1bEGsjCDScAbwFD9/ocg73NT+eG+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zXzUbCRV0IeEHA5fV1FtVGrBjHNXdVsZma63kzv4BM=;
 b=LpCPuRVR+fWH0g4MOxQKI685N7ojNkcZnNWg5+AUfRvkaUia0FV5mZjuiBU52yMyCe84JgbnpvPopFEOjWFRpJUpKBU04VfBhVbozGBK73HbF5epgJzoS33QBj0vQkwq7gKSZ2KcIW4wR5xAzvuGuIApr9nML996l5tRmYuOGysmrHpePV/9cJmPmq2awuNkwAknDV9rvepj8wEr6YJnhRNUKgXHKQoBTFsmd1vv78xYxmqq9K9nNtBvoPZtuwPsgyi2L/u1d3/yo+ByoioYL6b4tUrTY5gPGNol3rS+VTxFTEliv5cpiHbtVvIyz54buA1c2jubBx2pTtyHncnXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zXzUbCRV0IeEHA5fV1FtVGrBjHNXdVsZma63kzv4BM=;
 b=PxrPFpq724dHpx1+nG+6grx40q4gRYjh2r7r6hrtjqCeViBVlXtlC9BavVKWypdxLEHCFxv3OtsDN62AywCSPwKEGy8qJLRvEyvUNH0c4vQfntaZXo/DtaK2QwCV1yHVfWzyLQa+Wktc4q8XSgGvE+Eefj1a7A47C0S+jVB8qkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW6PR12MB9020.namprd12.prod.outlook.com
 (2603:10b6:303:240::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 22:10:23 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 22:10:23 +0000
Message-ID: <2e6714fd-561b-4e54-a562-1c85a7933af6@amd.com>
Date: Fri, 22 Aug 2025 17:10:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] x86,fs/resctrl: Implement "io_alloc"
 enable/disable handlers
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, manali.shukla@amd.com, gautham.shenoy@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <40ffabb62f9f36aae6a8dc26e5f2e376a3dee23a.1754436586.git.babu.moger@amd.com>
 <53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:806:20::33) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: ea37b1cc-0609-41d2-7a83-08dde1c8af49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU5CRzdmQXZsdUltS1A0VHNhVmZQRWRKZDZtUUh3UzF4bjd2eVREMTNOR2Fu?=
 =?utf-8?B?VldmTDdobjhoOVd6UVpic1htbXF6NytTUXFYMy9UcnhQY09odkR1MVRaUlpT?=
 =?utf-8?B?WUJvQkNxRHlNOTJsTGhvV2x4N1JYVjJHNGlVZy9SVmlvaHpZOWI0Q3dieGFC?=
 =?utf-8?B?T3RTa1kyM0JuZm1zVkljY0tSWWpxL1VVbUJMbHNjbUF2YXVVNDZ3dzlkcDU2?=
 =?utf-8?B?aGg1WE1xd1l4YXY5YjQzaHM5REVhRDZRTHRkMUFCaS92aE9rRmViR3Bsejds?=
 =?utf-8?B?eXBWdWFERFRJYnBVTVJGSVRGdmhaSlVsTDN5a1hkLzNKTUlYWDlqNXMrcjQ2?=
 =?utf-8?B?YlA1Wjc5Y0xlck4xMTV2aW5kSVlDUmRwaFZWbmxyMjM3Tk5aMzU0RkY1bk83?=
 =?utf-8?B?a0EwYkZoc09kc2VoZlRJNTU4dVZ2aDd4NHBlQ21kSXp4MEZSRDEwNTFZQ0s1?=
 =?utf-8?B?dWhnUXhpcnVYVGcyTnRKNy9WY29vRURzR2ZJYmorRHF6NmVlbUdrbGQ1Yll5?=
 =?utf-8?B?cDZXVnhKZjdTOERJcmp2bTBOS3k2Nnp2YVZ5OWRyQ2lqWEtuMGVUTzh0QlRy?=
 =?utf-8?B?OGNaWnNaWFYyRUFNSWk0aEl4MURlT3Q0RkxsV0psN1gvUW81TjlJVXRGMkRk?=
 =?utf-8?B?YTQrUGxRK0pOek5YTlpMRngydTZNL1F0MjVOUncvL3Zsek8xcjI1NkplTmNW?=
 =?utf-8?B?eVU3QWozaEx1cGZCQlRFckNEb3VPREo1NE0zME9mUTdMbldYdlR3bFBROHRi?=
 =?utf-8?B?eFgrcytMWG93MFJwZXBqcjdwa1dLTGNhU0VCNktud1JHaHVvR056L1RmWUs3?=
 =?utf-8?B?V3F1ODVUdlk0NEhicS8rZDZOS2xtZUk1Y01Gd29odmIrVmR2N1c4MEErZTRJ?=
 =?utf-8?B?NHk0L0lZR0Qwa3E4am8yMXVBNlhZaVpHbkZWdmNLZkhKQjVWTDEzd0hUZnFE?=
 =?utf-8?B?NVorbTl0bERjWGpzQ3VPdzJZSTlOSFNRSndRckFlaFF6dGhka2w1ck9ySjFo?=
 =?utf-8?B?ZGxUUTQ0QWZDL2ZJYWpOS3gxK1laY0FHNUgrTmFlVncxTHpZUExOUmwrSWhQ?=
 =?utf-8?B?VUZUTnZqQkJHemp1cFJycklLdzFDSHJGVTRwN2RnTzlnR0lSdUtOUFBmTm5H?=
 =?utf-8?B?MUhOaHhBd2ljbzFrT3hoeWlOLzJ0bFRlaFF4UWFXWVFGeDdoVEtlRVhKRlgw?=
 =?utf-8?B?YmRhUHdWTTZYWDdhMmxiN0FvTjRYZVFiTUMzQnIzeTFMNndsMGRobTQvUlFB?=
 =?utf-8?B?U05BVGNsWDJsbWh1eXBIZE1tVU4vVkRJdFhhQXRxSGc0d1I2WWUwRCtHZEJK?=
 =?utf-8?B?WDNxakl3NXo3VkZwNGI5cDh2U0ViaW9VVFBMQjkvd3VTK0xCZmFybGUyTWs2?=
 =?utf-8?B?OHdwRmZLcWp5aUsyeUZnYlY2YlZGRnRlTEMvYklRVWxXWmppeG1QaGpHb1lq?=
 =?utf-8?B?M1RGOUtGL2lsclpYSjhaK0x2dThKWklzRmthRFhNL2ZpQWdUT2tPY2lTaFNN?=
 =?utf-8?B?Vmt4Y3B0RWowRlhlRzBqSDBteDNoSlNJZ01SOEZqNUo0cFl5VENTRVNxQ1JS?=
 =?utf-8?B?V1Q4U0NQcG1HMXdEbGREZW1hdnVpbWYyaXg5cjZoZUx5YTlUdUdMaVRaTGhO?=
 =?utf-8?B?TmJHT2pIbjMzV3NlOFBaVjBMWnBYWXZKMlczdGV6Rzllc2txL0JlcExHWkVK?=
 =?utf-8?B?bUpvZDZRS21md0R0dFluSEZZTTRqQ0w2QVNuRzd6UHdNc2szNm5Fb3pjTThv?=
 =?utf-8?B?ZlpISGlLSTdJSENmLzhrOFMyYzdxaHd6Rkk3eUNRZ2xkSmRtYmpnNSsrTG42?=
 =?utf-8?B?RkZkMG9za01PWUxMQ1NiTDFsbkV6c2lPUnljT3B6TGFTdGZyaE5lOXdVZW9I?=
 =?utf-8?B?WHlXeUsxNUUvR0tHOTNnaFRpbDhtOW11OCtSbk1NUmI0YStheEdqOUxiZ2JL?=
 =?utf-8?Q?ZOTrW1aIMTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBNZldYWndmdGIrYld1b2N6b2Z1Um1LOGk1U0ZNK0pVWWh2OCsxY0dnTDlZ?=
 =?utf-8?B?Yml4aFUvU1ZPSVlDOEkyU2t4Si85OCtJY3dXMVRxa1hDNzF0d0l3ajhsNDdO?=
 =?utf-8?B?cXRzQVptVzMvcy9LSGNpS1Y4ZkhMdmZHSzlEdmowclpPMjdiQ1dFeWFvS1Aw?=
 =?utf-8?B?NFpxd2pUSTRUVEozSi94eVJnVllKbFp3SFZvNWZ4elIrWW5SK3RwdHd2TTNQ?=
 =?utf-8?B?dVpjbUxuK2pySWNvQkM4WnM0RW05SXJZdWYrZHU2bnlhUm9GWnp1ek8wdjly?=
 =?utf-8?B?MFhaV09HNzl1M2Iza3FiYzhtVnh0am43NXdTeEh1b0tod3BlWVo3eUxxcWpL?=
 =?utf-8?B?N3N4bTBDQnB6UEozR1k1aURqWWUyalFRUFA3dkFrb0ZqbnZhVlNTLytPMlRy?=
 =?utf-8?B?VG1vZWg4Q0FMR01FeC9NZFVsT2lsOXVDZk83QnJ4aXRJZndieW05NkdsZ3ly?=
 =?utf-8?B?MmREZXpSbDRjWWc1TGptbmEvNm1IRlBXaWxzblRiQ0tGT3MrTlhZV2FiUHRF?=
 =?utf-8?B?S0I1VnVKVzFJRmZIY2EzQVNDZm1IZzdkNnYzYmZ6ditTcXc3QzY2U0V5QWJk?=
 =?utf-8?B?UTY2azkrdUNqMnc3UGZVM0dac3E4YVY4dXN4VjJuMDFTZEpQQ05KSTdRamtp?=
 =?utf-8?B?eEhYNk02K0lvYm1iU0lqeFFaTXhvSmNqYjZoaXlveU44ZU9BT05QMWdiOXdu?=
 =?utf-8?B?ckczeGE1OG5EYnBaeTNVK2N0TjZjcU15NXlqZHhrOGlFcEdGRW5xd3M2OXBC?=
 =?utf-8?B?RVdzYlNTQktwM3A2cnp0Zmh4UnFrUkJKNFRSa2N3R2Y0b1hvaWo1T0NFUTVS?=
 =?utf-8?B?bk54SEFlYktsOEF0bWVTOFpkTWg4MGNKakFRNFFoL1ZsRnZPQU9vSWxtb3F1?=
 =?utf-8?B?ZlNzT0hmbTNaMFgranJoVjBYYUJxOWRnWnZwcUhNVWpGYnhSVXplMEVlQVpu?=
 =?utf-8?B?blVnQkFzU1hSRHBlS1FNeVVOQzRjQkZYLzFCMWlyL1U0M0RHY3M3TmpPK1I3?=
 =?utf-8?B?OTNhNFpjS3AyY0dyZGpTNzM2Vi9YYjlYN1lTdkhsRHcvNks4Q1FoeDIzdU85?=
 =?utf-8?B?OVBabTFXc0ZYVTFabVZRcGh5ZW01Q2tTSURDZ3creGxiSkZBT1hHdmN4eG5y?=
 =?utf-8?B?R2s0UmJyVGhHYjV2dHpHd0JFL0VaZjl6b3VKMVZVRndDYnhyWkZnUUtTeHlQ?=
 =?utf-8?B?YXJUZyt4eE9mVmVRRG94dlpkMFMzcHZxcTZGV24rQWc3SGh6SHJnN0JrdU5V?=
 =?utf-8?B?OCtoaVJYTzVSSzYybGJSZndjOVBUQ3l3MzFqQmJZdGhyZk9jQmY3SVlPY3BI?=
 =?utf-8?B?cGNnNC82Z21qMFdMQ0xsUko4YjBWK1JBQjhtUk5uaFRBVGJubEpEd1BIWG4y?=
 =?utf-8?B?TzlLSVBGamdEa3FFWndleHR2NnRuZHhvQXphT2tsMWJDS0x1YWJrbTdMMkJD?=
 =?utf-8?B?ZFZ5aEpIbWgrUTNPQVdsTWV0MHVhZlV3VlJOVmRMOUF2YXpROXhoekxkMjl1?=
 =?utf-8?B?R3BVbEtyK2N4R1J0TkJ6bEZNeE1VTm5Od1dLNG9nUkxpTkNFU2xINWQwb3Rw?=
 =?utf-8?B?ZFR6cjdkN0xrb2V3WkVBVEgxREx2L2x6UmxmQUw5RE8wMU9VZjJnczFQWk1k?=
 =?utf-8?B?eGJvSlpEZXpmblV5YiszUVQ0eFVLWGkvNURMN3VlMWZRcXdONkFLdDRuN3R0?=
 =?utf-8?B?WjdZZlA3YVplblMrVkQ3NzR5UDRubXFEU28zSnUzelhUSnBJaVhNd2FDQlNz?=
 =?utf-8?B?TTJjZ2ErbXJ1Ym9LdUZIMDRFMkFyaEp3azM2SjV6WjlQd1djYk81bm40Z1dj?=
 =?utf-8?B?MzkzSS9lOWsxR2FxRHBnVXNnSXNzZVJlNWZYNkFhOUpiMHFCQ0U0dWljREZ2?=
 =?utf-8?B?YXRkd0QyZTRRLy9OMHpRR2RYYnloa3ZSOUtrbWdUcHRmM0ZRTUpEelVpMHVl?=
 =?utf-8?B?amZwbC9KWGc1UyttNndHTTU2Q2lwYW5KcEtMVDczRUd3VzNuSGhmTG0vejhH?=
 =?utf-8?B?T05iMGtaNzZ2eVlETjIvdmRrSnl0dHBPaGJpNEtFV1FzS0M2TUhIODdFNldu?=
 =?utf-8?B?Z2hucG5wMFhQM1VxaEdpRGYwVXpKS3h5MXJ2YWUzamo4V2ovUjdmcmR0dU0z?=
 =?utf-8?Q?JU+E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea37b1cc-0609-41d2-7a83-08dde1c8af49
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 22:10:20.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCV5ohWIUlkILHeA3kL/put1DmrpEqkH06yYoHLtDAaYyTEdmmaWfw9DYAh61Qb2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

Hi Reinette,

On 8/7/2025 8:47 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> "io_alloc" enables direct insertion of data from I/O devices into the
>> cache.
>>
>> On AMD systems, "io_alloc" feature is backed by L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE). Change SDCIAE state by setting
>> (to enable) or clearing (to disable) bit 1 of MSR L3_QOS_EXT_CFG on all
>> logical processors within the cache domain.
>>
>> Introduce architecture-specific call to enable and disable the feature.
>>
>> The SDCIAE feature details are available in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> fyi ... Documentation/process/maintainer-tip.rst has some examples how
> the "Link:" can be associated with the changelog. For example, above could
> be:
>
> 	The SDCIAE feature details are available in APM [1] available
> 	from [2].
> 	[1] ...


Sure.

>
> 	Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
Thanks

Babu

>

