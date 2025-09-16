Return-Path: <linux-kernel+bounces-818446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58179B591D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FCC16406C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C281C285C9E;
	Tue, 16 Sep 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HBQ4MuCH"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD01E47B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013987; cv=none; b=FaLlvRAauLWR1A7RWlGyeLmELPQ1bufu7cC29IotfVIznwz0Ql8Ai0FNffW1pifMN3PvkWBJ3IfrctVw4kcJSo5jqMVUub0udTUZj316zsTE/AYQZctNyDL4KEAH/OtzM1aGNHaQuxET/g6KaT6mEg96bchuHnZ0RY96DZ9p0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013987; c=relaxed/simple;
	bh=bkv+tJjo7XJN0MAP+Ja6gowNQtLlHpJVPlj9L5CX7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX3zNUbsZDTo539XfK1obUXPEJ7+yYtG45qqPww13Hsf6rZj9JcvXwI+pr72NrAUJuCW9mZi7YsoC41ImdWhQmUL1iQHY0BPgDLivAT28lFw27NpNYlbFx7Y/yNrrTQyheTCiiW55oIZFJHD9nCQ+qIMpG6tL4Y6XoXobyi7A4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HBQ4MuCH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0F43A4E408C8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:13:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D86716061E;
	Tue, 16 Sep 2025 09:13:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 576C5102F16A1;
	Tue, 16 Sep 2025 11:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758013980; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=0Dah1yQtnf/tnnK+SFWBAA57wMzVPD3ViO+H3LJ6Y8k=;
	b=HBQ4MuCHNOLPpzeT4qCb6GruhWtHmXBCqli/r9EAPdJtMsE410vum1MKQWOFFbuVwCcEDu
	770ZAx9fffv0/nohWBSAg8EEJzBUbJgdIC5q4bkBxseEUeORi3i/04mzFklWJ7Tf88Ag+K
	QGgGFtVci70Irk85Bi1m4yd+aBHS2BatyYTTmR1E6KzKm6+6haXsFhQICyzr5UR2ns2FMD
	S0oBZJJhe5ikEMku+cw/ee/dhSKwwTKJXd9Lk7iEQzQiAfi+mtyVzFBkyGwgrfE1tOXHHV
	wLzOA8l8gWCrktBTtURKLYiBLq27TGVmbdFrr6Gj3VNgyLe7z10bjrQDcOrwuA==
From: alexandre.belloni@bootlin.com
To: Jorge Marques <jorge.marques@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: adi: fix header location
Date: Tue, 16 Sep 2025 11:12:51 +0200
Message-ID: <20250916091252.39265-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The adi-axi-common header has been moved to the upper directory.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i3c/master/adi-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 162f9eed39aa..18597ba1f1c3 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -10,7 +10,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/fpga/adi-axi-common.h>
+#include <linux/adi-axi-common.h>
 #include <linux/i3c/master.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-- 
2.51.0


