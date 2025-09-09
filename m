Return-Path: <linux-kernel+bounces-808823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57BB50524
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784105E6610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13C32252E;
	Tue,  9 Sep 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzuqNp9o"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19D3126C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442244; cv=none; b=BF/gmtPw4XPgeZzvyvOy5Eht63l1HcyDLvfOXFZkup53FSQal0KlZQ+zHjXpj1rl8tp40cU7tf5AiTjGMi5y/QPSyCPT91t9IE32IZf2/kAtXuhgbm02N0PpPkFoXr9WsOA2E2vmjKzyJlF3SuN33z5XANr1IaKmk0KdKNeTax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442244; c=relaxed/simple;
	bh=PYpuE1bg3M8RrfKVn/z5QPHZvCyw0Q4F4OFmwIUXtHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO3S/xmd/tyJrnmWjBhT2vJeU0QJX8PMdXNqilPV8zFg1nSJ1OPRKdgBVnqMDSPtjguTD7uvwTgHwI4KemBVzaHF31FUlA9r0CvgDFm0pghNvnjnGjKW9J+IfCANpBP/EaBw+yb2sctnA/WsOb3U2HGzX/dGHhO+vQBxRUcMlSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xzuqNp9o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f75e85dfeso726690e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757442241; x=1758047041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWPK6qiwC5pY+gvwfZR7zxOqiXiBtA6mSbWCJx8aeqw=;
        b=xzuqNp9oqvc7OsbdmnMzIjQ01w1yndPRuc9R/gAg1YwZG/rRF6tj2LSkhLJ1j30olM
         bhT7B2wls3EafIP7H785zroYx8dUPbQi4rmOsYj4tKT/E2Zdyw/fKwOkkxs2EeYS1CQn
         ILPhs0Fx5KvU0+wpnA9l10KNQDxSZ8UHdKPyaEmffnl9pYGi8yZPG/d4ouf/uEpBxRBB
         irjuDG0B3W+NHtzQfZAlBjPkTh1o/cC8vfTf/OL14O/AzQ+ZHgvxlJFnSENPcJ380rtl
         HUImEDOmtop+YVmksVXk15nzlSTupf/PL2EGaZ4SgrlwsLNWHwPBoQXuhYmjM3+QG56Q
         Udcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442241; x=1758047041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWPK6qiwC5pY+gvwfZR7zxOqiXiBtA6mSbWCJx8aeqw=;
        b=Wilg6Wv2V1b5nYVFLOGoFQynlihBvXvYaNqAzDegI42r7AULekQvjIGZtX0Ba4A8jB
         593WLJ1/7om529xxMtfhLqapI48O/RoiNTqvtA34I48pdiCpY6Xl8rQQRIqsmeEE1uAy
         c1vnNAS3JtEfcdLro2XOuBM6pjQyMWfJsg3OzLmroct299Grib1YJQsELBuibWYt3+Bj
         fuxI94Jz07+ftXeej7yWB+0UES97UT8aR5AGYdrM3dPes9XRzsLmRJdoM3BDKMGWbYtq
         rKHD0zincSKzYNDACa0mVeTxHZuanG0IZDiLqx3kWsxK5yQBWdpkEo6BTZod2KRS6njW
         cRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDTnIhOiDwfmnV9TQpexS8PvijVMqV+PE0CbqZRevHHDPFAoLWdN/pz8JtTYs+ILlptLgEksrj3VxZuRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUOhqgsDKgg9ToHs7hHmiPo5LN0MZY4bIVvU8ZtYSbwiIV4zv
	jPH2Rz/ENLhY/806KRzGg4aAfiA5A28Q6QHPwXY/vmOafz8WeRkMyYqQgatXY8Ewoy8=
X-Gm-Gg: ASbGncsBKxeivIssPWPwugR//PXtRGgl6m3WVXSlYad3xsEzIhihvJpMUAU/gViPu2f
	YxutHUozpc0UgRk8zPv7RQRm7/uzzWeQXIPvS16IukT3ij+CVz3D2z8cKoWXdb7ktlW7GEN5fJt
	Xwu7CD0wm1IcKCWrCKr27i9hCWV8OubU6qYfev7bnFIEh8R592mf2ql+6AGoCmbGs2Id1fiP568
	tb1NlGvSzY0DMYEgW+4vUi2lZ0IAosIgM0NydYQPOgo6O0rgh4FpChiox1Zz52DVWjw90W4wxoo
	9cNnzF6J8ctfdnNrVE0cdAaF8pnw6fRNNHhecVZ7kIaX3dsZm3lc1EcwaZFG0PyWHRwbV7MOfbU
	SIs2XFpaVHQkuhmEYf3U6fxBxLjOuKXvyWg==
X-Google-Smtp-Source: AGHT+IFKUMj2Ann+5FvQWmTru0FFpd1c0y5YYx+6dgpjzz3R0gwegHovdsmJzRrG+FbV0JmNIFTadw==
X-Received: by 2002:a05:6512:61cf:10b0:560:986c:9b4c with SMTP id 2adb3069b0e04-56262a40f5fmr1551769e87.6.1757442241028;
        Tue, 09 Sep 2025 11:24:01 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d757sm676071e87.82.2025.09.09.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:24:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: cleanups for v6.18
Date: Tue,  9 Sep 2025 20:22:56 +0200
Message-ID: <20250909182256.102840-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=PYpuE1bg3M8RrfKVn/z5QPHZvCyw0Q4F4OFmwIUXtHo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowHCA48KtemWMzw1tyv2NmUMBfo7b8GHRTLSZU
 QGFn/XMqgyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMBwgAAKCRDBN2bmhouD
 1wcPD/9nMH+muQgC86bN7iFNvLm+8O4InFbUmjf+AamXpj6CNoZ81ArlR0OgqmaG696pZh8+RKz
 r07DvRWDwSg2rSA1iAc6r45EvvPa2RCLFujMCLgp5llAixbu4GGVn9xvr9/bjUtqYIMcv7l8Xt7
 VGZouaW2YwL+t/wgOuBuA4dBvO805/I3XOwpXsADwrBfXtUEEH5Dr7dYeULkMB6HyQTYUWqaU8e
 mhnxKqrpUeF46mWVV1O7SWPswl7ieI60I6pmfFmn7eWbis0K4ihsCE3VcM9wsbT+OxkWcO5F+WE
 Be4c1TzYiMA6vEzRkiMFo4egPhwxfdYp3eaO2DyXBTCoNjJmmc4Ymfy+pKvCxTJ03sl6rEpsbfQ
 rOJNaon/J4sU0pz7pvecYodoADx9U8Y2RKpCqt6S/215BEOneyXDfIu9lMIEgoa2tpomeo4aVi0
 NSKYCbqjowjxRQsEwXDTmRteMjDyLAXgu517Frl5nz1B6EquOMKNecVjF0m+rJ766gonkY3frfF
 /TcJulsVdCrV90Nf/NCGpvCfa8WGrCtjAOO5oiZ/SkppfPy7K+PWIcdONYAwDIKJ8jwOhg4Loc2
 t9j2UuQUUXiwx8rqagzMLmCpJGn+Kud/g1/etDtKEWAtVHXDKZiUSX7zUu1KftuvbgsMH6AsvX0 KY2NQzSXvxETe8Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi,

Few cleanups which were not picked up by their respective SoC maintainers.

Best regards,
Krzysztof


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.18

for you to fetch changes up to 7ee0f223cabe9b9384250024fec577c731cbcf72:

  arm64: dts: toshiba: tmpv7708: Add default GIC address cells (2025-09-04 15:50:47 +0200)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.18

Add default address cells for interrupt controllers to fix dtc W=1
warnings on Amazon, APM, Socionext and Toshiba boards.

----------------------------------------------------------------
Krzysztof Kozlowski (6):
      arm64: dts: socionext: uniphier-ld20: Add default PCI interrup controller address cells
      arm64: dts: socionext: uniphier-pxs3: Add default PCI interrup controller address cells
      arm64: dts: apm: storm: Add default GIC address cells
      arm64: dts: amazon: alpine-v2: Add default GIC address cells
      arm64: dts: amazon: alpine-v3: Add default GIC address cells
      arm64: dts: toshiba: tmpv7708: Add default GIC address cells

 arch/arm64/boot/dts/amazon/alpine-v2.dtsi        | 1 +
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi        | 1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi           | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 1 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 1 +
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi        | 1 +
 6 files changed, 6 insertions(+)

