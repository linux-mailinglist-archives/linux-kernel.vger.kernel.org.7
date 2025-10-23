Return-Path: <linux-kernel+bounces-866041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4403BFEC09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C031C4E27E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA49619D074;
	Thu, 23 Oct 2025 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="wS7y02DB"
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02C2566;
	Thu, 23 Oct 2025 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179885; cv=fail; b=MCnhK4utCZnke9OZI3z7RAu0ZibYEIUfjaKP9hr87oPoan3gL7KDKat9lu4/xRU+XuHUmRyI+sXywF/vetBFMOzacB1S2GXs4QKHOCxwqvYgo+IFUJhxuFTeaqcLi4iXY2l5cUs31gWzz/HumyRwouVnsjag7TMoYs36fyV/ODk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179885; c=relaxed/simple;
	bh=6EPk/UqbZ1FRSs5fVYUGf9HNmPI7s8j27MAC1hL3ULc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r9xkvLEhpFCsZJFwnaStOgmwj0F7+TLSeBgSLULzsD/M6NVdu8j8rktxI7Xey68LVhGUeEGdrwJqZMqmsR5eMiNLW6x8KlkK9o3nFUX0q/igKRfdcqq16EiY1JG4s4eEoBEucgp7qYyA7SQ91HyUvZttJqjqHs10afAisg9xwRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=wS7y02DB; arc=fail smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1761179850;x=1762389450;bh=6EPk/UqbZ1FRSs5fVYUGf9HNmPI7s8j27MAC1
	hL3ULc=;b=wS7y02DBOPVGz3vKNyF1kx3UyOLZQVJL+2cywR1ZGvwPlUkXuBOR8KZ3oE7iNLRNaVT
	qeb6QlLr1uqKLB+LExroRQWa2fTgG2HsU7j6AmfvmGirfjAGVrw/bh5xfRvJ/gPnwgEsVEZf0W0u7
	1yGicMglQ4fEtSAUbMmI2JiIGxpfi0VNpOt80lzcYzfHUKxN4kVg3+Y6ibu1iu02tDRmE9WHlPj1O
	zKhIkBysi7jGmjjLUMgYs1tDVrZ2tLw5xjbaR7MeFGfRWj/gK8UXmZjsOQZs5MvyDt3EZodetUmav
	65JZAoY0XsJgEJTl605DocLwhuewBtC7RpMGG87hVm5g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 59N0bTSU2497160; Thu, 23 Oct 2025 09:37:29 +0900
X-Iguazu-Qid: 2rWhqFKk8FCXHZF6Gs
X-Iguazu-QSIG: v=2; s=0; t=1761179848; q=2rWhqFKk8FCXHZF6Gs; m=yU5Qw3XY8R3rI2mZLV2gFYF+vqx3S2VrNqGeQrDfo/A=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4csRvC5Q2cz4vyh; Thu, 23 Oct 2025 09:37:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g14h0BvaU3Q9Yd9nhVW9E65eJHCmfb3lgadIgpgeejNE26dlwm2syod4rMcXO/B4Dk2eydZNHSqvjUpLE/KtOfa7Hltvsd9XkAjz5rVvcOQdms5ukun3GwDJ/ytLSWLnDKXF9GkFbClPXCyXuiSFB7GNidZEj6uqDxTEAgHX8MA5IBvHRoxNEZrxuREywLK0NDWS2U5z87jbIv3KfrgqjOwaqCdayNFEl2StLI/sk/XNcp/Em7kQIvUkhdmETRl3O/rjT17p53PUWMwat2UdXZOCQVW+RD96GAFz9EGhIY91m3XdWCzdQDMoil07eek/zxCQqB1C8t3GRgWkUYB/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvSWCxrKUJbxiEGLp8mxIlvTRSdbPu22PwQxi11EPoY=;
 b=cvTNzHKz4M/EU1dDtv0b5Vvo4/UB5OCSBzVhYzjhnoDEFXSx06wnMz2HN0BaL8qtl8CQHRP0h2uiJbkqC72FYm8XaPmfQSsmbY9sb3177ce0zf5qwkTar39b2EWH4OpDCrg3Mrz49yaTq2jrOBhU7p/lJD9EpgoJXC5DrLWn05rKjyuDEdeKvPrza52LFc+9UxfLnUdCweDDvfOrwljEzM5wi323G3KxOxiwsaO5F19C9tZ3dn8I6R/aK+HcYX2EK3qDP+l8rLumScwfnFDE3cxi0tEtmVXoKeDY+hiDGeOxDDCIyxozs9zVFrR/AM7/xg+XkcURQUvbY+fAndBbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: toshiba: tmpv7708: Align node names with DT
 bindings
Thread-Topic: [PATCH] arm64: dts: toshiba: tmpv7708: Align node names with DT
 bindings
Thread-Index: AQHcQ1jhGap0CtwiZE2sd4AzlATOorTO4zPA
Date: Thu, 23 Oct 2025 00:37:24 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818346842A5155C5D82797DCDF0A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251022133616.74492-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251022133616.74492-2-krzysztof.kozlowski@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS7PR01MB15386:EE_
x-ms-office365-filtering-correlation-id: 74c2f2a6-dad7-4dbf-8c89-08de11cc560a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eWRVajJKdVlETG9VSlZRQTR2aGJSZkZiZjRSZGNRc3IyMGhPamZhZjBs?=
 =?iso-2022-jp?B?Q3FHc2UydHJxRlVvbXNwWW0wdzZVSHFXTjMvZGtHYjVlelpER3puaTY4?=
 =?iso-2022-jp?B?OFVGV3pLbXJxNE9ud3Y1Y2dtUUdmNFk4eENFZ1JhMHJSdXo4N21MbWZU?=
 =?iso-2022-jp?B?aW40LzJpQ1NkRUJvTDJPa2puSWV3SU5mNWdiMTF4TTFsUkVLcDQvdzlM?=
 =?iso-2022-jp?B?OVFUb0xKUDVFZjZIWmIyRWlXV0JNcCtFbzYyb3BUMFJZL2xpTW96NmVC?=
 =?iso-2022-jp?B?Qm5CVW9kcFI5aUVYbTd4Q2VVVWlVb2Uvb2dCRmU1U05EREp3V2xIQ2dV?=
 =?iso-2022-jp?B?RFlBY0VZRjhURjJoaktFVzJmS1F5V2pSc0VqQ2d6ay9EZnVDa2NFMDl6?=
 =?iso-2022-jp?B?T0JjUEVVVEhwaU5PZ2hUbE84WjB3dzFjVlExVzRud0hZVlg2UEY2Zy9x?=
 =?iso-2022-jp?B?SmVtWWt5QUVvcW5iWWtTSlYwbnJsR2hRYStUTklvRFZ2aUc1Z05PYWxr?=
 =?iso-2022-jp?B?MVhTc3I1aEJTQkRXUDlJUDF3YjBTNGV0UTFNZjdSbkMrZGdtVmhtMGJ3?=
 =?iso-2022-jp?B?b0FaZnhEYS9tUFVZMlNEa3k0V0pGNmQ3UVhKT3EzSWpTeHlGeWh3Uzcr?=
 =?iso-2022-jp?B?enJ0TmduMHZVUWNpZENNNHR3eUhGcU12RDhKVzBXQU5MN21SZHExUUhn?=
 =?iso-2022-jp?B?alNEMjB3VTZ5d0V5a1hLMDY2ekd5OHVXc20xcVM1d0M0SjM2VDRIVVZI?=
 =?iso-2022-jp?B?N0V3MTlXa1JLSUJId0FLNlRweDlOZWpBRlA0YXkrTUkzTkRock5Tejln?=
 =?iso-2022-jp?B?cGlYUzJSczBUWHlGTmNpWG0xV2JrTEU5WG1yUW1zZUJPUHFPSUtKM3A4?=
 =?iso-2022-jp?B?cW10dTlTbzdPWGEwOG9jR0YwMllGNHc3bW1jcWdKdlR4L1dRbElGVVhs?=
 =?iso-2022-jp?B?SzBRU1NYUnJzWElnQVZ0VnpPeWYvVC9iYm0rWTVpWWdGeTZoZ0EzU0ly?=
 =?iso-2022-jp?B?eG5wS3dic21DbUg5akdGTk9IdnFRbEVFRnFFZ3kzZlY1WmltY2pZU29E?=
 =?iso-2022-jp?B?Y1Qxamk1K2NpNGVXTWpRMVgzQmRxMTlFSEV2QXVDMTF0a01naDVJT2tJ?=
 =?iso-2022-jp?B?YkVKUTV5UzNhZVJTM1k0aGYvOGtsb09teEpyc1hSKzhJeUJXSHIwUm9o?=
 =?iso-2022-jp?B?cXV1Qlp5eitGeW9hdmt2aU9DZ1JMZUczSGhlR3pZc2ZKQXFmVG00TWhX?=
 =?iso-2022-jp?B?UFNNbTBubllDbzZ3VEk1SVNVVnZ2RDFCREpFU1J4VXo5TllkbTAvK2lh?=
 =?iso-2022-jp?B?enJ2NzV5TVgvWVFQcHFEVzFLak9PVHlpTlQ5M3NTRGsyUE1oa3RkUzJS?=
 =?iso-2022-jp?B?eHhBTEQvb2huZHQ2M1hqT1BQQWVxa3pYOXg0ZFdIVEk2Vy9mbCsrMVNs?=
 =?iso-2022-jp?B?aGlwY284Q29UNUNmVVZ3VkdxZ1B6NGU1WEo0amtiWUVjMDJsYWR0RVBL?=
 =?iso-2022-jp?B?MzdHMmdGT3c3a0tYUm03aStGVlhyaEQ1R09jWTNoeGFDSVlYcTBERUIy?=
 =?iso-2022-jp?B?SHp3YnYrMlRKRnVUR3c2b2pJM3pIL1BOeTkwUnJ1STRuc2lESkh0UWpZ?=
 =?iso-2022-jp?B?UEpZMjdzcFl1QmptOHhvRXZhT2RHb3p0Qm1ITUlRT0Qvc29EL0hKbkpk?=
 =?iso-2022-jp?B?aGR3SkVBbjVwY2gySWZKaktNQU0vRGhMZWlCY1ZzZVZNSEVFdHgvaSs2?=
 =?iso-2022-jp?B?L1Q5ZzVtcVR5ZWNMV3dNODd2VHh2LzZtSmR1bmlSTHpxQ0pzS2VqZEY0?=
 =?iso-2022-jp?B?OGo3Zk9xWTRDanRQREJsanVKMVlDQzdmOUlrZFI0RE9tdTJJS1NOajBR?=
 =?iso-2022-jp?B?U1MwRGZiYjl5YUJvRzBsWnZXTHh1TTg0ZWNvY0ExOTlUVmRzSVY0a2Mv?=
 =?iso-2022-jp?B?alVjZHJvblU3TWJUN0lzeXN5c2RBOE1YNERxZ3h6aHRURE51QzhyMmhu?=
 =?iso-2022-jp?B?akpJTFQ4eTZ0SS9uRVlwa2REaytzNnIxcUVTNGhqLzlsN3lrRXBnYTU0?=
 =?iso-2022-jp?B?REhsNitRUnFTU0x5cU92Q3hleWNURHFSTTNYNGY0d1JTbjZwTHZNQTlB?=
 =?iso-2022-jp?B?SjVHSHZNSStOL25yWlc1c3hXZVM0Ym9TZ1BUNjNBbjVUQ29EdG9zM3Bm?=
 =?iso-2022-jp?B?bzUzUGpXeTM0OGZwZS9OVmZzMlRMMEJp?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NjgrVzRsOVFmMlBIcXA1L3NGOW45Y3FGc0NDT2wyMUtvcElJNHdDR2hZ?=
 =?iso-2022-jp?B?bnpLTEdxbGlzOXRRcDROV0JBdlpHZVNYb05ZTmoreGRPTHBMV2hVRDA0?=
 =?iso-2022-jp?B?ZDFJQWM5K3pRYUtGWExRN1VHUXZJN2lIS0ExTWIyWFZhYlJ5eUVhZnpL?=
 =?iso-2022-jp?B?RkFGbGNMMzBkRThteDhnNWU0RERKZXhiMnl2Z3RIM0Y0MUcvVnFiVCs1?=
 =?iso-2022-jp?B?VEhqY2tJYUhmRGJwT1hndWltcGorR0hWN0U2V0VrNDJNdmlUSHlORUZ1?=
 =?iso-2022-jp?B?OHpXeWtSM2NubkMybk1rUzd3Smo1ZnRuOUc3UWhNVHBZTE1oUDhSaEdN?=
 =?iso-2022-jp?B?a0tPSGdFek44dGRJOWVrcWJMOHIvSFRRUllRM1FsQ1FEdG9BOWFsalNW?=
 =?iso-2022-jp?B?UWtUb1ZvNTIxS3ZoRkIxR0tlN2JHbGNqSDREMzdod2x6VGlRU2I3Rno3?=
 =?iso-2022-jp?B?VGFVQndsVERUbWU4K01mendSR1Iyei9JNjRiZEV3b2RRdFBGWGhkbFpT?=
 =?iso-2022-jp?B?d0I4MGVZZENoRnJJQXA1NDh3RWJFQkhQZDRmWmY1U1BNbjlvRmZYYTlP?=
 =?iso-2022-jp?B?dzVDZkd5VVVUcXNwM092cm1oaTI5ZDZUYU5iOTdhcWdMaDJiSml4VFdB?=
 =?iso-2022-jp?B?emF4bnhNWTIvc25hUXBMY0ZRdnlqZ1J6dEZza0JWZDZSb0YvQ0ZaN2Vp?=
 =?iso-2022-jp?B?YytXSzhadGFYTzBLRXNobFJMd1F2THZOWjRlcmJtQ3VTdmp1elBhN25y?=
 =?iso-2022-jp?B?Y21yOEVGV3EyWWVMd3o3OTg0R25Za3RWVkwvZFdVVHNvYk9GbzNrMUcw?=
 =?iso-2022-jp?B?YzAwR0QrL3BiZitIZmY2c2JjZUUrNDA3THBEbW9POEFvMGczNWVuRW1j?=
 =?iso-2022-jp?B?QnRXQWpzUlV3U2MyZ1A4TnNYK2lITEZJRmI1SmEzTXVrRkFockxhU0Fy?=
 =?iso-2022-jp?B?ZmJZdnN5ci9vcTMycU13elZxalltU1phbWc5VXVkam92TU5lNFdXbzJ5?=
 =?iso-2022-jp?B?YTgvTHpLckJKcVc4N05MSWhlWDVXazZ3clFaNmYyVzlXTWRPOHdQUnZL?=
 =?iso-2022-jp?B?N3c0S0EwRlFFQ29WZ0NPNnp4cmxtb0hwMXltSHFTSlgzc3Vyb29yQzM3?=
 =?iso-2022-jp?B?bk1xVVVRQVY5YjhsUncrajFjdm9weWZjbVJITXdCNFRGRlpCc292eStU?=
 =?iso-2022-jp?B?MHg0YStkVURKam5GSXluMmFxQTdpQm83Y3dVSmtwMzAxcUEwSnI3L2pH?=
 =?iso-2022-jp?B?ZXFOZGNEd1ZEMG1RbkErNVB4REk3cHJQcm5YL1A3a1NTUjdWRXZMblJo?=
 =?iso-2022-jp?B?SENicTZpL3M5dmRzTW1hdUdBWHZPcldQOFVZYVFjaDVCbnFJYWZNbjFl?=
 =?iso-2022-jp?B?NjFWU05BdkN2dWtEeG1ZMGFMSmtHdStJZ29LYU1uTHpxK3FrUmhhYmNs?=
 =?iso-2022-jp?B?V21iM3g5cVZld0JiTTNGMnkyTm52VEdPV21YS1A0cjA0ZkcwYVIrUFJu?=
 =?iso-2022-jp?B?UUlwQWY0QU9QVXdKWnEwb3ZEY0p3UWNpL2gvaXlQR3Q0Y2p0YlpQeHdi?=
 =?iso-2022-jp?B?eS9YRDhGeSt2VGtSVlZaZGpyWk9XalBaNThVTWtmZXJ5TEMzM2luU25G?=
 =?iso-2022-jp?B?KzhNZWhJMVhqTUJBamFxeGRsMEVZUUNEbVVGUXVRYjUwOTJ4aFpJekxI?=
 =?iso-2022-jp?B?YTBqWmV0STNOMFRGT21TWEhxNkdiUlJ0eDNtd1BoK3o1cVZnR3JmZTlT?=
 =?iso-2022-jp?B?S0dqRW56eHVtUmZrb3MwTDBsa054UFRNUC9FakVXOS95MU9MWlVjd2tx?=
 =?iso-2022-jp?B?QmdpZ2MrNERYZEMrNWlDR1J1MXZZZ3VQRXV2S2IxM2k5RmNQK2ZkQmlw?=
 =?iso-2022-jp?B?dXdyMVp4RkdLMUZMS3dZT3o3azhjN1NJSlVvd0RsVmdkWVJvSEVjVzJj?=
 =?iso-2022-jp?B?dHc1VFNPNWQyTE9OU0Z1QzJFTzQ4WkJXMDJiS2U5MnoraU5pYjVJQTdp?=
 =?iso-2022-jp?B?aVVrR0t6SFgxMDFJWUNhSElhSnVYMEtmeUhUQWloSENPWHNJT3hESlRa?=
 =?iso-2022-jp?B?dmxZM0EvekcyL2RqUzJXMm5NSUlKUnhqdFJOR0FRRS9TZFByUnBldlNp?=
 =?iso-2022-jp?B?b3JlYXNYM3hTcVdXb2pjRVBOYnpSaVJPaXJoU2dndmRWbUdJdVg1WU8w?=
 =?iso-2022-jp?B?eDNJc1pxQkZ5b2hEeU16cEVCQ1RiZ1dTZUlqU0tRaSt6dkxvcGhvMmpZ?=
 =?iso-2022-jp?B?UUE1amVlL0l3NWRNYmp6RHo5ZGxUWWJSNS9acVdDMFVwNEtyOGZha2pn?=
 =?iso-2022-jp?B?ZVFtQS9LOGJRR0k4VG13RVc5K3EvV3lhY2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c2f2a6-dad7-4dbf-8c89-08de11cc560a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 00:37:24.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdbImZmn0R+ZIOLrWjQ/2M2BpYsFyliBOHHKCVpTxZnmjIZLBG9NcOAQyxi/fAnKfnxcKk9XE0JGresTXRfxvxZal2m86zkozO7pa+qd5Yv+ARrMokGIqsV24+t4/sKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15386

Hi Krzysztof,

Thanks for your patch.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, October 22, 2025 10:36 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] arm64: dts: toshiba: tmpv7708: Align node names with DT
> bindings
>=20
> DT bindings expect node names to follow certain pattern, dtbs_check
> warnings:
>=20
>   tmpv7708-rm-mbrc.dtb: pmux@24190000 (toshiba,tmpv7708-pinctrl):
>     'pwm_mux' does not match any of the regexes: '-pins$', '^pinctrl-[0-9=
]+$'
>   tmpv7708-rm-mbrc.dtb pmux@24190000 (toshiba,tmpv7708-pinctrl):
>     $nodename:0: 'pmux@24190000' does not match
> '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>   tmpv7708-rm-mbrc.dtb: wdt@28330000 (toshiba,visconti-wdt):
>     $nodename:0: 'wdt@28330000' does not match
> '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

> ---
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi      | 4 ++--
>  arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> index 9aa7b1872bd6..88e38d6efcaa 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> @@ -161,7 +161,7 @@ gic: interrupt-controller@24001000 {
>  			      <0 0x24006000 0 0x2000>;
>  		};
>=20
> -		pmux: pmux@24190000 {
> +		pmux: pinctrl@24190000 {
>  			compatible =3D "toshiba,tmpv7708-pinctrl";
>  			reg =3D <0 0x24190000 0 0x10000>;
>  		};
> @@ -463,7 +463,7 @@ piether: ethernet@28000000 {
>  			status =3D "disabled";
>  		};
>=20
> -		wdt: wdt@28330000 {
> +		wdt: watchdog@28330000 {
>  			compatible =3D "toshiba,visconti-wdt";
>  			reg =3D <0 0x28330000 0 0x1000>;
>  			clocks =3D <&pismu TMPV770X_CLK_WDTCLK>; diff
> --git a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
> b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
> index a480c6ba5f5d..5ea835fe08a8 100644
> --- a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
> +++ b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
> @@ -91,7 +91,7 @@ i2c8_pins: i2c8-pins {
>  		bias-pull-up;
>  	};
>=20
> -	pwm_mux: pwm_mux {
> +	pwm_mux: pwm-pins {
>  		function =3D "pwm";
>  	};
>=20
> --
> 2.48.1



