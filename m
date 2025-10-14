Return-Path: <linux-kernel+bounces-853126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3353BDAB16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EC4EAF75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2B303CA3;
	Tue, 14 Oct 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3XnP5N6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87477226863
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460526; cv=none; b=Bq0t1w7L3hHENOHjf7GyrMaaeWHtKJcOH/yNqewE+2QN+enkSJt9oWek6EO9RqSfJKL9UKfPr6VZj4eoFszuUodZGEZLV5jIS/BMsQ79La89G9o0FR3ObmYdPUyiPIxDp4hwU8FaQsVXWVd/pA5ONWSh/K4by8Za6TGE1x2krDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460526; c=relaxed/simple;
	bh=y7SyNQdwhQ8j6s4dApzQSF09n017FvNnaQK3OZiKMnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjxPq6samgMSqq4z0cupF7JhFM+7ti0u7xLejyZyy6LRihk4lhAvaxZvNk+rtnHLlFa/SGsuM/siJlm/r52ZXn9PHCVE3JVeDorzG/cqCJLwcmrEIPMwYdMKG0KXw/HrCm60GyTyd6BsH4d8ypuCixnb9eAX0xq6VT6JTyhHTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3XnP5N6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-367874aeeacso56997011fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760460523; x=1761065323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9Qi/kb9RGo1YDHbWBhpvncWw8E3KoMeCrZ3P00Tm2I=;
        b=M3XnP5N6IrE5DG1EkAi2YhHfIUveW9U3cYHY0HgeVyh9B+MKO7In9LpJqhEibs2RwI
         O1R30bkjgaVvoc21S7PL7PpI/4W9xfCzzTBJqKjfepyBGR+DrfYsh3hkP/8pstP3iCHz
         wTWP/msYnVXYM9b1eU0wAuAM42yqCSONKVgh233ol5rfS3lcqx4JmFR6Sz0bD8F8P7na
         oVqZOceR5/rf3CttbtBb6AlZfAgi+wZEFlMKVpzBCBNgb1RGCY4VAcd6YBWXv+gh3CnY
         7eTqJIdJIU+RHgBIYGGyfGvYwRoZsMbv0Pxw9GjJ7CACsskOzxN/UO3geyFSHejLty+q
         lucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460523; x=1761065323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9Qi/kb9RGo1YDHbWBhpvncWw8E3KoMeCrZ3P00Tm2I=;
        b=TlJaBx6Awp67M/XwXPEV34zgZq1gj4ROSHLAeQM+OzqZwt7YhJdhfa8r2/JUvu/w81
         wiy2M+FtI3DOs+ItI/tTscwQHsY2vgRlpJy+8EJiWSn+7JvIxQPVl9ElCIapduB9iio1
         8tw0aid11QN3+dfYPgrb4y96wR3opsM2zkKgmRKhZB9eWda195kwmoHdbFnx8pYmoiqD
         eQ2enN0Z/f83Ezew6L5wyKCTa/d37/RSwcjTrQplFPbCEHrvW74+Ul0Vome6ygS0Lxk3
         AOepU3QOJ4HeXo6BCQtZeMlT+medzd55VbjhXNP8UJZEKtmAt8Q8fEtwy0q212xZBVR3
         WYXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzdhRZSanlW3bNa4EPrQr45ihchNLyeOTc3wB28sJiEwBUA6lQWUHo06ZVM+iE89reQLIYAr1p2HxyGk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszqEwomSAiEHV+0orm4Z7yKTaY+JfNDHANJ0xkCPRixOoQRJi
	gJ1X+RyjcBOkPWP1snPrlF4A4zHR+Gj1XarHb4YhxX46BII43Xxtb90n
X-Gm-Gg: ASbGncs1t8RWcGHL5TyinlqM7Ge8/iiQyKVQhVO4fo+exLTr+442KxthKzbPR6aXvbo
	JrRXlB32EVpgb6bSG+Xq3EZ9dtXpO5a5DcFu1jl37h9y3LP4tRmuZOGwHBnMKHr/OngyN4p7Pqt
	vdAwJpzl8Ftrs/BdeLhhb7Tcx/Peb/8TF2Tqadj1BrCqx5mDmOTNMj8InHPdb5D7JJD5y8r9/Qh
	U5O38lMypHQYeCh4TvVMj7uYO6Ui4cmPfJ4Qd3BrLzP24JsjXPhXCqaNA563LmmSiONFYgqPdjC
	zrA/3tdgQSPBWEa1iSXhU74L3VJw0qh721IBiHQa0eHwkFJkrJhyYyCWBUNzAwUj269QJqCiK6B
	6aRHTtgX5vKY7AkPzSpawOp65alq7KPYTJ6u9U7pI9lwroI0=
X-Google-Smtp-Source: AGHT+IEleG+I58OJH4rnMOXqyKjnNiR2vRFF7DYCaSq9NCZzQPNYtrggccOr/9rYwOrDtGQdKjfMAw==
X-Received: by 2002:a05:651c:158e:b0:36a:cdb0:c1e1 with SMTP id 38308e7fff4ca-37609db8da4mr59632741fa.19.1760460522383;
        Tue, 14 Oct 2025 09:48:42 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762eb6a963sm40563481fa.57.2025.10.14.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:48:41 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nithin Nayak Sujir <nsujir@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexandr Sapozhnikov <alsp705@gmail.com>
Subject: [PATCH net v2] tg3: prevent use of uninitialized remote_adv and local_adv variables
Date: Tue, 14 Oct 2025 19:47:38 +0300
Message-Id: <20251014164736.5890-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some execution paths that jump to the fiber_setup_done label
could leave the remote_adv and local_adv variables uninitialized
and then use it.

Initialize this variables at the point of definition to avoid this.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 85730a631f0c ("tg3: Add SGMII phy support for 5719/5718 serdes")
Co-developed-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - remove bogus lines with initialization of variables in function,
since its initialized at definition point now.

link to v1: https://lore.kernel.org/netdev/20251002091224.11-1-alsp705@gmail.com/

 drivers/net/ethernet/broadcom/tg3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 7f00ec7fd7b9..d78cafdb2094 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -5803,7 +5803,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 	u32 current_speed = SPEED_UNKNOWN;
 	u8 current_duplex = DUPLEX_UNKNOWN;
 	bool current_link_up = false;
-	u32 local_adv, remote_adv, sgsr;
+	u32 local_adv = 0, remote_adv = 0, sgsr;
 
 	if ((tg3_asic_rev(tp) == ASIC_REV_5719 ||
 	     tg3_asic_rev(tp) == ASIC_REV_5720) &&
@@ -5944,9 +5944,6 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, bool force_reset)
 		else
 			current_duplex = DUPLEX_HALF;
 
-		local_adv = 0;
-		remote_adv = 0;
-
 		if (bmcr & BMCR_ANENABLE) {
 			u32 common;
 
-- 
2.34.1

