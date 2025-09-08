Return-Path: <linux-kernel+bounces-805906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EFBB48F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75CB164D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414430C605;
	Mon,  8 Sep 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfYgd4/m"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7B30BB86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337187; cv=none; b=pZ94dyX2zFcKwM/eBhzjTrc4uoXwhdf87OwctuScHK2Cv+KlvYRvV6V1Sx2Ihf3wryFfdtb+nhiwkh5O7brcGkxdOVNbin05k43Xtaaizcb4u5suiX9yoVXV6ic6ra80r4pIwZ6jmKgS+PWH6ENBeA9kHLFWNDXaY2zS26RDa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337187; c=relaxed/simple;
	bh=r9B8eJrWR/g38PUeQ9J2wFXWREa48OIMpTY6cZptlBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OflqBowCghQVX9JNLHyRMBRFybZHEwsu9JJ7vR/krXJxmZoNE1e9AMcKZeBvTnWRjHzz+HTcHMxMHbtj7+jy9wsiAyqxQhSfWWxvroiirfVUi3nTL+EKgt5OcbM//GkrWSLvPsV3vjAS9l5e9jYs32R9yT6jfNnIDST81tC6YAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfYgd4/m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45de64f89a9so7602905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757337184; x=1757941984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX1P98lL0ntVTFobuHZJG04rSny4tquvD0IzM102LdE=;
        b=gfYgd4/mMQtSOhMVWToxxh3TVJ5Ttd4tiKfBFq3/plCL4xqF4FqEtMRXWDmASYsZNv
         1W5WdCcLPvjtpdqg+hL/24jZa2tKC/jEfopUTgEpFQZDXygZbev/2HYFMVjvv+VFcQfB
         k8wHoFAnN8mXzChyZHGYGJH3TdfaJf9XqnFfvgtioine3k/ouSD6aLqpaQvFWiVPrAl5
         8fZTS9+kCEYX9JQWxBgrxyAn6deGUAyGMflM1C+BRiYsE2EBexxJDIwOpPc1O0IsljI+
         I+04QdD8Hl7XpjGrDEBq/3/EnVPuyhqY6BhzNMQhLHJgB82NAawPeXcK/XJhlnE1cjZ8
         UwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337184; x=1757941984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX1P98lL0ntVTFobuHZJG04rSny4tquvD0IzM102LdE=;
        b=LHnBCMDGSp6LACCyQFBCFOqO3Ryo/Sp3jUuZbvDssqwUgAFxnlegD6a/h53zXUSXk0
         kST+4jUPoY4qP/nY3VO5zWnHGFynXZTI/BYv67koiSxo4rghZcKyK6H5nuvQlmDN7uj+
         k9vSyQJMObQPNdq7qBzmR1UvgaUnavrRbLEQNT9GwmfnFnu350al4/Tj/fRvhiw5C1/j
         ReHxWu3rkSc0l3uA0dW86OKrPJQMhxzbXMx5cqNQoC5U8mrdY4ylhbkND0un9EbM42ve
         V0bI5mSpJC3nwGtC0Y43hDONzaI0ULjGvewENVNkXkJRrjf3DdNprH7lhOg2XpdatiAu
         S9tg==
X-Gm-Message-State: AOJu0Yzp8xAq/8euZ+jXMjwsqTDZR0u5NG4H5jOQLLmZIIK4UwhQqcj1
	mH+nw6h9oV1KcEauI1PfM+FWACCLoSdUu2sVNsy30tRT2694wfDQliRS8AnUJ204BME=
X-Gm-Gg: ASbGncuaEyPfWdMg968d9EpEJPTLrJKV+DKLOIKS5doECgkWFeVJA4ORnnef1qVP0zu
	nGhZMVY3jnZFk4miRY/CL9iYP+xHh5y2n9Ur4R0JJhDqzSjfsrTKY2V5/1WuVMo5YGvS10GlpGL
	BGXrwHhdSsnZbmFSRrfJRrfCPo8/TmwHWI2qAk8HXFT4fZQlHfwwUlTJlBzQ5REVlKcTkieurc5
	EwPgTd2qNlo34cNKe/zQvURz1sIQeI1wbRLE8S4sIWxqgTUgCVim2t3f/fgf8bHvToCC1kVxrA1
	2qz5unzGCr4yjjgaq6+zDlpiwe6QPOKDGu7KAGxW8L/AAd9sx+bSrsE8ncz57F8UQuztFX29jpJ
	XuvL4F/3UhgnM9ma7O36HwfApvzQ7cvecf/y2r/Dn8AMFhL3KzAa96HXtGMCCSZzgxYwx+fNyDB
	6ry/hf+w1f2BFF
X-Google-Smtp-Source: AGHT+IHrei69SE3S2Wo3PhQL3nGzDL0r6xFLtoIiPAj8bXHlYe0awD9SWK429eaX/ZmPsA2F6T6ySQ==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45dde220a2emr74636385e9.18.1757337183601;
        Mon, 08 Sep 2025 06:13:03 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9dbfsm41650181f8f.43.2025.09.08.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:13:03 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 08 Sep 2025 13:12:46 +0000
Subject: [PATCH v4 5/5] arm64: defconfig: enable Exynos ACPM clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-acpm-clk-v4-5-633350c0c0b1@linaro.org>
References: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
In-Reply-To: <20250908-acpm-clk-v4-0-633350c0c0b1@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757337178; l=820;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=r9B8eJrWR/g38PUeQ9J2wFXWREa48OIMpTY6cZptlBw=;
 b=9ggP3KUVS2zT7FryKyHNIZtbBh3Rqan9vA/aNkZzb27KJvR7ycYAxiFo0bkteyhSCJ1SQvT4Z
 n+0HD5LlcvUD4LkTHTo1imFXIzH7ED6AZ4JOBehLysGJoPG0239vgL0
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM clocks driver. Samsung Exynos platforms
implement ACPM to provide support for clock configuration, PMIC
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366cd12ae212a1d107660afe8be6c5ef..4255bc885545fb3bb7e9cf02760cac35bf2872fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1445,6 +1445,7 @@ CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_SM_VIDEOCC_8450=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
 CONFIG_CLK_RENESAS_VBATTB=m
+CONFIG_EXYNOS_ACPM_CLK=m
 CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_OMAP=m

-- 
2.51.0.355.g5224444f11-goog


