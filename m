Return-Path: <linux-kernel+bounces-727512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA11B01B22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9CC7BF2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099628FA84;
	Fri, 11 Jul 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHFO21fS"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399627EFEA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234453; cv=none; b=M+0Nd8VLGzBaibpwEDBxLNoHIhcxcKCbVSmnavYoBY05W7/hxUdLrOPG47ldqfCLoXBS+JbTPXiZLvCAaY9XFmgVcGHJkgq+/aHCRkKOURxHvnb5IabvuddNf0qNmmrKmUI7oN6vAz0LCzhKQwSqp2vXt7C94L1tKLv2vd3YXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234453; c=relaxed/simple;
	bh=QJVaK3OzonhM172ouy0CpSbbwuoG2dejA4OnkSXs130=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1ip1MHPrrAhycidR+d7ECzZGfUX6vwMFFX0EQecIBGkhRJsntLThQevESN7wkd0LX0Nxzc26RualVICkhIHo32vBpBVoqUOL8Dkzm3/K8aGrKwwIZISsfTLE09NMOn2s9c+eBFd2IDLlnnSgOvIkZ+Wt/DHiXLmndkJmqVv6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHFO21fS; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553d52cb80dso1972014e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752234450; x=1752839250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRhFukVlfvQMsLzBFVuMG+Qi50dL1WntO88bS057RO0=;
        b=iHFO21fSeB6r0NI9Bn82bDDS8mZpmM3mfP7lbcTnFrvyFkVRYw6J+vgEdeyD22Y/au
         toTAc+SxPYaIJ4Oec2eOpBKdGKEyPnWUs2yno2f/QYSYbW+xcsV6xyZw10nKYj3pACcF
         HYXSaSTCNRDd5s/zAtMXywxrEoMVm9fef6hMkQq20T1EUEOFit2wX2baJIzDYQ/xVPEc
         BCKQjLNb6Z+jv2KPbX+VZM9FxI9my0H4yQsXm3sJ98RccjP5MFGLwcUROwEfIGTilEVm
         EosHI/RpkSeHABHQt/OysGmVQWtjjaUcv/3hY8ATMPy4H90Twi+SAXBbnuFP1Nro6ciM
         VhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234450; x=1752839250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRhFukVlfvQMsLzBFVuMG+Qi50dL1WntO88bS057RO0=;
        b=VNqfp1Ow42DHXtN4E+rZi9GhLM0ncGUZFV7ZDhUE2FeM8WpNQo11mBOcdqC6um0TiR
         V+oYEqwZzRd1vH5ucgBa+0iOanWqUEyd6BLBD5KeJsbvOrSBiaaqy+VOWYzDZhV4YdjF
         qcW5HKuKexiDIDAJtZAtgjHuQhMdlmrQV+Xj97ntlN/n+G7AvUWLSAw2mrQNKPNsMd1o
         mBw7yVvtUUb84qoOKzM6ERcKVrG9Imer4g+/4ZGN+4Ik8Nof+SX3kBXJIa1FZnUozDP0
         b1YkYJFnQN+vyopAFQn5q4bPlLBAFEQZgeJyInsZw4PqYstBTfixy6yBAJei7BJvDvrN
         YK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvPhJFGONqaN2FLaJzBHJt6ANC+H5bIqr6YTZDlHFAuejhwEAFuu2Rv3SUfb1oOzN6rrJ5opRFMf1BfmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx963xqt0Tp+GDL6XTaZ42zPHHUiFnEoM6W4BBk9oBcXWZ/ZxF9
	AYmwLK8WAtG1HmVUTAVsIsfygeEgB0G+wN/pPtKL16lDx/mWWpCF5lJON6kLk5yLuDI=
X-Gm-Gg: ASbGncsZsCkQtncCu+fjYPnunf3X+Pd9lsWmoxHL+PRJ2YNGzBO0Z2F0BH4r1syTcsA
	c7K3r+hyg3L0/0VN02V/4hkSv24K9SBMIIDOc8iS5ClnF4pnAyEFvWW49FclEGpMdrbpypTSjna
	6FFTBXAdB6PybZTjxq+Yf0XLBcJW7IrETF+3ig1xU+0/mEKjgPswZi4MMYoHs3pQw3yYb3vwJiQ
	e6P/iHmaSVx2H4FcpT8FC5ftCW3whb3Rn0xQ0YLgZoZ763U9ctpS/JPDHMsLET07O1PoLNnQ/hZ
	pdz/uwzEmXybstascHWg++f9cUvSjGA2+ZE+hKWEAsbZSHEAnc6L3KYk6SrTDBbFMq9OTBnP1EW
	h5Yrja13OZdO9MZqqUZ9pOgseca2OiJdpEZq44AWPJ2eVcldztdCiDBDmu8RC/ZliP62fGmVwT3
	7K21fZe4c=
X-Google-Smtp-Source: AGHT+IG12UDrTXalEDU0YKI0OWyt7RE273XbDSoBAUX3pRGix+0Sj5LWHFUpgBtVPKp9Q0+KnL0ueA==
X-Received: by 2002:a05:6512:3405:b0:553:243c:c1d3 with SMTP id 2adb3069b0e04-5590071bca8mr2492286e87.18.1752234449986;
        Fri, 11 Jul 2025 04:47:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b60f09sm915928e87.154.2025.07.11.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 04:47:29 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: samsung: Fix splash-screen handover by enforcing a sync_state
Date: Fri, 11 Jul 2025 13:47:19 +0200
Message-ID: <20250711114719.189441-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's has been reported that some Samsung platforms fails to boot with
genpd's new sync_state support.

Typically the problem exists for platforms where bootloaders are turning on
the splash-screen and handing it over to be managed by the kernel. However,
at this point, it's not clear how to correctly solve the problem.

Although, to make the platforms boot again, let's add a temporary hack in
the samsung power-domain provider driver, which enforces a sync_state that
allows the power-domains to be reset before consumer devices starts to be
attached.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/all/212a1a56-08a5-48a5-9e98-23de632168d0@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 9b502e8751d1..5d478bb37ad6 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -147,6 +147,15 @@ static int exynos_pd_probe(struct platform_device *pdev)
 				parent.np, child.np);
 	}
 
+	/*
+	 * Some Samsung platforms with bootloaders turning on the splash-screen
+	 * and handing it over to the kernel, requires the power-domains to be
+	 * reset during boot. As a temporary hack to manage this, let's enforce
+	 * a sync_state.
+	 */
+	if (!ret)
+		of_genpd_sync_state(np);
+
 	pm_runtime_enable(dev);
 	return ret;
 }
-- 
2.43.0


