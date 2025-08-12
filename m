Return-Path: <linux-kernel+bounces-765473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985CFB23849
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697CE1BC00F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD62D4804;
	Tue, 12 Aug 2025 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yhhm8auK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487A21ABD0;
	Tue, 12 Aug 2025 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026471; cv=fail; b=g27peaFsIpgB4eh6ZaMYamxus+ZpQJEZKhP4Z5McOZDa9ojGfDFTJ/DGlhdORDT4MLBhfCl5s6s47NzwyFf+BKLf9j2/UVyDOpOwyAswlSWjByaT0HEaMd0QVKWtkfp6xS5xb0R7S8nemNMskUz7AB5aefiGGLnPk5ZEoemH+iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026471; c=relaxed/simple;
	bh=Dj3x1D6AEbb3yu69nLFJX9sIuB6BDQYJtZtgNS2upjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z8wIDbtUQUxlMzd/ngghwNz1Al0CcyAoSCDSlp2DKbs7ZtYisUDQe3Mv0fcVo5sJsCMVAC+HovsMRm6dye4rj76VHnmm8+NpqY+KmfXaK4bqosmWhFLpxeVZbWNROJsomYIY0bRfYFaITq/n1TzY/JeACJA34cmFXis3wnhJWNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yhhm8auK; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p//CvrsLbWN3DQaLquetBKm+9i6c7z1jLS8arQK1B4eBbngnXduECSRbcfuIMEzwA/qim/0fIcUaIIiTAVwAYFccQOO57u6RtWRX1wHjNxQ/eCrYoiSsAONMi+L0ZGQ3xx4oHLwHYdu/kEacX1YQ4dhtXnKaUIjgqIFsGsWrdmX+j+RdE0zfGrx8gakcqOrE40sEsqobPaszi3Kn9WwkUjPhIcefu90WSaq51kw4dwW9N42WNWKMgrnT60lqAvTfSFxvXmTVcWt32bHUiIJkxqHUneU9cbIFpX4D67eyAc4XmZ99Yk9Sn2o3320dvTyQ35jK0+6IzgbNnGoDP/jnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di5G9PM0arXs7Afgp3rVReYwXvq5xLIFDOvsRNkLixY=;
 b=cgBo4AmPIPhTWQpfY8v4ObMrSV1kV/yTnqdgkdSL6g2L/Xdey+Ucp1ORX+Gd3En+Nr4AzePT+AgeBiON5WTNNz2ImapX9oiGQQg076b8RnCO9fOrXTOWe0Yq5o+rE1eabpuEKvvHdGgft5zfkL2EralIeV9u/zWhDR/XzeePY0FX69YYg1ebM2PJ24KKlVM3p/evenxmcKNigPza/ek0ApKA/5uVqntQAtCu6loSbTD1pt83j/B8kcJ1Gh6kdp8qIF7MCubJDbWXJvRvm2fP0f2+42jtClVgQYDIuF2tERJTgx3ZFdYtaEr4uGRlHxcvKnqRq86T373l7e/sCcIf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di5G9PM0arXs7Afgp3rVReYwXvq5xLIFDOvsRNkLixY=;
 b=yhhm8auKZFJsfFBSvdxEp2dpWGAp5O8FFEZzJqzcME1ShvRN5bmhx7rEecP/CA2/QYKWIUBfjiRPQiuYmuXgNHX+ubMVCSGOaXHBhi+hxLlILw6fzBsVcJmjUUkay/ub030QX6PMLUZZ4eEy4EjI134Es5JSUAslObdIgNo1Kn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4407.namprd12.prod.outlook.com
 (2603:10b6:208:260::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 12 Aug
 2025 19:21:07 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Tue, 12 Aug 2025
 19:21:06 +0000
Message-ID: <5b8decc6-56d3-4740-badb-32017239f3ca@amd.com>
Date: Tue, 12 Aug 2025 14:21:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 33/34] x86/resctrl: Configure mbm_event mode if
 supported
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
 <dff9af435f3103a2e3750a563c753f65658dfebc.1753467772.git.babu.moger@amd.com>
 <bb734538-4280-4748-9192-5bfa5ca8c8ab@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <bb734538-4280-4748-9192-5bfa5ca8c8ab@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0001.namprd05.prod.outlook.com
 (2603:10b6:803:40::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd3101a-0dd7-4c52-db8c-08ddd9d562e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2EyRnFkbXA3blE1dDlxLzE3Yk5FK1I3L3ViZnhxaldNbTRRbHZZOWM1Y1Nx?=
 =?utf-8?B?UjdRTElUZ0tZTWNqL2I3b21yZXMrREs4VXQxWnR4Z3lSYlpsdXBSLzB1VHRr?=
 =?utf-8?B?RGVWQUVjTGc0Nm1kZUZlYnlLdFlNY1VZNGs2OVJWMC9zZ043VlYyYStEQ2Fj?=
 =?utf-8?B?VDFDMy8wcVI2OHYxb1l5WCtWMU1sWk5ENHFhZHJ4Ynd3ZEQyTmI1M1QyOTVK?=
 =?utf-8?B?Ukd6VjA5VzN5QW5TdXhGYU1tdjFReUg2K2NjTmRvQlIxaDM4elF2U0YwcGlR?=
 =?utf-8?B?OFFSaktZSEVjRzJMbHBpOHlTUnNESGwvUjdxMUdsT2hGbVhEL2JKK1dqQjZr?=
 =?utf-8?B?RExVcm9BRnluOENNSXV5MXRDMEtxMEgxdXFGK0dGd3hNZEpHck40RUtER1FD?=
 =?utf-8?B?TnFwSE1mOXZTT2wwS3haVlVDRnVjNG5JZ0c0a0QzZW5NMzgxU0VsTWFwVUx0?=
 =?utf-8?B?ckRGUzh5bTF3eUtsRVEreWtlaTZvdmJpRDBRa20yb05pMUcxbElwcVdxMGta?=
 =?utf-8?B?aHhnUzlJZERPb0ZPejd3VW5NZUxXeXQxNUIzNzAwaWlSdjN4S0t6S3RQNHFH?=
 =?utf-8?B?WVZ5dzdJL1crNTFHdUlneVBuU05qYk10NDVIaHBjdlVNQ0JxbWZRQWNJVVFZ?=
 =?utf-8?B?U0xaZ0ZuL29kYTFINWlWL2dsSnhVSWVpaXpYZXJtdS9oR2g1M2NPaUhjTVBW?=
 =?utf-8?B?QXFzQ1dES2ZXTDlHUFEzN3RHeFByYnNVcE94L2duQUcrRS8yZERPVUpsaFoz?=
 =?utf-8?B?VDk4cTlCOStVNnhKb3MwZlo5VWhQNmdQdzBORS9YSElRa0kvTnZGcEY1UllN?=
 =?utf-8?B?ZUNxbDFITFRmNmNreGVDT1plR20zeURLSE5pQ05ibnpNTUtZZVgwclBpSjVS?=
 =?utf-8?B?a3NrMU1peGdzQjVxeXNVUmVlMmJuTkpidDZWS0tPQ0NnK3FMWDZkS2NoZkRO?=
 =?utf-8?B?ektYMld4ODNoa1RyU2RROWZtQUdLdDQvSDFpQTFabEE4TTRTeWlSV1VrMGxU?=
 =?utf-8?B?SmNaUnY1bWxEQ1YyMjVqcW1jVmJxRnBGdHV5YlVSL3F4WjE5TmovTm11aWNO?=
 =?utf-8?B?cUxYc243SVhyKzQrSzNZd0RmMCtoeGluajh6Slk2djhqc3kwUWF0aHQ1MzVr?=
 =?utf-8?B?REJUenlma29uelZaQUtZZXkwY1Y3YmY5VGhPRDBuWk1NVFlTSDhGWnRPQ3E2?=
 =?utf-8?B?TzZFWXdqVVQxWDdwRlpnV2gyd240N2dSN2c0NUU4V05YVlJxRmZkbnZDYWg5?=
 =?utf-8?B?ZlQzdlBhZThvQVE0MG5nMFlpZmZDYjBoUkRDQWxHMHdUS2w5RUYrSkZWd2pz?=
 =?utf-8?B?QllVcWczS29IdlR5RmgwMjF1SC9FR1BmTnRobmhmT0ZTUFFhU0NBcCsyVyt2?=
 =?utf-8?B?WmNEbVB2N0E4d3dJbjFCY3hDY29ZeVh3QVZTRC9HWWFIMHhYeE9HUG9LOTdB?=
 =?utf-8?B?QlZ3YUlwSnJLYzl1UUFZaDYyRGIrTnRZU1EzZGpIOXhFMmNVUWhkSElmZVVw?=
 =?utf-8?B?RWg4VFNNNkg5elBBeVp2RE4yMTVXa0RvVVZqK25DY0lnY2N1UW5KVnhSTDcr?=
 =?utf-8?B?UHhxQmlwVGxDYUJWajlFSVlqMjdZRUVNSDRTYU5tanBpWGJobWh0T3JJTmlh?=
 =?utf-8?B?UGtjWTIvZDFvaDZVNlFCOGhrRWxKa2JXS0FRcW1TNTJKZFVwN0JkNFhKZ2F2?=
 =?utf-8?B?NUhHdFZES1ZPdUR4ZVpSWmcxM2JROXYvc2R3R1RMck00TkF2YmZRa3RtaEJW?=
 =?utf-8?B?emVJcVpOSmxyMlZaSm1tcXlGNnd0MTIva1BlOCtUYWxXNzRLOFB1TU1CMnhm?=
 =?utf-8?B?N2dweURCYmdTSTFwL2haYXBmVFNjOVpGalgvN0tOejBjamkrTHN4Ujl3VDJU?=
 =?utf-8?B?UUVIV2lLVElBT2FZMThlL3QzeDVwZjM2SXIwaHpzYnRYYWZhWk1sSXpXTzJ3?=
 =?utf-8?Q?dj3J4hyg4n4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWtDZ3FxVlY2dVRBbllPTWVBL2s2ZWpEKzJKK3ZYSVlxYklVMWhDamYzM05i?=
 =?utf-8?B?M2pNdFF1UkJFRS9aTmxMK3dTUWFxbFUwMWdHS3NXWkJWbE83cFZkWXdGeU85?=
 =?utf-8?B?QlY4bGQxYlBGbUlsOHdkbEt3VU0wL1hCQXV3ZzNKNEJZNjlYUmhyZTZQQ0Rv?=
 =?utf-8?B?OGZxMExzdE5YWGRsSFNoenlldTgwZjhjb3IwVFk4M0p0V2wralh2aGhXVFE5?=
 =?utf-8?B?akhiU0RMKzN2ZmliNVc4d25RM01UeGVDWWg5NUdZRUFldVpMb1JlQ0t5VmR3?=
 =?utf-8?B?cXJxczJ6MlZYTFMxOWdKSHNlNEhqS25qamlTVWpZaGU3dmhYWk9xNFVDMXRK?=
 =?utf-8?B?RlRsc2UvSCswMUFuUjB5MEVLaW9NdmQyOGlOc3VseVduUUc0ZEY2cG9kT1Zr?=
 =?utf-8?B?L1ZMUXpGcWViMmhtWkQrYUphelcvWUNyTW1QTUZXR1U1NW1WWUZWenFGL2pG?=
 =?utf-8?B?dytyMFUyckxoam9ZTDZhckVzQ2pGWkFqbEtXSlkxaHljOHRUcU9TdGxoRnpp?=
 =?utf-8?B?eTNzR0h5Mk5YV3dQRVVXY1U4ZmdXRFo0a09xLzcrUnJzLzNNZUQ2K1haVlN0?=
 =?utf-8?B?U1JRVlpuSUVmajRtQ0RvYlRlUUQ1SkxubGtuVlVkOVh3R2UwaXFlRWN4Z3Vk?=
 =?utf-8?B?RlNoT0hHRXRySlorbGJCa2tKZmEya1N6ZkVwRStxbjluQWNoU0VJdUl0SWEx?=
 =?utf-8?B?dGI5UEtaZzVGbkh3dm1KYllnOUxHZXNrdVg1V0tkdExNeGZRaTlodGNsa2Y3?=
 =?utf-8?B?UHp3V0xmTk9teUpsVlVUaWphemVHZUYvUzQ0eTg0aFR5RVVocXpvR25NUjhE?=
 =?utf-8?B?M1ZWai9YV2Vtb1gvWktlN3pqdncycndFSE1wcEo3ZHFxa29LaGRkK3oxR0Nh?=
 =?utf-8?B?ME1DWVRhaHBJaXNvSC9uV3Q3VTNLUlVkc1l2aHFmSmdhdGxOQ1lYbnlFSk9H?=
 =?utf-8?B?WmJ2eXk3ajhsSVJLVkNHdU5JSnM0N1VnOW9zTFROMSsyZGpJWjNwNnFCL1Rk?=
 =?utf-8?B?c0JGV0Q1V1Zna0Jtd0VpQ3hhV0lmSWovZGpxTjFxR1ZscTNYajZxM0JSSGtu?=
 =?utf-8?B?dTYzcmdmZ1ZkVE1CSmpkT2RpMlNLdXFaQy9wckFsaHpadjBrdk9paFp6aHF3?=
 =?utf-8?B?ZWRtZEF4OHBaZ2gxUFV4UWVWc0ZtUElGNndkV0hNWHBRSE5tTHloYWp2WVNa?=
 =?utf-8?B?M3FSTUhxU2l6b2hwMEZBSStIaUV4c0ZLd1p2Uko3N1RYUU9oOVAyaUh2S29N?=
 =?utf-8?B?WGNmY3gySHY0aWR1cStvSnNacEJJanMxUFBmWmVGdmR5WVBuVDA3ajZGVzUv?=
 =?utf-8?B?UEpieEM2THlLeG1EaXpMaHViSHhBd3BhdXlONDE5YlQwV2Q4M1lYbFlLaFpa?=
 =?utf-8?B?TER5b09RLzd1WUZiUFdCYXozd3hqYlFlUXhXamRLYjBuSEFUMkhreW9KS0hO?=
 =?utf-8?B?aWkxTVhnQlpmc1Qyd3YzRWF6Y0Z4ZEMxZjlBTDZ5bUYvK09aMkpSeUlBaGFB?=
 =?utf-8?B?M0NkYkVhQXJMejVuOVF4T20zT2Vsb3E1UFBkeVlaSnA4TkVUNnZMQ21ncisz?=
 =?utf-8?B?ODd0VXhjTkd2cHJ4emZvSjl2T0hCVU5JWmplZ2JVWENjOXFreUlsdDltZmgw?=
 =?utf-8?B?eG12MFo0SjVyYlFLcktpSTNwWFd3N21KelBzWjg2MFBMNjVzd3h5bVdHUmR5?=
 =?utf-8?B?OXBaNzdZNWNiU2x0NlZ4YjRVTzFyMkx0cCsrSFNJaU9PV2tLZUlEblNVYmlx?=
 =?utf-8?B?Q3BDeC9EUWdidnFaTE51N3RWVmYydzFwQnBaU3FqcGFpZ0MrZGV1N0hrTkhj?=
 =?utf-8?B?VFhYc3FqQS95Mm5iZ1lNVW1NQTNSL1dHTTBQclZTNlM1bEtiZCtQdDBSRmV2?=
 =?utf-8?B?ZlRHdFI0M1AzOGwvTU1TaXBqcEozT2xHQStocXBteHU3bnlMU0RCd1VVSDd6?=
 =?utf-8?B?MHBOTWJ4Z2tCMEJzbFlvV1hDSzAwWkd1cVFnalhnZmhqc0prcHprTzF6WVNh?=
 =?utf-8?B?b2tGTlNVR1VuUzg0OUhoeDhId3BhWnUwYTExMk1XZkM3WmtCT0oraExPelNF?=
 =?utf-8?B?amZ3SVZKZ0Zhb0JPS1RKa2s0d05wWm9iN1k0ei92OU5adW9oeW82QkVNRDF2?=
 =?utf-8?Q?mfsI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd3101a-0dd7-4c52-db8c-08ddd9d562e7
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:21:06.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1b42EbKP5VBRg4I63eoSJTlvc5IG+9xoh8rWtRFxaYCDo3IDThs8FpnnNTJtbOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407

Hi Reinette,

On 7/30/25 15:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> Configure mbm_event mode on AMD platforms. On AMD platforms, it is
>> recommended to use the mbm_event mode, if supported, to prevent the
>> hardware from resetting counters between reads. This can result in
>> misleading values or display "Unavailable" if no counter is assigned
>> to the event.
>>
>> The mbm_event mode, referred to as ABMC (Assignable Bandwidth Monitoring
>> Counters) on AMD, is enabled by default when supported by the system.
> 
> needs imperative
> 

Sure.

>>
>> Update ABMC across all logical processors within the resctrl domain to
>> ensure proper functionality.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> Patch looks good.
> 
-- 
Thanks
Babu Moger


