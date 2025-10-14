Return-Path: <linux-kernel+bounces-852488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F4BD919B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE54FE7BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698E3101AE;
	Tue, 14 Oct 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="loH605AG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE451F4CB7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442474; cv=none; b=kTJlh4Jt0Ytcn66uYYqm/nyCrLPuKULCq/voZAUWRxrEECr8RAWt2wAPc3UXbRK2qjjAH96SWKZOa1b9HYmBEZTpdqi1b8QxJltoqSjc7kkcAC7PJ+zCgsXTt362qHDSghvnP8dT8sOMmbaOtHdvsJhWkvT7fAejpb5PQ5BmrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442474; c=relaxed/simple;
	bh=Co7cFHJGgPG9rCr6E7oygAs+aPpLYgTiSC9rPlo2r3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwDIxLWlsgpkvaB/rc+FR0nJkf9Fr1uPZijLtw+vp9Q5Cguvkv8z2kGgYJAA2QVnpBKPTVDu+rqWCQ5+eGgZkZIO5XZLvXgciFhMRKHwE9nu2yO52GQCuXw9eEMQ1yPM5dh90JjHp8YXpNb/22jWPJxNcJfVrOzfP/Ch/+TNrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=loH605AG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so5406236b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760442470; x=1761047270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPcMZxR0+lz33DfIEWTqyg43P9pNhyUOM9QOLXBPj9I=;
        b=loH605AGC78aBr2tgfalp7w0kMaMcdfPdH3TL8/xnTwVpuKpKJi4y0Doso2hwOSoWc
         zh5uP2AwQMjAFxCNrSfEWCOOeB3hUKqyb0xB6D6DKl7lyTAYkQCNhU6BU8bAbhwT8ZC9
         fze0SHgk6TMaHJj2LsjO68qy+Upv9/WKRl2wNji1/+5xl4cvWhIPUUV8sULytENwtBBg
         7nuZjVmVa1eVG6bLipcJ0RbdJvy1Uoq5Va53Ivu6EeLVM/yKOjS2tkl5FoV3iZJUcPLZ
         TLeb/qHVYZfjbotdQ0oChRqIqpZhSHOmDrIL+nyiiEgF8xEOHR24pct99OQIIgph0Lk+
         hGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442470; x=1761047270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPcMZxR0+lz33DfIEWTqyg43P9pNhyUOM9QOLXBPj9I=;
        b=aMfGGR7LrUiE0rPftLCEAVumJKSBbqJmM7oi0/AFPuYNIxAL8lF+zlUf40Ce2NFJMy
         uSbCjEpetP5eMtRFnKQoLuwFCiFjwZO1LoX0OlNQufgxNutDl3L/O3Pg5fJKSdFMb7C7
         rZotmfai3RqXMiiFPksISEVN9bqGfoxVZkjaY2arE9I8ZKkeKM5FZRC5TXKEehrAPTe0
         a+356ZAFuwJ5Hn/RaTvHuFpxRwCbKwJ/0Qsk0+txFBZbaSRXK/eKCiBd9Cr1VZAeBteQ
         GOakBLdlwWNp3kPoaZMuoG//V79y4/EeRz9cjA5mNRecrbuS+AzEvATGSn5+4KiN/BJV
         BUfg==
X-Gm-Message-State: AOJu0YyYpMbxr5e8zOUNL75tEhZfbwGoenUWUkpVZ/D7ZNfuhVgLZYhR
	1+BUfVboUN0/zR2Glx//U47PDv0p/kP+wClNyztLeU9CLxuNt9hw6FyJNxj9UA3T0vc=
X-Gm-Gg: ASbGncuVVsJVfuSAAhYNFy7p2XwFLA8vysg1QrlNHPqPyfoxMiTIujPykJemM/0zrsk
	5Q7GjOLj2w/mEk6u7xpu0ut1uETFkfxrqnERTE8mHKdvJ8zIwXLJAoe7Djj6k1rHbWo2QZ9Kk9J
	yIFy5bsNtpxlUgw+2YqVBV/cLix5UDt2n0ASAmMLGJlYny6mMOZCIpPUHABBR9NNaLcz4/Hmd2+
	hqQfEU68F6oK50UazPhletYsa3zyB8Gy9eCKtN0dg8MMi1fZKsO4CWwMv4KXTiWGFNnWAxyXpIB
	MXOXNgRQ4r7a+6EVsXnvlNFwogziMPc8xUVnZnotJgmeFzmOWtV6NNA1q2aPM1b2zhkwFTj56FR
	MujwoO2/VmGgjhSpcmY1kzgy3kkNvhKVbDUk5m7G/p3anWlnnXACLcmL2weutwNuOMXGSq05Joi
	1fmL7AM5M1aMWgXWXzkO9N
X-Google-Smtp-Source: AGHT+IEJ/Z4BcFcaDskM94Iyrqcu0UCwbiA+isEXzRBD9KhGU4ru+KvJ4hlRRGy82ez5z6OPxuufAg==
X-Received: by 2002:a05:6a21:999d:b0:2cf:afc1:cc3c with SMTP id adf61e73a8af0-32da8f7b6c4mr30979496637.16.1760442470439;
        Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm14808111b3a.40.2025.10.14.04.47.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Oct 2025 04:47:50 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] serial: 8250: always disable IRQ during THRE test
Date: Tue, 14 Oct 2025 19:47:27 +0800
Message-Id: <20251014114727.1186-1-zhangpeng.00@bytedance.com>
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

Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..addeef7a0d59 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq_nosync(port->irq);
 
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


