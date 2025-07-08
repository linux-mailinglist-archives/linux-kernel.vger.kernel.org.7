Return-Path: <linux-kernel+bounces-721761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5AAFCD83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D055664EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A582E11A5;
	Tue,  8 Jul 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzVEIFkL"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898A2E041E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984704; cv=none; b=DPxrFSmKob41/bHAor0yb8xZ5UKACthIoenRWSyzmJmbCDjVKDg6wyeFQkonsMiXzAwAB86td7KT/tlMXblmc+vVIaOvPsB+1v9IAZuINDRF1s0uVuitT3fFoPPvDM3kaK9xl/+XZj7KwHToJyJegEebeKoqm0pvtIsQX3bih5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984704; c=relaxed/simple;
	bh=47sMeezCkfD7BpmYxS/tUpV+p5t2PAyjflbnzmAsGmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxsITtRif2Hn8ycSRG4IBzqgaSusOgpxsoZzEjtGxQvlYG4EErcJEBS7op4nOoTxlHIUlTL+6Z35Wj1y1gNgtcV8atOL8AO7P41+mfub3GUqZD3e8yo1IZKQ0AbCJgHgqg9hpPLy75GjFJnOjlWJpUi0OBJsaykD9fqpHkty0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzVEIFkL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3341054f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751984701; x=1752589501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YpG3scJ3Np9QEUPPCVmqEg3Q5rZcnXDIMT/gTqWl5i8=;
        b=JzVEIFkLDHqcCTe+N5gm3FZYXKUN2tlXYY9mj6O7IQVyzUFjUegYsxMrQVVUB0MM5B
         NW/BUfnr2eyGm7+8V3ROR3znq6XSiqVA7TgBpBLUSQS2MvRB3lhFq3Efsi8i3aNoCfu5
         HfwMb5y+l4V3w7AjWZgGea49DmataQbqU19zqhmkZv2CpsO90nsVh7TLRhxi0ZPsmdO3
         i0t+xbIHbXvRX60202Te91Ax1VTMQk/tSca9eEQWjQ4mzlVQUH0E3PxHb+CHStHWZY01
         5ypdwky7L9POUlvz5APOw708xcBYb5Y8SyVtRPujx/tQNniHf5RCxxE7VeyzOxgycIcN
         hEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984701; x=1752589501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpG3scJ3Np9QEUPPCVmqEg3Q5rZcnXDIMT/gTqWl5i8=;
        b=rZZoiky8a+b20fHKWyzIrHtv3LAO/snUroHoHr29/DiphorIfPEbih1Yi7Ri2g/mSq
         TU00mGN4pPWK0GFT9pkEBArZfhSVe5hAd40sg+cMwX8jEx0mV7sQYYjVsv6Gc+ws4/u2
         s0o9fAYtCxWJ1E/siVIg0DoogtqqyQYhbls2VgRdJiDK6JiitQetDkCTfh+DhxF72xvj
         ww0xwlXzndg6JJ4InukaFyaBYZCm2T/gv9FuK9TG2zvj6LSLEwqDDBLlfmfySyAP2U/x
         lyhkTXALwniI/d0fsB1XUFEGlzclp5v1NvGpT0V/GuOo/8sboS8b/Sv4Zy8+mHsrVOsm
         P4nw==
X-Forwarded-Encrypted: i=1; AJvYcCXnUFC88LFoajFxpNaT+FbqGTR+7NPsSbqj+eXveJIBgdgi1A+rp/j9mKE88WLzGm/Q2ZzofOnHFDHpon4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYV6X62ocVAEhmOqq7Vk9PyabOww+sa7eOQW/pEe8HXF1Ybffa
	CTwenpzjHS4+AEWUXTD43PwJ9850lWZvch6bYPzzhNfuw1Bpt1QwOTTJ5/0XQXZmISQ=
X-Gm-Gg: ASbGncsl9yGV89H5xRjcPNWU4r8DUQk1B1E7OqOn+GUx5ZIRGnzM2kCr058iPpeNyyl
	CrOo+yhWNEMyBPUIWe4Ut9UOZgbmruJXcEv6zctECdSkq/Q9uEH/9FNaDbkOuWN5cA69Ybuoeua
	IYGWCd9FxQPxNDPFt4biSm8k+riKAYF34eF/YZiI9oP0khx/H6oy8XESbi9+tsbzVqmL8Zc/oVB
	jMwfTQ8y7x2sEkP+Ej0xmsEbk+frYEmqflUJhSgh96tVn2qOk/CpnA9ZK5UPA7DT7aj3ugP6LCi
	8E5SGcd04RjwYXn4dtD8kGAM+smVdIJiSknIX8j996bLA1gdsTXv0dnUNOW5IMNW
X-Google-Smtp-Source: AGHT+IEymzRvPZkwJUFRSR10rZv1xLWU8N2unb76TA0g+rPIrc6wJMjUMy01VtJ0OvHT3jK2NCdVsw==
X-Received: by 2002:a05:6000:2d10:b0:3b4:9c09:1aa2 with SMTP id ffacd0b85a97d-3b49c091dbbmr6654462f8f.13.1751984700864;
        Tue, 08 Jul 2025 07:25:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359d642sm12433730b3a.22.2025.07.08.07.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:25:00 -0700 (PDT)
Date: Tue, 8 Jul 2025 16:24:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <aG0qLaeAoTGaRs0n@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com>
 <20250702202835.GA593751@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702202835.GA593751@ax162>

On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > For large values of CONFIG_NR_CPUS, the newly added kunit test fails
> > to build:
> > 
> > kernel/printk/printk_ringbuffer_kunit_test.c: In function 'test_readerwriter':
> > kernel/printk/printk_ringbuffer_kunit_test.c:279:1: error: the frame size of 1432 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> > 
> > Change this to use cpumask_var_t and allocate it dynamically when
> > CONFIG_CPUMASK_OFFSTACK is set.
> > 
> > Fixes: 5ea2bcdfbf46 ("printk: ringbuffer: Add KUnit test")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > [pmladek@suse.com: Correctly handle allocation failures and freeing using KUnit test API.]
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  kernel/printk/printk_ringbuffer_kunit_test.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/printk/printk_ringbuffer_kunit_test.c b/kernel/printk/printk_ringbuffer_kunit_test.c
> > index 217dcc14670c..0c3030fde8c2 100644
> > --- a/kernel/printk/printk_ringbuffer_kunit_test.c
> > +++ b/kernel/printk/printk_ringbuffer_kunit_test.c
> > @@ -216,6 +216,7 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
> >  	return 0;
> >  }
> >  
> > +KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
> 
> This appears to break the build for me when CONFIG_CPUMASK_OFFSTACK is not
> set, like when enabling this test on top of x86_64 defconfig:
> 
>   In file included from kernel/printk/printk_ringbuffer_kunit_test.c:14:
>   kernel/printk/printk_ringbuffer_kunit_test.c: In function 'prbtest_cpumask_cleanup':
>   include/kunit/resource.h:409:32: error: cast specifies array type
>     409 |                 arg_type arg = (arg_type)in;                    \
>         |                                ^
>   kernel/printk/printk_ringbuffer_kunit_test.c:226:1: note: in expansion of macro 'KUNIT_DEFINE_ACTION_WRAPPER'
>     226 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Clang's error might be a little clearer with the "aka" note it provides.
> 
>   kernel/printk/printk_ringbuffer_kunit_test.c:226:1: error: used type 'cpumask_var_t' (aka 'struct cpumask[1]') where arithmetic or pointer type is required
>     226 | KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   include/kunit/resource.h:409:18: note: expanded from macro 'KUNIT_DEFINE_ACTION_WRAPPER'
>     409 |                 arg_type arg = (arg_type)in;                    \
>         |                                ^         ~~
> 
> >  KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
> >  
> >  static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)

Thanks a lot for the nice report.

The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:

#ifdef CONFIG_CPUMASK_OFFSTACK
typedef struct cpumask *cpumask_var_t;
#else
typedef struct cpumask cpumask_var_t[1];
#endif /* CONFIG_CPUMASK_OFFSTACK */

And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
is a pointer.

I am going to solve this by adding a wrapper over free_cpumask_var()
which would work with a pointer to cpumask_var_t.

It has another catch, though. It seems that the automatic clean up is
done after test_readerwriter() finishes. Therefore the variable
@test_cpus can't be on stack.

Anyway, the following seems to work with both CONFIG_CPUMASK_OFFSTACK
enabled and disabled:

--- a/kernel/printk/printk_ringbuffer_kunit_test.c
+++ b/kernel/printk/printk_ringbuffer_kunit_test.c
@@ -223,7 +223,17 @@ static int prbtest_reader(struct prbtest_data *test_data, unsigned long timeout_
 	return 0;
 }
 
-KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);
+/*
+ * Add a custom wrapper around free_cpumask_var() to be used by
+ * KUNIT_DEFINE_ACTION_WRAPPER(). It allows to pass @mask using
+ * a pointer even when CONFIG_CPUMASK_OFFSTACK is disabled.
+ */
+static void prbtest_free_cpumask_var(cpumask_var_t *mask)
+{
+	free_cpumask_var(*mask);
+}
+
+KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, prbtest_free_cpumask_var, cpumask_var_t *);
 KUNIT_DEFINE_ACTION_WRAPPER(prbtest_kthread_cleanup, kthread_stop, struct task_struct *);
 
 static void prbtest_add_kthread_cleanup(struct kunit *test, struct task_struct *kthread)
@@ -244,16 +254,19 @@ static void test_readerwriter(struct kunit *test)
 {
 	/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
 	DEFINE_PRINTKRB(test_rb, 8, 5);
-
+	/*
+	 * @test_cpus can't be on stack. THe pointer to this variable is passed
+	 * to an automatic clean up action, see prbtest_free_cpumask_var().
+	 */
+	static cpumask_var_t test_cpus;
 	struct prbtest_thread_data *thread_data;
 	struct prbtest_data *test_data;
 	struct task_struct *thread;
-	cpumask_var_t test_cpus;
 	int cpu, reader_cpu;
 	int err;
 
 	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
-	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
+	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, &test_cpus);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	cpus_read_lock();

