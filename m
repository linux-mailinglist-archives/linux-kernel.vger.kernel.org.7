Return-Path: <linux-kernel+bounces-768036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7DAB25C24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED827AF3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DC259C84;
	Thu, 14 Aug 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="dNNzFPi4"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023093.outbound.protection.outlook.com [40.107.44.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB7F257AFB;
	Thu, 14 Aug 2025 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154077; cv=fail; b=qGr9guQ6LgzNy0yxpxCAM/G5gUaapBkPB29F1U3LMs7ncLHRgbpxqrK+OGlY4wtrJmTMGhmmfE6XA8qQ43j4W6BZJNBHRZ/+0g8HTFLnGjwdIKqvTBsigoF3CQCscoSwhukJihm7FRU2xHwW8CN1g1I3biHgbyYrvlWJdUabnV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154077; c=relaxed/simple;
	bh=JaqZvI1iBBSYHRGheXA/U19IJ0gQWNCfVpRbg/CZF60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=saRICDRDgWgx0804QwU776cPcijAfzHB79NrXHvdoWYRXJovdek3EDC9Tse9Mdd+1+gHkb9DCFwyB832JpqNSITNfUPY6LIZLuoFhSzge2mTAW7p6lh9vsp6HTuekgkk6g54zYI+PP6pjLHINZMtbjfqqjMblY7S1/LfA9l9MIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=dNNzFPi4; arc=fail smtp.client-ip=40.107.44.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLUiAZ9sODlZ8YP6SDOOh71SdQtsmg6Lu0wi6VpBlpIQW9xrOw/jQbSWLTHnG7X0PYihr0XpJPqYsZCbw/ykFwv8wagBZCK19NrUybXDOD3LWI0v001g66lwXw26jCahiSzKh/JTJGSPYMeGldNAf14/jo87vNcKJaU9jMFK+Vyv+acSbZU1SWWJqiyvzkwio8dsw0utPkmY3q9B3RW3bIWbSzfMr/ZM6nO9Ki+lz3jq8Wrre65zZd7LPpI2koXcWLhrX+mPUoeTObG4PfFPq5HwOiXYJQPh/Br/60VYIk4GrkpDcsILqSFomO0x+Awqj9PH/6wk0/frZwi64NTupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sObWBleM26XlRHBt5J4SMak3+y3gQjEogba0jvTT/g=;
 b=uqgaFnZDftDRjaUp+3IUSuYG7rufa85pFJ08VC33F+2cTydDs7jD1s9j87H7zqvoAYJ/0SF2mB5r42UA0OTqB0IohxJBzW2itcgp9WyLQNxpntSfpFGY5g8HJdDTwf+AXS9nC6wvFPuiIfBou0jD1RgAx5R0NklLCM6TWfnP+Z4MbwYZfojZtf0YMM8sZXgDILkyHtCkZIMjy30RrKty8LZV5AJbqd458QmNaKch1p15b5jVzs8/b44+vIFpolWoTve0jMGBiGpXm23+19PM6C2eqPREt0IPWCXZOzV2vY5TPh5oBWn+D2gYfLMgbHM69z7NgMETJp8OP8b2z17flA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sObWBleM26XlRHBt5J4SMak3+y3gQjEogba0jvTT/g=;
 b=dNNzFPi4orHdCOifJWoCi871h3vU1U01MU6nw4fUvFvA2YRSkwVcLwOic3xR1Z2c0EtMFEfaya18pcSWLfHDfvh8f9XmG7eAwnCAl7ILkDSTLjTb2DTs6q36DD1dog89JOg5gefjjJMODiVrQ2cD1JZET4oSi5XCo5BX6aeN0IQfNxvV9MA9JXD0QKyUpGD0zVVXxjhs93NLhr2ewi94Bogqli/bzhn00hMBL4VHIM0XX5BIu8810p1ye8n3QJBvqyz3UKqJZp8LwAhr4pikfklfPxekzc56yakbEmKrvjvLMnh1hDl+IXX34lahkHRY4bo6xOcebulzZXR3gGkhEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by JH0PR03MB8116.apcprd03.prod.outlook.com (2603:1096:990:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 06:47:51 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%4]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 06:47:51 +0000
Message-ID: <a1f548e3-ba3b-415a-9bde-9d96c93a8d8e@amlogic.com>
Date: Thu, 14 Aug 2025 14:47:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: add video clock indices for
 Amlogic S4 SoC
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
 <20250814-add_video_clk-v2-1-bb2b5a5f2904@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250814-add_video_clk-v2-1-bb2b5a5f2904@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|JH0PR03MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5ff9cb-bb23-4702-0ae3-08dddafe7d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1J3dUVlckQvSTZQbGFzYm1oa1dwQkViUnc5WEZhU0lvRjh0NGR2N2JtQ1FM?=
 =?utf-8?B?N3Npdmh3MmtTTk9CMEVNSHN2TE41K20rYUtZZ201dEUvTG9JYnpoRTNUbDF1?=
 =?utf-8?B?eWJlVk5hWDdmWHBzY1p2V0xRNld3L0liU0RDQmxBUURJa29lZGVQaEFNb21U?=
 =?utf-8?B?Uk9NNGJxU3d6Qm9ES2F1WnpuVjh6RkNacFRTNnZaVWVQZjlIT0dTc3V2MHNJ?=
 =?utf-8?B?b1M1MHBnTStBK0xhWW9CWkNWK3hnYndqdWg4VHZ6bzRubzhwenlZU1pwQmVh?=
 =?utf-8?B?ZWFRVUp1QitGNVF3Q2hjSzFpNTJVTzJpK3NtbGpaVHA2dlBkTElQOWJITFZt?=
 =?utf-8?B?QUpLUnBraGdUdFFEOXBQTFdyTFlSTHhYTlU1Q2tjM2hLdGkreHY3d0JrQTBZ?=
 =?utf-8?B?RktPZm5PeVVlUVZQVzdqNCtlS3FEK0hSbVR4bkZVUUhkcWwyMHBDUDJ4bW9K?=
 =?utf-8?B?RnVxMlY4dVdhMVJmdG9OVEZXbGtMekl1b2JFSXVROTJNbnBIVFA3akRTWUxP?=
 =?utf-8?B?Rzdoamh3MmZxa2dGNEszZ0F4NmRCVXZpeXR6VkhjRUFZOVppNGRzczBLUlF5?=
 =?utf-8?B?MGlEUzNic1RVcmV5dXZDNDJqa2dDQUI1Z0NwNEg1QlJySDRxd2w3aG5RdWF3?=
 =?utf-8?B?MHJXd3VYWDFDRUxtRGc1MjFLeHRPVTVpUTFoOVhsbGdmMjd0ZWxYdkN0VmVs?=
 =?utf-8?B?Y084dkFDWUU3TUR2d2ZXZURkbmJ5SWZQeFNkd3VGakg4N050YmUzWWRiSmJW?=
 =?utf-8?B?VEkwQzlONFl1ZStTSVZCMmRteThqUmhOcHFPRXZiaWp4VzlUdEpzeHFLWmZ2?=
 =?utf-8?B?NzU5TmVJSGFTRGt4cDVTcURGMlFwUDcwZ2tvWHF3aUlSRlJ5YTBBWGtjeGpa?=
 =?utf-8?B?cmcyeFhFajhYdlNtSWtrMkgrTlJxNEJ2VjJiTTZRT2lCaG1pQTR5RzlXRUcy?=
 =?utf-8?B?R2J2WUl3Um1HUXdYeW4wTm04bWRVN2F6ZU1QTytJTmdscDVQUGY4cDRkVWVK?=
 =?utf-8?B?Ym1HQmJvSk9iTXVWdEFwOGNkZVZKMkJQdVk1V3FXcDJSaWZ3Z09yZE1DVEUz?=
 =?utf-8?B?ME5hWVhIbkJ2TGs4R1JBa3J6aDByOWdBWU03N0dkdERxLzhhV0x0S2JvMFNS?=
 =?utf-8?B?T3BZVFM5RkFjOWtsS0s3Z2RiaXJWeVdjQzVLUlFVNnhXaFRqTTNqUEhJM2Jh?=
 =?utf-8?B?ZWJMdHV1aWRlTFVRVGU0c2lSUVh2K01qQTUyMy9sTTYzR29sRXhGNVZuQmtV?=
 =?utf-8?B?dlJ4TWRhT0ptdXh3dEFmUlBKSFByMkp4YVJZS0pCbHZGMXdMa25tdGxUNE9M?=
 =?utf-8?B?a21MT0ZqN2RQUElzcUJ3OGRVZTZURE1ZNTBPWjZhd1FFVFFscFF1QlZkTDVt?=
 =?utf-8?B?dlJVVnlYWHdrKzR6MTJsYVY0UGU5K1djUFpqZ2xLRCsyRy83Q2RzVk9JRkJK?=
 =?utf-8?B?bWxYdU5sR00rVDN5Vmx4NDh0ZWpNcUtjYks1dHJubzFacVoxS2J1TDBDTG5L?=
 =?utf-8?B?TDJEYWRUMmhNTDdaV2Zxa2R2N044dGU4bU1kaEc2VG1GbWZaWi9PZDEyZlRR?=
 =?utf-8?B?bmRvaGVCa2FBUjczUEtkeStyZDJEY2o3TDVyN2NmZU5jVzc2eTVjUk1zNnNu?=
 =?utf-8?B?aGZvSGh0L0RQcGZHQkxUZVlDUDV5VmFlcHNyc2U4RUhlaS9QbVNYMnA5OGVr?=
 =?utf-8?B?SFY2eFBlajdWK3VPWkxPMEJaeHRuQ3BZMFdNOVdjNU40dzVUWENCNDdKUC9J?=
 =?utf-8?B?QVFYeFNnTGhQcVZNZExIb2p5Q2laRGY3eG9pOFd5R1hjc2owc1FBM0JvOUVE?=
 =?utf-8?B?YStCRktXK1hrV3ZGeWo0elZscElYeDRFcHVVeGF4U3hkaVc4ZU1rZXp6dk4v?=
 =?utf-8?B?OEV5QVdDbi9LSjFtZ0NYdDhRWDJ0NGl4Vk1JTmZ0VWx1NkhjNnUyelpOMzQw?=
 =?utf-8?Q?qAylsonboCU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZoQ2tVTTlyNUVmbnkrMGNaWDdrOVdJM2crcWZUL3JVL1B6VTQrNnVPOUdV?=
 =?utf-8?B?ZVF2RVBGbkkwbDE1Zkl5YnVjVE13K212TjFJZW5OL2hKRmszNmtRUlpXYk1t?=
 =?utf-8?B?MDZLTERQMm9BOE5TbkprM1RFQ0NDOG9icEdybW1Gb2xERVdaZzZ3UjBFZ3Zy?=
 =?utf-8?B?U0J3K2RoV0Y2RnZMWG9QaWM1ZXhueHRKTHI4am5RSzRpWXhaSXdQZ3F0MUdK?=
 =?utf-8?B?NmVGbXl3OWphTU5Td2NZMjJoVVcwYzF3NnJwckRCeWVJeGNTZDRLM0R4SFVK?=
 =?utf-8?B?ZUg1c3BlVFAyUXJ1R2cwbzdnTUpPQVMwRnN6c3VlUkFGd3krdXl3a1JneFZy?=
 =?utf-8?B?Vkszc253Tm8wcW9pWnZnZ3JkRkY0dnBDM1lYRW0vdkdwT0RWbjQ0VlpyZDk0?=
 =?utf-8?B?MVVNbWIzMjhwd1VZdXdpRU40MUxFayt3UFhnQWZmYktEOGRyOWtGSTZ3Zzcr?=
 =?utf-8?B?K21uMlVzalpHQ0lWbXRSSC9NWHQyWHpRM01mZ21ZZHZrdHQzMDNQY2lYd0w4?=
 =?utf-8?B?NlhOclhGRGZ2NjZpODJJUU8yU1BVakU1TW12VlVvTmMxS1l5cnBhU0QycVlU?=
 =?utf-8?B?bFF1a25zZ3J6Zmk3OXB1cEd1dFl0Qk9YakgzOFlDNnRHQldWQzdUL0xZUzlJ?=
 =?utf-8?B?M1BmTGxBYzFsUDFKWEV3eWZrRnJnaWNjYnJKa2pLbUcyNWVsaEIvaStBY3VB?=
 =?utf-8?B?b0s4eTB0b1BQQXR4ZUQ4OTVXUGJYMlEzRk9WS0hYTm9hdmtnUmcvYWRDNHFR?=
 =?utf-8?B?dzJQOFdjRkNHN2g3azhYL3UvdWk2b1hWMDhKN0FWTjZJUi8yTGkvd1pSb0o2?=
 =?utf-8?B?K3hFc09OS3A3dm1YYzBQNHZBQmJodHRBZFAvVjBRWFZLaXFqNStnSXkrMUx2?=
 =?utf-8?B?YllYVHlMVlVDejljOTd1OVdQSXZvbDNzVzlPckJJM0hremROYkcxalFteVlo?=
 =?utf-8?B?K0djZnhJZk1GY0JFRjI2UFFPZnBleTE2ZDZBYldwck5CMmR3aW5ZRzhKeEEv?=
 =?utf-8?B?WlJya05ZOUh1OENSeXJmTFNhOE1nK2tBMUhCemNpdnJEdDNvb2Jyd3pLSnhH?=
 =?utf-8?B?UmZ3WUF5U2R5UjQwZDRkdnkveGVrQ1VTMEtZSXhNN2JhVDBGWTJJRWVKQVhq?=
 =?utf-8?B?MlBWeGxjQzN0em9jYWVMUzJPbU9HK0JQTktRZ3ozRVlLcHc1Yk01bUFnKzlt?=
 =?utf-8?B?Skcyb29STTJQWkxGVC94WWxLVjZGVmRScnJmT0x1RUlqQS9FeGFWa2dTV2Na?=
 =?utf-8?B?TDVjZWRRUThXSXpqMksvWnZvS0xwNlE4YWxTbERDUS9BUkMyUzlsMVlZSjBT?=
 =?utf-8?B?amE2ekg5VkZyWUpmb0grODh2azhWYnp2Ym1EeXk4N2VLVkNIOTdsc0tZcmFo?=
 =?utf-8?B?ZDFXOHhjbVZEV0lQb0o3Z3FxSU1VRHF1NDRSdm5FUG1TN2hCaENBdHQ5V3dj?=
 =?utf-8?B?bXgybzVzclMzUGNGZUJQYmgwbFlkVEZhclg3aUFKTkZVR0ZQZlRSb2VDekVB?=
 =?utf-8?B?SW85Z2VBNlVwSUl4ODJkeVpESmpiT2c2ZkNLb0xWbzF1emtjZ3Nhck1sVE5Z?=
 =?utf-8?B?NDhsbnlSZGZuaW1IQ3FYOHhiRXBXbDNUMHBzMmFNOGZEWFFmL082enFiYUlq?=
 =?utf-8?B?cWZ3V3lxRG5BeGMzOXJoU2pSSWZuUVFEZmdadHBkRlk5VEZmcmxPYmpvR25r?=
 =?utf-8?B?QXdKN0hsMmNETFJveUppQVJkeFBhbFdPWUI0MTYzTHRCazdTOFhTUHg5RUg1?=
 =?utf-8?B?VTFBcDRBSHFmcDFhWklUZGdOL1lNMXpsRlNyYlhrT0F4Y0xXdkNFdGg3aGsy?=
 =?utf-8?B?ZG9Hc2QwQUs4Q2Nmd0VDM1k3a3RsS0hrbzNEdi85ZWYwREo0R0E1YUVEQ0lK?=
 =?utf-8?B?TlZsWm83UGJPL2JZbnZBQ2hXVVpPNE5nbXVTNi9xQUJOVlM2SElkNFA2WDZT?=
 =?utf-8?B?RUVkVk5ScXRCNUtPbnUwazN4d3U4NC9xQkh2N1dSa3pRckIrYTN4TkZkb0ZN?=
 =?utf-8?B?TG9IYTJKVERqR21KM0FSZHBRZmlpM3ZXTGRydFZWaTYzOW9TQTZBcFlPVTdu?=
 =?utf-8?B?ejZBY1BhY0NkSXBmdCtHdGQ2UTdCVWt5NU93aHFqd3NybnNFQ0ZKRTdMWXZH?=
 =?utf-8?Q?s6YrUXyWeACM1rrBMBtFX2akE?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5ff9cb-bb23-4702-0ae3-08dddafe7d32
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:47:51.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14UmC8777y27KOhNM3c9hm8T7b7/Tkth8LEqcfqUcVl+swpSonvg1FSdNdYzjDRK2YZrmd0Omqbkbkxccv2i+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8116

Hi Rob:

On 8/14/2025 2:32 PM, Chuan Liu via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add indices for video encoder, demodulator and CVBS clocks.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>


Compared to the previous version, some clkids have been removed. Since I'm
uncertain whether your Acked-by still applies, I've removed your tag in this
revision. Apologies if this causes any inconvenience.


> ---
>   include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> index 861a331963ac..b0fc549f53e3 100644
> --- a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> @@ -232,5 +232,16 @@
>   #define CLKID_HDCP22_SKPCLK_SEL                222
>   #define CLKID_HDCP22_SKPCLK_DIV                223
>   #define CLKID_HDCP22_SKPCLK            224
> +#define CLKID_CTS_ENCL_SEL             225
> +#define CLKID_CTS_ENCL                 226
> +#define CLKID_CDAC_SEL                 227
> +#define CLKID_CDAC_DIV                 228
> +#define CLKID_CDAC                     229
> +#define CLKID_DEMOD_CORE_SEL           230
> +#define CLKID_DEMOD_CORE_DIV           231
> +#define CLKID_DEMOD_CORE               232
> +#define CLKID_ADC_EXTCLK_IN_SEL                233
> +#define CLKID_ADC_EXTCLK_IN_DIV                234
> +#define CLKID_ADC_EXTCLK_IN            235
>
>   #endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
>
> --
> 2.42.0
>
>

