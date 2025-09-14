Return-Path: <linux-kernel+bounces-815802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732EB56B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08D4188AC17
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C62DE202;
	Sun, 14 Sep 2025 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIwJXodn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C911199FB2
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874662; cv=none; b=aeUKot2Kls5yOQ1cP7FNNSVKHwEWVqD8bINbV6LGUwI68DObnKIMc3dGGIJUzJqZZt+eRuBe5yfH939ftkWo9m4IGTVvVZaasQ4kp2fm7sxm4tZGAwif68AtUIaUa8BMTIsR8THKw6VaUZe7e9goWQGlg6GNdKz34m7x//zqYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874662; c=relaxed/simple;
	bh=Uwjoc4sfboPE3RMtWZnJ0FopewFyBEbkr5T2274bxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aq9ooVHv5mjWiYTuBwhdebHlBj+CIMUQZt0/1RVslSuOqneXRb4jEY0dV0wD2beUYBy0iBWeWCouXiMszEcQ+1w2VR7DULBVKuBoyjCiod7lv2diMPnwJFc++t7X5NA7SeKgsgReqWxAKco162rmb/YmogqhBgoSyadjgj9iFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIwJXodn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26060bcc5c8so13411825ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874660; x=1758479460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7OkyHoQryuvQTvU/byTYmQXFC8TRTuccWQSN7suKqI=;
        b=AIwJXodnxWBQEg6vhtqfed3LvIrxHZRi72ujD3i/XM81xIj4d1bzgDA/YU0xg1ZjZb
         WVZ2l318ZwsyElErY/qypXDUHGOoVZmjHKpW2Rc9MNg7b+3PC7rESUDUvPpJNqcTyONC
         vBv4EnMoXKw3naSMC0q9ohoneXwkQTw+kRFFJ4GnH0UrZXxtk8HUSOR9Vuv3KbZ8vlOh
         yZ2kqEIQRyHiDDffuyn5vqvBm+bhrSHRLO8JcY4s/XJMjMAAWy4LSxgGSxMJ5xfoyCI5
         X2FcroZ14gfxN52ayEi15aWXJVd/8p0YE4PSJhUkCa0ZYqEdjTNATMMiuKs8WnfNsfyL
         tRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874660; x=1758479460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7OkyHoQryuvQTvU/byTYmQXFC8TRTuccWQSN7suKqI=;
        b=iiIQTZGtg3ikw0Aje4tDwUxsDYhaRGUvaBY3RkKul+VESow7oemUrA9YeIoud7TiuR
         VXisZ/TruX1Ke/qPbtpVWsXnKEI2k/fYZhmNQekqeOvN5bBTz6YSrUBlCXWek2d1BuYK
         FP2Jkfy7cW4qgYyU0OvksvcyXUQt3JDWROA4AF8iTflOCrzywsXGknuP25HerbW7rdut
         882mAxE2/aT6xVW0mZ/UIJrc+BVquWEvRDz2i0RSrfvyk5Knp9oKc5p77dVos2ZoQiir
         EhsrJU/XKkJXSgp/PmHdgl+i+O6ArRwYWqgH1ZkCbl2z2kSRghiIQfRcRJslFFe+xg+I
         PFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUviuQ76uxCfHfPId3Zz9KqQmVecuuyEr4lTD4Osj8OTqc/6dwMNjDIF7RIx7FkTa6tDaiwscoD7Ihd2b0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtjDWYLswZ41gU4a0GaNzPgsOBGL2YvguFfjvOCfp9hz4ATRL1
	M1IWY1JW+tHlAvNTyypcU1FWVljpyak9EY2Xcd5XcGct4OWMvDuTtGYS
X-Gm-Gg: ASbGncsv2fviHFmErUBcaNVL4+Avf9faQBQjzBV1CCNHNYHC9yMNiVpLifHgRmTEf9s
	d8o1gThF9JNfQh2zKCpWyT7ZgHiwuZoaOqwLkFGnaUvwFnWFeP/uwCuvDGK3jHHg+5Laf7AVrVu
	Fild4/IYzCkoia1bW/fDs3nA+5Q5BLDXdlyWCBgm35iSUAsaJgVGodaGRtRSyPlP8tBoeG4vNcn
	pYc+ohHlOcfi4smjDPrIWg3PyU5cxR8XiaPXjXTl4MCYMDX+efI9KpP+bVSSXj/4Nsl+2bVPu3U
	UsiMGyQVq4LGyOr97zYpQzR4exQevvufOxmquCegQJZ8S82bL1xyGQE/JnzqNNlayhdiYZOyzHu
	OAVfCcxs8kIT4LkYrjfiT5A7JXoKkQOSTF2kK5EsqRK1m8pmi76hjlg5GslOogejb6sQ=
X-Google-Smtp-Source: AGHT+IFiTY1M/iqKWna3+l676xlEG6ziqliQbShqS23NxA6fN6O/AmQSqKLL9218+IRckCYFCn+0oA==
X-Received: by 2002:a17:903:2346:b0:263:671e:397c with SMTP id d9443c01a7336-263671e3cc7mr50657935ad.5.1757874660216;
        Sun, 14 Sep 2025 11:31:00 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:30:59 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 0/2] net: dlink: handle copy_thresh allocation
Date: Mon, 15 Sep 2025 03:26:52 +0900
Message-ID: <20250914182653.3152-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches:

1. clean up whitespace around function calls to follow coding style.
(No functional change intended.)

2. Fix the memory handling issue with copybreak in the rx path.

Both patches have been tested on hardware.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
v2:
- split into two patches: whitespace cleanup and functional fix
---

Yeounsu Moon (2):
  net: dlink: fix whitespace around function call
  net: dlink: handle copy_thresh allocation failure

 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0


