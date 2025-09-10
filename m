Return-Path: <linux-kernel+bounces-810824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC04B52033
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C838487BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C615271A7C;
	Wed, 10 Sep 2025 18:23:15 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ACD22D9E9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528595; cv=none; b=WRGS9QX3e+hjdTx1ddtclayDjOSjs6/81ZYfcoTHXIpRaf3NzF/QBqbAb7TVYCTkdwn/h8eQBpdCduvHruzJEvS4F4k+sB79bY3r2SmLhphfsThtM51Nj+GFJedYdb10+ncfm8mgomqj4WpWCpd8eI2ieZeNUJsHa5iTQQ1ZU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528595; c=relaxed/simple;
	bh=RbZB2QdvXdQC93hIZTWCMHxfBgllHO53876Due/cfHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSgt6MBGMfh/qq5FzXOkuR/K0S58eYUd9PRS4ymmR84pNBDwJh9HykF533klS5XOOWv+IxBqg6gTnfW8YT9Qy5XaFzqgnJkqUbULtEcGgSILLHpz48nC8FWgKLtUWIdgXSulBpQN2a386WnlddQnPWQsVlfMis8kCodu2EEKIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0418f6fc27so1193143666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757528592; x=1758133392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmFXFgSBxNTUpOGRx+AfdRKGmjlssb6jAEn00Lu8FBY=;
        b=iHQLpSBKSEDK09a48UBA6te6pXFID8YA/O7fSkOm6ZYZYSQwr6f9/AELgSfCaZClWp
         vZxA/nRi3aSpfPU9p3Ls2TxLvgOaXarMJp39bnJysgIUxDLic27R5IcqT/NDiEhCpub9
         OmLLri1d4s6EMkUhlH3GtDVmls9PdNnr+OdpfwQySq5WQP07lYTRJcPtRm2uO0J4uPaK
         8Rduq9wANLfCcoz+C17pX1qUave+EzrZ8gCSxntr2Q3xZUCtZJXf1fBYkxFDzkiTGKHU
         NHE3ylMWK5X7OcAqm/bX6LYkHOiVdzIxd8x3MRSuQx1K1KD9nLuoXCSDeA77sgIW/n8n
         3ceg==
X-Forwarded-Encrypted: i=1; AJvYcCVP1NRjYplMlRKUl4w1/jAdmgUgKBsH/74mrI7G3UFOqdlGhyTGoS11j6ITkzxaZPi2pFOW91Nus/6pag8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtcU3f4wRGoPdUlat7CLFzzbf8uWlZtHCuAVxRHGAw02JlCMS
	QIK+sW2HVdpr7Y/fxL7RCGug4M6OrmlMKRoLLI4nLSoMuRJQaaoqg8Uj
X-Gm-Gg: ASbGncsHtQOHFUvWG8rICISYx182irqvrY0GRFN6TukVWvWmhcw6Zmr7/tgVexgTfvd
	k5iMq0mZczaxplJQ7PBecULbG88eDN5NJsyCJSpnsx5D4qycmjA0EqYjbnh9O1Meg+seKWqRGNa
	YnUNAK3CZ141h1oB9iW2XiY+9xNJspIUmEsT41anArrineRsKDtWtPMqpgCuL0h4txNknpmlVWs
	5sTxecAYc7GUSOQ7D0I+SjAKo/nhUmi5+auUYVWhJRVjtF+Xdl/q2i31+obR8bMW7z4hlJUttXn
	k+pPHekqZM6ddJPuBOoiavRW7gWNSmDhl7m0zuo/GM1/OyhbTj6dPbRBu+0GIVXINjTlJ6SFUHm
	8XYm8zWe+1+zk
X-Google-Smtp-Source: AGHT+IHbHsFjicTmkBhhDK0SwLgSuiGScEUPM0kKkIXxZFZUbT4mc+5rRFWNh8O7jTHDdbNFXbzBJQ==
X-Received: by 2002:a17:907:1c26:b0:b07:892d:6769 with SMTP id a640c23a62f3a-b07892d67d9mr319644166b.2.1757528591432;
        Wed, 10 Sep 2025 11:23:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830aa7cesm205651866b.30.2025.09.10.11.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:23:10 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:23:08 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>, 
	kuba@kernel.org, calvin@wbinvd.org, Pavel Begunkov <asml.silence@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, boqun.feng@gmail.com, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <cbvfyefqdyy6py2fswqp3licm3ynrsmc3jclgnbubp72elmai7@kwvks5yhkybc>
References: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
 <trqtt6vhf6gp7euwljvbbmvf76m4nrgcoi3wu3hb5higzsfyaa@udmgv5lwahn4>
 <847by65wfj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847by65wfj.fsf@jogness.linutronix.de>

On Wed, Sep 10, 2025 at 02:28:40PM +0206, John Ogness wrote:
> On 2025-09-09, Breno Leitao <leitao@debian.org> wrote:
> >   b) Send the message anyway (and hope for the best)
> >     Cons: Netpoll will continue to call IRQ unsafe locks from IRQ safe
> >           context (lockdep will continue to be unhappy)
> >     Pro: This is how it works today already, so, it is not making the problem worse.
> >          In fact, it is narrowing the problem to only .write_atomic().
> 
> Two concerns here:
> 
> 1. ->write_atomic() is also used during normal operation
> 
> 2. It is expected that ->write_atomic() callbacks are implemented
>    safely. The other nbcon citizens are doing this. Having an nbcon
>    driver with an unsafe ->write_atomic() puts all nbcon drivers at risk
>    of not functioning during panic.
> 
> This could be combined with (a) so that ->write_atomic() implements its
> own deferred queue of messages to print and only when
> @legacy_allow_panic_sync is true, will it try to send immediately and
> hope for the best. @legacy_allow_panic_sync is set after all nbcon
> drivers have had a chance to flush their buffers safely and then the
> kernel starts to allow less safe drivers to flush.
> 
> Although I would prefer the NBCON_ATOMIC_UNSAFE approach instead.

Agree. That seems a more straight forward solution for drivers, and it
is clearly a solution that would help netconsole case.

> >   c) Not implementing .write_atomic
> >     Cons: we lose the most important messages of the boot.
> >
> >   Any other option I am not seeing?
> 
> d) Not implementing ->write_atomic() and instead implement a kmsg_dumper
>    for netconsole. This registers a callback that is called during
>    panic.
> 
>    Con: The kmsg_dumper interface has nothing to do with consoles, so it
>         would require some effort coordinating with the console drivers.

I am looking at kmsg_dumper interface, and it doesn't have the buffers
that need to be dumper.

So, if I understand corect, my kmsg_dumper callback needs to handle loop
into the messages buffer and print the remaining messages, right?

In other words, do I need to track what messages were sent in
netconsole, and then iterate in the kmsgs buffer 
to find messages that hasn't been sent, and send from there?

>    Pro: There is absolute freedom for the dumper to implement its own
>         panic-only solution to get messages out.

What about calls to .write_atomic() calls that are not called during
panic? Will those be lost in this approach?

> e) Involve support from the underlying network drivers to implement true
>    atomic sending. Thomas Gleixner talked [0] very briefly about how
>    this could be implemented for netconsole during the 2022
>    proof-of-concept presentation of the nbcon API.
> 
>    Cons: It most likely requires new API callbacks for the network
>          drivers to implement hardware-specific solutions. Many (most?)
>          drivers would not be able to support it.
> 
>    Pro: True reliable atomic printing via network.

That would make more sense, but, it seems deciding about it is above my
pay grade. :-)

Thanks for helping us with this issue,
--breno

