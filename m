Return-Path: <linux-kernel+bounces-746967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465FB12DA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F8189FBDE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0E7DA6C;
	Sun, 27 Jul 2025 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fosLsunn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218B747F
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583569; cv=none; b=aCoUCdNvjrlX4KE18pGQPekoJZhTtuxO8mwCHMBXVynpDDDPMZfKzrd6bwX011nc7pO2niJ6zXm/VvIvpNVpG+zzKHHRtythb/le9g40QDaekkg9R4pkn2T7eXzzxTqCUNvtQ09mqLd1e4xi1dDxdMhk6Hkn+A2PUAf3Se8z+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583569; c=relaxed/simple;
	bh=X5y7c1IKPsm4moCxSttni6m6d8YlltQ99xARehRD93I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5R9ZaCByBniF7grVezUAesqawVWN4Kb7XqzOEabJuNFEtTzDTpVRCy2hO3TlhtKooKT+7S22/+8wl49f/GYxDTUob7ILfQqpUkKRwXt1RkEIunlC0xmuHo+YMXQpZkQIjc6A44CfaCxI0ACQaS6fcbII9x9SOcCyF+d1ok93EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fosLsunn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7494999de5cso2347736b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753583567; x=1754188367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSOkd4w5gQIxsELipnCdQF0Tep6sCk+dGbmt4qleqzI=;
        b=fosLsunnXYE1caMx/ckdEb07lY+Yfvw/7cmptR3xoAolOa+XnVj+y/Ewy+aGzKrtl9
         4ymUpvxnBKryY5WZTB/2m6crSt8IC4DYDtry5HqAOw9+Da1n9GirJlvc6oev5e0nenST
         TY9jm+EkokS+ht5u30Gg1XpBUE9C/x29AzP8aGINGyV0k+9UBGs90EjkcTq7+Ry1WxLG
         0Fq1iaO402GcVZWa9ln9prhSysG3hcHbZ085OwWKgexmEVDXw5hyhJfHtep/3RhY+UoY
         YUnR07M/NDL6jL1jARyaxyrnhFrG4Z35qn//Njn8SBIpGwnYEgUXMoH+s237SrBr/3Gy
         WzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753583567; x=1754188367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSOkd4w5gQIxsELipnCdQF0Tep6sCk+dGbmt4qleqzI=;
        b=X7drQLVq6uO7Or9m6Gupf+jd2Mkh1DxbxB2HxomFsVDWCJwuzcX6EYolpZFXEP/YM2
         dHqP+yiC0PrSzjNj2S/I5siFtXws0Sg8SbleFZStMuENoOXi6bH9NzXXCNm0O/bckk8P
         eO2ULY/3qjXKuffGSpyy+PlCw+MGNUmr8dW3QT8v59RlXIJbxZ5VNGItkeyACviVLjQ7
         InutDXR/ZUlU7k6QDJm0LWYxjSwHiRdQ0RfqKulZDN/2dgElbgzAaIY0TSO3CKuAmTBk
         4VBrBzr50YDjcfQ/EVwdLTp287xgM8K+144MYL51vnkqzhHlG6LfBWhQY1lVaof+2y2A
         KH4Q==
X-Gm-Message-State: AOJu0Yzi0GTTvlpEha7h+FJ0AzT7QX6X19/mzb62I+ikB0xtD0onpFqh
	CeR/jA7ZK6MS1fX0mn7y6weC1qEBCpt4uObfSj/dhCDyr4ISq1rEv3pg9PkvsYbW
X-Gm-Gg: ASbGncuBa6aOpb6Xdouj1H7blA2QFeHIZ/I++cShknCln71A8dml30mHoET8oL338cM
	KzSFUcBpY/sKQDUac1vce4eIpUQ/qG3terkVsm9cuDq6qylzvhwVPRkUApDhHIuuSGu/3WXcpah
	MBTA9L/R7JETzgwQwC46/t2C/AEuobAK8XaVPeDPgdkp56cHfg9Q2E/oqr6JGTvq5bUqPOGpfeD
	iQGR0qy9voFjvzhE8WQeVgTldFJH7roHZe0P+sQsNkTBSjzEiRDwgZtXeELJYMrGTCSB6B7AmB2
	MOftqGpss/f2bAhmp+ceH8RiOotlGQEKGnDQBVXxA+amSbTOF0p6zcjD+FSzSIPMppnQo/aKEWT
	EbV5Bm5MCfsgQSII/4piDCK7DJy4A5+RFHbl7q6HZ0RlZrF8ei1xb+oVnTYU24/xYiuY=
X-Google-Smtp-Source: AGHT+IHvk3Cw+YwT9w7OZhsik9EpVynM4JJiL+GsT5O4RQQ4LifOYxPmYV1vSbn4JBW6lfqsy8eZIA==
X-Received: by 2002:a05:6a00:2d21:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-7633626d7bfmr10166159b3a.5.1753583567219;
        Sat, 26 Jul 2025 19:32:47 -0700 (PDT)
Received: from fedora (181-162-135-125.baf.movistar.cl. [181.162.135.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7642db46f00sm2365031b3a.109.2025.07.26.19.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 19:32:46 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ignacio Pena <ignacio.pena87@gmail.com>
Subject: [PATCH] drivers/tty/serial: Fix typo 'incomming' -> 'incoming'
Date: Sat, 26 Jul 2025 22:32:51 -0400
Message-ID: <20250727023251.82850-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake.

No functional change.

Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
---
 drivers/tty/serial/serial-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 8004fc00f..2eb49bcc7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1096,7 +1096,7 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	 * EORD is different interrupt than RX_TIMEOUT - RX_TIMEOUT occurs when
 	 * the DATA is sitting in the FIFO and couldn't be transferred to the
 	 * DMA as the DMA size alignment (4 bytes) is not met. EORD will be
-	 * triggered when there is a pause of the incomming data stream for 4
+	 * triggered when there is a pause of the incoming data stream for 4
 	 * characters long.
 	 *
 	 * For pauses in the data which is not aligned to 4 bytes, we get
-- 
2.50.1


