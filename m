Return-Path: <linux-kernel+bounces-878124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F36C1FD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95641A612E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049CA1E0DD8;
	Thu, 30 Oct 2025 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LOPgvX1y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3D218ACC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823973; cv=none; b=D//JZWjKa+Tlor6mgxnHbgr4GjDjsU/hSlnJ/Z5hhdaMf3ev8MqGs6MZZ3NQPk8CqGpHTZR9CQIQEsfyK9wGItcrPjIijEXAhyw4s2mY78lmQgDxvVfHuJUl6zO9eopDoTA1EAIqUevnHejHsQWroIg9P9pXFK/yuqA5Nut4Nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823973; c=relaxed/simple;
	bh=muMlbcMqXD01OwCkofrRnGNfdFL794PWo4IySRVrrEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpR+TkmWwU5Qc09ihezM+YoBhJ2sR/hhnOmu7+M6o07f2IQZvnJJGJMLWPjQpclJUGbXqjOxSFc22XFA7spaVcOqLPvUEJ3T/Rd1C6ERDqvDtKwI31vtbftywJ6C1s52mPjkQ9YWDp4YnO/eRdbgIKHfhaUvlNAL4sS7PytNVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LOPgvX1y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429bb95a238so73444f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761823969; x=1762428769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36R1/y0ppuhDia+apykCv/MJiHb/fMGU1uNXAB5g9Jo=;
        b=LOPgvX1yY3vuEE9s0bQESLBtiMcpdcHh5vXA3Pw9ePLg8ZHR27GKGbPlslZSVpGTpy
         SbzN6mKWw1UR+KgBI+G+pgYftVsxl6agEFIj/eGsIJATc+eepi+s88NxVy9nh1Fm5Zp7
         kS/djzRHBKXsK6+Ku52oH132EBGO2XvEbiI6O7AzqyAExlHisNpsIU1Hn41XNXLDTGPT
         LiNPmGCAjP91kMHOAL4cvDxQ19NNK3IGxHQsA8Fp3v8pchIWY5AdXvSZ4LgtuexMAovd
         52tjgC8fnYcIsr+76iFzDLoUz/MlLqjNGCHZWQfs+HGbb+HWPyV4Kp6ElXEKs047jOls
         YxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823969; x=1762428769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36R1/y0ppuhDia+apykCv/MJiHb/fMGU1uNXAB5g9Jo=;
        b=TfZr3dHplhTlMhb6XIdTNp3MtMjpDt/574XMIUU1IfqyPcr9DAeIfBk1nWHGStGz93
         l6NSuxX3MQ/jtMF6szxo6hWCJKMR/bWFp9I0ABbkG9ubQaaqK8YB2Pf8YQN9gzrArn8P
         xsUUVsY48gsLGTVQ/gvzU1xbCdnEaPSHgnb5VuMtmOK56nJz7GAe0bujKMLc6xk6HAH6
         LUTjG3UxObGna+uUIoPbv/kwqEwlkmAN7H90grsMcucxNZyr1eqss2/oXrPrjumwO+5b
         QIZIJtlWeyBQ0/8GR10NCuGIJzAuyJU/uCmSyZevp5qY4wFsueBE0hwUxPKXot47FU8G
         0unQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDrXWXILCplRJy8gRYGdxRqb7buoPDQDN54zYWbADloQeQVPgt6QNeDpW4GUankXsgQf9nXVxmg8UmmEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDww9kdlEQvGhx+nwkTs6S5Xypug5/mKDBxS12mqkqHJLKux1B
	qASYWh9GBRqfB0nLkH6nqbpxsfCCAbC7NW9ebTvRI/qV7hS4LOGdksFzMnnMZ+xNj84=
X-Gm-Gg: ASbGncuklRxUIajLGbH9Fe76XNafDZuKfGXdNgXfbZRCkm3vAANSIFg+7EM00IoVSYX
	aeme6x6UBOMxeofmPY8SWRE3/lNYxpVfReEAhOIwdljkfajmajHLN8nq7i7qUXvwVKABZAKzDy8
	5ETKa1RUoTPweAYdxsvjOAACDh9IgjNtS1jiC0KlTV6rR1YUB4MNvLACpBksFzT78vERp4sJoEr
	Ho5jAJPW+rmM49HGC4AIYFNCkmmKdbvJdF6UFAgrC7q44qwnLNwWD1ofnaULrhg7YQK4XEYxRT4
	vKin192HbBypBsAnYayivEcwctuUkIhbDbFwH+H738Cd5El2m7DaPtwwuJecfSuQ6Fiv9A8niAb
	68QEv0Ezc3lewgAOnIuzCPytC8+sebmdpnywnDUwp+7NCR/u+Py1SgjLwt4IzyXsKS82DIsEV4w
	cNf5Ow2OvbpGeSNg==
X-Google-Smtp-Source: AGHT+IEPxvyLj9Z6RbqevRQBpTtKGGxmaydSI6etzWXlEcJqPTS8WKcLBAuSkjLnQNUWVQWk2i3Nyg==
X-Received: by 2002:a05:6000:2006:b0:427:847:9d59 with SMTP id ffacd0b85a97d-429b4c9ee68mr2975795f8f.45.1761823969402;
        Thu, 30 Oct 2025 04:32:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba699642sm1857792f8f.16.2025.10.30.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:32:48 -0700 (PDT)
Date: Thu, 30 Oct 2025 12:32:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH 0/3] printk/nbcon: Prevent hardlockup reports caused by
 atomic nbcon flush
Message-ID: <aQNM3r6YU_4fl2Xx@pathway.suse.cz>
References: <20250926124912.243464-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926124912.243464-1-pmladek@suse.com>

On Fri 2025-09-26 14:49:09, Petr Mladek wrote:
> This patchset should solve problem which was being discussed
> at https://lore.kernel.org/all/aNFR45fL2L4PavNc@pathway.suse.cz
> 
> __nbcon_atomic_flush_pending_con() preserves the nbcon console
> ownership all the time when flushing pending messages. It might
> take a long time with slow serial consoles.
> 
> It might trigger a hardlockup report on another CPU which is
> busy waiting for the nbcon console ownership, for example,
> in nbcon_reacquire_nobuf() or __uart_port_nbcon_acquire().
> 
> The problem is solved by the 3rd patch. It releases the console
> context ownership after each record.
> 
> The 3rd patch alone would increase the risk of takeovers and repeated
> lines. It is prevented by the 1st patch which blocks the printk kthread
> when any CPU is in an emergency context.
> 
> The 2nd patch allows to block the printk kthread also in panic.
> It is not important. It is just an obvious update of the check
> for emergency contexts.
> 
> Note: The patchset applies against current Linus' tree (v6.17-rc7).
> 
>       The 2nd patch would need an update after the consolisation of
>       the panic state API gets merged via -mm tree,
>       see https://lore.kernel.org/r/20250825022947.1596226-2-wangjinchao600@gmail.com
> 
> Petr Mladek (3):
>   printk/nbcon: Block printk kthreads when any CPU is in an emergency
>     context
>   printk/nbcon/panic: Allow printk kthread to sleep when the system is
>     in panic
>   printk/nbcon: Release nbcon consoles ownership in atomic flush after
>     each emitted record
> 
>  kernel/printk/internal.h |  1 +
>  kernel/printk/nbcon.c    | 43 +++++++++++++++++++++++++++++++++++-----
>  kernel/printk/printk.c   |  2 +-
>  3 files changed, 40 insertions(+), 6 deletions(-)

JFYI, the patchset has been comitted into printk/linux.git,
branch rework/atomic-flush-hardlockup[1].

It is queued for 6.19.

Note that I did the following modifications:

  + Added changes into the 1st patch proposed by John[2], namely:
     + initialize nbcon_cpu_emergency_cnt and make it static.
     + call nbcon_kthreads_wake() only when printk_get_console_flush_type()
       sets ft.nbcon_offload.

  + Rebased 2nd patch on top of 6.18-rc1 (panic_in_progress() moved to
    linux/panic.h).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/log/?h=rework/atomic-flush-hardlockup
[2] https://lore.kernel.org/all/841pnti8k2.fsf@jogness.linutronix.de/

Best Regards,
Petr

PS: I thought about sending v2. But v1 already got enough Acks and
    I added the requested changes by cut&paste.

