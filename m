Return-Path: <linux-kernel+bounces-880224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D5C25288
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13754F9FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0334B183;
	Fri, 31 Oct 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBhQa6kw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B434B682
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915377; cv=none; b=A/w1i6sZwUPzlGBNVF8VHF9GUfWdwtPaksy+VvzhBEU63/Fb8mWz/ZAF+SsWaekIj3iCQ8D1m1l83tKJmiy22ddTsseBTErlka5XJWBkZgFIFnhUARbVMdoq7n25ftK/t3/C+3haSjUlhtk6+BAVQLI9GVcAFDozzlFc9omTC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915377; c=relaxed/simple;
	bh=SNitQ6iR1OrWkD+1kTT2otCfVrWRB5Aki2fWLfOjKbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqC58KCC8RMlg5hA7zwtAwjoPJeQWcxpxTE6V6UOs30CJJ0hVZEb8QnVULQmFikL3gmni7z+DG6fkSqj7Q1N0vVOk0AOqFdkIkMdWoyghwE3jPrsqSmzA5+AA8ydGzxxI510digdAdmhe0VTBTg5qTeB20Voy6+HFW9qTKcGMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBhQa6kw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47117f92e32so19200775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915373; x=1762520173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPmKs28lkpvHoRqiGTUvXenyc4ndbMqG/sODnZUvqnA=;
        b=UBhQa6kwo34GlyUttobY4UbBFhkSUX69JB3wD3r5ahlx6xQQmccAOyqoVX+UZ01waQ
         iNGOBnaexOYyzA2x8335AAwVIy//i0AzXSJ71R1dlVWdaZD+f3FIuZU931nU/cGTYjgX
         /MBF5n3g+/kQTM2vRzHport5NmNvl0QdRP29ee3xw205Ffz2DW6wy8S3lCWEUNM9aGgj
         cQUA16K/77T/8/WLbnE6zvoDkgS7XWKlt8p5uhISY8Bq78wNIkpVuTCnKPMAecsugdUV
         DUk4Gg8JD/QPLpKHMeAle8/3X/y9JPpDzkDdX/h6/V/1JRJApbKz78tR6hDOw9u3RWHo
         MHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915373; x=1762520173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPmKs28lkpvHoRqiGTUvXenyc4ndbMqG/sODnZUvqnA=;
        b=dIN8wwbuosG9NEWtV+KbigDq3LJ1T0mmSa5GM4yWVwsOFl8m8rPkTb4bDLvGrAqA8j
         NCYoz+BLlLahXiVPNFITXZzlAf1tgCiAUNkR+3efvaJFiscY6vO4CdkihCrfOqKuMFvT
         vX5ffYkEJvD1v+t/hzcXWrK8MvuQaedufOMptJ6esdiT04mjDiSVdgNSyF6Y2i9Qr+73
         a6QIBEq4DZxtUWThZxG8RaYGiApaN6rIJhjGmLz2Q5GZw6u56wxT897MyajGQOYMUIDl
         J4WsPFeb1yfKDQfaPH6iN5Zks/z6t8Zvd/jxCtRfuNZ2tWkxfOaPimzmR7wnkKjqHVH5
         k9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU5dn+Dp82r2NT5q4ethNCA8Dc7f3PYdZwHzxl+yyoso3FJ9VacuFgqx4u11bKQ/Z8gF01fncJG4BviIpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZkiCze+MUCE1RQyA/1FkvsqlqzoIsItb+mTmmtgFBoK+SqQ0
	dZI2qkF/6sOh38REXCEu2bOcegfSp32WESJRYKCVi+EiTmcnU7Y8H16qkN55Z/HQMf7No8fuvN0
	xJ+tK9EU=
X-Gm-Gg: ASbGncspKZW/jLHmRID5wLRcyHKZ3qEAA8R04EXqPEKpsBo/asS7P6uy/czn37c26FO
	nrYsU4aCl6o+nyGLXyBbngtIT+OyxaCHocgIYxquBazdpIvNMG42Y8uXDNvUlcy5BII4ZY3E7uO
	baUOcdesg4WiYONZFpz2i+1uHbnjYLqML89GwgCn/WK+ZHaXJhBnkdSx1gKoly+yFalwIa81Puv
	6b9q07NlHFJTBG9G7jzT/XBuhRfWomLNr16goDI+vW6/aeriPYkpA+rnxa1vraeVo2VSNL2JCol
	iGojFRnuPGtMrz6fcNFs82POXrwztfGQjLHD8aXST0/VlQWtLBlYTd+z+5wcI9Au6aBIlXC2T50
	1chs0XnF2pxb2mvyFylbTwSu3ELAMtbvThZOukpABnrjIC0VSlBuZDRrFiGPWNcTYkvlW+rBiVr
	bNzNVWYki00a7tZC66X7z8nFcBVVaZmHOtUVJFGECbMZ7sdbR8T7eI7a9Tm2Yousw=
X-Google-Smtp-Source: AGHT+IEgFt2drlICBdE8c15ZSdRAo3YhHP301vNjyBeBb0HaK8c5JkyxDlcHps+bf8XyCx+ZBmNPVQ==
X-Received: by 2002:a05:600c:538e:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47730890e99mr33964965e9.32.1761915372724;
        Fri, 31 Oct 2025 05:56:12 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:12 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:10 +0000
Subject: [PATCH 11/11] arm64: defconfig: enable Samsung Exynos chipid
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-11-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=829;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=SNitQ6iR1OrWkD+1kTT2otCfVrWRB5Aki2fWLfOjKbs=;
 b=tiltm92a6lWnlNHMGe7UFecCrk/97yelVtT3Nd5y3c3b6toA4eFvJ9l/AoAY69Wscue1C6ZYq
 vOAuVToq/TGCmsCXChXNd7/Jjdxd10s8Y2Ky3SlZlKDxTR1t/jGCqZq
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Samsung Exynos chipid driver provides SoC information to userspace
using the standard soc interface. Enable this to allow certain user
space tools to acquire this information.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 646097e94efe7f1a18fb59d5b6dfc6268be91383..cf1a548034d28db201bab0d48b838b4136dbb59c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1530,6 +1530,7 @@ CONFIG_QCOM_APR=m
 CONFIG_QCOM_ICC_BWMON=m
 CONFIG_QCOM_PBS=m
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_EXYNOS_CHIPID=m
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y

-- 
2.51.1.930.gacf6e81ea2-goog


