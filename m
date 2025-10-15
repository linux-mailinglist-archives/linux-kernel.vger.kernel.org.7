Return-Path: <linux-kernel+bounces-854366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F8BDE2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 872CF35711C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB031D728;
	Wed, 15 Oct 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gUDPjp/V"
Received: from mx-relay159-hz1.antispameurope.com (mx-relay159-hz1.antispameurope.com [94.100.133.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351A31B813
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.198
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526308; cv=pass; b=FOiosmmu+7XDBhL70HlqUlXe7ORkTkmuR+ZCrMqptKGaeD1Jvym0UKH1nNOzh1VQgE0ZRMRwIJoh21pssNXFeVoQ859tk9LuWM2odSiP4frBU1U8RK+fHqT+Ddkcikk9biXQ26IVZnFEy5O68a+sH3DuECf07eJHwp+KXotYVkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526308; c=relaxed/simple;
	bh=Ex8BMT3ow9gM/Q+g7vsqnxriF2M6q3c9xdUbaU+Ee+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=su2V/3/CZkN3GcCMbH9vQBduFbaeR2DWA1/ouMVoRQLf3le8Os4SGRCgIWhueWC4ZSPnBFHiGzg22s44RNC7iIr+BpL4Elo/YIBWjNLmFdzK3SOUk8ZL36BAkeuQBGa3TbAfKbjn23tJyp6Zji2HKv/QLcc7h+QijKt6Ie8F/2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gUDPjp/V; arc=pass smtp.client-ip=94.100.133.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate159-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=1kk6xYtM9QKNb+MYQgCibH5JG8izX6pLn1C5uPaM1zo=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760526259;
 b=HfGAYgGv52UHtRSOpGRDkw8DqNCynHg+MdwSZmw1wOHUQioHLSrOe+fbQ893A+8lKylM3r34
 rhcPwzfVsOZX4V1oJPykVAH68c2ukMzOpw90WA7uxMBvAg4AmZHy6fcCZEEmhGIBt7RdpqBHMJX
 DbRZS0ACNi28N5IgzEN604Cz9bYpRgOk13/ycz5ljjmjx5KXTRLc4k+dal2JzEgnT93oB3PPHG8
 Ql2FMFIvulAv4I8+/+322YXnHZMPVPoYFVpNEo1Cv2gGqByaaNe88HqTpfCeNh3hGU94slMBrUO
 YVUopGvyUR7CTsVbcrNBGrPDlSSsHE062aegV1rwtuFhw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760526259;
 b=VVwbjKRk40f3QVm3YcvmB5dleOCZ8Xs8ORuYvgOmiP8FdalUFuA0rhwQjuaw17awZhRo8VHX
 sZACSyD6DGqxsn6G+m1XyxsWUeIZd5uN++6SMXbpnkGEN8NNGwCyD+cKvcRdpY5T58062dH1jYM
 l4IuUKxLpqgnWF84REATjrsF6sfHFuH5qtNGnY159QPuU4zmGpspS0YYq0/OXfUuTCtcGO3/kd6
 K/GZjAIKOWmGy6SebhcYUjsXGWUupwRMxZWEx3sEzJ9Avd5JI+l0xVmMyN5voqkhamT73ePSvyK
 SH3lnSX8axtkvGzK70T6LB7IVgvlokA0jSBLaEY+QLowQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay159-hz1.antispameurope.com;
 Wed, 15 Oct 2025 13:04:19 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 4A4B7CC0E59;
	Wed, 15 Oct 2025 13:04:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] mfd: tqmx86: add detection for secondary I2C controller
Date: Wed, 15 Oct 2025 13:03:09 +0200
Message-ID: <7975988b26074b9417db3009e70de97bc0a24ab6.1760525985.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <9e00b0ff4e90e4fb31c3012bd7a753d06ae21b45.1760525985.git.matthias.schiffer@ew.tq-group.com>
References: <9e00b0ff4e90e4fb31c3012bd7a753d06ae21b45.1760525985.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay159-hz1.antispameurope.com with 4cmp9w4jDCzgbMF
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:34e472ab150a674b0c3c5d0d646ede8c
X-cloud-security:scantime:3.242
DKIM-Signature: a=rsa-sha256;
 bh=1kk6xYtM9QKNb+MYQgCibH5JG8izX6pLn1C5uPaM1zo=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760526258; v=1;
 b=gUDPjp/V8BQC0oqc4GDKe09zYeD9I0lBjxlRAd/VvOsymiYlGjn2AZ9QEqEqETQDD3rjPGVm
 QFbiKTfVwqtYUFEgUIDUoJQm8r9eVsd6zYdz9vzDkfqnWh+fZGH254fI3t3Cznpp05nJlwsfNxI
 ba48GnTKd7sNFIgv8DzXF5qPLxAJUEPSXBlKWmnWyuHtj9aWJ/sPX+MS5r6AfFBDN3YNCzl1wBv
 mIpiyQtDZYjFCFn5i2pEr76t8s5rsb685eAa/Gs55dqJp2KTNunMLdzyTXeC9KTYXRPgABMpr8c
 XRlI+6ST6GqkAorqhbklXFCcUEox9IicyJlDV+eLNUNHw==

Many TQMx86 PLDs contain 2 I2C controllers. Add support for the second
one.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 6447406f5026f..a6f0a185904e9 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -20,6 +20,7 @@
 #define TQMX86_IOBASE	0x180
 #define TQMX86_IOSIZE	0x20
 #define TQMX86_IOBASE_I2C1	0x1a0
+#define TQMX86_IOBASE_I2C2	0x1aa
 #define TQMX86_IOSIZE_I2C	0xa
 #define TQMX86_IOBASE_WATCHDOG	0x18b
 #define TQMX86_IOSIZE_WATCHDOG	0x2
@@ -52,6 +53,7 @@
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_I2C1_SHIFT	0
+#define TQMX86_REG_IO_EXT_INT_I2C2_SHIFT	2
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -68,6 +70,10 @@ static uint i2c1_irq;
 module_param(i2c1_irq, uint, 0);
 MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)");
 
+static uint i2c2_irq;
+module_param(i2c2_irq, uint, 0);
+MODULE_PARM_DESC(i2c2_irq, "I2C2 IRQ number (valid parameters: 7, 9, 12)");
+
 static const struct resource tqmx_watchdog_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
 };
@@ -338,6 +344,11 @@ static int tqmx86_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = tqmx86_detect_i2c(dev, "I2C2", TQMX86_IOBASE_I2C2, clock_khz, i2c2_irq,
+				NULL, 0, io_base, TQMX86_REG_IO_EXT_INT_I2C2_SHIFT);
+	if (err)
+		return err;
+
 	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				    tqmx86_devs,
 				    ARRAY_SIZE(tqmx86_devs),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


