Return-Path: <linux-kernel+bounces-756842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18958B1BA1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249BB17E118
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38DD29617D;
	Tue,  5 Aug 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pvk9NIeB"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE623ABB2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418745; cv=none; b=SPqbOuA0SJA83oHywvQIgQKACCgWNKzB1C0tiePJ8B4yBACFTyVCcs4umuzY3ATd+M6vZUk1G6d7zBRrBa9nf6DIGDpv3AspIPc8GaekGYMHAATvjddnz2GbqaiKiy0o7oAnJ9tD/1869dSeR2qoWuxPQOfNRykBiGN8ZIUDE1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418745; c=relaxed/simple;
	bh=KVDpod7q+Pi2GrZ4tTZC3rlWLE8oX80sFgkDCS2KkWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3icfV/SbzkOR6Q6M7Gms1cgUGbYyn4SdZBJ08SLAl1VEgmWk/Tbk0/Y9jLTPpsqG0XYpH4BufPnPK0rxR4Hh0cku1JgDn922ySFGZugrgCy3zvdOSsinJsEt1f9oamMmrEk1E95ZJs1ituezNzLWV2vONxfrXh9nxk4bS3npwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pvk9NIeB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so2537220b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754418743; x=1755023543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLWfr12pgjQ6FICNcNjnejxnQmEk/KleJ7fhxV5fuso=;
        b=Pvk9NIeBIYO7Zb10jCnQNbLInmjIkmkTQRVHEotUHtmNQwGn4i4yTC1caD6NcGLIb6
         sNx00rsi/29aURoJgQFICrGSu3fzAozjtQ74B8OvQocH5rohdlyGB9SIxIui70Xuv4I6
         dmClweIGGE5ZICouPe6XmdB/L3w4PuV85Fzls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754418743; x=1755023543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLWfr12pgjQ6FICNcNjnejxnQmEk/KleJ7fhxV5fuso=;
        b=wArIu0d4GsgasQVZXLhS7Bof8SUpiESnBj174pauBJzaLCrfp9TxFBtToMXZRFvUsm
         V5xqpIg04q351+66Yhct0egFwexmuuYvEIBsCgf7uFXlXhkh/EjG/VsoVuZ3zjphNe/Q
         AgHrgvCTBig7SA4PhuCdEWej/MnnjYFhh4NfXZeog7QMIMAfqAmfDZw6il4Nmb44MP7w
         NC8dlomekonbfBLuVti3epDTxYw0EbtbLLtRuWWYBtNQarGjLd/7qA2/cvundQ9TKVWb
         h/x2jGcpvudLuwJ3XDeNM5KA/tve8Vj7c3yXPw5apLo2QzE9OKhVWBIsehOgn4fwUNma
         ZzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJa5Iqv9xx6yVG+ZJftfy9a704QtFm3HCUOHsb0G2H0icj/Jb0Hf/3QMYCMav1kRrmNlgQ8GwNPRTKeqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBSb4+ahoSpjSMOBuAHUmw1ojAULeK2EHaaZXXcTXhpwmMYF6
	GrzNZQOD/6mN5sh0DEG3dN6t76vwQNV4zQkrEUtsHmC3SFe11GM/jGSaszpEcY3IrA==
X-Gm-Gg: ASbGncvsnttVDbhqTKOhAZgWnBfQvbCib/l5EAjOjkqXrzxcvnQOIIuh5War6CUr8pc
	HzJzU5i6R/Rg0igFUM+aBvMUkZJahVfqPeYGKJlPtR21eWoPIzRJ4VEMaZ/6cx+swO7IvLxVeZK
	Mdz3q2RRnLrYhVR79sA+S9kWJf0MIm6qwQmIi9WbwkHUj8Zqu92yFUdw6mxfZcHSf8ASDzAJsQQ
	IcAqd3dBcVGxebvQwPR9iA+TX/HBr7yuOTUYsx2zgrDzNe31cuE5J0lu5rvvhisT1fF0813T50n
	5+OEsmSHAJNSMY4f5rHarfgdXwOWV7Zvf93h7Zr04VkkOWGdJ6jnZABpn23QKKyF3ze5uvC3dXp
	LZT7QZQRxtdEWrOh5e1Byt4pxvlnO06BcDUCPLkj+AHhpauuq8OHBmV9tOFMvPcYGxFQAqQ==
X-Google-Smtp-Source: AGHT+IH8jfr94ztRq559ycNS7TAuQO/vdSoRkq8QonxCbAoGAJvBJk4zOFg2+yr/5Jcz8X8hIm/FqQ==
X-Received: by 2002:a05:6a20:938e:b0:23d:491b:76a6 with SMTP id adf61e73a8af0-24031379b10mr150530637.20.1754418742934;
        Tue, 05 Aug 2025 11:32:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:3cf0:dc1:508c:5a8a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b422bb0570bsm11698666a12.54.2025.08.05.11.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:32:22 -0700 (PDT)
Date: Tue, 5 Aug 2025 11:32:20 -0700
From: Brian Norris <briannorris@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tsai Sung-Fu <danielsftsai@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] genirq/test: Resolve irq lock inversion warnings
Message-ID: <aJJONEIoIiTSDMqc@google.com>
References: <20250522210837.4135244-1-briannorris@chromium.org>
 <31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net>

irq_shutdown_and_deactivate() is normally called with the descriptor
lock held, and interrupts disabled. Nested a few levels down, it grabs
the global irq_resend_lock. Lockdep rightfully complains [1].

Grab the descriptor lock, and disable interrupts, to resolve the
complaint.

Tested with:

  tools/testing/kunit/kunit.py run 'irq_test_cases*' \
      --arch x86_64 --qemu_args '-smp 2' \
      --kconfig_add CONFIG_DEBUG_KERNEL=y \
      --kconfig_add CONFIG_PROVE_LOCKING=y \
      --raw_output=all

[1]
========================================================
WARNING: possible irq lock inversion dependency detected
6.16.0-11743-g6bcdbd62bd56 #2 Tainted: G                 N
--------------------------------------------------------
kunit_try_catch/40 just changed the state of lock:
ffffffff898b1538 (irq_resend_lock){+...}-{2:2}, at: clear_irq_resend+0x14/0x70
but this lock was taken by another, HARDIRQ-safe lock in the past:
 (&irq_desc_lock_class){-.-.}-{2:2}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(irq_resend_lock);
                               local_irq_disable();
                               lock(&irq_desc_lock_class);
                               lock(irq_resend_lock);
  <Interrupt>
    lock(&irq_desc_lock_class);

[...]

 ... key      at: [<ffffffff898b1538>] irq_resend_lock+0x18/0x60
 ... acquired at:
   __lock_acquire+0x82b/0x2620
   lock_acquire+0xc7/0x2c0
   _raw_spin_lock+0x2b/0x40
   clear_irq_resend+0x14/0x70
   irq_shutdown_and_deactivate+0x29/0x80
   irq_shutdown_depth_test+0x1ce/0x600
   kunit_try_run_case+0x90/0x120
   kunit_generic_run_threadfn_adapter+0x1c/0x40
   kthread+0xf3/0x200
   ret_from_fork+0x140/0x1b0
   ret_from_fork_asm+0x1a/0x30

[    5.766715]     ok 2 irq_free_disabled_test
[    5.769030]
[    5.769106] ========================================================
[    5.769159] WARNING: possible irq lock inversion dependency detected
[    5.769355] 6.16.0-11743-g6bcdbd62bd56 #1 Tainted: G                 N
[    5.769413] --------------------------------------------------------
[    5.769465] kunit_try_catch/122 just changed the state of lock:
[    5.769532] ffffffffb81ace18 (irq_resend_lock){+...}-{2:2}, at: clear_irq_resend+0x14/0x70
[    5.769899] but this lock was taken by another, HARDIRQ-safe lock in the past:
[    5.769967]  (&irq_desc_lock_class){-.-.}-{2:2}
[    5.769989]
[    5.769989]
[    5.769989] and interrupts could create inverse lock ordering between them.
...
[    5.776956]  ret_from_fork_asm+0x1a/0x30
[    5.776983]  </TASK>
[    5.778916]     # irq_shutdown_depth_test: pass:1 fail:0 skip:0 total:1
[    5.778953]     ok 3 irq_shutdown_depth_test

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/31a761e4-8f81-40cf-aaf5-d220ba11911c@roeck-us.net/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

On Tue, Aug 05, 2025 at 10:45:33AM -0700, Guenter Roeck wrote:
> Hi Brian,
> 
> On Thu, May 22, 2025 at 02:08:01PM -0700, Brian Norris wrote:
> > * irq_shutdown_depth_test: exercises similar behavior from
> >   irq_cpuhotplug_test, but directly using irq_*() APIs instead of going
> >   through CPU hotplug. This still requires CONFIG_SMP, because
> >   managed-affinity is stubbed out (and not all APIs are even present)
> >   without it.
> > 
> This test triggers warning tracebacks for me.
[...]
> Is this on purpose ?

No. I think it's an artifact of trying to imitate CPU hotplug, but doing
so insufficiently. I believe the surrounding patch fixes things.

Let me know if it helps. Thanks for the report.

 kernel/irq/irq_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 5161b56a12f9..a75abebed7f2 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1+
 
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
@@ -134,7 +135,8 @@ static void irq_shutdown_depth_test(struct kunit *test)
 	disable_irq(virq);
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
-	irq_shutdown_and_deactivate(desc);
+	scoped_guard(raw_spinlock_irqsave, &desc->lock)
+		irq_shutdown_and_deactivate(desc);
 
 	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
 	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
-- 
2.50.1.565.gc32cd1483b-goog


