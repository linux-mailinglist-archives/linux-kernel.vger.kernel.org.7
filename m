Return-Path: <linux-kernel+bounces-878848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B57C219A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 754734EE85E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7ED375752;
	Thu, 30 Oct 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfWj3pH6"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10936C250
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846937; cv=none; b=RAn1hVs5DQyhb/Yj98JTQxJXsTJFFM0gi2BUFgZujrR5Fc6F1Vv6jIiJLQ/8W2lHt2NWW6xrEn5LnN8xWr82vm2+cpzo2A3CTijgIWSf+wx7+MuvPkbDZYnEXp59CHbBkL31E4ER0DPWw+WgugPetDNP5R19wyOLWwpBG8SaDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846937; c=relaxed/simple;
	bh=vO9lAruIFRWwmcjhkElTrINqAF4ZFqyjtlRL6JeFb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDufky94TTs2OjG7S+wZ/YeS0/wDH1382oJBOwcuv12edmNeuFpJFuj+Pz0CLLhHVXy8wNhHb038kAdpW3wr1ok414wIG9v9X7aHjZX1S+B/3tYKmN+Dao2cNwTE5YLnc77z9875WctZD8kvGkkLtydpO2ucav3LzWLIIW6xlm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfWj3pH6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1408971f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846933; x=1762451733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=DfWj3pH6gJatdsT5V21tGVLpmbkoptpWV8J5GgmVMAKaP7SV3J7Z4HSS+ma+ayDxwm
         YM/s8zT09gC0IxSmbuR71sx2udzUzAWWaqQS4PSsa8F+w9rEGXr8U8np1W3jCtVQfGx7
         sSdSIrngsl9r4I2XYMvk6HqrzQCGDFgmeOvDlWUC6mgM20+noF3bKvcehFxFWFjy1eZI
         sr6pDNrhj8xC51nbBUCOjNnI3GRNTfA12IgPl6s/5YVPl0Ta2hWD2k6uAPaDMVl2zigC
         Iwx1aR0011i5mZ1G8qklIkuUQjFQmBC7TokydxDBDyoT2Hrfeqke7rgxmFtk45q23x3x
         N7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846933; x=1762451733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=TbkQlADjrikB2OWNOhCJIkOrMR+lOMcKKJ6huu3QH1BT/1U51RlHVVPJatI2PdRnaE
         0aeKPP/CJNcKoB05lk1vSifyJA36s+pYz2VjJqJGYpCfLwZ7IsNSDXtQez9NS02KElFo
         7UXOPv2Vi2NRy2FjdSHD0OubPNf3IZaGypSOdfea42L4WAcaPM2YjmsRelp0nxrGmySc
         ps4SxeCXEztSr42nY752iU7JjdLkzqqMm4KxSViV8PgozVnFhdxY2zHXf4j4OBMlHsFr
         MRqIT4cvivcKdersmkvL//BV4xLodFKGq8obrf59MpJozDSmY+pVV9uQIl+mttn762b0
         noKA==
X-Forwarded-Encrypted: i=1; AJvYcCVY1xsa4vY+tv/cb5j7PjT6D36DojXTuNO786p9Y9/dChBcynTNiRwdGei6gQp0n+ZombeRKjTnmpt+UC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjA0ItKCdUkEy7DiBimzMct/q0SgOjyi7LAjg3/yfquX9zEQkf
	SOOBNrNtS3EORos5z1gGVy5m6ir9UxQ9Be3D2cG1CwcWGBzb2VDDw6vn
X-Gm-Gg: ASbGncvPK1WZqHej98MvOSNX7i7S3fmtjVQFTUzJRBQzcarBGsTyRNgcY0zcdl38U6t
	h1V1/gKBHll3QrkmysZrlZzAGzGUcwvucX4yoeePD9QZK/qcyyui+8DENi4YVTCRAvDzBlAMYjj
	2DOPOxwo945ArjcHKHek+HzzCEH2rXHBaVNqeRNU5nxSv54jCBl4FmuKQJ6P7d+RCrHtc+wNB5S
	ji0+Nc2hUPOdxdfpgzXn+oro480a9IraKhG6GCxHla7Z2BP/qsIJewn0OPILmYZsxCHwWcA2qul
	d1sLglvp4FrjQLTwnZygcUMu7h8h/wjEo4SP/eB/j9S7rWRRQEdP7eVYGocNtbhQn+/MN7WCZpq
	XWuBLiNgttoy1zmoh+bPWohqMJRW72zEJmv3v4RQWM3tGfi00fmbGelus4WaHroBI6eTxqD1UyZ
	1ISwx8yeXh5VIbfBVTgjJHojtfFMm3lwCk59v7ggEso/LyA1urisfi9kE1O3IzafKvFonu4yE=
X-Google-Smtp-Source: AGHT+IHQFsWv2WZtyuikDXDSZcQC16eMKnf/MSqZRjYeCi+/xS7a8yMFYJt3MbTFP4GQ55NBuKaNJQ==
X-Received: by 2002:a5d:5d11:0:b0:427:7ad:cdac with SMTP id ffacd0b85a97d-429bd682c6dmr534666f8f.20.1761846932711;
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 08/13] serial: sh-sci: Add sci_is_rsci_type()
Date: Thu, 30 Oct 2025 17:55:12 +0000
Message-ID: <20251030175526.607006-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add sci_is_rsci_type() for RSCI port type. This will simplify the code
when the support added for RSCI_PORT_{SCI,SCIF} private PORT type.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6f396e1151d8..7cc2b622e270 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1008,6 +1008,11 @@ static int sci_handle_errors(struct uart_port *port)
 	return copied;
 }
 
+static bool sci_is_rsci_type(u8 type)
+{
+	return (type == SCI_PORT_RSCI || type == RSCI_PORT_SCI || type == RSCI_PORT_SCIF);
+}
+
 static int sci_handle_fifo_overrun(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1016,7 +1021,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u32 status;
 
-	if (s->type != SCI_PORT_RSCI) {
+	if (!sci_is_rsci_type(s->type)) {
 		reg = sci_getreg(port, s->params->overrun_reg);
 		if (!reg->size)
 			return 0;
@@ -1024,7 +1029,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		if (s->type == SCI_PORT_RSCI) {
+		if (sci_is_rsci_type(s->type)) {
 			s->ops->clear_SCxSR(port, s->params->param_bits->overrun_clr);
 		} else {
 			status &= ~s->params->overrun_mask;
@@ -1837,7 +1842,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
+	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
@@ -3112,7 +3117,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
+	if (p->type == PORT_SCI || sci_is_rsci_type(p->type))
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
-- 
2.43.0


