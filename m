Return-Path: <linux-kernel+bounces-835231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578DBA68A9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D986F179174
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F8283FE1;
	Sun, 28 Sep 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="B19Xa756"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022119.outbound.protection.outlook.com [40.107.75.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD27136658;
	Sun, 28 Sep 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759039545; cv=fail; b=V9lM2xdAcGqV6C1OlPlgWJ/gWbwcnGz7MIzbfhM1mYekczItDfbvregsLWCJmhZWHmI0ukGHPm8tTkSihGABpaEiQZ+52+xcLYd/68vwKg5CikW8caxX6a8Sh/68bg0scAOjeJqRrPvg8e67hNIV8w/85qK0r6gL849gUSsGhFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759039545; c=relaxed/simple;
	bh=Dkkekg3YWdFAfGt0n2QHU/eJX8nQgXA7LJpuVELzHWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERvLKRRXivyPEBkObt+K560Mf5Z1BB4PGIBnLQlZIgemR0q8IteEvXTat38+Vfqa9UgS99s3frrvvqprcm8x80YmV3fzfYTosgTFFNbUYJjeX9ZIHuzrJT4HGB1RB+N5LWSYj0xxriiucVMY42UBd0Mc6gOaTnJogMYYh0vYZyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=B19Xa756; arc=fail smtp.client-ip=40.107.75.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFXYNPoCQA4GeAZmBvz/MAIIRdRyPYpk0DWmdx++ZQHr0BAUwfL2tikqVf9NcoEQJnSHefqNomRoBsnuxgTl+ezDjWKntfJWEe+yMwWKIPtzC4xqYEL5KF3ACAR0d7D4AypyIJFmp91VACMF6/fAJ/IwymSGFFUOP00cacdrlsyAErE3jQc+uC/Luzzv4tkRT+zzuBKzkXhaUKE8iNKORpNul3Cg1SXjGMxmb/1rkvCSrlel2k0ViW0xleU9A2gwGRovh3bcFfjhE0nCB6ki6bau7ZKACAlB5EWS+GMAWpagC443/nMWnM7yaQRJ0ip5x0GL3XsnqG0p95Zw5jO22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zl1mFg/rikISaRzGn+ceuwbLOGr/ymtYi/HRQKrUFk=;
 b=c0XZdQBKkROsJDdV0CmtJ4V6ZJ9Nt3qas59VM41/rXOfou9fXjtPSVFMG7fwX5GvyR2UM2AVuxp/BpRfS2TiUHhWyaKxD385n1wcKm6rrSCYpTwxHwmDZ66f4EQuaVEYy3DlrLcbflfdPBremJv8dij4/RWkIL0C8JP9dRQ+9qk+oiZ1AyuwkjlVTza+9dO3YqPU7afqtaSjSdwQCJB6kjSuPPIj3GPqWP34t9UIiut+0FmziQVxAYJzEKC84hL4JMWrYCnyXcBzoymkHnaqROkRWIJNrIlDUSuPWeYzmJMR7x7MxpMyqHFXDo61twvFvoudJ7iJhI3gWTXvZTHgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zl1mFg/rikISaRzGn+ceuwbLOGr/ymtYi/HRQKrUFk=;
 b=B19Xa756PVDTZB/I54RUK3xvKlG8t7kBXbHQGvf10sfIdHkbt+IsDSBYn8quxSqQbSqnCFD/R7zZbPJDSkOmYMDeVl7app2YhMsbK3oAVlwcOH8i2xKJwdrQmanoCoyrwTGflyXeBGijBovQIqVDxioGo3h/MSkSfsHObZrlkLtLst5uXdpxVBl29n2A02IEEyHeBVFFIVgCtZJOg1B+afWcBrFuKx0N+85P1c2J+3HQxbKU2ItpeorhWlF6tsnGOGy6gCeI2TuDO2DrWVQ3EpDd8ehjH2FRlqPDQejV++8GAdLgKU6UVaeY46sX4nPocFGpVLla36WSwk69RCVAvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TY0PR03MB6476.apcprd03.prod.outlook.com (2603:1096:400:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Sun, 28 Sep
 2025 06:05:39 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.013; Sun, 28 Sep 2025
 06:05:38 +0000
Message-ID: <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com>
Date: Sun, 28 Sep 2025 14:05:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
 <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TY0PR03MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 76758cea-e447-4f2b-29f3-08ddfe550c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzVGa3h1dkF1VVh0UG9vUmozZ0lLMnBrT0dQMFpTWXRYV0lLTGNIK0ZUdkhC?=
 =?utf-8?B?NGtBRldkSXRuN1M0SVJvMis0SCtvd3BNVGlyUUZhcmhFVzl2NDlSdkNYNUl6?=
 =?utf-8?B?R1d5ZkFrQmlDZkhuN1FFMXRIeGJjZnBLWFpCd2pJczRNR1RYZjNqc2I3Vm1E?=
 =?utf-8?B?aENoTG1kcC91SVBSNkpuS2pueUo5alcyelppRzQxRGpPZ0o3dXR1Vy9Vb1la?=
 =?utf-8?B?aXVBRW4vc2FmQjdIeFVJdDlRZElZTS9JZ0NHT2JnVmxUYjBQNUErU25sM0hx?=
 =?utf-8?B?amllV0J5YTl6a0dZMU5YNHBId2N6YytGZjJCdk11WGx4c3kxRWp2U0tJdnB2?=
 =?utf-8?B?NzhTb0c1WStHc1M3YUZFNlo1dEltMEJuRHFsUlNDTktqWVdLMW8zTE1OdzBp?=
 =?utf-8?B?cEhhTzk5L1RnZ0prTWdtR2NSTmFGeXpJMXg1bzU2cndsMWNSVEVSVUFJeEta?=
 =?utf-8?B?R2xOZ0ppVFdkakJvSVFBRlkxLzE5R1RYTksvaHdwb2Q5QU1kaEsvNDJUanNs?=
 =?utf-8?B?MkpTYUI0eEpVSDNSaUJPdHFhMFZHSFBVMW9JaDdXUmI1Nm45K3djMldQV1BM?=
 =?utf-8?B?a2o2RmNMQ3NjSVZZZFhJZlIyOWE4dXNqQW1DV2NCWElpNFY1Vm5vclh6bE03?=
 =?utf-8?B?ZmtOSDMxUzhrVCsrME9La0V3RE53Wmd0em82S05GLytxU2tHRWhIMGM2aTBJ?=
 =?utf-8?B?aEpoQ2xpQSt2UVpxcU8yL0hTMXEvNWNyaTBDMWszT0pjcXp2WnlnOU43THJh?=
 =?utf-8?B?dUhNbnhFV3lEdWt2ME9WMVZnWE81MlY1aEhnQXFqWTN3c2JOcGUvaXM0Yjc0?=
 =?utf-8?B?c3N2UHhqY0ZISFUyNEpFVGlNM0JaUmJ4U3hMSzIrNFpyWmJPRytKMDMrSVdh?=
 =?utf-8?B?WEEvUWk5bzd0RHNtM3g1K2M5SXA5ZUZVVElXSzJBRUlvanJxOXl1eGtCbTJk?=
 =?utf-8?B?WUlLWDlGTmpqcTgxdXBOTlM5blpKTm1zYTNpOWl2M0hhTzdjbXpKYy80ejZQ?=
 =?utf-8?B?RjVFRnVKKzNjR1kzT1BMZmZUK2txWFJXTG1qNVVPU0NFQnVzek1Ec0EremVV?=
 =?utf-8?B?ZWxmUlJ6SVNiVTFscVpwRmQ2dHgxLzE1eFRwQUVnVjdIamZ6Z0NMdjBBK3cw?=
 =?utf-8?B?dEI1UmxaaXJTczdZTUxncUlrMEJTem1hdjRQT3RBQTlEWWRVMXBWVFIzUmk0?=
 =?utf-8?B?SlBaNEFGN2xhQjlBNFpzT2NRRklLc1I5NXNDVkRmZHN5OExTb240ZC9lZW1L?=
 =?utf-8?B?VDlHblc5MWozN0l6WEN0NzNQdTQrWWlhRFFYZGREME9pZlYrL29JWlFrT2tQ?=
 =?utf-8?B?RlUrbGJtOXRxRnQraytDTElNQmcvd1RPUEJPMU1NSDlNU0VSeDZiT1Fza3Fh?=
 =?utf-8?B?eXkwbUZzVTV3R0JQMjU0aFFIMkp6MitXTk8yeWwweEQ3VFd4OVUxRS9keHRK?=
 =?utf-8?B?dTBCMDhVVlpoWGNVR082OHUzOUtkd0RtcDVVOENMYmVUdHE5K01KN0xYV2d2?=
 =?utf-8?B?VkJvNHcxWE0ybXVJVTlHTTBwdTNJREhucjN2UUc4TThDd1UwZmt2S1VOOFNn?=
 =?utf-8?B?aEtndTR3UUVVaEFKZ1JkSUp3M1pBYitCQzB3K3B3QnNPM2szTGhrM2xlazJw?=
 =?utf-8?B?c0FBbnpyK1JuUnRJR3JVYlIyOWhwekJBcFRhdTBQQlZVb204dHhITVJCeEh0?=
 =?utf-8?B?SVFNOVRzZHd1ekt0TGVOamdqOXkxRmRxMEI2NjZVZWpxb2lDK3NJSi93RWpH?=
 =?utf-8?B?S1lObjZ3aTBsME5mdlRBb1d0bmJxUFZCbG4zalNzQ090VHYzcXE5TG9mZ2ZU?=
 =?utf-8?B?VXVUcFR3eVNqTVpMOTdjMjBFNDNuRkk1cDNJQy9pVG9OQlVxUUFrRnRUVlZt?=
 =?utf-8?B?bmlHTUFxOEhMUUdrdktlZjd4Z0ZJelROWFcxU2duUmRrc1FVWmdxMVhoUGdV?=
 =?utf-8?Q?Ar7kV1GGmBKMaC7DV+bqCNSc+cRikTid?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Q0VVRKajNKdC8xMTFpejdIeFV6ZVJ6RTI3N0pxWGVzNnBvMVRhL1hyMk5v?=
 =?utf-8?B?aEozMHBKT1M2Y1dybmRWZ3VXaDArVTlkQmhCRWVEaXZsc2l2WWJXbjVvSEJn?=
 =?utf-8?B?MTBjWXJrdGR1Rm92R29VN3NMNlhmV2I0NVd4ejlaeC9KTmJZeWVKbTNSbkR0?=
 =?utf-8?B?c1RwemV0QmR2NkEvSWoyd0c3cGRMZnNSY2lEaCtxSzBTY3lNSjlwV2tYYlhv?=
 =?utf-8?B?Y3pDRzBKMUtySjZYRkROSmtRd0ZkTkdPbW5aVUxPc1g2ckJIQXo0aFRhUllB?=
 =?utf-8?B?L0xnbFJrQm1NSGphLzdoRGovdHEreVdTTVpwOXUwSmtxdW42NnlKTUFLWFRs?=
 =?utf-8?B?NDRya3oyaStUUGhqYlBWVUVucDBsdUg0bkplZDV4eVpHVTZGYUtBRnFpeUha?=
 =?utf-8?B?Mm4xdlNabUpNemM5d0JKMVd5VWxBaVNHQytmWTZhcjlBUnRUM0VCVC80TUR2?=
 =?utf-8?B?ck4reW9qcVBqNm1tYis0S0xqcjA4R2dRVHdoNHhFTkdxUUpjZzVNYnBBOFhN?=
 =?utf-8?B?NnNmeVZQemJISWNlc1FxSWZMZXNyRjVoMFhFTi9UUTVyZ0JtdHdZTGJzV3Zq?=
 =?utf-8?B?K2NXbENJZzVwVk54Z0x1b0NzLzlRTFh4ajFmQ0w3RWVkdWJBeTFJNXVJZFBi?=
 =?utf-8?B?OWxmK1RRRFJETXdveHkzaXpEUnYwM083Vk9Tb1M1N2VhOGNGamprZERyYnIy?=
 =?utf-8?B?bVRBQjlNa21kSmFhaERIQjlCaVc5bUZGRS9XUnNzM1I5VDI1TUIrL3NiRWhE?=
 =?utf-8?B?aHNmUzN5aXh0T1NyeGh0K0NIaW5wQWJ2Skp1Nkl1QlhIc2NzZ05SdGZLSmVk?=
 =?utf-8?B?dTdBMGpCblZYYktnVnd0Nllub1QzRUlFbFFwYzdhN05PYnpkbHNGRDdORUov?=
 =?utf-8?B?S21UK05HWjZ4aFJIYTBEYWQyOEdVaDI4bHBmcHJobU1NeDFuNFp0NlFtWHNh?=
 =?utf-8?B?WFNEQXpRUE1YR3NXcG1hTWdJNGxzVmZ3aUlVKzM4ZWxucFBjWTZwb0l2U2gw?=
 =?utf-8?B?TDBhWmplaEM5Z1QySzN1cGtuY1VrQUhJV0VJSXhBRU9pakFhRUVVc3hvOUly?=
 =?utf-8?B?V2pLeVlIbEdNMUlJZjVBZHk4STJSbmVLUDJOYXJnbmxNVi9rcEhWZ1pPSHNz?=
 =?utf-8?B?M1JaMEpTRFdoVUUrMFBhek1ESUxUdkNtL0NJSU1pc25NdkdjVUU2cXJGV041?=
 =?utf-8?B?b280MURUVzJyaVRtd2NRLzdzc09DQ3dpc1YxYW5POE9rT2syNzBhbXlveit2?=
 =?utf-8?B?UDlWQjRXSzR5MEthc3N6T2pDS3lvS3NWQ2FWZmhvY0dBS2lVVC9CQ1F4SzJ0?=
 =?utf-8?B?VnFZNzFwT1YyTFVVNkx0Y3ZnR0JvTkN0bTZvSHN5Wk5xK0hQT0dCRDQ0VWpS?=
 =?utf-8?B?NjJvTXdSQVIzNDlhMlE2dUNoanI0alhmT1FBL1d5T1ZMZFVwajJmWjhOc1Z2?=
 =?utf-8?B?bkxuMlFYY0xJaGhEcHQwQTBMNDRBMkllMytaUHkrMGkwanBLbjBIbEdvUHg2?=
 =?utf-8?B?Q0ttRElCVUVWamlMSjh1V0ZTTmx1aGVLUHJ6TWdObXVpSWVKcUtuQXN0SktJ?=
 =?utf-8?B?VDNsaTlpZ29nZjIwVnZYdW0zSWJuU2VoNDFoYWExT3cwR3l4SFM4R29CMWVL?=
 =?utf-8?B?YkswQzVxbERtbkJ3MTJkRzdOSmpZQ1VJSGwrbllhek9DOXVFWmpjWG1YaUl6?=
 =?utf-8?B?RWI0aXZVdGdlVm9NUHBEcjhSbXVrSXF0MnRmTmh6RVlOdlRGSytRQlA4NkJK?=
 =?utf-8?B?bW41Z3JXcldKOEcrTG1YRE5XV0tsUURQcko5UnE1UDUxeVVKQk94Q1dtSXZV?=
 =?utf-8?B?R0l0RXkvTDlqQUNSdFp0RzROOHMzRlpkUjJSZm9NTFRMSThXT0t4QTc3QjFt?=
 =?utf-8?B?b2l0OTVERWFRd1hXRjQ3UytGOWNheU93bTJEMVh1T2FpSmZsRnJEV1Q4Z3Vp?=
 =?utf-8?B?Nk00aUoyYjNuQnRDaWJ2ODVzWmp2b0IvVjRyeG1VMXFaaU5Ub2pRRzhiOXNi?=
 =?utf-8?B?Z3IzYWdsbGNlYXVSeVpnMDNBWkxFU2VpOHd1TGJCWUVDaUYrb1JYdXBnbDV5?=
 =?utf-8?B?cG9tUFlPRjFLZHplN25ydDFZN0hPUnAzZml6RXRXd2MzZ2dtZ3QvWWU2RHYz?=
 =?utf-8?Q?vk6NNmBfWKkLmy/cKiJJ/8Iax?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76758cea-e447-4f2b-29f3-08ddfe550c23
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 06:05:38.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT+L8Ujm7wq79AZWI+k4VlsPFcOhKhT31+bWEGW/Dke+ccxtxIiPG+6ELhwR9Kej3kyT8oTp0kqlnakItniE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6476

Hi Jerome & Martin:

Sorry for the imprecise description of the glitch-free mux earlier.

Recently, while troubleshooting a CPU hang issue caused by glitches,
I realized there was a discrepancy from our previous understanding,
so I'd like to clarify it here.

On 10/8/2024 2:02 PM, Jerome Brunet wrote:

> [ EXTERNAL EMAIL ]
>
> On Tue 08 Oct 2024 at 13:44, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> Hi Martin,
>>
>>
>> On 2024/10/1 4:08, Martin Blumenstingl wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello,
>>>
>>> On Sun, Sep 29, 2024 at 8:10 AM Chuan Liu via B4 Relay
>>> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>>>> From: Chuan Liu <chuan.liu@amlogic.com>
>>>>
>>>> glitch free mux has two clock channels (channel 0 and channel 1) with
>>>> the same configuration. When the frequency needs to be changed, the two
>>>> channels ping-pong to ensure clock continuity and suppress glitch.
>>> You describe the solution to this below:
>>>> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
>>>> switchover to suppress glitch.
>>> It would be great to have this change in a separate patch.
>>> The clocks to which you're adding CLK_SET_RATE_GATE aren't switched at
>>> runtime in mainline kernels (at least I think so).
>>
>> Okay, I will separate it into two patches and submit it in the next version.
>>
>>
>>>> Channel 0 of glitch free mux is not only the clock source for the mux,
>>>> but also the working clock for glitch free mux. Therefore, when glitch
>>>> free mux switches, it is necessary to ensure that channel 0 has a clock
>>>> input, otherwise glitch free mux will not work and cannot switch to the
>>>> target channel.
>>> [...]
>>>> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
>>>> has clock input when switching channels.
>>> This describes a second problem. I think it's best to have this in a
>>> separate commit/patch.
>>> Also you're updating some mali clocks (e.g. on G12 and GX) but not all
>>> of them (Meson8b for example is missing).
>>
>> Yes, M8 missed it, I will complete it in the next version.
>>
>>
>>> I still have some questions to the CLK_OPS_PARENT_ENABLE approach -
>>> please share your findings on this.
>>>
>>> There's multiple clocks involved in a glitch-free mux hierarchy:
>>> - a number of clock inputs (e.g. fclk, xtal, ...)
>>> - two muxes (one for every channel of the glitch-free mux)
>>> - two dividers (one for every channel of the glitch-free mux)
>>> - two gates (one for every channel of the glitch-free mux)
>>> - the glitch-free mux
>>>
>>> When switching from channel 0 (which is active and enabled) CCF
>>> (common clock framework) will:
>>> a) on channel 1:
>>> - find the best input clock
>>> - choose the best input clock in the mux
>>> - set the divider
>>> - enable the gate
>>> b) switch the glitch-free mux
>>> c) on channel 2:
>>> - disable the gate
>>>
>>> To me it's not clear at which level the problem occurs (glitch-free
>>> mux, gate, divider, mux, input clock).
>>> Also I don't understand why enabling the clocks with
>>> CLK_OPS_PARENT_ENABLE solves any problem since CCF is doing things
>>> automatically for us.
>>> Can you please explain (preferably with an example) what problem is
>>> solved with this approach?
>>
>> If CLK_OPS_PARENT_ENABLE is configured in mux, 'new_parent' and
>> 'old_parent' will be enabled first when __clk_set_parent_before() is
>> called. And disable them at __clk_set_parent_after(). Our glitch free
>> only has two clock sources, so adding this flag ensures that both
>> channels 0 and 1 are enabled when mux switches.
>>
>> In fact, we just need to make sure that channel 0 is enabled. The

It is indeed necessary to enable the glitch-free mux on *both* channel 0 
and channel 1 to allow proper switching. multiple original channel clock 
cycles and new channel clock cycles will be filtered during mux 
switching. An example of the clock waveform is shown below: __ __ __ __ 
__ __ __ __ ori: ↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ |__↑ ^ 1 * cycle 
original channel. _ _ _ _ _ _ _ _ _ _ _ _ new: ↑ |_↑ |_↑ |_↑ |_↑ |_↑ |_↑ 
|_↑ |_↑ |_↑ |_↑ |_↑ |_↑ ^ 5 * cycles new channel. __ __ _ _ _ _ out: ↑ 
|__↑ |______________________↑ |_↑ |_↑ |_↑ |_↑ ^ ^ start switching mux. 
switch to new channel.

>> purpose of CLK_OPS_PARENT_ENABLE may not be to solve our situation,
>> but adding this flag does solve our current problem.
> This is last point is important.
>
> It is OK to use a side effect of CLK_OPS_PARENT_ENABLE but it needs to
> be documented somehow, so what really matters is still known 2y from now.
>
> Make sure the information appears in the code comments at least once.
>
>>
>>> Last but not least: if we're running into bugs when
>>> CLK_OPS_PARENT_ENABLE is missing then that patch should carry a Fixes
>>> tag.
>>
>> Thanks for the heads-up. I'll keep an eye on it in the next version.
>>
>>
>>> Best regards,
>>> Martin
> --
> Jerome

