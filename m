Return-Path: <linux-kernel+bounces-769061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B6B269B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420F81C26712
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED918DB1F;
	Thu, 14 Aug 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E73uBhTS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC80165F13
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181763; cv=fail; b=n7r1n/NKoaCCMR5PvnJbHwFfWf0HG+2Hw7tDNSVCrf3FTIND/kqubNcugyNzTdoq0+P/jIW/Qt9tePNy7sIH8BNnFDAUM0q1aVq8WBuqxvPQgItcbN+7KIpSjxL4hZggeBknMTsahzG4NnBAyNlDWW03MHlWNnPTb++TVzAgM4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181763; c=relaxed/simple;
	bh=1ksKUPR3pZqrG5byrz7tcLmRb02fqjswKce4oTma6XA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0zWmOHE9Nnv7DcUpSZSbOIHBD+FrGoFaaEgsOUQn1UcYlvFg2lJJY77+hAMtK9KyesZNPNfQzk6ojbYrx0Ma/RriQJyfTI0atPZMTvEgiYqLuxQu1RilYXX0hTnANvD6tE7Zqr0JsSbe9rA7QT0Necf3Cw/XCy+Zx0iUAWus6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E73uBhTS; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDms0B6vWbuAXRhkO1qTT/3lfsfZor6F2oYU4jWYXDrHlBTgc6huh5JYDfivySmxMD9CGq7AiF78KWH6rITOhOWZMTYUXUhrlMGs/6mgNz3qevcrt6GT/LQeLmeDas09oAsPKnAH9IqP0htxZgrE3G4cwZFf8Y8kmdvpqcap+rz2M/nlm/bBAwIK7GUIJ6FgSsbVgx7/pdJ3vPU5STe7HVDmivrZS+yfoTszMHD3Y1QxoOh8mITXWhqEd2CytL37/z2sqL4agwPRIj81AkYxzAjB+BJj1C/FJViywr2GaevH04MtJGTc0R1JYKw/VvIxAHiSsHShtVGPA2NmTKTsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOaVeO/eJ1GiHaLaIuybKGDlqIrBYpf9xzgbUU8iG7g=;
 b=jvs4cu3eSE8ElHAK3TveDPcD64RijLFRzC9jy6lE6yxM4hEaNJUeM35VpPWVY5Nd4c/YcJFN1AiNYh65TtPclsAWGs46KKJx0ygjFBxG0qFjNvGWrMzMN/eHrQ1+uK4kQz8cLtSdinqAO2eiwf2Iv5MLTJRoiO9Tt2H88FfSFLcS0ea0VK/nk3SMPjER+bTcRctGrwz2F933lBDDxjF1AGudk76fK1S19G83s88Qxc8U1qAmndG0V52dLaNdtLOLR1Ozdyac3ONcREKypacDmJQDqYyORzvD6bVLWfYrqci9cBnI8kTopavtEuGpwOLryiOW5mObCSYcBDZkeZ1WbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOaVeO/eJ1GiHaLaIuybKGDlqIrBYpf9xzgbUU8iG7g=;
 b=E73uBhTSecQ8R5WOhjBrNECEbDRwBVcvAtXNmqd8jBBLu1DEhrehkeW6P09Je3HwfSlymd8qRstqUF8o1argisbN3Oz3GoRGDU2bi0q3yfWAEZdYza3m4EMZAkrlM9FxNIs8DyNxEx558C4JBEFy/bvyOR6Sdpt6PMTep3ZUYf0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 14:29:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 14:29:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "liuqiangneo@163.com" <liuqiangneo@163.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "Sharma, Shashank"
	<Shashank.Sharma@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liuqiang@kylinos.cn" <liuqiang@kylinos.cn>
Subject: RE: [RESEND][PATCH] drm/amdgpu: remove duplicated argument wptr_va
Thread-Topic: [RESEND][PATCH] drm/amdgpu: remove duplicated argument wptr_va
Thread-Index: AQHcC4TpQ5I13kP9f0OvGZrR6oKMv7RiOGhA
Date: Thu, 14 Aug 2025 14:29:17 +0000
Message-ID:
 <BL1PR12MB514421196F980730F5AA2A6CF735A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250721064614.9213-1-liuqiangneo@163.com>
 <20250812123021.49124-1-liuqiangneo@163.com>
In-Reply-To: <20250812123021.49124-1-liuqiangneo@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-14T14:28:53.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4324:EE_
x-ms-office365-filtering-correlation-id: 71092cef-7716-44da-c42f-08dddb3ef3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QjMcVgYjBwEfeAEfEIL+Ts99xh2ouviHX4psjPt56bBki+v3Omy46CleDfWY?=
 =?us-ascii?Q?VUoj+NMT4qersEPgVZ8d0LrBvYwl2TEC0YCoH2sM8TR0/LBeYBq1XSZgPoo2?=
 =?us-ascii?Q?a9DdvJEnAmovm7td4rq+WC/bCc9D43TqHa1mdIaCmLXkplEn8gknQk2XE9A8?=
 =?us-ascii?Q?brESWLr0Nc6oAHGC+c6m/6axupWAEmRmwneEhVunAU/rLH0Up+zAe+wxFVvZ?=
 =?us-ascii?Q?uXuFEZq07LfWUEpn+VPr/b56udlpGAd87v5L3JWhT8rZvkteqxRtEO0a0I4g?=
 =?us-ascii?Q?StFW/YNB5b+T4dLV0PTkUvL6gO70Q0WzS10iqn7LWii+lIkSrRp3h/yVkfAN?=
 =?us-ascii?Q?Kq7Ibvi9K18IQI6mIYEiXPvIIOfBrUKOJsN7HTtzGRhlLOwsY2PJnKXF5Ozg?=
 =?us-ascii?Q?fvdCxEHAcbTrW+2ivuYZtSrA7UkDorIkTmEp0AeAYEWNtNhBmvJ+7zF9Anwl?=
 =?us-ascii?Q?X3buOGxVAwmaw9+fYJtvZHmjarXj9jDlw8eC2MdsFYn6Ka5knozsqIjYb4SZ?=
 =?us-ascii?Q?NNgFnIHXmV2AFvcbJ4REnDeluMithBKdbmKVfbAJib5YbuclGGpqCw6b1Yes?=
 =?us-ascii?Q?TADl+VFIIkRlKMu7UeuZuNgrbr2dVz4AdI4xBeWG1tged8MM23W0x/zfjRMj?=
 =?us-ascii?Q?lcOhSzZwHdn/PvrAgR3mUqxLNFKaGjXC+MTHdKzi3hdYTgqwF4J7dCSfx1D8?=
 =?us-ascii?Q?L6q6Hq8OxSiHeT99TOyMgVJEHNOJ602sCGlWNYGYtKDLNRVgbFZqy+CtEfQF?=
 =?us-ascii?Q?8tNGOu0/FyVWWbyYx9nuue+60Ym84IqLagdKE6msUMN0ZfXqyI/bQjklL5M9?=
 =?us-ascii?Q?hCzGWYmerh7dDtvCzwcuyOaTF42xKan/Ca46DXx2Qs9FlCFqJtQiTslzadGF?=
 =?us-ascii?Q?44qobPRxmh9jdQ5TIQiVllpkEOHIM2Yn7Kp8wXjbF4W+vgsJSkLv72Ej8ez+?=
 =?us-ascii?Q?uc5O9tNhJVUHjOHdeinzMX/YWEUAJlR8wbMKgQtxlww+9E4fKTxzMkYUSJLq?=
 =?us-ascii?Q?pRTHSrE6jFNl/3oe7QiFn+c8MubBIUXPp7w/NPZIT0FNOi8fbbJeanxneQCO?=
 =?us-ascii?Q?cmImwhZ6FHN4RJELWo2K1rwcTTBLqHOO3nonhTjEjuMS2quvvKSbGhhtQo5z?=
 =?us-ascii?Q?A3L8rohfJEEL6Z83G7NCl621Dia8rgXw+6PFAoIh3HGn2Toynlhz9eIm5dIS?=
 =?us-ascii?Q?UhOl59W6Zskm9A1L4DzRpfJ6zbfs1MzFRogTCDbHVdghQ8YhrN4IsdYZLXJw?=
 =?us-ascii?Q?jxR6i24WsRByqoQVgQGPPDUKJCOhtshaAwDTi5D4AWWvoCS3a3Zt8n640D4c?=
 =?us-ascii?Q?9Gbfe6o6hQpn/0ubFWYLnLKIAmErVRpa5Q/xbO7DWezbAKphs1i6iB1QXE6O?=
 =?us-ascii?Q?ecYeFg0kCYUCnrImfb/2DaELwEPtVVj6mFRPaMi0UB1tBJb/9ah86g/yKv25?=
 =?us-ascii?Q?83F/WakzdeyWrla13UMCk/2SMshtdKuBzWnxEx7txi3GLi4gQg45T1XC0slq?=
 =?us-ascii?Q?yIHoPdCXFlaEJfE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ktBe/nRdW3m7zaswY//pJFuAm4FNN43lmVp0XNVLLD7PlB2ap1ex3uPkCLJe?=
 =?us-ascii?Q?vR0RMOx28gMQgoUg8emqdCtZ1QRUK/E0Yexj7/Hd0VJzowKONbOrFpM3BuzW?=
 =?us-ascii?Q?6hIW33s4vE9IWYtWjRH4E2+9LpHosBZkPhKQ7U88LqTsrzXAUcxtuOhvtpj2?=
 =?us-ascii?Q?J2Do8wZnmasxY7Z3+oY/bYRHVFaKPbsZ+w1BldIxpOkqA6mkPzx7qktiybmi?=
 =?us-ascii?Q?V4F1K2itPZ6ppWzDt0u9fZbZSir0jKIau+d3zc0i7IDpGVg1NT16OI8b9QDT?=
 =?us-ascii?Q?b0ekwvCcQ94CYfGN76oVsaMWakIEyc6mCeCu94l5HDqJ45wMIa9U6EHsYOdN?=
 =?us-ascii?Q?JmsnRVdWr7GmFnBQzKoSYs6/yCVqiTETKL9WBS0h0sA/4gmycpfsPm8F1hcT?=
 =?us-ascii?Q?1Taq0GaEgUx/zNUQJEcX2P9EwQljVb8yu2bQBvBttORDelmZXCVjkXaI9oOr?=
 =?us-ascii?Q?jCObIHC9dwyF3sTLXh/59Rg2nEUISoCEM+dKct22nfDQwX96Sbd+9KJiR1Vy?=
 =?us-ascii?Q?9VRysBnsKIJc4xD7jS8Y5XYUqLgfP26YkfX9Ca7XWt095GRJhs6Y44REKa7i?=
 =?us-ascii?Q?tDm4Os8J7HKf6ec23ymXw0+NPgmIPU87JtrWM+03YKOhxfIbPwBcgwe4NP9V?=
 =?us-ascii?Q?ZLjgRBhkAu2VFDcJgVD8+1vrdCs5FmLjSuVvYCGCbEIkKA3FR/v0uh5w+VnI?=
 =?us-ascii?Q?SA9vIa/nXqIUQcvDxsKr/L7woVLAMG1p/SuIzVhPQvxEOFaI7GBP+304Ul0Z?=
 =?us-ascii?Q?g7bUCbpwkyFmj0oMxor2gA297HjPjKS+/sOf59jkH5dX2Gqm3jvitHIsdFHX?=
 =?us-ascii?Q?EK8Uzlb0di1K3lpfxfShbmdbmNbnXtmDr58k1kH2GKw7AyF70s/F1H0aiYy4?=
 =?us-ascii?Q?YPRvTSnk9E9qRh3fol2+VJy8s41pgyNnrJoqGYh+B2ioYll2MyNWaj6EYfNY?=
 =?us-ascii?Q?1D/IuXmYS0LfWZkaUrXW3UHQa2LlkE23d4LbET85ykBdsLU/D1DcP+81tz9q?=
 =?us-ascii?Q?mmb+CMie5FTtwIc5ikuwqvQX/+CjCBN3CYH79AydFGgr+XEciMqxdemctha2?=
 =?us-ascii?Q?jjGy75ylQOpunmGvf5+e6hut0caQ0ndQ8TON3E6DBywQzllr25rNKJuo9Vq5?=
 =?us-ascii?Q?kCHY7yqA2VQgl4aRG13tk6ZxFRUmruwQI/mHhXgm+13tkzSEaximH2Sxh1r6?=
 =?us-ascii?Q?CCEf40cgCt5WnlGZFkBQzrwWeYlREKVjU76eG2xqoErjAdh5OVslsczHUIkN?=
 =?us-ascii?Q?SuPQn0BbIhQXbLILd6fZirSWdaoZu6GFz5DVbPpw9PiPn6wFdlmOS+SVvvbR?=
 =?us-ascii?Q?hZoCtmCKO7RYHYrtjSks3wpyBpuv3rkwE88js+higxepDqmrnKZTG7CVs2QK?=
 =?us-ascii?Q?F78OnC8hv1ISk4bGPngAqQEDc2nJoAM2N121jeJ3D1cCVbC4PqsP+gWYBvNZ?=
 =?us-ascii?Q?4MKpor1pAZWqmPAMQiPjt1jzceWUoBhfcsp6QhBePmHsWxwzPkSQPF4D6LmW?=
 =?us-ascii?Q?n6TU0Lq9NFeT/kUB9HbWIueujHAOUBIEm74EMCQfksKj5NS5lSC06e1AUJJx?=
 =?us-ascii?Q?sGm0gpNynTzVghcgweE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71092cef-7716-44da-c42f-08dddb3ef3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 14:29:17.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2PWPvTGpJlFSwt5Fxy3WKnxBM38XHCeSHCEhBDcUn9+6BLgxuw/L5JEVxD+0lnH2IXWsKF8IIWWcn9Q/8c5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

[Public]

Applied.  Thanks!

Alex

> -----Original Message-----
> From: liuqiangneo@163.com <liuqiangneo@163.com>
> Sent: Tuesday, August 12, 2025 8:30 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; airlied@gmail.com; simona@ffwll.ch; Sharma,
> Shashank <Shashank.Sharma@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Cc: linux-kernel@vger.kernel.org; liuqiang@kylinos.cn
> Subject: [RESEND][PATCH] drm/amdgpu: remove duplicated argument wptr_va
>
> From: Qiang Liu <liuqiang@kylinos.cn>
>
> The duplicate judgment of wptr_va could be removed to simplify the logic
>
> Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c3ace8030530..86cabb20bff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -567,7 +567,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *=
data,
>                   args->in.queue_size ||
>                   args->in.rptr_va ||
>                   args->in.wptr_va ||
> -                 args->in.wptr_va ||
>                   args->in.mqd ||
>                   args->in.mqd_size)
>                       return -EINVAL;
> --
> 2.43.0


