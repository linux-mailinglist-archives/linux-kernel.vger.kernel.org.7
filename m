Return-Path: <linux-kernel+bounces-848409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B001BCDB41
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02763543434
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F2F2F6571;
	Fri, 10 Oct 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2lX6zS2"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53B2F9C3E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108596; cv=none; b=GIeetZ1e0LtVB0VBtN3q+ST7IWCNCGNLl8TPCsO8w4L2Z6Fnfm4uljdmu85m36070Qy76LCV7dNeM/Zr/pOVFsB1wrO4kjfqlkUm+IJKYq52uV+/y+gymF44Br5us6QqeMPoiil7LjqE1H4xXuSAUWKbt/Fk+fItwMa8eNP7YUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108596; c=relaxed/simple;
	bh=YY7i+ekw8WEClpFqVZfbZbIPcOFXG9mqoVtYSHhdgrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgsUE1F4lJy6xtmpIOzbK8EfO3uXp1z6LcmZ9tXmEM7m5ruqFJHBR9v8Wt1kJa1qgmCaGlOwry9WXC2EEAm+TuyhA9p71b/HrJ7QycLbBXHpGLYoyGwtDE6aTH1omRX3EIvn+4o4oHYt9xkopmKgOUoi/bbmAbSTMzUu0o301G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2lX6zS2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-789fb76b466so2060696b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108594; x=1760713394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=H2lX6zS254lP6QiTChrWguTZXkBxQe3sQ/Ux3HyneGGx2Z6nWRZS1T/0E7DfiUnOSh
         tB0JmpvO3/PMfdw7pEsfz5lhF+YvwHZMmxPFpD6oT44nXUdZBWb7TvX0yLS8Iy3l31ql
         bN0G6x9iB7Z2iWPJ23atcp9ZHC+0MCdOP7roi5FZhUkZ8Xu6vaRzuzj0yDcTy6O0wtv2
         k7TczfjpIcun4laPXNizNW9ymMvS7F6AFXEyMn5HukbZUkIa44gcSaj0BXawFoHVU9dE
         keKKwNunzugLtmAvRmIN/hNQD7o4n1b2pyzmtgK/sx+iWwTlJb2DDtH3nnfWpcqhbc4k
         3fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108594; x=1760713394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lru4V+cwKFfxLK/nzfZUd/f7wkQ+5dEE9KWoaatQVPo=;
        b=vNCMRgphQfyMOlKiJwqN6lFyDn5L70y8AAcqSotytosJvTbxrBDjF8necg7zz8YOK9
         off2mrRP7yyGZR31b4ykoemnLGn2xoPt7cy5Jr90mtqPKTZP5cJRnPK8mUFSt2sjfJV6
         8v94OJYFqDgM+3daGKNU6KKvTdo/XTQqC5nWJYye8czn0AHfUsUxp1RaRcmzO9Dvhp/y
         2m8juSyKtMj7GuYctD2pg5OkdBeMyMDkC+TrcEcPLJw6wJZbJZAZ9U08kTJfBrmLBNtW
         dnfYXjweFCz7q8xvqjS1TuMr3VETpCbY9qYBZjNmCbucQeLANDOC7fM6Y/kfzSuj1EJM
         Nxtw==
X-Forwarded-Encrypted: i=1; AJvYcCUbl2XjVLlH6P3dTpYmYoc0bLwDNqeAXH4BoVLb9vn3E41FzyJcxroZXj+QGCkhiP7/GuNHjYm2QyfogOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XAGdRa4SJ5WrRrkCCu1uS19nxMqaDUYbSbeB0FlOb7vTkZ/X
	WoqdrSE4RAwTDx7Bcv6b4nlHEh1lgnh7gy7W7f2V2Xc+ot3ImxhqYzId
X-Gm-Gg: ASbGnctHZpmSr5qRjfuiBfWpAs3ELQSmcLoNfKjP4A6fGwUop5tKDZjB0HhuMu37v7a
	HSKT6wHmYWhJ2z705KRCp8BpF0YpN2cEOWGhg6hc8n9QsTADmJ+45mWzcqLz5TDuIARgGtPEgiO
	LQemBaF5UYMHrYJGfIGBevD1jAyL8WCGflHnjF3QjNoZFbvhfVmRfwz3cM82W8qaIpV/V1Z+NDJ
	SqImHSUjtzj0bHRr7A0BXYNY4Pv+qqadVmWJW2/HNVyKEvRVSHJDSiRZdSQHr8T0jumnoXT5lrP
	gQ0Dny2dGSV5NUTbblxCNQZNTHyxo8gOumsGpM5phmKhnEgHUdzRVg/jXE20glpx/52KDoBIi+0
	9HqKiQXt1WeEgObkwiE8sld3a08IQnwsJ2Z+cgzjRggegxBdV8zfGPZy9LEW7PCyzmx5u
X-Google-Smtp-Source: AGHT+IHDmtdSQ4BVOHtxe7GHClewheJPvHGauzysjfnwSn3tHptitjBMctHoN7F9QTbHybnsnanBLA==
X-Received: by 2002:a05:6a00:391a:b0:77e:8130:fda with SMTP id d2e1a72fcca58-79385ddc9f9mr15581102b3a.13.1760108594064;
        Fri, 10 Oct 2025 08:03:14 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm3266359b3a.18.2025.10.10.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:03:13 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.1.y 03/12] clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
Date: Sat, 11 Oct 2025 00:02:43 +0900
Message-Id: <20251010150252.1115788-4-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010150252.1115788-1-aha310510@gmail.com>
References: <20251010150252.1115788-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 73737a5833ace25a8408b0d3b783637cb6bf29d1 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to arch_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20221106212702.002251651@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.409832154@goodmis.org/
Link: https://lore.kernel.org/r/20221110064146.981725531@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.574672568@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fee1c4bf1021..ddcbf2b19651 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -687,8 +687,8 @@ static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
 }
 
-static __always_inline int timer_shutdown(const int access,
-					  struct clock_event_device *clk)
+static __always_inline int arch_timer_shutdown(const int access,
+					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
@@ -701,22 +701,22 @@ static __always_inline int timer_shutdown(const int access,
 
 static int arch_timer_shutdown_virt(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
 }
 
 static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
 {
-	return timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
+	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
 }
 
 static __always_inline void set_next_event(const int access, unsigned long evt,
--

