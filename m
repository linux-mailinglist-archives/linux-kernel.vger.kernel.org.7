Return-Path: <linux-kernel+bounces-896171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B8C4FC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE09B34DB42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697A35CBC0;
	Tue, 11 Nov 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D6xnVSsF"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC035CBA9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895101; cv=fail; b=VJwZ+YP22qOOzi+BSlTHt657ATcODwfiiNoWMzOOn/qDqXBwYmmoKFtakg/451C3st9MI0zJvjbKgwcJGeFOcz4ANiPuX335nbkpAUX862BAp6YdHXnlLwmDdDt+wPJq+sm+tZplkIAtkSnuXHhXbVnaymfxS93ZLzQYreD+CLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895101; c=relaxed/simple;
	bh=Fa1Nqeygua3M2gKNbpmSrmJXcUVn/YQ/cd1rnFrk0H8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nl5zfFRRCSPkYt7f3KOhtikm/FUHifzFm7WJQFAhZENRwXtvv4gKOvuDSKiQiCB5mh6ZVNbz2dv1zZBTAMfEzsH3MQuaIQZFdjg30KwceTkPui3THOvgORV8jVTO3FBzF+pP8OVhE0VC9tw/xkXuvWJF/NoyGx+yG2iO93X0eSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D6xnVSsF; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjjC62+fBuwvtqdyLOux0Ul8x4bhlljzkj0uaEwYoIuyCqiJrRBkSfZ6vW/3PHJzJKLfC+6FgjxDpDOaLcsFqhBgndPoZFhmKAxykwtXFZpR9JERX9yDgJZ/cZ2AWuQzyv0+MdpolvbHaU6IQY8yY04oGBMokCbt/2vxKL90tGNIfKIfWMh+BIF/WmmKoE8meAyaoxxXMoBc+6qNHlW7Zy6H9wYqYrMqFICwtIx573CFj8V5FxBrp8+TCQvkHa5O9Bezi04sB4ZDtoGQruBbHNYGYIqNIe67X1adNEBjG4k6VDvFXfj7zhPeWPmzawcM5kAYSvqs9B4vgTY407pFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj40SemfzWARWITJqI186cl657sertaJhEIexBSkjKc=;
 b=fDP9T4l2JVdRmoHBA6KjN7M9IMJ6luo131YphkQdy93xaJHgfXw+J2rrTJuaHXv26Z0FBB3H7ObYIWnQmbwsMgH3QFv5s36iivTAIFgev5awHwzt11X2STBX5A674YKK/Bi3yFFLM7neVrXrJNwBih6pzCxobBWhk8F6uYfoolUwyQBGAyDxbBH52OBhyGG3zfQ2bZbFnGB4eE9PR4EwoKVTmE+b7zwjdtWB4SzZlGrncjMRUduvRHUOd8SmTIodUjQupGL1E1NdjJRSAAT0VdUmP9jJsI5I+rzaM2fW4hYntUiUzxus6Yi/QhXbEsaT9STc56OD+/SghrUmHkVdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj40SemfzWARWITJqI186cl657sertaJhEIexBSkjKc=;
 b=D6xnVSsF99C3u/uxJ+cNa2GAaC5wVSRy2cWeCsuIbMr3VbC2FiiWmJ0+AvDCiOTXSiTp5d2citQwehp1dUGyasp5IG038Gkn43xXoaUdwjPB/0PrfniXGwwuIsnAr0KzwS7V2HLedb5yn5ckYj5Rl0n+ZOINPlAw6ZQxleUO8lM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA1PR12MB6703.namprd12.prod.outlook.com
 (2603:10b6:806:253::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:04:57 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 21:04:57 +0000
Message-ID: <589d5db4-68f8-4aee-9d6e-dee5b8754564@amd.com>
Date: Tue, 11 Nov 2025 15:04:55 -0600
User-Agent: Mozilla Thunderbird
From: Babu Moger <bmoger@amd.com>
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "babu.moger@amd.com" <babu.moger@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
 <7e264e18-23f4-4566-86f2-f0600a243227@amd.com>
Content-Language: en-US
In-Reply-To: <7e264e18-23f4-4566-86f2-f0600a243227@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:806:24::15) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e5d034-1995-429a-05c7-08de2165f810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aklldWE2ZTByamduZVM3TmhweVBFeEQ4bUk3ZzVxNkQ1OVFORG9CUjFWVHMw?=
 =?utf-8?B?WmdrY1NOVExQQVhaVEZXWTdsWVd0aS83U3RYbzlrcGkrN0I1OU91Tkc4Yktz?=
 =?utf-8?B?dzR6dC9zcGs3MG90WGFNNXZ4enUva0YwbEJLL0pTclJqdEtOZXZOTS9nUkVu?=
 =?utf-8?B?dG81VTkrbFFqSitsR2NXNGdYMXBsVFc3MjU4eVFhZm1abktuM3NkazU2Y2Vp?=
 =?utf-8?B?dlNidktCeUVabjIxVWU3QmExSFdyTk85Y09jNmlSOWc4aUQzZEo5cWlvT2I5?=
 =?utf-8?B?VE10dllTdU9yS0I3UGJhYVZsdTM3NU5nYkN2dHFKZ2xEVGRKVEl5MnpSc1pZ?=
 =?utf-8?B?K01YajJYY3V3WTJDd3ZrL0lkdlIxYzErZXhoKytjL1k2ZXdaSGl3aVVISitZ?=
 =?utf-8?B?L2JaaHFnUXlRdW9lV2Y4TmFDQkMyVzR3dThaSFQ3L1NUVDhCVENZamo4dU9F?=
 =?utf-8?B?ZHdlKzFHOWw3bitNcE01dEQ3NUY2MEZBR1BxK2RMc21YNy9TRnV5YkUwRW5N?=
 =?utf-8?B?cXJXR0gvK0l2Ni9wbjExbnNUWHFGckI0ME1qWXhlTzdmQkdWblNEQVZaU2RC?=
 =?utf-8?B?ck1RdG9EM1Arb1UyVE9HS1hjR3ZEQTlRQmdDdGR5dGVSQzU5T3p0cmUrTHZj?=
 =?utf-8?B?NG1IL2J0a01hclBsaTREN29PdEMrYU0vZXZTa2U1OE1xb3VSN2RXSzNVeHhT?=
 =?utf-8?B?aWtMbHZ1cWc1Y1orbHpxUGxmZW04SFhLN2lEWHZFbk1WUGRqTnZDbGlueHc5?=
 =?utf-8?B?OHIzQmdpcTBRNXZJMkRIRmFjV2tQb2w1MG9VeU5JL1g4RFkxQmlENmdsTmdW?=
 =?utf-8?B?R2JHdHdjRlRzSTVHeG1lSFJiSXFTM0tjTmFnVjVGdmNXVHdzV3BiSVQrVW1r?=
 =?utf-8?B?UW1oN1NpbythVlcwWWV6RWo2SkEvL00yU29aQStwdDdEUThJV2h2K2N4UTVn?=
 =?utf-8?B?WlM3U0xNb3N5M1VLTHVXTmNGMHh2Yy9NZkZ1S3kyR3EvVkpSc1ZIZ1drdHNE?=
 =?utf-8?B?cEhRcC9GeDNlSXlOeGRMeVZxR2VRNCtPV2wrVElqK1RLTWxLK3F6ZURMK084?=
 =?utf-8?B?NlRNWGZWdnBoSFJHbXVETlREWUpPQlpSbHY1REJEOCtuWnRMc2JpSkRuU1Rr?=
 =?utf-8?B?ZDJqcUxrODJkRHZ5eWJlRmJ4Uk8yck9vRWdGSW0wY1d3bjIzd25BcjBDenpD?=
 =?utf-8?B?MlVuSjR4Y0Jsc3dlOGF5V25YVHFCTXViRUdMbmc0RDZMVU9zYjFTaGNxcGxP?=
 =?utf-8?B?enBDc2Q0NWcxaUVlSXdYbjJKTlA5UlNHSVErZWFHcmthYmI3RWFjc3hCVktI?=
 =?utf-8?B?SHl4ZGtGMEZBemt4dmk2RG13UDdCMVdXK3ZMRjlZZ0luTTdyOGlGNUk2c2xZ?=
 =?utf-8?B?dUlxZGtvUUp0ckhINjhyaHZCU2RyaE5pK1FPN3dkdFBLQXVsNXFJeWFGQUlO?=
 =?utf-8?B?cCthaXZROGlOMDA2VGhSa3greFcyME41cVVHTkc1YmRHTFVQdFoxd3FqRDEw?=
 =?utf-8?B?OExsSlhvbnYvaVB0aXBWNU1EakFZb2QxZmNndk82MXlvRm1kbUkvVlV6T05N?=
 =?utf-8?B?UUhPcWQrSitwUnkrOEZSU05WWGcwWXJyNE1DMXgvaVNtbGVjTkhELzdTdVFm?=
 =?utf-8?B?RlRLdFNsRGc1VVdxbDVJcTZIQnArbWZWa1Z0WDJLM0N3MFR1WHRiOGhIcXlC?=
 =?utf-8?B?SUdUQXZJMXVDZ1lRYTZ6d1hrVTRjNnlpeWtiZUMzc1NSUGp2SDBISHRCV1Jx?=
 =?utf-8?B?Ni9ndk1MOWY2UXArZGM4ajYyTHUwK1BmNHp2QlR4cXRHeWFjUEFxcUFhTGl3?=
 =?utf-8?B?QXJuVzI4OS9ZeFhVNVB3TVZqRW0vVmNnYWROWjM0ZVU0ZDlLQkNKMkJFVlA4?=
 =?utf-8?B?NEZXZ0lDQnBzOFczcTAvdVA1OWFabFhRTWZtQ1JXL216bGJNZitUOWF0bTJh?=
 =?utf-8?B?Zm1ENDNXNHR0ZWxiaGE4RG5sdzVndmZpT3JaOXpxdkxudTVORFhmQjl2OGJl?=
 =?utf-8?B?Mnc4NXFIbUdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3Nva0dwNHJwYnE3eWtpWWdrTEJieHp4WUpRcTVJRzdKeC9MU1BUL0dmZi9x?=
 =?utf-8?B?RUxkUDJZM2QwT0dDWDRBa3QvS2dVK3g5c25pRUNiNHg2RzJPNmNtbTRCSDk0?=
 =?utf-8?B?Ukw0Y240aGJWZDN5N3FaNHNpSTNWTGRQTjBCODgvYnpxSjJlOXZCdHZCRzk2?=
 =?utf-8?B?RGczVkd5YXY1a0xXTzJNV0w1ODgveG9VdlJUTXl2OW80YU5tZ2huQUgySUxn?=
 =?utf-8?B?aDVkNzBVVU5uNzJHaERDZDdJVHVpSE9kMjBxZHUvVWRiMDdBNW5OQnluMUtP?=
 =?utf-8?B?UGU1MFNYV1FNNXpQRC82dGNiWDluSHpPS2RQeVRSSlhZNloxUzQ5aG9zQTVV?=
 =?utf-8?B?dFVFQjBnK1NIK0RlV2RZSEFaL1VQUDlZWE9kRkI3eHlKQnc2MFNPNUo4YzJo?=
 =?utf-8?B?VFlad2l0NmNXYWg0V0lCTSsxYVdmQzA1TFNuQjFiSWJ6MmFBK2pzaVNhVGVI?=
 =?utf-8?B?NGhUcG51aWw3TlJWdjlmY2xySE5tUitWdTNFZXNSLzdZVThDemFsUGFuYURz?=
 =?utf-8?B?UmYxNWRTNHUra1FKeE94eEZWK0tlSDJIeHJVZWdlMGxFTVFOdy85QlRkcW01?=
 =?utf-8?B?SlNsbEpZMEE2eVhZMlQya29nbFl3N2ErZmszbC9jci9OVDJKZHB5UFhvOE0w?=
 =?utf-8?B?b1lBcDMrelB0U1pxeEpIcjlXTXhacjJNNXJDTWJvQ1p4YTFTL2JoRFRGMGFy?=
 =?utf-8?B?UHhMZTNEQ1lvMlZsc3ZQWjRnTHpIenVSY3VzTktMbFp2c1F3a3g4ZDJRdTJl?=
 =?utf-8?B?Zjhwd2UyeFF0SW9oMHFPNFdzTXliMHVKMGF0bldFcTJkdWQrMWZXc3dzVGZP?=
 =?utf-8?B?WG04VmVNSUcrYVo0UGFoamNHdlNVdkU3b25vbzIybXp1alFBdFg1aEFoR0lH?=
 =?utf-8?B?QjdkNUlzeUhWR1F2MjVreXMwZ2dJaGlnOFNHSklFRDJBendWY0s4Y1ZMVG1Z?=
 =?utf-8?B?L2pUcStGNEx6YmF5UjRRNHVrSHk1blp5clBpQjNqa0Y2OCsxUDh0Vm81aTg2?=
 =?utf-8?B?M3RuT3dkRjRCYkNTTG5xaU5yVHZCWlpyYlpqQmhIZ1g4Q0hMV0gzcDBXQmR1?=
 =?utf-8?B?aVZyWVVjcFRTaFJrZTVRdDh6eDNSMS9yRzNYOTF6VDIwMTcxMkRlUEZCV1Y4?=
 =?utf-8?B?L1dTdnVscXcydlN1M0IzT0Z3TCsxTFhRVEVGNWlqclFLdXh5emtzTlNUdVEr?=
 =?utf-8?B?NWpBcWRyMGdNZ0dWOWFNbEt1OXlQMUJNMUdsRVp2TzBERlBaeXVSTGplVmc5?=
 =?utf-8?B?cGUraTVFVDFGMHJ4SVdCQ2VFT3U4ODRLTFMyZHdOVE5WL2ZlSjl3T3M1SVhy?=
 =?utf-8?B?UXZ6TjQyUnJoVzJRd1VBY2EvK3JYTDdyUVF1MnpibXMyck1WY1dJR0lvS3Uy?=
 =?utf-8?B?cTdIakp1NmppM1BYNEgxNmpiYlovWDlJbXducUFFMGM3MnVkS1hrYmg4WVlY?=
 =?utf-8?B?VnBOdnQrTlREN0RVQ2k4ZUtaajdCK2Y4QTBKS0o1Y0NZejFScHJ4M1pPaktL?=
 =?utf-8?B?QWFPelpKcnlLeXJjamo1Mk1PdndCa0tmY1NtcisyNmMvSUI5d1FPRHZnTkpG?=
 =?utf-8?B?eCtoOG9qaWxmU1FyL2lqeUYyUi9SSVlVY1hTcVpOUkh3REJYUS9ub3JpVUR2?=
 =?utf-8?B?WTRYSzQ2dmQzSUEwQlR5c1QrSWROWjVUMzkxWkRuOEE4WUNTVG54TDNkVEdE?=
 =?utf-8?B?SHBFUXBNdXc2MWR5UWdpdllleUJZZ3JIVjNReFNVMUx1UkkzcDBGRnpSZXMy?=
 =?utf-8?B?MlEwR3pPUnFrVnpDeU9YclA1bEVsbXFOM1NIUmtsYllYeEQyL2J5ZnN6RFl3?=
 =?utf-8?B?NEpsOHNmem1NYWxrc0o3T2FzVC9MaW1ReTBTWmJ2ckhDeFJSSS9KL3ZvYUM2?=
 =?utf-8?B?VUs5cktaYmFlVWRFZEhpRjJIQktyNGZFN2djMmFoVW1MVkJxNXZFWStpbm1P?=
 =?utf-8?B?U3RDQTkyczBaSVd3V216MWMwdGYyVGorUTBIZXJDcHVqUHNSN2lNbkZoT0x5?=
 =?utf-8?B?eWVkT2FKL2lIVU05UUtFenJTR0p4b3hQa1BhYk50RDM0NUZNTFFjMDBBWDd0?=
 =?utf-8?B?TlNOQVNaM2F5STZ2SzhTbDEzNUpmV1VwU0pmVWl1NWhvM2h0SmkvakhyM2hh?=
 =?utf-8?Q?qF88=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e5d034-1995-429a-05c7-08de2165f810
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:04:57.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y5dVd2Ta79ZG2gy2AYC40QGseMnJQkXIUEVJbZDxWx8KrvbsWIiU6fBlV6Uvonn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

Hi Reinette,

On 11/11/25 09:29, Babu Moger wrote:
> Hi Everyone,
>
> On 11/10/25 20:44, Aaron Tomlin wrote:
>> On Tue, Nov 11, 2025 at 01:40:45AM +0000, Luck, Tony wrote:
>>>> Seems like user space has needed information to perform a sane reset?
>>> Like this:
>>>
>>> 1)     Read info files to figure out what minimum mask is needed for 
>>> this system
>>> 2)    Use Babu's suggested syntax of
>>>         # echo "L3:*={min_mask_from_step_1}" > schemata
>>>
>>> Rather than Aaron's
>>>
>>>     # echo "L3:*=0" > schemata
>> Hi Tony,
>>
>> I am satisfied with either approach.
>>
>> However, to clarify, the primary function of the "io_alloc_min_cbm_all"
>> interface is to efficiently set the lowest architecturally valid CBM 
>> across
>> all shared L3 domains. This operation relies entirely on
>> r->cache.min_cbm_bits. Since this value is guaranteed by the hardware 
>> to be
>> valid, this approach is robust and will not return an error (e.g., 
>> -EINVAL)
>> to userspace.
>>
>>
>
> Here’s my understanding of the discussion from this thread:
>
>
> We plan to support the following operation:
>
>    #echo "*=value" > /sys/fs/resctrl/info/L3/io_alloc_cbm
>
Looks like we are going with the above approach where "*" represents all 
the domain.

Couple of things to consider.

a. Send a separate patch to add this feature after [1] is merged.

b. Add this change as part of [1] series in patch 9. The series is 
mostly ready for merge. I can add the changes. Only concern is, it will 
might delay the series merge little bit.  My expectation is to have this 
series ready for next merge window.

[1] https://lore.kernel.org/lkml/cover.1761844489.git.babu.moger@amd.com/

Any thoughts?

Thanks

Babu


