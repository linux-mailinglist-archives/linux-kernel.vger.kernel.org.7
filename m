Return-Path: <linux-kernel+bounces-732163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90102B062F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F3B17329F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D523ABB9;
	Tue, 15 Jul 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HLqkkeGM"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06025230D0A;
	Tue, 15 Jul 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593299; cv=fail; b=EKdtJ2+MRs6ttE0v4xO+dj6vV9hNnmLrCMxTEvCmvpLPn3q4cDRVWWGppgA9F10K7bvUEDrrcK/67cpJkDx10iXvPdvBZoudbPI0mNdWJjQcKwj0S0tpjEb/qV80AE6Va0uvoY5CMsNKPJRyqaNOtDg7muP0DJTyZu7damT2Tkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593299; c=relaxed/simple;
	bh=kCjmuJEzBkoOXUOmkZPYza5VKWM76fFUzsNb3ggAL7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAW2AzKuNcMcHDG2DpW1SIf6xByNouyRSIqRQD9YGUApQesIMa0oNaoniq/g5TtznQejM7YGBEJdLrTqYvkighU64VYVwyr2/9ocLiqsHgx/gwhbf8g9aB2NsSa4O8sQR/YsqS8y0/nYIsMpAkqOFZqxkUpKhsQWXrVMr3Eo/yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HLqkkeGM; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwy3/NnPX8lixJWdP0hc0jMxVOaSHlNR/e1ZGIArOG5zg/XdUnbHqzkyqjMSqHqho2JhVcpAW8CZCGfkgHOEilodvHgy3Ceh/ylHqing3X5vtYksYl1pMk/5ah+ogSLXjbPX+YhjpB0jJIHjB3gTgATuWPKrLcOi0E+zbr3c7kvZTY0qdKbqlA2k6l3hyrStlsZ2yarVOsE8uhyHoAZIt71j94UJxXyfQ6niQRBzd6eSovma2xsFHyeLZ+jURsmr0RVXed9DYUI+7Zu0dKfTh7sOx+PkuFNHHQdA0nKGLbA3OWVJqUxJL+cb0SLxleNHTZw0Qa1aoVdT/arKzoV6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXb7kvZJHOM+n0YTkSRaCxa94aVCQnhv6dggpuD5rO0=;
 b=x/8R0GaK090y/bTiGtU52kfrnetbEcW2aRDLTImiQGhpvtaeuJL5riK4SvfSiTreUmPlO3kcMfmyXhapgCFb+6kIjBBkRqsgqwvyYWgiYw/8SKB0oyZaSLDkUBQdGgL33KlU4OVPAdtobLUEyb8fQUliAcZsoU4hdE79waWmV8URbZZzQ/VYz0pd2BlNov8rQe9bb8/EVWeodWBakP1kzThpiQRzXheI8h3yfFbktV1uLTlZLvTmSYeN5fV+kAMbS4bG1Bj5p9D1+1+7SBgVm2ZM2hfYgrExjR6n9bDASnZigaDYNHq4OOMWaPzGjwEIjfNoUHP3B4Fn+LDHahpfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXb7kvZJHOM+n0YTkSRaCxa94aVCQnhv6dggpuD5rO0=;
 b=HLqkkeGM1E7K1bE6jybQx5P5ngAgl/5JanGzlu2Xuebk/ZRkP9TRn+d2q3TdLjqoDXznHsfYyIfQJZIOCZeCRhtpq8a8eafKpUKGaWoTNtBgzeuyNJFE+nFJ1iWiZCZMIitwYdjW4oY9MjCowv/CczJatlI3xUSPnLqfeCMtEBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 15:28:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 15:28:14 +0000
Message-ID: <e96a5fa9-50ff-4176-8634-db626c4b2b75@amd.com>
Date: Tue, 15 Jul 2025 10:28:09 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 28/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tony.luck@intel.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Dave.Martin@arm.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
 rostedt@goodmis.org, Neeraj.Upadhyay@amd.com, david@redhat.com,
 arnd@arndb.de, fvdl@google.com, seanjc@google.com, jpoimboe@kernel.org,
 pawan.kumar.gupta@linux.intel.com, xin@zytor.com, manali.shukla@amd.com,
 tao1.su@linux.intel.com, sohil.mehta@intel.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, peterz@infradead.org, xin3.li@intel.com,
 kan.liang@linux.intel.com, mario.limonciello@amd.com,
 thomas.lendacky@amd.com, perry.yuan@amd.com, gautham.shenoy@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <ef5934fc2b04654c7ff3e6bb910e7c5cf38ba62d.1752013061.git.babu.moger@amd.com>
 <CALPaoCjN7-1fBF+6x1X4SfhRyx6L8aWaOfqOLQzKMRp=zHiyFg@mail.gmail.com>
 <bdda1774-e03b-44eb-905d-1ca2e30ab61d@amd.com>
 <8a1e2bf5-1e6b-4142-b0ce-6b1bd3248956@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8a1e2bf5-1e6b-4142-b0ce-6b1bd3248956@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: a1292d78-b5f6-419e-6a95-08ddc3b436cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmVsM05XaEtVWGdkRTlDa24zUmpmblR5bWFYOGE5UnRCekY5dVZvSTIyY3ZV?=
 =?utf-8?B?c2l4L3BTdkcwUGZIUDRKWVkyckRyUFlBdi82NHdlaS8vUjBoVXEyTDQ0YkRG?=
 =?utf-8?B?ekNGSklFUEtCUFZCZzZiMWpjTW5XQS9CY2xXUExhQlNxNFc3SUZPaUZnMGZj?=
 =?utf-8?B?WUFMTGlyQjRqc1JGWGtGYzNSeld2bmxpOUpJaW5qZTg4NHhybnRFQ1R1RVlI?=
 =?utf-8?B?MDhxdXB2Y3lUSDcwc0tlRGlSc092Z05vSCtwa0J0SmNNeFFxZ3lnQ0dYSjhQ?=
 =?utf-8?B?MlhGbmZOSkFoMVRudjBYZmlFRE42c1VJZWhwWG9IVTVjQlJ5N3lFMkxzY3hG?=
 =?utf-8?B?eU9Bd20vVlRhaEJaNVZSTWo0SDdRL3Z0YkVWSXBCR2hidXg0eEVaeHRUU2VN?=
 =?utf-8?B?eGgvbGs4dGxkRUpwMTJlODE1UGFFSmRSTmx4ZWVuc0EwVG5yTE9lRUpQRHFD?=
 =?utf-8?B?Ylk3cEtrdVV6czhRNEROdWdjeWhuWVlHRFF3SzRhT1JNUUJZbHJCM1pZTWVC?=
 =?utf-8?B?Q0YzTTdRSjYvbXBsTFhqWGh6SVpUeW1HdTBNLzRKcjN3bjl5ZEFyQkJucVNP?=
 =?utf-8?B?aC9SWWxLcnd1NUpoYml4OFhRcmlTMlNrQ25FUzJsYkdFRTBPMXdUNE5mQmdl?=
 =?utf-8?B?L0dWYkxkZ3QzT25iL0hHMTVSZ1FCWXIrZUsyTWRRUW1zOGhBZW9WQXRld052?=
 =?utf-8?B?eFlmNHFwcjJPc3A2bTVFaU5CbkZIMHdMQkZaSXVrRlZ3UWI3K09mTVFKc1dY?=
 =?utf-8?B?YnJpUnFuNWNmcU1Za1hhRkFWWkt3ai9Rb1NKbG1mNzhuUWJxT3k3N2VxelpO?=
 =?utf-8?B?a3ovQVM4RkNZOWR0VkVsK1lNbldCeXJ3NXZpZ2xhYWhOaVdLZmJJSU15RkFx?=
 =?utf-8?B?UHluZlJhd2F6Skp4bDVUQ1pFMDNSTDk5WU1tNlpBbUIzQzQ4TU41bDRUeDlX?=
 =?utf-8?B?amk2RjlYOTRCbHpyeXNNYmtxaVVKZHlRc2wvOGJiQ0w3WGZJVE0zNDhXUUFF?=
 =?utf-8?B?R0gyUGY4ZERuMDVPZExLUzBhLytMTXJtajhGeWcvWkRhaGh3SzlIL0thV0cv?=
 =?utf-8?B?dHRYajBzbUNhWmllb1QzQyt1OUhrd2VnclBjRlU4MUxYYXdORkxxRjJFd2xi?=
 =?utf-8?B?a0xEazdaUEJ0alRZVE44Q1dOUk1XSWR1NjZXSzFsM3ppWEFpNzBCbndGSWxq?=
 =?utf-8?B?MERac0Jid1NvaGVNSyt6QmxyZjM5MThrQ2F5QkJnWlZjdWJmclpMeFZJbmdr?=
 =?utf-8?B?UnQyUVBIcDY0eC9iNXVQWm9MS1lhRjR4ZnMwbHhJY1V3SVlTbjkyMkE4UWZs?=
 =?utf-8?B?V3pVTWhwMTdYQUZsZ1pTTnlmcHNrSFdlZEdDOUt2V0xxT0xmS3dXeEVFRFlv?=
 =?utf-8?B?Z2JuYXpQZnFjVGt0Q2lZeDIzcGY1OWR1OVNySlZCczd3cFNId05DZjZWaVc3?=
 =?utf-8?B?NldZeTlHTm00SlZYQ2U2R05COGlPQkI1UkZyUkFnR2t4Q2lMM2dzZFNqaEUr?=
 =?utf-8?B?dGdKdW1JMGJ1aXo3Q1JpWmxBRFpTUnB6UVFUc1pwVVhuQlFDWFNlU2JSWWc2?=
 =?utf-8?B?S3V0SUVvNnVwYWU1K3U3TnhiN2YrSkVWY1I3QzkyTXpXTi9nejFNQkdSS1pF?=
 =?utf-8?B?YWQwNU5qYk9ZVDc5WE9WdDB6OG1lMHExekYrbUwvSTdxbjFCRWhDeHB2TUxa?=
 =?utf-8?B?cVFXdEVVeGk1K3Q1SmVzY2dtTnpOeERmTGlIY0IyQmswMDRVRE85NkNIN0Rz?=
 =?utf-8?B?WEZ6Y1NES1liazdqUWFmRkNnNk5YYXMrbTNzYk5pa2hzVTZjRHhLTG5FTUE2?=
 =?utf-8?B?RHB5M09KcDB6NmxadEJDU204VFhMWEZ1WDd6enZPVEgrSTBJVHFmcm01Tm11?=
 =?utf-8?B?RFpwWGk2ZE03ZHdDamFJT1pxK25aczQweUZsREpwZUNLdWI5REczd2tKMU85?=
 =?utf-8?Q?UJXeqg+QQEI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzQwVU5OUVhHVVBycUdBWWx6ZmtseVI4ZWNUa0J0RGNMbHdaRmNXWkM3M2ts?=
 =?utf-8?B?UzBpU1R4ZDVZQVpYM1ViQWZNVlNIeStuNWJaQW5WY0ZobjJIZzNTN25PeEQv?=
 =?utf-8?B?VXYrU1VxOUNhNmppanlsbXBjcUZOU1Qvd3ZaR2ZjNHFLUmNBTjdaN1dGaFQy?=
 =?utf-8?B?elRsZkFzVjlHcExSUEFNd2RhNGxEVW8zbTNpbTNqSjlrU3ZIVFBYK3U3MVJV?=
 =?utf-8?B?TSs2TERzcG5TTnpIL3U5Y2Nyc0VCTC9tS2dTanFSUmx6OEN6Wm16T3VubHFr?=
 =?utf-8?B?TGZ2aW9GNm1ROFZLZTVSK0I0dGFFY0RYYjFsaFBncEdEMERnL3grSzJNUGRI?=
 =?utf-8?B?NnpjRkpBWS9RdzJwdDdaL3pNWC80Y0xTZFY0akZpMkxLeEdaMDRHR0w4empr?=
 =?utf-8?B?OWJaY2JvY3pSV2lQaGhwV0c0SnZ0MmRHa3A2TmRubXhVTlMrTHdaY0VxdjZZ?=
 =?utf-8?B?TVMvaTc1RlZyRlpXbU9JSktST1dIWnJDK3hUMEs5UGhkZlF3SkVadVE3N2hO?=
 =?utf-8?B?cUFTYXZ2SmxlOXdvVzNkTmRESDFrR0YvN3R2bTZ1WXhKT3cxTk9ka3JSa0g1?=
 =?utf-8?B?TGY1bjNQcE5ZZkFLUFhOZUR3Rk0wNi91N3dZRnByY1NBaEZVYVdieVRVMHBI?=
 =?utf-8?B?STdHR2RySWIyaytUaGlUYW8vKyttcnR0R0Y5NXBMMkg1VVFRL2tSaENxeEMy?=
 =?utf-8?B?eHRITFE5Qk1HU20rYU1hV3dRUFo2ZzRHb1V5RFlwMk1lTXVXSmNzTkVMQWla?=
 =?utf-8?B?M2VUVHJ3MG42b0lvb0g5RElvYjIzdE1sZ05jRjQ2UUdpTk1JWnZwM2sxcFdB?=
 =?utf-8?B?RXBuTVgra0Y3cnhaM3lUNFcxYXhCa0tDVUhiTFdZcC9ZWnRMK3Z0c250UzRT?=
 =?utf-8?B?Sm04NE85UjEvVmw4T0xFOVhpVVBtUXRremsrY3NKRmN3SGJ6MlREZEIzTEVP?=
 =?utf-8?B?TkVyZ2ExYWVKQUFLRE9FTHZVcFJZdktNcW1UTkpyelJ0NDFGRzhkYUR2eDVO?=
 =?utf-8?B?WGJSZW9wd0wyWFdvWlpPN0xXcm94WHQrRFJSZTg4LzhoaEN6OWtzUVNjVGVE?=
 =?utf-8?B?WkEwRzBFZ253dnhkcjVYYzFXVmxrajFrTjJEbWZHVFZMQXdISHJNeVM3VU5P?=
 =?utf-8?B?SWpiVm90YVAxdzNHMnl3S2lwU1J6L1NKYkFZYm1vSGxxNS90N3VyVSt1NkVU?=
 =?utf-8?B?RTMybm9vYkZBUHMzK0dFWHBsNWdDQUs1NzA3RU9LcC9ONmFEd1dtMDJ6ZkRZ?=
 =?utf-8?B?M1RqTG5tWmgyaDVRU3VTS2JNbEQralIvcmEyTEhnc2E1d0N3T2NOWWxTaEF3?=
 =?utf-8?B?bEZLWGJjUVEvdVlpY2dheUNkTzVxV004aU5XaHBBd2FlY00wQ0RoZWhocjhu?=
 =?utf-8?B?cmFvL0ZhOFVBUnFRNzh4TlhsWDJ3d1VBZ3dEN2xUTW9zcjU4UkpBSVpCemN6?=
 =?utf-8?B?K3VCSFMrcTBRYi9pOC9uUnNMTXF4cFlDNmY3VjFSR0NIYUc2eGhOR2xxVzdW?=
 =?utf-8?B?bVNJRnMram9id2FOV2xRaGRXKzlFSnZKeWFtbWg4VkpaZ0tYOG1ocTVnUk95?=
 =?utf-8?B?d0pBYWk5NDJ2c0M2WklkdU15RlMwSE5ZVk15K0ZtSVM1R3VyNSt4Tm83TlZu?=
 =?utf-8?B?KzRRODB5WFB3NmpCMDVvTDdzQXFNV1J6em14b2pOYlpZalp6THROVVhjb1VN?=
 =?utf-8?B?SWVFSkRTT0xIai84dnRrcXF6YjY2WDNvUnhQNTNjWHQvamkzZGFtaURXZFVT?=
 =?utf-8?B?Y3Y4RXNnYW1vcjlVNVJBSklhdCtGYkduRVU0ZnZ2eFNIM2wvTDFjZXUyUC9H?=
 =?utf-8?B?YnI0dDQyZHl5c0FYalJVQ2hKMFE1UG1JZjNnT29Udk1INVVjb295d3kzNldI?=
 =?utf-8?B?YVByQjF5TDFIdVdyWjdJUDVsdDluaFJPVFR5MzNoTjZRZThCcC9wc0lFZU5W?=
 =?utf-8?B?RlJ3cTU5VWFZbytrVFBvbWVWc1Rkc0ZnY0NqeXBHcHlKZUVXSzN1TlZjZjlr?=
 =?utf-8?B?NVAwRlRucGVyaEpzc09HbWhtNk5MN1FTR2htTGExUHV4WWtMZllYenlnYlBB?=
 =?utf-8?B?djhoK2U0citMYWFwUE9nZklLenNMSHlGbXdLT3Q0RmFKZnpmR28yT1FnTGJx?=
 =?utf-8?Q?Mf2M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1292d78-b5f6-419e-6a95-08ddc3b436cc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:28:13.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Uxkxlq4HCDkbLMlCR6vddhDpgCXBo9Rmr3mOm2KJrBH6FXbl0XGebl6NbYuekDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Hi Reinette,

On 7/15/25 09:27, Reinette Chatre wrote:
> 
> 
> On 7/15/25 7:18 AM, Moger, Babu wrote:
>> Hi Peter,
>>
>> On 7/15/25 08:53, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Wed, Jul 9, 2025 at 12:22 AM Babu Moger <babu.moger@amd.com> wrote:
>>>>
>>>> The "mbm_event" counter assignment mode allows users to assign a hardware
>>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>>> assigned.
>>>>
>>>> Introduce a user-configurable option that determines if a counter will
>>>> automatically be assigned to an RMID, event pair when its associated
>>>> monitor group is created via mkdir.
>>>>
>>>> Suggested-by: Peter Newman <peternewman@google.com>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v15: Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
>>>>      https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/
>>>>
>>>> v14: Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().
>>>>      Updated resctrl.rst for clarity.
>>>>      Fixed squashing of few previous changes.
>>>>      Added more code documentation.
>>>>
>>>> v13: Added Suggested-by tag.
>>>>      Resolved conflicts caused by the recent FS/ARCH code restructure.
>>>>      The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.
>>>>
>>>> v12: New patch. Added after the discussion on the list.
>>>>      https://lore.kernel.org/lkml/CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com/
>>>> ---
>>>>  Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>>>  fs/resctrl/monitor.c                  |  2 ++
>>>>  fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>>>  include/linux/resctrl.h               |  3 ++
>>>>  4 files changed, 64 insertions(+)
>>>>
>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>>> index 06c8c08d0341..f9e9a8a66cae 100644
>>>> --- a/Documentation/filesystems/resctrl.rst
>>>> +++ b/Documentation/filesystems/resctrl.rst
>>>> @@ -354,6 +354,22 @@ with the following files:
>>>>           # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>>>            local_reads,local_non_temporal_writes
>>>>
>>>> +"mbm_assign_on_mkdir":
>>>> +       Determines if a counter will automatically be assigned to an RMID, event pair
>>>> +       when its associated monitor group is created via mkdir. It is enabled by default
>>>> +       on boot and users can disable by writing to the interface.
>>>> +
>>>> +       "0":
>>>> +               Auto assignment is disabled.
>>>> +       "1":
>>>> +               Auto assignment is enabled.
>>>> +
>>>> +       Example::
>>>> +
>>>> +         # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>>>> +         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>>>> +         0
>>>> +
>>>>  "max_threshold_occupancy":
>>>>                 Read/write file provides the largest value (in
>>>>                 bytes) at which a previously used LLC_occupancy
>>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>>> index 0722e72f6cb1..ccca2330eebd 100644
>>>> --- a/fs/resctrl/monitor.c
>>>> +++ b/fs/resctrl/monitor.c
>>>> @@ -984,6 +984,8 @@ int resctrl_mon_resource_init(void)
>>>>                 resctrl_file_fflags_init("available_mbm_cntrs",
>>>>                                          RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>>>                 resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>>>> +               resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>>>> +                                        RFTYPE_RES_CACHE);
>>>>         }
>>>>
>>>>         return 0;
>>>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>>>> index 4889e7556cc7..b7289ce2b3a6 100644
>>>> --- a/fs/resctrl/rdtgroup.c
>>>> +++ b/fs/resctrl/rdtgroup.c
>>>> @@ -1987,6 +1987,42 @@ static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
>>>>         return ret ?: nbytes;
>>>>  }
>>>>
>>>> +static int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
>>>> +                                           struct seq_file *s, void *v)
>>>> +{
>>>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>>>> +
>>>> +       mutex_lock(&rdtgroup_mutex);
>>>> +       rdt_last_cmd_clear();
>>>> +
>>>> +       seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
>>>> +
>>>> +       mutex_unlock(&rdtgroup_mutex);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
>>>> +                                                char *buf, size_t nbytes, loff_t off)
>>>> +{
>>>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>>>> +       bool value;
>>>> +       int ret;
>>>> +
>>>> +       ret = kstrtobool(buf, &value);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       mutex_lock(&rdtgroup_mutex);
>>>> +       rdt_last_cmd_clear();
>>>> +
>>>> +       r->mon.mbm_assign_on_mkdir = value;
>>>> +
>>>> +       mutex_unlock(&rdtgroup_mutex);
>>>> +
>>>> +       return 0;
>>>
>>> I noticed that "echo 0 > mbm_assign_on_mkdir" never completes. This
>>> should return nbytes.
>>>
>>
>> Agree. Thanks for pointing it out.
> 
> Not the first time:
> https://lore.kernel.org/lkml/7fcdb142-b188-4f8d-ab26-391e0b9cec8e@intel.com/

How did I miss that? My bad. Will take care of it next revision for sure.
-- 
Thanks
Babu Moger

