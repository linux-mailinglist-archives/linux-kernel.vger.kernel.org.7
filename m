Return-Path: <linux-kernel+bounces-853298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820ABDB281
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6BF3E49BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587A305968;
	Tue, 14 Oct 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMjLXFmV"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31130595A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472466; cv=none; b=JS/3FeypRI+ayjL1XveMZ47bDU2G+qr4oXvEuH9Wz3CecrAtgrTmv2a7nYnghs++iHJgoEnIJaMbtPLi2UZTsvPuE8X4rz9q5SvCIVMXS94RRvu5LfPsBwwceRclE1fVYXlZC87OXMIn7pvaT32uY7ZHZWFChXQarHXEGYysk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472466; c=relaxed/simple;
	bh=11G9qWo3AalZFB6Fko0IXrFFm6wbNdqaAFoKRnYqgaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXz2a6kZpUCE3fnSwhwNudWRJTpGh3F+Nd47dSPzQwQGlGUZcwENS/bx5yn01EUAoeA2rPKlO+eJiUpnf67TDtfEHMzlBewGpCTfv9VMW0sXDEkRdBNKoD8uQd4J8lHU/HUKxu/CQgr4C6vRw6HB0qVo/32LWNA0kjrAhlCd9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMjLXFmV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2907ba47f71so12091305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760472464; x=1761077264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUJFv7ESp/8mj4VXSk9djpKF9F8nqTF7GCFJU4tlJik=;
        b=jMjLXFmVMNkL9Vj5udx7xL+UmIAtcHNK86B7v89gWxyKyFsNmX4HGQcijpNHc6Tf9u
         fNAGta2scILFpzXAZfO/SGk9wBelWMz8CWwWa/FW72IoYCvof12GOeFh0ljmmV3rMKJw
         ce4SH9VpMCmZ97iyphJw2OyXDvMKnRrj8G5Rgz46vkQ4ASdifrQ3DifBgj/EFMltIqd6
         asmJWa/1X5H4q4qscPhCZUWDxch6Aj0kHXZDAcUMex9Oo6I17AwFBCyIzjDsk9LEF43q
         1W9P7i1oMYnuM082f+LuQrNPlNjhByJJ+8COXdtP5/xb2MXJGw/njvhqrSr0+mRTsRzh
         tZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760472464; x=1761077264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUJFv7ESp/8mj4VXSk9djpKF9F8nqTF7GCFJU4tlJik=;
        b=Qd3aesbBaKxoRIhR4hPCKj56TPyqi0oLAskuDfblvre6ymR1baDMBLTfWu2iklbdOV
         EQ3ZuRWioj/LCgeXxyAxXXZME4B9uelNmYs6h+hQTCp6Sj/VxZ+5M87rbZU9hjsE06Kc
         ugmDkzEoPtbtb7gp+tqYYteHBormeWFFTT1X+PAF3Vv4OFUMqIEASx3quhU/uNwMEzz4
         9E2jw2u5Xrla+wrFYthnVuvJ258yEbUUZcNgl6Wd2ZJWPsb5/cT9lWD1j/0QDC9/Drh1
         wJqFs+J2z/UpnHzuIh0YK4Ejph6pc7Ca5qL3cN3KvdQiDCAyINlCvNSfMDt6ALEc1cak
         w3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeo/TwVHdtQNybCsAb7GUBGKDvOWivfsi1l34xSAX5SRmymyC2TocDosXeFDiclFoT2V4WBIfnZcOMaa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4jWuQC1RLNULFI7penE/Jgg8RZ3pRogK63tf/rUKyqHypWIS
	BvYvMsh8niER6kLkAE42FZY/mlvXUpKIbIq4whXTrVVkA4uHoo+n1GUH8GGy/OGT2XrfKg==
X-Gm-Gg: ASbGnctE3p+pwMHEAcv/97I7H/tVSkPJrNPkyFARwOolUxIkhgpTqhSEEu4atgWP45O
	IcDU/RI1EWhLgfmrht43JRjypmCEW/urHm+gYPems14gjMx8CaeTKuu/a2MhJbZ765x8vyJQLCm
	VvCunnfVVou18CGpzCx/lucCeoCXsG2llyg7BzBGrUldFHmL8YvcwsSe6oYfPUjb7XmnUkwOHL6
	bzzFppj3+b6NC85Key9TOZd4fK6MzjktBq5HEUM28sqD3sIlgzJjRU/b4cXDHi3c/SttrNrmZiN
	aYTAeroQluD1W11EBJrz4rbGEdOUdhn/ZLqFmpTva4Um0atCCS3i6su+s35Cz0kLvvoYUNbnqjw
	cba4HMaZn7ChwU8W8nlzpblIlBT8hEhdmagcB2Sb6qR10
X-Google-Smtp-Source: AGHT+IFFKeB1Mvjp4X6Fnn/pnWiCLBzUt9+3u52VJg1yNRK0ffmaoQzkUVGVa1S5Cm0s2yvoXega6A==
X-Received: by 2002:a17:902:cecb:b0:268:baa6:94ba with SMTP id d9443c01a7336-290272ff553mr380301905ad.53.1760472463985;
        Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
Received: from archlinux ([2a09:bac5:3e67:a82::10c:4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e205a6sm172580365ad.35.2025.10.14.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:07:43 -0700 (PDT)
From: Fokaz Chakma <fokazmchakma4427@gmail.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fokaz Chakma <fokazmchakma4427@gmail.com>
Subject: [PATCH] staging: gpib/pc2: convert explanatory comments to /* ... */ style
Date: Wed, 15 Oct 2025 01:37:27 +0530
Message-ID: <20251014200727.206103-1-fokazmchakma4427@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Converted single-line // comments that explain data or logic
to kernel-style /* ... */ comments, per
Documentation/process/coding-style.rst.

// XXX notes are left unchanged.

Signed-off-by: Fokaz Chakma <fokazmchakma4427@gmail.com>
---
 drivers/staging/gpib/pc2/pc2_gpib.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 9f3943d1d..c9c2b3ed8 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -19,30 +19,30 @@
 #include "nec7210.h"
 #include "gpibP.h"
 
-// struct which defines private_data for pc2 driver
+/* struct which defines private_data for pc2 driver */
 struct pc2_priv {
 	struct nec7210_priv nec7210_priv;
 	unsigned int irq;
-	// io address that clears interrupt for pc2a (0x2f0 + irq)
+	/* io address that clears interrupt for pc2a (0x2f0 + irq) */
 	unsigned int clear_intr_addr;
 };
 
-// pc2 uses 8 consecutive io addresses
+/* pc2 uses 8 consecutive io addresses */
 static const int pc2_iosize = 8;
 static const int pc2a_iosize = 8;
 static const int pc2_2a_iosize = 16;
 
-// offset between io addresses of successive nec7210 registers
+/* offset between io addresses of successive nec7210 registers */
 static const int pc2a_reg_offset = 0x400;
 static const int pc2_reg_offset = 1;
 
-// interrupt service routine
+/* interrupt service routine */
 static irqreturn_t pc2_interrupt(int irq, void *arg);
 static irqreturn_t pc2a_interrupt(int irq, void *arg);
 
-// pc2 specific registers and bits
+/* pc2 specific registers and bits */
 
-// interrupt clear register address
+/* interrupt clear register address */
 static const int pc2a_clear_intr_iobase = 0x2f0;
 static inline unsigned int CLEAR_INTR_REG(unsigned int irq)
 {
@@ -78,7 +78,7 @@ irqreturn_t pc2a_interrupt(int irq, void *arg)
 	irqreturn_t retval;
 
 	spin_lock_irqsave(&board->spinlock, flags);
-	// read interrupt status (also clears status)
+	/* read interrupt status (also clears status) */
 	status1 = read_byte(&priv->nec7210_priv, ISR1);
 	status2 = read_byte(&priv->nec7210_priv, ISR2);
 	/* clear interrupt circuit */
@@ -89,7 +89,7 @@ irqreturn_t pc2a_interrupt(int irq, void *arg)
 	return retval;
 }
 
-// wrappers for interface functions
+/* wrappers for interface functions */
 static int pc2_read(struct gpib_board *board, u8 *buffer, size_t length, int *end,
 		    size_t *bytes_read)
 {
@@ -273,7 +273,7 @@ static int pc2_generic_attach(struct gpib_board *board, const struct gpib_board_
 	 * is adapted to use isa_register_driver.
 	 */
 	if (config->ibdma)
-	// driver needs to be adapted to use isa_register_driver to get a struct device*
+	/* driver needs to be adapted to use isa_register_driver to get a struct device */
 		dev_err(board->gpib_dev, "DMA disabled for pc2 gpib");
 #else
 	if (config->ibdma) {
@@ -284,7 +284,7 @@ static int pc2_generic_attach(struct gpib_board *board, const struct gpib_board_
 		if (!nec_priv->dma_buffer)
 			return -ENOMEM;
 
-		// request isa dma channel
+		/* request isa dma channel */
 		if (request_dma(config->ibdma, "pc2")) {
 			dev_err(board->gpib_dev, "can't request DMA %d\n", config->ibdma);
 			return -1;
@@ -319,7 +319,7 @@ static int pc2_attach(struct gpib_board *board, const struct gpib_board_config *
 
 	nec7210_board_reset(nec_priv, board);
 
-	// install interrupt handler
+	/* install interrupt handler */
 	if (config->ibirq) {
 		if (request_irq(config->ibirq, pc2_interrupt, isr_flags, "pc2", board))	{
 			dev_err(board->gpib_dev, "can't request IRQ %d\n", config->ibirq);
@@ -447,7 +447,7 @@ static int pc2a_common_attach(struct gpib_board *board, const struct gpib_board_
 		return -1;
 	}
 
-	// make sure interrupt is clear
+	/* make sure interrupt is clear */
 	if (pc2_priv->irq)
 		outb(0xff, CLEAR_INTR_REG(pc2_priv->irq));
 
-- 
2.51.0


