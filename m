Return-Path: <linux-kernel+bounces-793193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F4B3D01E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E4D17E469
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446CB25C6FF;
	Sat, 30 Aug 2025 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEFOyiPH"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55C2594BD;
	Sat, 30 Aug 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756594326; cv=none; b=Xwt6JzK1f9t9pmYMMegS9YJAOmHb2G9GACDVKy0jwwMVgYL2aBg6oRcrT7WQOTXUnokp1BdKcReB1Qru1XJJF3mpsN5xhMQmpo3aS9zYjbvBq8rFaC+ZLmF9byXEwbStaUMO93uNz367m9XCw+lhbb+tusNhrhOkDPzoEyVbKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756594326; c=relaxed/simple;
	bh=oaJar5oIwqYM3zgwnEEbQ2AyDNuoVXa9JWl+vkJ/R6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7fiAp1HdmWSI5HMRqK26Hx5C8Hw7SFe5alfpIaVEV/nqTRIvweqOoZBgaAjP1SAjSSf0DMJsNZ2cdvEDoZlGU1plExOCRy2HCmXb8k8ncyiOYGGriuxbLlL7r1buBy6PtWtrexQISB2ZBUG83t7MiHfroqr88SRvi2zxcvatlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEFOyiPH; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b1099192b0so62123261cf.0;
        Sat, 30 Aug 2025 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756594324; x=1757199124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrZ1qN3DYmU2M5pGPX1QKTcsDyaZXEbX9yPyZzRw9Ug=;
        b=JEFOyiPHEtRzGZqD38qhBYGxMfWknk/27s3LGyBB4ugr/jyvuDd6NQXTcBtWlWTPrv
         yBzNBcwIS2AR4pkeMWDoLi2Ex3gyO3tGCYXUYMF0oLCIx5VaXqgS5azgFa5YjnPLym9M
         3yaveQCvpvrIpnkBjWpWMlq8jQvraJGSePY57knQs/wepL9utnPlUl9uBWwUVe0HMFXQ
         zzC27JMNMDpJ90ZY3Gc6vAY9joqFarzryFb0F3QbGrnBVRXezyOYelsVySQTL8JhgRYd
         LyiI8rBRB9V9z8239+Adb23pBzFR1I242MfSMZBVVYDFLjxB+9Yac6EjZvLl0mwUDooT
         8SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756594324; x=1757199124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrZ1qN3DYmU2M5pGPX1QKTcsDyaZXEbX9yPyZzRw9Ug=;
        b=FDhZ4DGyEAx+R9980bVYu4PL/oiY82GUUKGVyBbJEtHAaMGYy0pPaVK0sx8hGJiIOl
         gTNa8NOlK7rBhJbPHAy7ubNcowjRPGscrRSCdmaa4AtolRMTc2lpL4b6Ckl9fLt1QwHu
         1rQJi5zi/jMaVfCuQFvZnVBRSiBlRiCqUXLOJNdmtb/BKDXAOpdkriOXeappp63wB7Dp
         Kry8zpBxosLKCPnOH86/hEhjzlSZA6pSxDxH4aTZs1Xpz124IKgI4055VYplREHtMZYQ
         FGHMneSZ9sOwy2V1WO4Era2s0zQ6WpyNpXjHtgknRIlM4hsB9+IaZLw5Cin0OZV1oG7u
         vNFw==
X-Forwarded-Encrypted: i=1; AJvYcCWYz+NZRGTama6ivaYTZ52VAcVH37b9NeNe2EiUdbMjVXT7RsN5dxmQD6p5fY47EEfm3I36YPj3WWsB@vger.kernel.org, AJvYcCXBASRxpciXUuAVWDsYenEJ6F8gcUWMDtszphB0YwhcBi8Kr0NtwQBEe30QRbBfRY0Yf5oLb+jSetIVLyIP@vger.kernel.org
X-Gm-Message-State: AOJu0YyCvQH7CCHiTio4DPLOX4PLECa0HXFY5Y+GzwG9NbZkIZ/o1mDt
	c5trdKgzQCqthQ4GvwcyHrJEjLgJzmpMuqt64L8weXxtEim4j+c0Bmw=
X-Gm-Gg: ASbGncsWaEUfQaqC9AVPkZmEKCk3Dfntz2dmDCQt2xTR8ZAb7d9kYY6rZtYAVJZt0Ns
	VDHmohOwWqv7po9vNC4uPifk4ICA7gMDNds7vxSuSId8wzL6H3hy4MZdjPsoDHyyv7aoX2Ln9F3
	C1U5ikR6ujJjQAMZxdwpm1FN3fleFpXTHCVip7D/FxnGaFb4wCtE0bP95NJm8ZSTWvsKe8Ud1hb
	EJrGup1F7UXhF1vhIjG677RPdY51SyZ/7eLESa3ae/l0f0Zjl4yr6pU0pNKy7N5yHVlRv10sA7J
	6ebTDyOHdFmoWSLCe+LqWgAGgVbKaxKVDUIp58CYJRiYVng1/K9qHQveuZ4IQ7wP2O61h0P1y1p
	eTVhhSu0nGuDwj05FQ3T/NH0X+Ix4jbXZLoCpD4rJfoU80i61cJ7uC2vl
X-Google-Smtp-Source: AGHT+IHj1Y7mSbhB/V78RbLpZrF2ojqkt4iRIfegSDPVQpLKIbvDqEpOolWmEiXgivm+8z/ghRL4WQ==
X-Received: by 2002:a05:622a:2284:b0:4b1:103b:bb84 with SMTP id d75a77b69052e-4b31db67395mr34440651cf.62.1756594323672;
        Sat, 30 Aug 2025 15:52:03 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:68e:c28d:1818:9595:da56:53b9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b67894bsm38752341cf.33.2025.08.30.15.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 15:52:02 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: mcoquelin.stm32@gmail.com,
	robh@kernel.org
Cc: alexandre.torgue@foss.st.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: stm32: stm32mp151c-plyaqm: Use correct dai-format property
Date: Sun, 31 Aug 2025 00:51:15 +0200
Message-Id: <20250830225115.303663-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stm32-i2s binding inherits from the standard audio-graph-port
schema for its 'port' subnode, audio-graph-port requires the use
of the 'dai-format' property. The stm32mp151c-plyaqm dts file was
using the non-standard name 'format'.

Correct the property name to 'dai-format' to fix the dtbs_check
validation error.

Fixes: 9365fa46be358 ("ARM: dts: stm32: Add Plymovent AQM devicetree")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
index 39a3211c613..55fe916740d 100644
--- a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
+++ b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
@@ -239,7 +239,7 @@ &i2s1 {
 
 	i2s1_port: port {
 		i2s1_endpoint: endpoint {
-			format = "i2s";
+			dai-format = "i2s";
 			mclk-fs = <256>;
 			remote-endpoint = <&codec_endpoint>;
 		};
-- 
2.39.5


