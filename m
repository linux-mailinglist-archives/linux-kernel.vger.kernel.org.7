Return-Path: <linux-kernel+bounces-739272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C39B0C42F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0612B7A96A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADA2D3A7B;
	Mon, 21 Jul 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bh0gqTXl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A122D0C69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101310; cv=none; b=mkg0fZSX+J7UPYparY4uNwUL65au7jlXofntfjAJD7nI3+QbHbfedf9MySiUgADsm4/OYCeJ2nWFjl72VtTN3BHR7DSA25oP7GJjEPs+6RC8PJAb+Fap8BRkFygqT1ilu3L5DkoUYcm6jcP8G9X8+1rouTvxH9fej6v1kMYGCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101310; c=relaxed/simple;
	bh=O91kV79pVlyB1aw34aHO5FvLamb5mNiEO23N/U5+fiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mjLz1Pm6ZCTRAwTwlhll1+ze7UQwH3l6HpQVT4C5OSmW4usPQ/Oj2YHlUouPDZ7hcZpAyzcYRWbrMTuYDu5nm51nIxmoMauG5qwmEfV6gQCr1sKo5oCM9W/QRE2olITCcLKcwdaNHuu0rmTdLlRFbc/u8t/r0se9TPEm+XQHmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bh0gqTXl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4560d176f97so46182755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753101306; x=1753706106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zWeKKFmXQT7g0C6PVGMg3GNyP6pXlJ0on9vzRpXs9c4=;
        b=Bh0gqTXllfuQAbX1jAH13X2R6upqB9cDUxtOFUyimTjLPImC5H6L7mQY9IoZF3hM1K
         pAzRHdEKqRK/9YiMhol4+o+KrOIQQ3U4NQ06hyQVo29yi+MGGc8Tzj7ZPjcuyszZfb38
         mUlyb4PcVlbZ5ap9X6kBznsVWZNjkoOKi32ngdi8JsqC+AR1jBryInHM5eps+obQ/iqC
         hOM0CPBmb2ailGfuuWh8slauVngyWYdJrsaAhOA+TXocfn4KlZmEhLl/d00xCQJw5f1y
         99XPGYEOm5R4nl58lg6duoJ1S+f6q2lgPIGGN+01ETMe27gtjWTLwmKbJ+AyrtPagEFA
         Fl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753101306; x=1753706106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWeKKFmXQT7g0C6PVGMg3GNyP6pXlJ0on9vzRpXs9c4=;
        b=nFHerG+Ha69EYybLKxzSZzvNvA6WtpPLSfnEXo+EAWFizk3ZqXuO7cA1ATZT8oePNZ
         jgm4w2M3vxPTJd0i6dQjdDWAG4+OSocQ2985uW7yK1JXOM6fwrXpg5OOrVy0GdWhtd75
         RFMAZenp88XO/5jSk8+0QDuyH57kP2TlUbjJAoBXrgQ2SSq0VIfd6wH6b7UNiqgdLMf4
         emQm/FbwqBz19uEGEDkoDFhwl1y8O7RNfErZa1sryMYCymEPwOKakFwKZ1ApLVPCgfo/
         edpsfPhYijNZ/TQJR2M+682shOy9Hv+QgkN38o+MZCikb6XoSuuuvraihw46qBkoZcwM
         GxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWFgKXKu5a0UcUpPrzbDcriDOVOgRLG1NliLRhNKmTP+cwyrBPu0cbHT4d2ScoK/qSpj4K2foPBSbhVNtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUm3BUF6uw170i1HJk46dQENvvU5Rm53pWqgV9WgKKAZB5u2hn
	VIaG3KKLmBeV/8iGArOREWTt4czVTJlGAXCi6TD7QS0QuZKt24XkQV3m12vK+qFbOn4=
X-Gm-Gg: ASbGncv5BPcVq9e4Ug9S5UG7EJjq/CcYPzbMNcNp016Sah46Or1pnvyMfgPK2/q6hAA
	KGHwWyhrQKXooKFnnIxiDhnx3p4v9BIch3gVLnzv6DJ3A9+OHRBF79P6fQCM4XXRsHFgIgeJ1h0
	0YPfiKgHEkKG+cxLgwdjiaAL9petkLuzyhwI/f71tDgQ+SDCPs8fAfhT1DhYrj7wy8uw/AMqC/z
	Kkad2D0/nBswxbJCt5wrSuP74Elrp8JR0aulp4t3aiXzxy18Vza8g/FzFUbc/sGjLp93XuFlbEX
	YCyyHv/5rfo8XnYm+bb/W7dqzeqjwTiDDPbNaQ/14YFFioLAHxd0wPrd4IDpeZzLSxOnbo4JoEU
	1TFouh+g8kvc2gHHZ1DJNwNK68M91buMttB5gM24P638=
X-Google-Smtp-Source: AGHT+IFG4kXXmx0zh4K9sMcn1V0MOV16G+IB8ljJaAKXFE9c5b/lozHQb27C8mLcsiUk1H5j42FfJA==
X-Received: by 2002:a05:600c:468b:b0:456:2419:dc05 with SMTP id 5b1f17b1804b1-4562e33db7fmr212236965e9.12.1753101306277;
        Mon, 21 Jul 2025 05:35:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25643sm10026654f8f.16.2025.07.21.05.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:35:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 21 Jul 2025 14:35:04 +0200
Subject: [PATCH] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPczfmgC/x3MOw6DMBBF0a2gqRlpbEIS2AqiSJxnMg22bH4SY
 u+xUp7i3pMykiJTX52UsGnWMBeYuiL3fc0TWD/FZMW28rCGlxDV8WHwFCPCU1z5vW9hAXfe3e6
 deLRoqPQxwevxfw/jdf0AHSMKJWsAAAA=
X-Change-ID: 20250721-topic-x1e80100-gpu-bwvote-9fc4690fe5e3
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1510;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O91kV79pVlyB1aw34aHO5FvLamb5mNiEO23N/U5+fiE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBofjP4kJcyfWacvsCCp1u6bg1wWUMn/RjwQ3GLOc9C
 buFsCgGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaH4z+AAKCRB33NvayMhJ0SkJD/
 9OjSOM3gWCnvasEhptI4hBy1sc2kjQQqMcjy4dCSE18KxSG0hBpJR8LsXVJSKvWxed/zdmPse9wB8i
 HcwrX68tuo1Y11kf/IohKZOmW43zSu9X/ox0+Imq/1UxirYaezrAy6Le19D/H4Dcvy87PbsW+zck2j
 w6VZiu2Y21LHow4N4a1hA3uuwAtGV0WLdLyrLcBVIqO0msQIi8gF3Tt1fP0KNeokd4z4z2l3U8i7i5
 8YTxW0yGHZneLcYUqk1LxyIoaFnWtVNij/ON4QsDMCb0bHIoZMgzTLuOfygHEuAWXQTdR3nseFhAii
 E8XMDPkbMglGxCMiXjU92LeKm9YfZrHp2KmLom4BEpMvPsHYObpICMEy542dA3uOwm/6UqUS5TMVRT
 /c+ijayc/i+vJYFerhzCuJXZb9pvkNa7kOsCDYeDpBQU7q7TB0cHP9Ky0wWUTo+gvB3Uge6MFcELSf
 IEy3qCw0zLvTFkQloYfz73QsIPeTfLDvhZSdFpCIATKjydKx0HtfywRLv0E7cc2Pvi4dnkcAFcR2uh
 wYs2X/BVkhYBw47WQu3xqu4ccKVfH4uhPdXiJJliS0HqE4VME4lcYBl5E6ksB4Ohhl2zWABz3xUEi5
 A2vtwhF+C/qxPPoZxGDdr2DKhrLZhZgU7wc7wTNR/X5te04h5yPne7BZuP/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
the Frequency and Power Domain level, but by default we leave the
OPP core scale the interconnect ddr path.

Declare the Bus Control Modules (BCMs) and the corresponding parameters
in the GPU info struct to allow the GMU to vote for the bandwidth.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..b313505e665ba50e46f2c2b7c34925b929a94c31 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
 			.pwrup_reglist = &a7xx_pwrup_reglist,
 			.gmu_chipid = 0x7050001,
 			.gmu_cgc_mode = 0x00020202,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 10687500,
+				},
+				{ /* sentinel */ },
+			},
 		},
 		.preempt_record_size = 4192 * SZ_1K,
 		.speedbins = ADRENO_SPEEDBINS(

---
base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
change-id: 20250721-topic-x1e80100-gpu-bwvote-9fc4690fe5e3

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


