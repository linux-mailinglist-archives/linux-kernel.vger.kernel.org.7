Return-Path: <linux-kernel+bounces-745361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB55EB118E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859C117D378
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFCC291C09;
	Fri, 25 Jul 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZuCrkQT4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="V7u/p1g/"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12A293C79
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427295; cv=none; b=Gx8gXRMw7HgaLFf3+o09XWicT2ai48kDsr2ka0MPvkh6J+e5F/5wcfenPaP/lXBC6M/2VWRrA5DlBRM3hCxOvuuGeaFkqc4hC0+MnukCl/LB1Hm7hNYQuxOvLZhtDCWVMEhfgq+4LoIgslUIsFYYszJCECvtJs2440BjDZVZs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427295; c=relaxed/simple;
	bh=1XFJFqJCH3X7J8t9nRMVvrEF8hZUnn/cpMtZ8ui/Q3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eh/iDv2++2N7EdX0WeqTIk157tEn/om0Z8R9PKEJ0wXEXe8bh5Jn/6CtjmdP8AUwByZdsxDW9p3FGgxzFUXXpDEyx3pbjvb8spPijXUsMoT4oIB2l1p8oVTS0B/VDTzPE7dpYdB1GGEv8A7nDO7b/M5ouiBOh6UCj3xKhlDby4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZuCrkQT4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=V7u/p1g/ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427294; x=1784963294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6nuRxtELZntDjB9h69rDkTQPFgdfIrPnrFInhSdP8E=;
  b=ZuCrkQT4q44gp294U5Iday1Ox+P0YLMxep902McfLxCWSgLPD5hRqsjU
   kA32fd3qO69Ld9yDVN1ykER7Gc+mRyQ3S6yF5FftbykewJpqpDlbyR+gL
   /PWAVLmfqIVm8iwJz9caRUJ1T3ozI65MysgjTVxubHu2Dw4OwLtz0zRo5
   Q2GgmKI+rpoWICauOmsKF+3Cq1yY6Amsn3XtcUwHfp5hIDIwuO/eYA8WR
   JTxZODduz8cNd7wK3rMh6WEFrBkAiA2R4WcCA06bYp9+qGOHbuGZwmUWp
   kl7DxT9OYj2suisIO7ia8cgyZ6I01VA1DZGpoS6zbXG8z1GvwUjT6hQGQ
   g==;
X-CSE-ConnectionGUID: gHxpVgQ/SjC1lUFhmXG7vQ==
X-CSE-MsgGUID: GnFy7sS6SDuH0SIgq5Y/AQ==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414673"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:08:10 +0200
X-CheckPoint: {68832D5A-3-4FC15ADB-CD71293B}
X-MAIL-CPID: E5C49D879E08C065B2E90774F3BA4A44_0
X-Control-Analysis: str=0001.0A002121.68832D05.0045,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC9D41736DA;
	Fri, 25 Jul 2025 09:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6nuRxtELZntDjB9h69rDkTQPFgdfIrPnrFInhSdP8E=;
	b=V7u/p1g/N6DiURgk4wF4ZlDZs+EGZwvvq/6FM+Ys/prtGOGgRIujY0SQoo4LjmJhLlGZ5a
	0t8XZLY1HR+8uCGrwzTBVoPQZji/TASEuCLiURSk4SKt5RWZiYgsOdUe0z0BEAcRn0lQLc
	Pe93BaY67Rxh5Gz/c+MmDkiWrmFPhSRwRWJp1+bdhzbBnbH4hAfwiYLY6vgc/pr9wRNHQE
	eXADSWyzUb8BJ4VQoudX17idCUkOcUahbpRoDAAt+t+0IYonp7GYnACOjg8Fm/ctqt5+Zq
	YC483H/69EgGAuXgo4FWH7tfiLcsHDadwwp1arL4eVpQa8xOEfv/iDk6GBvNcQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mfd: stmpe-i2c: Use module_i2c_driver to remove boilerplate
Date: Fri, 25 Jul 2025 09:07:50 +0200
Message-ID: <20250725070752.338376-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
References: <20250725070752.338376-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Driver implements feature of module_i2c_driver() manually. Replace it by
that macro instead.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mfd/stmpe-i2c.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index fe018bedab983..145836320c170 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -122,18 +122,7 @@ static struct i2c_driver stmpe_i2c_driver = {
 	.remove		= stmpe_i2c_remove,
 	.id_table	= stmpe_i2c_id,
 };
-
-static int __init stmpe_init(void)
-{
-	return i2c_add_driver(&stmpe_i2c_driver);
-}
-subsys_initcall(stmpe_init);
-
-static void __exit stmpe_exit(void)
-{
-	i2c_del_driver(&stmpe_i2c_driver);
-}
-module_exit(stmpe_exit);
+module_i2c_driver(stmpe_i2c_driver);
 
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
-- 
2.43.0


