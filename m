Return-Path: <linux-kernel+bounces-825164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73610B8B277
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CEB3B1C94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4331D744;
	Fri, 19 Sep 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lME0yzqv"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7B263C9E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311773; cv=none; b=HdTxUiEPsVNt/4S24meFWw9FNgOJvudBrZ46znVJGMJwtOXl1VP6c0tG90k+r/VD+uB/LnHUKlogs6VvFaCRor0CMXrey2VhAcNLkBwNyZcEWn52axItuW3Cx+y2Rbg6AFXBMiG3j2VIzVoury5kqn588F7hx8KVDXwlMnEY5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311773; c=relaxed/simple;
	bh=0k5FdH7x0PAc0uLBBEgdANkFUdlliQWI7SUax9iqcqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ/FLggmVftSLtYz/Y3BHMqJ+rPvRSpJWJF3GY8eq5iiOaBk1M4H86wDXfwYgu7xZg/K2Jkh8wsYNhlaPQWrf1Z2K1pHmo2veCLZt02Efy/KBwK31X/65cNK6VfNpKOck1weKZ9Xbrn+UEQfwq1B5GhUZM81Swhr9DXga0eNZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lME0yzqv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1252595f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311770; x=1758916570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ksYK0jWpJo5qBD8tLPnVcvm2hGKV3CK/pEzYQu8jRg=;
        b=lME0yzqvRpTNzv4j4CW9Pj5248VBCWz8nxwdAZbafvClb/+JkDrnxvioQmZPYOCbVu
         cLLFnHGTgN7dc5YryJJxhpAmqDr1VrKyr3NkjQ6K2Euvy1TN4DPHqbkyGzowIjrOXOoS
         Z2bLiTgGX7sATgUco5HCw5tPYavepzdxIq2y/X0yhbiQmRRLQWh1o9Z9h9Y2dEfO2+Q6
         dojZOcLvNRSk3iYuctaP339njdyEygYVWxtQFA0xtO9ZGfZf1Bk0qcFhpaIgEnIpn+KU
         tbuWR+jyaIlmVuGU93OBrJ3ORhBCVwJGuNbBkD5XVY303qCs32CYbS0edFxbIqejupdE
         usAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311770; x=1758916570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ksYK0jWpJo5qBD8tLPnVcvm2hGKV3CK/pEzYQu8jRg=;
        b=D6c8thEIyRE0Sa+t/ikI68OCFVdBy9PkSHV2cJsR6/zXGaZRBnfgI8HgpQPQ7KcuQR
         YA8CJHya9RfMaEb5ZlC1NLvYRPbUqsfFOgiInUG0eiW3hbKsy2pbnb2uf/XuTIoW0+xi
         y0HiiWXKmJTUUF83fwCSYoL4CqW+tY8B56rOF4XeZul/Xrbp3cn7LmzG9HIGOBTodebi
         Kz1fvO9Lc8wijKvmHMjFevXYGyLdbPvXyipCMAfpR3OkFeiwC2GnBvzZ1MFuPHPIRUnU
         Mv3aIFHt5VMqZ5Py5+2xZxObHm4/76Gck+Dn0QFy37vgbG0AD1nTIVLypCR+V9PBRp4R
         ohfA==
X-Forwarded-Encrypted: i=1; AJvYcCXTdNN2B16EAsWmheGtj+CjiyFYBd/ny2Gp2Ihhjh+gmHIrZcO6+1wn8n4zYV/DPneGCKLrtP5yZVUi/XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hCP4NxJH2Gs3E5j0McXYbBdeE0Tp4SB5RUA6cR1FMSQBbfjw
	It/MFtiBYsZCzUkvRVo6yIKTrtaosx7Mub+xpxKMaoM99Cbv7wIFaAAe
X-Gm-Gg: ASbGncuxBYVGXbB8m7GSl7mQPVAEQSXa/lbgJXskGkfMHMZQhrhRGPOviQeweu0g824
	QBsIQHvGDxUk5yxQPsyxQGqKLqDnX09g0jzR0JC3XQQj8+WZ09gT8glIotyox4l1MJepGXEA7jz
	dWZEmQ5Y6ODawpw/e0Eq5no4Ec5+rUJ3HFIheEqfcAE+dWcYl02Pwpx2SdAKnWAuE7YplX+iSQY
	qpySsFibjYvHJPzeIla2sLcjgnUmvdK1FW981d+DcXatR02WE/Z9zzcgu/HUwRlUhJbP3e+SMkE
	RR91dVifcY9MYvn4xSmVNOPOw+x28VCRPTPAgHyLNFs51h9NC53rEnbHn1oo+C1WKQAcN/JA0dQ
	VKHvU5tI7X8hTB/fFgLuawm+p297qFqADz/GnWV9kTU3n
X-Google-Smtp-Source: AGHT+IGor7fBbmJpCo3EZrrz4UffjyX5xnKngpFVuRGVtadGoz+Wq2zsxj9zRG4985FcwN4OoMy5qA==
X-Received: by 2002:a05:6000:2911:b0:3e9:b7a5:5dd6 with SMTP id ffacd0b85a97d-3ee83da05camr3501396f8f.40.1758311769847;
        Fri, 19 Sep 2025 12:56:09 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:09 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 2/6] staging: axis-fifo: simplify interrupt handling
Date: Fri, 19 Sep 2025 22:53:56 +0300
Message-ID: <20250919195400.3180039-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
References: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irq handler iterates through the interrupt bits one by one in a while()
loop, clearing one bit at a time. This is unnecessary and inefficient, as
the 'Interrupt Status Register' can be cleared with a single write
operation.

Also the irq handler checks for some interrupts that are masked out in the
'Interrupt Enable Register', so they are never triggered.

Simplify the irq handler by removing the checks for interrupts that are
masked out and clear the whole 'Interrupt Status Register' in one go. The
macros that are no longer relevant are also removed.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 144 ++++++--------------------
 1 file changed, 33 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index bab2002628df..33a8440858d9 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -89,16 +89,8 @@
 #define XLLF_INT_TC_MASK          0x08000000 /* Transmit complete */
 #define XLLF_INT_RC_MASK          0x04000000 /* Receive complete */
 #define XLLF_INT_TSE_MASK         0x02000000 /* Transmit length mismatch */
-#define XLLF_INT_TRC_MASK         0x01000000 /* Transmit reset complete */
-#define XLLF_INT_RRC_MASK         0x00800000 /* Receive reset complete */
-#define XLLF_INT_TFPF_MASK        0x00400000 /* Tx FIFO Programmable Full */
-#define XLLF_INT_TFPE_MASK        0x00200000 /* Tx FIFO Programmable Empty */
-#define XLLF_INT_RFPF_MASK        0x00100000 /* Rx FIFO Programmable Full */
-#define XLLF_INT_RFPE_MASK        0x00080000 /* Rx FIFO Programmable Empty */
-#define XLLF_INT_ALL_MASK         0xfff80000 /* All the ints */
-#define XLLF_INT_ERROR_MASK       0xf2000000 /* Error status ints */
-#define XLLF_INT_RXERROR_MASK     0xe0000000 /* Receive Error status ints */
-#define XLLF_INT_TXERROR_MASK     0x12000000 /* Transmit Error status ints */
+
+#define XLLF_INT_CLEAR_ALL	GENMASK(31, 0)
 
 /* ----------------------------
  *           globals
@@ -166,7 +158,7 @@ static void reset_ip_core(struct axis_fifo *fifo)
 		  XLLF_INT_RPORE_MASK | XLLF_INT_RPUE_MASK |
 		  XLLF_INT_TPOE_MASK | XLLF_INT_TSE_MASK,
 		  fifo->base_addr + XLLF_IER_OFFSET);
-	iowrite32(XLLF_INT_ALL_MASK, fifo->base_addr + XLLF_ISR_OFFSET);
+	iowrite32(XLLF_INT_CLEAR_ALL, fifo->base_addr + XLLF_ISR_OFFSET);
 }
 
 /**
@@ -402,106 +394,36 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 static irqreturn_t axis_fifo_irq(int irq, void *dw)
 {
-	struct axis_fifo *fifo = (struct axis_fifo *)dw;
-	unsigned int pending_interrupts;
-
-	do {
-		pending_interrupts = ioread32(fifo->base_addr +
-					      XLLF_IER_OFFSET) &
-					      ioread32(fifo->base_addr
-					      + XLLF_ISR_OFFSET);
-		if (pending_interrupts & XLLF_INT_RC_MASK) {
-			/* packet received */
-
-			/* wake the reader process if it is waiting */
-			wake_up(&fifo->read_queue);
-
-			/* clear interrupt */
-			iowrite32(XLLF_INT_RC_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TC_MASK) {
-			/* packet sent */
-
-			/* wake the writer process if it is waiting */
-			wake_up(&fifo->write_queue);
-
-			iowrite32(XLLF_INT_TC_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TFPF_MASK) {
-			/* transmit fifo programmable full */
-
-			iowrite32(XLLF_INT_TFPF_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TFPE_MASK) {
-			/* transmit fifo programmable empty */
-
-			iowrite32(XLLF_INT_TFPE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RFPF_MASK) {
-			/* receive fifo programmable full */
-
-			iowrite32(XLLF_INT_RFPF_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RFPE_MASK) {
-			/* receive fifo programmable empty */
-
-			iowrite32(XLLF_INT_RFPE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TRC_MASK) {
-			/* transmit reset complete interrupt */
-
-			iowrite32(XLLF_INT_TRC_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RRC_MASK) {
-			/* receive reset complete interrupt */
-
-			iowrite32(XLLF_INT_RRC_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RPURE_MASK) {
-			/* receive fifo under-read error interrupt */
-			dev_err(fifo->dt_device,
-				"receive under-read interrupt\n");
-
-			iowrite32(XLLF_INT_RPURE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RPORE_MASK) {
-			/* receive over-read error interrupt */
-			dev_err(fifo->dt_device,
-				"receive over-read interrupt\n");
-
-			iowrite32(XLLF_INT_RPORE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_RPUE_MASK) {
-			/* receive underrun error interrupt */
-			dev_err(fifo->dt_device,
-				"receive underrun error interrupt\n");
-
-			iowrite32(XLLF_INT_RPUE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TPOE_MASK) {
-			/* transmit overrun error interrupt */
-			dev_err(fifo->dt_device,
-				"transmit overrun error interrupt\n");
-
-			iowrite32(XLLF_INT_TPOE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts & XLLF_INT_TSE_MASK) {
-			/* transmit length mismatch error interrupt */
-			dev_err(fifo->dt_device,
-				"transmit length mismatch error interrupt\n");
-
-			iowrite32(XLLF_INT_TSE_MASK & XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		} else if (pending_interrupts) {
-			/* unknown interrupt type */
-			dev_err(fifo->dt_device,
-				"unknown interrupt(s) 0x%x\n",
-				pending_interrupts);
-
-			iowrite32(XLLF_INT_ALL_MASK,
-				  fifo->base_addr + XLLF_ISR_OFFSET);
-		}
-	} while (pending_interrupts);
+	struct axis_fifo *fifo = dw;
+	u32 isr, ier, intr;
+
+	ier = ioread32(fifo->base_addr + XLLF_IER_OFFSET);
+	isr = ioread32(fifo->base_addr + XLLF_ISR_OFFSET);
+	intr = ier & isr;
+
+	if (intr & XLLF_INT_RC_MASK)
+		wake_up(&fifo->read_queue);
+
+	if (intr & XLLF_INT_TC_MASK)
+		wake_up(&fifo->write_queue);
+
+	if (intr & XLLF_INT_RPURE_MASK)
+		dev_err(fifo->dt_device, "receive under-read interrupt\n");
+
+	if (intr & XLLF_INT_RPORE_MASK)
+		dev_err(fifo->dt_device, "receive over-read interrupt\n");
+
+	if (intr & XLLF_INT_RPUE_MASK)
+		dev_err(fifo->dt_device, "receive underrun error interrupt\n");
+
+	if (intr & XLLF_INT_TPOE_MASK)
+		dev_err(fifo->dt_device, "transmit overrun error interrupt\n");
+
+	if (intr & XLLF_INT_TSE_MASK)
+		dev_err(fifo->dt_device,
+			"transmit length mismatch error interrupt\n");
+
+	iowrite32(XLLF_INT_CLEAR_ALL, fifo->base_addr + XLLF_ISR_OFFSET);
 
 	return IRQ_HANDLED;
 }
-- 
2.50.0


