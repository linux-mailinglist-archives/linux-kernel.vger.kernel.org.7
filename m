Return-Path: <linux-kernel+bounces-764855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3FB227F0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0EC3A9F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995328314E;
	Tue, 12 Aug 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LeZ6a8lQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65D18C332
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003822; cv=none; b=WsGta4cvzQZMgVr3+xbs+B1EQ6ewUz4YUqxV5wBebnp0Tl1jIx9zKOIn6dzrbg1pglHddGBrzsjSHpSdBz8WoLKEkD/nCpRb3F+JQryaZKISvqzTuOFIIYZCSTJbPsWzAgYUN60tnFLjbahZnK2ygIJiXpNqh0BxvW4gXcRL/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003822; c=relaxed/simple;
	bh=NWSS4a2G2NKaVEP9oDMsrO8svRwz9OznEItOp9TqNro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL+kEKO8b0F2Ctu7K/MgAgTfzEMMhASYNHLCj6WVi801S3Kk3zE7PBEEiItsPfDFERd9Mi2ODB4eHoaXK1FV7cdGR0XiOfF1iQOBKHN1bDn3JdJTlryBF+fdFcZOtjXlA2HgDp9+Qa95+BLpMUtFhRZVdiGnDBwY4WehMxeNtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LeZ6a8lQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af9a25f091fso729420066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755003818; x=1755608618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLLv2nQBHEJR+g91v7U9odPGsbP2CfasOVGwt0Y+qpc=;
        b=LeZ6a8lQTVq8/DXzeB2aBGghGIVWE3Nl3sOFgRccd+Dz1JEkdjsJZqrLIuoI2jkjmH
         44Cs6oVgSOMVjUis3mcrouPa9lyvm8IK3IYqKZ9zGNXTQWB4M/2k+8H0NQz0GYfrp+qu
         t4oI8PU4YA66QDG7m/Bq2oXjXQLvSvpKz06YZ94eP5CqKo5vyQl7DThavev6tCVS4JKu
         htAtScm8rHfDl8xxnZT6EhQHZZK7K/nYN5xM5/aNKI4k/jEOnC3CjjR/dlXoYGrUp4j2
         CEZa3mW7nWXtgZZVjJCXcZXNBxUgAfnttfxy4oYYio4D13SP8RiPWXsLQLHbqxEWhIV5
         k3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003818; x=1755608618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLLv2nQBHEJR+g91v7U9odPGsbP2CfasOVGwt0Y+qpc=;
        b=eWUwcCbeo0cyE2L3YQaEEUKUoL9mSgXU1foXtFtnXS54aZIRLYwBZx5rKoRC7K+YZY
         x5MZwRYsrhjNVWitfhhRttZ1b1sgG1bCpe+xtVAJUE9k9K7jS302W4D1puHo/Z+MbTc2
         I/9hp52nRfRwUo+idvcsZjuduRVgl4DKoSEenzLjXWCwjSqXVdRYVrycPKHleD49iPTd
         zHnM+UJIfjL9v+UMrRJPNZkxU4SsJmyjDkO25LpkhOT7trWoNowE/Q6MGUpKZ+3lmBy5
         ovw64CdHXqUVcADdHjvz+g7f7s7P5WKEOoshLlCgrDLrDeZkY/YdTar2zBejdbi9FTZS
         BKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC9QT/KV83c8S9SQ9PB7hIropBOnQ3YZmT06aKnmF0wPdL5vybjwte8EsCMmjfQvgm5UMQ8W0X03R2jCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMzGgvxveWRFN6Npt+H7Sjr8IJUt0PiKA+NlGclyiNvCS0Hc4
	lSIBMJ7uGy41pXrPyRzbJrsbgRwCPdMF+fIQASvsOHAl1zLb2N4Eqlqkc4CHzMloRRM=
X-Gm-Gg: ASbGnctR8Rx4EoX+m5EOSmq3P5I6TA0i6wU6Y22GkZbAcOVmX2+HR0j9TmS0MbXjkMu
	K3mLqyu72Br7nTKF4R/+P9cs5S9ZdvXpEWMGVAVzvBdd9AC0L05X5XpQCe4xHJuhZkPn70rl0kF
	teOTmqtbMpIYdMgI5bNe8jxXjy7JgV9l1bKwFhloi8dzrY2nrtGhmU9lWQFFgJiRO9sBh/lyANK
	ccXecYASXBUr66yHPJUUtNhBnHcyhZtrlhNZTKmdESPZxDbuI98v4nTe3DxOaLprtDCN9W1SFrz
	vZZKvzrGUu7wdT/usU7uZe+XzdVSkluXfqX02qtWq5QLyl1rIR0/mxpDj4ohOZNCF4w+lrVqL05
	6YcfcbZQkd0QW/Q==
X-Google-Smtp-Source: AGHT+IHlRdaXUminR2OCXZx9Ym5MYMunUmi2u9CABsSYGs/XeuBz8XNM0vrBe6skfAEpL9la7K68Dw==
X-Received: by 2002:a17:906:99c2:b0:afa:1be7:3136 with SMTP id a640c23a62f3a-afa1e1194f9mr282036066b.51.1755003817773;
        Tue, 12 Aug 2025 06:03:37 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a396fsm2208318066b.42.2025.08.12.06.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:03:37 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:03:35 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
Message-ID: <aJs7p_UjPIfb_XYd@pathway>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
 <84seichm5t.fsf@jogness.linutronix.de>
 <2kwymhiz4fcozfmbmj6ju2qatsbmnrtiidfa4nxrqutgwa6xfy@dbf3caohbbay>
 <84pldghkho.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84pldghkho.fsf@jogness.linutronix.de>

On Thu 2025-07-31 09:51:07, John Ogness wrote:
> On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > On (25/07/31 09:15), John Ogness wrote:
> >> On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >> > SYS_INFO_ALL_CPU_BT sends NMI backtrace request to
> >> > all CPUs, which dumps an extra backtrace on panic CPU.
> >> 
> >> Isn't this only true if CONFIG_DEBUG_BUGVERBOSE=y?
> >
> > Are you referring to vpanic()->dump_stack()?
> 
> Yes.
> 
> > Another way to get backtrace on panic CPU is via BUG(), which routes
> > through die()->__die_body(), which prints registers, stack trace,
> > and so on, before it calls into panic().  This might be x86 specific,
> > though.
> 
> So in that case you see 2 stack traces if CONFIG_DEBUG_BUGVERBOSE=y?
> 
> >> Also, the information is not the same. trigger_all_cpu_backtrace() will
> >> also dump the registers. For CONFIG_DEBUG_BUGVERBOSE=y on the panic CPU,
> >> only the stack is dumped.

IMHO, this is actually not true, see the following code:

void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
				   int exclude_cpu,
				   void (*raise)(cpumask_t *mask))
{
[...]
	/*
	 * Don't try to send an NMI to this cpu; it may work on some
	 * architectures, but on others it may not, and we'll get
	 * information at least as useful just by doing a dump_stack() here.
	 * Note that nmi_cpu_backtrace(NULL) will clear the cpu bit.
	 */
	if (cpumask_test_cpu(this_cpu, to_cpumask(backtrace_mask)))
		nmi_cpu_backtrace(NULL);
[...]
}

, where

bool nmi_cpu_backtrace(struct pt_regs *regs)
{
[...]
			if (regs)
				show_regs(regs);
			else
				dump_stack();
[...]
}

So, I think that the following patch should not make it worse:

diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..dfbfe1ce7bfc 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -67,6 +67,7 @@ static unsigned int warn_limit __read_mostly;
 static bool panic_console_replay;
 
 bool panic_triggering_all_cpu_backtrace;
+bool panic_this_cpu_backtrace_printed;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -328,6 +329,22 @@ void check_panic_on_warn(const char *origin)
 		      origin, limit);
 }
 
+static void panic_trigger_all_cpu_backtraces(void)
+{
+	/* Temporary allow non-panic CPUs to write their backtraces. */
+	panic_triggering_all_cpu_backtrace = true;
+
+	if (panic_this_cpu_backtrace_printed) {
+		int this_cpu = raw_smp_processor_id();
+
+		trigger_allbutcpu_cpu_backtrace(this_cpu);
+	} else {
+		trigger_all_cpu_backtrace();
+	}
+
+	panic_triggering_all_cpu_backtrace = false;
+}
+
 /*
  * Helper that triggers the NMI backtrace (if set in panic_print)
  * and then performs the secondary CPUs shutdown - we cannot have
@@ -335,12 +352,8 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_CPU_BT) {
-		/* Temporary allow non-panic CPUs to write their backtraces. */
-		panic_triggering_all_cpu_backtrace = true;
-		trigger_all_cpu_backtrace();
-		panic_triggering_all_cpu_backtrace = false;
-	}
+	if (panic_print & SYS_INFO_ALL_CPU_BT)
+		panic_trigger_all_cpu_backtraces();
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
@@ -422,13 +435,15 @@ void vpanic(const char *fmt, va_list args)
 		buf[len - 1] = '\0';
 
 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
-#ifdef CONFIG_DEBUG_BUGVERBOSE
 	/*
 	 * Avoid nested stack-dumping if a panic occurs during oops processing
 	 */
-	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
+	if (test_taint(TAINT_DIE) || oops_in_progress > 1) {
+		panic_this_cpu_backtrace_printed = true;
+	} else if (IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) {
 		dump_stack();
-#endif
+		panic_this_cpu_backtrace_printed = true;
+	}
 
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all


> > Hmm, it's getting complicated, probably isn't worth it then.
> 
> I think it is worth cleaning up, but it probably won't be such a simple
> fix. All call paths of redundant stack trace printing should be
> identified and then we can decide on a clean solution.

I feel that the check

+	if (test_taint(TAINT_DIE) || oops_in_progress > 1) {

is kind of a hack. It would be nice to make it cleaner. But I am not
sure how complicated it would be.

Anyway, I think that storing the information, whether the backtrace
was printed or not, into a global variable, is a step in the right
direction.

Best Regards,
Petr

