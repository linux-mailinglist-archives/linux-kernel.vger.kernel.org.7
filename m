Return-Path: <linux-kernel+bounces-769920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26F4B274F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92DD5805E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BB29B224;
	Fri, 15 Aug 2025 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="pbdHYN52"
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010014.outbound.protection.outlook.com [52.103.73.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144A29614F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222838; cv=fail; b=OxPjXVl9OOo2ZGGroylf7O55uFzjzmdcRqiezD7cUrjGS06I8ONm3+oVRh+EygikORw0Q3nGDFH0O8Qkb6b1kIqWz7y34fjm9jTevnV/FBMYQco5vGr4EjLBC97PyImRRVmYcr7AyKCVBlU4EQwYmw0KYcvvmPP6f5MNap+F6F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222838; c=relaxed/simple;
	bh=wCVQZKQxExW/gk/UqJq/b0C3w+RrhM4efCaPYKwXhgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3wjECajYVQ/cifO/vj8mC9GoQ1fQB9zKlkXl3x1kUbu0uCgsft5T3VzjPIFszXJbKum832xhzncGM9vW86aQxpc8LzyzB3m1TEEuKkXKKNIrHm7YG1zmjuD8IvnRAHiyZgB10Ysh+7W9OjTa7/1IFCXkjJvSYZNa7Lhrm03Tgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=pbdHYN52; arc=fail smtp.client-ip=52.103.73.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFtApilcb77QaMpb33Nn5QBo6vnulTnhGrk5f7jPWrd8N/BoMqg9Qve9NNylDqlceSbK5NqyzM6T8kmK15NRTc5vCLDR/v7QD+zwbaLmAvndktD8DKdCJ8Fb2PETVISbZ9z5ww0rKEyiTrkhDfWtIe967diAugWMJ0veeR3NE5qi0G3tKOZ/nUSd1jg6j0FKRuiBnN+PvoM976sAM+KqS2vXyT1YneVyzwBA+o/73Xy0PloyKyRXKW1TCZyLKtXdq8ahsUuAHSo+yA9CDtz01aRdsx0bu8bfYQDdnpr1GCWjtMQ48ILvEWgU+SEX4WpkUDpD8BuVpRfMwqHMAtU2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFspAiaVbKkycfYHHPUCKzMqbjkCCGVyYNuSyA1dRdY=;
 b=M/LAAXxFG6Sj9aTs7oUNAosNne1rkoz0zY/pNYlIfGxylx/zsPREM8yp+jSVXmfa32AHowTIGxltB13GCrGi3rb83IxBUt6c/nnyjgwpR4qAREDM0P4pWBrlNmWn5vUYR/IUnkAEuvm+UO9JPB8KkC64Yo9xecNbORlPQWkD2Xldy/iI6irSgbojtzAERmAc0dAsi4ZPeQ7k+r8QX/CzxFRff73QnsXe63Mg+wnHRIgooP4FP6Tod7eIRZIZEgBVSg83tXzhb8V9Tp+e/buhmjagSpBbGZb8kA7YX5iti8aks+LM8rn8pwL4VS+4xsQ6+/ocpIuhPc+AHP9k84n7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFspAiaVbKkycfYHHPUCKzMqbjkCCGVyYNuSyA1dRdY=;
 b=pbdHYN52lhAOguR0ncnRRO4J7DDWA+q04HJ8WwfrAi9L+fbj6vYOOV7oCwFQzeHL6+GLSsaLW4Uuf54vFDhu4YY83VeOnHaajSSPC4QwJbDPUPObnU/aEE1k8dTI4IWt0QD6Vf9S8j1kauMhl+Vfuv+rdWBZQRbpGavC1HLEbiXJrr/Bnof7tMg6/5vaJf2qhk4eXGphaiFDAt2scs4vCkH7148RfIvVYERB/c7bc6+kOQL77N2lr3jGlO78/OnMNLjTJHwjBmgtdsmEB+jxI7t6lSs26wva1VYtedaMrGhEKIAC+JAzpYoIMnY/CktJbPOEdNLGuwP3k5oYsyJmmA==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY7P282MB5598.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2c6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Fri, 15 Aug 2025 01:53:52 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 01:53:52 +0000
Message-ID:
 <SY4P282MB30630DE6D63A24ED9BF3E30EC534A@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Fri, 15 Aug 2025 11:53:51 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250813112020.345622-1-s.horvath@outlook.com.au>
 <20250814152550.GAaJ3__hIHnOBhKGWN@fat_crate.local>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <20250814152550.GAaJ3__hIHnOBhKGWN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::6) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <1edebd42-a88c-436f-9fcc-da9e4c9fcac3@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY7P282MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c4ecd9-89a7-4c02-d26e-08dddb9e95ed
X-MS-Exchange-SLBlob-MailProps:
	xgbIMsDSu2ZT1y/65awFWm7XKXdH+3USJ03G4quN2Xalt/1XsYRZCPbYsVlUVpQWnY1o5Mfj8UzYiTwBPtsaArXNeYxR0+gHjf74PoHuGZ/2jQSKENzRUnlTDtFKnzBt9RjYw+wjQDB0eCBZrW59mI829VMvyLoH7RZ7LDBHYEjBAw6swXeXY6eH/WIIAsgpLUNGHEIWynJdMfN/ICuyrXRoF6OfXaP5gpXV5D/vz6a0uSLNAv7Kl1Y8BQK2Zut1JYxagt/aYzA7ctWj/p8+A7jWGy56R7LEleZrugdhP0wWTAlSkfB5Y94hTT5cfjnv7onYuUPXi2jYFK/69cIeQiq0iXIMZ1HeHqK1qnH2WZbdspbBTu5yNIrYrPeA4+UGx3W4doKwDtx+1B9qNNYaNea4C79DkJBPN2hzIBmP21c60PSHxKGNUWYZhZWB77QzZMu72lb6k+VBDylSbZ5RiKEb8fGk09/wO4fvAghf7p+dE9gRjvlkqsP8pDQMAzsltMRfFRWLgfndA2FFxXHuRM2p5fc3VUeNCtgFq4sLIhqMvlHK6WaE0kI8wDJI+fjacaDWANs77hUMZoTROyCwoxCbX/VQWdp68CmWy2zaQmKP9q04l/D/04DaZrlS8DAo9AQYth0soq6mHGJlTC42fr4Ljl3xn7ed8rCH3vKUh75aWyCqRDcRbtwYFCn+z48MAjbMULx6XOxcRU/2yk4tYk2b+Z55fhjmmSEWGloJGo6W+EnF7vz6d3x3JUQg4EiO96UXYVkCbeR5Ojj8gVuZ4FenSkON7+mS
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|8060799015|5072599009|19110799012|23021999003|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1hhUkM4ekhRZ3lubjJiTm0zYXF5SGxmKzRRUzF3LzF3R0NZNG9KaTZjNVVm?=
 =?utf-8?B?Q1JjaU5HL2YydGw4aHdwTTQ1U3lqYVFkQkEva3U2dWg4bFFkclE3M3dkWmZy?=
 =?utf-8?B?RWh5am15S0pCYnBKdTRYTm9JaDJYbVozUm5ma2kvdktzWE5zb2UzcnVtaUJI?=
 =?utf-8?B?QUlxN1pJbERuRGNHN3NYR25QWnh6U0VaTDVOWnhDblJPU3pPbk5SWlhhTTc5?=
 =?utf-8?B?QVZDY0JUTTVESmJNbFQxdU5VRTZOWmZBVEt0ZXVna3NBZ1NEMnJ0MlRUNndD?=
 =?utf-8?B?d1MwUWRWTjZVeXFpWG5hV0QrVlRscnU3WXFGZ0VNNHNJUGxpRjdrM0VkOXdw?=
 =?utf-8?B?Q2UvcVhTWm1nV2NwQ1d2Si9VRmtzNkdaSjR2QzFtL2x1UEhVbm9XOTg3cldE?=
 =?utf-8?B?dVNxbGdKaFI4alVsVGl5WjRjWExFaWJKa3dzdW1LTytEcXpaN0FSR2pUeVdS?=
 =?utf-8?B?cTRic2tsT3hDRFhDUjU5WDFFN2c1RmRIZitRVGhMS3RROFQ2N0V0Q3RTbTZk?=
 =?utf-8?B?VVFsM3NjNEhaWDZEbmNIbGJjTWR3dkx5amxzRlM5dXlFK3N4UFlnR3p6aHJ1?=
 =?utf-8?B?WGJhdytWU0xybVpPaklBTzA1dCs0ZXZZREpiMEp1TnRQcFZEZ3hiM1FpZlZz?=
 =?utf-8?B?UmhXbjhhOTRCMk4yM01JVmxiZkFOSHNQeE5sRUN1N3VuYi9XQzZCaUVleXhw?=
 =?utf-8?B?d0Jzbko3SkZrZi9Ia3NZandKQ1NXeFZmUU9idzNxNUoyeXNJSXc0OXBTSmtH?=
 =?utf-8?B?T1M3cllTZ0ZPUjAzaHZkSGRpOGNCYm9IT09lV01GZ0swbjUvSGFxS1hJWk9i?=
 =?utf-8?B?ZEJ6aHFFZWp5UE96WTMxcytZTTRyMDdrWnp2b0pabElSRU1DV296V2Y0OEpE?=
 =?utf-8?B?ZlRkLy9VQVhPSDQ3NXdlT3U4ZitLbTQ1cWQwT2JISFk4aDhrU1BzRlRDZUZa?=
 =?utf-8?B?VzkxT3l0ZXE5Rmd5ejhOeTFNWkdqcTNuT1VsWVRHVFdtYlZSZlNkQldTV0Zo?=
 =?utf-8?B?WUg4OVV3dHlSN2xmQXlwaE9GVlZLYnVxbVkwL0hPY2ZIMUwzSEhtdXRtVU96?=
 =?utf-8?B?Uit1RVpsVkY5NEdFTTFXWW5tM3ZPNndkMVdzYnozRC8zaEV0cjBNam9ibnpV?=
 =?utf-8?B?aEFlNFF5OEZxOGFVelNLQVE0by9XbjgrWTEzdnhmcXJyVmE4SVFhbTZWOEhR?=
 =?utf-8?B?alVQUEVyTlE5QXhmZDVCWU9LLzhmd0FqNDM1THN5VmVDY3JQR0ZyMGRhcldN?=
 =?utf-8?B?dXlDZUpka0VFWkZudFVKOXhXa202VC9tS0hxTXV5VGs0Q2RhNmxmSGU5QUVw?=
 =?utf-8?B?MGZ0VHFzbVg1ZWV0d0Iza2VJRktQbjJhNTFiS2Jucnl3OG9xbE9HRUhIZXdo?=
 =?utf-8?B?UEdDbTVsNWl0a1ZmM2JiRkZiVEZsOWlkRERmRWFnMlJTeGR5V1RJZU9kUHo2?=
 =?utf-8?B?QXBOZUZiVWk5TVZXVzhrUG9xbFdNVlpqRWk2V0NUdEc4dzE0Y0pTcTZkdWl0?=
 =?utf-8?B?MkppQXJuejIwN3k3VGtTVVBrUzUveUZKeUdoVXRkYW16WFJqL1RYekdpSU85?=
 =?utf-8?Q?QAiYUrrez5hAQPueAeFqSquls=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnlWVEhQQ2g2RFlxR2VHQmI4bVJCN0xKbzZuRnVIdnpzWmxRdThsdHQ5dWVG?=
 =?utf-8?B?RTNjdWtrcUlQa3FVTXRiM1BRL2lib3RENVViL211NUgrOHpzcDVmM2RBQzYx?=
 =?utf-8?B?dmQ2T0JmTlB4ckJZYXQ3aUxubUJuSzFVQVBWcVJFSmFLUEdoRUNGWlFuclRQ?=
 =?utf-8?B?SU5wSjY2NFp6RE5Ya1FwVFFYMFpWTUpOVXg3a29lTE0yT1JxRFp5Tnd3cGQw?=
 =?utf-8?B?dDdzWnRnS1F4MGQwaklTek1aNjJmVEt5WGRXL1ZTcGpKZDA5Sm1raXR3RFFD?=
 =?utf-8?B?YnFhbTdWZnM0c3hab1hDNDNGaVZZdVgxMjVaTzc2dldtb2gvQUY5TWpjanpS?=
 =?utf-8?B?Uk5mc1BqNXJDTGFqMU5IYTBIUnNpeUYvamM2cXlCQzcyQ293VFc2dlVYYzFx?=
 =?utf-8?B?WXpxaGpNYlFGM2Urcm1mRFB4a2VQOS9ITXRWUHJNZWc0dGxma21WT2pDSHcw?=
 =?utf-8?B?NXYxOGpzemRTdm5kcGpPSDd1ZnZEdVRXbFNIczIrcVR4VThJQlZraEd2bzky?=
 =?utf-8?B?dEMza1RidTBkZDdWaFlZczh2ODhGYllpTmo3akNmOUhkc1VrQTBob2tkdFV4?=
 =?utf-8?B?MUV5VVFPR0xFdzdDSVlPSXV6UDlRcFJac3BoaEY5dGpQY2dOMEZxRmlyb3NF?=
 =?utf-8?B?eWtWeU00aU5UVGF6WW1QZkcyajBVcHlJOW9LVjlqak1yVVpKS0NKb244clcv?=
 =?utf-8?B?ZXZZakpIa0J4M1E5VE1MY3ZXUVg1UUVNS2diQ081aWN5bDFjQ0dlRmlzUmxW?=
 =?utf-8?B?ZHJwVVdtK3Q5K0taNE02bFU4aUZlV21aTS80NE03MmZ6TjM0OEh5YnJNN2Fn?=
 =?utf-8?B?VVpkOUdEbkhmZlpWZXR6SERrRzFnbEJpWnNzOXRLOFMrYTZRVENuK0h5UE9Q?=
 =?utf-8?B?OE1Xdzkwd1JBSFhmZWp5REdrSnRhN0YvNisvZ1ZrNlB1SHVVM1YzQzBJbHNF?=
 =?utf-8?B?QWIxRTRSQXdVS28rQUZmeEpsZERidXhtTGdvYTRMMGxvaGk5aDlaT3E4RTZZ?=
 =?utf-8?B?c0FzMEp1dFpCeU5Bc2ltVkNFeFRobmxVVmptNHA0V29LL3JYdnJwOHJqM3VX?=
 =?utf-8?B?M1RmbHhvN0dLRDdOTHdxanVEbWt0eFEyYkhKemVWZlJGZVN2TXlWenZmRkIw?=
 =?utf-8?B?MEhrUk50ZnlNYU5IV2xlY04yV3kyWU56bTJWR0RUWFlld2pwOGRLWnpXd2lK?=
 =?utf-8?B?aWFxMlNaNUtzQmNjNHdtN0RYU3Npd1hHQzBTSUhoSTB3TXlYUVRkZXZZeVdW?=
 =?utf-8?B?TXVTdE5XQU10RllTdURuMk8zUnY2K3FCb2J1cXY3Y1pQbDNJMVJyLzBxM05a?=
 =?utf-8?B?SjMzTzdUTkIvUFFZeWd2VCtoOEh0NkRyOWRnUVdXdkJUSEFlY2o4L1hNcUQ5?=
 =?utf-8?B?VjJhdzlIcmlaeUc4NFdpc3cxV3UxU252cTVRZmQyVEdOTWV2VHZqdW1udUFE?=
 =?utf-8?B?QWk5Q0FhUTJsZDhWd1BNZDdMVVNFR0tYQTVxUzZTU2h1N1FVbGR4RnFiSEV1?=
 =?utf-8?B?SWxtZGFnRVpQbVZRWEpDU05nR2J5eGRZOGlpOWxLR2VuSDc5b1B3YXgra1NZ?=
 =?utf-8?B?ZmtDenhqbWk3Tkt2S1NRNGtmcnpDS0kvNGxkcmtUdERWU2VOdnlJTGhhRkh0?=
 =?utf-8?B?a2VjN1MwTDRUMjJDeUxkRDZscmZDRE4xNkdhNEhWVWFDRDhGdkoyZGtzc2E5?=
 =?utf-8?B?VlJHbkNTSXJsSWdsWFc1NldtbGE1OUZueDRnL3drS3dzQVlHN28zSGRVNWJv?=
 =?utf-8?Q?Q6sFEkkXLQSVue/ANO0Zi9JekIAwTj+xrrYaejG?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c4ecd9-89a7-4c02-d26e-08dddb9e95ed
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 01:53:52.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB5598

Hi Borislav, Thank you very much for reviewing my patch!

On 15/8/25 01:25, Borislav Petkov wrote:
> On Wed, Aug 13, 2025 at 11:23:38AM +0000, Stephen Horvath wrote:
>> +	/* The PPR defines the core multiplier as CpuFid * 25MHz */
>> +	p0_freq = cpufid * 25;
> 
> As someone already pointed out:

Was this pointed out publicly, or something internally? I couldn't find
any relevant TSC patches for AMD on lore when I looked previously (other
than the Secure TSC which didn't seem applicable).

> 
> PPR Vol 1 for AMD Family 1Ah Model 02h C1
> 
> ...
> 
> MSRC001_006[4...B] [P-state [7:0]] (Core::X86::Msr::PStateDef)
> 
> ...
> 
> CpuFid[11:0]: core frequency ID.
> 
> FFFh- <Value>*5
> 010h
> 
> So we need to do per-family checks here.

Ah, good catch! I did check through the 17h and 19h PPRs, but overlooked
1Ah. At least 1Ah is simpler since there's no divisor.

> 
> Not sure if that is worth it, frankly.
> 

Yeah that's fair enough. I might submit a v2 with some changes next week
and leave it at that, depending on feedback from others.

Thank you again for your time reviewing this!
Steve.

