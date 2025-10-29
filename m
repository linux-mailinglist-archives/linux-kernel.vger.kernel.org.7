Return-Path: <linux-kernel+bounces-876576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B54C1C650
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15693624FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2EB33F38B;
	Wed, 29 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ReYWCsOD"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020115.outbound.protection.outlook.com [52.101.189.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4233B6F2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752730; cv=fail; b=qOz0L3r/9nn9l9PEDdsLDsf72mCRSGUGW+WQfZybehQA6QyBCCDx+uJq6EBtZI4DrBEsjEZrh43htodE5sb6dnfqQrLNMpfdBBCdO6D2I+lsXOiTqehNWJ9BADCfn+erz/cAbdsVw+FwCGLsSSmR23FYOKE9016Kj6xKG+Pg3+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752730; c=relaxed/simple;
	bh=+sQNsFJDpuLj8PznT810Fgs1wcztiwJTz6rOb9vy5TI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPDU3lZ2RvckmRAoi1Z2oemMY7yOpX+PPqTB0xS0x97LLnIyphcZsOXTERlSv4dR1RXCVQm/gSiZPgmio5TldFIz8hDloiNeJ9kr9eGwOIDiE0r5eX5bNxI5mYipHVJwx9gUiG735RzUaBYxugMstsHGl2MG/woSfLK7ddbal3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ReYWCsOD; arc=fail smtp.client-ip=52.101.189.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnAlw7llNw71wO35S1Ddqikdv3XVJPTgbdFEPn7GliJgiNIdmtDZOSn1QZXKxtadrU3Cb8wknSgGWdlJRrMr2Om7BVxp9YBurQEm0nkiRDsqKtkmFVfUmw/QqHd2DZZ7kDqjoogD/X0IBEGdoXY6CJhivPAq6ZE6lhTqcPzeEJZ+uGij1ocdv4rcx/X2nvF4bF9gvO88aaWpSNfsRnERodrggR9I6NL3gAs3KvOalgOmdijPAbiaqAx8EYr8Vmt0ex3E7iolsw86OqZo91a5evyqR8pgbHDDv0zBKLlF/d7r9hMNWIcCnGvqs7PjDc64dHq0aoNY4UhnZNcxmZHqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxlWx0chW/xrb3Sn4Q1XaMkow0EvaaEadspyHU41mQY=;
 b=eUbmUTFlVimmVG5EqGnT5V/4xBniScLNHgCkfrGteRScJ5ZW6JlMsLwPePB3vkmbDqgpFB95gY0w5f0awPYW4QWDvK105JAA7ittof9f8X2ONZnTmj4/6vUmq+j0zcrQlOChFI5MpYGb5+bDQaChzxk36HKJNpl75TJ+milSMNUddLeV8EUhcjeyH95i8a7hmAfFyiTo0VAqsMdqGuEci0HZI2WmuKxIbHwkmo2aHB1P3Mnb15nuezUssKWT7atshBdSI9W+aipkcjTrbpA68daVYo+T7aMcwqOeJHUG1YmLM/hg6ikH74URFDUwjf14ZdmJlrLHx3R+H3DYMjzc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxlWx0chW/xrb3Sn4Q1XaMkow0EvaaEadspyHU41mQY=;
 b=ReYWCsODSZgIBrx6U/Z1Zb2LGeSaRFqY9fNEXwDy2yQjC+xZa4eGM4ha4c1DGWbc9EG30UE3BmKEY25Z3zReVRYT/AwKYZ98Yuw22F2UFS3lopHCkTLKaUFqSgm7xeUbbTi1gjLZGDDAzczPqY6/lufGIrZe2fhshBpH7nH9623DP+SnJM46ucZEhUO3spHQtHns0S5mwmP0DSme92F14KsIahcQn0948TZawCxXlBg2/R9eOm+oeYA4vLYVvJcmQUyvPQZJbZWb+/AluBJx0I5PRmWiXbQy+sZRtO6BvB3QwEWv3fCIH9LcKtoyuZJCfubay+S7ly7IatPSMXvzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8438.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 15:45:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:45:22 +0000
Message-ID: <9c0c4bef-1b56-49db-b9cc-953e26572fd6@efficios.com>
Date: Wed, 29 Oct 2025 11:45:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 06/20] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.655228863@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.655228863@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 9748d3f0-8caa-4d38-c54e-08de17022b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjY2YkEwZnRKeGVzVnQ3ZStVYWc4d2ZScTliV2tmQ3VHQVlVZDBQV1ZxQUI0?=
 =?utf-8?B?MVNhczJMbm5MbE1OMFNiR0MydzZhMEZxeFZhT1g3RmsxM1NRY0F1T24rMlJL?=
 =?utf-8?B?c2lhTUNVVk9XbVhEallCaCs5b1ZGUGpkYWxrREg4RWtmaFF4K2VoRFljUTM1?=
 =?utf-8?B?RUUvL3VtaWpoSjloTlRmQ2dYTlhBWUwrVUw1VVN1cDd1Yk9TaWg1WWdzR3Zh?=
 =?utf-8?B?SlhHdVF5emdEZ3NvaTd0amFhMW92QTUwalVWQlRzemhTT3g4dTVZRkYvdld4?=
 =?utf-8?B?Y09iblY2VEg5T1lhL2ExeGdPVC9DWTV6a3lRcm9VeHJoZ3RTQXZIWFJSZUl2?=
 =?utf-8?B?UlFDMnNkUThUbXJYVCtKVnJoYlBSdmJoTmc1aHJnNWQ4RnBpQlZQL0w2ZldR?=
 =?utf-8?B?L2xxd2l4OFpXUVVHMk1Gb2Nud0hkMk5hOTZ5WGx0NmFvVndOa3NpaEZLQ2JP?=
 =?utf-8?B?cVFjQXg1STNmZjJOSVNzK3owQUJKZ2xrd1pwa3FGZVFudUtIbEM3NHduSmxs?=
 =?utf-8?B?NUNXaHBPOFZZY09HeGdyMklnRHhvd0s1Z01xak10QWdzZFpRTTdCL0dXNm1u?=
 =?utf-8?B?blYwbEl0ZGtmQVZWL1BlMHBIODA5M2VGSjBtSXRkeHVZN0tQNmNvN1lpREtx?=
 =?utf-8?B?SDVwR1pSVXc3LzNvM1VFSU1qR1lycG1zRG54bEdRRDRnMXh3NWgwR2NKRUtw?=
 =?utf-8?B?MmFnMDVKQVBqL0s0ek5OZGlWcE1oVC9sMzZkUk1vS3lhcll3MExpTE9CMVk5?=
 =?utf-8?B?ZTNtdzlsTlVnZlovM3NxZmRQSzhGVEZaTDVJeWxJSXpSd01oU0tWdkRzQ3hs?=
 =?utf-8?B?bncwOG1YSmZHMnd1WWNMeG11ODFQeU9KaE9MZk9zaVZvSnVBdDU4STlyS085?=
 =?utf-8?B?WGhXdXRIMnEweXhWSG1FbHNVc0FSZEVSN09NRkVlMmY1S1JBTGljT2xuYUFS?=
 =?utf-8?B?NlNqcUsvOEtXMFhXdWNrZTRMNFFBU1BTOW1jcVZOUlhBNU1EdmNuQXRSR3pL?=
 =?utf-8?B?V2h5QXpyNDFRNGpkcVMvcENNVEtjQmVNV3NsZ2ZTQ0s1M0YzVmhXOVJGRXA0?=
 =?utf-8?B?Z1ZmL3VzZjU3cUlFS1Rmc3dGKzVVS1VqdFZyVjdTRDBoNExFTFNTZWMwMlJE?=
 =?utf-8?B?VVV5eWc5QlQxTjU0NWdhZlQ2T3NpYW5aUXAyWUVpRVNXbzRwalR4ZjZaeGlH?=
 =?utf-8?B?WjR6V2VFTHVGTHluWTl5VTh4M2FicXhrVUJHVXlhRlVwZHV3S1pTcnR5Vy92?=
 =?utf-8?B?d2dmeEl3MHozelZVVUc0R05mSmpNV1F6Y3RGZzYzekRWakNadFBScEJVemhL?=
 =?utf-8?B?aDloV1VkVlpuQUxjR1luaHJFdzRIVWNvYXpORSt4TFMvMnc0OUlwekFvNy9i?=
 =?utf-8?B?ZVB1VzVRTG5QRHVrYXkyQVg1cDE3TUVZTFlsMXdScXJER0ZDS0FYZzhBSXpo?=
 =?utf-8?B?ZnlUOUlhMzdsN1dWOE9WVjVjcStEV3FYcjFRczRHUVc5Sm54YXNOREtJYVFR?=
 =?utf-8?B?R05jYUcwTHBJZFlxY3lVMmNocjFjd3MxSVRlL0xTVkc3UXc3VE5pVk1pM2lz?=
 =?utf-8?B?Q2U4RlJtSUNJTEZyNUh0ZmdIUHlFUzBCSEFCa2l3SlNzdTFmOHROeFl5NEZY?=
 =?utf-8?B?c1BQRklqOTdFRWlBcklsS2tpVWg0QUlpN0NkNThGalAxMmdhaTZ6NE83ZVYz?=
 =?utf-8?B?QTBjMVFObFlTdkhiYUVYVmxQZEd5VkdPcnkzM3NOWFAvdlF3QU10c0xzVDN1?=
 =?utf-8?B?UjdOR0gwNlpvd0sxSUlOWGVlSE5HaWU5ZFhQY2NRRlhCdmQyS2htc0t0dEh5?=
 =?utf-8?B?MDd1bTZ3ZWxNU3IwWnJHYWxhd0ZCR1dPV0JZRlZwKy9rVkMrM0Z3czlKclJi?=
 =?utf-8?B?SlFUU052aHdiS1ppeXZkT21JOWZ4bUU4cXdQcXRZeVVEeHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2IxMGUxNkFZdCt0ZzdGbGR2M0s3STQrTDlzRUZ3MnQ1TGNKRC9wTUhDNTBy?=
 =?utf-8?B?RzBMc0dhME1yWG11UzMzSU13UHRISlZjYkFrYk5IZ24vVmpvNkd0WkY1bXJt?=
 =?utf-8?B?NnRDb0xxS2MwZVZLY2xlSkVuSDlaT1VrQzFQVzJmZ3hKMFdOQklIS3pmcXVy?=
 =?utf-8?B?REJxYjhWRWdpelRjUUgydWk5VTBjN040azR1T0NVd25qZERWSWpYWmxER2FC?=
 =?utf-8?B?VUNSQzhHVndheW5WNGZvUi90Ulc5akNRVWdLN3pvMnZibXlnQUtyY2M1TVFm?=
 =?utf-8?B?M1VHVFJwcitQa1lxWGRQdU1lOTMwM1dNcE51MnVtRHU1RFdHM2VGNE92SW1S?=
 =?utf-8?B?aW9IZjdtSUVHekVzVXdVanRGdm9yemI0RWozUlpsdXZ2UlozVDlQb0RTRjBP?=
 =?utf-8?B?K3Z1dmEyT1ZQcTdQWFlqSHVlMmxndkFwSk9tSUt0Z0JWWmpNU3NCbWFMRVZ5?=
 =?utf-8?B?ak5sUkl1SEJteTVmM09uSEFLNHBPanlMYWx0NXAxTHNOWloycW96cjd1LzNM?=
 =?utf-8?B?c1BPckUyTStJbkpWTFppSWpra2YrM0tIV200QW5OK1NHUUkrWUY5aVhnOVk5?=
 =?utf-8?B?a3BpU1hqV0lWeTRsRGhSaU9HMHpNVlFZRjIwT3NNYVpPRU1MZjlnRlg0UktN?=
 =?utf-8?B?VmVsdS9lNWlaQmxWTTljQlo1eGwwRWhVSFZqd3lpeGFSSW1JQWZOZWtPb1Y1?=
 =?utf-8?B?TUlYWXJaVDR4eHp4Mlg4TldOdnlLbWUrOTJlNzZhbDJhMGpGT0o1RW9xS3hW?=
 =?utf-8?B?SzZlbVdBNnhyeDIyVVkyelVQdS9ZU2lkZlhrY3Jsd3V4RXk0ODBBNm9GcjZ6?=
 =?utf-8?B?QW5iNGZmZEtZaGJIWjdUL3lOS09UMlpZNmo2OUJCaVc2cDdrd0NveGtMbHFE?=
 =?utf-8?B?K3A3OXp0aDFtbWY4TGloRTl4NlFvQ3YyamhKRTNvQm1ZMFFKZUhTOHozT1Vk?=
 =?utf-8?B?UXNjYThXRERqNGxhWmhyZ1dmajZ2M1kxcVNqNC9JQ3ZuOXBqU2E0a2NZZFh3?=
 =?utf-8?B?MjdCaDZWNklUMElmWjJ4YTRRb2tkOGJwKy9PMGp1THljUmVvVU1LRENaNUVV?=
 =?utf-8?B?SzN6dHZMWTl6R0hBNVRETy9HYjlramJMUkhnMXBmaTRmOTZPS1NMTFVnalB2?=
 =?utf-8?B?aTJmVlVmbnVIT092TEl1UFVFcVdNVHVaT283WDgwWHlqVkFrTERodUQ1bXFG?=
 =?utf-8?B?MW9IRVR4bkxvZHhQbE04ZmF5S3BQNmJFZTNyWFZYTDRNVTNMSnpVckJDMjhH?=
 =?utf-8?B?ZHdkT3A5UHhRZHFrTTJzUERxNkxuODYvOFFRSkFsa3NiZWNWVmt0OE9zdi9u?=
 =?utf-8?B?Y3ZLeFZ4bzlBTGJwKzNGbVFUZUhPZERXVzNoVFl0ZmxFRnVoYU95UzV6YS8y?=
 =?utf-8?B?ZndUTnhwRmJoNnhIZmxRRDBLVXN3YnB1TlhlMG95SDNFY0F5U0poSEwycDNO?=
 =?utf-8?B?MUhwZGI2cGtkb0RoaDhVKzM0d1RZM2QraldRem9jMzdEM2NlNENiTXlQZkRs?=
 =?utf-8?B?bE1UQmR6b3VCVXk1SzZjTDlmdWhwWkgyZ0dBZytNZFhjZkhyeWxXK3hnQjZh?=
 =?utf-8?B?NzN2a3ZETjNlWXZlVERySUhDSEllUTN6c0prNkhjdmo1MjlTUmRsVFVHaXdq?=
 =?utf-8?B?TFRucVEyM3lkQ2c1V0FJUXEzdGhlcFVISEQxK29JcmJJWVZQTktJbTVaQmJs?=
 =?utf-8?B?Z3lSUHdCVzFZUjFFZGVxVE43WWFzTmlLU2M4cjd4RnZGdXRaMUZvNjIyL1pQ?=
 =?utf-8?B?QVBTYVIzanVPWWFYdFNyeWpRNVdyWDE2KzlGN1pJOU9HbTNleTBnRFFZZWVQ?=
 =?utf-8?B?U1ozODlES1lxSFVZTjB2T3Nhakc1Vzl3V1BsT3UvWWI2c1Fyc2xNbEFMd0po?=
 =?utf-8?B?QVdkdFdzcVg4bGFJTGtoRGQxWHNORkxpeENuMkg2MXhjMWxvTnJ2aGJQVURh?=
 =?utf-8?B?SUxXN25sUmwrQWpTSmMzUUhmUmluVW5yUHVQdTFRdFE1RUVzdHlUN29aN05v?=
 =?utf-8?B?bmUzaUx3SklGQUM0dFBvQVlsVXJTVEFFYTJDYnJCT1Q2VUp6ZG9meXRnU0xa?=
 =?utf-8?B?VmFDYVlCdDNNRWlneGg1YlZyVVg2SHBYcWlSUTBuYm9vWldQekdNUERhZm0w?=
 =?utf-8?B?c29mMHVKbUVPbGVWMmlCRmRzY1Bjbk5CcVAwbmlTd3RKTmhjNDVnK0I0Smds?=
 =?utf-8?Q?v7Yc0stmfe+/RNsKFXq12XY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9748d3f0-8caa-4d38-c54e-08de17022b80
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:45:22.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKHnhfRbh6XQx7QDFBHVNi8kFTf7m2V7Sifvrk9basr4rBjkwYH1svhooatVQ0tEfQcGzDE+YqMAl2hzLl1LyjwB5Qi09neZ5F+9AOYd658=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8438

On 2025-10-29 09:09, Thomas Gleixner wrote:
> mm_update_cpus_allowed() is not required to be invoked for affinity changes
> due to migrate_disable() and migrate_enable().
> 
> migrate_disable() restricts the task temporarily to a CPU on which the task
> was already allowed to run, so nothing changes. migrate_enable() restores
> the actual task affinity mask.
> 
> If that mask changed between migrate_disable() and migrate_enable() then
> that change was already accounted for.
> 
> Move the invocation to the proper place to avoid that.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

