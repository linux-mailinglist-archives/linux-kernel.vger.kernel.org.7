Return-Path: <linux-kernel+bounces-759406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40FB1DD28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437E93AA0F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27821A458;
	Thu,  7 Aug 2025 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W12JZDJw"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E418BBB9;
	Thu,  7 Aug 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591639; cv=fail; b=GMSHIvBXFcM3k+98cArvPAnXy7YcU1V66fRg+w7TLFJoxK0+IFQLhq+AsBz6H2A6OSYzpgiWBxKrvPFZC0jidWSNpgVUcXkOm/7cfQgKwqmC/ozvRfeUxYFCdpwVWQkCAxge1lzz+LxPQggHzyWQIvVzqzebrS8ZvKPLkcHPsjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591639; c=relaxed/simple;
	bh=DMchTP/hZRsp4zqgSgJzKdzhTm3fXk0qdcgabY7tPg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hokkh1u1LBOta5wuVDp+Fj9/BSxuhP+pYZ42bX553onk7DBiQqKfWUlmZYbNPHmFzCVy4I7zk2YsLtWdjSll5FNyXakFpEVcyOHEgDgLEjeT2HDd4KTdzZ4LiEqLkqqrIuarCgv9g2xQC+JvLUhA5Sz+8v/YtbK6YIT0qZIRbIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W12JZDJw; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKMYX5WyaBXz/X9Bi+h3GZqVLjmADANChGNCRl38GsJXHEI6l16buMblQpW5rVoU8e4DScA2XJDWMhAsZNgiCImVdG7al7VgkEfUtBUUIiBoaiSP3fdvgpGrpUZxA0we/xIFj9LAH6QQK6KBCfk2LLKppgNIIKjPXWS8UQcdQTwHI4YmVuKZw+IpVwrvcIXQFEd7YPOrkC6h/p7Bf+VBUdsYoU6gaaELk+8MsO5vmuqGfzdn/cO6D/jW7koiYBmtW7/HlHSsKQbV4vtrFu3BFmRioNR39PNCnA10D3Thv284/bjNp9NKgzfQtbPKsJNIwGIp1gws7KOBq+5YEIYLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBmg9Kmr0h4CCLjJsatw6jHrfpWgUp++FggM+52A2jc=;
 b=CU1DnIK3QpDI9EldIxlZwYr48I5fcf7ToCYjGWxcfjrLOyOeDTGPYLmu6YnMHyhxsS5+YNnXwOP3xRImRMtX/NH6z9tn6UDDOskS76sPONEYD/p/ExS5PV3tsQQnLe+lXp4D6D8qjWGKn6upEh4aH4g3M3dPBJcUuSYG02XQJkAxGNYzI2GTneSnfE4Jt80CU3Dpypyoh2fJ1mhcjbhToDT4CoSjaHQGpEg7ateGJFHOv0LIyifZHDMzAYxrbYFz/9ZxZgKnxGuHMthNjnOPAg4W9TzDFkXjVUn0h94WgpYomAP0TW/gbMxNUguihJ9+bSNr8SpjKFKzJ8dfX6lebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBmg9Kmr0h4CCLjJsatw6jHrfpWgUp++FggM+52A2jc=;
 b=W12JZDJw1EpjnfORrcIabxOcZzumMfUysZZIWyoarOZJUBKrETAZ2bxDdmcxSOPX+hdmzOD6LTLwybHNLCie4RwiDP+0Z+x6EBrc1GmdZ4WkXga87lT2vVlEtrVHZos2oRaudp7e9Mt1He57uNvqhf3DQic9UjxkHQootOI5GVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW4PR12MB6950.namprd12.prod.outlook.com
 (2603:10b6:303:207::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 7 Aug
 2025 18:33:54 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 7 Aug 2025
 18:33:53 +0000
Message-ID: <c1fa8b57-f655-4d64-bdf0-49e53325f367@amd.com>
Date: Thu, 7 Aug 2025 13:33:49 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 18/34] fs/resctrl: Add the functionality to unassign
 MBM events
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <8289b3fcfabe6d820620429646b18660e7cf9ffa.1753467772.git.babu.moger@amd.com>
 <a65263be-523f-48a7-9473-4f4db1b458f7@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a65263be-523f-48a7-9473-4f4db1b458f7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:610:e6::10) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 8868fc16-8b2f-49ab-711e-08ddd5e0f5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czlJZ1NoMVIxQUZJaTdPTFZJbThtbkkrVW9JY24yWWJyTEZrOUY0b2pBR3J2?=
 =?utf-8?B?d1hYOGszLzBKazR5dGZoSUNNMENKbXpITkZVK1pQZTBTT3RBc2gvSTVoSEJp?=
 =?utf-8?B?YzVBWXhvUFo4YUc0Sk5rS21UbTJjTysxbkF2OVlONGpLUXNFNDM4TTdHWlk1?=
 =?utf-8?B?bnl2aDVJNnNHc1dGNHRsQm9KTlZoSjNzMGNjVFN2ZGV5UFFZWUZZdVpkaUFR?=
 =?utf-8?B?a2VMUU1IQUxpN3RVZDZ2V2dtaXQ5NDc1R0tvcGM3QVd2K3VSdmQ5NUNnVUdV?=
 =?utf-8?B?NXVOSzZISVJFVWxhZFdvWTlKa2RqTjk3YlhDZ3FUOFhtS1ZGaTBQdUE0QXVE?=
 =?utf-8?B?cC8xbGloaFVyOGdZN0xIRi9nS0MzYkEzUHdwSWg2ZHQ0a0F6c3ZPQ0sranZW?=
 =?utf-8?B?Z2p4SFVQYVFXUStyL0V0emJUdTZMODhZcFhSSWpYOGlNenlrNDlYQVN5WnRE?=
 =?utf-8?B?a001RHRlRlEwR0pGVHRYYWtrUFVENVBLOWpsbEk3R1ZsR3hFNWllSFFmSldB?=
 =?utf-8?B?VlFQZFNveVcwenRUR1pYZGJnaVdGS21RUTVla0FwejNidGhNcDJBWkllSW9N?=
 =?utf-8?B?eitIY2JRWmZrL0pXNTJLMndPSEwwUGdpQmc4MTFBeW9aZkZvT2NqMDBmR01t?=
 =?utf-8?B?OEd0TFp6cmsxSTZtYTF3ZmJJUmpBK3JIbkZlTVZLQlZ0SHIxNWdHUWIwQ3o4?=
 =?utf-8?B?QTRDNExWakVQcnppdWpkYkRXVUN4bkhtWjAxOTVIZVZlT0g4c2hNNktPV2tz?=
 =?utf-8?B?c1BETEVNUERxdVRWMjV2UU10Q0NlV3RXKzRzMkxnaU8wOEwyN1oxamNmaldQ?=
 =?utf-8?B?Ukd3bXRIYWhEYlFCaE1RVWF6U1lKZVYvb3NLcGRKL1pYMEMzaXdOdmo2UC9B?=
 =?utf-8?B?bm9RSTJGZnUzWEIvVUt0U0N4cE5yR0lsQWRaUnBzWDRRb1BvNWsvb1ppM1dP?=
 =?utf-8?B?MlFETlRIQW9FUlQxL3FFMllnNGVOSHcwNlJSbFVnb2lEc0xybWQwbGNkWGFS?=
 =?utf-8?B?R0szdk9ROHNrTjd3NE1wQnFQd3h4aFE4a2Z1ZDlSaWFWUENKSngzVVo1TVhE?=
 =?utf-8?B?aER6c2g2S2NzTUoxbEVKZWF1VjNyL3g4VStMNGtVU0I3L1EyQVhFeHBUazBy?=
 =?utf-8?B?ZW9UVzdyT055QStjbzRZcEs0YzByUkpScFhoYUJHREYzSGZMQlY3cWVZakV3?=
 =?utf-8?B?U1IrenQ2S281aXpmWVM4MzhzWU5BSGc5bHRQQnMybzB0MTZVbnl1MldIQ1NJ?=
 =?utf-8?B?U1M3L1JTQUNUMWsraVUwZmQzQ3R5NGMrM2FsSXlFZDE2OThJVVREelh1bUY4?=
 =?utf-8?B?QzJoY0dIcndUVTRyR04zNHZTTXljVVNsMVFiN1ZvWWExUjQxZGFaK1lPVUM1?=
 =?utf-8?B?MkJMRVJ3ejQyTk9UYU1vaWxaK09Cd1hDck5iS1RwNlRxc1pQckJscjNuUW40?=
 =?utf-8?B?UEhXM0hnMlRHTGRaZzQ2OG1IZm1YaHRqVkVVdW9qQlc3QnNES0EzMFRFVHV4?=
 =?utf-8?B?bXlRaUdGbjl2eENUR3BpNXNycGVJZDRRYzROSGp2TVptbHU2Y3k3d3JlNWRk?=
 =?utf-8?B?SEVMRDNtNzcvYS9DUE45ek5TL3JwYUJtN0VEV3BtU0lxclhWbGZGZ3huV1JT?=
 =?utf-8?B?VHkxZm1ORlZQd040bWVZTU9zTlBOOFRBdXVFclhmejBYSUFHcGp5U3o2TjBi?=
 =?utf-8?B?QmM4azQzdE9EQ3VBWjdhNDA3MlE2d3U0YTJvWU5aTjdzTXpBR2RyTWhYcFZx?=
 =?utf-8?B?WklZY3VGbU05SCtkWEE5WHllRU9hWHlBZmdRWUs0WVdTcnd4dzFZcGF0V3F1?=
 =?utf-8?B?bkJUTFB6QWNzN3ZxTTlGZmx3TzZWYTRnaEtjNlJvaWZsc0ZsUVU0L1NaWkRW?=
 =?utf-8?B?WjNQV2FGTkMwUXBOeGZmNTJUNDJMRk5vcjZaL0NYWnRRL3k5dmxqeVhnMGt1?=
 =?utf-8?Q?xSLKZXbbZbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alNRaCtXT3FKQ09ZT2hRUnUrVnhYWmdJZmxGdUhTU0FyT0IxZUsrbGhzbFVs?=
 =?utf-8?B?dTJRM0RjNG9MUmRUU3huMFJObHZMRzhPSjFjVDBKZDFYck05RVpLWkFQUFNx?=
 =?utf-8?B?ay8yMFFIcThIc1R6S3p3eXp0SW4xZkVOaXZJd2ZOODlpcTB6R1hSRUdVOWl0?=
 =?utf-8?B?eHliQWZPa3FnWHdReUlhN1VuSkNSZSttZmpFaFNnMVdsbFB2SmhDK3NJUXN0?=
 =?utf-8?B?OXRFQzc2YWxNb3pvbjFJWXVYMm5aRjFuTElNeTZ6MmFQMThGSE9lb2I0Q1Z6?=
 =?utf-8?B?SW00RlV0RXNTRkd1bjdnNWpQb05ZY2Vjc1llTVc3OVFZa3JHc0dIemRNMzZw?=
 =?utf-8?B?d3NjaU5OR3drazR1cWR5NTEycTlES0NGZGdabTJQdjU4VDgvQjB5OGRoRWlm?=
 =?utf-8?B?SXd1NXNEYlhMZjJIampuVmFmZnczOHkyOWZJaTJsWnhDdG9aYjdPdFZobFFy?=
 =?utf-8?B?TVIyR0hBZVUyVm5GNCtHWGExcHRlVi90c0daenVvbGdUMjJTZGlsZmdabzFF?=
 =?utf-8?B?QXp4RGxKZ1RuR1dnMk55MllINHJrUFpxOGJqaG5qbytDNVNUWGFGb0pkQkl2?=
 =?utf-8?B?MGpwbWRqNFlsYWREOFpsUU1KR0VkUHUvYWNnL21sU0xVdUF3b0xRM1Z1My9X?=
 =?utf-8?B?RVA5b05nRk1GeXlKRFRNUE16NFFNRHdabG9hV0FCdFk2elQ4bFhlaVRFREpq?=
 =?utf-8?B?VXU3dFhFOTExb3o5ZVAzVVpZUk93eVdLSWIvTHdicEJKOVdwSDhGT0FzL20z?=
 =?utf-8?B?azhNTFFWL2V1dWxSaFFzc0hncVJpZHh4MFh4M083UUFVN2o2eW1RUndORGR0?=
 =?utf-8?B?aUlPc2tRNU5KWXJEeGoyVTJRSG9hUGFZZEhhbTNTZGFFYjM4Qk5NVFlKeWlQ?=
 =?utf-8?B?L0lDS0t4K1hyS1ZycStwY3dMd2RITFhqdDJwUUNscmNFMy9zNHRmeEtGNUFL?=
 =?utf-8?B?SlBKaDF3ZDBlY2dySmIxN1N1bmt6RjhKR1pyb0ZodnMxeWx6RmYzdXNsREZ4?=
 =?utf-8?B?VHYxUXE5TE5mVkJ0Zm1BVXlkZnJOYi8zNEt2enVqbVR1VnAxYVN3T2d5SEt3?=
 =?utf-8?B?eUZCQlAyd1lTN29lWG9FL3MzSUF0ZEpqUzBqUGRhbUZKdzk4YUlTa05MU1ox?=
 =?utf-8?B?MHlHVkYvR2FOUGlSZlhiaVVFaktqUXhpd0lEaHpzeS94eFdsN21zWWg2Z1ZS?=
 =?utf-8?B?ajNwVTNpbld2TGpPN2xPbWVoTXBLSmFpMDdHcG0yZTlVeVAvcjZpVkh1aFo2?=
 =?utf-8?B?UjdlU0xreWY3WWlHUkREaExEL1BpTW8xdGw5Q0doOTc1OUxvUjBrK2hEdGJm?=
 =?utf-8?B?QWMzSXhSckxaZFNLRzlCdjJPL0J1ZmY3MHRxdWVmRlRzRWY3NEE5Y3psVTVF?=
 =?utf-8?B?VVBvNTlWTkpSOG5FY1kwcGJpdGduYU94WXFRQlVkNnRhQWh5aW9GaUFZT0FY?=
 =?utf-8?B?eW91ZnBFa0FSd0Q3aGE1ZHpMMklIb3V0cituZldjbXhlQ0Rack53dVlaSmxR?=
 =?utf-8?B?T0pZaVhOZzFlWkw4eG03amxTNUtzWlJRRnduMkdJYjNFWklUaHF5d214Z1ZQ?=
 =?utf-8?B?bWordFFYdi90SUVmSUNPMXlraGtlOXlOOWdBanJ6MDAxeG9pZ3lJb0pvWVVL?=
 =?utf-8?B?TUpod3VhTzFxUWZWbkdiUWRYRFVPaVduSmNsR0JMSnRCYnBMdDN1S3pncXhC?=
 =?utf-8?B?S09PYSswUWdPMEVlNDJrck4reTJJNFJXc0Fla0tGS3kwbU0zekpqRG5INklZ?=
 =?utf-8?B?SmNtNTg1bG82RGxJSjlMYmVkWmdib1RHbXhhRi9tRmFoNk5LN2RTK2tGSnY0?=
 =?utf-8?B?MEtTbmxKYUlaVEZHVWpyR1UwQ0R5K1p4QStJanU0ZHVWY0JVKzhtRnFvZzVx?=
 =?utf-8?B?VW10NFg2bUtJMkgvaVZidlhTL29SenRUajNCRk81S2xKU2dyd2M5L1hkWU9s?=
 =?utf-8?B?MHFCSVhWR3FZaG5DNnpid0hUY0xhZnJJNHVOdDFZVnFBNW5jRzIydVNyZWtN?=
 =?utf-8?B?K0p6eHBGdnRNSlQ0RGVCWWJ2VmROSmQ0MVRrQ2ZvTWtpSTNmQmpHWWtNWUJX?=
 =?utf-8?B?LzIwVFNuSC9qZ2hCcDI0UVg4QWhsdmp0ODlML2t4cUZPVjFHNFAzSXFqdXJt?=
 =?utf-8?Q?NxLo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8868fc16-8b2f-49ab-711e-08ddd5e0f5f3
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:33:53.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aQbnxi5yK1LNKNt8rSn5uAlJ7hvxedLqJ+vwCbBZ5gYwaEE7k6AVpe6Zb2gvJyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

Hi Reinette,

On 7/30/25 14:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
>> counters that can be assigned to RMID, event pairs and monitor bandwidth
>> usage as long as it is assigned. If all the counters are in use, the
>> kernel logs the error message "Unable to allocate counter in domain" in
> 
> Needs an update to match new message.

Sure.

> 
>> /sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
>>
>> To make space for a new assignment, users must unassign an already
>> assigned counter and retry the assignment again.
>>
>> Add the functionality to unassign and free the counters in the domain.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
> ...
> 
> 
>> ---
>>  fs/resctrl/internal.h |  2 ++
>>  fs/resctrl/monitor.c  | 46 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 419423bdabdc..216588842444 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -389,6 +389,8 @@ int resctrl_find_cleanest_closid(void);
>>  
>>  int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>>  			       struct mon_evt *mevt);
>> +void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> +				  struct mon_evt *mevt);
>>  
> 
> Similar comment as previous patch. Please try to keep all monitoring code in
> monitor.c. The caller rdtgroup_unassign_cntrs() can move to monitor.c and it
> can instead be made available via internal.h

Yes. Brought rdtgroup_unassign_cntrs() in this patch for completeness and
moved everything into monitor.c.
> 
> 
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger


