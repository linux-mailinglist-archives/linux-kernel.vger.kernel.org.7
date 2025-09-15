Return-Path: <linux-kernel+bounces-816377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E21B57304
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61B4164FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444DC2F0C73;
	Mon, 15 Sep 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLTOx798"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52952F0C70
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925228; cv=none; b=IRF7MO2GIv3Ac69jIk1jzhcBOj4M4Ef219OtZ8AqrAo5rY0V5SCJ0GcYrJyr1WHcVR2m9/9uxlNv24949y0jht5PSMgqPU68G6CASC1ehmarUt5+dJ90JUWDjevJgYu1Ne+0tfXDWZCsiLw32AvC95DE/j1ivv1k0XY8rFJ2YJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925228; c=relaxed/simple;
	bh=wucKZjXUVtRxrGoS9CppvLYgJwFvEG8gqGPWzlZGBag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBjwZRHfh76HR0+/bTzVu/x1DpGt/CbDi+fuOZypE2vbbs9ElCkUxAqjDxeRb8zUnxcXjbMVYa3/Z2/pmtlRpza6jkhrbVWxf9oSm1PPNdcblGCNSJtzPQUJLBMCOtiVeWzXnDpA44E7ASN5DLwvXi5ySZsgBlvgueqVrSmHnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLTOx798; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f7c0fb972so3787971e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925225; x=1758530025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=ZLTOx79863Y9dBGRIyWS02ByXJ5b3dBO7796MWO2BA9YvYPYyrfqyKOgPJ/9O9jEcx
         sh5ls7fehOXmv2n2NgbYuj6zvE/6WlesqtRxA2ppoFQKhxfRvwJ9ywJ1trLtSeqmO5i9
         8rAzhG3em7G6C1rlf82Br1v205tdwLwfMqUF8+5MXsKFcMHRvsLqqeFSaAtyP+NhdZWH
         JwIrhyPLIX/6xL6SV6p8DoBm+nx+ijjeC2QzPBpeudP/7nsbB9/C1bxzWMTSZuKBVmdd
         ECkGS3LcnjuhKsknbC5fYIurpy211mPzM/S7nWiGEUwgrPfwtPglZrRSncoGx+SZk78m
         vfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925225; x=1758530025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qUTD8uROnoCtAqaX/Ri9iIJ3aP0OlkHXH5AZacDoiM=;
        b=lm+hfX8XGhyzpk7HqoQfGv6+8Hdx2+lxVTPjOQ81t+0LfBnbDRHHuA5s36nd1ljQ+3
         5ozAL2d3/ldpReRlYMMwO0jr6lu6foPbAiG+jagq5xA+8u1moaxGBm+g05M8O0SNxheZ
         Vk9B0BAw7mrpvvWdFO7x2ts8RPsx53ps5PakAIsXoKuOPCt6jwam4vQHt2Hxgo05m0Se
         o5CJxHqvvfPhPWzHxCib6DKKcNpuJ1O+g8sPFCuwYRfboQCeEpf125eUwN8zPfEhfYWq
         uwgp2wkMwRJSrYKQid9HUOrPZl+qcYGjcMutvQij9XyRhnHarsGWhz5oluqRt2zoClUF
         FbRA==
X-Forwarded-Encrypted: i=1; AJvYcCXsVcuXuS99DNZ1D8nFFKavg9p2p0gw1MK5PknF8Ckd6Fz1uyhS7pajKDvApZ4oGj9Zh5+wI9n3Pqt/nqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Jx8Bky/ejN+9b4hdirDoG8Ab/3v6FjNAGUt35wPvDwrHVMz2
	axE6nVRepnk2yzuXX+HmdwoBbW/2LMaZno2iHFdt+kh82yfActXu+se0NoSMUaWQCZA=
X-Gm-Gg: ASbGncsPS5vtV3+hNPgBjVVrSjTYkG2/5un429DFUh6+v7NzLgRECbLvx/ZFsB2mQsy
	e3Psy5WiL3eU0KZpMrAdqdFL9v2LNNtIVdqacI64Zf9gfx302zygDz/eSkqRzbKoam2fw3VgLc7
	iJO36/MOuN15SG71cR4kATB7MFvbF+3NiYXn+PE3jgEANXY4ZrZ5r93/QL6NovghCTAaAIrL3uf
	0s8SlCFkGI0L7bICuybsFHb+uBa2I8tE7U/NF5Re6xd4DlN8ExqPqZQlI5L0iOQ1bgLchbGLMQh
	bjAxKqy2KwdV6JIh9bUqaHkj9ZZ41PAT2O0Qpria6UvKEdZbBqcYz4FB3yh2nNgnz6gicsRj53J
	zQYaBMG+Cdyo58dEC+/xK6qpjMrWta5e1rWAqwFUPM4kBRfAzJTv9m24=
X-Google-Smtp-Source: AGHT+IFCaOIerdSvA+z61cnaMnc6f4/AxdvboyLIWVzD2Istbx7t/KAwnGHxWdDUQK//4BQjlegbXg==
X-Received: by 2002:a05:6512:3f05:b0:55f:3e4d:fb3b with SMTP id 2adb3069b0e04-5704d0071c6mr4042367e87.30.1757925224185;
        Mon, 15 Sep 2025 01:33:44 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:43 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 4/4] ARM: rockchip: remove REGULATOR conditional to PM
Date: Mon, 15 Sep 2025 11:33:17 +0300
Message-ID: <20250915083317.2885761-5-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PM is explicitly enabled in lines just below so
REGULATOR can be too.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 arch/arm/mach-rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index b7855cc665e94..c90193dd39283 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,7 @@ config ARCH_ROCKCHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select DW_APB_TIMER_OF
-	select REGULATOR if PM
+	select REGULATOR
 	select ROCKCHIP_TIMER
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.34.1


