Return-Path: <linux-kernel+bounces-732033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83783B06151
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CDF586479
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B22472B4;
	Tue, 15 Jul 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1XBjZR6c"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909C23ABA8;
	Tue, 15 Jul 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589146; cv=fail; b=PCvE1RJ64pyNzgZEonqXEpnUSk/UVZbdk7ert/oiruhhq3XnIdHnvbfMR8RznbgzV8g5x96Ym5DO7JofUWC5aGDDGZZ3MGXFmvHebTPFNbwLBi8I2GP5kOHFiGhA3eUNrVMh3poOXYRELFpgProCAqzrqRKRhPYwsJ5Sgem/tCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589146; c=relaxed/simple;
	bh=AZRfMkBP2TJ1t6VleDbtc4VTesB88SYPRSr6xsFl/4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YxKuuYJdw015kEZF5m1yRRmYeCOuyTH5cPRTbaznP+3VOxsmH4VX5WvtPngJS7dZEg4Cmb/MDb8S+5pZzTXmBuPbGO1cdI+8tPURSebTJ7UjLmSijghJSYDMo3IFtBMkwH8hK4MRXLxw8bkJ1fwGT67nLlu6dptpC1AxblVLvT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1XBjZR6c; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgKduUT65Ow9GnHX0Jzg+bIu24QRJQWS1A78YnCe1OrR24I9oy4GB5ZWmEfNliNB5jRnB5zOfvl8BywVm3ROqMK0gjeXbSK7eR3Mzwl7E7c3/KiEt2xvmANwdlGOwmaI2Rl4NCYetF5f1Ne/AgrhLL0jGSbZmb3FK7lCv3xENMNklMoaXi9Pp+xqYqAihc9gFJrhZ23P1BZLemOxQiZgEY/PKMWwfcbhx1wwo2WtphMaBRUdMbXHnRq5posM8IKZszD5ATCoTKqAkIBvFfXjlXA/xKUc1Mx9+FKsviGmQiMmluEAJ8SpIlzk3ygHdz0cOEcYKi0x6LIVmXOpPjch5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV73PsnMN0wTxsbh2F7CUwP3+WWQXHR3ncVguhtiu1s=;
 b=TZsIAUW2/Y3fiuC333vsLFlO22sBqlq1bsMuJAIMZ16AaKVB8c00ItlC2xUvyVr70SRRl6RHDnx5E26ukrIHg+m+wGnTjuzb5LjReQhgYNh4thbBhvoL3cqv3SV8Aktss/rJbtLDXTkJHZ4FS9zblmSsIHSWvcnDvGj5B4I6n0QOdQojDUQYqLxl4RieuVOE8cFVEFMdKwHAjFqRpwePXagMoQ20/q7I4CBCPAS979mln6jg5gcEt+lCWXhXBUjFslkCfrHTj33/DkDMKXRZbzs5i8zvsVu0DehA0q+wECKtJ3ibf3Zl2GflOhgWq564dMKsJklph9q4TJbG4rfDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV73PsnMN0wTxsbh2F7CUwP3+WWQXHR3ncVguhtiu1s=;
 b=1XBjZR6c8E93qFmslZawS9CRxDj9MfmVIbf9v7jZY6lDvoJJ3D3cr0IfQd61GAFRybSzd80axVs0YC64nz05d3lXVqkTwX42m4BAjmB56V0BH9epdDNva1RGexe7WzL3DHXc8Bf7R3i7jcEc9wIVTbCXob9fkyiras84GGe3fz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 14:18:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:18:58 +0000
Message-ID: <bdda1774-e03b-44eb-905d-1ca2e30ab61d@amd.com>
Date: Tue, 15 Jul 2025 09:18:53 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 28/34] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCjN7-1fBF+6x1X4SfhRyx6L8aWaOfqOLQzKMRp=zHiyFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:806:127::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 632cee2e-619b-4e73-cde8-08ddc3aa89cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXh2N0I5YmJHVm9WQlhMOFRqQzUzQXZMcW5SQjNxUmovNjdDT1RHNk1DU0xB?=
 =?utf-8?B?Z3RidU1uL3NIZ1ZZNml3U2xha1ZUeG1jYlBDVmZvV1RuYUh4WXNnaEkrZ3dv?=
 =?utf-8?B?cFZva3FpVUN5cHAzRjhza0RTZmM0REVRd3RHMGNBTURNM0txQkhIeDUzOS9L?=
 =?utf-8?B?ZXVvYlNBMUg5d2pVNklsU3ZMUVB2WVlUNmJHdHNseXVCWDJyekpmVlFrRVZT?=
 =?utf-8?B?SW0xcmJwVGJQVFNaUndyZkNNZ28rN0J3aFpQT2lSQUduRnJpakZraU9kZHND?=
 =?utf-8?B?bnlSNnBLd0hFQ2p1Y2tPcXg2d2JubkJXL2hPODA0RWo5WVJ6YWh0MktJV3JB?=
 =?utf-8?B?QXRObmc2Vy9xU3F3TGJUQmZ0b2xxaEM4SFRXbTFnT21PT1FWYkZ4MForTCtz?=
 =?utf-8?B?N1EyNEZhcHdNbXAwUFdtbmdOaFEyaUxYU2VFMlpCMXBJemtrbm81cFZaM1F5?=
 =?utf-8?B?NE02dWIrby96eWdjMzRSNjJpNzkyTVBreWFwbW9JNnlVR0J3YWcvTmVueUFo?=
 =?utf-8?B?MGlvL3RQVEY3cCtHSlZsdFVpSUlycjc1QWRZb3RUaFJUaGEvSUgvNGtqbFhm?=
 =?utf-8?B?aGdGRHFPcDRtTEFMenRHdW5aUjE4L3A2bmlYUmMxMWFReWtWemtRMDVZYmFY?=
 =?utf-8?B?QlJuQVZxcWJyV2t3WXJIcktPVkd6VjJKYnpvL25nTVBjc3JwZmNWZm1QVjZO?=
 =?utf-8?B?S081SDFONExOdkpFTUJSSjBGdzIwcVh4cmEwVUtBQmZNUDV6R1FpYkxkcmw1?=
 =?utf-8?B?ZzFMTHFIYnVJYVZtRVJtS2hmZUpBRUg3MFMzYVNKMUUvL0hZUG5uQ0Z4dVdI?=
 =?utf-8?B?bU14SXpmZk9scWNBaENnbldMVksrbUlSSEN1cDI0M2RkdXRpUDJIbytkakhi?=
 =?utf-8?B?b2NUL0tiR2UwNytUYWZpM0wxUzV5aDZsZkdUcjFxY1FEVGxBNnUreTdjSHhW?=
 =?utf-8?B?UWMxV0E4UjI2a2tYbUNJV0V2Sm1JVkxQUE1hcGZ5MkMyU0JLbmEzaGhyUjBD?=
 =?utf-8?B?TEJGRHpOUWh1VEg1bVAxY2RmaVBsTmFrZHFxd3ZFY3g0dTJNQVZoM3k1d3BH?=
 =?utf-8?B?SC9ibThSdHFHWEZtQnpQRkFMNmNjbzhzdDVhSG5zQk0yYlY1UlJ6TitDNkVQ?=
 =?utf-8?B?QXBWN3dqVXVnVVdhYXhOLysxbTNmK2JOSGN3cjdhSEJpcDU5OHpVTzdzeExn?=
 =?utf-8?B?T3J4Q3I5UUYvS2Zzb3hMTnpEUTZTdVBhR0FIMUdUWUczWmUxRnFyZ0tvby95?=
 =?utf-8?B?S1pFWEFFSHB5NndiWTBJdGxEV3pLTXFRYkxxOTNzM0R5NkpwOXZRVEc2RWgx?=
 =?utf-8?B?cFhSd1QvNXpiZ0pTcHl6YUd2RnEwWk5OM2hDZVNiK296Rmk2b3Q2Sm8rUndU?=
 =?utf-8?B?c3lKNmswbFcvUTdnbFpEc0o2L2xqako5dnlkR1IzZmlDQnhJZkVPQTdoSTk0?=
 =?utf-8?B?czRvMzU3RmRibnNBOFJOUkY1Q1BZMm1VTkxEMlJtYzhyand3dG5HRnJ4Z2Vh?=
 =?utf-8?B?S2tNYXVPQTdieStyMVJRTGxFTDdUMUxQWWN1VFJndmF3ZzNuaTV5UzVpNUp5?=
 =?utf-8?B?NDZUVU03SU5PTityVUkwQ3dNd2ZqYWNoWHNVQmFZOVpnc2d3SVhmOUliSXJX?=
 =?utf-8?B?am16T0NOUkxJTitJOW1KTU1EYlNMdVhTUmhuajNrYWVpbHRRMlRpeWEyaWx4?=
 =?utf-8?B?bm85K1hMM253c1ZiN3owMnRPUzVqdGYwazk0YklyYmZGUDFLcVZMUzFzZGdk?=
 =?utf-8?B?alhXbDNTNlRvUW5nZ2hvOHloQ3hsM0xpejJIT2M5c1hQZGwzVzFNMUhnWDQ4?=
 =?utf-8?B?MzRYNU5xOCtTUEY1VHdud3dNSXI3ZjVSRkJXbnlQdVdLTEp1UXVvc1JpRGVz?=
 =?utf-8?B?dExjSk04clNncUExL0JTUzFIMVVnaDRieWJwRVVCVTVSQ3hibm1ESTErT3Rx?=
 =?utf-8?Q?xDQ3JRCL4Bw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmF2d2RGU2tsUW5UVHhlaDVhZzR4RnlhR1pCM0FkSFpCY3RVcURHR29YYXl1?=
 =?utf-8?B?WEVWdnFDWEloRjNXS2Jqa0NGaFpkSjVyQnI3bGtkbEs1djZ5bEpscXpRMTFl?=
 =?utf-8?B?WVk4TVFzT2FWblcvUUI2RzVyUDBWdXN6SnpGRlkwWVcrSm00MkJoVzBpYVk4?=
 =?utf-8?B?RlZ6Qmh3Y0J1QUhOdVVXL1ZPMVZPdFJ6QXVzUGxNbS80WjRVYTIxOXhPejF5?=
 =?utf-8?B?OVQ2djA3c2lNWUxQSUw5ZlZLYmM3MW5BanJ2TGdtYjhEdHJQeTJEYm13L2h0?=
 =?utf-8?B?bXUxU2djcTZ3ejJpcnp0KzdPK1BzM1lLbHVXMWhGWHl2dk5rTFBoZHFzMHEr?=
 =?utf-8?B?SEZ1U2NDSHlnYSt0TWE2czA2SDQwd25ObERwdGwxWGozUkZBWFh1WjZZTklJ?=
 =?utf-8?B?cUo1YjJLNEg4UUVIYi9USWk1NzlaYUxCRXVvQ1hzaElQMm5XZ25YSjhYVm1h?=
 =?utf-8?B?RXBDNTVkRVpEcGxYWDQxL3VTM0gvVGd5WitHS1Z3ZkdLWXMrMU9UclZPUHo3?=
 =?utf-8?B?cHc1N2VPYmhRQzRZQ0o2bkJtbDdPak44a3BHVkU1L2lsVFNSZ3Z6Z0d4Sk8y?=
 =?utf-8?B?L2pmOHNSd0tvbE96NkdFTzBtdmVLbGM1SXgvei9DbzhmRVk3dTR6MndFdnFP?=
 =?utf-8?B?eXNQMWdDY3ZnNjR2N21NcUQ1b0FHd2I2OUNsdmM2dGxKcmxKOWYyVnVJZUtG?=
 =?utf-8?B?aVlLRTNtbFQxeGhXRE9yRkdzWEt1cy9lMEJEQTBvYWZiQlFaNkN2UksxSDdN?=
 =?utf-8?B?cVh3eXBEemxvYy9ZYk5rM3JIdWl4MnRHeFNON215OHZ0T0c2YS9zd3cxTFZJ?=
 =?utf-8?B?UEphbjNMMkFpSGJxMDBxOGN4eG55bVJaQmY2cVhycGhra3gva0Q3Y3pqZE9y?=
 =?utf-8?B?VTJydWNqUW9XYStYSlBqU21YMVdPU0hFa1QyL1l5RzNFdGVnQ1Q3ZEkwQThq?=
 =?utf-8?B?eG9xUXFwRTUyRjJtbU5yUFZEU3BaempLS05EeWoyMTRRSEd2R0p4d1NMVkI4?=
 =?utf-8?B?WWlpN0lFSytnUlhmb0xQeFVNNjJTZWVtbjNBNDhQc1l6M3UzbXg3K21qOThB?=
 =?utf-8?B?ckxWSkhXNGs3aGdKVE5IOWY2cUM1SDhkd1FWNFM2bmkzMW9OdTMzV0NvcHRk?=
 =?utf-8?B?M0t6ckJhV3R2dWhRZ3A3OGxWZ0dCeWlLOURVNXV6dTEybDM1Q1JCMUZUWS9q?=
 =?utf-8?B?R29jRHlpSzIwa2lHVnBYSVdrYnFweElSRHcvSTBCRTFXeUY5bklUMDlwYjJQ?=
 =?utf-8?B?YkprR29JTTlqSnM3TDBQcEZObnN1cmdmeXRXZ1NRa1BGM0NkLytxZDlaRk1v?=
 =?utf-8?B?WHNTdVBHazMvRGJyTEFUbWpURk9xdGhmbllTSmVUL1BSWUdtbXpmRlJBa2Ey?=
 =?utf-8?B?SUlQOFlpejdRSzJoUUpSNUJJeHNUMjZHYlBlakhpRlUzSU1NSDFoUC81ZDBS?=
 =?utf-8?B?aE1DMWFqVFIxQk02a3hsZjVvRWtBODdWbkw2QmdzVjlsQzJLTkwxcTg5WllP?=
 =?utf-8?B?aVdmcklTQzl6TElqZHlTWkkwVkc2blNOcFFnRE9rQTkrdWVJM1BONXFHSzVp?=
 =?utf-8?B?TVRwWlBTVXkxV3laNElndnN5bnJXdnN6UG1ORld2ajk4T2FueGgyanZLMU9m?=
 =?utf-8?B?dGN1VWIzQTRTVEkxbWppcnVhNVRva0dxQzFCNDVPeGtSZEVleFhzaldiZGpm?=
 =?utf-8?B?TlpDdlVHVW5YUjNlSWRmdzJVRFVMRUp5WEhnTUxOV1lPeUdNM2JDY3lkYm9j?=
 =?utf-8?B?RUp1Vnd3WjFSWVVaMFdQYk9UOWYzZGRsQkEyajBoMFpleHExUThqV2FBQSs4?=
 =?utf-8?B?TGJQd29WdFJyZXFScjl4OUdueG9nTXJHejk0czJMT2d3VkphdXoxci9hTm8r?=
 =?utf-8?B?Y09BMXFaSlB1UHJ4ZjZWRE5tVXRjQlB6NEZDNUsrSTQ3QUZValBkanBtK2h5?=
 =?utf-8?B?RGRqMG5aWXNOSmEwd3Z3NVJXSnpxQzhxSE5TMXlJbDVWNDhUTXVBbmJ3dkZn?=
 =?utf-8?B?VmhWU3k5Zk1NejRTRlI3WkVqZWhnc2xxQ0FMU0lzZVBxNTRxNTN4aW9zWGJ5?=
 =?utf-8?B?M3FTckVHeXdxU1NDMmNpZnA4OWpDMkFiQXFsbW1naUdKWTlKZGtnQXBQbzgr?=
 =?utf-8?Q?cy/E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632cee2e-619b-4e73-cde8-08ddc3aa89cc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:18:58.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCWxXoVG64gbzaeLVO/N81m+OUOow9wPQ+TEoIW1mEYrV61mgRiSIHygLl04BreN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

Hi Peter,

On 7/15/25 08:53, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 9, 2025 at 12:22 AM Babu Moger <babu.moger@amd.com> wrote:
>>
>> The "mbm_event" counter assignment mode allows users to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned.
>>
>> Introduce a user-configurable option that determines if a counter will
>> automatically be assigned to an RMID, event pair when its associated
>> monitor group is created via mkdir.
>>
>> Suggested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v15: Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
>>      https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/
>>
>> v14: Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().
>>      Updated resctrl.rst for clarity.
>>      Fixed squashing of few previous changes.
>>      Added more code documentation.
>>
>> v13: Added Suggested-by tag.
>>      Resolved conflicts caused by the recent FS/ARCH code restructure.
>>      The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.
>>
>> v12: New patch. Added after the discussion on the list.
>>      https://lore.kernel.org/lkml/CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com/
>> ---
>>  Documentation/filesystems/resctrl.rst | 16 ++++++++++
>>  fs/resctrl/monitor.c                  |  2 ++
>>  fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
>>  include/linux/resctrl.h               |  3 ++
>>  4 files changed, 64 insertions(+)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 06c8c08d0341..f9e9a8a66cae 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -354,6 +354,22 @@ with the following files:
>>           # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>            local_reads,local_non_temporal_writes
>>
>> +"mbm_assign_on_mkdir":
>> +       Determines if a counter will automatically be assigned to an RMID, event pair
>> +       when its associated monitor group is created via mkdir. It is enabled by default
>> +       on boot and users can disable by writing to the interface.
>> +
>> +       "0":
>> +               Auto assignment is disabled.
>> +       "1":
>> +               Auto assignment is enabled.
>> +
>> +       Example::
>> +
>> +         # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>> +         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
>> +         0
>> +
>>  "max_threshold_occupancy":
>>                 Read/write file provides the largest value (in
>>                 bytes) at which a previously used LLC_occupancy
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 0722e72f6cb1..ccca2330eebd 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -984,6 +984,8 @@ int resctrl_mon_resource_init(void)
>>                 resctrl_file_fflags_init("available_mbm_cntrs",
>>                                          RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>                 resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
>> +               resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
>> +                                        RFTYPE_RES_CACHE);
>>         }
>>
>>         return 0;
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 4889e7556cc7..b7289ce2b3a6 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1987,6 +1987,42 @@ static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
>>         return ret ?: nbytes;
>>  }
>>
>> +static int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
>> +                                           struct seq_file *s, void *v)
>> +{
>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +
>> +       mutex_lock(&rdtgroup_mutex);
>> +       rdt_last_cmd_clear();
>> +
>> +       seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
>> +
>> +       mutex_unlock(&rdtgroup_mutex);
>> +
>> +       return 0;
>> +}
>> +
>> +static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
>> +                                                char *buf, size_t nbytes, loff_t off)
>> +{
>> +       struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +       bool value;
>> +       int ret;
>> +
>> +       ret = kstrtobool(buf, &value);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mutex_lock(&rdtgroup_mutex);
>> +       rdt_last_cmd_clear();
>> +
>> +       r->mon.mbm_assign_on_mkdir = value;
>> +
>> +       mutex_unlock(&rdtgroup_mutex);
>> +
>> +       return 0;
> 
> I noticed that "echo 0 > mbm_assign_on_mkdir" never completes. This
> should return nbytes.
> 

Agree. Thanks for pointing it out.
-- 
Thanks
Babu Moger

