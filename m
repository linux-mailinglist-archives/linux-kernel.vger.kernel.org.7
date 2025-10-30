Return-Path: <linux-kernel+bounces-878865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB99C21A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 761C94EF140
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A944637EE3A;
	Thu, 30 Oct 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+3fxuz1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54233375742
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847103; cv=none; b=D4ytN8W0flYUrNRooylJq2nRNGf4DSO3xIpj08CewZnGKI//1BVf9fBS7SS7RyadAT7dATdi8OK7+gTTJ9TxSklaNHUHjVHQoBk2evYQfJFUciAntjsxAHVC1wf4K/1rTLuY4Y58nYRqBW9pGPvkdVQms3/f9ovjar4QrUl5I4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847103; c=relaxed/simple;
	bh=vO9lAruIFRWwmcjhkElTrINqAF4ZFqyjtlRL6JeFb7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7yTMjQ9RjGdNcFjJW3SNP7AtG1H94G0D1P5mOFa2MVFBEzV5Gl6OgRxARjYfwnUyQburqXbOz2sufJpurz42WdbJbgHaIBpagvpxiUg5AJi8gXOvCNF+og0Ii6mG0eyt4mj16FHlWPpHhAYAZ4bwrBV0STGDQYATO0m+iReC7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+3fxuz1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso17423575e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847098; x=1762451898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=G+3fxuz1w6dLvNdBnSclQjsuzXUS/OCeDEFOcc66qghMNxL7Iy/2o143MmZRVvXZz1
         1spVp0vONa50xG30/qk5WeBwq9kGdXvP7Mx5klSK5nboaWcbytszB0J9hXp8Uo2KuHIm
         +2fS4Q/Cy7wLHIpblWV5dkIYSZtBPnqR6nIuQtLg9Nex2QVICZ3D5Yv8kRY0oTr9i7g2
         n/L5QbLcPuZqZ/Kz9vaIHMpMskZF4oKZVHNObkHIKd1WEC8dBcZQTGA8HeaULMYIZpPJ
         XWjCxt/f7GW3U3sc+qO9Hpeqyd0NGZ1q1+U/2vZ3S/5DeAt38in3bx/HZHJQUQOH7doI
         DUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847098; x=1762451898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWj+7xNpysOeYb6zB5ArYmBB0QA2bqcJvV4UM5jfotc=;
        b=h0SKH0kQuURmSVa02YRl/JAuGfwjwfOpq+qoz6rAru/ld2mDFQ08aWAcNvPB39a20v
         bGPBBiZz4dJ4jsz2Tv/nFQPv1kWswItIGS13R7YFqDkXcZQhGK7NHmuukuhDLK8k20RT
         Yy+zdGsoyFkTI7fg5TDclFyxa149NGzWSaNZBDLIejdYvmt7GA9UixMvMmDMwbVGnflJ
         BSzQShmlIJ0LdpG8Qgk9CTYv6CKp6U+hbjgSf7JY+URMh57v3uyXBd2vKpvOB3yLA0Ud
         5n+WPJ7JbiQouvmPaPMV6o+pvQv6ZdvsnGILl6hefILyiUjMcxCyIy9HcTaFlYk8W1Ex
         bYpA==
X-Forwarded-Encrypted: i=1; AJvYcCU41xAQxfw7lAF/V0zEqMYX15G5FQEQ2t/ijYCJ36iME58pOGS86Ey3jm06z4WF7FQKWLlT65Czn/idF0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBHwYuyIBmimTU9oQ1Z1T83gf8opBg7ivBuhqRnFH6LL3cpOf
	zws1qWZRAC/LF/0oZpjbICoNJIJ0zBgF7FdGjMbfGcP/Iyvs5Y8eNbtv
X-Gm-Gg: ASbGncuYnM7NqjoYePu+KqICs94msBQyD2zYK+EE3mnpx+uidDKb2844twIj+KJkqjG
	O6eKl8AJjic5kR0E5zP10tol4CVoE2yKPE61L9JcVvubqOqU/O4ARLkNzdM2YoQzQgsyi5KEghu
	Kh8zvN0CT6KCtWClnS2oqGLLAxjEG3LBmqp1p3Og1Fl9Omo80fZa+jqqFTqo2Je7a/hnBRMb/xc
	CK9cehJDwsBXrJWWzjszrvWxlUaW/IqObLjR73sJxRUWxb+n4OuBvdY7wCqB4wlPv4HKsv3oWWg
	fi8h/GdirZmqqGoVN0OgvadCjAx9XN4iTa06gl/Pg+MnYspt4gOoLLpqZ8kDpFTProo1v8XkU5C
	9FSuGDx0DdNzKkSDQWXRfcAaDJNm4BnKEXlcyebSXfFbiv5mXI+al27KDLrwkEFxcWVxu6kd2Cz
	y7plKwq9cnefNhiWZR5ComceXmU5Eu6fpqJHxvOjmUAm33AM1HaeTovKo8qPkrWFdu/X+YBBY=
X-Google-Smtp-Source: AGHT+IHSLeHPyg7IKsaNF1Z5dRMW0XOJfQJfZIjvZOv3DXHqMuCpNkr1OVMVg0G9x3tsIeUBwjGQJA==
X-Received: by 2002:a05:600c:1e11:b0:475:faaa:8620 with SMTP id 5b1f17b1804b1-47730871febmr4732345e9.20.1761847098425;
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:18 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:56 +0000
Message-ID: <20251030175811.607137-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
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


