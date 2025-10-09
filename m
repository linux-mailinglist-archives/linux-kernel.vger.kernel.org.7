Return-Path: <linux-kernel+bounces-846536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F43BC847C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C38419E754A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3832C0F68;
	Thu,  9 Oct 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TbEVzy4L"
Received: from mx-relay02-hz2.antispameurope.com (mx-relay02-hz2.antispameurope.com [83.246.65.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA862D5C9E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001727; cv=pass; b=K43Z7uZpHLIUTSNAVx54/imltZUzmHcJFtlfmHauPa4VNBVwl8YcEhOLSzsyKILNWwR6ENafBcTfV9DOSBPrBYHNCy5msAv0G/uiJaLRtKgkRDjJckEfFNgM9blAjRa9JlFYXqhiFSV/X4L4CLdd1fdVPSvl7rmvYgS4nW05VFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001727; c=relaxed/simple;
	bh=XGkyybDNY1mb6KrENDxDb39fxVtd/EDG+xqpLeoMNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pfqN0rUGpXXweSP5O0Bne9RolGfHMSgsptTzZoka2oFOqe+vq2/b1eBOIxZenSMgWOjBXgoXG4OZUnuJu/8kRDJbQ0scPc2Fr2Ixe97qpjI68h3zfGIv460NyoQ93AVURuLITQUfuPhB/ccEkrbyUTTBsOrj6sjkYaknsky5MaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TbEVzy4L; arc=pass smtp.client-ip=83.246.65.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate02-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=V1zco+aUJaXBAcg9GM1X/IscW6w2wuvsTjlRMqGC/NI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760001652;
 b=LKEWEB7vRTPErrmSpaLAypJc7r7NheGi1X0j/o2ed5PoJIAKyrGODJRoXdxZq40U0quRALWA
 j9qEolU1zJkGZocsQLFD29Od7ffU2yu/qwJBNaap9hgvTP3qkKlYn5QvG+BSUaJ94axY13PWKXv
 EClVUIm+oj3zFAqksHJkMpxCqWFaX50sBEnK9p6DeeNHNgUI/URSFGereaXVcc52AwezC3yxc/g
 gA3BM+Lkps5UF/u8jmamly+V0WhkrRQxXqfdWWBXiCdmUz8628DAw7UqmWyzc0YJhDPwrdJ2mYg
 DeB8y0ZRtVQgoRUyFsr/VqDdlmvQWHIk1uA06BfwqSYtw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760001652;
 b=RaKgZWJJ2+j/Klj/xRuSlh5Zm/neLx6AlGtuMFMRgu08Qaia39UDAu4eQHtwBOYdYqhXTlP1
 SScLDn8N6/0bEZdV9ZxxZcEoiS9GV4Ux8GcmXkc4v0BFMsbm5+m0pf87ubnAvVo0o6UjG4F9E8g
 hoyVffPPr39JUdOqtgIekg5dYFSV0Q/n/Q69188EJR5WDleyq23tEM+fF6qTof9DiVyDmXJStLz
 VZECdkjKhUBnNv0Fz4PrOn+fJXj43BMn0KfDAJQj5T4rsvgqn6y5HSIaVPXXj0r8AQ7BFI34yJW
 3RSlo6QNDqnO0P1gwSBfSZGneko+TbXBYQB2jza+XFISw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay02-hz2.antispameurope.com;
 Thu, 09 Oct 2025 11:20:52 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id B3F5C220CF8;
	Thu,  9 Oct 2025 11:20:39 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/2] i2c: ocores: increase poll timeout to total transfer timeout
Date: Thu,  9 Oct 2025 11:19:49 +0200
Message-ID: <51a72ceca0154d7be85c3cc67722e7dd0b364a2e.1760000254.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz2.antispameurope.com with 4cj49N1cGlz2gY5Z
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:3b51b6f303a4b4124ce7a9c384325c99
X-cloud-security:scantime:2.538
DKIM-Signature: a=rsa-sha256;
 bh=V1zco+aUJaXBAcg9GM1X/IscW6w2wuvsTjlRMqGC/NI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760001651; v=1;
 b=TbEVzy4LjzYrulcuZ3+h03tfS0yophLaT5CNV9heDiydaokdl+wYpvAUdrbhUTpW6JJTfxzn
 uxLWeKk6RrkApsbDVm2eEWwxlqZihfdjLfYCUkearSjXLdEQW6h2sv6Zp3+Z7SHAaCIRg3TqDX3
 JLjiDZm3FZGBEJF4iiMNILqRhFQYuhO4GNEm+RW6OxM8Sg4MUkWsR1v33jFdgErEE/tQ8nLVum9
 Z7VFVHKMgGsqCesu0/v3tFf5HLL+i3InuRjuYrcwXHhGhiBhnD29FF8QRpnBefG1Jnak2D5mckr
 e452n37qvoRGSHIaLmQ9RpGj+tN8DdQwzfofqNo6y2YSw==

When a target makes use of clock stretching, a timeout of 1ms may not be
enough. One extreme example is the NXP PTN3460 eDP to LVDS bridge, which
takes ~320ms to send its ACK after a flash command has been
submitted.

The behavior in the regular case is unchanged, spinning for up to 1ms,
but the open-coded poll loop is replaced with read_poll_timeout_atomic()
as suggested by Andrew Lunn. In cases where 1ms is not sufficient,
read_poll_timeout() is used, allowing a total transfer time up to the
timeout set in struct i2c_adapter (defaulting to 1s, configurable through
the I2C_TIMEOUT ioctl).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: avoid spinning for a whole second, switch to
read_poll_timeout[_atomic]()

 drivers/i2c/busses/i2c-ocores.c | 44 ++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 482b37c8a1297..c4587194d46be 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/wait.h>
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/slab.h>
@@ -258,7 +259,7 @@ static void ocores_process_timeout(struct ocores_i2c *i2c)
  * @reg: register to query
  * @mask: bitmask to apply on register value
  * @val: expected result
- * @timeout: timeout in jiffies
+ * @timeout: absolute timeout in jiffies
  *
  * Timeout is necessary to avoid to stay here forever when the chip
  * does not answer correctly.
@@ -269,30 +270,32 @@ static int ocores_wait(struct ocores_i2c *i2c,
 		       int reg, u8 mask, u8 val,
 		       const unsigned long timeout)
 {
-	unsigned long j;
-
-	j = jiffies + timeout;
-	while (1) {
-		u8 status = oc_getreg(i2c, reg);
+	unsigned long max_wait;
+	u8 status;
+	int ret;
 
-		if ((status & mask) == val)
-			break;
+	/* In most cases the wait is short, so we spin for up to 1ms. */
+	ret = read_poll_timeout_atomic(oc_getreg, status,
+				       (status & mask) == val,
+					0, 1000, false, i2c, reg);
+	if (ret != -ETIMEDOUT)
+		return ret;
 
-		if (time_after(jiffies, j))
-			return -ETIMEDOUT;
-	}
-	return 0;
+	max_wait = jiffies_to_usecs(max(0L, timeout - jiffies)) + 1;
+	return read_poll_timeout(oc_getreg, status, (status & mask) == val,
+				 10000, max_wait, false, i2c, reg);
 }
 
 /**
  * ocores_poll_wait() - Wait until is possible to process some data
  * @i2c: ocores I2C device instance
+ * @timeout: absolute timeout in jiffies
  *
  * Used when the device is in polling mode (interrupts disabled).
  *
  * Return: 0 on success, -ETIMEDOUT on timeout
  */
-static int ocores_poll_wait(struct ocores_i2c *i2c)
+static int ocores_poll_wait(struct ocores_i2c *i2c, unsigned long timeout)
 {
 	u8 mask;
 	int err;
@@ -310,15 +313,11 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
 		udelay((8 * 1000) / i2c->bus_clock_khz);
 	}
 
-	/*
-	 * once we are here we expect to get the expected result immediately
-	 * so if after 1ms we timeout then something is broken.
-	 */
-	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));
+	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, timeout);
 	if (err)
-		dev_warn(i2c->adap.dev.parent,
-			 "%s: STATUS timeout, bit 0x%x did not clear in 1ms\n",
-			 __func__, mask);
+		dev_dbg(i2c->adap.dev.parent,
+			"%s: STATUS timeout, bit 0x%x did not clear\n",
+			__func__, mask);
 	return err;
 }
 
@@ -336,11 +335,12 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
  */
 static int ocores_process_polling(struct ocores_i2c *i2c)
 {
+	unsigned long timeout = jiffies + i2c->adap.timeout;
 	irqreturn_t ret;
 	int err = 0;
 
 	while (1) {
-		err = ocores_poll_wait(i2c);
+		err = ocores_poll_wait(i2c, timeout);
 		if (err)
 			break; /* timeout */
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


