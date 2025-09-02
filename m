Return-Path: <linux-kernel+bounces-796690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787BB405ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0346E17E8C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F108530EF6E;
	Tue,  2 Sep 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BBoM17pD"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC430BB8D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821335; cv=none; b=JdbMzipZBc/iIqyasMuYOQrBjnshqOsXjdy9nK4qRgIoiBqVq9vng3vfcVetEZg/2FZ5FR1AJ3nncQfzU+hZv7eXyOY6m/+Lx0u07R6xaivqLl6XqsOh4MJ2k5PXQqzA7wJYPgd135hNwJeeflNLThcRjxkFXXQB4lz+P070QHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821335; c=relaxed/simple;
	bh=bQakP1YsFZpN261MdTv67NQ3SO9sRRoupHv7KYhCKvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo5NUxfK3/2kWEKyD9an2RcNTSU0z5b63nCblgkR/zwLJDuQhvAsd+MUh9wsOLGATJQaExgXmJkI6eqHrEldb9iPrr6bzYogGNJPz4QM4KRJihVuT+MrpCAwqvGV5ZsJCJHqMtaNBmW3PEHJYgMToowIwkqjzZ6MjAa1/jHtJq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BBoM17pD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so7175313a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756821330; x=1757426130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux1+zM7DCGKk8Y0pNnzy3MA9mFKRSAX580GQ0UU99YQ=;
        b=BBoM17pDDz4pTG+yQQkZNCPHzFb+sqNNNPnzNE6XnQxvJKCZXrY9y5VJf4kkGEOIgx
         ydEkiEHqR3V1Oi/XJXlWHaa5a+hzJLnoTFj8W9H+aYPEHQ39Tz6Jo5/ZkiO+0F9sD/u4
         K8mR9N6KW18MD9fwxGgR8bHSe4dZ2OsXP1NJmopKwwCechitZNog58ufXpf2uglRvm5G
         SvGz5ILKq+7b59llHzAzx5FZZ78L7EdVoPk4QOGvMWn5UYnQvtajPDyMbLN3iy14wUY2
         +gW8zBe6E2GOkvMFfe1gbcM2bUJJ1pYrrs+/rQBpANOkOEAzkKgPnT6PPLPVVvZZ4NvS
         z0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821330; x=1757426130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux1+zM7DCGKk8Y0pNnzy3MA9mFKRSAX580GQ0UU99YQ=;
        b=ZlBuQejv2FsSfUFyhc3a82JM4CaeRQ+nrWvF6ApdfSwdFJErQcL+SB8GzxMSuk1ckL
         MYSXo5WsymXCrJ+d5wOGDSvSdYzfHPcBgKirE5bQgqCDKK/JT1d37ph5kMBCl2Mhj/HA
         d+EgnML6YSrSEiR+orBq6aAc6yX3p5XLJZeSflbpTPNqoii5lqhwjQYes06yyEwtC5uP
         jQuRpx+V6FI7R4L/TPgKIdzqVctO9XLr6bzs5RjnA4znskpX1oQzibi09uLUUrPurOTH
         4VwuiUHSAYd9T4gixnvdoLNJMJXrd4ix1RfovsSmQJdRvSD33Kuv55mphSWL9wNUvhFT
         FcZg==
X-Forwarded-Encrypted: i=1; AJvYcCUfv8maz40ub/kDArFmq09B7Ndxh0077X23vkpYbnlxjBA2swdQPwiidaXs17D8HwwufKvdRKrV8zd2rgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIf+eByMd7qihAZECXztUl90kstcT6wAhEBl2szMqCeXNS0Fqa
	GDZ4sUnnJ5ia6NgCzvjpgfy4glx8LBkqxJgew39M4EZ6j+n6bzw7W4Y0y3QnKOR4+IE=
X-Gm-Gg: ASbGnctOt9LVKe5ra9WO7HWCOoOpfa14lF2rZ1Wovp1ZTcOWmThtAknz9J5Jw1z+nRz
	RM/sxEyNK6jKQBPLd0ApqisxRIHbezYp8YfqI9kKveDcin+5IOGzlsvTAyi5hXzc+ngEaznSk3x
	B8VGmiOhT5AqfPnQa5zoPbOvVedaahaZ8liuFmVFUL+whkdA2wZHgv6m0XFcbs67XKNOnfagA1A
	XuqTgXfrPItX84BIEXuriTJ8MyhwaOr3MjzNK3llDM8EWIaCeJynlDvAZfMjK+JElpCdy56MChA
	DoWFjULK8cPxYpZTOuUZe7uz6wz3IW8tDG8BilFVPBn8uGceZI0RAwrESUZjWBOyS7X7UnZ1UXZ
	MByT51Z0o7LVCMFRumu3pP4vSn/2wLfl1Xsaet7m0EWdh5i0=
X-Google-Smtp-Source: AGHT+IFYZsCEWcaT1DOSZuHxLNtRPdpvwo7JLtkjMRaV/jRgWXdGVcGEYo0U2qGMp5Ea0wH4E60Deg==
X-Received: by 2002:a05:6402:24d9:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61d26eb3cafmr9948273a12.26.1756821329693;
        Tue, 02 Sep 2025 06:55:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214bacsm9895291a12.16.2025.09.02.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:55:29 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:55:27 +0200
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <aLb3T6hjtX4M37dA@pathway.suse.cz>
References: <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
 <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>

On Tue 2025-07-08 16:48:47, Arnd Bergmann wrote:
> On Tue, Jul 8, 2025, at 16:24, Petr Mladek wrote:
> > On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
> >> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> >
> > Thanks a lot for the nice report.
> >
> > The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:
> >
> > #ifdef CONFIG_CPUMASK_OFFSTACK
> > typedef struct cpumask *cpumask_var_t;
> > #else
> > typedef struct cpumask cpumask_var_t[1];
> > #endif /* CONFIG_CPUMASK_OFFSTACK */
> >
> > And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
> > is a pointer.
> >
> > I am going to solve this by adding a wrapper over free_cpumask_var()
> > which would work with a pointer to cpumask_var_t.
> 
> I'm not familiar enough with the cleanup mechanism of kunit,
> but can't you just move the mask allocation outside of
> test_readerwriter()?
> 
> > + */
> > +static void prbtest_free_cpumask_var(cpumask_var_t *mask)
> > +{
> > +	free_cpumask_var(*mask);
> > +}
> 
> Or you could pass this as a cpumask_t pointer instead,
> which should do the right thing without the indirection.

It was actually enough to use this in the KUNIT_DEFINE_ACTION_WRAPPER()
definition. It removed the warning about passing an array type.
And I needed neither a wrapper not #ifdef.

I am going to send an updated version of the patch. I am sorry
that it took so long. This patch has fallen though cracks because
of vacation and other urgent tasks.

Best Regards,
Petr

