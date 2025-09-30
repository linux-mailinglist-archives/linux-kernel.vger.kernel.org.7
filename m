Return-Path: <linux-kernel+bounces-837152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD2BAB8FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88ADD7A85CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6931928152B;
	Tue, 30 Sep 2025 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDaaisk5"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20428137D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211446; cv=none; b=WNIfYJdFHWQhFWFTo5BmWPAYOBp4e6pLWvgdaaFgQoO5CunbhGp0MDjilXTxtrIdJBeE1+jvs7xGn+HZud0G2m3FL74Ol0T/KQWltwdoTjGpnOfoscOEkLwrxrmVtPIuqdsbKV89cnRcRfPHTbvCp30R3I02sUn9HKlkuWu1E+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211446; c=relaxed/simple;
	bh=fxxAVmPJGca8589Kqpk9mJo76fAFnptROiZXxjqZbz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWQ4HkIm/jFX5a2G8kSEA8Ew8WWsw8JQ1rgAMtmmVmkBUaKAhDc7imkHd60awMfm8C5nzt8NcuDmjkNJDaYx9LNk/kboqkKyBdi5xada06QWrCr0TsnYNiQMlAxJKf51hDfOTBqbSTp659nS8VhGOCOBuu2jlsBkahUIPuaqQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDaaisk5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de8bd25183so52983041cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211444; x=1759816244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=mDaaisk5WOi4kysBuecYhyn6+LYSGp8ZujcuSbXulGT4CQks2GX2B8OCt0LsZ3lRMr
         nsKB6wwz6a5M9y98cyjUCEY5vjNc0yLAbf0HH5L70prLO18OVlvkzQF9wTs586WcM1ra
         p9zpJSHPJb3T5jselcW+FYix59wtYShX0MbkmSLAU9mB8eSaXj9ZaOEgedk/z769HcZB
         SXP9xo5xwedGU0nHdwPxOAu9tU2LKMiwKrXL7qB/r/ZPE0SZRY/NtIaKhL2kVLQLBJLn
         RxYNdwmMoPIrzTom2R1ClVeqHRSGEPEY83GQj9xWh900cFafcwD89vE0/wRSg9B94002
         Wvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211444; x=1759816244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDW22d1KEEhzhYCQi/m5g5KGiHWCtagl6QTEa0SdVU=;
        b=YaAE5uE8nKedS0yX2hhqUd0KmLD3a/doZwgVvLlPKxHefU/eawNGKaRD9vxW2qEq2s
         e+yFC8juwoYrRV+1BuNRTyjfbgz+w45zG/KeGOhHZnov2xVLenDLoSaRRce96k45ObpS
         2AycEBBL6db5ExlkA85pJZ2PWYxry5BTaupzZlK1DX8ksK01tJrQnIFHNidQDT9IlqwB
         G3KpUmAcmqVugxLQeDcyymD+E7yVsjRVaJnplFQ018TxSomHusgO++Ns9fFYjW0GYOXy
         N83qleWdek8CwrCCKRED3ec0sSeCKm1BSIwSFUT0NiO0sqI0oMF3JzDSldOFEHaUL3q8
         e8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHd0ksH4GGWHEXauFRxmw4RdP1q1qMI5kof57TrMew0RG8nHoI95Aut/O3ZBAJp0BGRBdbeybHV5fC8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCk+OgS8/5kqzRW3+J7sVfZg2q6cazx+ZjaGk2bNAE66sh1/Q
	dxFmcJV6rbT0/daXmA6/dfk2HobYaYhHSB/hqIuCDJU/IelB3pWeHVp9
X-Gm-Gg: ASbGncsCngt7ULrIBhEiFW87DaQj0/QTJfqGRdXay5EL4O6XOOcyRTGnARdFR9+llIX
	yxQ6GdgjKUeT7cVzuR19JdvwrpVpwkYN+HbTWUxM7zknl0J+dYhtgUpXuzHL/QEQlpT6hrhMQAo
	95nBMQGCularLX2OnPRARv9vVxMiZAtGteudalS3TWifHQ2tXu001tqeAGNMRE3OohAZMXeibOH
	kVOiU8QjRuMeAVR+EP66K4wrOMQrTtE3r5ws0VMe9vNOcbnx/BT7+81dn07m2EV07o0krqYfx6a
	EcRtY0CcWkUq4b6mvVp5ojzwb8WmMn+/fSrM0fcooCDDGBWtKnlcyK8DWOjzOHucKL9NgZqcNii
	UKor79nu1jG5pi7B5+J7TGfHJDJ5jWv2KxxiA+p3NRDFi
X-Google-Smtp-Source: AGHT+IE8TjM82ov8xrxnZMK/gXEPncLjzJMtiR+2bILyr0672r34V2+xjWe2oOQ5Pcx9lnrmFBdBDA==
X-Received: by 2002:a05:622a:1893:b0:4de:515e:61f2 with SMTP id d75a77b69052e-4de515e792amr151619881cf.83.1759211443594;
        Mon, 29 Sep 2025 22:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:263c::3cf:53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b5f64sm971990985a.32.2025.09.29.22.50.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:50:43 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Tue, 30 Sep 2025 13:50:16 +0800
Message-ID: <20250930055017.67610-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930055017.67610-1-jjm2473@gmail.com>
References: <20250930055017.67610-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0


