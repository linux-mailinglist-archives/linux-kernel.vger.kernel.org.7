Return-Path: <linux-kernel+bounces-864545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E3BFB09C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C8634F5905
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7379311C2A;
	Wed, 22 Oct 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZXkfBmus"
Received: from mx-relay16-hz2.antispameurope.com (mx-relay16-hz2.antispameurope.com [83.246.65.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDA3101C2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123725; cv=pass; b=AKOkQYUaEjfFgBaVz8S2VLxtNrEI38EOAgGsVwRBKh10bivZzrfmUs/jK+eBe3c13WFhau/6XRaDxy4g3X+w3bI2M5OXb/RiyCbHtfQ77Lw81GNvfj9n7NQ5aS7LysDpnVWLBPWhreUVsZQ5QxTNW/8yZTGPOan7h5FwPXB0WMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123725; c=relaxed/simple;
	bh=0fkg3DHVLOcn27lFo1b4YOX4rGUxBw4jMgCFoAM33wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtjMvNzHhiIOCfqBX8iWb54QSnPJIMsYfnHKhWkNr7i9BN7OoEnJmBSTcHlYvc9lYWBhwjIQ1dq5TMGaheF9uiI5/txk+MQn9Z/PgpZUrJvmiWY2z6i9j2tHb7opZedCpNqxPB1CDCrGqCVZhYJmc4JXfnlZGeQHWWx3xYN81WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZXkfBmus; arc=pass smtp.client-ip=83.246.65.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate16-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CWEoKoLs1uka7zqpgXdocLVnWxfFIzcxvKoXmWWIDC4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761123706;
 b=CLhHqxMwFsBck+0Mo5i+c8rlTcd4gtlgZT8Y+6NtIKC2Xqw5xNCQUCuracFHfeOQBBAHw56j
 8ZArId2gxAoXym/wdHei0dRf8DNty+Hbt0duEsp7Vgtbsgw0MWuFkNqFDMEaYJSByRZmlVu4YGl
 kXk5JnvyKKaAn5ntDfhiOf/oeqsWYF51vS1xdiqhrJTcP+sAlTsZ7nqyxf0PuMRJk0dRUx21//j
 WvIXK4akdOU31KmQdDAcypfQ2hLP/+uBj6g/kOEnwDuyayBYWHgy2ROiD3rWmfnQJ42QkdPXatt
 G1N5qpugK6LaTxVUI0r6+gdqHq1rwCiWFGD/svvPihQcg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761123706;
 b=EjFGSfWSKW/NCp6aUqvFtSt59udYVfcnTgrKRw7j4J+n/kqf1euxOnkQ3OVomGhVqzCYpysZ
 c4j9wwIfCp0k1iTe+t47s3gpcDqW0ufFUF3hUJ3KctHOyrFMBl4xYQaCskoaNxkjQPIOkf0JFtG
 NBKm/A79fe0Xr3fp7zMsLKqthPM9pd92KoRzpu8dfgmr4eUduleqQ4yBkR7jn5qLIF/FMC1klct
 sxRoybdcnLiI2Oxb+6yCEv7k9V7EWnLX2y+WeSTkC85d8i9D54OmD+nyz4VM0yzFXXWXvbowrlB
 5AqUtj/FRXj30M9OkX9AvKBjzSIEXlW6Q7+h3YrOYgrUA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay16-hz2.antispameurope.com;
 Wed, 22 Oct 2025 11:01:46 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id A4A025A20AD;
	Wed, 22 Oct 2025 11:01:36 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 4/4] mfd: tqmx86: add detection for secondary I2C controller
Date: Wed, 22 Oct 2025 11:01:16 +0200
Message-ID: <52090a7a24995ad3acb72ec0f6d48d40e1f93e3a.1761123080.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bc9ce42883d10d54bc0954024d7e2312ff45fdb6.1761123080.git.matthias.schiffer@ew.tq-group.com>
References: <bc9ce42883d10d54bc0954024d7e2312ff45fdb6.1761123080.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay16-hz2.antispameurope.com with 4cs37P1ghZz29y99
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:723875e2fc813b0cc21b6ba59ab3ab7d
X-cloud-security:scantime:1.635
DKIM-Signature: a=rsa-sha256;
 bh=CWEoKoLs1uka7zqpgXdocLVnWxfFIzcxvKoXmWWIDC4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761123706; v=1;
 b=ZXkfBmusiYo9VD0f1okBKBoAguoKg6fXArpOJ3mWDNpVJaNteamy2DrTAeWGmbA3BOQhrY/x
 vab8xhteJiaTU6vJy5BjdhMMygb3e5LIM+VsXU+ZW9laQMw5K94yC2HWdGuLCbFs7nPePgXTkUT
 A6vToqrfFEq1guywcyQhbH+gGRCvp1to0X2Xx6Yc4Yi1jyAunNvlcieDDe2bpOzOxEZLSQG2nLl
 J1tpv+WeA8Bc36e1Sl4feH21zr7lknNmvlkDwMY8gvkrogae3ynj+9yhkqOOGztNY99c153l/4m
 bGajgkr7Dc+wEod9db6w3SB/2zAP/4AOFLnjmI0MJq2Hg==

Many TQMx86 PLDs contain 2 I2C controllers. Add support for the second
one.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: no changes

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

