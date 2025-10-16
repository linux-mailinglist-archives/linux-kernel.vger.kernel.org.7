Return-Path: <linux-kernel+bounces-855642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC09BE1DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BA4EA7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60B2F659C;
	Thu, 16 Oct 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JigxG606"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1924A05D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598329; cv=none; b=kFiAnMZQSftbFZBP2Tv63802TnBrg+njlsdna1osc/xOAggd6BqDlxl8g5UlFTdfUoOYXY4eW6ywfd0x1hHW+SBLDPxBS/+KWmYEKu5LW392dyrlCmofmNFE6uBk2e3fZQyeKgIReIOH9JghQnQK6QGepdBfbu0pPGt374BqFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598329; c=relaxed/simple;
	bh=p0myo92MmjxlvZuAoHPLrlj0DNjkKh00FfJsrOtYC58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DUPFCFxNY1bAT9qbXTCwwqJ2XwEeT4oFUKR99Q29tfNBOfbqU8WRpyym4v5G8PoZFCpZUHhMjNN8P5VyOs1nY5yubGAeD+A7/2d4/aCLgkCBnyMeJ9N4fpbJ/3JZ2mq8GgoXsjTZq4UcVJkFL4eylgJYIfBpQVAWqZSHm1C1ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JigxG606; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7930132f59aso625816b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760598326; x=1761203126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=JigxG606i3zg0l9ISOhmVN+m4SBteP6CsnkqooJYr+3V+AJaSXYBgWlJLNO9K8c3mx
         fLUCkI7a432HKcP9t35SeWN0LL90d5mdffO0eVL+gazccg8OD4BHOTA9F59Udm7kEXXl
         rvA8HRkMlXZg9QfGjy83uQqXDn/TCzJHmgI3hyQjJD/jCPEnvlf9oLhDpkQVGCoC0fqF
         zyTFwOCpLwgDLXPDOdM/rOTmOj9Z6EYujXxcaDEqLxQGv+uKdqJD+iPqLiEINzZWZyJJ
         KDlaXSy+L+AJgsgvB6LzVEAR5S2gCYuxyjSzelDVJuaiOeVIO13a+wLudDbErAbRuNN7
         vtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598326; x=1761203126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=sWzP4kYz8PQovZskh6GcgSbifUeR0FEps6KYprB/5S0K53LRgQNh6ta8/qUZ7ppJUu
         ck056eNkQEofSVkAwzb1cTZIUJDVwgbcjy4CvPjn7vKmbD/Y/xuwlUPQzq81qfeXqaHk
         HyBqpEoYDfaljPWXHx6BbiMu34m0c2nSIvWKn+s3Meuyj6ecAp0V5gl8koLTK1rifRvH
         LrZ8MGQ/7iAg21tmA9TtOEAHyCjF9js8SdM5+/ey1L1Zqbui1jKjBNZpr7lp3FI7J8bx
         e1dvYWxnXkZv8RZFY3uYpCrTpweJjRIMBYqPoFh0jiL0WV5T8tt8KmTT8WYkMu25DC78
         K/+Q==
X-Gm-Message-State: AOJu0YzffOsU1PdHbQhCQ2Cx5n4bZE31lbD15WEUbGyDeI/gOhllQXhy
	dRg3rhUXftWIo0ASOO78U2eMOH2yAiccjdNb3qvo5nN8GYg37OUytplgmvTRSuYNf6M=
X-Gm-Gg: ASbGncvA1g0EMC3I3I1vLSV2vbrdSPoYcnvtry05mEGpOhoFpEISgiUvTVFxEuo4YeH
	2VQtxnIfB5C5t/KKzr5zz0I+hnPNLLaRX/zZsGoNQESCW1Foezj9HLMYHwsFcXUfxJlN02demlD
	m5lmqIY1SGTDlaeJqB93T3NaVDA8Oh8ce3gasag5kTqdN8/QkikDSU0xD/lzuNVcAayhUmzDhp/
	q960UIePUZu44dAK4w7OOGP1ILIiz2QTyixLpgG5AuYT+GOy9de5fxtHod2Fp1jxvAmWjibm2mh
	RTOn0ngs8nkooZPCU6gxfuQKPEtE9MuPZ2MTfcIAnrISoWN0OVygPfxPTTlspnfHawBafKtd/Tg
	Fuvr7II29bbiJ5YxHut6pS9QtBgj7RaKzGBfjrih/6KHQFgXKxSjDeB1v0VNotV7HcJ3wOYh+Qj
	fI0TipD2VmFWU1/pZjqH6oHqdRLp1J1RTztbu9lWwfH5X0F/lGAUZD
X-Google-Smtp-Source: AGHT+IF1MUyIStDGYZTHEyg8E2ywDZduM7sqAh10ehYvS4mTZJXKLG3YccUhx6i6ZwBsPOUw0Zd0Wg==
X-Received: by 2002:a05:6a00:b85:b0:781:2069:1eea with SMTP id d2e1a72fcca58-79387828612mr39359235b3a.24.1760598325971;
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm21105126b3a.63.2025.10.16.00.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250: always disable IRQ during THRE test
Date: Thu, 16 Oct 2025 15:05:16 +0800
Message-Id: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, so the interrupt
handler can run during the test and race with its IIR reads. This can
produce wrong THRE test results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
short duration of the test and re-enable it afterwards to avoid the race.

Cc: stable@vger.kernel.org
Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f1740cc91143 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
-- 
2.20.1


