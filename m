Return-Path: <linux-kernel+bounces-883711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50217C2E2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 101D74E22FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F172D47E0;
	Mon,  3 Nov 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zLSW447z"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E192D321B;
	Mon,  3 Nov 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205782; cv=fail; b=Uvyeb7bA6F+mZwxCSPW7uA+PI6Q/lwQIgWJt0YPna8tMIBrAHNpss5pBPWK0tPWJ9zk6lJMgCiQJoGkAjgqYA6eJ5vrJuwFG2aqmt8a95tf0GbQRTNc+efaAzy88SPZ3ksmcQJAX4eUmKJUPee8HfGtb25mBFvxcJkVrR2yJ718=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205782; c=relaxed/simple;
	bh=e5lBOYMC689A84w2bCIWEnNaAo1rQLgR9E8mC6G+qd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UjwN9KcyaEkO99kaGuP1UCb1nv3D6R0McclHG8Y35hmXTeDpfBOiz1KwLV3XxBq/C7cC8A3DoReghfFdvu8GilBmZL1ymBOg+D7gFY0wN+yMLyqDKjuXDrnB1lVNBloaSieERbTWDYTfwuZA0eCujBF9qPgNPfhC9UVhsMMEk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zLSW447z; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeJ0lY/IWR/0C+DVeLSbYxSnbg+Ovvxk+DxbmuQPRRgKdx79QdMmxa2o7ua3uxHa9AIS2EfwEFN8GxZhLIH6QsB8nbBNs0ws2wgJY+KSspQFPV4hvpwM66+kUy/AquybPJK4X4ftvMvOxOPbofDHzG9AherG7O6UhaaTFm/Nlwom1LyJBotbPKjxo25Sn9Tj5zuzx4Nz/cIz2E+vPDTJT1j0jqHaFLiQrImo6ck4zB7Mv5HpNtewcLuv1FPKZapldPBTBH+AA/7HSMWmUcmMQlNEeTdvU/lbrxgiNy/a15GLLkW3X0MPry+wbVStzTBmUZSNLQrLnL6CNHwRNETtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w/VS1vtyiO8f86xanFa2TuplQZgSZMfKrPNi3LAVU4=;
 b=vzkYK8fqMvep/IT07g7CNahdYnqyaY+OnoEmb/LnCH3xTKqlfpD6AmnB6k4O9xcOoAMVkkXOUy69I7mZoXzWb7UMQF1/S51yrSDaft6MeqVYpihhW8OGvn9Er101tgXfAWaVH+bieCH+V7sRp9mNbkd1kv0kS22MOl56lZik7ptivz29xzeXUELOyPzjUgFRlEQqlVKE11JzMwgLJpxL2KcphfoccTef8BMXS951MQc7HOKIZ2WGpr8V1qhWsAh/GPgnQWzyrv30KQkU/xDE8VFEsW523SIY5FgyQrC5p7DmldWMK0PBSBipp7EIIEyRTu7WAzFnV1PoF3/CSh0Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w/VS1vtyiO8f86xanFa2TuplQZgSZMfKrPNi3LAVU4=;
 b=zLSW447z0Nf3F11WhLQwNH+h6EhmMc3So0UrylRb7mLLYVhB5xavvOY4M5/T2t1MkWAyMqrfv8SsGFvwOUaXUbYRsYxOn++odGpast6h1A7UhyO19pQZLvZrlJXioxpg1Risr2D23Qud1hb1CDffu7iEGgO4zkuGa+bUq5ASxHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MW4PR12MB6924.namprd12.prod.outlook.com
 (2603:10b6:303:207::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:36:17 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:36:17 +0000
Message-ID: <674c91d8-7349-425f-86c6-fe03716c15ac@amd.com>
Date: Mon, 3 Nov 2025 15:36:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: corbet@lwn.net, Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org,
 hpa@zytor.com, akpm@linux-foundation.org, paulmck@kernel.org,
 rdunlap@infradead.org, pmladek@suse.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, thomas.lendacky@amd.com, sohil.mehta@intel.com,
 jarkko@kernel.org, chang.seok.bae@intel.com, ebiggers@google.com,
 elena.reshetova@intel.com, ak@linux.intel.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, feng.tang@linux.alibaba.com
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
 <43506b9c-5ad7-4871-8a24-11e71380321d@intel.com>
Content-Language: en-US
From: Babu Moger <bmoger@amd.com>
In-Reply-To: <43506b9c-5ad7-4871-8a24-11e71380321d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: fa61bcf2-2ae5-4101-b298-08de1b21057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVVBMGF5ZlhRNFZRTnFkR2NXZDFuaE05SzNwcHBKZmJTWlFVcGhoeEJGWnFD?=
 =?utf-8?B?Y0RaUUtqR0hZdkZibEVwS1BBakxaQ0RHMUM4dnlkMnA3SkFYV3NjT290VnBV?=
 =?utf-8?B?YnRFdityUlZKRVdNYTlmcFB6THJ2eWpQdEsvRDlMOTZFMGIzK0pscUxwTkNh?=
 =?utf-8?B?QmVPcFZ1V3prcnBDUW9OdEEwbUF3cStmdkl5cXg1UnhhRTdET29xRVZuNlhI?=
 =?utf-8?B?RnBNc1d0Nlc5amRtd1ZFNjhUeS80U2NlWnIrZFdyNTVqUG55WjJJMmIxSER3?=
 =?utf-8?B?b1QwUXBzSHlBUmFSeEtyN2d6RDREMzhFTUttRE5zdWIyMEdZTXlxMml2UFEy?=
 =?utf-8?B?NGRWTGRkbDNDZS9OT29GK2N2UzhYOG1rUVZlUmFrNE9jRm9JQjFwMHozbWZU?=
 =?utf-8?B?ZW1CbXRpb2s2WktCWC9CUkdxNHFKcHl0VjNmWERtZ3dsbFdUczhMZXdFaUFY?=
 =?utf-8?B?TnIxakVxOHpJWVdqemM0VmtKRFhMSlJGVFdCZHB1R1ZxZ0RnTzI5aHVvOEM3?=
 =?utf-8?B?TjdYMWN3WWdTTkVBK3VzVjlDaVhZVTNteWFTUFVOMGI5S0d5V0Y3ZzFLQ2dS?=
 =?utf-8?B?Zkd2bUZLNmlOVTlDVnpERVo2VGkvQUlCS1JFcFRKWjh4ZHZBN240V1ZxdVFZ?=
 =?utf-8?B?YzdWT1VoQzNrZjJFNys3UGZIWHBIUFJnNjBFQzhGNU5Bb2FoeVFtZnBOc0dM?=
 =?utf-8?B?VjdKeEZDZ2pTckJRRjZsRDNoN1VXb0pDaVVmamhKdUFRZzh6ckVVaEZ6OG5E?=
 =?utf-8?B?b3RZTk1KUFNJMFQwSFFxVTR3RkV5azhtb3NLYXpnalVaZ2x1WHJGWi91Rysw?=
 =?utf-8?B?d0g5OFp0VXgrVlJyUlM1Y0ZXMUttRXFaUXNHZkhhZzlCRTUveEdEOVljMDdu?=
 =?utf-8?B?RFpKQjVSZG9nZ3daTHZ0ZEpoWFNyaXlocUtNdlQ0Qmxab2tTc1liOTNQZGY5?=
 =?utf-8?B?R04vOHFka2EzdWRSODNUYnJHbTNNeWZIK3NHNC9UT1BhcDd3cjZnalJDRTlK?=
 =?utf-8?B?VTBHMmJZODRxOXorMC9uRkFFQVJ3ejhQbGJlVHdPNFppM1lTTUt2S1lkMVNz?=
 =?utf-8?B?VFBsTWlRK3MxWWNHcEYwd281U3dlNTU2WlJuVGhSd05FVkl6TEZDRXpPK2Jl?=
 =?utf-8?B?ZVhlSjc1MjZ5U1FpKzBZUjJCeUNiOG9HeTVXTGhpN3MxWlRFdS9DNk5wRERu?=
 =?utf-8?B?VGtCWFJkMHRGTHZGL25xTWl5T2N0UXZsUVhCZEU3czI0RlhxQWw2YnBiY2NY?=
 =?utf-8?B?NkRYK2dtVklPcHJJMXdhbVhzTVVEMVhqN0xrNjlrdWRvQ1NyRGFGM1RLWDdB?=
 =?utf-8?B?R0pwL3BnVC80Nll4b1laZStwWk9ZbW9xa05lVmw2QkVxUjNGQmN1ck5WUHNU?=
 =?utf-8?B?THhZQW03cXZ3YUFLUjROYzNFYmFlU1IwS1FzRWt2ZjhPR21mWTJ5T1Fzdkk2?=
 =?utf-8?B?U1FCTTVLRTZNWkV2UzN6aEZsS2JjdUNENXJVRkQ2cStRY2xxRjAxRkZNRHht?=
 =?utf-8?B?YXhxUjd1bnJ0bW1JNko3dktwcUoveWI0Tll4Qk9nTTlNWnBpSHFRdVlSbDhJ?=
 =?utf-8?B?TzNDa2hWb1RSNjR3UEJpOFR4a3psSE0xbmZIb2c3K2h0OXlPSUFGdmc5cGMx?=
 =?utf-8?B?ZWdlR0FNZ1ZEQVNneGdkeTRST0tXNVB2d0RvbE04dC9nM2UranIxUFZDSDVj?=
 =?utf-8?B?UVhjMC9zbUVBMTJkRVR0b255bGw1WURGUllWYUN1bmxGMzVXRWxXRFlibkFp?=
 =?utf-8?B?K2ZGRklSSXVQaHBoNzhPUjA4WHd1enJhTzMrTE0rc2dkekdSOGM1ZHhYQjBs?=
 =?utf-8?B?MWlxK2xNVisxWFgxa0hRYnNKS1dsbkxNUzRCMktIRk90ek5QQVY2bk1Wazlq?=
 =?utf-8?B?b0ZEWUZCRTJHWDhoNmlaZ1U3MVQwZk5EeitFMDRwelM2VEVFN3NPOHJLMzJG?=
 =?utf-8?Q?s68By52MKKjFMpFgwdyPxYaTEwlyVhQ7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBvcS9iS05aQ1IwS3NBWWlXZ052NUFmWG9qUzNjZFhHWmE5ZkdUVUFBdVFY?=
 =?utf-8?B?ZjVwYlQ3ZnhYK2VDYU5Cc1BMVEpCN0ljNjhScmVHR1loYTBNeXVLMmg5dk0w?=
 =?utf-8?B?QUw1Tkh0SkdIZ2hLYzZpMGtIVlM1MGxrcTRvaDF1YVNQYUYwRStYaFhCdlk2?=
 =?utf-8?B?TldrekJNSDE1bTl1VG9RckxoRDBJbG9SRUFSY1d2cGJjeVBGRlJHd3JFLzZw?=
 =?utf-8?B?RU54cm5IQUtVbGlrOUNUN2dvcDQ4KzhUUjVsRGlCMmE4c3JNZHNpMnVTa3JX?=
 =?utf-8?B?OU5mdW5hWWVHSVRIVThnenV0RzVVamd1MTNnMjUzTXBlSDZTOXVHRTI3Zm44?=
 =?utf-8?B?SkwydGd6VUJ5NHcwc3E1Qm1vSzVRSjdlUDBxK1ZOV1lLeVJCaDV4WlBXT1V3?=
 =?utf-8?B?M3BHb0ZKWDkzemF5NWJyNXNqa2NSdmV4cVhiVGFDUXVCUXp4bFZSNDRyaldP?=
 =?utf-8?B?cFN4YnREamI0WFQ0RjZnUnErWURNYmF3OGhDdFNTVXptUVIrcGFZOVkralVJ?=
 =?utf-8?B?SVBmN0FKNG5UWnZ4Tk1SNGRNb3VoeDhVS2Y0OTlxc3FQdkVZb2dNNUUvaVM0?=
 =?utf-8?B?Wng0enZyb3NpUUlSV05aZ2lqdFgxWm93RHpMa1VBM01aNHd3ekJVMXBacU5I?=
 =?utf-8?B?cFdwU3RseFJta29TbFNKaXdRc25JcjJaalZTSkNWeHd0UUNXdXZXSXU0SmRw?=
 =?utf-8?B?SFF0WGlMUjIzaHN1c0g5SDVkNjhkRm5RUWtLRktCWk1JVG05b215MWEwTXVu?=
 =?utf-8?B?dVRNL1o1RzdKRmlPUVJwTC9YSnhSZ0ZvN0VrL1ZPc3lBbVdQTEU1QkhueXZK?=
 =?utf-8?B?RHJsblV5bVhmU2htMHBPWERwVDVvWm94SURHUFVYTFQ3VURYRDFPallwRXRX?=
 =?utf-8?B?ayt2cUp6NXhkOVVVVTliZnNvNE1GMlpSU2xmQVVFYmFhZkd2NGF1YmcwVEoz?=
 =?utf-8?B?TzJFTXZaK2I2cDV4ZG9nbGVjTDN0d0F3UFdZRWZ1NW1nYmN2RjlRcGVLOHh1?=
 =?utf-8?B?ZURCajNJaHVIOUlKNEU5alRzZFNWbVpRWHBSa3BSZVdQZ1V5WjNIUmpFa09U?=
 =?utf-8?B?UHUvM2lod29jcThLL082ZGVIakV2YlVLTGtZMnRET2lveGltYmVlblBSQlN3?=
 =?utf-8?B?bG8vY0ZncFNFcUF5ZjYwUXJ2ZW13NHhNaW1ERkNucUh6K1IwQzUwdVZwdlpP?=
 =?utf-8?B?d3VCVUVMTjQvR09GOUtZa2RWWWUrUlZHTER0UG1LUkRmVFFrdDg3WEdTYmZz?=
 =?utf-8?B?dm01RGp4N0lST0d2VDJycnVkRTdsb2FHNk9WeGJyanA2K3BrTGRjR1JMUFk2?=
 =?utf-8?B?bGxiQ2pMN3I3ZTdJQ1dleTJNTVduYnVqSEpMZFU4UW9Rek12OHYwQ2lrMVBC?=
 =?utf-8?B?d3E1L01QUHlSTkRyVFQ2eEgwMWJOeU5jeURQeE11cEdrZzVuWlVkQnV6QmY1?=
 =?utf-8?B?L2RoSVZ5RUJTb1R2cWxGdENkR0RUM0ZmU0xuUFJQa3k2NURPQ1UvMnBmNkc5?=
 =?utf-8?B?eU50TTJuV3pDZDhicVVrSStDNFZ1aG1lK0xUb3lWNkRiR1BVK1J0Q2VRMEFj?=
 =?utf-8?B?eCs2ZFZSdEdoNDZzWEx6RHRTRGJpbUZoQUdaaCs5SitUUVp3eHpzQVR1SWZy?=
 =?utf-8?B?WXZRcGFERmh6L3BhZnFNdU1scUNGYjFzRXd1dHRMN25lVUFpNWdJcVZjTzVG?=
 =?utf-8?B?S3A1YlNBR2pScDY0U2FlQS9zaEZNTnBNaEU4bDAxUitZekpXNVUyTDJqbHY3?=
 =?utf-8?B?TVFJODF4K21VQkU3YjJESGJlcGZNUytJcWhMdkJJeWNLV2h4WmNHQjJDempU?=
 =?utf-8?B?L3lyTmV2ME5qWGM2UkpRdS9BaGo3TmZGcTZ6MldUSm9uSVVHaG1USmI0RFE2?=
 =?utf-8?B?T2hYeEp1UlNwWS9sNmlZK1h6YUZwSFpYK0NhVm4yT3FjTUJCd25zVHpDNnA0?=
 =?utf-8?B?UXRheWkrZno0L01yMGFKZTRCaDR1K0x2K3NxZDRod0k2Z2RZdW9NeStrdCs5?=
 =?utf-8?B?SFNObDB2RS8rNHJMTklhaGNvTmZXd25JdllVS2V5NjF4QTZ6QnVCRWtncUhI?=
 =?utf-8?B?U3lSdThmd1V5czBpTlFnVUpIMHpycnc4aTd2azJ6ZkZJVFEyUzVuNm5IS3k5?=
 =?utf-8?Q?hU9o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa61bcf2-2ae5-4101-b298-08de1b21057a
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:36:17.4961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze/gUfWTUc5d8QN/nqKCSEmRBudL3HfB4Y+ZN96QjHUhqpYHwFkcTmfSmOKeC39k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924

Hi Reinette,

On 11/3/25 13:05, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/30/25 10:15 AM, Babu Moger wrote:
>
> ...
>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 108995640ca5..89e856e6892c 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -152,6 +152,29 @@ related to allocation:
>>   			"not supported":
>>   			      Support not available for this resource.
>>   
>> +		The feature can be modified by writing to the interface, for example:
>> +
>> +		To enable:
>> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
>> +
>> +		To disable:
>> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
>> +
> Above examples are missing the '::' that will format them as fixed width text blocks
> used for these shell examples.

Sure. Will update:

diff --git a/Documentation/filesystems/resctrl.rst 
b/Documentation/filesystems/resctrl.rst
index ccc425b65b27..cd2214d8026e 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -161,10 +161,12 @@ related to allocation:

                 The feature can be modified by writing to the 
interface, for example:

-               To enable:
+               To enable::
+
                         # echo 1 > /sys/fs/resctrl/info/L3/io_alloc

-               To disable:
+               To disable::
+
                         # echo 0 > /sys/fs/resctrl/info/L3/io_alloc

                 The underlying implementation may reduce resources 
available to

>
>> +		The underlying implementation may reduce resources available to
>> +		general (CPU) cache allocation. See architecture specific notes
>> +		below. Depending on usage requirements the feature can be enabled
>> +		or disabled.
>> +
>> +		On AMD systems, io_alloc feature is supported by the L3 Smart
>> +		Data Cache Injection Allocation Enforcement (SDCIAE). The CLOSID for
>> +		io_alloc is the highest CLOSID supported by the resource. When
>> +		io_alloc is enabled, the highest CLOSID is dedicated to io_alloc and
>> +		no longer available for general (CPU) cache allocation. When CDP is
>> +		enabled, io_alloc routes I/O traffic using the highest CLOSID allocated
>> +		for the instruction cache (CDP_CODE), making this CLOSID no longer
>> +		available for general (CPU) cache allocation for both the CDP_CODE
>> +		and CDP_DATA resources.
>> +
>>   Memory bandwidth(MB) subdirectory contains the following files
>>   with respect to allocation:
>>   
> With the doc formatting fixed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>

Thank you.

Babu


