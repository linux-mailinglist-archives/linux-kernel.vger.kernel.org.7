Return-Path: <linux-kernel+bounces-855472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82801BE15B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C468A19C52BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496B61F4CAE;
	Thu, 16 Oct 2025 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="CVyseESf"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022143.outbound.protection.outlook.com [40.107.75.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36F1EDA03;
	Thu, 16 Oct 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585244; cv=fail; b=gFbU0useuxkDNIzfAmSiTXYIMEZiy1aAkgufVm/mx7vi1nnQE3KKc4uP0WTJBpm/XbhHPfFCZMgHvRkSz6trN0YWWYZBqSG+K8RGLMbaRcjbS8Nz5huLwUttXWeYZyLxVq2VvH+8LBHXrkDWahwmA9g87uMAXJbYbk8IxVt5z/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585244; c=relaxed/simple;
	bh=tPj8r2BB482+GGpyGsfv+J83nJPGpigiAaghb8BENA4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E0QJnrspSQipm5AmMxGxD7Xbr4Gt/4aS9jdtOV1JhirQLRx1QFMtO44m49MECn++7Cx2jp0005NrZcuCjuyT9E5JOolF6z4Nye+2Fn+M3irkym6kkUzw/z9ndjrSrZe9IqlmnglkQcOorZX4W8bNIXaDzEPsSs3tCIOueeSoiK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=CVyseESf; arc=fail smtp.client-ip=40.107.75.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuVoGfR65PfvIwvDogAd8eS7IO86OLgkUhNp2RUQGCGPm/i96AH4Fohr1y83/YmnEuLxnstHSAQiwCwcezonsFYRXIQCNtUBSV3+KRW0ztV2Cfx+OdCr4uvh1VHU/GYmcVCJ6tn/oykYjVvCafxA0k+UbRdYJdjo4016G6W3+9xKc1nirYbrpJutZL2/f2VpJLj5UyHjXRuT6mGjYm//Vz9zXq3mB9nIhnxXmumkjnEvuS76nxkgZaRhyUwSIPX5j0YV5h/2omnlAgDNFVVCZOP9FhPEurFyIGaxAEEW3qkJqgW1TXZmPFQ6PJHDNZeHAuCmihcRORX/p+TgEI8OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPj8r2BB482+GGpyGsfv+J83nJPGpigiAaghb8BENA4=;
 b=oqFcyG201K7vlvm50Z4rrDm1MSGn4GMew1grfMBlRzsOMbS2XhIOTeOy67jWg4hsjcFicwu2z9sxrdsTwUXDb5xnv0ndNdYFsJzS84YuNZXNt6i/po4iyrsw2gj1CRfmnl3hw//wo3zDIGKVbovR2mgiHJcu4x0I66msb/igGWUV0Jtd2npUO8ZQ+lym01qtyLyOVZEdnUKqH66yZFexR4MmerpgpWTMH0/jenGJ41C9WNpqzyMruug1lYF5ot8FrxtwVhGWz0MJNShDXNZGde2TZn9W4EfxQJl28j81CpWawoi2IQYT92Xpv2AR4LM5Sd4WyaadJKjqkC2lw6VVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPj8r2BB482+GGpyGsfv+J83nJPGpigiAaghb8BENA4=;
 b=CVyseESfTyKAYiVUtPa8bUuW+nmvHyR2G9rfOUhrPNl9EKfZ/N4HHTBNQfjSU5pn2oaq3GRDXor+5euRbvA5py7NIMrLwTqG9ea6tT79mluCoVLfD5SDkNLfpYPqK76hDQQBlTti9UlyHzBiSVbRrzKYjAiPORJKDDOTBgJHYHxYxv1MZjPZKcvcVQGeqj9BypPv/kQ+E9o3OxAMKlCcdb6smwn4if49GuligR1lfVvhO86/o6O3yAMyCMR/HUGzdK5/tXvzeRCLU5D/cxNa3whVB0WVaaCQbGcseQ/ueilvYO8Re3c/Ef4Mik9UEkNvD2Cyi7sIYCIx0SHjbzj7zA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KU2PPFC11D1E7A7.apcprd06.prod.outlook.com (2603:1096:d18::4ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 16 Oct
 2025 03:27:15 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%5]) with mapi id 15.20.9203.009; Thu, 16 Oct 2025
 03:27:15 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v2] usb: uhci: Work around bogus clang shift overflow
 warning from DMA_BIT_MASK(64)
Thread-Topic: [PATCH v2] usb: uhci: Work around bogus clang shift overflow
 warning from DMA_BIT_MASK(64)
Thread-Index: AQHcPgOeFZznTW8WmEW6AGPvc9VqHLTEHQIw
Date: Thu, 16 Oct 2025 03:27:13 +0000
Message-ID:
 <TY2PPF5CB9A1BE6DC2C9DD1B9070425284FF2E9A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References:
 <20251015-usb-uhci-avoid-bogus-clang-shift-warning-v2-1-68532d2f6114@kernel.org>
In-Reply-To:
 <20251015-usb-uhci-avoid-bogus-clang-shift-warning-v2-1-68532d2f6114@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KU2PPFC11D1E7A7:EE_
x-ms-office365-filtering-correlation-id: 5e334284-4675-4551-3fba-08de0c63e5f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDhLU0pQeG9YK2sybnRqQ0ZSaUZBeXZHa0xibVNBRzR2N1NKZ2t6M1E2cTRS?=
 =?utf-8?B?TjRWRUxCYjh6MDlnR3BDVUdRT3drcUdXanl6WmNxNklCbDNhQXlQTmljYTJV?=
 =?utf-8?B?YjVncW5oYlhoT21RV1kxdjBxZHRVL0dkK0RQSkRZdkVNWENwNVVYQkhDbmxu?=
 =?utf-8?B?dnVQZXBGSzNkUHo0czNwOHU3STRSRGZvODAySG5WVm4rRVQ5TCtFVFNDQmlk?=
 =?utf-8?B?RE5idVVkQjFrMWRrN2dxQnBGWWdocTBRSlRORFNFUDlaMkRGRHFCYXdlcnlM?=
 =?utf-8?B?NElpZEhubmF5RTBtNzRSbXMxR2F1UHMwcHZuczRORU1abTVoUkZZMGFzYUty?=
 =?utf-8?B?L2VxczJMcTFseXhUS0Q0d0pjV0duQmdzQTBjbVJuSnA5OFRqNHB4endyMVJj?=
 =?utf-8?B?YUFtdXZUM1ptRVlEVWsrb1JuQnRXbDhPYlh4K0FhWGs1UDc2NWhRelBibXIv?=
 =?utf-8?B?bzgwZjE3emVzSWJuOVRWTktMV2JDaXlCTnU3VFdPc0h0TjRZdTkxbzBaRW5F?=
 =?utf-8?B?SmZlNGJNeXpCNFMyN1B5WTF6M2xCMENFYy9YTUNGVFV2VjA1VjNYYlQyRk1O?=
 =?utf-8?B?SS9Ocy9OUit1WXFySlJYVDVYYUI1MEJ1RU15ZWJaU2I4ak44V2Y5dmJDZ0JN?=
 =?utf-8?B?WTBsbnFPSlFkckpadEZoc1pFdGY4NVBaSHdLZHdHQWxrejNmZnhabm5PcldZ?=
 =?utf-8?B?U1p1RFBOOG1QdnZiS3hnMFphSVNZNGNqbGQvQXUwWnp5NzR3MHNWZjNRdnBn?=
 =?utf-8?B?bU9kRjB6ZzdtQTFkeTluTHBrekEwUjAvR3lyVmg4M3diNjlYeUQyOW9xY2VV?=
 =?utf-8?B?OHI3L2xLOGJRNUFrNE4zVWY5TlFtMWRzZUE3TU9CNzlPT0NIMUFxMFBCREZp?=
 =?utf-8?B?cW9mZ28xMm5ZTHVFTXFRaitFZldJTHNObnFsR1FsVlNXZTNaZEM1VjRxYkhn?=
 =?utf-8?B?SjNlZ1llWU5HdXJCdlpTY3pMQzhxeSsxZzIxTTZPUEFpVW1VVHc2TktEdVpD?=
 =?utf-8?B?RzJBNkpJQkZJZDlPbFFuWkw1dlkwZ1N3d0JoeE5lR1cybGxlbUhaU3QrelBw?=
 =?utf-8?B?NGdvWERwbzhBWUlWSlNyUStwaUNsV3ZSSTkzRFNsbGhLdEhYZktETmxjbWNk?=
 =?utf-8?B?L2pZbW1TKzM1K2ZtK0tVYnQ0OEQxMjkzenBGMUg0MVIrTEQzbWtlK1B3OUtS?=
 =?utf-8?B?MGRMOXRRTUx4WTUrRW4xSmtNL242MEdGclV4NFVCTHcyRlhMMzlKYlp2Z2lr?=
 =?utf-8?B?eHl4V2U1RjlCcTd2eHFHZ25vUGpTZmNGdU9oekJpS043Q0hrQ0tDNXFib3Fu?=
 =?utf-8?B?cXowdVZvYW5NYUZQbU10U01JRXhZeksrQ3o2MmY2TzF3UDR5Mk9lckluQjRu?=
 =?utf-8?B?TDYyMVQxUDllRy9xeVFWTm5wZ3BLTi9pTDZpNWVmeG1SZ2ludmNkVWxaWTNR?=
 =?utf-8?B?Ni9jRGNrYmtjZTJ4SHpzQWlNMWNHejU1bGo2clhNVUc2U3JaeTgweEdjM3VC?=
 =?utf-8?B?cG40TzlabXkzSjRZdlF3WVRlQnZzT0dQaUwwTUlCenpPNGJYS2F3K2FNNysr?=
 =?utf-8?B?d29wSU9mdG53bTZ2UlNHSGpHdVhFbHNvUHFuTG5IeWxkTTNOV1Y2YTgxQUVp?=
 =?utf-8?B?TkZUNG9mUkh5bEhWNGUwOERTS0U1ZFJlazdHbndBdkZrWHJSQko1NE5vUzhv?=
 =?utf-8?B?Q3ZJVWJBN24wZ1JRY0Uva0ZrU0dkOUU3UXpkTWJtTTZ0eUc2TCtjZGxmaWxO?=
 =?utf-8?B?ZHRxYXk3UFJRNzdUYXUzaVRnbm5FMldJS0hnMXlvcDc2YTYzVVNNemxycHNu?=
 =?utf-8?B?WnNlNUN5RnZhWXdjaXdmVG5QOTdzK1pZMEpXR2JNYUV6RDQvemVDanI0U2JJ?=
 =?utf-8?B?aGF5TGwwTmZJaHVScmtScEQ4OVJtZGJLOTJTQjlVTWlwZVZ4UlY3bnJLalJ6?=
 =?utf-8?B?Nkp4eCtadlJPTFhRU25zbDBsNDdLM0poL2dOMytFMnl0VEV0TXZTTFNUWDky?=
 =?utf-8?B?TmdNZjF2RHJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnBud3Z1K09FcW9JS0dlQ3FLTVlYN0ZFV3RUNVVlbjBFQVNPV29KekM1TmQy?=
 =?utf-8?B?WTdUL01UQm8rSlF5WUd6cnBhNVRGOGZzb3Q3QllFRXQ2VGwzU1JCRVh3Vjk2?=
 =?utf-8?B?ZE1xd3hMRnhQelpGTXlmWHlxVzRZeEpxeko2Z1lXcERGZzZINER1QVlFRC9a?=
 =?utf-8?B?TEdNNlFuWFdobURUUkxER01xVzltaG1FZVYrQ01hZUg2V3pQZGhKckFGejhk?=
 =?utf-8?B?elRhNFBtWEtVbHNKZEdvYTdKa1o4RkFKSVMxbDhXc1NjWC90Mzc3QnJReE1j?=
 =?utf-8?B?TGNrcEFQRVM4NjZSZGxiYXdPQmpMdlprckZYT2t6ZUIvS2ZkYmNST3VHVkR2?=
 =?utf-8?B?QTR3b2JzYjdOL3VhbHorNGdTWm01bTl5ZHg3UGkwbmo1ZnFNOXYzU2o5c2F2?=
 =?utf-8?B?aEN6a1JtN2MvM0dTYVQ0TzFlQU1YbGR0YkNuWWpxclJ1SklWWkx2VXVpSjdx?=
 =?utf-8?B?QmNNNFVSMFc5YmF0S0p1MmtiaWVzYWRNc0Y0d2o0K3Q3TUxXdFVyWW5ORW9o?=
 =?utf-8?B?T2RNbWwrRDh0aFFDV2J4aVF0SGprait6WnRON2l3VFlUV1Vud2h0bkxnZmhh?=
 =?utf-8?B?V2tPYmRGYVNxSVgvS3ViU3Q3RURiTi9ucFRjcGdCMjV3R3RiRFdPMGM4UW5i?=
 =?utf-8?B?cEd6WmlQY0EwSVU3dWtBU2lrbnp6eXN1aFZ0QXRpUU8vN3RiRVlJdW5hck4w?=
 =?utf-8?B?VWN4bCtZQWtlT29abk9tQXZYSmxMU1loZU1qUmxqM2tzM1J5WlBwY3daYXJ1?=
 =?utf-8?B?WmRJMGRUS2JsV0ZUZnBLSngxTzViQXV6RUhhajhIOExMQ0RWK05wQ095djVH?=
 =?utf-8?B?Wk55SVRpQzNLNm1YRzc0Nm9lRGVRQlYyalI2d013Zi96dW0wc21RMlhibHBy?=
 =?utf-8?B?VGVFSitQbm1Rd0JPc1NEWlZmd3RUaUxOWk5FeVd3UWtjc0lJL25MTzB0b2Vo?=
 =?utf-8?B?TVlFVVpVb1Mwb3k3SHFiYjl6UkQwT1RMSmg2R0NveUtIVUxndXVXRERpRHFO?=
 =?utf-8?B?aTIvcDIwMnRQR1YrVDJyRTNHYW5BeWhxYkNKQnlwZjU0R21zVmxBWnRrbTh6?=
 =?utf-8?B?eVp3anRzU2M0Tmg2cEV3d3VmQ0s0QjJBakQzZWp6eWJOS09YUkFEUGZoc1R1?=
 =?utf-8?B?TDk5VVE0M21xN21ldjB3enVtNy9UKzh3OHBwclhxVVpLcE9wZHJTQ3h5WHlU?=
 =?utf-8?B?ZWhEVjdvS3NhZjRsM2h3UURaVXFtUGk3eWRJY1U2VjMxRHEwdCtIOXI5V0F3?=
 =?utf-8?B?SDFVOWp6RUdmcm5kVXVXMEhEeC9WcE9wUHhkWWFtM1Q2amJKYnNMNFExUm1H?=
 =?utf-8?B?NUtGb0U5MGNsV0JocWthUTlsc0NDalgrd2J5MjNOTjZKT3VCck1ZSjVYdTI0?=
 =?utf-8?B?bTJJZ0l0SnY4SzF3alF6bTFOcjduUE9GRXlmUTcrU25YdjFJNDk0b01wNnZz?=
 =?utf-8?B?VzRCOHpyRnpZallJeGhYR1hqbzhzZXhjU3ByRWFWT3pmUy8vc3JWdlo5emFJ?=
 =?utf-8?B?c3dBMTdhakJBejA5ZmN4cGxpOU9GTmZQZWlSZXNBZnV2ZThBbXZWb09XajhN?=
 =?utf-8?B?eEFXUEtiUVBqQWFGRTh5MEFzM3liUFhUV01GeG5MaUVkZklLVkRDSWdiRmdp?=
 =?utf-8?B?bVlKVi8yc3h3VFBXMEY4VzBObmUzU3czNFQzZEpMMXE0SlBNblB1SzdaVzBq?=
 =?utf-8?B?SWVlUnVhOTlpTW43dEVPQUtvWWE0eUx1NDU2czZPQlV2RlY1YnNtZlJSdll5?=
 =?utf-8?B?OWNPUExDRkxCTm1qLzlDVklocSt3WDAxUldEaXRreFM0QnBBSzZUZXdWdUVn?=
 =?utf-8?B?c3V0R1NuZkE1aDlzVGZOcW1kRXVmOHBrSXpLKy9GY25kb3pZQnYrMXlDQUpt?=
 =?utf-8?B?SmtGZ2llaU9jVFdCTTlTc05nVVUwNDgyTVErOUlKTVIwMWdmc08vbEx4c2Mr?=
 =?utf-8?B?TndlUVFLamJSZzNPYkNlWGgvVlJoUnA2b040Um9YeXFUNWJ6TDBPY1Zic1kr?=
 =?utf-8?B?UTVIdDdJS1EwT09PTndvRFZ3eHQzZlRDYzA1S2phbUdaSldoQnM3Zk5nK3Rr?=
 =?utf-8?B?Z3BFamdnVmROaUlOalMwNS80V3hCZER4VHluSFdrNm4rMHkwQ3pyWXcwRHd5?=
 =?utf-8?Q?kEWcAdqzppmdZOHqfumWm8KOA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e334284-4675-4551-3fba-08de0c63e5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 03:27:13.2252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OI+bwFH/MRF68+6MFfVYgpneCnIw88dQMBwQxvsmkQZ0jaT2nMpI8immkwDSM6mBir37Ik8AMdJS3MZ0zioowifRtk+rfsv+K/cNaGzSrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFC11D1E7A7

PiBTdWJqZWN0OiBbUEFUQ0ggdjJdIHVzYjogdWhjaTogV29yayBhcm91bmQgYm9ndXMgY2xhbmcg
c2hpZnQgb3ZlcmZsb3cgd2FybmluZw0KPiBmcm9tIERNQV9CSVRfTUFTSyg2NCkNCj4gDQo+IEFm
dGVyIGNvbW1pdCAxOGE5ZWM4ODZkMzIgKCJ1c2I6IHVoY2k6IEFkZCBBc3BlZWQgQVNUMjcwMCBz
dXBwb3J0IiksIGNsYW5nDQo+IGluY29ycmVjdGx5IHdhcm5zOg0KPiANCj4gICBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gZHJpdmVycy91c2IvaG9zdC91aGNpLWhjZC5jOjg1NToNCj4gICBkcml2ZXJz
L3VzYi9ob3N0L3VoY2ktcGxhdGZvcm0uYzo2OTozMjogZXJyb3I6IHNoaWZ0IGNvdW50ID49IHdp
ZHRoIG9mIHR5cGUNCj4gWy1XZXJyb3IsLVdzaGlmdC1jb3VudC1vdmVyZmxvd10NCj4gICAgICA2
OSB8IHN0YXRpYyBjb25zdCB1NjQgZG1hX21hc2tfNjQgPSBETUFfQklUX01BU0soNjQpOw0KPiAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4N
Cj4gICBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmg6OTM6NTQ6IG5vdGU6IGV4cGFuZGVkIGZy
b20gbWFjcm8NCj4gJ0RNQV9CSVRfTUFTSycNCj4gICAgICA5MyB8ICNkZWZpbmUgRE1BX0JJVF9N
QVNLKG4pICgoKG4pID09IDY0KSA/IH4wVUxMIDogKCgxVUxMPDwobikpLTEpKQ0KPiAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
DQo+IH5+fg0KPiANCj4gY2xhbmcgaGFzIGEgbG9uZyBvdXRzdGFuZGluZyBhbmQgY29tcGxpY2F0
ZWQgcHJvYmxlbSBbMV0gd2l0aCBnZW5lcmF0aW5nIGENCj4gcHJvcGVyIGNvbnRyb2wgZmxvdyBn
cmFwaCBhdCBnbG9iYWwgc2NvcGUsIHJlc3VsdGluZyBpbiBpdCBiZWluZyB1bmFibGUgdG8NCj4g
dW5kZXJzdGFuZCB0aGF0IHRoaXMgc2hpZnQgY2FuIG5ldmVyIGhhcHBlbiBkdWUgdG8gdGhlICdu
ID09IDY0JyBjaGVjay4NCj4gDQo+IFJlc3RydWN0dXJlIHRoZSBjb2RlIHRvIG9ubHkgdXNlIERN
QV9CSVRfTUFTSygpIHdpdGhpbg0KPiB1aGNpX2hjZF9wbGF0Zm9ybV9wcm9iZSgpIChpLmUuLCBm
dW5jdGlvbiBzY29wZSkgdG8gYXZvaWQgdGhpcyBnbG9iYWwgc2NvcGUNCj4gaXNzdWUsIHNpbWls
YXIgdG8gdGhlIGFwcHJvYWNoIG9mIGNvbW1pdCAyNzRmMjIzMmE5NGYgKCJ1c2I6IGVoY2k6DQo+
IEFkZCBBc3BlZWQgQVNUMjcwMCBzdXBwb3J0IikuDQo+IA0KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0
aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGludXgvaXNzdWVzLzIxMzYNCj4gTGluazogaHR0cHM6
Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1ZXMvOTIgWzFdDQo+IFJldmll
d2VkLWJ5OiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiBTaWduZWQt
b2ZmLWJ5OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQoNCkFja2VkLWJ5
OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCg0KPiAtLS0NCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gLSBTbGlnaHRseSByZXdvcmsgc29sdXRpb24gdG8gZm9sbG93IGNvbW1pdCAy
NzRmMjIzMmE5NGYgKCJ1c2I6IGVoY2k6DQo+ICAgQWRkIEFzcGVlZCBBU1QyNzAwIHN1cHBvcnQi
KSAoQWxhbikNCj4gLSBBZGp1c3QgbWVzc2FnZSB0byBtYXRjaA0KPiAtIEFwcGx5IEFsYW4ncyBS
ZXZpZXdlZC1ieSBmcm9tIHYxDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9wYXRjaC5tc2dp
ZC5saW5rLzIwMjUxMDE0LXVzYi11aGNpLWF2b2lkLWJvZ3VzLWNsYW5nLXNoaWZ0LXdhcm5pbmct
dg0KPiAxLTEtODI2NTg1ZWVkMDU1QGtlcm5lbC5vcmcNCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9o
b3N0L3VoY2ktcGxhdGZvcm0uYyB8IDE1ICsrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9ob3N0L3VoY2ktcGxhdGZvcm0uYyBiL2RyaXZlcnMvdXNiL2hvc3QvdWhjaS1w
bGF0Zm9ybS5jDQo+IGluZGV4IDM3NjA3Zjk4NWNjMC4uNWUwMmYyY2VhZmI2IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9ob3N0L3VoY2ktcGxhdGZvcm0uYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9ob3N0L3VoY2ktcGxhdGZvcm0uYw0KPiBAQCAtNjUsMTMgKzY1LDEwIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgaGNfZHJpdmVyIHVoY2lfcGxhdGZvcm1faGNfZHJpdmVyDQo+ID0gew0KPiAgCS5o
dWJfY29udHJvbCA9CQl1aGNpX2h1Yl9jb250cm9sLA0KPiAgfTsNCj4gDQo+IC1zdGF0aWMgY29u
c3QgdTY0IGRtYV9tYXNrXzMyID0gRE1BX0JJVF9NQVNLKDMyKTsgLXN0YXRpYyBjb25zdCB1NjQN
Cj4gZG1hX21hc2tfNjQgPSBETUFfQklUX01BU0soNjQpOw0KPiAtDQo+ICBzdGF0aWMgaW50IHVo
Y2lfaGNkX3BsYXRmb3JtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+
ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAtCWNvbnN0
IHU2NCAqZG1hX21hc2tfcHRyOw0KPiArCWJvb2wgZG1hX21hc2tfNjQgPSBmYWxzZTsNCj4gIAlz
dHJ1Y3QgdXNiX2hjZCAqaGNkOw0KPiAgCXN0cnVjdCB1aGNpX2hjZAkqdWhjaTsNCj4gIAlzdHJ1
Y3QgcmVzb3VyY2UgKnJlczsNCj4gQEAgLTg1LDExICs4MiwxMSBAQCBzdGF0aWMgaW50IHVoY2lf
aGNkX3BsYXRmb3JtX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
ICogU2luY2Ugc2hhcmVkIHVzYiBjb2RlIHJlbGllcyBvbiBpdCwgc2V0IGl0IGhlcmUgZm9yIG5v
dy4NCj4gIAkgKiBPbmNlIHdlIGhhdmUgZG1hIGNhcGFiaWxpdHkgYmluZGluZ3MgdGhpcyBjYW4g
Z28gYXdheS4NCj4gIAkgKi8NCj4gLQlkbWFfbWFza19wdHIgPSAodTY0ICopb2ZfZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiAtCWlmICghZG1hX21hc2tfcHRyKQ0KPiAtCQlk
bWFfbWFza19wdHIgPSAmZG1hX21hc2tfMzI7DQo+ICsJaWYgKG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YSgmcGRldi0+ZGV2KSkNCj4gKwkJZG1hX21hc2tfNjQgPSB0cnVlOw0KPiANCj4gLQlyZXQg
PSBkbWFfY29lcmNlX21hc2tfYW5kX2NvaGVyZW50KCZwZGV2LT5kZXYsICpkbWFfbWFza19wdHIp
Ow0KPiArCXJldCA9IGRtYV9jb2VyY2VfbWFza19hbmRfY29oZXJlbnQoJnBkZXYtPmRldiwNCj4g
KwkJZG1hX21hc2tfNjQgPyBETUFfQklUX01BU0soNjQpIDogRE1BX0JJVF9NQVNLKDMyKSk7DQo+
ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+IEBAIC0yMDAsNyArMTk3LDcgQEAg
c3RhdGljIHZvaWQgdWhjaV9oY2RfcGxhdGZvcm1fc2h1dGRvd24oc3RydWN0DQo+IHBsYXRmb3Jt
X2RldmljZSAqb3ApICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBwbGF0Zm9ybV91
aGNpX2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZ2VuZXJpYy11aGNpIiwgfSwNCj4g
IAl7IC5jb21wYXRpYmxlID0gInBsYXRmb3JtLXVoY2kiLCB9LA0KPiAtCXsgLmNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI3MDAtdWhjaSIsIC5kYXRhID0gJmRtYV9tYXNrXzY0fSwNCj4gKwl7IC5j
b21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLXVoY2kiLCAuZGF0YSA9ICh2b2lkICopMSB9LA0K
PiAgCXt9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgcGxhdGZvcm1fdWhjaV9p
ZHMpOw0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA4NzdjODBkZmJmNzg4ZTU3YTMzMzg2Mjc4
OTkwMzNiNzAwNzAzN2VlDQo+IGNoYW5nZS1pZDogMjAyNTEwMTQtdXNiLXVoY2ktYXZvaWQtYm9n
dXMtY2xhbmctc2hpZnQtd2FybmluZy1hODAxNjZhMjQ0NzINCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gLS0NCj4gTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KDQo=

