Return-Path: <linux-kernel+bounces-847671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB30FBCB63C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014E74FD8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E11239E63;
	Fri, 10 Oct 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4iPRaj47"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B26238C1A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760061441; cv=fail; b=SfE052aR3vdKcx+iWL0243GFrDXtUwI/1Hv8M/LY6d92ZFKKuDpEr6XILCO0fTdCTT66BuZZkdqb8Pkl226lqfS+uNRq7rVE5d5VKcTQLtJEH6A8yH/+tLpYn292MS0+Zo8jlE5WkN1k3Cgf/4eZen7tkJr3aUhgkAiRWGoGiEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760061441; c=relaxed/simple;
	bh=NSHImxN1oJGIKjyZJJ3tq0RZioSA0mpdOufoEvoA0c0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YhmgitWnVRUpNynUFOjOzg6TMFMCtnViL5urd1SFy/AOnvPF+Z+jePJ6QBY3EWbKeX4bEXO1JVbRDr2ieJgFDaR9i1wGlB1lkV9UEKmfgY8emkWGBDSqjbAgmt408kYzP7aMUfEB6/Oj9HJ6MmJGFQzfI2/dJALEhtBaeockDko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4iPRaj47; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfz9sjkrjKuuHMVgTM/Sbry3o5hlRCAJBXoKq0L6mAuVjvynKXV/HyahAzLAUFjAdmakS+iKunmaxtBLFMMAaE6hBcRZhBg3EWZF1BxDdmY3SglA0DsZxCZ2y3Hve0c3xp2quPqxFS7hBO7JoWNuVgpjUXKwKC2v3leG8P9Fu504jiz8TrMrgZtnoGa8Efz7aDn2o633eb9Wa5b+cAz/LzsJ+e9q3ibGmiPrSUmdw5idgm+HJe5FIyrwFCG/9GLJ3iq2tIdTl1nSomqLl1BpsEYS835m5Bpomk8a/vmVP6+wzK5XeWXgIGfsrcw/OTvSyJnPnEJmiskIDwtaGmCYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozdOwm/9Hz1hvsLYgZjSvkcqyJCjjW3O25iUdkSCoSc=;
 b=WjMEizVZ2S/AFl49bib7PskXPgRmficifvQhgWSsF70c8iioGL3DZOIe695LRTTznP7C9V/AFrC5q4jwpJDkLNWSo5qg3uCLUJoJN2vp80WOqw3EccHfdg8tXTaTBje6/MlFee9n7jpH8SbQzlwnvRuDf1eCBE+pXTqwQtv8N7m1kA3VpUXPPFuTrjh91ikLqdPE6RXPZGo0MsX1OzKmJBcP1M1TKhsth4keoXXb7nUXaGEIGLjaWIhiRkDU66Nw1KxQqw7OwzJ2KZdSF1M3EEXoyL8xwmLHoJXR3li41ntj1Z8Fk0AVmpi33Y0bHMwUqHMlFr0iatbhOVwzgZmT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdOwm/9Hz1hvsLYgZjSvkcqyJCjjW3O25iUdkSCoSc=;
 b=4iPRaj477k/w/rJSlQbVoXI8tvww6Mn0mCGYGWCs8zb6WERAdEWzK/JrdzHkXNReRBkbwbOZekz+J4gaoWwHheFyLLwLfo8AdKHehCHt2T6NdepXYP9kkevmZutH17+4EE33ewHgl7WlyU2u5h2XleLRGvb0zstunfcMSlUcIQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 01:57:07 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Fri, 10 Oct 2025
 01:57:06 +0000
Message-ID: <277298e3-5713-4914-848b-9644f33e2a30@amd.com>
Date: Thu, 9 Oct 2025 20:57:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
 <20251009232200.GDaOhDmBfQVJOQjETG@fat_crate.local>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20251009232200.GDaOhDmBfQVJOQjETG@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:806:120::7) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 454abc43-96d2-4962-299b-08de07a050be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFhUanhJRXFjMEc5bVJWbWQxS0p5QUtGN1lLOWg1Ym1yNnliOWd1MHNiTDJ1?=
 =?utf-8?B?VGpDSFBsUWFobms3WmdYaEo0eElMZVh4c2JnZ25WUW15MW9SbXI0Z3gvSHVt?=
 =?utf-8?B?RVhLcXNkdUlJVnFmZENQbk5FY2ptVDY3TkhyVEdVU0VaYm12bmNBTlB1Y1Np?=
 =?utf-8?B?TGliQlpYcm9RRXpMS08rcDBQQWxuRDRkVEgrNmlSaXNoMFZiZWgveklJYi9a?=
 =?utf-8?B?T0FiUlA2VmVOS21PelpKbWpkbnp3VllxUWFaa1oyZUc2YjlTVEJNcUJ0Q0tu?=
 =?utf-8?B?WlZTdW5TZURwMUZhNmdtbi9nZGVmdlJhVFNHMmFKdmZBb0RTTnJxNHhKZnhS?=
 =?utf-8?B?eXFIdHFnTjA2TEphUUZGR0FlMUZPZU9CdU9VRjh6WUtDTVl4d0I0UVJwdjFn?=
 =?utf-8?B?R3JlL1dHRThwSkQyZHlPYmRIeDlZZFJ4VkExcUg4TjVHT280ZjBvb2JrU3dH?=
 =?utf-8?B?K09NYnNlQmlSUUhZS2pIUXVxNHllYVVNWFc4REgxQ1poVUViZ2xBaCtmbUx5?=
 =?utf-8?B?QmtRVG9CdEdoMldnRVdsSHdCU3RPVWJhZUIvQUZ6eUtzUjFHK3pCbzdjN3lr?=
 =?utf-8?B?UW9RNkVIM3l5UkxvRlQyV2pyMHBRY2ozaEtJZ1ZWWFJMUHB6alJzYkJkSVU3?=
 =?utf-8?B?eFFUT2FXNTc0Z3UycDNzR1Rnb1p4SDVRMlFVT2JXWWlPUUJ0YXZNSFozakFl?=
 =?utf-8?B?ZDBSekkrNWo3S0NtbHFDZkR3T2h0eEtmYjU4Ykg2b3RDTTZxNFIrT0lNOU4v?=
 =?utf-8?B?YnNxUDJaMlhUNkw2bThvTElPbm1lb21tNFhZOGt5Z0JqcE0zdVlVOHJGVlhj?=
 =?utf-8?B?Z0ZoNW5xQVhPdUpTVXVOc0VJSDZ6TFMwWjV4TTI3UG5LOC9kV0hlblNUSlhE?=
 =?utf-8?B?d3RrOTVDMndNc0JObExpV2dGQ2FnR0hST1N0YmQvR2I1RWdTb0JvaU5jOE1h?=
 =?utf-8?B?VDY4bUpZbkp0VjY4eld3NWVlT1l6cW9hNTF0Sys2N0VBSXdHaVpGcmhKZDc4?=
 =?utf-8?B?MkFNMksvcVJEZFY3VEl5YmwvYTBwTnhFdVUwNWFLdi9DdnQxRjZMcXJ2R0lm?=
 =?utf-8?B?NkE1c2E3bUpsQ243UkRyZGo3ekl0SkVjbjFWdVZHSkllTFhEdlBLYi9RejVH?=
 =?utf-8?B?akJpOWNKZEhZZmNnTi96RFo5QkR1YmFIY0k5SWhnRUtEVlQvQzNCdmJiYTJr?=
 =?utf-8?B?UmhXMTZyZ2d5eXJzZllldjVtcjluZlhEemZ1eloxODAxdUZPbk5ENGZPOGE0?=
 =?utf-8?B?Mnd3Y1dxWU9OeHFmc1QrdjBKSWZOY3dnMkFzZm9oVXRKRG52eTNqdFRrRzU0?=
 =?utf-8?B?UHpxT0xnSzUrWWdNdnY3c3NtUTYrbXgvWEczL1F0Zy80eFgrTkNtanY0Z3NO?=
 =?utf-8?B?dXJCSUVjV1NNUEhIZ3Joa2psbDRpOHBIOVlpSVRVVzM1R2JwZFArVHEwaUxB?=
 =?utf-8?B?SjRlQWFFTFNXNUVJNDZ2QktWRklVTjhMRGlJY1A5ZFFNYW55QUk4YzZUNlE3?=
 =?utf-8?B?bkNQMUkxdlBJYmFsRHZjQXNIbXIySHMwQUw5VE1sdnhES2l0aVVBUmVnS3lW?=
 =?utf-8?B?ZGhKczJuaS9YSHRjRE5SWHZqd1BVSUU1clFYU0tNRjE2cHFpQlBSTnpvcmRH?=
 =?utf-8?B?UjhNUGl0cGhUSG9GVXVscWp0QUNneitWUWl0VzVBWVU5VzRyZ3JlQmxHVlM2?=
 =?utf-8?B?NFNVQUt5cGpId1JiVVNzRnBnZXlzbDVEclNVOEt2c0tqNVlFanF6NXB5NFNm?=
 =?utf-8?B?cFFJYTh3Z1kwSW5mN2N6TlVLN0NWZ0lTclkrUDRZL2RVaVhZNnNXT1Z6WXVa?=
 =?utf-8?B?L1Z5bytUUXJTWjBLZHRGTWYzZ1c4YUFQTjYwelVncXUxc1JidUNiUm1zQkxE?=
 =?utf-8?B?THZLSUJoc21UYmVuN2libXR4dVN3VmE5U21NMGd5YTl0d0lIcmpVbVUxMEM3?=
 =?utf-8?Q?/xMwuli1KfAE93LBHsHKJDkP8FDcBJjg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2cxS21KOVdQd0NqMHBLR01QM24wakxhOWJlT3AvcmxBNlVldUpXVjZydWdy?=
 =?utf-8?B?QUM5OW5IUGxvVG1GYmNGc09iaXp4SUNqZXd0TG5FL3RWVEFXbnhLelZEQUdK?=
 =?utf-8?B?Z0s2MkJSZHlTaVMvY1BpSTdhRWkzSTlHdUxHczRUOGRZMFN1L3hYYSswQ2xO?=
 =?utf-8?B?YUlmekh4L0hLTEh0V1lnZnlBQ2ZxdXhvYUdmMG5pWnF6SHRHa0hwNTl3eEhN?=
 =?utf-8?B?WE5XUndRcVNJZk5vVHZCWGFXM1NNbXhWUXorNC9QcUFTSGp3eFN3RjdKc3A4?=
 =?utf-8?B?NVBqZytjRmloVlB5enRtNUJIR2ZCWnplSHFOQVhqQ0k4SXlpUkxaTW0yZWhD?=
 =?utf-8?B?VjJENWZpRXUzZ0FYcU5GVEZ6dFU0czBrNTFFeXBOd05KeUE0MG13TEtCRXNr?=
 =?utf-8?B?T21TN3RSZU90OUswdXgyTUY5NUc2ekRqNEx2QTJuRTU3dDhpU0FHR3Avall4?=
 =?utf-8?B?Q2h2S2ZtTzZFWWlnbEk2a0YrMkRJOFFaUnA0ZXMrMGRRWG9HZXByL3YwbEZo?=
 =?utf-8?B?eC96QjlhZW15ckdwSW9uemdtUnlJLzZUSlNWWS9kU3ptNklnNWQvK3VmZy8y?=
 =?utf-8?B?cnpvRmVYMTdHRzB1dHZKWGtvbS9qald5NnFHZlk3elFZRHR5Q1BEYmxyU1Jj?=
 =?utf-8?B?b2Z4VjFyWEJUemF6b2lZcjEyNnhMcWhWRm40MmVZbTljOCtoSXVQVFJ4QTU1?=
 =?utf-8?B?eVB2cS8xMXMzY25WM3RlU2FwVzVQK3BZT0YzeFpVb0dFMlNzS2ZwOWRHcmhN?=
 =?utf-8?B?anR0b01JVzVNQVU0aG5WdkR0SGZiN1FyNmZVcUQ5YmNNenVTZFk1cys1YkhU?=
 =?utf-8?B?blB1VzNrblMzdnVwN0VXaVMxNXpEdHphNHlMaGpUZmp1NWlvcjhZT0dTMnVZ?=
 =?utf-8?B?UFR5MmJSV2JEOWx0TVZVMTBPTWtUc29tY2loQWt1SmlaRER1Zzh5ellBbnR5?=
 =?utf-8?B?YUNmSHFTTmJrZFRoZ3REY0FaV2NNbXVXRDFOektaZklVOCtJQzZyMUsxMDZs?=
 =?utf-8?B?eTFHMU1TWWxUd1FuTlROMUJnMVcyVnB0N2lYei9abklFZGZ5V1p5aDlOTmx0?=
 =?utf-8?B?YVFTUnJ1M3lRczFST0pEQkhYRTZnODVwY3YrM2dPbWR2T3JuaWM0WDF4YTZp?=
 =?utf-8?B?NXpxcmR5ZHo2VnBHb3hmYjZHbWRyVXZZMEhoMDVWQWswaDFHTkRBem1YQUJS?=
 =?utf-8?B?VkczSHJyQ0ZrcXk2S1VZMW5DS21RRVU5NWJ1UUw4TmkyVVArKzNIUTc3c0lS?=
 =?utf-8?B?S0p3N1NsL040NXdGZkx4cEo3dXFqYVdnMm9pSmpzK29ITk44TjZqZ0duOS9F?=
 =?utf-8?B?aFM2dlpGMUtGSm10aFg2aGhmeUROTjRuVGdjdGlVWVBXTDE3OS81RllydVhV?=
 =?utf-8?B?NzdBT1dwaXNReVpZREF0WnM5NnYrKzdKbjVybUkyWmJVUko0WEo3U3VXNHJl?=
 =?utf-8?B?ZnY3ZGhGNGt5eFpsbzZEeWlIWkNjbFg3ZDhHNW1sODAwWWtweE5pU01OcXAw?=
 =?utf-8?B?eW05Rm1abWY4UUhVbnRsUWNIMVk3M3RIK1huMklEK2xGL2tVekR2RE5yWEdT?=
 =?utf-8?B?bmZHSnRIWVgrdmw1TVEyajZRVG5rNmRLWHZqVGhLcFQyRzl2cnNsdk9iNEJZ?=
 =?utf-8?B?TitiK09mb05EYWhwMkdkZ0RhUTdvbFZpWjhLanZTWWg0c3VqK0gyVmhTWlZ3?=
 =?utf-8?B?ckp1a0NqQjFPVHdqNVhxWmRKNDdvNEVrM2tNTmZsRWdMUFFHY2dTTEJBRTVZ?=
 =?utf-8?B?a2l3OHhJQnNPbWpoVzRZMTQycDNrKzNSdFFRUmx5NnQxMWt6SWdKZWk4ZmIx?=
 =?utf-8?B?YTB5bHZMK01vNXFDRjZOdkRScWdiWlJhdVgvZWdZai8yQlU3Q003SE5BMzd0?=
 =?utf-8?B?d0dmYVBLQktFb1h2eDhDRWZsOWgySHRYN1JoR1lDNi9KL2FucXVGOXhlK0FU?=
 =?utf-8?B?dWhPZjhKVmp4QUhDZWlqS09tQ3dDUmVzTjhMemRpRTRaaW9OQUREcWI1bGVs?=
 =?utf-8?B?OU1wRnF2cEpBLzZXaHVYR1lsNDJ2bHpkd2RXL1dLVVJLeHZEeWd6Q0UvQkxm?=
 =?utf-8?B?TjBRUDQwbWVTUTRKSkd6dTIrOStDWE9rUUNvbXNsdkh0S0tCNUFRTGF6anNi?=
 =?utf-8?Q?QVQ82eVJI60a8xi0xTFUSygsU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454abc43-96d2-4962-299b-08de07a050be
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 01:57:06.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMFc1cLMS76aDqO7nlwkfzctlTcDPzbIxge2+ZHqJbjkqwH0PWEt/x+/3Ru6Iyf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

Hi Boris,

On 10/9/2025 6:22 PM, Borislav Petkov wrote:
> On Thu, Oct 09, 2025 at 01:29:17PM -0500, Babu Moger wrote:
>> -	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
>> +	switch (ret) {
>> +	case 0:
>> +		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
>> +		break;
>> +	case -EINVAL:
>> +		am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +		if (am)
>> +			am->prev_msr = 0;
>> +		break;
>> +	default:
>> +		break;
>> +	}
> 
> What's the point of this switch-case?
> 
> Why is this not better?
> 
> 	if (!ret)
> 		...
> 	else if (ret == -EINVAL)
> 		...
> 
> 
> 	return ret;
> 

Yes. This should work. Will revise the patch for v4.
thanks
Babu


