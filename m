Return-Path: <linux-kernel+bounces-824637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B032FB89BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684567BC0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FA24167A;
	Fri, 19 Sep 2025 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b="OmL6l6Aa"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013067.outbound.protection.outlook.com [52.103.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA22226D04;
	Fri, 19 Sep 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289868; cv=fail; b=JFQLtbGoxNVDMyzH+J8gY5O1kOAfIsOjXHwq5pkxiqWxRCJvDdP3lOYwusG+Dii6g2Rms2nX49HC6h8SnDWSe4DszquMNTMEb8iruvzPyx4mcPdbxHsebNU5SbOaMtSmvmm6FO7BWENPEmtyMtfFh6hR0kft9gZi3NXXjlZ5uoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289868; c=relaxed/simple;
	bh=KVEq7i33FADJWvyQ3/L7CpDT1R1bDmsVXAE3e/xN7ys=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MN7CVOftaiePuhsLprY+zwgtP+6DlWnyqTpV1iqEILyvTLaVqKruvQ6j7uIsj0eZAVZHD9rUILQO++dQx+YC/E5MtgxNdZcab6JuZqLW43iTD+lQps9wQaJe57YJ6UK3i3vGCK5IMXPkwpaZhV3szLE8QXkAMsax20cAxUwBYBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca; spf=pass smtp.mailfrom=live.ca; dkim=pass (2048-bit key) header.d=LIVE.CA header.i=@LIVE.CA header.b=OmL6l6Aa; arc=fail smtp.client-ip=52.103.20.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.ca
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWJGkE+50gwqkc6hg6NbetAz97LvPDEuOIMmElFWu8CBpdMCs9gXrS7Se2l/+RvLk7qIA8zTO5P5bWZgczNdMxn6FAlvLJZXZKthrM7Z2Rw2c2gZiSh6xOSiKdeAU1vZlkNg0Dc47koR77hhDE9YoLF0uVhP7LdjHIqeFhoTgspUh89PACFE27jsn/L2oC3bQ3a4WPmAiUt0YLErEh/g46d9HAplnsMZVtP9A8eW8r9JEUvYcJ2tpzc8PNL48LksoJSbkaUSpq5HQH0TxAO3YfLbrZ6+OCyBh8XW0hDuXJGk0RWOXZ0qAYVgRJOVHH+OA9vwMMILPE8FVfH0yUL00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ocVy69Za4nolbHl+QMW6RGiZ4Ho33m5KD0JHKLYsI0=;
 b=dG0+UIvhiGXbC0a20PmDNMb3lRnKVFARtgMpdkNIwqZahl85vuTKuTNS7UvoAjIE7Vg0z2e6xfJeT+giHY5+yLJjMjFdochc2bOYc49c7x+rxHqIuAJ82Yxn9TDybbzJykM2LeVa8tz+P5oLEBuR3jbmC0vkxuMoIihoh2ZdCMWOtl+Lpbbw8PhBUtdKNDy6e8/E5+2oJgkIn2BnMXImkpLbur0KuA47pK9Go6TsZag9CVpPky8DXh1IOcSGpil4Db7xnhTFPFkKik6/ZdgGyE+DH9C72gFgQI0f1CbqA4KM17gdfGvUcDR9/B2SVRJQ4iY1LswEnutkI7J4YjeOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CA; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ocVy69Za4nolbHl+QMW6RGiZ4Ho33m5KD0JHKLYsI0=;
 b=OmL6l6Aau4RUsj+HJVtEtixtM9SxE+AOmEwjIsg08DWUN8gIFstFwsdqVY99fSybwxLmGQKgjGy6kAKZQNW22XGwc28V4fhw5EoASoRt87LmVEKBr2VEW1DZPOd3LmojMs3s0vd0FgfXj3eKPsso7SX/shIVQ/YQve4S4qReM8neMnCxc/gWfPLodrnVDFeqVdhIe3UWyWQoSqUsr6zZJuOPvAFppQujbMqjfZ3grxkwIi+wRmvti1RTTtme8b6Y71nj5bmKnY4VjZnPEzOcq2biXRU8iDlwsyx76kOIqQu023mjhOHVpxJPULUpESxPCh+Qd3YO3MKlrh6yyFdrxw==
Received: from MN2PR06MB5598.namprd06.prod.outlook.com (2603:10b6:208:c3::13)
 by MW5PR06MB9008.namprd06.prod.outlook.com (2603:10b6:303:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 13:51:04 +0000
Received: from MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4]) by MN2PR06MB5598.namprd06.prod.outlook.com
 ([fe80::96f9:fd1e:4b7c:17f4%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 13:51:03 +0000
Message-ID:
 <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
Date: Fri, 19 Sep 2025 09:50:46 -0400
User-Agent: Mozilla Thunderbird
From: Daniel <dany97@live.ca>
Subject: Re: [PATCH v3] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
To: ilpo.jarvinen@linux.intel.com
Cc: Markus.Elfring@web.de, hansg@kernel.org, linux-kernel@vger.kernel.org,
 matan@svgalib.org, platform-driver-x86@vger.kernel.org
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
Content-Language: en-US
In-Reply-To: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To MN2PR06MB5598.namprd06.prod.outlook.com
 (2603:10b6:208:c3::13)
X-Microsoft-Original-Message-ID:
 <1f851251-899b-4d78-940c-e934c9cc361a@live.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR06MB5598:EE_|MW5PR06MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 758da53a-a1c1-431d-748c-08ddf7839084
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|41001999006|5072599009|23021999003|19110799012|6090799003|8022599003|461199028|8060799015|440099028|3412199025|12091999003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZUY2FUcldqLzdqK0plSjE5L3RXeWt4YXU4VDVPTktpRVQyT2NzdnE4S2hw?=
 =?utf-8?B?UkpxK0JqQnl4czBHMGJwaGk3S1pmcWJvSVhDUjBMcVovVG95OW85TGxzUjht?=
 =?utf-8?B?dndqRGJGVFJ6bkt0WFpLcVFKVzQvUk04Yk45THRzTGZ3VzJyQU1YMWE2VERQ?=
 =?utf-8?B?VitPOEsxdWRad0UxS0ZjMHdjYWxSY1Q4VFhFWktzWHp1ZVNvVk1DM1h5dzNI?=
 =?utf-8?B?NnVqTXcyU3FMcDFUYmM3c1U3TnFFRnpOeUlRdHpERGlwbVFWZHNNMWZwdkpF?=
 =?utf-8?B?amZzcnV1Z1kzRzUvT29LUmFmWDVPRFoybU1WUXhLeHlqcVVHKzdtZnpwM2Rr?=
 =?utf-8?B?MERhWDh5bUZsaEFvOUFmWE8yekUxVTlRYTc1ZU5ZRG1XVE9XWnFIeElNOTdv?=
 =?utf-8?B?ZThKWTNZU25Gc0liMUo2d2liTEd6MUZXZFlMVW9KZDcybHAwRVQyeHF0aGk3?=
 =?utf-8?B?UHNLRVROSE9pNEcwY3habU5JUldYMm5oZytzc3ZuQjdhNTViY1VCaUVSU0pR?=
 =?utf-8?B?MkZBR09ESUc3RjZFd0J6YXBUZ0Rmbm8wQ0lEK2RrS3JiQWhvamd5TnMyQzMw?=
 =?utf-8?B?UWt0SHhuWUgvbnhqbVVaUWVqVWZKVzRtZElIWHVod0xMQStVVkwxenVIQUZk?=
 =?utf-8?B?NUVRT2kzSjVza3FKU2FGcTYxdEdYdnJoV0lmVzlyeWNpTTRaL0dTODVOb0Rr?=
 =?utf-8?B?dk9sREh0UW9Ydi92ZDZBVzlaMDBhMzZDTU1BR2tLUlIzNUtoRitKVFFyV1Fr?=
 =?utf-8?B?TUh2bTE2Wmt2SGl2Ly9IdzU1OE9HMFRTakZJZE9BRlI5M1h5Qm1kZTZYTE1j?=
 =?utf-8?B?QUpBMWRjOEFtdTN2VldXMnNJRS93ekcxR0FRbXdlMHRqbllXeTRFNUlTWmRm?=
 =?utf-8?B?c0k2RWlmN05uV0lkWnlqeEF0RE91Yjk3c0haTExPU1VaRXV5dWh2ZDlQL1ox?=
 =?utf-8?B?cW11b0owTVRDdUp5WHdUYnJwSGlFajFqR3B3dWc0OHRsYWVvWkNqb0RJUFVL?=
 =?utf-8?B?S1hlTjVraVlnZmZaWVpFQmRaZyszNzcvaDYxSklpUzRuQUlRMnpGaGUvUklF?=
 =?utf-8?B?dk16NndBQ2hJdVRpQmw5TU04M0VQY2FoZHd0UzNuMXNGZWFHSmw1K2xlTWw2?=
 =?utf-8?B?RTNVMGNDWjJQOVdWQWpSL25lM0hTU3AyZ0pRa2M4VU1oeVhGSDBvSmRpYUl3?=
 =?utf-8?B?ekxObUswckV3bFd2cWFNamxNUVBzZFVXdVQxZkRvRGpiZlN6cnRKSGMzbGth?=
 =?utf-8?B?bkpXQ0IzSEJiSEMzbDR3TThIc1dDemhMWDNkQVFhcytrU3A4SGFLZ0tuZWtH?=
 =?utf-8?B?aFJIZkcrSGZlNWkxSVBIZDhzazRya3lXVGlLYllQV2crTnNHc21NR0pLRmRm?=
 =?utf-8?B?VEl5azBIdWgrZDRlbW9KNGpMOVV6UDFDa29wU0FvMXZ0emJGR0RuTDdDU0M5?=
 =?utf-8?B?VUZzd2R2QUtIOVE1c2cwelRodHN6c0RleG44SEh3ZnVWcml0aVQ2NUduL2J4?=
 =?utf-8?B?L2RZbWN1MUh0b1ZFMW1hcjIvWW1UaHNnTkFrY1B0cXo4UU1walhQR0RKdGlK?=
 =?utf-8?B?OEVRZ09DajFZUGVhano3VDgxQnpVVHV4cCtGU1JoTzB5Y2lUNDY1b3VBbGNy?=
 =?utf-8?B?Q2VhRHNDUmFSTE5pczdJZGszWVRyOXhSZUFqWThTQVBIWW5aalpzNzlzU3Zn?=
 =?utf-8?B?NFdmaHpIb1JNK1Z2azg4UGNXTExjSHZsVmtwaVd1ZXY0VlN2djFJZHRnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ynh6NGZRaEM4YnY5YmxjK2xJSFZtUzlYbjJVMndtdWZ1YUI4Zkk3RlZsM3VV?=
 =?utf-8?B?RWp0SHRWQ1ZWSW9Gak9GWEs2VmVpK0Y2b2trUWM5dVBRakRZK25Ha1Evd21J?=
 =?utf-8?B?WkFzNUI5SHd5bWtZVDhBbWI1ZjZHNTdqMlFUYkl2V25CNUJvZkFBWGwybk0r?=
 =?utf-8?B?dllsOXBHTVpSQy85cFRrNDYrNzhnNkVMNlFlaS96ZlM5Z2pYb2lSTjRSUmZW?=
 =?utf-8?B?dlNhOXFvV2pjS0s4ZFRFSXZzcFJtMkVsdS9BTFllYUg5VW1GNFZ1VjFIdThn?=
 =?utf-8?B?N1VzSEdmZ0xaU21EL1htYzBCSVFlM1AvNDVMT1VKTnh2TGFZTmdjM3JQeXpl?=
 =?utf-8?B?QzQxd3czY2RqM2ZXRFYrYkJYdDRIbm9aekxOZWpBbjdKVytWNGxTdGlTL3Qr?=
 =?utf-8?B?TllXYkI1cGNYVlJHZTdQcWd0S09RQnppKzFaZVBZYWhNdzBFY0NubUFGRUNS?=
 =?utf-8?B?OUNEQ2VRY1BLNkx6dmNraFpQYVdOV2J4d3NSTEJwQ2NHME4rTHpLUExSU1g4?=
 =?utf-8?B?OUMvZldPbDBMYzVOVk1JMXNvWWdJK2x2b3ZZV0VhSXhGdFhSN0dtMzFHK1BU?=
 =?utf-8?B?TWJtTXlGczg0T0xobkd5WjgvSTlVZjlXRkxSd09IaVcyMmg0Q3I2MXdHWkVm?=
 =?utf-8?B?NG12NmFaR3FHTXlxT0hoTVNVQlZ4cUFFZkJEOFBmQUV2WXo1ZE8xRHpGaFJn?=
 =?utf-8?B?T0ltb05tbUhKdWFtMnZIN3FtQm95K1Y1OUthaUFvYTM4eGpBTjdBUXhQTlVy?=
 =?utf-8?B?ayt1UzBBMnBOM3JRd1BUY0xhN3BYT0k4Z1RGN0VuNHF1WGpZVkErd1R0bXJn?=
 =?utf-8?B?QnZoRWNHQWNvV1FJLzUxa0tvMDY3RWM3c010Wk8va0Q1LzlrQnpzcU1zKy9G?=
 =?utf-8?B?ZjltVXlUd1N6U1A1MWp4ZU1uMG1jQk9xNjVoZTREYkhGckdOWmxwY0dldWdY?=
 =?utf-8?B?OTk5RVkzMTBuSVVEYXREdnBuR05RejJHd2Jod0hJakhGNEU3ZnpiK0dwbDF6?=
 =?utf-8?B?T1d4QW1Ha3NuazhhcHUyTkZXKzZ5Z1hMRkdUNytjVHRLTm8xT3ViZWJycG1a?=
 =?utf-8?B?MzhFNkVMZDY2Z1VMRlZ5eGc1OEg0UWlpRW1Vd1pUNHkvcmkxSk5wQnBGa3BG?=
 =?utf-8?B?RGdSdGhQeHVsbG9mQVNySWtHWDAzK2lnYkJLLzI0ZmRPeHRYcHEvVXRGMlFr?=
 =?utf-8?B?NnRmNFRENTBKUWdqRDVwZmdibFNpL0xPQzVEVFNJaHJYYmY1dVdFMUhMSWF1?=
 =?utf-8?B?ZHFqN0FpcDkxV2E3b3JZRGZMZys3ak1ENjh4aTMyZndmVDZBUUZORUd4MXB0?=
 =?utf-8?B?elUwUUNpYlB3STNkZFY5c2FkTVIzMFAvSDdyV2dzMHNyRm9IYSsycTgrLys2?=
 =?utf-8?B?STR5eHE2SXR5L0E0K3JTbndnNXRsaXlBV085clZyaUJZdEhabVNtTndaYTd3?=
 =?utf-8?B?L0k1Q3JRS3JRcTBBMExzSlVKandjMnRVOE9kL2ZvbU95b2ZZSldYNkhKRktn?=
 =?utf-8?B?OUczWmx1MkJKbzFWblhna3YwblRiOEpWU2x2STF2UWdkYmtaODhBd05TdFdo?=
 =?utf-8?B?Ni9jS0RzN2JQc0tsTTRPWklmcTYxc0JXUWVmdWY0cGpoaFdmcFJ3a1ljNUUx?=
 =?utf-8?B?SWJqaXkwYnY1T0lYNXdhUHdQTWRKUUE9PQ==?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-a1430.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 758da53a-a1c1-431d-748c-08ddf7839084
X-MS-Exchange-CrossTenant-AuthSource: MN2PR06MB5598.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:51:03.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR06MB9008

> Is it good to reuse the input side define here for response side or
> should you have another with a more specific name? (This is put to
> status named variable so my natural expectation is that the field's
> name is somehow related to that.)

The fan mode really is sent back to us in *_LOWER and *_UPPER form,
exactly like how we send the fan mode.  (Only, the lower and upper
portions are guaranteed to be identical, so we just read the lower.)
Hence why I did not add a new define for the response side.

Should I add another define FAN_MODE_RESPONSE?

-- >8 --
Subject: [PATCH v4] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
/sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
report a status of 0.

Disassembling the relevant ACPI tables reveals that in the WMAB call to
set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
(depending on the value of some other EC register).  Thus when we call
WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
call undoes the effect of the first call.

Fix this by calling WMAB once, with the mode set in bits 0,1 and 4,5.
When the fan mode is returned from WMAB it always has this form, so
there is no need to preserve the other bits.  As a bonus, the driver
now supports the "Performance" fan mode seen in the LG-provided Windows
control app, which provides less aggressive CPU throttling but louder
fan noise and shorter battery life.

I can confirm with this patch reading/writing the fan mode now works
as expected on my laptop, although I have not tested it on any other
LG laptop.

Also, correct the documentation to reflect that 0 corresponds to the
default mode (what the Windows app calls "Optimal") and 1 corresponds
to the silent mode.

Signed-off-by: Daniel Lee <dany97@live.ca>
Tested-by: Daniel Lee <dany97@live.ca>
Fixes: dbf0c5a6b1f8e7bec5e17baa60a1e04c28d90f9b ("platform/x86: Add LG Gram laptop special features driver")
---
V1 -> V2: Replace bitops with GENMASK() and FIELD_PREP()
V2 -> V3: Add parentheses next to function name in summary line
          Use full name in signoff
V3 -> V4: Add include for linux/bitfield.h
          Remove "FIELD" from bitmask macro names

 .../admin-guide/laptops/lg-laptop.rst         |  4 +--
 drivers/platform/x86/lg-laptop.c              | 30 ++++++++-----------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932c..c4dd534f9 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7..0ef179f7a 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
@@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_LOWER GENMASK(1, 0)
+#define FAN_MODE_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_LOWER, value) |
+		FIELD_PREP(FAN_MODE_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -317,7 +311,7 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	status = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
 	kfree(r);
 
 	return sysfs_emit(buffer, "%d\n", status);
-- 
2.51.0

