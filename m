Return-Path: <linux-kernel+bounces-844882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4F2BC2FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9A7C4EAB45
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39462224AF3;
	Tue,  7 Oct 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wo8QD/n9"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3A182B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880853; cv=fail; b=Y53HAsT6238sjhx+IcS/9TZtTEuXxNExnmKTl2sSa9Vhs8DB9RPcasuGzV9L+lPvBfo/6q3bSsZeUoSW2Mn8vci/zFSgjva4Rj+irIq+b1ECn0SQoxLxPyyHBxM/d0pNWTMR0VJbuIV3GhVXqHLCNcsBWH2Gh2y9qbzmKyehFRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880853; c=relaxed/simple;
	bh=ftWVtYCucYFW15GgSJikGSigP/nvyfjXZfgoPOqW+Xc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iStIl0i4ZMmrl0HXqcMrUJR+XO+hGbS5rYa6i72xNGo8GMuXbCDIyiqdAEtcQcfGK+j7vsOVszDVfn6fCdBBBo6eDuv8iWv7A/rOuap8BOZdbUH3jG9m8PKpHUmvA7JPUGRd2Y2oZ18cagZg5BOqnEbMrBLz8Fnj9/3UdZlf2Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wo8QD/n9; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVJIOkKv7j03DmZ7IYxbC4mxIdGlool3J7c9cXGJ7z7YZjQWqU18aVYwLJNJQiedsFqYR7MjKKbXt2qsq1DjVjYDv/5oKN4hEYjTcpNsewTeSDV8NCQixoqZCXnbzNfDSsLG/9Iy1NZ07/bcX/lujPStsyl2JGD0uRgz27/ZVpH7CcuUQb116McTGfqu0WbQpXeK0L3TlUtvkFgZMhp2qo4PEgZjodTAnvNpE3b+rOa+o/oChAoFjj0RaG6iCTxXCOmyWQp5l4c5FRTiOsklWuTG2qBqhcxzc9VQ4c39dStWxQ9zK2QCZs6oet+iXkHDc4u4LISqWi5MWPJqAVILfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwrqbMmGOWSHAEUxdIQJK0GpAs+lYPRLNwcWpTCpYTI=;
 b=nS9RGU1JoFLA9NsH08Nu74sxSz7kJVAJN4gbpNKCbAA4DtZSozlhGjd9oLwCeZ6WK15FE2OiUsV2ym3exjPu8JNk1UKbsyShxZkAY8Ca3WgkMyeC9dhxKFXqcyjnTsAZAZ396BCU4szIOgEg3yShX488nSIqUQ8dcM4HAdhkr41kDC1O3dHFNr/VtYG7STb8/3RdIQZgo1LXhrrUeu/QrDfQco/+pOAmQgRTvvr/zwvDSmWwLJ3CMM/DOHpSY2fIoXDgCABGbUkxPCfGPnHRnuX6vv8oWoEaqCZ2bQLAx088Kly4grHVk5dtI70ILvU9WhWQBgCJwVuzk25x1IITUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwrqbMmGOWSHAEUxdIQJK0GpAs+lYPRLNwcWpTCpYTI=;
 b=Wo8QD/n9ttAN61M4nr/JlUUnjWJGf0CmwdXmr2QEJeMqdjDn4coOLhzjE/ozyrW70B0NKnyp6DCeIAUxPrq0t7oDkqkZlrFa7pYDRbAU7FWQPla5WrS4nVG/xbx3l28ppnBAgAAjNIN1b+7EezDRkWfLqLxX/teLdk+Un1rL4Y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH8PR12MB9767.namprd12.prod.outlook.com
 (2603:10b6:610:275::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 23:47:27 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Tue, 7 Oct 2025
 23:47:27 +0000
Message-ID: <3e1b459a-bd9a-400b-8c10-038b330e539f@amd.com>
Date: Tue, 7 Oct 2025 18:47:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peternewman@google.com, eranian@google.com, gautham.shenoy@amd.com
References: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
 <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <fe06aa33-3351-45d4-a687-ff88a689be6e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffa8c36-177d-4a95-0a95-08de05fbdeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azI0QytMNFVwVFpVcEVMaklzK0hpYzhDaGxJNUhrN0liS01ESmpvNE51TkMy?=
 =?utf-8?B?NFh4cWtqaUFhTUhHaDAxejF2S2ZuZ3hiMG4xR0RwRm0wVjVYV0hqNHVyMExD?=
 =?utf-8?B?VkNrRk9YQnQyV2R6QWp6QzFqMksvQ1d1c2tMTGZ4NkZmM1A2Z1pab3FPd3J3?=
 =?utf-8?B?MExmMlhaRnhoVmtXWkVqdVZ3YTAxNDByOElCOFRhTWE0eHd0Z3NjM3ZKNDVr?=
 =?utf-8?B?eGwxdFVNOFRxNkpqdTlxeDlqa1VYeFlLMVFVVlZMR0NPLzBxbC9kWnhHcW1T?=
 =?utf-8?B?c2pBV1hQK0dtOUYza1ZLQzFBMGxsYzliY1o4alVpRlJYYitnQm1KUzc2VXlS?=
 =?utf-8?B?MmQ2RHBzSTRRYzJOVlpXQmE0V2VnRVN4NHFGOFd1TVI0QXhvbXVWMjZwWnZt?=
 =?utf-8?B?QlQwakIwbU95QUtPeS9WNnBRWDdoRWVQTmNRcTEyK2FkT285SWkwbng3V3Iv?=
 =?utf-8?B?Y1NUYUtWZGhISHF3dHJwb2FQR2UvZ0JhaG8vWjlVOGpGUnNzNXlWdmIwSnJs?=
 =?utf-8?B?UzU5QzRlZXBQNk5LNjFIMEh3TFY3NGtISVp0RDc3QTh2YUtpcGRjY1NEbFl0?=
 =?utf-8?B?YXRuV1ZpZmlBNU9vaGk4Y1psWVA5RHl0Z3FmRzEyQnV1eWtnVUo5SHcwT1VL?=
 =?utf-8?B?OTJSdk9Fc2pqKzk5bjYxUHpWU05VdGRVb01PS1lsTjFHSjAyMTJOWm9IOHY5?=
 =?utf-8?B?K1lhdEtKNmh6NTVvN1VNWUxGcDk1OW1RQXlOU1BVdlZNbVNSWkp6dWpjQ3dH?=
 =?utf-8?B?M0tzcG11Yk9sRjBlRTd2bnNiVC9wVm9neUV2YlVXU211TU9tazNzLzRHWmp3?=
 =?utf-8?B?OVk5NUhaS0VZNGxwY000TmhTN2RHVm9IWmNRRzdtQk5iTTFFWWN1TXFYNVlj?=
 =?utf-8?B?a1M1c1dqWlNzNzdIWUM1MUFwM1RXOGlMNitjV3d5WjQzbmZ3SkxuYkJCVkpq?=
 =?utf-8?B?R2hzTGVVTlpXZVVWTDlYQjdXZ1RYTHpEODdZcjlvTDVOSThnbHVRUVNKd2pV?=
 =?utf-8?B?NzQyTzNKRHBub0pLY2Y0eFJMeC9WdXMwOEZUOXRzMVAxcGJDS1N2bWk1c3Ja?=
 =?utf-8?B?MDVZeFFKU3RsaEtUOUwrNy9rRkdhVG9LWU9GSU9FaEh1OFpYM0cyNTFlWEdh?=
 =?utf-8?B?U3JpSG1vd2tjanhIV2IxYkJQTXAzRGdwVTlkcGg5dTE5Qnlod1hsMmpYWnVp?=
 =?utf-8?B?ZDVlb1QzNENYRlhpekJwUzNzL1pCeUd2Y0tIdGVycFg0aHM1aFRSTDVIRzVJ?=
 =?utf-8?B?blFMQlZwRjBwZlFTRStzRlRYS0E3KzhHU2FkeEdkZnBkOC9weGhGODRmb01s?=
 =?utf-8?B?QmNCVkhWZkl4OTJwMnBSWWxSc1VXYmt3SGdKa2tkQmhTV3V2MTM3dm9XTTZ2?=
 =?utf-8?B?YVJLeDhiQWMyU0hrY3h0bWsxb3RvTXFpVW81WVR6a3piQ3F1cXQ0Wm9QRW1T?=
 =?utf-8?B?dHlhVDE5WDFEUUlTSXJvTjZjeGhvVlRMU0pmVlZNWFR1TzJQQVNSYkRTdUF4?=
 =?utf-8?B?OU9Pc29FUWVnd09FUTdPZDRsTlE1UVdvSzg4c3U4NFkzenNtQ1hBcEE5MnBV?=
 =?utf-8?B?WnJmZDZoZDY1aDlFaFBNZUljU2VzL3VadVlFKzhPcE1Pa2NNVUlTTk8wWHpC?=
 =?utf-8?B?bkJqNlIyTy9YSEZwSUozcnBSaEN1MnE0THJVNWVQcGc1OHY5WHd1UEFKdVM2?=
 =?utf-8?B?ZDdxejBrL2NvK01pWFdUeTB4VGtITE1lQ3VFRllGWmVTeUc1TXpENmpWaWQz?=
 =?utf-8?B?b0syekl6RWFveVl2V0M1dnhvRXZiRWpUVzltWUdGOTdrRDBZYUFSdStqcXlO?=
 =?utf-8?B?VHoxSWJxek5NeEwrNWxVMVZQWjNQQStrbzNVYnczQUxSRFRudG1MczZWd2k3?=
 =?utf-8?B?bUlJN3BEaG44b0VpQnpURkhVYkFjVFI4SlIvbnBBSHBhR3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkhBa0c5SFJZMkN3T3pKRE5aOXFJSmM5MFlMaUNnZ3p2V0lxcHRBaW9sTWVD?=
 =?utf-8?B?T3d1SkFiYnZ6NG1mK3hCTEhOQmo3M1pCUEp2L3B6RVhXK3A1ZWdCTGZ3cmZt?=
 =?utf-8?B?OVU1c1lLNVRqT1NWUitMMm4rMU5tbGNVU3FYODRrdDlobWRUMlFwUVVscTU1?=
 =?utf-8?B?QkhIeUlpdlFBRUljb29mdnptWlNPN1ZaYmE3aWVmaE1uNVJZcytRYlVwQzNI?=
 =?utf-8?B?N0tscHpwMTB4Z0UrV1JiMFhVVHg3L3BWbXkra0p1aU5hY2lqWkJuNTdoT3VR?=
 =?utf-8?B?bitSSXR6b1dXSVp2U2N6ck51VlVSZGdXN2FpMmRHdXhCN2tPdVZSS3o3WElF?=
 =?utf-8?B?R2hEazlGVHQvbVFHNFNKRmNPNkFWdThoUHdZU1Y2R2xGMlY2VFYrK1krVlRZ?=
 =?utf-8?B?ZTBicTZTOXpZd2RWa3h0b1VDYitxK1h4LzMvejNOMW5ucnNUOWp2Ujh2L3Jl?=
 =?utf-8?B?bzBIMlZuWVpodHFRNkJZUURNTVJMdGVxVHp6TzhseHM0cVZrRGRyYjhqUTM3?=
 =?utf-8?B?OHJqK3FjOE5XYlFHN2ZtbXIyT09tbFFHYjU1cVAzTS94Mm04UWtuZUU5TEhq?=
 =?utf-8?B?ekZtU09KZWFpT0poUlR6WktRN3NUbDVsZ0R3TC9HMUFydFhqdlprUmN4Zlkv?=
 =?utf-8?B?VldIcEpkYmpONC8xeHhidnhXYVZLUi9Pd2wrK2M3RytuZnArTGdWcTNlc2Y0?=
 =?utf-8?B?TEZ5WjdUUVlTLzU4MWpsdFFwaWZlZDErYnoyalJXTmxGK0xMK2NiQkVBQXZi?=
 =?utf-8?B?MEZqMEQyS1dSNDdOcjZieWJub3hONHNjRW4zNElNclRtc0dBM0ViSG5ObzhS?=
 =?utf-8?B?UkNEYURic3V5UmtreTBpWmhGQXJybW1mT0VEbzRNd1dFZlJUK1JCTkprRGlT?=
 =?utf-8?B?Sk16bTdobFhoc1p6OWl3RWFiMVYrdWtWYU1Kd1NyU21Fc1UwTjNUTFlFOWtD?=
 =?utf-8?B?aUJrYjBvSGpkWHNuWUR6RUR3RGhybktDMjRlM00zOFJFZm5Sc3RMeDRCRnJP?=
 =?utf-8?B?aDBtVjBRMHFDOTdhOS9mTVlmbE1wTVdqbVRYaE9FcXovQmNCU2c1Mll6OWxF?=
 =?utf-8?B?MW1JTmRSZEJZajlObGVhN0UwZlRBTitJMHF3VzVsN1BSUndYOHBaNVh0bTRB?=
 =?utf-8?B?ZU5ObWpkSEI4MVJaem0wbVhuQTRDSm01emxTM1E4bVpYRUV1VmhJcUYrczV3?=
 =?utf-8?B?a1VVYjBhcDNRNmdQUmxJNFN1ZktiaDIvbW9kaWtYcGJkZzE4RzF3RWgvZkIw?=
 =?utf-8?B?STJaTzNBVUpuQTBmWkt4SXgvNFBiNWc4WlpabVJsRmo0K1FVNmVvNzY3a0F0?=
 =?utf-8?B?Z1NHU2VzcHFQYjRuTCtXYnhSbldFUTdPeTNzVFZURWo5R2lKYmp3YUI0N2xM?=
 =?utf-8?B?TjRWMi9qVEtyRUk3OERDdUJrWjZEUFRETmpKVnBsT2Fsdk8rdjhVZXRFcVY3?=
 =?utf-8?B?OW11eXNIcUVEUjVtVVFFSGRIMnhaemxjQWo1VmEzWmkzOGZDMkhyOEJ4a3FC?=
 =?utf-8?B?T1IxYXdQNUQybmpFdEl4Umd4N3pLTXphM2ZTSDNGNnY0NjNma2VLUjJoUUxY?=
 =?utf-8?B?OTJSU3VHRDcvOEpWOG1ncE14TmVyR0g5YXRpNUE2SkVocTBUVEZQSFgrT1lx?=
 =?utf-8?B?eFEzOVNXUDFGbXBlck9DR1B2QzZRVXh6RzRqS0JRQlpBci9DOU5FaWlEZnMz?=
 =?utf-8?B?Sk1MZ2NXK0ZFN3RKMG41b2ZIeGlMOFR4SDJWNUEvZmUvcHBLQ2VoQU9ld1pY?=
 =?utf-8?B?aEVmeHl6SmsrUjR1ZzFjcXR2UElVdUpKR0NBZDhOajNrOEJBbklXOHBGOFU1?=
 =?utf-8?B?a21jZmlNY01pb2RCQkc2NGRaeWo0Q3ZqVEtjbTl4Zzh4RVliZUp1T1pCVUtR?=
 =?utf-8?B?UC9qTW1YeGkxdHlxVWNjbmxVcmxjbldBY1I5MHRyNmhaQ3lYOS9HbGQ4Qkt0?=
 =?utf-8?B?TEN5cWk5QUdwM1ozZFkvejdMYVMzNFo5UWVGUUMwcmZPeU1NWkFPTyt6YzJV?=
 =?utf-8?B?UWxsQmdBWm12ZU54dlhJZ3EyVy9POGM1T1FYSWVTOGNLbEQxdFNZS3AyMFBG?=
 =?utf-8?B?TnZaWHhUWE1ibzd6QVNMdzRGTTFzRnV4alFabUo0a3RCV2pwVmVUQm5VQ0Ji?=
 =?utf-8?Q?rRKc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffa8c36-177d-4a95-0a95-08de05fbdeda
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 23:47:26.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kc5Ty3usziDTHnvuDZOH0XmtTK6Eq0pboLVzQt9caImeYUkIHrHqTZ7oC/8RGN8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767



On 10/7/2025 3:23 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> Thank you for catching and preparing a fix for this issue.
> 
> On 10/6/25 4:13 PM, Babu Moger wrote:
>> The issue was observed during testing on systems with multiple resctrl
>> domains, where tasks were dynamically moved between domains.
> 
> (please let changelog stand on its own and not be a continuation of subject line)

ok. Will  remove the above first line.
> 
>>
>> Users can create as many monitoring groups as the number of RMIDs supported
>> by the hardware. However, on AMD systems, only a limited number of RMIDs
>> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
>> this limit are placed in an "Unavailable" state.
>>
>> When an RMID transitions from "Unavailable" back to active, the hardware
>> sets the IA32_QM_CTR.Unavailable (bit 62) on the first read from
> 
> (can drop "the" from "sets the IA32_QM_CTR.Unavailable (bit 62)")
> 
> (IA32_QM_CTR -> MSR_IA32_QM_CTR) (learning from touchup made during merge of ABMC work)

Sure.

>> MSR_IA32_QM_CTR. This indicates that the RMID was not previously tracked.
> 
> This seems like a contradiction to me. Some times, like above, it reads
> that Unavailable bit is set on *first* read after counter returns to
> "active" but this text (and the spec) also mentions the "Unavailable state" where
> where the Unavailable bit is set on *every* read while RMID is in Unavailable
> state.

You are right. Will change the text to make that clear.

> 
> For example, from the spec:
> 	Potential causes of the U bit being set include (but are not limited to):
> 	- RMID is not currently tracked by the hardware
> 
>> Once the hardware begins tracking the RMID, subsequent reads from that RMID
>> will have the Unavailable bit cleared, as long as it remains tracked.
> 
> Can we thus expect that Unavailable bit is *always* set when RMID is not tracked?

Yes.
> 
>>
>> Problem scenario:
>> 1. The resctrl filesystem is mounted, and a task is assigned to a
>>     monitoring group.
>>
>>     $mount -t resctrl resctr /sys/fs/resctrl
> 
> (resctr -> resctrl)

Sure.
> 
>>     $mkdir /sys/fs/resctr/mon_groups/test1
> 
> (resctr -> resctrl)

Sure.
> 
>>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/l3_mon_*/mbm_total_bytes
> 
> (l3_mon* -> mon_L3*)

Sure.
> 
>>     21323            <- Total bytes on domain 0
>>     "Unavailable"    <- Total bytes on domain 1
>>
>>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
> 
> This implies that the Unavailable bit is set while RMID is "in Unavailable state/
> not tracked" which seems to support that this bit is always set while RMID is not
> tracked, not just on first read after counter returns active.

Correct.

> 
>>
>> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>>     counter starts incrementing on domain 1.
>>
>>     $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
> 
> (l3_mon* -> mon_L3*)

Sure.

> 
>>     7345357          <- Total bytes on domain 0
>>     4545             <- Total bytes on domain 1
>>
>>
>> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>>     state because the task is no longer executing in that domain.
>>
>>     $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
> 
> (l3_mon* -> mon_L3*)

Sure.

> 
>>     "Unavailable"    <- Total bytes on domain 0
>>     434341           <- Total bytes on domain 1
>>
>> 4.  Since the task continues to migrate between domains, it may eventually
>>      return to domain 0.
>>
>>      $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
> 
> (l3_mon* -> mon_L3*)

Sure.

> 
>>      17592178699059  <- Overflow on domain 0
>>      3232332         <- Total bytes on domain 1
>>
>>      Because the RMID transitions from the “Unavailable” state to the
> 
> This paragraph contains a few non-ascii characters ... like the quotes
> around Unavailable above (and below) and a few other characters (’ and —)
> below.
> 
> (This happened in ABMC work also but slipped through with Boris needing
> to fix. Now I include a check for it so that it can be addressed sooner.
> Please check your tools to prevent these from slipping in.)

Let me check that.

> 
>>      active state, the first read sets IA32_QM_CTR.Unavailable (bit 62).
> 
> (IA32_QM_CTR -> MSR_IA32_QM_CTR)
> 
> I expected the Unavailable bit to be set the entire time the RMID was
> not tracked, not just this "first read"?

Yes. That is correct.

> 
>>      The following read starts counting from zero, which can be lower than
>>      the previously saved MSR value (7345357). Consequently, the kernel’s
>>      overflow logic is triggered—it compares the previous value (7345357)
>>      with the new, smaller value and mistakenly interprets this as a counter
>>      overflow, adding a large delta. In reality, this is a false positive:
>>      the counter didn’t overflow but was simply reset when the RMID
>>      transitioned from “Unavailable” back to active.
>>
>> Fix the issue by resetting the prev_msr value to zero when hardware
> 
> "the prev_msr value" -> "arch_mbm_state::prev_msr"
> Although, this can be seen from the code. It may be more useful to describe
> the fix as "Reset the stored value of MSR_IA32_QM_CTR used to handle
> counter overflow every time the RMID is unavailable ..."

Sure.

> 
>> returns IA32_QM_CTR.Unavailable (bit 62) when the RMID becomes active from
> 
> (IA32_QM_CTR -> MSR_IA32_QM_CTR)
> 
>> "Unavailable".
> 
> Related to earlier comments I do not think "when the RMID becomes active from
> Unavailable" is accurate. It seems more accurate to say that the value is
> set to zero every time the RMID is unavailable/not tracked in preparation for
> the RMID to be reset to zero when it starts to be tracked again.

That is correct.

> 
>>
>> Here is the text from APM [1].
>>
>> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
>> first QM_CTR read when it begins tracking an RMID that it was not
>> previously tracking. The U bit will be zero for all subsequent reads from
>> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
>> read with the U bit set when that RMID is in use by a processor can be
>> considered 0 when calculating the difference with a subsequent read."
> 
> Indeed ... and APM also says that Unavailable bit is set on *every* read while
> RMID is not tracked? :/

Yes.

> 
>>
>> The details are documented in APM [1] available from [2].
> 
> Seems unnecessary (copied from ABMC?)? Earlier quote can just be prefixed with:
> 
> 	Here is the text from APM [1] available from [2].

Sure.

> 
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>> Bandwidth (MBM).
> 
> (another learning from ABMC work, this can be more readable with indentation)

Sure.

> 
> 	[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> 	    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
> 	    Bandwidth (MBM).
> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> ---
>>
>> Tested this on multiple AMD systems, but not on Intel systems.
>> Need help with that. If everything goes well, this patch needs to
>> go to all the stable kernels.
> 
> Needs a "Fixes" and "Cc: stable@vger.kernel.org"?

Hmm.. Not sure. Which commit to add Fixes in. This is AMD related.
We should have taken care when adding support to AMD. Does this commit 
make sense?

Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")


> This patch will only apply to upstream though so would need backporting
> support. Will you be able to support this?

Yes. I can do that.

> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index c8945610d455..a685370dd160 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
>>   			   u64 *val, void *ignored)
>>   {
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>>   	int cpu = cpumask_any(&d->hdr.cpu_mask);
>> +	struct arch_mbm_state *am;
>>   	u64 msr_val;
>>   	u32 prmid;
>>   	int ret;
>> @@ -251,12 +253,21 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   
>>   	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
>>   	ret = __rmid_read_phys(prmid, eventid, &msr_val);
>> -	if (ret)
>> -		return ret;
>>   
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
>>   
>> -	return 0;
>> +	return ret;
>>   }
>>   
>>   static int __cntr_id_read(u32 cntr_id, u64 *val)
> 
> The fix looks good to me.

Thanks
Babu


