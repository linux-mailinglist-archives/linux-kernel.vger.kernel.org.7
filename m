Return-Path: <linux-kernel+bounces-856168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F66BE34A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380F14811E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923F32C317;
	Thu, 16 Oct 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NDh9dXOy"
Received: from mx-relay02-hz2.antispameurope.com (mx-relay02-hz2.antispameurope.com [83.246.65.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0530FC0C
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616856; cv=pass; b=Bbet2LUiwmSN+Z+OFPq3UsR2ZBazlpQIsKghqldU3w4Lv8AI3aDXgVCvRmPfIqqTCdF9WxiRk2a+o3D/gqs7aSLSjaKM5cgMMP+hjNQEj5Uyun4qLXhC041+cQ94FQ51IH5yrnVMR4RZ3XgE/UWKZZKnlhQC1DX4BHDfyvtQAeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616856; c=relaxed/simple;
	bh=AhE7mWYiKwrLmMujdh80FZXwWeFEXVxROalbMp5K+rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moz4hTDpRcMS3tNNdGYnTwWfjSUYWX7e9jUVj7Na/1vbWPrbXL8s0zAkzaRhbG2d/sjv3qRACOvsc8QmUk6wlcWZ3Mr9P/fqrGvZvOuvcm0LCGQK8F+5JVoou/VuPdRkSEzh7VA5Hj1mgcji8k+ya35iLUV0XZf4vdysa2i7MdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NDh9dXOy; arc=pass smtp.client-ip=83.246.65.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate02-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=p8HU5ghILMkmBE7X0DI6HUPtOtmviMs6RRNSg0YuQZY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760616841;
 b=Cy14voxppyPk8ApTckNvySRhT70U+WYriA+YDa6q2YuEVOylWZByjFBwMFo4GTDFARCsAK7R
 3pwk4WeyTrQmrrSou5wi0S0+ujC+kAVRJfeLmEj6DDd4oM2vOtN48zYgOMizCAxsCj6+NLZFZ9j
 dNiWZ6/VEBIYiPGBc+8nR3ga/c05WyS3wUbt8OybDEUc4ocT/yIMFFSjgH2a9JlYGq69G0zorJu
 7rEmWDPuSM8ENSZenSuOMuCB8cRldpl/EO6aCL3lxiv4TvVrUR5jXd6sOvN5CB9kpxvACUB/8tt
 lw8l0GPPyGRUA9tg6pBS7idzxCawDYZNreztONPPAj0OQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760616841;
 b=TgNfrbMuPv6Fh0SsvyacUeE4rJbcxS4pR6EyhU4yFcz7z1AcJZ2PlrWhOTzqtlsAxaFfJnIe
 yg7bAqlrH+h9jUCdHkmsVeM6Vokte5oF4FMqollAix+6aHnlRhUMbtEOBIxd2Y5SrLod4uujU1C
 50Wz7IeqoKbUqdMrD4QiVfR/TepOO2rhiPaPZZwYeQL/dcyyXJ6L+JL3bdkissZYBV7sRNA7Goe
 BPi28LpBWNZHuGVDHoEfdo6cY+zJrVYo8LdwRN4ER0uZpzLpya0C7cl/Uc1OmeCIJmXSNZIlQp2
 KHsVI7bL9/H0b2gYAdjGYQuCg+utlgdi77Y0+tsQv6YUA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay02-hz2.antispameurope.com;
 Thu, 16 Oct 2025 14:14:01 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id C151BA407A7;
	Thu, 16 Oct 2025 14:13:50 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/4] mfd: tqmx86: add detection for secondary I2C controller
Date: Thu, 16 Oct 2025 14:13:29 +0200
Message-ID: <24f2c69532dea95a7ddbf97f34dfef92c49d065b.1760601899.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5855f15ad83617d3a71b40d89d61273722c6e15f.1760601899.git.matthias.schiffer@ew.tq-group.com>
References: <5855f15ad83617d3a71b40d89d61273722c6e15f.1760601899.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz2.antispameurope.com with 4cnRgz2bqCz2gWjd
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:51778a54f7a6890771feaed904a7d54d
X-cloud-security:scantime:2.014
DKIM-Signature: a=rsa-sha256;
 bh=p8HU5ghILMkmBE7X0DI6HUPtOtmviMs6RRNSg0YuQZY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760616841; v=1;
 b=NDh9dXOywrFud4WExfzTZWWGdC/OTct5ZyaWeScYC3Kr3IDCj8Qxd3SkE+KBnkT7n/7S70ut
 pooH2c9bB50lVM2aHbbHamcPw78OLuf719y+VTrEae0G8dsREtE50BDHzYZtvPg4uu4qUOM+2MW
 u7lsfBz9GrBAlzMIjzwpV3RYmGIrSpkwam3evydlVuqnLdja/yAYPJ33KiNqqHMUPNs4phF1z6m
 1CqdMK1GdU9GrEDCqejse0io6RtE2S5yq8Eg6f+vbkk5dJNfQb/Ox+J4NaiOlCvtTEzbt7o/99F
 ragULN297FD7Flwjb52aNR2yRdx+Upq5eNsQ2kIWTPYGw==

Many TQMx86 PLDs contain 2 I2C controllers. Add support for the second
one.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

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


