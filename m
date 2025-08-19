Return-Path: <linux-kernel+bounces-776057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95852B2C7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E155B3A6A32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81E28000A;
	Tue, 19 Aug 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W1VJ5eyO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB320C48A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615701; cv=none; b=nbLY+JD5JcTXj6ZBsHyNmOMX5Z81RhqbpnJCn7+k4WnjJlx9Pn7iBttXdcOPaO6cE+HrAjrcUedM2BMSytFLzud5+l34r4BKh6kr8mWHP6hhHgEdlMiujrWKdF3bFUg6R4sqepL+/8lJRqiq6CsZxHvRE0oOml0crpXuFhqwQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615701; c=relaxed/simple;
	bh=7+tpD+9B1DaiIZzcRJKGBn8+q8FrkczJgMMZ1wey080=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUsUVVmnQG7/XFgp2NGO3WMDgWOswfabmhHLVw+DnC2D5sCF/TiOyB4xu/ZnSE4NFLzBzn9/RuthuMLrr+/LShG4GRVHeLCljvfpNHkbRjuNIKOUunlqd3aNvVpKuuvopj0k4M+TxaltXy0k+Sw2XqCsR9R7KPsdoKs6zggrnVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W1VJ5eyO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb73394b4so810769566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755615696; x=1756220496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCEq0dSFwmX2zvtf6FSiWkpoIyNND6QWBI3HAE7kt+A=;
        b=W1VJ5eyO6MobK8wxnjpwQ7+IG6UiTvW7ig1dqrVEDT9oOCopRv8kqGnFF4qbA8nuBJ
         eqyu2+7MbGCSHKY1KP8O0xUWaE04HLBxygqK+H3f0yZy8e7WIyRVgQA7ryAakSooP+3b
         Z61eXnKANiF3PNQrpxk0rbSdAhbf3MC2NZjwqLyc1K+mc3JRfVZBDxRDXiokSIMKS1Xu
         o3rCzorhrcDCr1EuerFyD0Q6p8i46fI3U5ip3iy8gWKCXurz66QoaPUkpSWa7wtA5zUZ
         N4dESHTfBzgkLltklYc++RAp0sQbL7Q3ME/tWuTlexXOKq1XQfP7v7ulYt72h64nFHOx
         aI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615696; x=1756220496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCEq0dSFwmX2zvtf6FSiWkpoIyNND6QWBI3HAE7kt+A=;
        b=sGUUpP+6BuYXgTlEFmoXzjrSCQ7/lTX0ROByqRlESV0pbBKmfwjUAPaCcrKKDR+60z
         DszzDjwWV1fhdc8GkqGVc7esjQRDoD9fciVPBQ729NNrNW0YkLEjATKOd0lJ1TcukEx/
         zpGueWIRznIYY7Uiq2jZly46pVBnbDfyTTf6KT4iHF8e2Jh8GsY30USGj1zI5G7iXdlU
         w0hloCSRfehFY+eftNiSeEJUkt+aCkMg8xJ8QT//YwPCAVDVBcin1QstQ6TLnVDLDSS2
         Q1w8cvYiVRz4Uu1xLmQ0z+deYMYRpz43lInngBtwzcLyB2uUP1HtBMymnx131Ho14Jbq
         WF6g==
X-Forwarded-Encrypted: i=1; AJvYcCUQwlx6CZRbcX+I91QUJPliGpqjRF3ILp4D1ObI/Zpu2+rxj+xfc6BJ+02Uius34E0P7Cb2/9mAnNgd/R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXligl5XMEu+nXUEXAyJ/3tYzWbsIDGNUNE30PGl9b0DzqvIv
	LTpkeRQTEtfK13lpAMGM7EEoykEYH24prMukI9mWWLYMp6vn/NsKEYOjHlAAxhp7gpQ=
X-Gm-Gg: ASbGncsLoyFgeAaFBoEAhHPj3InWp5UH/XSAAaKJz6ts3vEaFHVwSeQC3OMNr+C6Aoq
	qGbJI633v9vj9+420mekh2nlJeifKHm/44268tolFs+my0daWd77HVWNE5R1sjwaj7KwUbMQnbk
	iysA/lqEnqerCHR13JTAUZiI73PwOBDgowzdCsc+B37gxdrXChSuAsZYgcUkjxTzA35hr9e7y7k
	EXCWTZNa+4zsiBKdG1tHdCrywNgURk5V61ZZBXvmFVm33BifxRzs7F+jse7HDP11i7AfswJimw9
	k15NBJM9+TFSCYxx8eRA1XI8cE3NPJDzmmKr5GUrISLarRVv5QJX/qnLNDYsasEgt5+yg940A3I
	NtKWabeowcmk3xC7ON2IXYbCqGQ==
X-Google-Smtp-Source: AGHT+IHtqXzK23Ncck4MG4G6BeVxNiXz/YbV2oypQHv7GTC2sEWzwM/hUDUYihytM+l2GgM8DjWKLg==
X-Received: by 2002:a17:907:7e91:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-afddd1fb2eamr236562066b.47.1755615696309;
        Tue, 19 Aug 2025 08:01:36 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d9ccasm1929168a12.4.2025.08.19.08.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:01:35 -0700 (PDT)
Date: Tue, 19 Aug 2025 17:01:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Wang Jinchao <wangjinchao600@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Ryo Takakura <takakura@valinux.co.jp>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] panic: call hardlockup_detector_perf_stop in panic
Message-ID: <aKSRzbUvuEkVz-Gk@pathway.suse.cz>
References: <20250730030638.65355-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730030638.65355-1-wangjinchao600@gmail.com>

On Wed 2025-07-30 11:06:33, Wang Jinchao wrote:
> When a panic happens, it blocks the cpu, which may
> trigger the hardlockup detector if some dump is slow.
> So call hardlockup_detector_perf_stop() to disable
> hardlockup dector.

Could you please provide more details, especially the log showing
the problem?

I wonder if this is similar to
https://lore.kernel.org/all/SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com/

There was a problem that a non-panic CPU might get stuck in
pl011_console_write_thread() or any other con->write_thread()
callback because nbcon_reacquire_nobuf(wctxt) ended in an infinite
loop.

It was a real lockup. It has got recently fixed in 6.17-rc1 by
the commit 571c1ea91a73db56bd94 ("printk: nbcon: Allow reacquire
during panic"), see
https://patch.msgid.link/20250606185549.900611-1-john.ogness@linutronix.de
It is possible that it fixed your problem as well.

That said, it might make sense to disable the hardlockup
detector during panic. But I do not like the proposed way,
see below.

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -339,6 +339,7 @@ void panic(const char *fmt, ...)
>  	 */
>  	local_irq_disable();
>  	preempt_disable_notrace();
> +	hardlockup_detector_perf_stop();

I see the following in kernel/watchdog_perf.c:

/**
 * hardlockup_detector_perf_stop - Globally stop watchdog events
 *
 * Special interface for x86 to handle the perf HT bug.
 */
void __init hardlockup_detector_perf_stop(void)
{
[...]
	lockdep_assert_cpus_held();
[...]
}

1. It is suspicious to see an x86-specific "hacky" function called in
   the generic panic().

   Is this safe?
   What about other hardlockup detectors?


2. I expect that lockdep_assert_cpus_held() would complain
   when CONFIG_LOCKDEP was enabled.


Anyway, it does not look safe. panic() might be called in any context,
including NMI, and I see:

 + hardlockup_detector_perf_stop()
   + perf_event_disable()
     + perf_event_ctx_lock()
       + mutex_lock_nested()

This might cause deadlock when called in NMI, definitely.

Alternative:

A conservative approach would be to update watchdog_hardlockup_check()
so that it does nothing when panic_in_progress() returns true. It
would even work for both hardlockup detectors implementation.

Best Regards,
Petr

