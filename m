Return-Path: <linux-kernel+bounces-880215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 028BCC25231
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4756D4F7BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A63F34B192;
	Fri, 31 Oct 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkHVekZx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203734216B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915368; cv=none; b=b7wk4X8OAsveghDXEwnDenQE3ByoxsudMpnZ3RqQlfZ3dAuWS2JYGZd6YLgaWA/QsaTCSaqp7y7p1QGFWD6j4rUB9kBOtjReZV/khDaoK0KxKcIdw9w3dGFlQ6n1bhQwl57AssqK5ETs8Cpx2HoMgaR69tkVWW9lDqyoPdgxsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915368; c=relaxed/simple;
	bh=5p1LeqfmmwFaeenEnSkkkwhzGqyUgPudlC9tgJJ0jsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sx+i8uVZNk2D4NvilsCpSNPRsYVqWyBS0V2LIpR7sQxbOQYbG+Zjc03+Z2YFcx3glIjkxNPYTsO17Y7SpJEbKmf4ql9Q7ewpVy+DkI2OHY1MlmOdBoQjcXnFdn26OJG2MX+SDiQeUhuXE4MozXaywulX5Rfuq43O9FN50gBsBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkHVekZx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso10541395e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915363; x=1762520163; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSizeuZT4cpU3hNiP/rAVuNIA7WcfkZd0/3ee9GQoRM=;
        b=DkHVekZxYsIHEKdYlAMZ7F6bfAVEFc0Er9nNl/RYgzkOO5wgMM8RxH2HGBCehKP6l4
         Why2xa2PYnQK+Rt558m/Q41061Iu53f/jSHdMq90772oDde+ixRJ1ar8lvSMjijR+iCL
         YnTGiqAYdRee8bBSTBcUybAgijTkaYQYKi2J6BKa3nJzBx2ZOBtlVlpabvHwPH/RreU1
         Te9LDH4kwmdQSKxLQi35RqwkQNCHZOIWt8Nx7dcjic0rO3gUbsz/HSwkWJNTbEuueIrr
         UvS/xBEU1KfpT+PUItslvFsVzFaTvS9yxC6M2kYjzv5L03iKgjUzCbFjeYjB+G/2+FiM
         hDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915363; x=1762520163;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSizeuZT4cpU3hNiP/rAVuNIA7WcfkZd0/3ee9GQoRM=;
        b=Ghd8OISioplngqp6LqNXkZ4i0SLKUAu72DJOpv7sYXpG5O2lf8Vw4MzWTANSEVUPm6
         YdML6wUIdJB5Aq+ywlmPIhFsRsFapE62Y9gbRSj1iw3kBtHyS+7NDH/zMTay+I57gXnS
         oEN38uBdOon5/EZf7oXl5D1DyIhVPvWaPW8GWFsWq/k50urDuGs/CRHwHUk4yl1tuF8c
         WKVLLoXvT0JMgOvQHWeadSPgJhusOnO54gu8QHaWDIiCBz+yzhkxJh67IuqSZecb9ScI
         tZFgOYQPT2qbZPnkRV1CwwzdtHukmwnvq+Udxn5kMg5BL7KFiYBponn/SNmsON7VguoH
         gxkg==
X-Forwarded-Encrypted: i=1; AJvYcCWkd1fIER9QbEvTThWMp88a120k0PUEOf4N6Y5BqLza9H+Qal68mVuWUS9jDTYfEFq3424rosdjWlMy41k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67e/qys1Z3UiNoDAkE+/fvED87bvDtGV7E0wbnygz2SGe5lgM
	bcd9sJKmad58R0AmMczqdyxv/QFJkg2Qp/vPVW5ptw+3o7mFjSGIctiRcQHY1PAqyZY=
X-Gm-Gg: ASbGnctleOEtmcEBPCJPMc1H9yR+DfHELx92FY3+qEcE2BJG36kkP3aV74gxmKxme8c
	GuVet2cP12zevfCin8r3cbK4+ImfEtRFBgIZSsL0iS+5+lvl82eFrIu6PxXLFAVsmCeI55eT403
	qg19puQPi8NH5z5wHeb6lLM4Off5En+dvHzoKaQeDVBXWt61l2WgfqJ1XAFDhj+7eY1IBJs2iGl
	AmBPtsep1AU61iP63fGCjFkboeJirGG2s5uy1D4B1C/41nfuDVgyq51GxLEEUl7xoPpzVhl5XjD
	zsI5ApU9fqbd6/2tv24whdzGAxqYMZOt5T1EvLQH89wsxvwesZ7zdR/Q7blwjkRUqhqn3CvBCyg
	Vtuyj6Ut8Gijf5tl8BMkImufCyaFJnosMwaX+66ywNLG7+FuUcIRRCvqSxDIg86o2sabqIhe/t3
	uuH8FKTbyk4SFlFps3DiJT/trLA2q4tAPNLJNlmnL7EkC8CXxbG3UMc9iEm2SJmwc=
X-Google-Smtp-Source: AGHT+IGWxYF93lfuQ/cW7BRqRYwYwuobMFF5l+VG4Chs/3oiv4JkKC1iwBzuzNb9Up1q3LYo95lusA==
X-Received: by 2002:a05:600c:a088:b0:477:19c2:9765 with SMTP id 5b1f17b1804b1-477307da91dmr31824705e9.4.1761915363285;
        Fri, 31 Oct 2025 05:56:03 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:02 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 00/11] soc: samsung: exynos-chipid: add gs101 support
Date: Fri, 31 Oct 2025 12:55:59 +0000
Message-Id: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+xBGkC/x3MQQqAIBBA0avIrBMcK5CuEi1ER52NiUIE4t2Tl
 m/xf4dGlanBITpUerjxnSdwEeCSzZEk+2nQSu+oVpSxoULpEhf2MnizeWtssDrATEqlwO+/O68
 xPkTejqdeAAAA
X-Change-ID: 20251031-gs101-chipid-fd84da8afa2f
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=1738;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=5p1LeqfmmwFaeenEnSkkkwhzGqyUgPudlC9tgJJ0jsc=;
 b=d+BPbUINRjy4l2Ym1VjrE6HaCPsue9Nyr0tngMPGtDoQTB20S2dUN9hf3AEOOwYRtOSMPMOd5
 AEgHi19masrB06nuIdc/Jx2kl1prsuWCOWbdWaO8oCSDDIa9mNVnt+f
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The patch set has the typical dependency of the DT patch depending on
the bindings patch. Plus, the dt patch references labels from the
efuse node, thus it depends on the bindings and dt patch from:
https://lore.kernel.org/linux-samsung-soc/20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org/

GS101 reads the Product ID and the Chip ID from the OTP controller
registers. Add suppot for Google GS101 SoC info.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (11):
      dt-bindings: hwinfo: samsung,exynos-chipid: add google,gs101 compatible
      soc: samsung: exynos-chipid: use a local dev variable
      soc: samsung: exynos-chipid: use heap allocated driver data
      soc: samsung: exynos-chipid: refer to match->data as data
      soc: samsung: exynos-chipid: introduce match_data->get_chipid_info()
      soc: samsung: exynos-chipid: make asv_init opt-in
      soc: samsung: exynos-chipid: add support for google,gs101-chipid
      soc: samsung: exynos-chipid: prepend exynos_ to a method's name
      soc: samsung: exynos-chipid: downgrade dev_info to dev_dbg for soc info
      arm64: dts: exynos: gs101: add the chipid node
      arm64: defconfig: enable Samsung Exynos chipid driver

 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |  51 ++++++-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |   6 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/soc/samsung/exynos-chipid.c                | 163 ++++++++++++++++-----
 4 files changed, 186 insertions(+), 35 deletions(-)
---
base-commit: 73f7017e663620a616171cc80d62504a624dc4de
change-id: 20251031-gs101-chipid-fd84da8afa2f

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


