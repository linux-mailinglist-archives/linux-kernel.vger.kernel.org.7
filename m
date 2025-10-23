Return-Path: <linux-kernel+bounces-867227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332ACC01EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177EB1881A28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80E32D422;
	Thu, 23 Oct 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d8cGVHlB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178114C85
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231374; cv=none; b=EAuqaKTfAO/9CmhIwqXPvGtwYrVDWniUzztsJUgShXZQHpEfS5Kt9c2JhiqsQJNjdKRzWYrdW4/l9ImfRI7dYjWGLkgfyyl9884ODg2bDPzFqUyYlEVWJioILD4rBK2xyt3n0TLkwO9rC7+MI5QbZyEnB3K++XDMV6WchSz4lPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231374; c=relaxed/simple;
	bh=hF3j4uPHqlwnDAjO1X9Pwn3pj7ZWK7ZEL2YqU7yGiPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0FhfnYcCpNTseiI5POj49Irow1ybO0UQpxDFJ6TG4i+XBckWg3M2uXyb8QLAUFpbKZYyomGuYQJ5ODIurtuNIG8hnEiXXSdI4ckEqb0l4FNMhr9hMLrJUunnBx2/Wpt2Y+WPbvAJHR2uiFlbg+5y8n22lTnJJ/Y9Oa0d5m20VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d8cGVHlB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so5423045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761231370; x=1761836170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJD1f1d4Oy5BuizINLHSk2WqqhWJdvdwAaQPK/9Z6PY=;
        b=d8cGVHlBnSjFUJgh41nc9ZEnJFitF/TP4+sn2gx5ndQoS9GAV70+dIGbtOTG/dAsd4
         RrMHd4BH8VY9eBn6RDtmW7ekDCoC3lRP3NPekl6HCkrlucYQuriDq++maj7ILCPt2/Ku
         oXY8jKjSIEp4cQPy3tz1f5NpYH6K4vSBor4xn4lKbb56ltkzVkr2r///5u9M2Bw7XbwQ
         bcdciRzGfpjAvZc9cX3wfgiRwpuQDTJwgtgnCF0ai54kSj1n7p3V70y3lu5H07T9A+qC
         4wClYB93LM+yAKpA9UH3X3EwAoo0BgWahuL884BUc4i3w/HIz+BUa6vbgM6hJHpzJIZK
         Jgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231370; x=1761836170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJD1f1d4Oy5BuizINLHSk2WqqhWJdvdwAaQPK/9Z6PY=;
        b=elGyb6U+Lh3AJObYtprjsIm+RcMj2MmHbedbqh1f0a2xXYMUHt98Uzf6i60tQQYFl4
         9w9X2ghqqiDX+J7srkhyA1oESLurXSgg+jsS7ypI5gdJY3rayE3PkzFTArBK/DGwpIvw
         J4S/6oZngaGP3VMw5cpVBuu1HiT9+w2K3y0Fv5PvM6ycQahX8QRMO5lMeiyOry8+wWo4
         fLyZP/3JoXxcdlqaKyLFQcZWUJVT2b6zVgPmCe+Mhvh391S5+FdWxnXwyY4sgK4J/s4c
         iHR9mqORxG0F8auj5+7AMxZsa5009flOjWKy2NHIwYSlgJXe3MIIoIdSp96vT6PPbKE3
         tn7g==
X-Forwarded-Encrypted: i=1; AJvYcCUIH5g2OtwujuJs4Y+TghPYlJP7BPCfTwJst+6kuuU+SSIWSVlldgMoVFxkg6dDQfjMU/DoYn0N/SSoE0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexGaa19ZT0wG4k6fuEc+mOQHwFaBs4xwg5hm+bpYUxNOMmPs4
	Vdw9GBMSevIAHoRA3npGQMJVLUNWNLmJUUUKKRJa4Vzeof4sPDRXxN4unK+Y6sIHnI4=
X-Gm-Gg: ASbGnctl34XvDuUtmSKl36npsCBpf1j6ReUDljT6epvmVu6tNqGfarfv/sRGbyS4X/z
	10NxrM9GtGWzkFfx5R0HU2PnDXeEmNsGSbH7T6KrjaN1Wl91uTPyeRT/jPCBpvk7/t3R27jHIlK
	PuSRGgvDApGjz7yRkxTaRQpwzVCYm3jXy+ZKyIQLgtx4BWWQiQBvwb6HxU94E0YY4bGM30Qjo5Q
	NFZ5hTtAJRW8K8D+nEP1m88kbWCxrWNDA4BIC/KZZG4dZexTDfUKKpBDFbosjYpZZQgpIHLqc2X
	8kPpsWxGK83kAxeDqQDnzvAaoAL0v7zkJNBYNj1kOhkh1gdMuVcqyEKaCqgEU9QkAGyohijHWu6
	CAA1+oBXYXxTDs8c7r4U0x56CmZ8wYzvDCQ5B7Bq9FPBIIDD8ucLgIW+RWnon7ELkBlvEwKAct6
	A5zUEiA/u2olTW8j6FDIa4J4ygAHa/
X-Google-Smtp-Source: AGHT+IHJDZyOaFNN/9f52KeR5lqd9Ywb6NWeLlJcqLjS32+nkU2f8p0RAuUl6xa8lY5RrKw5dpDZzg==
X-Received: by 2002:a05:6000:26c8:b0:427:72d1:e3b2 with SMTP id ffacd0b85a97d-42772d1f234mr15048661f8f.35.1761231370292;
        Thu, 23 Oct 2025 07:56:10 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eb549sm4340046f8f.41.2025.10.23.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:56:10 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:56:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
Message-ID: <aPpCCCIg0NafmwHY@pathway.suse.cz>
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk>
 <87zf9hbvrt.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf9hbvrt.fsf@jogness.linutronix.de>

On Thu 2025-10-23 15:25:34, John Ogness wrote:
> On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 6c846d2d37d9d20bad58c6e3a7caada3be9552ca..2665a7a59f03b3a357b3346de1735606e77c3496 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3644,17 +3644,26 @@ static bool legacy_kthread_should_wakeup(void)
> >  
> >  static int legacy_kthread_func(void *unused)
> >  {
> > -	for (;;) {
> > -		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > +	bool try_again;
> > +
> > +wait_for_event:
> > +	wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > +
> > +	do {
> > +		u64 next_seq = 0;
> > +		bool handover = false;
> 
> Nit: I prefer to sort by line length:
> 
> 		bool handover = false;
> 		u64 next_seq = 0;

OK, no need to resend the patch. I'll change this when pushing it.

> With change:
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

The patch looks good to me as well:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

