Return-Path: <linux-kernel+bounces-769384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465D4B26DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DCD1892F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4030BF41;
	Thu, 14 Aug 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwTp7nYJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263530102D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192229; cv=none; b=WmjdWDseH6Lwumj1lz1magw6x71NfKdys0yHoDv/kEzFwtq7N511MIauzel/NFo8tsioJCXT5+TjBEXgYriu1b6bUVGkCSy5jhKy0ulZVWjb1gI2pPO5Q5ys39J6gHepAc4lOuRJur+ujldJ42nI7cy8UUQzhcBHne3eeN4nzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192229; c=relaxed/simple;
	bh=U6WsfbV8ePMllaRZ+Smh/4X6uCfRaZQpb9Y2ISJylwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qav/fdHEPp9Q/yB92uDlxQsE/TthlqtbhEkw5Vu5JY5XYFuayKFVIXWHUlF1O01HWccMIL5FslCtTDqjyr9nKg1r2Zf0X4vGZr0jDyfdYLBcWTVyHZKxp5fj0Zv3Mge3el43mAHcdQ+qwLZUAL62rKP5L8dcsOjEslQQ/4KuHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwTp7nYJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e38a6b92aso495674b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192227; x=1755797027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUuwnMr5cJFdw3kMTCufuIrt59uK2KJmVhi6WoAhRaU=;
        b=fwTp7nYJAxUmO5/PAAMDuQ6Cn+20qKUWQVlB1NSk+jWDnlwIdHlqF2UylZZY3s18D7
         5qZvBCJklQ0PofG0PDZLfPm5ovium0rzg5A5fmgkLJKPbJPtXF4Yfucz78hXYQjBu7DB
         DeyzESkyLn0KxBpjvUAB8lwUGTFfwO4rg/d3wgV0QGXcDs+DmdqpX5QbpBqpj2emdHRb
         PgANIH47ouwCg4mN2QRsOEmaKQsuBEffzGUbWK06/ulcSOShtxPV8iZb1EdG0FtOPiWG
         6UH+2HzfKpCY7OYFfez/uj8NQp40Pe8az38A1NRo9yEfuwKkfQCuu5u/rgq6cpZsT65Y
         NZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192227; x=1755797027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUuwnMr5cJFdw3kMTCufuIrt59uK2KJmVhi6WoAhRaU=;
        b=KS/8GncZrH0W3pbXpCilMDEkovBf4GFWcWIJJyx2b18jLbkB6qJ9IWW9CrGRpMf/IU
         VfQnX3tD9nDxRrFArHlVT44LeaomviPtyoFBrbwbfPM3fEqe0OcS7aN04yvRAjRWC1ub
         b6+333hs7E1UpuzlQsuDlZZx3Rcvml3jmB/Acs6E1BeHTOf2zOi3nXjFATtY6wtZ8h+s
         JOqYeW48avPof8weF6GAcjR7ZPJQervz4CRhk18/VpYj6qR51SuUfS+ooKIrqw/LybRY
         ql+4SMLdxXEKl8+1IuhdW4B7psoYqFremGk7GqophK0hXdjJB4gwZpb+f5HfrB6wp2Vk
         eePw==
X-Forwarded-Encrypted: i=1; AJvYcCVciBb979OK7N+u6XAjVQeUFb6keBxvrOGYfGviPNQ5LUuDNx4I1EYeHk1EDBalukHLWb/Qwe9T0lrmawQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0osEmdnO41enspO6FRvAnlLrLUB5y2SjI6fGK6gaNiyOUV+wn
	7yuiEYNJ1iAx+URWSaYXtH1A9DBfCs81sNFtOqMGz3V17LAaWgmz+yOUZ9O1QPvKamA=
X-Gm-Gg: ASbGncuwRZlrYaOkztvucgL6Yo0tNUxa9yF2Suo6mkl1tN1DcONl02P4nc18N57z6N8
	27CuzciqP0QvlmXTfR9DHSKK5PPjQxgAFh+KvD07PhJq6m4GTpMwZWrSoBfc1stV4FRtQ0v/MlU
	V9AGv7bTqiIXLPY9w4sR+gd3HNKiBt8eEODsnPv5QYkAylvnDAPUJyGDR/n3xvNnjqrlGUmBG4u
	053CuFw2OVux6L+8YEhxchJLBNPhEDmjBDv2GEOgFUxppybjOXbyQItXJ1+Ur6vze3aDFFxszgh
	6JQV8EPd/bIgh2yXKNCiiXdQweHef0Um4tHbTC6+1Z+EQE9QfBlBNoy6R25dlNBZTu4BcgQagFT
	5gs7RKoLPhuW3kNUE+Yx0z2Hoyud10pmyrU5utzcxPpE2NDvkb2A4xCh71wZdCw==
X-Google-Smtp-Source: AGHT+IGpe2mqIirqe/7OBFih53vw0yZWYFPlVdAHH7MK/NVq5p3Qz6zelUDEaxyhRQRCyJOqO9Ebdg==
X-Received: by 2002:a05:6a20:7347:b0:235:7452:5859 with SMTP id adf61e73a8af0-240bd2523b4mr5611675637.30.1755192227344;
        Thu, 14 Aug 2025 10:23:47 -0700 (PDT)
Received: from localhost.localdomain (66-175-223-235.ip.linodeusercontent.com. [66.175.223.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4289c5e123sm17825759a12.3.2025.08.14.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:23:47 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	ason Wang <jasowang@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Andrew Lunn --cc=netdev @ vger . kernel . org" <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net: tun: fix strscpy call with missing size argument
Date: Fri, 15 Aug 2025 01:23:00 +0800
Message-ID: <20250814172300.57458-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tun_set_iff() and tun_get_iff() functions call strscpy()
with only two arguments, omitting the destination buffer size.

This patch corrects these calls by providing the required size
argument using the IFNAMSIZ macro. This ensures the code adheres
to the function's documented contract and improves its overall
robustness and clarity.

Fixes: a57384110dc6 ("tun: replace strcpy with strscpy for ifr_name")
Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 86a9e927d0ff..88c440c99542 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2823,13 +2823,13 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	if (netif_running(tun->dev))
 		netif_tx_wake_all_queues(tun->dev);
 
-	strscpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
 	return 0;
 }
 
 static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
 {
-	strscpy(ifr->ifr_name, tun->dev->name);
+	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
 
 	ifr->ifr_flags = tun_flags(tun);
 
-- 
2.47.3


