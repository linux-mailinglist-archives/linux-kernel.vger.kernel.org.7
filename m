Return-Path: <linux-kernel+bounces-723287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52746AFE551
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D74A3A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF0B28B400;
	Wed,  9 Jul 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3GGNCFy"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93128C02B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055798; cv=none; b=V0BsPLWSRna6NAFvWvzESAueU5LWvAc9tQbd22BdP+PNskR2JHaN0uou3GaePDP2XpsibvxBSjf38nhXtCi/MkU9UDTZrhm+7Lfq2er+JjwD+J2AvO7UJegFPm/W76BGZgNeORC2BImg/HdxAYeJegb3GN4okbZZBlP+w7gfR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055798; c=relaxed/simple;
	bh=BtljJoJu29he5h3E1fMJpoxReanEYHNeB8iJaVXCAtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3PJMNf3eXYtlcesYvEgqaz4F1T9fQgIKvhUyCSWkeNdhzMr62fjndOBXdmumwNzywWd/ohE+vcjFqq93xt9dxiSiXBQu4MrSU2MKZoUwdI0ZPV1Re6UsdyGqecUTVAAFTuBn+QVhE3O8Ph3svTruPfmyx5eIB+nyedWoRxrXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3GGNCFy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso2303004f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752055795; x=1752660595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqgIfbUcailCPKp6TXnf2r6fZEj8c+V9PAnko/MkSqA=;
        b=F3GGNCFydH8nAyZAUz62L0GYK+E0E113B9lAmFB3dQreIF6CN/kVmGOqbgYI96f+d5
         HGZmQW4r2Z8hpDmPGtytPziPWHDrollHp66c2Bmgy2XYuvfbVxOxgN7or2Ijp4SyxhLR
         cufeOylEGPXWy6cfpxLCnMg6x5AnJIAT4VGvARCr07P9zVAPWlp7iepvK8bSd95mL2rp
         5Lnzj1ftoufwFxPveubaMqmo4ntsFIcljw27PBSz4D4a3hElAgmgmL4BPSCs1AJZH43G
         ugqCrqLhTaO2zoglNxFt/pwamiocs4vijK4f7Bsx2MgkT4nzxyOjAHisMOvRdb9ekKwF
         j+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752055795; x=1752660595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqgIfbUcailCPKp6TXnf2r6fZEj8c+V9PAnko/MkSqA=;
        b=N6+TLqT3MLkFwnNJLyrTodRYzkC3RJC1heimH8ZUSWjEqCfFD5QBCyY2/vavR2ZYQ1
         o2qZ3iCbLlh9KTOsEWI+ekpKfjehvCZG5pNxhwFmPYhUG6sQjcHtkW8qO+WljqOOGPOn
         luV998/82psYvfbbu6xItqByDeTVJTllmlKlbNhxKDr5mGGOok0PUNowyF30i1XrxPYH
         NaacDzoMWyaQcvhdfS8KCX5hf2Db5h+HNeuKtuox++8megek92PJQlKqSoSHXaLPGO/R
         mcuLMNAddY8uMNtOfyLj58+PV7egoMPms5JrMAgaRBwmXTYHmwmT2LAPT7+8UcH4zZos
         zt/g==
X-Forwarded-Encrypted: i=1; AJvYcCVihV7WqjFBRBEBFfEvvddyc6KrGd9LFgamuLtX6ek1jHdoB+MoaxOYXAM6iOCazFlyhSIqVKX46LikMLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWnDtmA59V1s2uQvMmwFDnrFHcuS+hRswnE1Z/5boppJMd915
	Wq+eYCoXoSwzTK2fa+9J62q6pE7/VsT43mUT8LXP3W5GOmr12kWPUPGJUVwNzCLm8fk=
X-Gm-Gg: ASbGncven0IWw1uZBBoaTOIjboM+SrefyXXtVMF2aUfP1vJg/4ACGurMM7620j1Ir+m
	X7o3nxApPVNkOAyH2kMz5VfEhX0yQDhn9t6yST/kfyt4jYtxNgH18vvai48/NXVnP8gafs/thoV
	AY1Ox4s+1NNc4gsbL8wqwjkHT7msHsndQmlLbhmvvv7yFKPctst/KMBKitRIb9vr9+mYZfrsbSo
	WlEQqIV4GFsQGxfJp6u8FKj/P6eSNlnOnpv68XOPBA2lSHVMbO6FOxV0nxZewOK/Q6wwaQvycwW
	c2thqexG6ed6n0MrD/stik7P/aE3DI3ek6/vAIp5JjqJlL0fKRcM41rYSbWJfvIf+JodHJTSUi6
	sk5IdOA9vwT6f
X-Google-Smtp-Source: AGHT+IH+kX8gb16vc2IqysKW8WfIZF3xM6sEokJKtIyslzmvhXUij9HEIcvjHcBwVbgQKslIh5YFWA==
X-Received: by 2002:a05:6000:41e5:b0:3a4:dcfb:3118 with SMTP id ffacd0b85a97d-3b5e44e3ccemr1447480f8f.10.1752055794558;
        Wed, 09 Jul 2025 03:09:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:d3be:a88a:dbb9:f905])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032997sm18342105e9.7.2025.07.09.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:09:54 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 09 Jul 2025 12:08:57 +0200
Subject: [PATCH v2 5/6] clk: qcom: gcc-x1e80100: Add missing video resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-x1e-videocc-v2-5-ad1acf5674b4@linaro.org>
References: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
In-Reply-To: <20250709-x1e-videocc-v2-0-ad1acf5674b4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add the missing video resets that are needed for the iris video codec.
Copied from gcc-sm8550.c.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/gcc-x1e80100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 3e44757e25d3245e455918e9474c978c8dacaa5e..301fc9fc32d8e6e1ddf59c1d3350d84f6c06e4b6 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -6674,6 +6674,8 @@ static const struct qcom_reset_map gcc_x1e80100_resets[] = {
 	[GCC_USB_1_PHY_BCR] = { 0x2a020 },
 	[GCC_USB_2_PHY_BCR] = { 0xa3020 },
 	[GCC_VIDEO_BCR] = { 0x32000 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { .reg = 0x32018, .bit = 2, .udelay = 1000 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { .reg = 0x32024, .bit = 2, .udelay = 1000 },
 };
 
 static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {

-- 
2.49.0


