Return-Path: <linux-kernel+bounces-681838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F7AD57ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E43D1886DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489C328C028;
	Wed, 11 Jun 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XepqDvdB"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219428A3FA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650571; cv=none; b=LJxGp4Nfat65tkFDvXY2LmuZTJT9RDHq3HJo/1NiOCAL1GoRfdJi7rWf8dvyIUXUSPfypQNEVP+h9N+qVxB2XZfaFmnk2DJqHRNlKvL1Q+VRuygnP05wnP51jyu9cZen46Tl5RiyY8my24o+MkkMEeUwf6nrflo2z9iJs6lNAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650571; c=relaxed/simple;
	bh=o0u+MzreQqxmxPcaJUgkWIV6t2qZ1GoGgCoKawHBveg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjTUnAoqqYhSKfvcotsVy+fdRi5+Nm1Muck4qlHbPfk6Lvjm8bYinFStGHz3Wq77+rCCT+uDKeZ4fW/5MCjRsfy7NUm1pASLQGpdB+EzRMP7/4TzjREDSmV3yU2U4T0CpN6Uo3Ae0fO8Bv8Zgj4py3XZIaXRHYIWDSUvKOONJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XepqDvdB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5533302b49bso6978142e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749650567; x=1750255367; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zIB46TLcdDazaxx/FuNPRf75NEIO/odsUpYD0AT+6kA=;
        b=XepqDvdBtcxc3CPq4F4lWTTBHxXeU9X3HT1HpoiHhSw4KBa+gNM3ht8A47XRIPApiZ
         DubE7ovff0DukGKLTJvquWOJIxYRdJFA7NxE2sfhbkKG7v92HmUzyZA4sKFjaKfQxxVM
         CdeC7t82QIfhszQ2T4RvLo57iB/YMTUHwE2byMZ7rkyCR2nuF7mkhD+ZcOsBXXNMb3Db
         bjI4XlSQlM7Kxt9KY1QwNLAVsQZG1ft0h1BiaXRD70Nj75LT7ZsC8aqe0wL3I3UvlaJe
         pzd73ADMjRpv85YJlQk3s+Na2UZwHVWist/yO/0hlFQ/RZmPqGQEfjdXhy5WRWRs55JC
         /f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650567; x=1750255367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIB46TLcdDazaxx/FuNPRf75NEIO/odsUpYD0AT+6kA=;
        b=FXyNdiEemEcIwPJaVJd0tANQUlLeb2jQA78PahMijxTCSoZODPFjk8yqnjyNXPdP9n
         XY10IimyKfEcgx4SncqnzDO90312AgLTbnvYH44l6PWIHBw3831tRmW0iWv5i4IiN5JH
         GLCdOAUK5p5rV/MyfHQUwGdd2sMewhxs8yPn33wgUTGMrSxN8YmZ+OuSQ6ei2oOpHYXc
         unqr6uvhFN3hJ5GQqDGUXYumd3Tk5rKo4I317FDuq1Mu79jOSchGZKI8Gmr0TIileYMj
         aWoVi5e0kvv/wOMpoEXsXQ/TTAhKMR/YlDjYNBy36YN0rjUsX3F4SiRrGYz+0O/94/c+
         eQCA==
X-Forwarded-Encrypted: i=1; AJvYcCXY8gnrmZgFHQB+ScDjeRf1kLTKabHy38YcFICtaQMVj1V3KB/nSsuN5yYaHV7Ea+PvJ4vYMUJkBldZIKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXiZTtc8K/qPt1eLqaWc58Wp739ax/bvv/vGGLiBAXUEFhNvu
	BOYqDk0ShUU0U1dQMe0LWad812SQkz52kPQ/r0vi4qkvT9qqpKpkPcQWajAWGgtyyZs=
X-Gm-Gg: ASbGncvekol3+SyK2hKlBcu41a5lyns+vXQsHc6ZO4GjAjq602rUAT8fIhm8U+Ympvm
	Frn0ndbSh9FZuI6lpq2l9HWEmrkt/LOShGDLLvYosdIoNLXOLL9xhsd74yn5DeCu1Rnt9SmHb8T
	cyhLa/VeIh24ulN3pJJjNHXBJbNvoEm3DiYAKBXszFvI2+7oaeT4v9BTALMhJkLlOHDmJ8utAFe
	rH3UmceGAfi2AXvWWAp0cjW47ZgF/ZeOyt7p14GpPwz18XE6ZwprTBtKFElw35jndBvnKvQGXQm
	rc0ISbPXDYolL8j6IWLde3yagS50PqBooPcZnVrHkRHB0YeTQEleLWY9u38tN0Sr
X-Google-Smtp-Source: AGHT+IHK5Hj5K2xpl++HknaoG+eNqzmM14dC11o00vR+KIbIAlNp6iIr3v3/hhPXrslVcqxUmQzq9Q==
X-Received: by 2002:a19:f605:0:b0:553:a2dc:6624 with SMTP id 2adb3069b0e04-553a2dc66fcmr194189e87.7.1749650565346;
        Wed, 11 Jun 2025 07:02:45 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7ab09sm9520720b3a.58.2025.06.11.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:02:44 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:02:30 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <jogness@linutronix.de>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] printk: ringbuffer: Add KUnit test
Message-ID: <aEmMdirOERyv8COG@pathway.suse.cz>
References: <20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506-printk-ringbuffer-test-v2-1-152200569eb1@linutronix.de>

On Tue 2025-05-06 13:58:48, Thomas Wei�schuh wrote:
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Wei�schuh <thomas.weissschuh@linutronix.de>
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1685,6 +1686,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  	memset(r, 0, sizeof(*r));
>  	return false;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(prb_reserve);
>
>  /* Commit the data (possibly finalizing it) and restore interrupts. */
>  static void _prb_commit(struct prb_reserved_entry *e, unsigned long state_val)

[...]

I had to add:

@@ -2337,6 +2337,7 @@ void prb_init(struct printk_ringbuffer *rb,
 	infos[0].seq = -(u64)_DESCS_COUNT(descbits);
 	infos[_DESCS_COUNT(descbits) - 1].seq = 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_init);
 
 /**
  * prb_record_text_space() - Query the full actual used ringbuffer space for

> diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0d60b2273b710b9b7ecf41b37503beeb76703054
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> @@ -0,0 +1,292 @@

[...]

> +struct prbtest_wakeup_timer {
> +	struct timer_list timer;
> +	struct task_struct *task;
> +};
> +
> +static void prbtest_wakeup_callback(struct timer_list *timer)
> +{
> +	struct prbtest_wakeup_timer *wakeup = from_timer(wakeup, timer, timer);

Just for record. The function from_timer() has been renamed
to timer_container_of() by the commit 41cb08555c4164996
("treewide, timers: Rename from_timer() to timer_container_of()")
in v6.16-rc1.

> +	set_tsk_thread_flag(wakeup->task, TIF_NOTIFY_SIGNAL);
> +	wake_up_process(wakeup->task);
> +}
> +
> +static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_ms)
> +{
> +	struct prbtest_wakeup_timer wakeup;
> +	char text_buf[MAX_PRB_RECORD_SIZE];
> +	unsigned long count = 0;
> +	struct printk_info info;
> +	struct printk_record r;
> +	u64 seq = 0;
> +
> +	wakeup.task = current;
> +	timer_setup_on_stack(&wakeup.timer, prbtest_wakeup_callback, 0);
> +	mod_timer(&wakeup.timer, jiffies + msecs_to_jiffies(timeout_ms));
> +
> +	prb_rec_init_rd(&r, &info, text_buf, sizeof(text_buf));
> +
> +	kunit_info(test_data->test, "start reader\n");
> +
> +	while (!wait_event_interruptible(test_data->new_record_wait,
> +					 prb_read_valid(test_data->ringbuffer, seq, &r))) {
> +		/* check/track the sequence */
> +		if (info.seq < seq)
> +			KUNIT_FAIL(test_data->test, "BAD SEQ READ: request=%llu read=%llu\n",
> +				   seq, info.seq);
> +
> +		if (!prbtest_check_data((struct prbtest_rbdata *)r.text_buf))
> +			prbtest_fail_record(test_data->test,
> +					    (struct prbtest_rbdata *)r.text_buf, info.seq);
> +
> +		if ((count++ & 0x3fff) == 0)
> +			cond_resched();
> +
> +		seq = info.seq + 1;
> +	}
> +
> +	timer_delete_sync(&wakeup.timer);
> +	destroy_timer_on_stack(&wakeup.timer);

Also this function has been renamed by the commit
aad823aa3a7d675a8d0 ("treewide, timers: Rename
destroy_timer_on_stack() as timer_destroy_on_stack()")
in v6.16-rc1.

> +
> +	kunit_info(test_data->test, "end reader: read=%lu seq=%llu\n", count, info.seq);
> +
> +	return 0;
> +}

[...]

> +static void test_readerwriter(struct kunit *test)
> +{
> +	/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
> +	DEFINE_PRINTKRB(test_rb, 8, 5);
> +
> +	struct prbtest_thread_data *thread_data;
> +	struct prbtest_data *test_data;
> +	struct task_struct *thread;
> +	cpumask_t test_cpus;
> +	int cpu, reader_cpu;
> +
> +	cpus_read_lock();
> +	/*
> +	 * Failure of KUNIT_ASSERT() kills the current task
> +	 * so it can not be called while the CPU hotplug lock is held.
> +	 * Instead use a snapshot of the online CPUs.
> +	 * If they change during test execution it is unfortunate but not a grave error.
> +	 */
> +	cpumask_copy(&test_cpus, cpu_online_mask);
> +	cpus_read_unlock();
> +
> +	/* One CPU is for the reader, all others are writers */
> +	reader_cpu = cpumask_first(&test_cpus);
> +	if (cpumask_weight(&test_cpus) == 1)
> +		kunit_warn(test, "more than one CPU is recommended");
> +	else
> +		cpumask_clear_cpu(reader_cpu, &test_cpus);
> +

I was curious why the reinit (below) was needed. We did not need this for
the default printk log buffer (printk_rb_static).

My understanding is that we need this because the unit test might be
started more times. It might be worth a comment. Something like:

	/* KUnit tests cat be re-started more times. */
> +	prbtest_prb_reinit(&test_rb);
> +
> +	test_data = kunit_kmalloc(test, sizeof(*test_data), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, test_data);
> +	test_data->test = test;
> +	test_data->ringbuffer = &test_rb;
> +	init_waitqueue_head(&test_data->new_record_wait);
> +
> +	kunit_info(test, "running for %lu ms\n", runtime_ms);
> +
> +	for_each_cpu(cpu, &test_cpus) {
> +		thread_data = kunit_kmalloc(test, sizeof(*thread_data), GFP_KERNEL);
> +		KUNIT_ASSERT_NOT_NULL(test, thread_data);
> +		thread_data->test_data = test_data;
> +		thread_data->num = cpu;
> +
> +		thread = kthread_run_on_cpu(prbtest_writer, thread_data, cpu,
> +					    "prbtest writer %u");
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, thread);
> +		prbtest_add_kthread_cleanup(test, thread);
> +	}
> +
> +	kunit_info(test, "starting test\n");
> +
> +	set_cpus_allowed_ptr(current, cpumask_of(reader_cpu));
> +	prbtest_reader(test_data, runtime_ms);
> +
> +	kunit_info(test, "completed test\n");
> +}

Otherwise, it looks good to me.

I would push it with the timer API renames so that it works in
Linus' master and linux-next out of box. So, with the following
changes:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 7d75cf2e15c6..bc811de18316 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2337,6 +2337,7 @@ void prb_init(struct printk_ringbuffer *rb,
 	infos[0].seq = -(u64)_DESCS_COUNT(descbits);
 	infos[_DESCS_COUNT(descbits) - 1].seq = 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(prb_init);
 
 /**
  * prb_record_text_space() - Query the full actual used ringbuffer space for
diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
index 0d60b2273b71..6a24294b85f5 100644
--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -153,7 +153,7 @@ struct prbtest_wakeup_timer {
 
 static void prbtest_wakeup_callback(struct timer_list *timer)
 {
-	struct prbtest_wakeup_timer *wakeup = from_timer(wakeup, timer, timer);
+	struct prbtest_wakeup_timer *wakeup = timer_container_of(wakeup, timer, timer);
 
 	set_tsk_thread_flag(wakeup->task, TIF_NOTIFY_SIGNAL);
 	wake_up_process(wakeup->task);
@@ -194,7 +194,7 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
 	}
 
 	timer_delete_sync(&wakeup.timer);
-	destroy_timer_on_stack(&wakeup.timer);
+	timer_destroy_on_stack(&wakeup.timer);
 
 	kunit_info(test_data->test, "end reader: read=%lu seq=%llu\n", count, info.seq);
 
@@ -245,6 +245,7 @@ static void test_readerwriter(struct kunit *test)
 	else
 		cpumask_clear_cpu(reader_cpu, &test_cpus);
 
+	/* KUnit test can get restarted more times. */
 	prbtest_prb_reinit(&test_rb);
 
 	test_data = kunit_kmalloc(test, sizeof(*test_data), GFP_KERNEL);


Best Regards,
Petr

