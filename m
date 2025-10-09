Return-Path: <linux-kernel+bounces-846170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A64BC72F8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E7219E2C91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312848615A;
	Thu,  9 Oct 2025 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFGy9XGR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863113957E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759976116; cv=none; b=JLlQGk8abWlIZN7qFx5WTj0EcxYlBFOrxhaPgfWr4eT415DW8RaOPVv+TfngstKInKTbUBN/6CkV3s9rynfR7OFcXAuMbFUoO51MczqDOjQda52K5Yt7JRCwJjrNAV6U0No/aCQmJ4NJ+n+okc5W9xVn+IP1jVsa10rbMPxcd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759976116; c=relaxed/simple;
	bh=ekgEJmb54FZNZrD9BT//BnKOt7CsT/rwgOhCwKQUjdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv0VDez2HtFTxkxQc0r+5VV4pFU16NqUkIG+onQzaIHVJPEqWgwa2hPRXoFQztXJKVwXtIWqj6+AGp0VkTOuyrAScHKIeYFsHXb4E6hShAJ8Bm2xzc+hhZL4TCfUrMcrtmJt0TRgC0htE/YcKCAyVTzmTdL7L5gw/4KiRbUTIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vFGy9XGR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2697051902fso663075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759976114; x=1760580914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kd9gVakjyd2VNEiqLrfFbQtpaxcXRer5ni3ThNciULk=;
        b=vFGy9XGRnaqZXCuoIeW0NsOClsUtbCiQLazqI+TLwuljrb3C1n4W5ZfimzpZ4tM9Oa
         rEQbcx+C6m7xCLxvk7rVFEtMx8OgPzthU1z+hnqSsuEovQ82fltlsqt01JkG3gGt8l7P
         EK1lv43rVH63nIHZBr8Z8g6a40+nVJqMkQITXub15ydOM7LjU8XHEpdIhHH2c0UB9c6H
         CyctQdbSXYKKXdzYhBKdZYflArzJ9n50ursV5SFE8NwQpM3v3f+/3z8WwNR71OkkCAOq
         Uf4Dlopm36o3XxwbQVR4ol4HqtH7gArsmCz8wu2gxoRxIlJKOZJ8S2waTe1n5dr1n84k
         N0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759976114; x=1760580914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kd9gVakjyd2VNEiqLrfFbQtpaxcXRer5ni3ThNciULk=;
        b=FDAbKBLw+7M8i4AEgM1811wG0S05UtEM5zxz+G+sR9bql2yTrCfc9WvJWgz2LyW8Dc
         1nsnHrB5YOpMxuQj893Pj6Yvu2Sk+5KC7NtVfl9PD9wlSUBrUJyo4jKgARHOvuAXf4Pd
         NIyhgrfQSBBEXlO7fN5MV5JBZgpOYzRT3TlaeGLlXs2oaWayDmtbhqsFApDQEHb2vufW
         1Arh5kPouaEtgF4CJsk7aOnwedNC9ZEJBLY91JIMHlqEmX5Jna3B+vNhgQr2y8zViIKF
         Z/pZZhv7rm9FfiPlUpgBzf29KE0+1aZpcSe8lkes1Jr+xt6GczvwPvq4d/b+I13pG49L
         TwSg==
X-Forwarded-Encrypted: i=1; AJvYcCUu9n45HQcSLa/hEFYP7xYV1LQvumOlDWTeZnYevlYsqu9OTiFZSZgv7QayrVVlscRcAL4wYjWsmP2TNms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxH46lprc6XDU8Bzjh+AdHmOGFwsTak867RnjkudP/d5qtlka2
	ucsDeMELo/lAcvY8BJd3frgiuHEzz7kV8WIJbPJS1pw/i/yZToWvwGBH5xYKfKH3vss=
X-Gm-Gg: ASbGnctLmSwo6Oq8IIUb6nGd8dgP6wK67goBlgfEqT6CWHt1gYpe08uUdnZlDZSF6nb
	no4ne71+W22atJboFRDtP9Yq848yhuIBKeIuKQVkX0wb4d0kCqJ+jwbzz5FG/UQeyWp6S2K2/aX
	/DQoL0bEZ932byW0nQ6uEQCBEFBperzahznZFgY9HfgZqeGbPtANhT80JtsEMgEhUsmrjgWN0Li
	cixUf1wJLO8nvAho9IPzQRQq12Gj2VEhLfMftorz3q0IZOUwDMDvv+rideIRBb4jnWOylMgLI5K
	BZ11jvkWvVD8yuz4xCZUFc7Pj2Urw2Eq60hvj67igamNRWSIg8pDBmXfzXSPPjySS6s1NTfFJtR
	9K/SgJknfSPsSOSBUeCYMxPi8vu8iaxqVoFAxSEdS8sLlBnQwjYb1C2Pxk3vCrjzCNX7PsMk=
X-Google-Smtp-Source: AGHT+IGPWFA3IoAZeXqDh1/NlFw1Xmfh1DSVTiiVoh12bpNLo1QaMR7jLGjSGUz6+FGOK1+mP9Qflg==
X-Received: by 2002:a17:902:c40b:b0:267:b312:9cd8 with SMTP id d9443c01a7336-290273038efmr35922935ad.8.1759976114144;
        Wed, 08 Oct 2025 19:15:14 -0700 (PDT)
Received: from kuoka.. ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1cb83sm11285855ad.44.2025.10.08.19.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:15:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: Enable two Novatek display panels for MTP8750 and Tianma
Date: Thu,  9 Oct 2025 11:15:08 +0900
Message-ID: <20251009021507.175290-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable drivers for Novatek NT36672A panel (used on Xiaomi Pocophone F1
Tianma, Qualcomm SDM845 SoC) and Novatek NT37801 panel (used on Qualcomm
MTP8750 development board).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for qcom soc
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 24b1c943a7e1..adfc21d1ddff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -937,7 +937,9 @@ CONFIG_DRM_PANEL_HIMAX_HX8279=m
 CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
 CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
+CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
+CONFIG_DRM_PANEL_NOVATEK_NT37801=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
-- 
2.48.1


