Return-Path: <linux-kernel+bounces-787163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C5B37249
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3112B3667BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516336C092;
	Tue, 26 Aug 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfsifXGa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163D36CC9C;
	Tue, 26 Aug 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233201; cv=fail; b=dAO10me8AlgFN9Gq8ZSEROX7muriel5XVM5LquFGJJY3x6mC0ed0gsDkffp+dU89M4UZ8ZJ75dD4r2i9ZiJo39uX/dauL1Ggu22UImCwgcaI3bYjuL8yZlczO1IK2+/9Wsksz5fq4hQe/C+IxN9z3oTDdEAV084Fgf7iw4Jj+bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233201; c=relaxed/simple;
	bh=B6AX70uCoxUTy85xIcmy44+HvRoIqR0csWGvNPkK1aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SggnPyWvMgyoOno59tuzqkH/zEYJwiTKCqdfawHa6yOfoo+WuTDElWTd83Y8p0TjRzIKYRICok9m2F8Abcnhq16gQebe7A+lkyjqbrMvpuFO8F/o0OZgL6cNVjIWqBxTZ6lQShcXfx5i8azecq3bSr1eNX8jmsmaa2lvnUBprxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfsifXGa; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUGf6QYDoctyNOGsF/+KA2iLcLyww6GA2olxHBOEcb3Yv6JJayB2r6Pa6BvWAQLmq8eltiCMDJHLQIIhkNc8B3cZiWHEIQ4F0O+BXyom5A/fzpWcY0blUYbszczkvVOWKP4ECBySyDU6QyPwb+nD8C7RYWRmGlsPkCY0wOcX3hLW+w/GxquDIgQ3VAU9ZhinioFq1lAI2fSIS3JusUgyjaAlsxK82qsNLQc0lsDvQkcPt7p40AGPUAhsUq0+UEcn8wyU3EoQF2VZp/Cm61wdkjplII/eujmQ7ew6Yv4Snxo5ayt0OUdpYBZF+rdhyHhqos9saR+A7QCb/IS87JfxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVyXbNCCAHEum8PpXm34MjnVfDKeOZz0jUh2DkMzXKM=;
 b=kRvxALIdsPfw007613TtvCq3e9RSr8Svrfinw3Hp0HT/rPpqnNlXnQu/l0tfeWvvaWbiRQys168dcLfAfZnURuHEMCOJz9f/Pk7GdM59grA+owVoc+JsRZyw2M19Ci51fRXAraaE/0mqwKXFC4+m36denKmx5Kdap7EjCzlZAOMcnjZmauONiKYny0pHtyGpbXXMROxsviMjZ2y1YGU3HgYBC5QN6G2CbtsVmh8Vx1WnNGaqbK3ebfvZ9zN4EGjCJ2GUlR97QwhLzUS36ZBy8Q8YzRvM0KkJ4DMWCOn/1GjqoXTdIwGfC4M/sM/m7QHonz+9dIjIrHvdBUenXz9iwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVyXbNCCAHEum8PpXm34MjnVfDKeOZz0jUh2DkMzXKM=;
 b=xfsifXGaK5aOHW4zjz9ASVzTpISoCLxkiH1ZANwmhsznOTjEpBiAV1xYQ7ew7oWmSAP2cgSgUVPGt4OGwTz9oKwZHwnRfzodrzdWR56BHaqbVJqqpVrf/e+TFS5DD0pPtlk1Quoje9/SPUC+5Kl16HiNs/dv2c5yfkmBrpRXxaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by SJ1PR12MB6195.namprd12.prod.outlook.com
 (2603:10b6:a03:457::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 18:33:15 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57%7]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 18:33:14 +0000
Message-ID: <dbbf40e7-8667-45fe-9de1-8e64e8ea4bdf@amd.com>
Date: Tue, 26 Aug 2025 13:33:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/10] fs/resctrl: Introduce interface to display
 io_alloc CBMs
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
 <a5bc5ecf27c229a0cf429dba6a174e39cf83357b.1754436586.git.babu.moger@amd.com>
 <63a8dd08-91c4-407d-8064-41d395d514bc@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <63a8dd08-91c4-407d-8064-41d395d514bc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1230d50c-55cb-48e4-63cd-08dde4cf04bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2M5bE4zemtrb3JPVXlHTTRrUmJBQ3JoVzlZTTNiaFlvcjM3Y2I1OExwcWxL?=
 =?utf-8?B?empRN1NsdTdiakhyRVl2RkJ1YUNBS0psSnBJbXVQMi9oUHhNci9GSkZtVXpl?=
 =?utf-8?B?cGtIVWd5RHJYZzlrNFhrbkgyeWNEOWUzNEo0UnI4Y25PamRNTVgxWDF1NTBj?=
 =?utf-8?B?K1Vmb29odXNlSTZhRzhmdVNnMmdyNzlDMWo4Nzh4TDdZMUZwdGhXcCtjVTFB?=
 =?utf-8?B?MWM2RTRRbUdVVS80S0VUdUEwRyt1ZFFodHAwMDFYQ1JZS3dkVXM3czlJTVFw?=
 =?utf-8?B?VG1ScU56ZkhtTXUraEdSVWtCRW9la0R6N3B5VU9mVzkxVEJlRjlBN01TVnJZ?=
 =?utf-8?B?SDJLZUJpVHVFd0tXWmFMVGYyTVpuTjVzcWMxUXdDenBqa3EwSGtmR3gvbi9R?=
 =?utf-8?B?VFNQM3F1eWdna3NteTh3cFNmN3MxR3dTT1pQSWI4UG8wYVNVemp4QzhWVmps?=
 =?utf-8?B?c0U4S0ZWL2YySVVyd2NRQ3hrVHpybk5BMzhKSDh2c09HbWhFR0FRNXc2MjJZ?=
 =?utf-8?B?bG54V0RQZHVYaUF0NEZrTzVHY1RBamM2NEdzaDYra1hOVHA4UDZnOUVRVFlp?=
 =?utf-8?B?a2diTEZVYS9IMEgrRFF5Yk1lY0UrK25jZ3FId1dScWZjY1NuVVhzQVVqYVBX?=
 =?utf-8?B?Ym5GUURoa003OFlUM3VVcjUwTGdyc1V0TFZkK2JuUXYrV2tyTFlUNTlNcHNw?=
 =?utf-8?B?TWU4dE81M0FwencrTlZTbEllZGZrMHBKOU5YR2R3OEJrdHV6Ry82NE16bU8z?=
 =?utf-8?B?N1BQK1J5dm5mMElMZ0VKdEk5MHV6Mlh6SG9Rbk51YlQvelpsTGpRbHZzckc4?=
 =?utf-8?B?aGNhOCtMVzYyVnNRdnZUOGRHV1N0T0NrendLMjJMZlB3ejFCa0RRVFlhZWdv?=
 =?utf-8?B?SnFFbURNNEg4eEkyVDgzejhvOTFvODAvVjlRL3lFa2N0Um8zelZyMFg1Vlgz?=
 =?utf-8?B?a25DelpZdDBaNE1EcG1GakZremxJeG5Cd2MzUEZBK0JyV202eVZ0ZTJuREpG?=
 =?utf-8?B?SXFTdjhYSzA2UERrVkhVTmtqbXpETVpnMHBkQitTWWJQdUlyRitoTDU0N21h?=
 =?utf-8?B?RHg4Uy9jK2FFTGdMUC9aUGdqKytyNGM5VWtlU1ZkKzNnMXptRjN6VnlFQUdy?=
 =?utf-8?B?czlXeFUvR1pNeXRaT3FsRWZGR09QSHV3bG9iRzljMEhzNjdqdlhMR1praXRS?=
 =?utf-8?B?TlJQZ2NtYXZETEtDS084MWlOTUR1TFIzRXR5T1lNazZIajZMeUhGYThtY1dI?=
 =?utf-8?B?Q2lQRW1XaDlsY3lyc284ZDN1VzM3RW5Bdnl2N1dpZzRvNXJMbExvK1dpWEh5?=
 =?utf-8?B?Uk5TRTA3MUt3bDFFWUFFTytxQ1lOeitWYzlWa3BJSmJOK0VNNEwyOEJBeURk?=
 =?utf-8?B?aVI5am1icG8zSHp0TjUzSlpSTnRoeVNESVpLd0hNWDQvM3VxTkZxb0tDOWI1?=
 =?utf-8?B?M3ZrMk9heUc3MkxvTkZUUFJpRjIyeWZEZFZVWkhBRThTY05ub3YxOWZmNUw3?=
 =?utf-8?B?bk4wbDVIVGJmQ1ltcis4S1RmdU9zSDcyQmw2U1dkaDAxQlNyTjZLTkdZRHYx?=
 =?utf-8?B?S1htdEJsNk5oUWJPdHRuYTRjR1FVZlZKenF5NCthUmVSYUpsWlByOEw3OCtT?=
 =?utf-8?B?T2xnU3lFaVVDd1ZrNjg3YVpKb3I0cWJQTFVra0VwR3ZERG5WbFVOWm43UFlh?=
 =?utf-8?B?SE02OGxTU2EzK3lWSHgyWlljVXdBblQ1UWN4ZWo1MEUrbjhBaFRsbXBTSVFI?=
 =?utf-8?B?K3dzQ1VObi82dURXT2lDUXVuU2VVQklKRnV6QWpwODhLay9GdWRrZVlmYmps?=
 =?utf-8?B?bXgyQzdNaENubVBhcVB6ZVRFWk5IalRoVGk3aHRLYUtMbXcwbUF2WXVaMFhl?=
 =?utf-8?B?Z2xvTVdhTWMvTnQwdm1JUWN1T2FUcXU5MTIxQmJnNU5IRkltaGdNTko2R3ph?=
 =?utf-8?Q?8s+qPurwuuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckdlbXROUEtlSThvM2phdzROSmxXaXVsdlRZK2ZaWFVmSHN3eWlJR0oxVWwy?=
 =?utf-8?B?N3R0eUc5RmEwRU1qQ2dSallKWndOT0dXNElSSTlXR2lMZ1VxcDJJN1hjVXdF?=
 =?utf-8?B?M0pKY2dkZXRWTmo0TDJlTnk0NzRWWHlydk03bVVZTnZrUXlGSFp0ZEtBcjRp?=
 =?utf-8?B?VTRYZ0dtMC9vOG5tZzY2VGhsOVBhWThFZXg4bGEyS3lvZVIzc05GMlNHWXlO?=
 =?utf-8?B?ZjJKdkZ5V2gvaG5LNm4xeVIyWkpvTElPWWc5a3dVcVROeEJTelZvbWNWdG9N?=
 =?utf-8?B?V3piUnZ6dHJaeHBvNi9GYlFVdE9KQ2NXYmdOaCsrak1NR2ZNNnZQMVBRRGNa?=
 =?utf-8?B?SHZhWVhXOFl4VEE4Mk80SVhvZjJ5YjF0alJ4RUQ0NWdPVjFqbDF5bW12ZVBi?=
 =?utf-8?B?TFV4QUJPbzJLL3VJNTZacjRPK3BkZzdiaGZOWkdXR3h0Z2ROM1FMU3JFeGdP?=
 =?utf-8?B?bXlobHdycHRkT0IveW5TMnFmeHBrY3EyTUJKLzJlOGFhalJuYjRWclBVTngv?=
 =?utf-8?B?UFZRU1NTVis5QnBsWTdQNS9RcFBJWm16L0VQWFF1b1JsRWg2MGlRM3hHK1du?=
 =?utf-8?B?cmxkTE5hSEZnVnpDSjVMQlBUeU9WMlFpMXlvcHh3dkFnaUxkUlJqaTN2WFky?=
 =?utf-8?B?SmdERTh0SFd0eklXRjYzOW5iYW1yaXRYaDJNQnpKdW83bk93TnYvMnZWOWVh?=
 =?utf-8?B?WGlpL1BVL0ZLaFJZZXMzVWpYcG52V012V1p5TlJ3MXNYMzdCengyL0hnWEpF?=
 =?utf-8?B?WXRZazV0YTRKd1lIU2tVZmc5SVB6THJPOGw0ZFZ4c2VZdmpWZTdxdGlET2Q3?=
 =?utf-8?B?Z0E0d2Z1bTg0eVp1UDBTZDRGaFJLRWJweC9rMnhuenZkeDlHQUhHejh1Vm85?=
 =?utf-8?B?QnBWZkF6elg5dUhCLzl1VjRKYnVQcmYrbHp2RGluYW1FQlF3c3JteHBqdWlS?=
 =?utf-8?B?blVYQTdENzc0RElsdWxxMGtWTEpwNWJCUGtZNUJUZ3dtZmQwTCtma3gyWU1s?=
 =?utf-8?B?d293RmpLeUFMeE1tZHo0ZzhtZzdFMWFhSDNEL0RWZTZjandaUjB3eVFRanZB?=
 =?utf-8?B?WUlBb1JGaVFLMStBRndNVno4UEhjLzRTSjJzNE4vSnd1UnBmUmZRY3dHeTZr?=
 =?utf-8?B?NlVpMmxsQncxRXREbkJ4Qm1lOEVpQWVpMU1ZMk0xTXRNQjk5cXlHWEdGV0F3?=
 =?utf-8?B?MHUvdUlZWFVZSklSRWlFMGkramZDNWxhOUF2SWU1UTk0Q1A5eUNjSlF4cHd1?=
 =?utf-8?B?RDJBSy9KTWdCRXdJbm1lN0R0a3JjdHlmaVNheXFITDBlYnpYakNhL0doQ1M3?=
 =?utf-8?B?OEhTa00wL2tlazdBWUNpMEdwS2g0dVJ3QVNXNVVLQVhIOFpaMDhsRVU1MTcr?=
 =?utf-8?B?SEY1MFlDbEpHR0J3dTZtVDl5RktKajhpRXhDc0hmWUM2RnZZbHFsMFJHa3FP?=
 =?utf-8?B?cW5pRzQ1dGxGeEs3OXhQb2hVTFh3UE1waW5Ld0MwS3ljRjZkbkJoVmsrS2Fx?=
 =?utf-8?B?dEhXbDVXQ2U3NU44UFRuNUcyZUEzSCs4dElJUktCOFc3ZW1LRjJrOXM0YUQr?=
 =?utf-8?B?RXFYNUkyeUttaERIVFI3bXNrY3dXc2dwZlVHUGxUSlRtWEJpdFprdUNTYUxo?=
 =?utf-8?B?U0xvRytka0pyR3NPUlhsaysyNFZVdjRJT0NVRUVJYjRKc29UTW5KdjN3Q0Nj?=
 =?utf-8?B?cDQ5UzVFRE5OYjIxMjRRZFg4V200R0Fpd3p2Nk9zWjVZd2l1RFN5ZWpRWWRs?=
 =?utf-8?B?VXZXM3hFMGlxUitWSU02NDBWb3dHOXk2d3JZcVBFYlZZWjgyYlBQNi83Vm9G?=
 =?utf-8?B?U3NwdUswOUV4cGhEWHVrQ3FXa2NYTkpIbUZITDlEZUR6cXR3QzErRldyOStv?=
 =?utf-8?B?NVZUU0E1dERyamhvQUI2VWZiSlNidDZqV2E0QXNXSFR1R0FjMnE5MnFtSVJ3?=
 =?utf-8?B?cCt3OUNtNU5tMDFyZjIzbHlWa0JxVTNCQjdseHpyTXJsbi9KT0szYUtSSXdD?=
 =?utf-8?B?ZHUxK3dyMFdxT0ovSnVEQWR4V0dkMVJ6enRvQWdMQ3FIN0E3WktueTJpLzB2?=
 =?utf-8?B?eU5VNHowQ3ZGN1IraERNWWROVUtXSTRPZ1RHaWowaXRhdnQxWi9Jc09Wa3du?=
 =?utf-8?Q?mgkg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1230d50c-55cb-48e4-63cd-08dde4cf04bc
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:33:14.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/nrpOBr0sFDBN5+IbTNv4+XDR+nJPMTq8vCX477Ehw8Fh1xYv1NIM7PF9ea4EqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195

Hi Reinette,

On 8/7/25 20:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> The io_alloc feature in resctrl enables system software to configure
>> the portion of the cache allocated for I/O traffic.
>>
>> Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) of
>> io_alloc feature.
> 
> This is a bit vague. How about:
> 	Add "io_alloc_cbm" resctrl file to display the Capacity Bit Masks
> 	(CBMs) that represent the portion of each cache instance allocated
> 	for I/O traffic.

Sure.

>>
>> The CBM interface file io_alloc_cbm resides in the info directory
>> (e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
>> necessary. Pass the resource name to show_doms() and print it only if
> 
> "Displaying the resource name is not necessary." -> "Since the
> resource name is part of the path it is not necessary to display the
> resource name as done in the schemata file."?

Sure.

> 
> 
>> the name is valid. For io_alloc, pass NULL to suppress printing the
>> resource name.
>>
>> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
>> associated with the L3CODE resource. To ensure consistent cache allocation
>> behavior, the L3CODE and L3DATA resources must remain synchronized.
> 
> "must remain synchronized" -> "are kept in sync"

Sure.

> 
>> rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when
> 
> I do not understand this part. rdtgroup_init_cat() is part of current implementation
> and it takes L3CODE and L3DATE of _other_ CLOSID into account when
> determining what CBM to initialize new CLOSID with. How is that relevant
> here? I wonder if you are not perhaps trying to say:
> "resctrl_io_alloc_init_cbm() initializes L3CODE and L3DATA of highest CLOSID
>  with the same CBM." 
> I do not think this is necessary to include here though since this is what the
> previous patch does and just saying that L3CODE and L3DATA are kept in sync is
> sufficient here.

Ok. Sounds good.
> 
>> initializing CBMs for new groups.  The io_alloc feature adheres to this
>> same principle, meaning that the Cache Bit Masks (CBMs) accessed through
>> either L3CODE or L3DATA will reflect identical values.
> 
> I do not understand what you are trying to say here. What do you mean with
> "same principle"? The fact that L3CODE and L3DATA are kept in sync is
> part of io_alloc only, no?

Yes. That is correct. I will remove that text.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
> 
> ...
> 
>> +int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r = s->res;
>> +	int ret = 0;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
>> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
> 
> Could you please add a comment here that explains to the reader that CBMs of
> L3CODE and L3DATA are kept in sync elsewhere and the io_alloc CBMs displayed from
> either CDP resource are thus identical and accurately reflect the CBMs used
> for I/O.

Sure.

> 
>> +	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +	return ret;
>> +}
> 
> Reinette
> 

-- 
Thanks
Babu Moger


