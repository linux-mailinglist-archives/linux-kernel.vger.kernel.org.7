Return-Path: <linux-kernel+bounces-847333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1971BCA8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D781896291
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131541A0BFA;
	Thu,  9 Oct 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kp+OchPr"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224231662E7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760033709; cv=fail; b=svsNK+njE4YAYIDXjbCreKjeqvz3sWVV53MB7yDxjAbDrYmrgBjJJ9XBNCzNuV6yWmVgcvnhPigHSvDQpZAKJFlbYbe67ynwICoNxvXjQEh2CfOoM6axp2A9SPUX17ru4gku3aVTpQM7bTyBxolBIGYsrBAnYK9GzOV1gjsUpKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760033709; c=relaxed/simple;
	bh=G84mHAqd/kYsrQFvkgvHC41Hw2UQ9E1sWv9xegTIkC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rhI04/tpLOM5yIwqb22xgTmAESEK9+0CRiMrEAZ3stJtsdlE9j244U2cz5RQMWuhFN48OTz3lU3c0nettX5N0AqygYb/l7iWAsFXOaq74pKlbZ2ZT/WKPawLvJ9iHp1CBu+EphIoFBjMMI2RuiEojCWqhxo0jWDDSPcD0Oqs/vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kp+OchPr; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIoOolWM4X0got1eP/gj4YSn78egqlJ0V6V99Vh79P08+0D7eXlBYNb809CGLPWNd7vLyDuySj+k6YAbAAs583/JZiFVUEthOGgZWziYj5S1YftECDuEF1EVyrlZjQPR3/PDijbgZvoqREbfeTsoAHfroznjVlAkyKEcYEBtN5R6r+ekqLqmtsigrfXmuooariWbOMK8xsmi4geLOg3TFznKhfBGuu9Y+9g3ISE4zPhWE+VZPGVPcaM7QrOlCGDmXQ2Cy8qLEgcHyPWgMF0eoPW7204CsZ3WqYTlrqeAP6Rl4hVUU0oV5nYieYy9+xc6ksKkxNEhb14tTgpeYZy8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMrb3fSjhw7NRHoxvCXD/5TNHEBpdYfMiPWYA07JL2E=;
 b=VbspqlR4OwbJuZqcE/nHtgYlsj2yvs0onnco2wtRiwhaVIGtM4GvkcdevKMxArdBbHZy7IRfPCUU3IxnRslTe1yro9wc2aH3x9uw/EQMTDbXmWn+0aGJuQFMx0A2EkO/DUdliDxhMNV3xrpjdXnQ6AXfO/t+vmxHFbV3OXrQkod+zPLziQb5Jz0IR5y79JlZf32hBKcfBUAyMFdG0I4hL7m3/RmfHhhNBQK22TawOJPFWdBz7sVowxU4aTEj0dAS0SVXtGg9tZu0cnWfOe+tqYbnsmE3z3MvmDWJsHMS8cY8W+ohZsKf6WN/0EQxGBGjmF3Tcz15vJc++aNFHPiFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMrb3fSjhw7NRHoxvCXD/5TNHEBpdYfMiPWYA07JL2E=;
 b=Kp+OchPrJHUIN/ROx3Vf/MYGD1eID7Ob/iKZOiC7I2Lh0a4nbpQZB6Moh3eBHQGscAHG6s2Ht7BvTR1SEcX1i+LfpMFOsNHDbZE568MYxZtvyw6VucwBPOJILS3vCxeZ/+ssd1mfBgBS8UASmRl4pnyI8CVFvMKD2devGNuctZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA1PR12MB7038.namprd12.prod.outlook.com
 (2603:10b6:806:24d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 18:15:02 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Thu, 9 Oct 2025
 18:15:02 +0000
Message-ID: <091e40de-716c-47e5-85eb-ee09a7d6ae50@amd.com>
Date: Thu, 9 Oct 2025 13:15:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating
 previously Unavailable RMID
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peternewman@google.com, eranian@google.com, gautham.shenoy@amd.com
References: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
 <78dcda7c-b3f2-4149-b6f8-3da695d83bdb@intel.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <78dcda7c-b3f2-4149-b6f8-3da695d83bdb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0183.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::8) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3a62f5-27d5-4235-407d-08de075fc3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzBlTTM2b2l1S1JLSU56MHdjQ0JtY3cvMVZ5RE5IZEdkekFqNlVFQnBRVjIz?=
 =?utf-8?B?Ykg5ZnZJcW00ZTduQXdEOXpabG56SmtiNUNiQXV3SzlheGhPOTVkTmRBUmNk?=
 =?utf-8?B?dnZzZFNHTWl0bDNRZEowTEJldG1Db01rYWxKQTY3eFZPd2c2cktUdDlGZSs1?=
 =?utf-8?B?RDVpdW9OR0s1eTVRdGZXTWMyV2RjWjVYbnRPVkN1TXd4Vm9Jc1prU2xUTDZl?=
 =?utf-8?B?N2hIeE1qcU1NdWFHUUhGTlBBbUdOSEU1bmV2eWtoYUUzUGpXR1BBTmtjYnFE?=
 =?utf-8?B?RTBZbnNjUko4bnRPNDUxMVQrdDNWWmlnRUJJQUNKUEJkUUpMcS96dlE0b0hy?=
 =?utf-8?B?Qjd3TmNwbnVEd0pUdDZVUFhXdk5GQ3Y3SFVHNVJWbWN6SmFEZmM0S1lFSzdS?=
 =?utf-8?B?U2p0NEd6R1VpWElVdUNlS2hKOG9jSzRoM096R3FQNiszNWhNdXRZZGdpeG5t?=
 =?utf-8?B?dm4rZ2VlOC9JVm9DZTRzR0xDZHZ2MGc2Y0U2anZZVGxhd25nZERhTzZDZytv?=
 =?utf-8?B?dVBXNVk5aVYvbjl5MElPYnh4ZE8yZ0kvRHF0Mk1NUUxDbzROdVAvaHNWSTNJ?=
 =?utf-8?B?MUNuYTRCTkhWYmdLWTdWckdqMWt4aHBOd2JsczNzbVgzVjl1cXBiQVBLYW5N?=
 =?utf-8?B?ZGw4RUhjenlNT051R0tGOXRjN2dKUlQ3S2RLWjlRZDQ4dmFFTVJpQ0IyNlNR?=
 =?utf-8?B?eE9PbU4zS3N3Q1BUSWxCaUZDK2VhZW9OcnA1d3JLc2xGNDJuRWlIeFpXREpZ?=
 =?utf-8?B?VGJNbHNhUjA5K0JaNWNHUXRyaXk5Z0F6dU5jbWh3dHBob2EwR0t0NGFaQkE2?=
 =?utf-8?B?cTR2TUFtSmJwdE9RaXh6d3Y1VzJheTNoUmVwSXdqZ0N4RzJQeEhjVWJROG9P?=
 =?utf-8?B?ODFYaDlEYnpKbUEweGNvdmpZcjB0K3RoMjJVUW40SlBLc2QxdU00UHU2K2hr?=
 =?utf-8?B?akhlSzgzSy9KelU3cWRhcW16UlNTN1g1Z2orSEV3dDZDNUM1WXFROVpQVTZq?=
 =?utf-8?B?ZXh0eDc5K3IrZC8yVFNULytGQmtZZWQ3UmFOSHFmT05RUUIvM293Zmt4MXg1?=
 =?utf-8?B?TUVjekc4Z0VHc2xla3Z4akpTN1NpbWFSZ0JuZWRhWWc0RUdJZmE3REx5RHNp?=
 =?utf-8?B?WGhMckppVll1TmJYaDlzc3F4U0JnSzJIMjBHV1htbVFjcDRqdkhIbmdKb3Iv?=
 =?utf-8?B?Sm9PUno1NWt6Z3NyZnUxRUg0YURLa2FqNldZTDl1TVFabHB1VXUzMVZTNXNi?=
 =?utf-8?B?bnFqMHI1alQyNCtDRmlQOU9zSDlvQWNEWFFRRTl2T3ZZSTdJM0MrYXBncWc1?=
 =?utf-8?B?N0JRbndKWkZFZ3NVRUo2QXlvOWlRYjFwT2NmTU1kemNTV2h2WUZCQWJDOE5l?=
 =?utf-8?B?amdtNk10NWdOSG50OVEyOFNWTnYxVHN6RSsvUDRLbG5LalZ0SkdkVjZTOVN3?=
 =?utf-8?B?WGM5SHJrQ0ZpVENrSXFzT25LaDg5ZFRhMDdnTGdITEoyS3puQkNTL204dFpE?=
 =?utf-8?B?S0Q5UmZaTXA1bHl3UTh4YklCRHROYTY2SXcwTEZERGx2RGpKKzAzTGR0SkhT?=
 =?utf-8?B?S2JFVVExVDhZYUFmL2JKYkF1TG43RmtraFF3WEhCd0ZWcHpqazBFeEc4bEZq?=
 =?utf-8?B?NDVWSHcyWmNORUswbzMzQmFJVW5vMUUrY2k0aTg0ZE9DNE9Tc1FvNDhJSkth?=
 =?utf-8?B?eE9CK2dwN1M5VWhEcWlhRlhxTXpBSUpBT3NCaDBwZHA3bW9kcUFoMGtBMDh2?=
 =?utf-8?B?TGFtT2RsN0psV3UrUzhubWNlZzdMTzE0alVZUmxKQktWSzJnVDdsdUFhM1Bp?=
 =?utf-8?B?ZlpaZ1g3M2FiT0dzYWo0eHdnZVB5NXhXT3lkZ1FyYitaeWZrODVQbWJtRzFx?=
 =?utf-8?B?RHpEZmFKUzRpSGZldEk2QVBvTFp0ZnZRVFFCVmM1QjdSUXFqa3ZHbzVwekx5?=
 =?utf-8?Q?UYWmMk549Q7/CtQnKipxfIFDttmsMaZT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajE0dVI5eEF5azhad2x5ekZ5WC9NU0dKa0xVSWUzV2JvWHJFOFkySDdYR1Zt?=
 =?utf-8?B?VlkvNGh0a2JSMzlobWRmYkVFV01TeERoODZ1RVFWMkR3RnNmK0tnZGVwM1BM?=
 =?utf-8?B?VVdnUVhCNmQrczNTS0xtUUtRWVJ6UzFhSGNwOStzcjF5U25RcTNDZkdFT2pi?=
 =?utf-8?B?T0RubmkrejYzNWFzRjZSeldpMVNZcUV4MEd4NVlhWW53VFpMZks3SGcyajdi?=
 =?utf-8?B?Z3MwendIdUY2WGprTjRjWGlHMmN0TzFLTW9jdjVoWmNkM29UNFJTUVlsdE5n?=
 =?utf-8?B?SExQWktwbU82TFNpbk9xekUxZHAzVnlxT0ZLVUQrSldvTnZINHFhbmdYSDcz?=
 =?utf-8?B?c01pWk1leGNIOFB4cysxZTY4T0ZKV3RRQUQvcVlSR0lQS1o3MXFrOUwxbTdk?=
 =?utf-8?B?YS81Mld3VEszQkRnTFZkcDZzZUNZY3E0c0lqbWNsd2R6cWlHM2l6YWp1bC91?=
 =?utf-8?B?NW9GRFhSWnpFZlJrUm9lb1Vvb0lpR040WHFISW4rM3MvVFdia2dRb0ZBY0V2?=
 =?utf-8?B?SUl6QVc3Mjg2SVZRTzduSkp5aUUxaVhITWpnS09OdHhlOWwwTzhjUDJCVGVq?=
 =?utf-8?B?TFh3bmtDbzhnTnR4WlRwZHhDTjZ1a3FIdUtMdHhUeW9YMk1RaEhYNWtyRzdw?=
 =?utf-8?B?cmdJL1FxeDg4SnpmNEpxV2RrUkdFeDhZTnQwbFBXWUZCdjB2Qm5vTy9KSkNp?=
 =?utf-8?B?VHQ3SmxPN3pEV25qMGw4TjJJMGZiU0hLaFhERjBIVFpoVDB3WHBoT0tNRzkr?=
 =?utf-8?B?bTNheDVYZnNuTGQ0WVRiZGIrK1dEeXhYK2hrbDNFNml2c0xHYnVpMzRCd2Ni?=
 =?utf-8?B?WTRXZzBhcnBoWkt0Vm1TdHIxMFZPM3VKRGlvYnE0SDArZXdUZWIwTGVwR2Vj?=
 =?utf-8?B?Q3hpaW50SldWY0lrQkVOOHJXRjMya05VVnF2azMzL21rZjBaS1pYbG5Db1FW?=
 =?utf-8?B?UmwyL3lOU1NQOS9FS1BHUlFROWZSNjlOQW9ISGZMRTZ1UlVzcHNYbWgwSzEy?=
 =?utf-8?B?WVdWdVJ2ZGVQVEtWU0VvZVRHMTZzU2NLTWZ5c2FJdnIrM1JsTTlydnhVTWZt?=
 =?utf-8?B?ZjdzVmxFbVN4RXAzOE5pWHZJTFJoVGtJTjJpMEZBQVFWK2pvbXBpZGJpTFF6?=
 =?utf-8?B?VHFaTzczVHNXTlpTeUdrei9uNGhMVzB2SVN5L0w3Y1EzUVdZblRER0FBZFZM?=
 =?utf-8?B?VzdmYXYvQTN6cHIybXhOZWlTZk9BNmJPcjdxK2NGRkpKMnB2bjVkem1sSmtN?=
 =?utf-8?B?M2JWdGFBczV0NnhTWENYRjE5WHdVTFFoNFBqYjFkeitqK2gwcjhPRnMvVXFz?=
 =?utf-8?B?QkMvdEVMRWpJM1lRd050YUh1Y3FOc28rb3dmTHpFaFpRTEI0djZ2MVB4MGhq?=
 =?utf-8?B?bzN1MjdUSGM1RzE4aFQrS3dlWUNlejJ2dkhJejFXKzFKUzU5WHRFT2MremhH?=
 =?utf-8?B?VENod3ArWlhrS3ZpbXBqdDVEQ2xmeWFtVWFTTStFTElyWGdseTJGNWI2Z2ZO?=
 =?utf-8?B?WUhWY3ZoOThMS0JDOTdpMUtlUWFJdXJ0Q2NUd0toUkZGd3MycVcvOTdkUktO?=
 =?utf-8?B?U2oxQStjYU5lVmczM0xZNW9IL3BJQnJXM01QVGx4K2NZcTBDM0U2OWZJQkl4?=
 =?utf-8?B?b2hsM2JpZURGN04yUTFkanVaTUZwUlltZ1M5SE9nbHkvUVdZNnlpMVZocXdz?=
 =?utf-8?B?WVRVMVFIaWZETEFDL0tpVDRPVU9GS1BvUXd5VUNWSkhNTHlEVkFpc3ZNQVd4?=
 =?utf-8?B?eXl2ZTFMdEhGZWovQ2dlMmtwQXJmL28yaloveGdyWlM1Y0FFNUROS3ZnSnBG?=
 =?utf-8?B?OFcrWmtvcjNIU29NbU9mOVMzdGIxR0ZUclBLRzg3TURadk1UL1dST3RtUTVy?=
 =?utf-8?B?UnlhbkYwN0hmNGxrSVNkVzR5dVo5YVBVVWhLMDZSNGxiZStDNERyZFZZbjdm?=
 =?utf-8?B?MGJQRmdUcGF2R08vYUFSeTV3QjZwRVAyRzluMmluTHdTZ09NT2VwOTVOZGY3?=
 =?utf-8?B?MlNma0J0L25oc3cxYlM5RHFET0VsalVEMHZrWFZsZlROTnhSeURHV1hycDF1?=
 =?utf-8?B?d1A0M2hsUmNDTXB6c2VVaFJrQy95dis4eEhmQVhpdzNTYWM2eG5BUVIwUDhT?=
 =?utf-8?Q?XWnE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3a62f5-27d5-4235-407d-08de075fc3aa
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:15:02.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx7LU3WlSfrwHXqYn2evMxIBseomGMhHxeZmZmko9xi2JSghgdA595Qwj1NsSfZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038

Hi Reinette,

On 10/8/25 21:00, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/8/25 12:39 PM, Babu Moger wrote:
>> Users can create as many monitoring groups as the number of RMIDs supported
>> by the hardware. However, on AMD systems, only a limited number of RMIDs
>> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
>> this limit are placed in an "Unavailable" state. When a bandwidth counter
>> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
>> (bit 62).
> To make this context complete I think you can append something like:
> 	When such an RMID starts being tracked again the hardware counter is
> 	reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read after
> 	tracking re-starts and is clear on all subsequent reads as long as the
> 	RMID is tracked.
Sure. Looks good.
>
>> The problem occurs when an RMID transitions from the “Unavailable” state
> Which problem? (Please let changelog stand on its own and not be continuation of subject)

Sure.


>
>> back to the active state. When this happens, the hardware resets the
>> counter to zero, but the kernel compares this new smaller value with the
>> previously saved MSR value and mistakenly interprets it as an overflow.
> I do not think this is just about overflow. Certainly this is the
> most visible symptom but the stored counter value may also be smaller than the new
> counter value resulting in undercounting of bandwidth? (ignoring that not
> counting at all while RMID is unavailable is technically also undercounting).
Yes. That can also happen during that window.
>
> Would something like below be accurate?
>
> 	resctrl miscounts the bandwidth events after an RMID transitions
> 	from the "Unavailable" state back to being tracked. This happens
> 	because when the hardware starts counting again after resetting the counter to
> 	zero, resctrl in turn compares the new count against the counter value
> 	stored from the previous time the RMID was tracked. This results in resctrl
> 	computing an event value that is either undercounting (when new counter is more than
> 	stored counter)	or a mistaken overflow (when new counter is less than stored counter).
Sure,
>
> If you agree with the summary then please update the subject to match. For example,
> "x86/resctrl: Fix miscount of bandwidth event when reactivating previously Unavailable RMID"
Sure.
>
> I think Dave's feedback about changelog length is valid. The changelog can present the
> fix at this point and leave the detailed description of the overflow scenario to the end of
> changelog with a heading that reader can use to decide to skip over if problem is clear or use as
> reference to see the problem in action.
>
> I also recommend that the fix be specific and avoid vague statement like "to resolve the issue".
> For example,
>
> 	Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to zero
> 	whenever the RMID is in the "Unavailable" state to ensure accurate
> 	counting after the RMID resets to zero when it starts to be tracked again

Looks good.


>
>> Problem scenario:
> The portion below can have a heading to help reader identify its purpose. For example,
>
> Example scenario that results in mistaken overflow
> ==================================================
>
Sure.
>> 1. The resctrl filesystem is mounted, and a task is assigned to a
>>     monitoring group.
>>
>>     $mount -t resctrl resctrl /sys/fs/resctrl
>>     $mkdir /sys/fs/resctrl/mon_groups/test1/
>>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     21323            <- Total bytes on domain 0
>>     "Unavailable"    <- Total bytes on domain 1
>>
>>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
>>
>> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>>     counter starts incrementing on domain 1.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     7345357          <- Total bytes on domain 0
>>     4545             <- Total bytes on domain 1
>>
>>
>> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>>     state because the task is no longer executing in that domain.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     "Unavailable"    <- Total bytes on domain 0
>>     434341           <- Total bytes on domain 1
>>
>> 4.  Since the task continues to migrate between domains, it may eventually
>>      return to domain 0.
>>
>>      $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>      17592178699059  <- Overflow on domain 0
>>      3232332         <- Total bytes on domain 1
>>
> Is below intended to be indented?
Removed the indentation.
>>      In this case, the RMID on domain 0 transitions from “Unavailable”
>>      state to the active state. The hardware sets MSR_IA32_QM_CTR.Unavailable
> "active state" -> "tracked state" (to be consistent with terminology - not sure what
> is preferred between "active" and "tracked" but please be consistent)
Changed it to active state.
>
>>      (bit 62) when the counter is read and begins tracking the RMID counting
>>      from 0. Subsequent reads succeed but may return a value smaller than the
> "may return" -> "returns"
Sure.
>>      previously saved MSR value (7345357). Consequently, the kernel’s overflow
> "the kernel’s" -> "resctrl's"?
Sure.
>>      logic is triggered—it compares the previous value (7345357) with the new,
>>      smaller value and incorrectly interprets this as a counter overflow,
>>      adding a large delta. In reality, this is a false positive: the counter
>>      did not overflow but was simply reset when the RMID transitioned from
>>      “Unavailable” back to active.
> Here is what I do to check for non-ascii characters:
> $ b4 am <message ID>
> $ grep -P '[^\t\n\x20-\x7E]' <downloaded patch>
>
> Could you please try it out on this patch and fix the matches?

Yes. Now I see. Thanks fixed it.


>> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR, used
>> for handling counter overflows, whenever the RMID transitions to the
>> “Unavailable” state to resolve the issue.
>>
>> Here is the text from APM [1] available from [2].
>>
>> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
>> first QM_CTR read when it begins tracking an RMID that it was not
>> previously tracking. The U bit will be zero for all subsequent reads from
>> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
>> read with the U bit set when that RMID is in use by a processor can be
>> considered 0 when calculating the difference with a subsequent read."
>>
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>>      Bandwidth (MBM).
>>
>> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
> Tag ordering guide "Ordering of commit tags" found in
> Documentation/process/maintainer-tip.rst places the "Cc" just before
> the "Link:" tag.

Sure.

Thanks

Babu


