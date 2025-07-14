Return-Path: <linux-kernel+bounces-730111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F5B0405B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3D83A5094
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9721F462D;
	Mon, 14 Jul 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=viard.dev header.i=@viard.dev header.b="qa0XMd+r"
Received: from geovh.egeo.net.eu.org (geovh.egeo.net.eu.org [37.187.0.189])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111818F7D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.0.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500458; cv=none; b=cyINmz6OfFND3MaNsXdRbYAT50lOIAzHQ0aedv4sYXjMp/4EmtB2/hTGAFmfDmA1G32fhg6Ru4828uDv9vMUFCbk1/vTRbaSXiDW1k09xm+ruEV5sI3lTBlYsrfZcKmIkW56Cpq8mbs7JtGB3CEICKphy149V+BElocVYIsIP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500458; c=relaxed/simple;
	bh=Av4sZlAnaXxNH+OG5H4W3D7HSIb+S9k6Olf8ZLnd3JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgMsx5zlAMNLggo8y8x+T1rSa/05mp1zMymZQ8qIs6rkFleayKWrgLTZsbhRZuzmPcFqSO5zIYyyGV5tiUzZmpsHkHKidmJ9/jvjnXnxkGaVWm3I31kJWd6h7Sm1q4do92s9/grVNaWfJ4c7fGUXX+eRqpR2qIgy1KalwdI5ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viard.dev; spf=pass smtp.mailfrom=viard.dev; dkim=pass (2048-bit key) header.d=viard.dev header.i=@viard.dev header.b=qa0XMd+r; arc=none smtp.client-ip=37.187.0.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=viard.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viard.dev
DKIM-Filter: OpenDKIM Filter v2.11.0 geovh.egeo.net.eu.org CCB598006B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=viard.dev; s=201812;
	t=1752499988; bh=Av4sZlAnaXxNH+OG5H4W3D7HSIb+S9k6Olf8ZLnd3JQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qa0XMd+rgnvSKSyhF6cVM2/2pESa6YV3QWT231wU1BZlJOa+pLCXGfFZlkmQFQrtm
	 bHbnaUD7w/3i1DWDdC0vqGTX9dok2x4UdDDB1uE10QnkhEa6C6TyJWd7U97bqYzh36
	 vorRyrUf11k59VfLBCP4DDedqf3881bjLg5kWtxj6CpV8lGaoAo63/KzJVSRudA5mr
	 /WgH/KvYzgn5v3mehE6Yu2OBgNPbG3aXLb5TS4qFLyLv46ifq/eXtOv/kkY5USYmZT
	 H4QoZeuVY2k4xAuTNZodSJQFetaM9Xx0V696K+LTEEu+/AKcSL84kSojHuSP2KcFnj
	 rkxi1zts5uAdg==
Received: from slimgeo (unknown [IPv6:2a00:5881:3041:2700:399c:b271:5bcd:1c08])
	by geovh.egeo.net.eu.org (Postfix) with ESMTPSA id CCB598006B;
	Mon, 14 Jul 2025 13:33:07 +0000 (UTC)
From: Alexandre Viard <xela@viard.dev>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Alexandre Viard <xela@viard.dev>
Subject: [PATCH] staging: rtl8723bs: os_dep: remove whitespace after cast.
Date: Mon, 14 Jul 2025 15:32:30 +0200
Message-ID: <20250714133238.67997-1-xela@viard.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch error "CHECK: No space is necessary after a cast"
in sdio_intf.c:292

Signed-off-by: Alexandre Viard <xela@viard.dev>
---

Hello, this is my first patch on the kernel, I appreciate any feedback, thanks!
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 5a7238e661ff..e735747f2000 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -289,7 +289,7 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	rtw_hal_chip_configure(padapter);
 
-	hal_btcoex_Initialize((void *) padapter);
+	hal_btcoex_Initialize((void *)padapter);
 
 	/* 3 6. read efuse/eeprom data */
 	rtw_hal_read_chip_info(padapter);
-- 
2.50.0


