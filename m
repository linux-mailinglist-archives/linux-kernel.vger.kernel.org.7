Return-Path: <linux-kernel+bounces-770136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C4B27759
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B25AA5228
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6F294A10;
	Fri, 15 Aug 2025 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DOG4qGbp"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1A1A9F8D;
	Fri, 15 Aug 2025 03:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230195; cv=fail; b=qBen3XjwDahNUmPFGTdvyS6xsiBJoKztnaGXd3otLLigVJE8kK3OYoBoLvJOkj2RefDu9OYpSGYmpSHMpfDkbaeOkjBu8/dbrfioGVQrOx/VLqiW0Ioss6skKhEZGdGUFtpVq/Nn/KH+A/a/SO8SPsmGd8/qMz2ETyxxoJNc784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230195; c=relaxed/simple;
	bh=vdUs4U5EUPWfMz3GZtw3UZrRC+VexJgI/Pjnl7D6I/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mo9I5d4tEK2T02xL8mWTdOT1KlEocJhR65bPDuQOYtjsUht2FKUgtKgbXakz53jFXHLBQD+dHXYW+Dm0qDJquYJyXN0OXhLFjZhq2534vfM5JXFvxr9B0rCx9jJ3gUlFgOVDo+nEMHfTgN7eLa1czNwbEnKNSxi5jM1oottwja8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DOG4qGbp; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/asgog9RutJ71WLisDsDtljy/r2ubafh6u9GCo0QpJwVnfcd8QZnkvtuPv9ruuXdMcYKF5RsAHO4gmNaMXkoOrkFqv0WBpmfVvjukYYI+TMIqtVYFhUrowGNMFay1ZqEFdtwnS4ma9apB7kiOvarU0pcMFJQ03rn7fN+NYA4fBPQlGhs/i45B/pAe67WamRQmYaATlKUJQO3JLl8Qmc6SGcBdafDIiGKv1ERtmlwrZJpO6bD/uFobIVVljTttDSY/xbROPrLDX23ZqwjRHopuwoSEI5juquaUjL3BLFiVEx0mnohBpOxPncZcYJGjKEEFLF3+531d+ZyexsUWQlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TraJO3CMRHBAbq5bzAZ9rCfXx0rAiCPEMahexg44eS8=;
 b=QWvviUINpUWPAxTwxJJTd/y7pv/CfMLnm+phTM4MFIRd4fzDTcf+obJzsIMIoX9qra3gf0IlFtUXaFwQtepEdOW2ya4/f3gDbtSBsnnnDqnX6TAgdgPyBisbqxaHE0OhUaJCW7664hmvNY704VMjJTN++gHl/Wr8Uiogkj6iyCWQng4FjkhYLFqVt+w73WHPwC6UCZOMagiwcLD0SkCrnSw3zcp0LwJFVYo89rw6yvubNQPpzZw5lRnw4VfcYRdRCdsA0guCclgwq+/0v44FjDVfGrK1C1ZZiPupAClKcwL9wJE7eFOsurLtnx8104vKiMXuvXUAVDHQ7X9gYYfzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TraJO3CMRHBAbq5bzAZ9rCfXx0rAiCPEMahexg44eS8=;
 b=DOG4qGbpUHR9e2A0cJkfwXC0Sw9w5P1LaAhBVp+DRazrh7cRWpsSRXKIpZlAzagW6/yoLcdDsb4BXvIxOz2oHMNeA03RNEtmPb0S0m7y/5yX+Vsx8U/DMfi/VNbazpEf7asvDH3TD8e2+wP4vTKKiRsyHoEdRhAYq7sHXYjCnF0aFHQJ6tTBcmf/UN1rryoyM4uKTZdcrbpAEceDGtrfhmzeylagr65emicWnmQ+t84iopF1AbeqghtXS7E87pB4Qctd5fE6W3tNA8om5C/MDpmNaWFHt1sMCciYJA90mb+X4xmvScqBKzTbrF0rkOwGW4SH6alApXpSqKkjCHhdyw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAZPR01MB7182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:50::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:56:27 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:56:27 +0000
Message-ID:
 <MAUPR01MB11072CB6BD1EC94B752AA1F8BFE34A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 15 Aug 2025 11:56:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V2
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <rabenda.cn@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
 <20250813-sfg-spidts-v1-4-99b7e2be89d9@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250813-sfg-spidts-v1-4-99b7e2be89d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <68bd5d2c-a0fc-4c6f-aa10-e96d465a91fa@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAZPR01MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 25009a19-f415-4920-00ef-08dddbafb582
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVWrg+fxRScxfg9v9HXnUFlR7U3F9NJo7cHUaxpJx1q9TL8Jgh37IFkCDZ76t4Mco/iL5UULLoOowvQP4+7q/ePKQ40BsuU2i7zflXMkGIjAv40Q8/JPJXJh3hjWlMgJwXYPyjSb8hI+cUr9BbkLuVF74QKP/bXimNsXjiqhcR+l4Qxj5wjF0vYEV4hOgYV6x4ZXMXOUjtoaR3Wgb0ifUj3oJxsqE3upairO/leinzPmCpVW9Pul+tloCno9QYX+84jRaTF3Kmre3iUYR96SFbB0gQEoXRxo4DuHOFAtb7D68hUGQMRGmicmV/xHXfGEqTQZ0oYXoWfl0JylezMpiwZn/ISi4E5vtdR+VFO5fRur5zKRYFUKYMZF6FZUfe+aHJ6+lF1iGNfeYjPhpmUPV/DCCxZ82ZuqYvL3omZJFj2ioVkwGn+SVDJUB5FjKh+LDesHYkBZPADE3GZtdQpLbfhmfrRdpbQFAjksgKi9b3CAJwZch7LFC6kUqUjUJ8ugWwUxG4fxm1CNFodT+gv6fb4DnsmKMRWa4tJVUtPj422JhzjVBRMgpwuh4YmGA8lEwsoV+gTt8BU6tQFOIXfcoirXAFouEaCmgEqy6x5bkvNXFB1VP5O/EYGdDr9nLncHQthqeQLPjSp+n9bQEriDKK51e73NW2b6FfOA01Ms6QrMfKJPsNIfWerRZSsesZ8ETDPf33vC6lKS3orixu/a4uRMqP/Wwf6enmg5ENc4xYhsIk9emrR0gXGuwVMA29YkyyEp3WG3QETTcQ+S3HsVWE9f7UMAroDB6w=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|19110799012|6090799003|8060799015|5072599009|461199028|3412199025|39105399003|40105399003|41105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0p0Nlo1WDVwTUw4czd3MWhHTTBTSy9kd2s0REZGYytnR241cng5Z3dqUmpz?=
 =?utf-8?B?N0xNREJSVXRIL0FZUzRHRjMwYmNmMElnU0VKVTR6RE5ndlN4K0wyRDhoY2sy?=
 =?utf-8?B?cTlhZHlxY2R1ZW9RSjZrTTZuYXFVOUJOaXpONUdXRWZLcjNRT3h3ZnhQaFNP?=
 =?utf-8?B?UStXZXlOeVFZSCtnSllKRjlKSHViNE9PK2ZPMXBlMVoybDRIV21jZy9YcHYr?=
 =?utf-8?B?Zjk3S1c4L05sN2JTbzlaRUYxd3VtVFNKMVdLbzR6bk8ySTlRVHMvNTFSSVVP?=
 =?utf-8?B?MVM0b1ByWVlOYzRrSFN5QzQ4Q3ZjK2Y2T25XYlFNcklYQVpXaHVsRk52WTJr?=
 =?utf-8?B?dTN6dGZ3bFVpazNUUjMwVm01OXZoOWJxRWtnSTVLOWMvU2R2N3pqL2pFK1gw?=
 =?utf-8?B?U3dwVy82Z0cvWkpESFVPKzF1R2oyWDRPcTRtSVkxNitHTzhVWGYzMDFuaFZY?=
 =?utf-8?B?ZnVzUno2Sk9OOGNvNVM4TmNSZHd4QnZ3dXJZU3lxclAzUm40NkpRTGNHbFRB?=
 =?utf-8?B?bnh1ZWRHVFdoUGZKS280MTQyNUlFak9iU1pHOXdzWWl5dzBiNFpyUDViVW96?=
 =?utf-8?B?NlhoUWZoVGhBU1lSQzlTTXpZR3JET3FvOFFRQmxsTXpqSDVtZWgreUxFalI0?=
 =?utf-8?B?azJmd2szTmw1bVJlZzg4MWRNQUl3M1NDSUhXTW5sU1Fwc2lZU2NlTVQzYVB2?=
 =?utf-8?B?WXhCOUw4NUNUV3VNcXR1QkhvN1BFZG95Y092VjBOYnA5eDdSSDRSK1dqQkY3?=
 =?utf-8?B?cGtidmFmVG9TeDBlbkRXRXpSOHp2eG9UckM0Wm0vd0VkclJBWWRGMnM0MTEx?=
 =?utf-8?B?Lzg3d1lNUXorajhBYnhlYTVlZDlhVlE2T0pEazBlZ0paelE2cEcxU0YrY3cz?=
 =?utf-8?B?cjFXdEdjaGdYY0ZEdHlUUzdEbVVmNzI0eW9VVGJDR1pVZ2Q3QVpSSUtNVEtN?=
 =?utf-8?B?cnZINEZ4RDNVL2p6dGhhaVJEMXRCc3BFUXYxTHNMaUdVSHVWMzNTa0p6UEpF?=
 =?utf-8?B?NGdXcWJIWjV0NGx5OGJBazJzamFLSXNzQkpZVzRRR1p3YmM2SU1hYWsyTy92?=
 =?utf-8?B?QTVCT2ZpcEVuL0pLa0FSQTNUZUVScU52QWszUGJTQ1ZGaFBVbE10SjFDWWgw?=
 =?utf-8?B?MUJJZk85bXY0K0hrd2Juc2ltQUNWVWxnZHZuMWIvN09sQlgyTkdiZVJpWUli?=
 =?utf-8?B?VFhYdzFwc0hCdkhpeE1BMDhGTmloT3gzQmI2UFEvaWFFVUZJMGl0aThKeExF?=
 =?utf-8?B?ckNNK05tWndFSk1pOXVKM3NWWU5JLzRMdU5JUjhwclNPRGJQM0xHd0hyZDBR?=
 =?utf-8?B?Mnh4S3JkWC9nckxVMTlvTU1qL2FPWEV6MUREbmJmUmZuNG5rU1dNT0Q0Y1du?=
 =?utf-8?B?WFd2NjZxS1d3dGdITnFiekdQS1VCK2l4SFVWSW14K3FUaVRKRlI2SHRETUc4?=
 =?utf-8?B?d1R6eDVDNitMRDBwTEhhVTIxL1FDNU5hN0FDRlRUWmpVUitlQStrWit1RFNx?=
 =?utf-8?B?bmJEMjZoMmVZdGZ3eGhhVW1VMjZiUi81cU9sRGFIeTNMZG9TU0VwTkVhdlMx?=
 =?utf-8?B?anRLNyt6d0hBOS9jTXllemkvcUUvcTg2TjFIcnBqbG5qQUFvQlgxc1FYQnpv?=
 =?utf-8?Q?LWlm3BZSxrHIse3DkrgBED9rx57vPAl50ULUGn77s5NY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3FQOElxY09YMFlqN09IbGh1bHB6dy9NQ1VOYm9KWkpBWnRMTVlKU2IwR3VG?=
 =?utf-8?B?QlA1STkwNTlyUmFYVWRDRVFOYjVzSDZDMWE2STJBbllRU1dNMFlJeUdFOFMz?=
 =?utf-8?B?MkxUbUV2d0Z4T3dDNDdrUW5nQ3h5N3ZIa0Y1ZjdNZXlQN0lPQndPZ2VMNGZI?=
 =?utf-8?B?M2hZUDNrSGVrQnJobW45bXhTSzZDQ2IrSTMxSTBPR3dtQU5kdElsL0VWMkpp?=
 =?utf-8?B?RnZrSWtneEVqMC9tVlNUS2wvRys1MmovQnY5d3FWMWtzTkpHZzRkTlRnZXV5?=
 =?utf-8?B?WDVlUS9nc0lCQ09QRTlyUHZ2Z1g3cVlmMk5tdzlyTThQQWdabGkyZkNXdENW?=
 =?utf-8?B?T1UxMktEbm8wMTIya3J2TExJR1pSUmJLaFp6Z2JPeFBEb1N1aXRuOEhSY1pU?=
 =?utf-8?B?Y2c4TjhHTXI2WWhMeUl2V2p1S25sbGVkajlhbzBGTTl4T25jUlZoL1NocDFL?=
 =?utf-8?B?cit5ZURqNXZmVjZtK211NUFqSlptNmJzc1hoT3lDYm1HNmhjSWFVNk5INSta?=
 =?utf-8?B?M1VjcERtQ09xc0VoQnZnNnNZT3REVXJzcktLWUhNK3hjOG1jZ2lzRzMyVzRP?=
 =?utf-8?B?NFkzdXlBZnBMdllkSGliQTBMd2M3Y1RFeTN6MXZlSFhmQnUwUFkzNkpTVFNi?=
 =?utf-8?B?R245Z3pqalVFdmdRVGVNbmlMWnN4bzRPeEZ1QTErdWh5U2Z3NnNkT2c1UzZU?=
 =?utf-8?B?YzVoTW9RM1JpOXF3djM5Mmw5S3cwZzVyd25oaXh0VGliNU96TndxNnRzSzRT?=
 =?utf-8?B?VDhFQ2tPVHFXRW56TlNpNzYxRjFCSVRUa2RuekxzSm42Z2NnMDhVaTVzRCsv?=
 =?utf-8?B?ZHB4QVM4TUxwVDdjT0lSNVMrckJKVWd5dDU2RWk5RzUrbGloSWxoOG1qdElH?=
 =?utf-8?B?eXN1MzRZbjZXSmJIVEprTnNlL0RBbmNBeHpWbVplRFRRRmJhbzVlT3UzVEdv?=
 =?utf-8?B?TXl5OTN6b2tlYmo0QXF0L09PY04rOTJ3VncvNzd1Sk1XbGlZbzVPM0NjblBz?=
 =?utf-8?B?bFpxMWw5TG9MdkdCVGdkczNaU3NSbi82ZTNEMXpKSUowUGYvRUVoMjVEdG41?=
 =?utf-8?B?L1pjNjc4cEprR0lsMkdkWFV4QVJQQmhrellVc2RjeTZvQzBBdlRiV3d2SUtp?=
 =?utf-8?B?RENRMWZRYWZIRnFMMVpyYlZoS2gzeUs0S3JiWVBJUHlQQzhOd2JkVGVoWGhp?=
 =?utf-8?B?WnRndUFCanRpejc1aVMrejBKK2FSWS95OFpaUmh1NGxBMTVNdjBsNlYxayt1?=
 =?utf-8?B?YXF2LzVqV3ZlcjNZUmFTOWx2NHU1dC85K29VMUlrZEVyREs4NjdvbkZMeWRB?=
 =?utf-8?B?UnQrNTI5ZnFzSWxaQVMvaXdVVXozWi80NWJEa3dEVFhtSHR5SFFNQ2RuTVZj?=
 =?utf-8?B?OCsvcGs0eWNKRzREQk8xMGRuTlY4MTgvVjdQQis0YkcxTnJBSVNzT0twT2xu?=
 =?utf-8?B?YzFUNnBhazdVQ1NhbUdneUtGc01aaElHU010RGhxSGJORWl6ckV4bnB4eFNR?=
 =?utf-8?B?S1ZLdkF2ZjRmbkMyUFQ3L0lwdmZlbTBOcWFEYmFPUE1LL0p1cDdTRXNQSzhK?=
 =?utf-8?B?N1Y3YWVZZXJ4b0JySU92cWorRFZkRUtaRWVsY09pUmlJNjErVEU5bEVkOHMw?=
 =?utf-8?B?VzVtNWVGbnhjM3lPUkNKY1lCMmFKbzVaSUJldlVKaGRyRVpDU3NUNTFnRkFQ?=
 =?utf-8?B?VmdvRjFxdkVoSEJETnFmcWtLNDBGMmVrUmVDalFtU3pOaW9Fb0hLbkl3aWd2?=
 =?utf-8?Q?phcxUjYx0Os7tfFFeqcWr55bEwjPWYDJWKae15/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25009a19-f415-4920-00ef-08dddbafb582
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:56:27.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7182


On 8/13/2025 4:33 PM, Zixian Zeng wrote:
> Enable SPI NOR node for SG2042_EVB_V2 device tree
>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> index 46980e41b886ce17dacce791fa5f2cef14cfa214..7001d8ffdc3e04c5a5cd5da85a4fb1c0351eb9a5 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
> @@ -226,6 +226,18 @@ &sd {
>   	status = "okay";
>   };
>   
> +&spifmc1 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +	};
> +};
> +

Only spifmc1 on EVB_V2? What about spifmc0?

Otherwise:

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

>   &uart0 {
>   	pinctrl-0 = <&uart0_cfg>;
>   	pinctrl-names = "default";
>

