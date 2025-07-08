Return-Path: <linux-kernel+bounces-721660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9809BAFCC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E4F165577
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0162E3B05;
	Tue,  8 Jul 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zQ3qeDqd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E82DEA9F;
	Tue,  8 Jul 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981248; cv=fail; b=UuPbuXdVwpGatcI8ZCTAMDNtqyXhibVs/+qa/ABDJSKvx/v3Q1DCKId8jV7RBSpe9PEXftLpgBiIzIeMaatawFygsmBke2S0C+SjXvIiiS9p15f0u02aWp3P6mbhhCxHaJWylV4uNnL0RU/uJ2FfJ/NR+6KrodAAKqQxmxdeWsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981248; c=relaxed/simple;
	bh=LQnmmFDY/6+DHYJSf+8/bE4zNGsv5G9vWu/GbrA9WEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjp3gjO2pG8h786XsI4tkhkdOHrnro/ZWXfpUIvJJOzSdkMudbl8luA8H5pl/GQtocNs2MauDq4K1cl4wqJoxImOsnNH0p/fYnwwIs+SEr+MllyF0xCVINll4zrQvbrjYLWHx/0m40u22azJgIFmPjirge44mNSPyZfsrF6JoXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zQ3qeDqd; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVcb3eTiZ6mfeWIw9h4dmj3pIiHnqclLil6A2Snow8+kucqqY2gXqIEPa9/lREM7sy1pY0OZc8eWgoCcnMGKcr+gw90/avv0WbmY3XBXamP+AAByNxzgWff4V+2tQTFZylhAYU+Td2EPQtzuLc1wpRu01iGm3PlMR8uiEXZMfVzUbtYAZOubHLEPdPYJDOJPzmJ4NPVqUkBT6WeVnwQqUrtAEVXLgwtiWJukOecB/iu2dvc+uLl4SOK1yayaVD7gLb9+Bns2RBXpJeV6F/F4ZuylRGFUW37siCMu6FcCOTvvTndIVQBOxmezNa7f7EM9Qu21psFIENU2tN/GzT6GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS06i6YRs52EPZjJtepzCW7CNBXH79i6z+IshYqWfy0=;
 b=SwaDdGSy+vGflhn2Av9pLjiqSXqXKq0amYZ5Yi5qqBIUxncI5eUhNqhMLq0nXX6O798hcqfeQChhUYavCdvqwxWPoPuawGIPB61HjlOecaCY5Rl1UVzuRDYDi59VzWNeBKh8jcicdHfpf8rvXrg6+8K8GgzEWW6IrO7oKzAGuzvJ4r3C8c6FaOmxJFweeTWLJWIFwIYNtP7PgetFDnrJ+QMVbSeRnnF5ZqgtKZCj9zcotezaAspNfDwx2WoizkM2IYtf09a2DVC2EWOmHtNL2rL/G6u9uOfw5CU4gVrWHStHKnx2c/sr7S2cbb8DlLy1iY5RAhP3jJrshCLoMi1K5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS06i6YRs52EPZjJtepzCW7CNBXH79i6z+IshYqWfy0=;
 b=zQ3qeDqdmQqetK3rOLhXswpgPWPcDucmLYN5NB2rkGhx9rReCW9P+Mr7dw97SpcJK5cqaGT4njiACEm2PriGEqKFSU+dlqX58pyFfc4LulbA8qbU00/OdrvkP2XXcEeIaupgKS2qI4RifUX2yLbSdLxvv0wo703V+J1u+sCaeNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:27:24 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:27:23 +0000
Message-ID: <2b49620c-f2b0-4994-8617-e436725d0cf6@amd.com>
Date: Tue, 8 Jul 2025 08:27:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/32] fs/resctrl: Hide the BMEC related files when
 mbm_event mode is enabled
To: babu.moger@amd.com, Reinette Chatre <reinette.chatre@intel.com>,
 corbet@lwn.net, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org,
 gregkh@linuxfoundation.org, seanjc@google.com, thomas.lendacky@amd.com,
 pawan.kumar.gupta@linux.intel.com, manali.shukla@amd.com,
 perry.yuan@amd.com, kai.huang@intel.com, peterz@infradead.org,
 xiaoyao.li@intel.com, kan.liang@linux.intel.com, mario.limonciello@amd.com,
 xin3.li@intel.com, gautham.shenoy@amd.com, xin@zytor.com,
 chang.seok.bae@intel.com, fenghuay@nvidia.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1749848714.git.babu.moger@amd.com>
 <4769751d1de7c4f66b1c7f3c5ea7eeeb49951363.1749848715.git.babu.moger@amd.com>
 <3c753f3c-e91b-4cfe-983d-efe8ff07b750@intel.com>
 <f85e467a-1d17-4f34-98e3-512679baad47@amd.com>
 <ff314427-1c03-4e26-be19-c5f5090f3d8a@intel.com>
 <471975cf-1094-42dd-a965-f536cf399d0a@amd.com>
 <d5c4d3e8-6d5f-4892-83b5-867ec8bfc97a@intel.com>
 <f8f434d0-1c44-4d76-9121-7c0acc7aa10a@amd.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <f8f434d0-1c44-4d76-9121-7c0acc7aa10a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: bafeb00d-5b41-4ecf-dcf4-08ddbe232c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFpWM3Bma1UxOFJ4VXNqbVo3cjFVRHMwRC82eHgzQW4zWFlaZVEyMElkT09w?=
 =?utf-8?B?ZnVyK2RjTWlwQzlHSzFieXMrWEVDUTNnY2E5cUdrbzh2d1phNmhkc0tDNmdt?=
 =?utf-8?B?bERhZ28rN042anVWUi9aNHM1eVBsbmFRQ0Nmb1k2NXNmRUJpZFdFL2RpQklr?=
 =?utf-8?B?QUxHMVEveWJiZHVvT0x6M1ZvZjNITnYvTnBMSnhPaXNZbTAxMDlBZDNrS3pO?=
 =?utf-8?B?QngwSmRnTUk3WlNaRlFhUitOTHk5OTJCQnJJV1F3Q1FDTW1PY1B5dTk5Y3Rn?=
 =?utf-8?B?M1AyUmduNXF4b2xZUVZOMlhRV1U5WXpMMld6Y3FsY2Z3L3VhZnR6Tm9RZ25Y?=
 =?utf-8?B?QzZvWXZwUHZPQUdkOFMrMDZ0SkpMU2Y3Z2c4SmVFTjZUTjREZ0hMWDlES2ds?=
 =?utf-8?B?bUx2NEhjbUI5U1QybVF5b2d6aGh4dG9YbkNBeE5CZXAzWXpXb3MydlVhQTgr?=
 =?utf-8?B?OHJsUkp5ek5PK2NBbWtNRFliVEpZSkZVUW4vbFRpRk5nZTVCNDdscENMTnRw?=
 =?utf-8?B?QlIrQXpVRnA5WTB4NDNpZzRBYm5Ra3dWWnkxMFdyZ2kveVQxVlNiYzBPQlRj?=
 =?utf-8?B?ZzVFT3V0YVA5Vk1WV3VGTVBrMmx4eUZTNytHcGRiSyt0L0tpZWlUSlRWNUZJ?=
 =?utf-8?B?VENScjB0MEU4N2xMdEdkVWluVVZwVkN5RmI0NU0xVnBBaEVrVkhTbzI0dTFY?=
 =?utf-8?B?NEpaR3FtMkFLU3RDSThubzFqOTVoNVlRUFdRSE1wa3J5WHJxM1lVV1RtaWVu?=
 =?utf-8?B?UjNnYjRLWW9Na0k1RVdLd0hDeUVhQmpPMU5pNHVwVHBWYzVud2ovMDhpbFkx?=
 =?utf-8?B?L3Y5ZGVneWg3dVhmVVU1UWYzSnlDcDA2OFlMalBjOC9FMmJrdEFHUTlJclFh?=
 =?utf-8?B?YUN1Z0t2Q2xKWitKejNvQUhIb0sxeEFGV2NGOUlXZkMzV1dYN2ZaSmYxbDNC?=
 =?utf-8?B?YTVjNjY3VDNVdmhUOFFkZktsTlY5OVlBWVhHVVl5aEZ4WU05ckJHUXl4eXlt?=
 =?utf-8?B?TEgvSDR2VGlmZkQxcU9kUVU3bjY4YzJ1eFRKWXhaazJaNnBsS1pmZjlsbDVz?=
 =?utf-8?B?RGJlaEZxUUlXeTNObGdsRTFiWklOL3NQdEhRV3QwQi9JbExyTll1Q2VZSGZh?=
 =?utf-8?B?UzhVckpJaDRxZGFZWWZHQ2QwNHBIbUtoVUtweUhrUWQ2Q2lNRjlSKzhsWDFX?=
 =?utf-8?B?TjFDS0VuM25vbnA1UExhNlRVYm5TMEJqRWpjMWlyaWYvR0NYQUNDcm83TW02?=
 =?utf-8?B?cFE0eFJOd2hTalpXdlorUWxCaytkTWFzRGx5RHQwdHJxdk54SzRLWXpWQVp1?=
 =?utf-8?B?dkdIVVF0ZUdDb3QzQlpoQnQyZWxPeGpvZzhsYXhNSmRqNGs1QkthVFdOZkw1?=
 =?utf-8?B?N215WVEvbGo0QVM3bTNRZzlKY1UzcUZROTdFcWo3amJaSXJ2R21leHRtTWEv?=
 =?utf-8?B?UUVOdVo4TzN5Wng1MW9MYXB5RDFnRTY0MnZKQ3ArYWhpcWZERlYrQjhIM0ps?=
 =?utf-8?B?MUxiNmxueUxTQXR1MUpCdkFsd0NscnN4QkR0R2oydEplY21TbDlNS29TV3Vk?=
 =?utf-8?B?U1Z3S3BrbFVaMXZTTUl0ZWsvUG01Z3ZxVEx5TFlPZHNYaTlBNzFxQ3NtSFdI?=
 =?utf-8?B?SE0wcnZ4aWllbksrOENCU2l4c2FFYTJnRC9TK2RYcU12QmNodmg2bzhpUG85?=
 =?utf-8?B?VTZNb0d4NzB3bnVuUmw2YlI0UnpyWmY4Z2JwYVlHWEZuRDU1RFhKbDRIVFBB?=
 =?utf-8?B?TDJ4OFcyb1FIVGRBS3JvbTVXSU5UV2dQS3BoQ3dCOVV3bGVaeVFWVmM4MW9y?=
 =?utf-8?B?aWdmUHFLbVMwWWxLYzBtdXk2M0hzRlR4WW4xd0t0a21wZ0djbkhCS3cyYWxY?=
 =?utf-8?B?U0pCaFZaaWhEL2RTdzF0TjdIWUk2MWJvRW5UcVo2eVMrVEFXZnF2MGFpRHR1?=
 =?utf-8?B?SGN5Q1VlRFIvdUdyaFB1WUJWRS9XM1ZsbXhaSEc2L1RnaDd0anNJVTdQTTBX?=
 =?utf-8?B?cEw0cXVSRHZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFnK1hZeHpZbmsrTUJHcWRuL2ExUW4yd2NWNVQxa3R0WCtCMDJyMGhXTEJM?=
 =?utf-8?B?T3UvajFady9MUjQ1RjhoVUtaakQxVVI1MkQwQ3Zib0dHSEIyYzUzNWZ1MGpt?=
 =?utf-8?B?WDArMGtpRERzN1Bya0RlZS90dWJwVEZjZDZNSlZrSmVKeFN6b1h6SjAraDdZ?=
 =?utf-8?B?TDN0cE55T0dlaEZkVms2WkFQVjNmSFdoNlZQdnppb1pEMERHMjJKdkJnR2h4?=
 =?utf-8?B?SlQ4NWN3OUU2aDdBU2Q5enhkSnd4cHd2aUNZWWRLVzJhK1NyL2pNeDMxcUZz?=
 =?utf-8?B?UHluZWRnZjhESElXbmcxampxc2dPT3FsazdJYkcvUmFTODlScjBVU283cUpP?=
 =?utf-8?B?TThtNEFhQldIb3MvUmtLU0JvS2ZwSENQOXE1N1Z4bzNsb0JjMXI3RTRqcXZh?=
 =?utf-8?B?eDhXMFRkb2xDSHVSRnpuNjVQUVphVXRad0RDVTg0VGdRRW5QUmVuUjN3ajI0?=
 =?utf-8?B?RHBWZ3dSbkV0QkxERzFkUjB0LytZNG1GYkFOS3FvQ2JLRFI2My94WlQzaC95?=
 =?utf-8?B?aVNadDZ4QW83K1I2akdzbkUzeHpvbStIRnZLZzJ0ekJ4UFpad3FIWjA4amVp?=
 =?utf-8?B?NWlFUDVpOVBZZ0FuaUREU0FHY2JRWjhsTUpIVTBPMzdSWi8rNUNkYVBpUHpD?=
 =?utf-8?B?UWN0Ym1mMmV2SllsT25yVC8rYnFsTG9hbGpHZHBLby9tb3E2S2RlQnFNYVZs?=
 =?utf-8?B?WmpzQXA0aCtIa3hUcUpBbktITXJrUDhUNVdFSktOSi9FQitseVZrVi9vUmR3?=
 =?utf-8?B?NGNQZnpKWXl3WXNhNnBhR2MxQUxSV2hRdVdpV1V2elpZWnNqb3JuYWZuYlhq?=
 =?utf-8?B?OVZHWXpjeTR1N0lTTjVmY0JRZXFDMitRZW4yRUlPRXVhOWVqVTVPSjlXTERm?=
 =?utf-8?B?QnA0aDNBZGhmNDlzRmRQOGtuMUxWWGlLVzJOaGxYeElwWmRmOVNEZ3ZVTUUr?=
 =?utf-8?B?a2RMeFZ1d3FDS0xsZVc1L0pUSy9MSnl2NVdTaTdCUDhLWlhBYzg0UGUwcWd5?=
 =?utf-8?B?bjIxbnJpUVNIVHNPYmJ2dW1HandFZmFVdWJ1NU05K1NvaHhralpwYXNLSCt5?=
 =?utf-8?B?dHhSSTBkQTVnRXYzcW9XaG95TjF2VUorSjFUK3dHbndOK08ydU9Yb1RVd2Z1?=
 =?utf-8?B?YlN2aDl1VUp2Rm1KMmZwdzZqbi9wK1c4YXVUMjV1U2ZFcVYzUUJGNlRCZjF4?=
 =?utf-8?B?RXpLKzlieU11MTlnMEMxc0tHUm5RSWJFVkNxSUNpaE9MSVI2OFpOdUZNVUFJ?=
 =?utf-8?B?YWpQOEt4b1E2VFcyK2JkWW1uTFVHN1NDclFDVjEyTy9JK0tYUjJhTVhXZy9z?=
 =?utf-8?B?ZlZnM0J3MjVaRGtiODdOYjFCYmpqYzdYbkF0SG83dE9iQlRPSTFjMXF4V2ZW?=
 =?utf-8?B?K3lheEg0NUxRK0pxWFZvRDg4c3VoYXNQVDVOdnB5NnRzUTlCK3dQMlgxVWlY?=
 =?utf-8?B?T0VBN2g5K041UTRrZVVqa3B0UVI0alVpWURBMXJCek9UeW4xOTdtV0Zyb2JX?=
 =?utf-8?B?T1N6T3BaQ1NONUozc0N6MkJEaEU1K1Vscm5XdHRsSWpoT2FVRUVJbTRxd0R6?=
 =?utf-8?B?UU5lSW03KzB4dmp2ZGhnOGt4eFd5Rk1XOHlkcmtHeDRGd3ZDSHFyblBIY1pR?=
 =?utf-8?B?aVFGQUFac2p1RTlaZ3lBakdpbEwwTnpTbEJFWDNNczFvYkdHbFhKdFJTbjVx?=
 =?utf-8?B?K3VObHNVaFI4NWczREh5bG94bklQejh6NlY5V2xGNGoyWmJaU0pQdUo2UUll?=
 =?utf-8?B?Nmc1ZmJZWUhnbnE5SkpZR08vbkxsdUw0ajRxeUVSMC9aNFVNYXhrekM3WGpq?=
 =?utf-8?B?WkdaTzJDRElrSUJraVhRTkRBUzJIN2tobFFoSHUwaEFxKytidDN1Qlc3Nnlt?=
 =?utf-8?B?TWdSUHVhdHM4SmM1TW9tQ3RZbnNhOHdmVjNYbk5ENUVvdjBZRzNvSXJRTnQ0?=
 =?utf-8?B?VkVmYVZvblhBMWtGd0JuVkJGVWJVTEVSMC9BYkpXUG1KdXA4ZmFOVnR4MkF2?=
 =?utf-8?B?NWpuMmx3dFdpQVlnRVhTT2hsUm1sL0NHYWJRZ2pNZ2FORXhqd24wTWViTjF2?=
 =?utf-8?B?TFN6b2kxYkYxWTZJNlFhV1pHT1hndk1FbzdZNmlrT254azdTSDIzVjdRRlVp?=
 =?utf-8?Q?0Dv8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafeb00d-5b41-4ecf-dcf4-08ddbe232c7d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:27:23.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTItk0BFfRVU92y27VvQH93Pnewj0JrWAtyfaxaMPFMxgdBetLu9DctsLBXiXZZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

Hi Reinette,

On 7/7/2025 5:35 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 7/3/25 11:21, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/2/25 12:04 PM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 7/2/25 12:21, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 7/2/25 9:42 AM, Moger, Babu wrote:
>>>>> On 6/25/25 18:39, Reinette Chatre wrote:
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 6/13/25 2:05 PM, Babu Moger wrote:
>>>>>>> BMEC (Bandwidth Monitoring Event Configuration) and mbm_event mode do not
>>>>>>> work simultaneously.
>>>>>>
>>>>>> Could you please elaborate why they do not work simultaneously?
>>>>>
>>>>> Changed the changelog.
>>>>>
>>>>> When mbm_event counter assignment mode is enabled, events are configured
>>>>> through the "event_filter" files under
>>>>> /sys/fs/resctrl/info/L3_MON/event_configs/.
>>>>>
>>>>> The default monitoring mode and with BMEC (Bandwidth Monitoring Event
>>>>> Configuration) support, events are configured using the files
>>>>> mbm_total_bytes_config or mbm_local_bytes_config in
>>>>> /sys/fs/resctrl/info/L3_MON/.
>>>>
>>>> A reasonable question here may be why not just keep using the existing
>>>> (BMEC supporting) event configuration files for event configuration? Why
>>>> are new event configuration files needed?
>>>
>>> New interface that enables users to read and write memory transaction
>>> events using human-readable strings, simplifying configuration and
>>> improving usability.
>>
>> I find the "simplifying configuration and improving usability" a bit vague
>> for a changelog. The cover letter already claims that ABMC and BMEC are
>> incompatible and links to some email discussions. I think it will be helpful
>> to summarize here why ABMC and BMEC are considered incompatible and then use
>> that as motivation to hide BMEC. The motivation in this changelog is to
>> "avoid confusion" but the motivation is stronger than that.
>>
> 
> Changed the changelog. How does this look?
> 
> "The default monitoring mode and with BMEC (Bandwidth Monitoring Event
> Configuration) support, events are configured using the files
> mbm_total_bytes_config or mbm_local_bytes_config in
> /sys/fs/resctrl/info/L3_MON/.
> 
> When the mbm_event counter assignment mode is enabled, event configuration
> is handled via the event_filter files under
> /sys/fs/resctrl/info/L3_MON/event_configs/. This mode allows users to read
> and write memory transaction events using human-readable strings, making
> the interface easier to use and more intuitive. Going forward, this
> mechanism can support assigning multiple counters to RMID, event pairs and
> may be extended to allow flexible, user-defined event names.
> 
> Given these changes, hide the BMEC-related files when the mbm_event
> counter assignment mode is enabled. Also, update the mon_features display
> accordingly."
> 

Here is another update.

fs/resctrl: Hide the BMEC related files when mbm_event mode is enabled

The default monitoring mode and with BMEC (Bandwidth Monitoring Event
Configuration) support, events are configured using the files
mbm_total_bytes_config or mbm_local_bytes_config in
/sys/fs/resctrl/info/L3_MON/.

When the mbm_event counter assignment mode is enabled, event 
configuration is handled via the event_filter files under
/sys/fs/resctrl/info/L3_MON/event_configs/. This mode enables users to
configure memory transaction events using human-readable strings, 
providing a more intuitive and user-friendly interface. In the future, 
this mechanism could be extended to support assigning multiple counters 
to RMID-event pairs, as well as customizable, user-defined event names. 
Also, the presence of BMEC-related configuration files may cause 
confusion when the mbm_event counter assignment mode is enabled.

To address this, these files are now hidden when the mode is active.
Additionally, the mon_features display has been updated to reflect this
change.



