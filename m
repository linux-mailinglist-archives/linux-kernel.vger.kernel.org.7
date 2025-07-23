Return-Path: <linux-kernel+bounces-741766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA2B0E8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3257A0483
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4181DED47;
	Wed, 23 Jul 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dBXdZBY7"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9219C558
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753238017; cv=none; b=eTp5H0VLS7y5PgUNKtL97YG/atfgxd4rdBArUmHniXUpPhKoz+uwdB60Tl0zBl80PSmwz1hMAJh+9x/pP6TVemXjmGU46BdGUaEsBb/TunuLSxj7uJ+TFPAz3U00iH6izCXNvLCR4hBgf1a/6gIedcVyIQXSkGiW1wyujjgklqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753238017; c=relaxed/simple;
	bh=SqF492q9Kp82C7tym/WEovxGbqtFyhfwFxqr0W+j9Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyKynuWOIMd1MocIxbsEri9mvHRsqOX+5PwDWuPPTpKCLvgux+pdS7OYc53EYJyb5LM0dknnD22f3KR41RJzZoETODW5GzI1zo95onw0quODHJpo5s/kUwbjL8uxN04GDhKnIeiOCaf+HTOIxrqHImO8UzgP7WYzRQzMnLuQoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dBXdZBY7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so5269430a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753238016; x=1753842816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=dBXdZBY742Qe6eu3o+2wDaSvfIIreToWinwBW7Ng70yjYMJy685LqI6zuvJ+m9OzgO
         7wHGrpsSDbensDb9PbJB3RfFSGZZ70WJJHa4inD1lg94dE1fKWxvxAc5b2xFAGQLLd3m
         LOe69i90kS+gO6Uq2LvwtdEa1UubJZO+addWVv9KpixTxIEk34JMvsNAFjalGL6VJqLo
         1ZdibaJ17mpEebeYASDUHdIik6VXistwsntwOT2gKscDSn1JfZkRpSrV7zJOOpqflJ5L
         VVfVuh1AMvwy0PzEgwbBPy1cM6y7/+W8Z6tKIoUOkoDIf4+BV6Q2aEe7elBUJ23NXMuo
         3Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753238016; x=1753842816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI974Jb0wm0kSmb50OjDAjQveAFQOS1fTvXMINV5m8o=;
        b=EzGXQhaV38yYKMnHVEJe8BuAV4/pT4yUIHTLqet0NR4IpFly9Wa1kAN7prnZRcWd7g
         PHJuIY/VyjSlohjkR6xYhNtdieDo8yl/RmLS6Mco91jlZtlDdFysF2n+fSQH2FzPJQSn
         M72D1pnqdApvB+GRniLwkaM2GPdJW133nKM+dTOZ+4+3aOL9oatek7yKPmeNXaronh0M
         cZSyGozv3MZNvDju9fSxLuliYdXZ3G331J4YH8pUV1/8etoBBOqBr58ERFUr6VL7YM//
         L197peE7kAQCZlSBwTpB2glufs1fsxRjme3cZEOVVPlaf5CvppfW1NY+UeozMZ4Nxafa
         MNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUs+M1L8rDWCRU6T3TFqJWJVJde4MfA8Pba6Uz2EXe9X3VKbblaFXLmpc5Pi0uUIwNd9TvvZYQLC5LsO88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aXatBXqxGNYU9audJs3XJwZ4btmP8dogM81IcwRE3oeUJRoR
	5RAd0k8qIX4ayywr4+5LAyTtomfr0ALrlAmh8gQtYm2JNs+KMSqoRGwCTvq145WbQus=
X-Gm-Gg: ASbGncuotuqjyQp8sNAw+MMorPfdCbbjCoiAv1SToe2uEkqcA5NBBzpwG9kuhNta9Hc
	LvER0vL07A6qTfYmD/KNidipBoFdtTklU3Iye9ZmW2nrusa91QCP/4zNpBKYj0TiFRo7RAYQNYB
	MYo/1A6X9E4iSUyKwJscmvEpCBDpnVvONnCgAb0UMkD4LZtV6pf0eux3cwtNDFBheIcwX+2zeSU
	Wf+ODd10sf+GytWefsMk1sOXy8pO6Ne0XvrHwZTiuR/2T4Qwkq3Y6VdWUOYb2TV6G1LhiZnURQy
	x1MY5NuVEq8zbJ0F1vuwvQPlGddfIzPjFgl9R1h1XzJW/Fqa3QHO70ptYI7JgBiu7D9KN/381y4
	BhIkXyOmAuL9OJmrU0qRZtcsI3guhAnftCUSZdABwH5z8+dUbjaAPLzpK
X-Google-Smtp-Source: AGHT+IF2KZMu9tBJ5eQnwYDzw6P9UXzyzYbdG7iFoo+7BGUm52xEPh6annNbtlg5BtEsYH8AFeKVTA==
X-Received: by 2002:a17:902:e785:b0:235:880:cf8a with SMTP id d9443c01a7336-23f98149b7bmr15717685ad.15.1753238015655;
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2a77sm85325795ad.136.2025.07.22.19.33.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 19:33:35 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	john.ogness@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	matt.porter@linaro.org,
	tim.kryger@linaro.org,
	markus.mayer@linaro.org,
	heikki.krogerus@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v10 1/1] serial: 8250: fix panic due to PSLVERR
Date: Wed, 23 Jul 2025 10:33:22 +0800
Message-Id: <20250723023322.464-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250723023322.464-1-cuiyunhui@bytedance.com>
References: <20250723023322.464-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR (Receive
Buffer Register) while the FIFO is enabled.

In serial8250_do_startup(), calling serial_port_out(port, UART_LCR,
UART_LCR_WLEN8) triggers dw8250_check_lcr(), which invokes
dw8250_force_idle() and serial8250_clear_and_reinit_fifos(). The latter
function enables the FIFO via serial_out(p, UART_FCR, p->fcr).
Execution proceeds to the serial_port_in(port, UART_RX).
This satisfies the PSLVERR trigger condition.

When another CPU (e.g., using printk()) is accessing the UART (UART
is busy), the current CPU fails the check (value & ~UART_LCR_SPAR) ==
(lcr & ~UART_LCR_SPAR) in dw8250_check_lcr(), causing it to enter
dw8250_force_idle().

Put serial_port_out(port, UART_LCR, UART_LCR_WLEN8) under the port->lock
to fix this issue.

Panic backtrace:
[    0.442336] Oops - unknown exception [#1]
[    0.442343] epc : dw8250_serial_in32+0x1e/0x4a
[    0.442351]  ra : serial8250_do_startup+0x2c8/0x88e
...
[    0.442416] console_on_rootfs+0x26/0x70

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Link: https://lore.kernel.org/all/84cydt5peu.fsf@jogness.linutronix.de/T/
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7eddcab318b4b..2da9db960d09f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2269,9 +2269,9 @@ static void serial8250_initialize(struct uart_port *port)
 {
 	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	uart_port_lock_irqsave(port, &flags);
 	serial8250_init_mctrl(port);
 	serial8250_iir_txen_test(port);
 	uart_port_unlock_irqrestore(port, flags);
-- 
2.39.5


