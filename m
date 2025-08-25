Return-Path: <linux-kernel+bounces-784703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4718BB34006
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EFD1A83591
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDEF219319;
	Mon, 25 Aug 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Hgz/7Tvh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="oplpzs3E"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578A6BFCE;
	Mon, 25 Aug 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126173; cv=none; b=fSEkQctzw7IAK9TdrLPngX+nWkMI3SxqNqENXszP4bjZ4emAMECfWvxKn23Yq+0MU9seEI0qpJnzO1plbE4pdARJsMe+ACR2sQ6Gl+LWJZAybUBZDvR3lAaaA+RIHbFZFghqgs7Qzw21szjT11DGhd4lFBUlqcRb0m34TpOfEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126173; c=relaxed/simple;
	bh=IQKOOFlqFAtLTzqwcUqS5SNkGjI4OBb8Q9xA9VpRGko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0xu+N/v1iD0AGxNex7g7wXsIc7jDDkez//UQ7j91hxDQk188Rq3jweccr4IrWdirn8wMlNwyvCbFkDXOLuVlnmputrW8azMDw2dK0b/j2raIGWTDMc9Le8Gw4nZvopqCi1CG++o6nAu411MUBqXPKt8v1M+E1tGbNFcirZ/ON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Hgz/7Tvh; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=oplpzs3E reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756126168; x=1787662168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gaQtNdcQBw6TkuqQOMHaCaeCRNbn0y4lit9cmniz650=;
  b=Hgz/7TvhTs5V9IiLufYlzfL2GuzK3eKx3qjFz5tO1y+dKGesnN1HQlmy
   71HxxkPBk5IjbAs+mMtGyYd2jju/LyPog5brK6lb20HAQ2kTtEeUaLt12
   GBLEZPxml8UPISqj5XwNMzk5O3fV7czvsPNyXay9pZcJkWcK7QKQe4QYh
   EufLcobj0nN15+moy2qst/MHzk5nltnGcMm8jsQKj34uftGVpgkSTPPlV
   lxeIw3WVpxp0w0Rkogf6DUWFdHnBkBLiaxi7FEhItRTj5BNC2n7fIbgkP
   Kgjgg/fXIbBhl3RdB4+MwX3iwLsMuDjCCHeKIckENUbPBW4igQCYFWRof
   A==;
X-CSE-ConnectionGUID: pJelOCvFSz2XARN0aE7ROQ==
X-CSE-MsgGUID: 17NcARDYRgGqhtmNI6XchA==
X-IronPort-AV: E=Sophos;i="6.18,213,1751234400"; 
   d="scan'208";a="45893996"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:49:12 +0200
X-CheckPoint: {68AC5BC8-37-299FBAB0-EF52EDE7}
X-MAIL-CPID: 1C9800A739D44A8B67B14F2EC758D138_5
X-Control-Analysis: str=0001.0A002108.68AC5B6F.006B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 175AB166EEF;
	Mon, 25 Aug 2025 14:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756126148; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=gaQtNdcQBw6TkuqQOMHaCaeCRNbn0y4lit9cmniz650=;
	b=oplpzs3EqosJx63n/4EpCqhJ3g9eyh+vRg5k40QFy4vlKzYTwpTd1GLnbghXWouiPcWES7
	DmAsx0qWN+G8xxmrjCjcu+chwHC1bXiN2J7p/e77tPUMbz30Bq8AW3ZMk9PIS3oJONqpwa
	zlAt00ETMwAaBiM89dzF6eky82y+InLe2kVWQow4nhBoqAtTwaqiY2GFkcOY9B6o8X4BDE
	QVomUKGgdlnY1xA4arEKaUZk5WZp8PqRJY5nYgQAFg26B4xnPBh1qdbsl7n9emFLxnHycP
	DQHtz29h66hBKh7nEdtVU5MMxV+yYZJdOp3knS1lnS9Ov4BgZqP2tOQloF+ozw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] usb: musb: dsps: use platform_get_irq_byname_optional() for vbus IRQ
Date: Mon, 25 Aug 2025 14:49:00 +0200
Message-ID: <20250825124901.2190539-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

The vbus IRQ is optional, so no error message should be printed if it is
not available.

Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 12f587ab85117..a08ce96c08d3a 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -839,7 +839,7 @@ static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
 {
 	int error;
 
-	glue->vbus_irq = platform_get_irq_byname(pdev, "vbus");
+	glue->vbus_irq = platform_get_irq_byname_optional(pdev, "vbus");
 	if (glue->vbus_irq == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-- 
2.43.0


