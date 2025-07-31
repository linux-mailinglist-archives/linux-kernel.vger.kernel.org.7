Return-Path: <linux-kernel+bounces-752231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04504B172C6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4703258783A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F4A2D4B62;
	Thu, 31 Jul 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vo4MtXY0"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1842D4B53
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970529; cv=none; b=iEbM8pG7Ds7HvWA6rYT1Tm17vCF20FXwFfKLyjsMWz6Nprn6PSTKzRWPAVx27QjA6W+u5wFakUIbN/WlDjqkbe5P3VBDa9rWnTOvVII4WHyqjFIWOFWzLgvhLGUQ1AH/Ba9jxORG7GrFd99dMf1M8lOby8sx6LFXYjS2yt6HCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970529; c=relaxed/simple;
	bh=Q6gqUDKWSByswweoa4MByrpih4dPJFAYYxh1yHsXWcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyVrwnDY+POBYd8UAewVOn/+ZICSY4gS5+QW8t4/G2pj4PiFtvcF3P1o7fLn8n3v97xgau6Q1qNu0NRtqlMIFLTvwFSqn5FqOov3kiAuNCAwE4hb+SBwwYd/GnY2w1HNvRPXUFMlvHHPuzEsbFxqeRxcziXg2UXIG+T/h6VZktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vo4MtXY0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45610582d07so6583015e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753970527; x=1754575327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UbYDXw5XC5hpPAAcjH/Cyq+ROm5RlEeQDd+B8eN0DU=;
        b=Vo4MtXY03kYNuUrUeQxCtBINIE0fkvMJJYmFNFCbCJF/MfH04UE4cqKIQjOhpcYQxA
         ovP4MFcUEedM3gd1MSFQ20AAcJOmGMkeXpfnDp5AmguQkH8AZ4zaS4jHlPEOaP8ETSAX
         fjqiKyNxvLpyia/z4/9JPlvcrzQybnoOWcx08gBk9+Uy5EM0nn/PE5TjOunGSroDD5Ai
         4t+boDxQc9QN44HnR/VN3D1TB5pFTU8FsCkZllBqkj5ZTUl5M+ykRmElsyvcDyT+hThc
         KK6M2d74Z2kGkEXM4y1K0BcGVjfQNQhiZ0Z+metZi4aJJKkc5dDF7LZep5JeO8jakxkx
         PXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970527; x=1754575327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UbYDXw5XC5hpPAAcjH/Cyq+ROm5RlEeQDd+B8eN0DU=;
        b=DG+PS8L2KivwI89y7lV2HVsuZjIcGhHYhzklK3Kq9Z/qwxFWGKe2dlRlxKDTfUmSMN
         3GO4sfP8iO3+ycjaI4cuV14SDsT/hNSRx0pnrLpVAkTIdqyJMhN0d20jAdaLhNRl9oB2
         Q8eMl2fy7kLdaJTs4B+pIeccmZvwQtOjYYEpY6rVX2WZcSaY5yROaMmB0UHR3o5H9/De
         25dwckhI5jtS2hKpRDRHdWvCe7QI+OduKAWrWthW4tbGQ2Yere4VTs7WtTc8U59/zLUk
         ql9MaOxvDa+OAyryqTIjUEE4UZsgRlNvqVmIABwUveoZSlxZCBA7/F+1+rKLAy9U0tAI
         lM2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsIaTt/5ebs6JfBThEdxSxZ43ZqW4/0txF/yQD92xlnbk3s/4epqGnxR2BDAN/hHMa0GjbtMyGD9bZ4kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOLfoBC2j3zF25Am5PKFq5QALaStiGnKxNhwedZ7FQ7Q32Yun
	Ro8cfKWaiMkkBsvdoWK6WQ7TS2Lse1yEox2kXtTqqvE+XskuOogwNL7MXNozxnKBWNw=
X-Gm-Gg: ASbGncsK93Co9eE9lHdgRvafMsexXKnjjkLOhFqBQSNKa0shuGv1oOsCOe3OR8mbQLD
	I4LFnW6LXB3bgD8gZxQppDUlHIwFIPil/U5Dk1Xm5znx4rBoYXQ4UPB1elIWJNAFEOoGxO3INtM
	f5ObWdwWofXrM8reLBsWOqDEub17HSnHja3maIkff7RY2DmeobU3nmxJyDo5aYJ9BzVsLSOKPzl
	2s2NC1/wuHTE63HhBi+ALbBmdWGU+EidyaNMIQv3r8ineOm+CknkvvKWiFuvmTFAT7hHpARHTNp
	R8Mwd53O07ANrl384mcA4BGDObfYdbXt8zNrLkyYDDYW0EE1n7evAIVUmqRTrkYyboDd7Iw0ZgB
	L57Al1dniV0rwWAFzkBcDx3+G80iDJwgW19C4oYaZnWcVqS6zCm8BWUUd4ho=
X-Google-Smtp-Source: AGHT+IGoCseWUX+0lPWppwUdmNG0l0frr+iK8vwkU/QkBfN7U5WGI3OnPVlPht7D/5AVPZPGmJkn8g==
X-Received: by 2002:a05:600c:8812:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-458930ec808mr51382735e9.14.1753970526033;
        Thu, 31 Jul 2025 07:02:06 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57c18sm28121285e9.28.2025.07.31.07.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 07:02:05 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mbrugger@suse.com,
	chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: s32@nxp.com,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: [PATCH v2 8/8] arm64: dts: s32g399a-rdb3: Enable the SWT watchdog
Date: Thu, 31 Jul 2025 16:01:41 +0200
Message-ID: <20250731140146.62960-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731140146.62960-1-daniel.lezcano@linaro.org>
References: <20250731140146.62960-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SWT0 is directly connected to the reset line and only one instance
is useful for its purpose. Let's enable it on the s32g399a-rdb3.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
Cc: Thomas Fossati <thomas.fossati@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 467e0c105c3f..e94f70ad82d9 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -72,6 +72,10 @@ &stm8 {
 	status = "okay";
 };
 
+&swt0 {
+	status = "okay";
+};
+
 &i2c4 {
 	current-sensor@40 {
 		compatible = "ti,ina231";
-- 
2.43.0


