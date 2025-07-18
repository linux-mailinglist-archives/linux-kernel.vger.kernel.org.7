Return-Path: <linux-kernel+bounces-736983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E65B0A655
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A76A87224
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A32E03E4;
	Fri, 18 Jul 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ZoHjNa8u";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rDew+xoa"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1A2DD5F0;
	Fri, 18 Jul 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848504; cv=none; b=SjTnIRbE6ESxOHAzspEuHyD4PvrZAx/sUVv3FqiDwNh/DKP2t2CUXWSNEhd8MJ71HPuQP+hl9EwFf9+ouPrzK31clWBu5xcCVY6IUPt3kvyWDrEk5M0R5VDxyGh+F/ZGXh+AppG/Dt+R3kSfwPAr71pjKplkG0ajQCOI7Koa4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848504; c=relaxed/simple;
	bh=P8mJGbBCa9KRO31+2BUNcwNUmqvqJRefNVwpQ/WC+rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fjmcJ3ETW+EpauwmOEZRYb/bJeAhwej2531S8lkUNPVrMBBKVeWJUOjCpvFQZZIGYbBoyaSxsERUTRs+tZJKIJXda2iiGWNKZCBmG+W1RdiaCa51GWA/cmYH591nt/h/NVrf1mr+I4wfaVNziSxX9VPWD58RDFARruflWUav93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=ZoHjNa8u; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rDew+xoa; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1752848493; bh=P8mJGbBCa9KRO31+2BUNcwNUmqvqJRefNVwpQ/WC+rU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZoHjNa8uKXfSBxNCAZzQoUEqe6XvWTjGIFjfeUm4Bkbdfydc7VzNVDYFzYvGbCpGm
	 WvlaqMr/13PHmwehYQWScymSxFYxVJzA2D6RfgEOTsD5jBQvlkh+M+7g22m9idqSZR
	 zno/7gcKdeKTnDKgmQnv3qZooUGZ0hkCO+y+XOnspLqBt3g8aiHCRHUzDk5m9Nms3+
	 Sgx7iCs9lfDIO4F1bipnkv68u/6oYO28+puW6at/AKsWtWe26TLaPUOVbVFrKsZxU+
	 ZSzG3f2GRifXwhCowfqdyBCI4EUyA8jls6wOj8lFkYtYr4uAEcriaKHGu5Zjkilf2Z
	 fVLj0LyUGohtg==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C530B1000D3; Fri, 18 Jul 2025 15:21:33 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1752848492; bh=P8mJGbBCa9KRO31+2BUNcwNUmqvqJRefNVwpQ/WC+rU=;
	h=From:To:Cc:Subject:Date:From;
	b=rDew+xoaqU+wrQ0YcEXZ597NksDv79w/g6i8/CPfPHtS8o1O2xHBTPucySMUWCnlz
	 7Ff5eVmJLN+5qI2SlcjMOEFVQ2x4TUdj4PvfnSLrAuRIJbqb7q4Imvcgagdv73EzEO
	 FkqHC/YlSu+7EFcxHfPBKx809ua3H7PADn/k4SEDuw5O4e3LntUPh2Zt88p03D7z/m
	 IsmWgkj8E/9SYUkvhwzB99MHigEjTT/7dUC2Z9hu2J5HnkyLV+CqxHhmD/PDO1/g41
	 QIzQsYcpu70QyLBMMwup1DOe+ZXzCN6XnFZV+BJkjBzyDcW5icbnfhA5/GjoCtdpuj
	 W4xtMb0oW0wYA==
Received: from bigcore.mess.org (bigcore.local [IPv6:2a02:8011:d000:212:18e9:4540:7989:d247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id DED081000AC;
	Fri, 18 Jul 2025 15:21:32 +0100 (BST)
From: Sean Young <sean@mess.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: imon: Remove unused defines
Date: Fri, 18 Jul 2025 15:21:22 +0100
Message-ID: <20250718142122.7572-1-sean@mess.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These defines were used for devices now supported by the imon_raw
driver.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/imon.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index f5221b0188081..f4366c8e44e32 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -39,11 +39,6 @@
 #define DISPLAY_MINOR_BASE	144
 #define DEVICE_NAME	"lcd%d"
 
-#define BUF_CHUNK_SIZE	8
-#define BUF_SIZE	128
-
-#define BIT_DURATION	250	/* each bit received is 250us */
-
 #define IMON_CLOCK_ENABLE_PACKETS	2
 
 /*** P R O T O T Y P E S ***/
-- 
2.50.1


