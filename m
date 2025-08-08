Return-Path: <linux-kernel+bounces-759636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C9B1E06B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5DA7A6267
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F12EAE5;
	Fri,  8 Aug 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ILNFcJSI"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C647FD;
	Fri,  8 Aug 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618717; cv=fail; b=HRyy2lb0A494ws6U7vsrByuuPrIoGrTEYOwq92plw0i5FJQrqHri13gDfHAFoyrudUIHTnujFswccLXMjvz42oyxg+yyDmUw+g0uHmPpvMRVrnHkc/hu5URQb5inmtrn1J/2fBMSK+VvdcSfADZhWtfmanMwX1Sr6FvLvJhro3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618717; c=relaxed/simple;
	bh=jfuFy232qo/gMi1AGwM+HpDZurxfmiOZXULN6z3aapk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p+TY9qwJvzFBQwfZEwklcC5NaOKcFszIO1fYZm0G3V9GcmMywBC/Y/WdMN3uzCMr6Zc4ZK8VyucRJy12JBfJEuQ8UgZemDkMs7LrPy2lBVrjFL5ewV4D7OVeSk9SIeoj5y9loMYsEagkjRlHJaRPMmCxNiprKJOlUZNXf/8oV/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ILNFcJSI; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7cVjoyGQGP9TwwzIlxcv6t/xFCBZV98lYQqAdBAsd7y5VIBxLfsej0bSFz6ljNBiew3frrX1DAkyCVQASMhfqFhiRv3gToaYlwDcGnYbGllpmDu3kNX5G++KZo5v9HURKks3ueYFQwDdTSpxXvfp6pJy9GTL03kU3IShH3D4tVgrvfkV1HdQuXbkbq7LMOAN+FEq2JQjqoxIW3b2kvR3KeaKxpcJNdC/GFeEyjJqFICyMmX9mvv5SiIcJjrqISC+MfoIRlah7a09b5xCKNaLIwg3RPHVWeeofn/ODMJIlpvOCsKWmelvYADjmzyRTPKNEE8D3z03y/7IoTz4TmEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1PE7laCWJhqc4W6r9gwdz37vlEsHQ9gTJTKEPwU/c8=;
 b=WIHogX8lPWmQcCZCOfu/tRH1IXirFt+IIp+iahdXJwUTRRtNPP+bYg+/AVkm6EHgD4wcZJ9tIUjPTNLyZEO66e8UC+2hPHvqmNmhyWcPoEk5w8gpmBQ432+hrZWOhS1rzhlptXv8PKQvDU3IijL8b7AoVY9gnobV1X+5WRu3nSd7Krd0L+z5ZKdfoWg983PrcpFxWJPIlFM666U0y4J17B9XLaWEWXNpA5HzbZQqVpe1pSTK+WksL787sK3fg7uzOMvmUqJArFpRZMh843wCB3JKA3FAtGpzLg9G7OxC9xoT9Y0VD2w+pEQKjF8WNT8mT+XPQXNrh6WZ0KiVe9URNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1PE7laCWJhqc4W6r9gwdz37vlEsHQ9gTJTKEPwU/c8=;
 b=ILNFcJSIGLYs+wMI8Mj8yIwvNj2MWprKh1bERTViOPNAUJwENi/n3iuzHkBatd/YbPMDqAj1KBKOJEQIR/0UgArridAJ0aujDs90IVySpH5TGgj8ebXlJpNiJtIMClhVIW2EBBEt/ZPL2VTvqVP8O+zu4/jK1LkuK3Ddz/XFYrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by DM4PR12MB8521.namprd12.prod.outlook.com
 (2603:10b6:8:17e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 02:05:12 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 02:05:12 +0000
Message-ID: <e102e3d6-22f3-49a0-9535-f83bb0040332@amd.com>
Date: Thu, 7 Aug 2025 21:05:08 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
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
 <c11095389417ce2dec319f20619b3b13bddd5973.1753467772.git.babu.moger@amd.com>
 <8ed4970e-de37-419a-978f-8eb13c260e90@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8ed4970e-de37-419a-978f-8eb13c260e90@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:5:100::45) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: a3448d02-fad5-43f1-cf7f-08ddd6200258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXRmZi9LQzBudnJGR1FVVkdsbXhuVnI1REIxbDcvTVo1cVNmRUpDaFpsb2Zs?=
 =?utf-8?B?L2VqanhKMWxXM0Z6NkRFd3RBOHNQeFFlb0F3UWhhQ1Jpb3JITUVqWnVoNXlI?=
 =?utf-8?B?ejVXMVhpUm9qY0tKNVBxU2hORm5kZklyKzQwMGZEQko2VVZWVFFVS2dPekhC?=
 =?utf-8?B?ZUp3MUpCbGtYb2RmQXI0VHl6anNGanhoSlRXeWZkOXJpMzkrZ2kxdk5iak8x?=
 =?utf-8?B?cGZFMFR3M3BqZ2ptYjQrWldIQ3pQMXl6RWhIWDl3K1JQbzNZek1uSTlWbnBM?=
 =?utf-8?B?ZVV5ZXRuNERFYTcxK1lIN1ZUUE9JeUZuc2lFU1NEK09KbHZhSmR1d1BvcEND?=
 =?utf-8?B?YnhSU2tMNFc1TTBnRzhQdmxJK3hadjU2T2RUUk5CTW1iOHNEVyt5UWhBdmpt?=
 =?utf-8?B?OHdTeTVCVWlSVzJZLzBGTkJuQyt1aFFGMU15ODNNTWZtTEdQUEVsN1Q2bThr?=
 =?utf-8?B?cjhqTUVGQmc5QkszOWp0cFpSbkpNMkFiRUVmMVRReGZ4VUxMS296L25rQ1ZV?=
 =?utf-8?B?aVVnVnlqMmpkcy91RVFNOXNBQ0d1ZkJudytEWXNVVVhib3U1VTl3OHFqQm5G?=
 =?utf-8?B?djZwdXJoZ3VWUnJmeldVRExNRExDQlVNOVo4Y2VVdnhQQUZ1aWhTNjJhMXJC?=
 =?utf-8?B?UXRtZGlkVVBvK29XMEtPdkhXZTJXWk1iYVY3V29POSt0NVZqdHFubWZXamZw?=
 =?utf-8?B?NFBzNGphNTVRRjNtR0UvMXRIQW1ubXR4R21VclhmT3VZNVhyMkFDcXVmaG1j?=
 =?utf-8?B?U29XY1N2dk95Y0dlWXRtaVQzdDdRakFmbXZPVlg5OS9saTMzTmFlZFY1RURP?=
 =?utf-8?B?ZHBvK01laXVCYlNmUGp3ZWhXUEZ0ckd6NHNwZjlXU2ppWmhQOE5HUG1ISWpU?=
 =?utf-8?B?OGpYVDB0bEJ4YjJ0cTVONFRNZW5Zb2UrL3pKZmI5ZER1aUtQYUpKWXBtbmVD?=
 =?utf-8?B?aVd4aHhxY0tta2YxZFRoSFVRa3BPOFZEdkU5MjlFQ000ZXV5V2FqemZxbzh3?=
 =?utf-8?B?dTFWMXRpQ2MvQ0I5dUpndXRxbGZ0RkR5bWw1U0tOdjVyTGpBOHFjL1NRYVRm?=
 =?utf-8?B?dEJaMnVyZm14SFZpaEtLWDBCTno4YitVMmphQ3JtSkU3dFQya095NGxER2hw?=
 =?utf-8?B?YUpuWmUvRmpmQUxnV3IydE1TbFpNM1crWjlYTXpWZ09CU1YzLzYxRCtIL0RX?=
 =?utf-8?B?YXdPZWNSRTB1eE5yYmI2RGZ3V0FXN09Kd2E4SHpwT09JbzhXUUVDOTZpN2VD?=
 =?utf-8?B?c01ETTZFTGJKc1pHM3pQakZqTGpuSDZJSVlONitkUzlqMGpKcDlIV0d1byt6?=
 =?utf-8?B?a0twcnBHckdtNDhyY25JZ3Iyc0FlRGw4dHVSdkxqWGdyaWdiMWZGb2IrVWkw?=
 =?utf-8?B?eWhOQ0tLMmtvUGtWM3V5YmZnSDNsdmxZNjhJSTFNRzRsSlJlbFdtaGZJTHRu?=
 =?utf-8?B?THVZZDRtajhod2FIeDBmNkx1Nm5lcEpuVElrUURLS0gyS1pFUXVWcDRxNVZt?=
 =?utf-8?B?NDdBd1BKUk96cDU3cXNBMXBhUWszb3BodnNzcTJTZFRVcDQ3aFNtc3ZUUW1M?=
 =?utf-8?B?Z1FSK3VnQ3M5S1A5NEVxNEFGais5RXNOTkZkR2VHTU9GMWIvMmpUUWszWm12?=
 =?utf-8?B?ZDZQZWdCT29OK2NyTEVlbGdTM3B6VExFYlE0aVRQSDNzN1hlNysyMEdUbmVN?=
 =?utf-8?B?akFJK3VnRFhZZHRVWlNTWExINEM1MUxHY3BiK1Z4VC9hR3V1SXZ5TlZYNm9H?=
 =?utf-8?B?K3pvSG8zS1BpMC9xUHBtZVd1cFJ4RnpOQjZkeUVYQnZRWEZhNjNCc3ZBNlZN?=
 =?utf-8?B?K0dkeUtjSjA3bHFPaXdsa2puOVdEdFg2elFaRjZhdEFVNi9KbEpHajBtZWRZ?=
 =?utf-8?B?RmZWN0FZRDBUUGRCVWtYb3I3VDlDRTN5MTFwVGFFczR0Q1ZnTm9tQVA2VFZW?=
 =?utf-8?Q?aZogLzsMNbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmxpTVBiWlRZcWlXbmlZVXBROWlqWDJ6djdtVDhMMnVoS3V4WUZvUDhGR2o3?=
 =?utf-8?B?OC9RTXJTbjBYQ3ZBUzZocFZxWEhiazF2NEo0R0pFYVJuV2lsU2N0VHRVQytT?=
 =?utf-8?B?QUdTY29UeW9QTkxmTVl6WVFjYlQrZGtwWW9TbjFycHNienZ6d0NXRWZJTlVu?=
 =?utf-8?B?WFBnQTEyTXprdk8xaGU0ZHpEWmM2YzJNcmMwYmNTM0VSU0dvSmlhTWJXWGV5?=
 =?utf-8?B?TndHRnkzOVRCQTc4dFg4Q2I1MnUrY3o1TmkzbDRNelNzcHJ2b1VvR0hiSEIz?=
 =?utf-8?B?QXVTNER6Q3BsRzhMUmJ4V294M2U0MEdaSE5GWEU2UTk3Ni9rSnVQY01UZ0VX?=
 =?utf-8?B?TWROOG8wQVRJbGhSU2JSdURYMUsrTFc4SzNpME92dW1EaUZGZnpHY0hsdXZk?=
 =?utf-8?B?MDlCZFNMc0t6dS8zQjFtaklSVWQ1ZGdzRHhKZ1VZNDBpQlNZa1V6YXF3Q1hY?=
 =?utf-8?B?TWRJWUdyaFpjSkNoYnBXcDdsTWVzb0w1b3R6bnRuRXhsdkZIM1VKakdCSnZ0?=
 =?utf-8?B?bzNhQ0NOUTR1WWxacVZ2TEZGZEJuOVN3N2hYbXVML0FNRTFhMjlLYUFHYzhn?=
 =?utf-8?B?Qi9pRC9vcjZzdDlCS0N4cUtMYlpiK0dleExOTXNjb0NHakpLRUdMbGF0Q01U?=
 =?utf-8?B?RTdIcTZrVkJpdGlPd0VOOTV4cmZPa2ltN0F5OUx6c0FRUVoxcU1sWlpyekYy?=
 =?utf-8?B?WEJSdnpvWEdQcFhiRE1FRENQQjVXUC9DaG9qY1BnK0l0T0F2TVVYYkp3bUZn?=
 =?utf-8?B?RzFORlJiZ1FuWi9tMmhkMHdzNXZoS2JSbUxoSmJkaW5RemQzQTl5V2lEV2tJ?=
 =?utf-8?B?TFUwMU43dzM0bFh1dUJpKzlONytrTjRkcXA4MnJjY1hqK3ZpenBEdFhxQjJV?=
 =?utf-8?B?b3Y1b1ltQzQ3dlBEY29qUWhWRTg0OFNTQWc5Q0k3NUZwVm9yQ2VFQ3dBR2NN?=
 =?utf-8?B?QTJMTmNEZm1lYU9NMDJJbjFyVVdBLzA2L3ErQ1Rva2haWDZLUzZPUkJBWFpx?=
 =?utf-8?B?cHZRQUU2VEhDejFyZFJsOXZLa2RvZnlscGpvNkp4OEd1aFF3OStKRzVFeFF2?=
 =?utf-8?B?c1lSRnlRSmRwS2U2Q1ErQ1pKUXNubDFCY1FxaUF2YkJEMjJWN0NUWVZaTmZr?=
 =?utf-8?B?V0k0SnRkdDZXQVZ3cHRiZDRqYktWQWFzTDhmeDRrcWNlZlVVSk51ZzUxaS9D?=
 =?utf-8?B?K1pPWDc5ZlNYUUIxK1ZKcWdTckZ5Q2dZVVFWTld6TDkzZXZIS1I2VDFHaUI0?=
 =?utf-8?B?ZndQdDdqRDhGOWZhbXZHVjgxNXl5T3Vnc1FjMzdOemtPN3pVZjUveFNMN2Q1?=
 =?utf-8?B?bVdaekJKeWR1Y1JRSzZ3V3JvdzMxaCt6M3ZjMjF1OW9vYzJSTXZLbWl0bE9l?=
 =?utf-8?B?STdOcXRUMk40dTlYZ2pBazVVQWwxU3prQWJaa1ZVWW1KZmZGWThPaWY1OFR0?=
 =?utf-8?B?Y2IwbnhSZTFWL29HVUdYaFpPZzZzc3ZwU3R2enlBOG9oSkpxTVlyejZQVXdn?=
 =?utf-8?B?WlZGUFZYYzAwcFhNcDhYSHF0bzBUTW96cGo1YmZGZnVLbXZZYU9IWExhOFJB?=
 =?utf-8?B?TlZMdzdlbU1rT1Byb1YzRktIYkdtSytWV28xRExETm9VYTRobHBXZUlGMDBU?=
 =?utf-8?B?bC9YRzd4VFkzd2tnSDZZaG91QWdtalJlZXRzL2dBYkxNeC94NVp0Z0YxeEJM?=
 =?utf-8?B?OHJQcERVdkhzQzNPN3c4K05HQVljNlNGakkxQWI5cUhtdVNsWmpRQVl6R0RP?=
 =?utf-8?B?M05MYmRHUjQ1Y3owRURWUXhkODJnL3NDcXR0cHhSWVZ2TkpPeG4vb29DM3lR?=
 =?utf-8?B?KzJjbng2c1BCNkdOYWcyaERqc0E0NmxrNk1TMmxQQmtPZHlsTmZLUm1oWkNG?=
 =?utf-8?B?MHB1TkZuOXhuUmZHNjZHWnZwUzVNRytmN2MwUElSNU9Sa0lKQktheFFqMVdO?=
 =?utf-8?B?RTNra2VBNlJ4VS9JTWlRWW1GK1FManRXRGordnE0TmpNTmViNCs1WXBydDhO?=
 =?utf-8?B?WjFzYkV2NExBZzJmdDlMa004MzhVSU1BWVJTMzlHdUtqeUNpajF4QjJmNFJt?=
 =?utf-8?B?SlF3RElUUEpXaVVGNFNLZVZ6Wi9FNm9neGlpS3l5Q0NPYjdzVkFkRU5RVTZU?=
 =?utf-8?Q?0zqE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3448d02-fad5-43f1-cf7f-08ddd6200258
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 02:05:12.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaK64kUS8sRaO2GX8HSqsrnmdUHFMHACbtsMqk2Yv08fc28cH5yWDv/D62P79D2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

Hi Reinette,

On 7/30/25 15:01, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> System software can read resctrl event data for a particular resource by
> 
> "can read" -> "reads"
> 

Sure.

>> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and
>> then reading the event data from the QM_CTR register.
>>
>> In ABMC mode, the event data of a specific counter ID can be read by
> 
> "can be read" -> "is read"
> 

Sure.

>> setting the following fields: QM_EVTSEL.ExtendedEvtID = 1, QM_EVTSEL.EvtID
>> = L3CacheABMC (=1) and setting [RMID] to the desired counter ID. Reading
> 
> "[RMID]" -> "QM_EVTSEL.RMID"
> 

Sure.

>> QM_CTR will then return the contents of the specified counter ID. The
> 
> "will then return" -> "then returns"
> 

sure.

>> RMID_VAL_ERROR bit will be set if the counter configuration was invalid, or
> 
> "will be set" -> "is set"
> "was invalid" -> "is invalid"
> 

Sure.

>> if an invalid counter ID was set in the QM_EVTSEL[RMID] field. If the
> 
> "was set" -> "is set"

Sure.

> 
> "in the QM_EVTSEL[RMID] field" -> "in QM_EVTSEL.RMID"
> 
> 

Sure.

>> counter data is currently unavailable, the RMID_VAL_UNAVAIL bit will be
>> set.
> 
> "The RMID_VAL_UNAVAIL bit is set if the counter data is unavailable."
> 
> Please review after changes that all is coherent and in imperative tone and make
> same adjustments to duplicate text in patch.

ok.

> 
>>
>> Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset
>> and read event data for a specific counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 68 ++++++++++++++++++++++++++
>>  2 files changed, 74 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6bf6042f11b6..ae4003d44df4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -40,6 +40,12 @@ struct arch_mbm_state {
>>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>>  #define ABMC_ENABLE_BIT			0
>>  
>> +/*
>> + * Qos Event Identifiers.
>> + */
>> +#define ABMC_EXTENDED_EVT_ID		BIT(31)
>> +#define ABMC_EVT_ID			BIT(0)
>> +
>>  /**
>>   * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
>>   *			       a resource for a control function
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 1f77fd58e707..57c8409a8247 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -259,6 +259,74 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	return 0;
>>  }
>>  
>> +static int __cntr_id_read(u32 cntr_id, u64 *val)
>> +{
>> +	u64 msr_val;
>> +
>> +	/*
>> +	 * QM_EVTSEL Register definition:
>> +	 * =======================================================
>> +	 * Bits    Mnemonic        Description
>> +	 * =======================================================
>> +	 * 63:44   --              Reserved
>> +	 * 43:32   RMID            Resource Monitoring Identifier
>> +	 * 31      ExtEvtID        Extended Event Identifier
>> +	 * 30:8    --              Reserved
>> +	 * 7:0     EvtID           Event Identifier
>> +	 * =======================================================
>> +	 * The contents of a specific counter can be read by setting the
>> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
> 
> ExtEvtID vs ExtendedEvtID ... either the definition or the text should change to
> use same names.

ExtendedEvtID

> Can description of RMID be expanded to note that it may
> contain RMID or counter ID?

Sure.

> 
>> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
>> +	 * desired counter ID. Reading QM_CTR will then return the
>> +	 * contents of the specified counter. The RMID_VAL_ERROR bit will
>> +	 * be set if the counter configuration was invalid, or if an invalid
>> +	 * counter ID was set in the QM_EVTSEL[RMID] field. If the counter
>> +	 * data is currently unavailable, the RMID_VAL_UNAVAIL bit will be set.
>> +	 */
>> +	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
>> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>> +
>> +	if (msr_val & RMID_VAL_ERROR)
>> +		return -EIO;
>> +	if (msr_val & RMID_VAL_UNAVAIL)
>> +		return -EINVAL;
>> +
>> +	*val = msr_val;
>> +	return 0;
>> +}
>> +
>> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     u32 unused, u32 rmid, int cntr_id,
>> +			     enum resctrl_event_id eventid)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	struct arch_mbm_state *am;
>> +
>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +	if (am) {
>> +		memset(am, 0, sizeof(*am));
>> +
>> +		/* Record any initial, non-zero count value. */
>> +		__cntr_id_read(cntr_id, &am->prev_msr);
>> +	}
>> +}
>> +
>> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			   u32 unused, u32 rmid, int cntr_id,
>> +			   enum resctrl_event_id eventid, u64 *val)
>> +{
>> +	u64 msr_val;
>> +	int ret;
>> +
>> +	ret = __cntr_id_read(cntr_id, &msr_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
>>   * which indicates that RMIDs are configured in legacy mode.
> 
> code looks good.
> 
> Reinette
> 

-- 
Thanks
Babu Moger


