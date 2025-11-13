Return-Path: <linux-kernel+bounces-899079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13139C56B43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56DFE349598
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911E71F5EA;
	Thu, 13 Nov 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W6QqVEyP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F72D7384
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027584; cv=none; b=tiVZq/CXYi3LAQwpdzNWbTLwVSHAMuE1DGJBofd1SEXsmYXSU3RtFRhYHd3792D5/xqQilbd95JqlcQ27xfT5WvjW6UuTCTRo0jMaxxkPIKP7tFwwlGPyKm89wJwje1JCYPT0N2zajYorTUNRTVvaWCQaGVLDUUzgOSQVfg92Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027584; c=relaxed/simple;
	bh=6lCTspNXXG8TL9WsqkNOhLsjm8KE2uU5YJ523fQtSZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF/TBNQ/zzI8YJJqA3JVguVM5YLezsqXNMy9ZYi2yudR84TLaHXkhHEhu91Sgx+oFBRFA3myBkZvkVlLhy1XH32C066rlHjsZAYQkS6yql3B1bEZsv76AdMi20HBnxEYOh7S2PsX/7dlzpdgUPrYxuOQ4I2Q897HLm2Ly7DDozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W6QqVEyP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b73301e6ab5so75253966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763027580; x=1763632380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoBKw49AlIbvYgXLE0sUru9NF+Zm0xipHAylnS2PSy0=;
        b=W6QqVEyPDLZNa4Hq+5b29oXBqUZXpe3mc0drzEU/zvb1vTQCy76M9sN/MpMAYZZx7r
         Eaa1gJl1kJCXbuh+JS5pElR29Rg+3hgNZNN94NcXJxiDFlWlwbovnoaGPoYEBDpvTIRU
         TYVY81NpCoBxrXb3AAy3tFrm1c2VCOIw44PJ6/vyawYDQMPAm9S79+cUTXZOvcgqDbWS
         EQKQkmvZjxtodg6L5dnVRtBX25oVN9jnh6M/YO3MNvlgp/mWsQhqTPkq9xIwV8B+Sfxm
         vEQL1P9EI9LpGxHh7cxSieNMQyRPAFq/NQd1SUKKwcu3yS32QKxdJQM1P4T4tijq/6fc
         Narw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763027580; x=1763632380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoBKw49AlIbvYgXLE0sUru9NF+Zm0xipHAylnS2PSy0=;
        b=jJxoXnmhxKZ+bJ58n+XWEcOJ8EmWr2pZg3Gl24ZB7EUDBInk/8hYMxmxNOTcQNqed8
         l478cKHA3tNH/OUop/2645fJzF+jLZ2ghfDjmlxQb9un9NSwnA4n5HXe4GKlg9FnGr9o
         OerZ1X9HZQOXHpamrq+HcSQd0RpCPwZK39aK2cytJqm1+9bB+oGVC9E+Ht6bBgDfqbGU
         w25S4LhZWhPWXfVFEqmnIOSRW+it7JL0pGw6Sy9wO7mcYgELcQxMZLIeo5S66I4hUH1u
         u4Sy8FeyhODlC8+GHhOUSHo9dHXr/GAzj7fkJIXB+LS8jD1WjUFfoXT3C0upeg19V6xY
         aV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKF9Xk50mLGehwlkU82CsvRbPQNj0YEAv6l/GSqHSz83yXU7UDUfTzVLnm6YklQzDy+v/xIGcZQey0h4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDqkBvimN2qFvANkJceUJSym4muHZI8ifE/KAnqV5rLA9JFMX
	53UKv8UDoXTOCxRuUoxBPrl7fuwTclaIq54OtoSSJkU/xQ0PjFyiShgMhE3mAoqp5YE=
X-Gm-Gg: ASbGnctXW29DVy+S3dduUlpTWXQKEpQbz3a5QBwwO+0mhbuK5qdnL7fL7OaqIYjjDCp
	h1J0+o7znQ4XcEGzUoB3SaZojKKXvpJm5Qygp21TNlbpXlw8EAZvfeYa30MIFxfZTA88JcUEEhN
	/9CLYZI9Bqmi5Sg8H9b4ecRYzxH1GvIqv5XIOP+D449AEjOOEKSQ2lVX0aviB6P7trb0q9xLko7
	xadRQJlgX7JHWrUoU6t3Ry9ioRYEfE7kSgRip72d+uaBp0mmlwDWBDCoAdXnHGSqmkSD/u5ak/U
	ppcibUedAn+jZ3cdhmvcpXO0kL7faDWmEQmCKDZwqXje9F1nngWLsCLwCtsiwa6+Sb2NkuvYLNt
	PpwaYeOMl7fWR8Q44v1KCLhHCRVz5n772MRjZgVBMdcA7ncmQoSeuXHa7Tda5BKBqc1WTzjh5u4
	17LQE=
X-Google-Smtp-Source: AGHT+IFOOZDoUn3QUugRM7g5tlD93FfiRjUJwHjHjA6lHKsrk39VhVq0NmVwV5vw4rnJjMFTmaZSDQ==
X-Received: by 2002:a17:906:dc89:b0:b40:6e13:1a82 with SMTP id a640c23a62f3a-b7331a71aa5mr618089466b.26.1763027580379;
        Thu, 13 Nov 2025 01:53:00 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb12d55sm128460466b.33.2025.11.13.01.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:52:59 -0800 (PST)
Date: Thu, 13 Nov 2025 10:52:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <aRWqei9jA8gcM-sD@pathway.suse.cz>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
 <20251111144328.887159-2-john.ogness@linutronix.de>
 <aRNk8vLuvfOOlAjV@pathway>
 <87ldkb9rnl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkb9rnl.fsf@jogness.linutronix.de>

On Wed 2025-11-12 16:56:22, John Ogness wrote:
> On 2025-11-11, Petr Mladek <pmladek@suse.com> wrote:
> >> Introduce a new global variable @console_offload_blocked to flag
> >> when irq_work queueing is to be avoided. The flag is used by
> >> printk_get_console_flush_type() to avoid allowing deferred printing
> >> and switch NBCON consoles to atomic flushing. It is also used by
> >> vprintk_emit() to avoid klogd waking.
> >> 
> >> --- a/kernel/printk/internal.h
> >> +++ b/kernel/printk/internal.h
> >> @@ -230,6 +230,8 @@ struct console_flush_type {
> >>  	bool	legacy_offload;
> >>  };
> >>  
> >> +extern bool console_irqwork_blocked;
> >> +
> >>  /*
> >>   * Identify which console flushing methods should be used in the context of
> >>   * the caller.
> >> @@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  	switch (nbcon_get_default_prio()) {
> >>  	case NBCON_PRIO_NORMAL:
> >>  		if (have_nbcon_console && !have_boot_console) {
> >> -			if (printk_kthreads_running)
> >> +			if (printk_kthreads_running && !console_irqwork_blocked)
> >>  				ft->nbcon_offload = true;
> >>  			else
> >>  				ft->nbcon_atomic = true;
> >> @@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  		if (have_legacy_console || have_boot_console) {
> >>  			if (!is_printk_legacy_deferred())
> >>  				ft->legacy_direct = true;
> >> -			else
> >> +			else if (!console_irqwork_blocked)
> >>  				ft->legacy_offload = true;
> >>  		}
> >>  		break;
> >
> > This is one possibility.
> >
> > Another possibility would be to block the irq work
> > directly in defer_console_output() and wake_up_klogd().
> > It would handle all situations, including printk_trigger_flush()
> > or defer_console_output().
> >
> > Or is there any reason, why these two call paths are not handled?
> 
> My intention was to focus only on irq_work triggered directly by
> printk() calls as well as transitioning NBCON from threaded to direct.
> 
> > I do not have strong opinion. This patch makes it more explicit
> > when defer_console_output() or wake_up_klogd() is called.
> >
> > If we move the check into defer_console_output() or wake_up_klogd(),
> > it would hide the behavior. But it will make the API more safe
> > to use. And wake_up_klogd() is even exported via <linux/printk.h>.
> 
> Earlier test versions of this patch did exactly as you are suggesting
> here. But I felt like "properly avoiding" deferred/offloaded printing
> via printk_get_console_flush_type() (rather than just hacking
> irq_work_queue() callers to abort) was a cleaner solution. Especially
> since printk_get_console_flush_type() modifications were needed anyway
> in order to transition NBCON from threaded to direct.

I see.

> >> @@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
> >>  		if (have_legacy_console || have_boot_console) {
> >>  			if (!is_printk_legacy_deferred())
> >>  				ft->legacy_direct = true;
> >> -			else
> >> +			else if (!console_irqwork_blocked)
> >>  				ft->legacy_offload = true;
> >
> > This change won't be needed if we move the check into
> > defer_console_output() and wake_up_klogd().
> >
> >>  		}
> >>  		break;
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 5aee9ffb16b9a..94fc4a8662d4b 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
> >>  
> >>  	if (ft.legacy_offload)
> >>  		defer_console_output();
> >> -	else
> >> +	else if (!console_irqwork_blocked)
> >>  		wake_up_klogd();
> >
> > Same here.
> >
> >>  
> >>  	return printed_len;
> 
> I would prefer to keep all the printk_get_console_flush_type() changes
> since it returns proper available flush type information. If you would
> like to _additionally_ short-circuit __wake_up_klogd() and
> nbcon_kthreads_wake() in order to avoid all possible irq_work queueing,
> I would be OK with that.

Combining both approaches might be a bit messy. Some code paths might
work correctly because of the explicit check and some just by chance.

But I got an idea. We could add a warning into __wake_up_klogd()
and nbcon_kthreads_wake() to report when they are called unexpectedly.

And we should also prevent calling it from lib/nmi_backtrace.c.

I played with it and came up with the following changes on
top of this patch:

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 45c663124c9b..71e31b908ad1 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -203,6 +203,7 @@ void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
+void printk_try_flush(void);
 void printk_trigger_flush(void);
 void console_try_replay_all(void);
 void printk_legacy_allow_panic_sync(void);
@@ -299,6 +300,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
 static inline void dump_stack(void)
 {
 }
+static inline void printk_try_flush(void)
+{
+}
 static inline void printk_trigger_flush(void)
 {
 }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ffd5a2593306..a09b8502e507 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1302,6 +1302,13 @@ void nbcon_kthreads_wake(void)
 	if (!printk_kthreads_running)
 		return;
 
+	/*
+	 * Nobody is allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		if (!(console_srcu_read_flags(con) & CON_NBCON))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 334b4edff08c..e9290c418d12 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4581,6 +4581,13 @@ static void __wake_up_klogd(int val)
 	if (!printk_percpu_data_ready())
 		return;
 
+	/*
+	 * Nobody is allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	preempt_disable();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
@@ -4637,6 +4644,21 @@ void defer_console_output(void)
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
 }
 
+void printk_try_flush(void)
+{
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
+	if (ft.legacy_direct) {
+		if (console_trylock())
+			console_unlock();
+	}
+	if (ft.legacy_offload)
+		defer_console_output();
+}
+
 void printk_trigger_flush(void)
 {
 	defer_console_output();
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 33c154264bfe..632bbc28cb79 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -78,10 +78,10 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	nmi_backtrace_stall_check(to_cpumask(backtrace_mask));
 
 	/*
-	 * Force flush any remote buffers that might be stuck in IRQ context
+	 * Try flushing messages added CPUs which might be stuck in IRQ context
 	 * and therefore could not run their irq_work.
 	 */
-	printk_trigger_flush();
+	printk_try_flush();
 
 	clear_bit_unlock(0, &backtrace_flag);
 	put_cpu();

How does it look, please?

Best Regards,
Petr

