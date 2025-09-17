Return-Path: <linux-kernel+bounces-820521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81139B7D448
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E363B1658A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845029BD88;
	Wed, 17 Sep 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="ZtzQoxrb"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954645C14
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106884; cv=none; b=rfWP2vWXQ7GlR/qxi7v/XkcNfly64cAFB+n1qqPBULV5V/F+aYGyDUdLi8dJUIxi3A0lc9VTqt0eQSMFXlxB4EIr6T36+Lx3WLbFZUDPdAqLjSUazaoLulaIKs9sAZpI90l54oBDZeun7g3oPAsXUVYlPyb6ackPY899N53ig2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106884; c=relaxed/simple;
	bh=DXe+3PYozcWXl57aBr5WezaAMdVFPw3kN1QoS1BjuR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FF+73HBW8QTuPAkjIQWaPZvPQudizmXp8RNFvU0uM/x/t3u5UBYiaM8pq/lYUpKePbrfT/LJLk6LdsQ68qB6AOJE+V32Bol3PDvtkYzGNFSQ18k3QG42A2KQ1HEXVFqnNW+Oxus3hBiH7hsIwNFWkBlMdTR9/pFo0yzxl6kK+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=ZtzQoxrb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244582738b5so54814865ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758106881; x=1758711681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMQsS7dEiEcn1XR+6VViCf5cMvlHhDrANmtU1f3oLC4=;
        b=ZtzQoxrbB/VnwBnWRvWG3K85BKlJGdwoNTM1+O0esT1jio4TWqZWs+yKdSV5yMouXY
         y1S4YXcJsNMzqwiiIiD0G+50MiAYCiSl3/Av13EyBpbjWczenQpABZMWeu4vcY44lryr
         d6s/5/3i9ZHFAcv2KqIXXkP5CUHMqv/XqGRrMwIcnNVNaSh8JSkJN/Zvx2XVEidroZM/
         Moiz9Zovqw1b2GeKTVrUibHz6Tti21WnzIcvAZmKevieerpgiV5eCa0ysqrOhySuMiwi
         qzNIQQ5yNBDImOHRWYxR3Fe7XKiTeA13YiG+F/m3f9o4YQFh9uBu9Q/AaCDztmdMRFzY
         6Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106881; x=1758711681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMQsS7dEiEcn1XR+6VViCf5cMvlHhDrANmtU1f3oLC4=;
        b=JGqpFEQrPY8BkzA5BsicHIlHvNav2jap/pumJzblMJV2J2Gzwp5q6emxJixe48wGZb
         o5NDjv8wrawh8EpFxZfnirUFRcpH/VlfzGuZmY9NHieVnfjblKHIsm0wCx1Xh0kkHeVE
         VdpfgZPIqrKfBX3dYq3YOEjxz4V2D8LiyrDr1P0nhB1kp3imotocrOJMtxC6RaW3shI9
         O5S+VGN6hYdsniuAm1fqAAKYkCszRom9IZFxvLxF1sxXhghhQcVR9mUD2R2G5MknNjWJ
         7B7BtAPh6qTRDniOwW+PdqGCRH+8tgHlsL63d9QSDBQZu49UB2rDcHZh7ZDHU9uXqY2A
         LK8g==
X-Forwarded-Encrypted: i=1; AJvYcCVvnTUZcUQm/EcFggEefHw1dYVALJc3pOlMB1hpKBLPtKI5gNrqt6MzERWKZofTPMrhFnB+rojMI4rl8c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+8BJDuZBp9uEyLkESC6gO3YhDuOexCNKOmyDTR3tCacLozyz
	kAdTGyn7UfftJBa2QbfRrCbMWvkB+Ew5Qt4tYZxoyEd/TM0Ri4+6C5a4vYOlvTRprxc=
X-Gm-Gg: ASbGncvNOBykeDHtvKoUBIdNrgikNrOblsCjMu1b+ysIE1ZJob/X5iruBSIPxBlq1pm
	wQanD6cVfH8wNlFgVrCrE3ZD2GkfAuNSBBlr1W3n3HncWXui0f3qOFK99nqOk8n6Qc340etf0Wt
	wm8l5Ry+yfqFxql3DrcEzO7o5uBqLw6S8YJT93uwzihtgdmzNxCi0S3Ab6PVKHruUKPUtx2WQKT
	cp6V5GUysm0HisYtpDO8OVvb+C8kn22mOe//QGKYSXju2bbjZTr/A9JRcDVxpEjeShDAZnpmh+v
	BfQnbhtyq3JMW4sNLoeZWIoP4w/LIZ2NLM0gmq/M+j+o/vrCt4Im4hekZmh1IZA7vz7pGQ9AJ4j
	FPUDD1FcKTe2NKrUQm9pmmm1l5ZKK9yVnVEkpMywxp5E2dwTiUW/LR+rn
X-Google-Smtp-Source: AGHT+IFzHlVzYa/q3MnbGUKmGNaxoTqhiBZhkinwoVOAqXMfYX6776FYQwngWLp/NNcoxyCfaQZaUA==
X-Received: by 2002:a17:902:d4c9:b0:246:eb4d:80c8 with SMTP id d9443c01a7336-268137fd08fmr17646195ad.34.1758106880901;
        Wed, 17 Sep 2025 04:01:20 -0700 (PDT)
Received: from fedora (cpezg-94-253-146-122-cbl.xnet.hr. [94.253.146.122])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-265819a6212sm94231445ad.57.2025.09.17.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:01:20 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: ethernet: microchip: sparx5: make it selectable for ARCH_LAN969X
Date: Wed, 17 Sep 2025 13:00:24 +0200
Message-ID: <20250917110106.55219-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x switchdev support depends on the SparX-5 core,so make it selectable
for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/ethernet/microchip/sparx5/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
index 35e1c0cf345e..a4d6706590d2 100644
--- a/drivers/net/ethernet/microchip/sparx5/Kconfig
+++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
@@ -3,7 +3,7 @@ config SPARX5_SWITCH
 	depends on NET_SWITCHDEV
 	depends on HAS_IOMEM
 	depends on OF
-	depends on ARCH_SPARX5 || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on BRIDGE || BRIDGE=n
 	select PHYLINK
-- 
2.51.0


