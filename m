Return-Path: <linux-kernel+bounces-724345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC770AFF19A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE947B6757
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770B2405E1;
	Wed,  9 Jul 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKFNscQZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063917597
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088534; cv=none; b=MVAHtd9x9UprBIOzZz1BR+Kax0KiWbM2s/adMIoSeW4Q1Ibb7/zicbtoh/onsklgqfh8xf5bNddExkW+jvET6/3gpTM0PzgMjoQhAiLYh/tRmEXsttfVg5SzVV0EbcwZgwJvRW6oGbLgWtjlskaiIjw0fpl4mg9noy050BfeJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088534; c=relaxed/simple;
	bh=LBLtPnGLFKCmbpB+0VnZBJ/y17TkI+PJVcwVQLb1mgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItNh0c3bZBaaig1fueLSwH3buX+Wuh/51C6ysKtTGFgx7JxgB8OQcBObo/5tnPcYxsG4fCi4akkaSfo2jaJm5YWKGSkEhSH5BZFQIWdyXuhOZsErDgvcOyBjpDnvXLMSnziRcAkFI+1NLK3WMh8tcjkvcjH9vxXBoCHpgUvBEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKFNscQZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450828af36aso201505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752088531; x=1752693331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsSnIgBBZ1kBciUGilPIV4WsdrkG/yK/XMLgkUNs/ME=;
        b=eKFNscQZAO0JGj9Smy+wf6JzBAg2riV46d8nhiwbM2mvNTxacj3hNK3U8tVbtbniTE
         mjrR60Ob2j+/apcblPyEXwXxQXSx5DMhK+greNYZozE8UOetuEtY6blK5z/rYeoERGld
         tUTFxFrf+BO+S549OjDL+PrgWAtfA4an6xgf6WhVaN9AVTPWdPeFGb2soND6h+cHcjcb
         PVgtud38Rfv5v8AHu1UeSE2jmvt51/2SjJJVOO+UIgeVLFG8Z0HVVcuNE7CKpfihmxqr
         ReamdTcmlxwWHqBPAaZ20xhIK2KFLUEqt5GQv8xR5hVO5PhB4TjZKSVvyIvA5X42WnG/
         hImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088531; x=1752693331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsSnIgBBZ1kBciUGilPIV4WsdrkG/yK/XMLgkUNs/ME=;
        b=FVukuABZdHevbh9xGYUX//aVCeJNofaPLNxxq0OPpj1qXOCNhCZXWvm+cSvyluJ8LG
         IgrgfEf4CocgbHdXNcHQFy1vD7faB+l/5K0+fEn61lXhx1OesBI+ct+XTAHX33mRJsEr
         QdZQoD4g9b+48dDVlorLaN8tq7k3kLOCeNx765UVsJWqRcQyCYq4MjkKlI1vU6psI73U
         G4tFiECldDDRD3OEgWXQdJKa1s96fZWejDioiZLgtmFYYeBhCnAoXU20f5rUSTCNMPdr
         tmRvwvvxpom1xRpgQePVO24/D2pXKFvy0UuO2vbqhv5PcogxQgBOLlUj3c6QJ1ls2IPh
         5YRw==
X-Forwarded-Encrypted: i=1; AJvYcCWms7RmJFhPPAajmbzBjCv941g7cBa9mQBRsrSwMRZ9V0WM2cwuXG9x6OyZi8rLoyLpP4M9Xgvazpcv7p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wjtYeprAQX+CHTBRNC1rJUQwc7dr9sJ3zOG+HZ9xq5SDFxX5
	e8uLULVc5cEruRM3vj9myh3knUMgmMXD8N/Gs3nxyvDha0v+W7cBLpEYnYh7bSvD7jU=
X-Gm-Gg: ASbGncuPeo8QEu5DEKoKt3jX0U4gAko6R3+OacioTQtVXKrLgBCDdeDNxT1oK9MuINj
	JfaAR5QK1EkPZsKzWAfMxg817MPfZTci4LEFDAESSsxU8i3+f1yTtsbs+8V4IU3exTXi3SBraRl
	pJZYbG/Gfn8QYDbf7iasE75ou92rMhpg3gTqBnny5fHx699oVnn6xMxJMal0EfC82ozf1Aa2wlS
	DyRoe5ONsKT/+czlrWe2RIg9OVpxIk4Trhipaj+wQLvSV7XyfXgsrqLDGd3oJdt3U6CHlMq5DqX
	iVIbVvF9Ze22JdhlPwLpOoMP+HPLDOj4GjOkZ3QqF1wX2jPeiiLpOqAOKC4fS0ylLuwE4V97CAQ
	=
X-Google-Smtp-Source: AGHT+IEw+2/Fscn7De5ZvL2RlCEWtJ9eIRsrKn6Ngh3wy00p2fYxejGpstLQTHOXdLIlShkvStCcLQ==
X-Received: by 2002:a05:6000:26c1:b0:3a5:8ae3:bd6 with SMTP id ffacd0b85a97d-3b5e4576314mr1192466f8f.16.1752088531010;
        Wed, 09 Jul 2025 12:15:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285dc08sm17159588f8f.98.2025.07.09.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:15:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] ARM: dts: samsung: dts for v6.17
Date: Wed,  9 Jul 2025 21:15:21 +0200
Message-ID: <20250709191523.171359-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709191523.171359-4-krzysztof.kozlowski@linaro.org>
References: <20250709191523.171359-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=LBLtPnGLFKCmbpB+0VnZBJ/y17TkI+PJVcwVQLb1mgw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBobr/MuYhtk8c9lMPkEtPvmo+CAlmyNqzC5XKsG
 etty9ihw6aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaG6/zAAKCRDBN2bmhouD
 17IgEACQ//MMqhTUvXRVCfVpbI4nZNkn1RvBEh7W9Sj1SBLGztID8SkulO7Cf0l02iB3pzOO/Dn
 m2bWGs228g0m0mL2VsXk3hE08J8j2weor9nT77c3WmOGpv2H56SURP3bIuJNIrvWrs0GJ9gumjB
 3dR5PFESdOkbgNj6WIdVikTPhHBXpGfvoMXRZq+qLGUamca+1JdzOrgsEUYjGoVmMdPBji3Kor2
 tRYccxsqUZyw2HF28CeOMDHIU1F0voTj6U6K8Qeg92D8zN6E0UZxxFN8hxqtNicMKqiO7nZlMKA
 nfsDALvXuTDAu0M7BBbXFlQEYhuhGuvLjMJJAk+9yjgMhz0JDplURFo6JzTHCHzJYS737Ze4zH1
 f7K7MYgqco30pBfz8lKugotvynygJ1JAW21MPmTNnrnRszILRaw7FHBbfxYlOjU/CCm1P3pAwV7
 /Ex1M+V+Bp/x3SYrEdc/I2XjyEd57raDmhqgSpKFB+efOEUS/alwpewpOJJQ48zcq+ywRXyUUa7
 X6VS61wmqOXtSKLXm6UPnTpHNBd4NwiOdYyKcwZA6KGGfA0HMpfomV9Bs8LPYEEMtezmxWPl0e8
 VBQBR0Vyq2FohU4tVyr+goz9DGutUd8JIYXTSIe6JvKhTiUlIn90Bd1eAQc7/Tco6MD4CNYSRsE EFqv2w+iKTAuMwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.17

for you to fetch changes up to a24cd2f207efa73d7ce8089ce4848aea99f48f6e:

  ARM: dts: s5pv210: Align i2c-gpio node names with dtschema (2025-06-25 16:11:48 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.17

Just few cleanups based on dtbs_check.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: dts: exynos: Align i2c-gpio node names with dtschema
      ARM: dts: s5pv210: Align i2c-gpio node names with dtschema

 arch/arm/boot/dts/samsung/exynos3250-monk.dts       |  2 +-
 arch/arm/boot/dts/samsung/exynos3250-rinato.dts     |  2 +-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts      |  6 +++---
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi      | 10 +++++-----
 arch/arm/boot/dts/samsung/exynos4412-galaxy-s3.dtsi |  4 ++--
 arch/arm/boot/dts/samsung/exynos4412-midas.dtsi     |  8 ++++----
 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi    |  8 ++++----
 arch/arm/boot/dts/samsung/s5pv210-aquila.dts        |  2 +-
 arch/arm/boot/dts/samsung/s5pv210-aries.dtsi        | 16 ++++++++--------
 arch/arm/boot/dts/samsung/s5pv210-galaxys.dts       |  2 +-
 arch/arm/boot/dts/samsung/s5pv210-goni.dts          |  2 +-
 11 files changed, 31 insertions(+), 31 deletions(-)

