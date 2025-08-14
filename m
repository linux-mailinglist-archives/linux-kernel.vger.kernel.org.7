Return-Path: <linux-kernel+bounces-768167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE99EB25DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69291B67F34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050FF26CE23;
	Thu, 14 Aug 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="C3cTvfjz"
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012053.outbound.protection.outlook.com [52.103.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB126B2B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157215; cv=fail; b=sSBrC5UccaNN1pwqNplYhY5D+pgs+a4oclImx3FgosvBtxbMDb+Ih1khAUE+rO5Wli/+n9TJFwkjf4dFgf4tLzeyE1azpV2SqeJr1hQQIY2gemO4C9annQ5jTQwLQtH+OzzpjjlzqcxsIrVPTHLmJcEUb8tVoK8E5hIDi4xcOo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157215; c=relaxed/simple;
	bh=gg9fpmpwZYO+oQ6AmfXkNzVAsWGiFm5mFbKN78uc98w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vCvw231Nx/D3+HgWCFjQQOGf7KjRsMoGFvv7iZi/nqY4IUtpwyg8Ymrzx0yTWXAB+bUiRFsa/o7HL5L5LJalx3DEZY15z0Xfgbe6itTpfz3ZQTtEOWjtHifB5seS8W4YE+ZdBW/cAiwFUPBFUrHLEMaxFOnuiETegDXY+PRVQVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=C3cTvfjz; arc=fail smtp.client-ip=52.103.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+pGvoOSb9/pK8SAifqqfwhjFr5MNY2YVazuX9JG2F05cMWbIUVgbVQ2DQATX/5RBU/I9KHIipEGf6NaZIBQx/z6vYxIrs3Z0E0Lh+80tqlZgLu6i2F1N/jpE32S9P6DiGcNF6ngp28vvZV/JM4gNak9ov8HUmkRyp+8+/kMo3WVBR/fmG29MiKtEmBXvgqgPRduNcFefIkq02aJCiYE3zSkCr5mXdZqepDpPNQ0ehWEn9RTSzRN4HRlAix1IM8LEG42Qv8NR3ppsAG/HjM/R+J1iBbzpy6z/y1lnQUnhy0YZN55NQWcNV5AZpShdgV+vesgw0pp0Bp37AuNaoUEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr1YR+MiU67aEBHvWELZ6/LNHMOpIuF5n/CrVoNdGfM=;
 b=wJHtRm8ntlLX3Oy5jw4dFV7wRDjkJEqiWdhEUC5gGL1AFcm2bwmmIRZCRmgneRBZxo7YrpfUtAV8bqga5gH5vyvTTxedBFR0rC8DVHrfEdVXt9Ww/GPMBa+Ye+DKW82sVbUU2VDrroxw30LOwLeP4qj/DiGRj7T5VKU1jkpi8PflqasF1wSfYO5+gLUKs2vQEe8G59oAE39H7LQrfbuPM9aXFn/W7EioeNS6Basyur1SvczFfYh3qXd2X4Kk64aMZXeApGYoPT6/LlaWR0vUk0SAI5C0v40o17E7R9BLheY4x5PM3O6DJKc/SCGhZN2B2jc+SHZ4RP2R16dDLFo4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr1YR+MiU67aEBHvWELZ6/LNHMOpIuF5n/CrVoNdGfM=;
 b=C3cTvfjzdZb2kG6daxgNs7KAx/qj07gE+QYcIroVD/kUWJZTl0QboJo6fCuGkLONTPJH//s9oVJ/fP/joPbP4XDuJgipnhsc4iBs/nW6soJHTal1N5MW/ap0C5/gTiOvy2c0QUY2ll6jNvupwXS/moDWiUB7vvLVD3OnTtYiOQpAXCpT8YJiTvgJvx9Xz+jACqiEGoWJQGU63E0qJMXES/QvYRhputNvD2O8VzJaXQyuRphying4Y5blikrWU4i1tGi5cdFSFCTA1czc3xmYm+dCVGa/klNWiA+LpXuho/H60cdDfVEb5zx0M+R/dFxNCnII11IWMjgONduIBP4LTw==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SYYP282MB1327.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Thu, 14 Aug 2025 07:40:08 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::37cc:3733:d1e9:d8e4%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 07:40:08 +0000
Message-ID:
 <SY4P282MB306320D794B9E1407D0CE5D2C535A@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Thu, 14 Aug 2025 17:40:07 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Read AMD CPU frequency from
 Core::X86::Msr::PStateDef
To: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev
References: <20250813112020.345622-1-s.horvath@outlook.com.au>
 <202508141439.JO8YA6fq-lkp@intel.com>
From: Stephen Horvath <s.horvath@outlook.com.au>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <202508141439.JO8YA6fq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0096.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::13) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <259011ba-23d6-47fc-97b8-1af879d03e9c@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SYYP282MB1327:EE_
X-MS-Office365-Filtering-Correlation-Id: 069a91b7-845b-4ed2-e042-08dddb05cb10
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUykhYCLh9DY9coCVULpTnXaxR9o4ASBTPRU1qlcaY8IboHIKGY5I5Pbu/K8XgV690U7Rjjbvu1hVxsV1/ZLYaBPUwz0A9hKVG90EgUHk7umgeg17qMVP81DwOKDO1O+ZunFcORVmggcSt2OZaj2u23KNDZxcbi5cM9JtgsJMSuQjbKMV3HX39rdqdeOK7ceBng6JU07Ecj+6CpbCLLhyGPmd4RFlxIRhm6g3DkRiTN0mXrx0xk3/Sfvac1t5XN33X1qZiG16Gf9ydcT82Bb1z+XW8WwSosap7Eq+/aWejynkMZMVDYLbacLAHfsqcX/nxqSVY7YvytI4vS7FIdIfyrNOW/qIDQHAO5XVcJtUcyXxLcV/OfpWz959DqR20nLhPDelI5lntaDhaZYBayQKLbHRsWkjm9gcRmoHL5Kdjdmysz+5cUGxhe60SFcBnEjObRG9ul7ysEp5920SO+vxMdL7XTo1Zrh8E8IPHN4V6bIAjTjKBVEwG74s+4+DZjIpSVNmstCphLYxensS+e/GbdZK2UOP2XklPomdpKwVNhS35nYV8oWB+6ovDhib1mRmyoYyaibc/9EgmSgk5aQGttlmD2ruToA5Iyc71gfnaHO5rTNCAQcGKqhwXmauQVy1n/Gcw/G+kNt58ljtF5m/j4AoMjxMaL5KoFtwY8OeHezcQRKo9HpltqzIlJVPbqj4hCqnxQ+UySEIo0mTdnHPwPiUMgP2V29+YBuu8KcKApcq/nAAPsL+ovDL4sbVf0FrI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|461199028|5072599009|6090799003|23021999003|19110799012|15080799012|3412199025|440099028|40105399003|51005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzRXQnNCMHZqM2JUVU5hbmcyZkhQNkkvaUNkQWhHNUZSWHhQV3JEWDVHbkJU?=
 =?utf-8?B?WGYyMW5pV0NCaWdHMkd2bnhmcHRoSFRVTXRDdklMN3AycEtiOHVnUFpIZ2Rl?=
 =?utf-8?B?aVVUSHZ3MmhBdDEyRE5mTkt3VmN1TWNEUE1Makk4QmhaMUdIYUNXQVlxZW96?=
 =?utf-8?B?bXVmdXN3aWREZ2REVXFEdHRBVnAxSitITU80anhjZytQNXhCNFk5c2NVRUJN?=
 =?utf-8?B?OXdaVWUyN216enExVUp4dEdTdVRSdlJsSW1MeU1JQjEyZG0vVy94dWZ2ekRS?=
 =?utf-8?B?YkpReURzQlhGMTVGUEU0dkN6OTAvN1JEOFRlWXBXK1d2SDNVOUl4NjJXQW10?=
 =?utf-8?B?TzRZN1hPemkwNGZ0WmhsNURRN1E1U1ZNZVhwaDBqLzRPUmd4RU10elRkNVV6?=
 =?utf-8?B?YzJ2TjludjJGT0lnODJRd2lkNnhWOCtFeHNsS0FHZEZjZFZMZFZ3YUhTMDVL?=
 =?utf-8?B?Q1JWdmY1T2VCQWdnVnVldkFNc0R5cUxXK25kaGU0U1luUERkaTZhQnk5OFhV?=
 =?utf-8?B?bnJiWnZpNE5ydC9lbkZEUnpWSFdDZG1zQ0FZWTU4K1hjbnNUSmVEcjMwcXdR?=
 =?utf-8?B?VUl3SmNjbVpwczFWd0FoTUQwK08veGdmWlVhSk1DYXpIelZUcFVNcVBtTkRH?=
 =?utf-8?B?WWxXeTZGQUNCd2FDbDFGN1BaWWtmK3VXWGNXM2t6ZGkwY2lVYmxPNGpFT0sz?=
 =?utf-8?B?OTMvODlBeTUreTBvTzJ0eTBFakMzdmdKY3IreU5BWThqdjJ0NTJrMjVDNDhZ?=
 =?utf-8?B?SzJZTG1UeVRyeWNYbW00NkZFc3NPYTQ3ZG4rVTlNWnhhbzFyUFVOQkYwSHFy?=
 =?utf-8?B?T0Q1WU9BcmZxQW9JaUxCMG1WcVV3bklDS2xGNGRaWnJwcXVOWmNaT0ZnYkdD?=
 =?utf-8?B?L2M3R2hSbkcvZHc2M2diSU11K1RqbEVvcTZyR2wrem93dUs4UUlVK0k2VWZD?=
 =?utf-8?B?eXNzY1VnNXkzYnlIZmdmeisrc2p5aGRkeXJWbnJtTFFOR0t0d2RIRWo2dHVU?=
 =?utf-8?B?Y3R0MGpaNWFtRnZpWjBaMmJ4SVpsdGxud29mVWRnRHBQWERURnNLYUx4M1pw?=
 =?utf-8?B?S0NFV09pdTQvNHpUNHhuNk1tR1NodlJMbEl4VDAyV3htQXZoa2lNM0dZbDF3?=
 =?utf-8?B?M1FoRXFSMGxmUnJYR2dnd3VIOEJ5SlhYL0F4MHZzS0VnL3JPeUlGVVBQL2FK?=
 =?utf-8?B?b0Q4UlZ6cVFCOHRNQW1hTnZQOFl5c0dJdVpnUjNXN2xKZnpTVlJ0RWJrR1R2?=
 =?utf-8?B?R1ZzSG1RNUVkSW9nK1pFZHVCb3ZoZTJtejNsaUpWSDIyN1d0VkxJVlBuUFo5?=
 =?utf-8?B?MUtmSzM4VFhLRnBzN3VUTlZKMXpMZ2RseDRUWGFxYTEyQlJzbnRpMmExcytl?=
 =?utf-8?B?UG5jTmxIdEx3enhORXh1Q2lNcUdaWWNkeEthT294WVdnMXZDRDltWk53cTZv?=
 =?utf-8?B?ZzJvaDE0ejlLeEFDbGJCR2tmTk9aRERrMWViY2Q3ZUs0dGdWdnVKbmliZ1Uy?=
 =?utf-8?B?UmJlaXRLbklwdXhDN3hzS1lLcDNCVkh5cEppYjVpV0dFdUZ4Y2lPUk0wUnNV?=
 =?utf-8?B?UllXL2xBbWFlRXVmK0JsS0QwaGNPSEpvbHBZbGFESFJQUXMxSkd5L2dGSjY4?=
 =?utf-8?B?aDZHR0hhb3U4b1o0aVFOUndTQitpalE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzZMaUhSbGtUWHFQZTZNRkd5dHY2akNMejhoN3RmMExYOVQzTXZTalNwUko3?=
 =?utf-8?B?Kys2RXVDYVNDNkgvSS9TcXlOdDkvd1NleEJtQXZNQ1prQ0Q1S3QrZjc0b0tC?=
 =?utf-8?B?dUZEV0k0cEZ1cHZXZXR5Y2hIMmZaQVNlNzhrT1p2bllQME8wSGZqNmVsVFpn?=
 =?utf-8?B?djhuRlp6K1FCdlRtd3F1bG9QdG5MUFJXKzFoUG0xbXExWjNXTEJGWXRuNG9w?=
 =?utf-8?B?QkR5N3pqdnlKcytCWm4rNWZ5UkN1WUVwekhDYzVtbzNSaHA4Y0VrS3piRVlY?=
 =?utf-8?B?UWtZNlhhQ2VDZHQzWlZZSlJyTDdqZ1RCMVVrTmIrYS9IWFg2SW83OW1kNFFx?=
 =?utf-8?B?bzRabGpnNU9tTjhEeVVnZWJHSm1ocGxPaHdzckFZRkh2TW8wUG1ybExkVFRW?=
 =?utf-8?B?aVRhQVZVOTd0TTVTNi8rOW0xL0F3MjRKeVhydzhuMzJzMW9wdC9acW1xc05R?=
 =?utf-8?B?c2lDSkNUZkhNRFB0Q0hHK1JKNHZPZVFXa1RYTS9UYUxOLzdOWG5ocHVsRzk3?=
 =?utf-8?B?WFhsSkN3YWtReml6anJnNHVScUFMWkxxSlVPTHd6U0JueFdoUnpUVjRaaVRt?=
 =?utf-8?B?U1IwbExpQWxjWEo5OFY1LzZrL0xaSlFuZXNPVmJ5am5BZ2QvOE41N29oU1dS?=
 =?utf-8?B?Vk9NdmFRTE9rZU1yTVVsbjNPQ1VGSTU1dFN6SkFQN1kwZXJaYnBaUlM5TmNS?=
 =?utf-8?B?bVlDSjVCTStzYzAvekxSRFVVQmdWb1VXOHFmYVFwc2Y3MkpGYVBVRjR1dktU?=
 =?utf-8?B?MzQrL1dobmJLVEFzSEw4blZ2NGFHQUhMdjhVL1ZNSGZKUE1RY2IwZnArMkVo?=
 =?utf-8?B?MlYyMDREVzBMRXpDRlV6Mmpqd0ZZRGJCT3J2K1l5WUw2QjZmcVhCeEhEVW83?=
 =?utf-8?B?MXJmclZDZWxBNjZlMnJnQWhYQkZ4TkFxbXMvbXdKb0J1T2NXTzZjVldYREFn?=
 =?utf-8?B?Q3JMMjRGVVVFWTBtemlMTTlXM0JUOHZVSURnbGt0WW9HOTAvOWw3SzdvLzZS?=
 =?utf-8?B?My9WbXBEVlc3NW8yRmc1ZjZQSmQyUEN1QmExRWR0bUkxcXZJYUlXcndRRTdj?=
 =?utf-8?B?U2F0RTZpbmZoYzRBeHh3aGpBZC9rdEQvSVkzVkp1Q2dPUThYTTVGcDlWcGtM?=
 =?utf-8?B?U0pmaWl3WWNsM1VJdkRkM09oVkpmSUpib214UTZrYmFGQzBMelozYzRFblF6?=
 =?utf-8?B?c1djQzI2L0pTamlUbG05b3AzbnJKalAweklKaGpPNjVwcmgwUXI4T2dYUnJt?=
 =?utf-8?B?SnYxajNhZ3hGc2Z0QkpyYWI2WmlCMDFsbzl1VmVBOEFFWTM5d0srVGtUZStx?=
 =?utf-8?B?QTJnU1dwc3lOc1laREM5aEwrejM2Q2d1WnNZMk4zelppZ3RYUEtMaTBxSWZU?=
 =?utf-8?B?NWZwZ2VwNmJxRHhlYW1pSFExOGh1UkpWbmZWN0dkR1ZiS0VpMVJESnBwYlVY?=
 =?utf-8?B?Vk5ldFpRWlcrc3VYQXQ3MUNrbEEza1JDbFlOb2xicVRYTWNkNERyRXhWR1ph?=
 =?utf-8?B?eHZSQUErNEszbUgrRUxCM3MrTXgzaXVwcFg2QVhPV09idmI0Vlhib0hvbEZR?=
 =?utf-8?B?Qk9YaUFsSnpZQTJLVEsrbmdrQzZJR21rdFN4YkU5OTg4QUJQR3NvdGNWZTZz?=
 =?utf-8?B?dUpIbytwZWJsVUF6Sk5UdW1wZjRUdWxHVDdiYjZpOGJNd2NIZk9Dc2htcXBT?=
 =?utf-8?B?YmNZR3ZoK2t0MTBrR3lJTDUzVlVrSlo1bnpJYlU4dXVCeThKb3YwdmxoeUMv?=
 =?utf-8?Q?PEI50DK87NkM/ec9ZCvYJu4Aggbm08tP3DNmoKI?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 069a91b7-845b-4ed2-e042-08dddb05cb10
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 07:40:08.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1327

On 14/8/25 16:36, kernel test robot wrote:
> Hi Stephen,
> 
> kernel test robot noticed the following build errors:
> 
> All errors (new ones prefixed by >>):
> 
>    ld: arch/x86/kernel/tsc_msr.o: in function `cpu_khz_from_msr_amd':
>>> arch/x86/kernel/tsc_msr.c:307: undefined reference to `__udivdi3'
> 
>  > 307			p0_freq = (unsigned long)(p0_freq * 1125ull / 1000);

Thanks! I can replace this with `mul_u64_u32_div(p0_freq, 1125, 1000)`
in the next revision.

Thanks,
Steve

