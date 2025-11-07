Return-Path: <linux-kernel+bounces-890510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE8C40370
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EEA1883ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EA2F7AC4;
	Fri,  7 Nov 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fTgzuZCN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECD1EB9FA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523803; cv=none; b=TrSpXt+tyYbIsw8G6CQJd2/nyLU2Txk8rCXCSnnUfxsGbVNovv0WfFrmbo/EpCKg9AIudpnyx2ewoaRGzqlkmHW7ua6ZqmF4dVtu0SvQN7GBedwDOursj8ShPZ6MnuN8hhz0PwHjHVWDyvyrpS4QTP6/Vt4ZyEPrlPtIhOwCzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523803; c=relaxed/simple;
	bh=1R/kTr6m6xk+J6ieD0IfKohXS4gczHqVrNFEl5eefzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef8gNbHmcaLBQ7cITwPX+nxGkynlaS6BJtl7NsKBA99ByyqVkuLr8Jf4ziXLUzRf5R1s927A1OvCINrl45Qp0aVpuLycxJ12tQOYhAIktzioySDrKmwkgsPNWb5SufpA9ntMYGW7sygLBpWx7esQW8/LSGLpDAVZjRShQGtcdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fTgzuZCN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b472842981fso99576666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762523799; x=1763128599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IcVopb2s8w+16S+g7lLVIkPkqupIqMM9/M7RBxla6g=;
        b=fTgzuZCNr6b+ZU2qqmqn6UornEbD/eIzYLyOKiLxjAJIvMYySDaoZ8EGFweDtp/IXu
         MFaErtlds8IWO+/HqEAMo1l77EPce0DRIk07l/o7Psi58ZXj8tUP47ZuH2eo8bY9FcNJ
         P67lvXmXJpi5MjFqLuXeNsmoprjvJdaTqG2cPhiSHaBYs9pUIwtEkuXcefws2gI/UGcm
         W3qbqEcd9wtHUlNmSjHDccQKO20BpKRhKqugnF+ze9MIuBlvc75tS1098WqGN89r8Gma
         P16FAtXH5FAhPe9VWqni3GUl1EtCe4bpOrvyQG8qU3CplS6cyoTp7EY3IiEM575k2UVm
         BKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523799; x=1763128599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IcVopb2s8w+16S+g7lLVIkPkqupIqMM9/M7RBxla6g=;
        b=AkV/zgfocpJY756UzfPNK0A05HTVwE80IVuYs9wNi7fYxs0ZhNnB77rqEEUmzQfQoA
         mT+zStPCg7gBIS8zmmSafF9oyfnZs6cdrsGuXYZI0wLPNM8suWyyUaDVfK3h83qhw7JO
         8mwwXNNamoCy4z4nS7SrbkSm47uTZ4lHKcbsxbZxEryl9LvW/NuwVZKZ1NC5KApoAhWC
         ZwfUC8Dh1U3OzBEAIMBJyCpVVLAx7BLsssC2VE2zZakWtRx2vN28phaKyy7tJDzwok/z
         SyrA8u1slqgNPtqhPuk2yHAw8lMdHoXtnBaZRSJT+S2yuMFdebUiIkxS2Mvn+2RQCjji
         2amQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyOXpUoZZOWMKVwmId1NkEJX+MOzXyNxk0+nwdoccEMqLkukMWTCGTSqX8Bup3RuUVv1z5NakmGoqiYVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycyXhaFHyAiI7JXNHJ34z8GaoPCq2gQQTF/SYPgyr1ZAIVDIVp
	nKqW9KxtujsIqt+hQoqitR7XySCa+EdXfU4wr9ZYOeDQJRhxqbviyVUQ/imupofLOzg=
X-Gm-Gg: ASbGncvCvjtUkVK8pSK3zAQ7iX0pOzgZLH1c7fr3F/WG1F5xio8/sTxGB1ZO0Si9iTa
	CreYe2kdzcnO3Uk1xAmm0iyAfuR7+4xNGEmHLLqZb1/o9oovsgBfzu1nUGf6k6TeYzZCU/ahH/r
	PHdDUTacx9hHdjZpg1GR0oPwa+6QhghKpvcnBXZI9zJAYFQDXSAMNxoPr1GhJM8uPoaezeYAJlk
	BjSuhp/e9bioRXaYR2Qtf52w2T3wtqW91nQbwQQUcXWbKOCObUFGt+mUJcLCJf9rQrsYBUi94S4
	P79PFhY7ap1GL/LiueezvfrxHzRK76l/QHg3/k/Mf1VhFS1BvAQFft5na7secDoIyH8iaaXi/dX
	q0EBuISzqmiCm2EBoXBcPrXH0joA4GiwRZFPW9jrQHW70WoLwBselYSwLPzinIlw0ZEHo7Iy1Zl
	IVoOs2M4X18XUQtQ==
X-Google-Smtp-Source: AGHT+IH2mdtpLAgFnDN7/ewxqyAABSf6hLPb4+RazOfaC2hkb+/b+HZf0k+E1J/zd6r3nLrolhosug==
X-Received: by 2002:a17:907:97c7:b0:b72:1b8b:cc3 with SMTP id a640c23a62f3a-b72c0abc36fmr333150866b.33.1762523799482;
        Fri, 07 Nov 2025 05:56:39 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbca75bsm255953766b.14.2025.11.07.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:56:39 -0800 (PST)
Date: Fri, 7 Nov 2025 14:56:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/1] printk: nbcon: Allow unsafe write_atomic()
 for panic
Message-ID: <aQ36lc7bq2J5X3zd@pathway.suse.cz>
References: <20251027161212.334219-1-john.ogness@linutronix.de>
 <20251027161212.334219-2-john.ogness@linutronix.de>
 <aQN-NeWzlxtWDLXF@pathway.suse.cz>
 <87346z5u1l.fsf@jogness.linutronix.de>
 <ofk6hbiz4wjux6k4zdlsfglvxeszlxl4at232wcbvlovwjix4i@7e6wfdsf66pj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ofk6hbiz4wjux6k4zdlsfglvxeszlxl4at232wcbvlovwjix4i@7e6wfdsf66pj>

On Tue 2025-11-04 01:56:07, Breno Leitao wrote:
> Hello John,
> 
> On Fri, Oct 31, 2025 at 10:02:06AM +0106, John Ogness wrote:
> > > I am not sure how to move forward. IMHO, the original plan was to push
> > > this patch together with the other netconsole-related changes. In this
> > > case, the conflicts will need to be solved when merging pull requests
> > > from netconsole and printk trees. Well, the conflicts are trivial.
> > >
> > > Or I could push this patch via the printk tree and queue it for 6.19.
> > > But this might be too late for netconsole.
> > 
> > @Breno: This new feature only exists for netconsole at the moment, so I
> > am fine with it going through the netconsole tree. But we need to decide
> > this soon because there are a lot of printk-changes queued for 6.19 that
> > conflict with this patch and we should get those sorted out sooner
> > rather than later. (Note that the patch in its current form will also
> > conflict with the netconsole tree, so regardless of our decision I need
> > to submit a new version.)
> 
> I would prefer you do it through the printk tree for 6.19 and I use it
> in the next releae (6.20).

OK, I have just committed the patch into printk/linux.git,
branch rework/write_atomic-unsafe. It is intended for 6.19 merge window.


> I do NOT have plans for integrating the port of netcon to nbcon
> in 6.19, given I have other issues to solve first (described in [1] for
> curious souls), and I am still a bit stuck with [2]. Given all of these
> patch conflict, these patches are being a bit serial at this time.
> 
> Link: https://lore.kernel.org/all/swdpckuwwlv3uiessmtnf2jwlx3jusw6u7fpk5iggqo4t2vdws@7rpjso4gr7qp/ [1]
> Link: https://lore.kernel.org/all/20251103-fix_netpoll_aa-v4-1-4cfecdf6da7c@debian.org/ [2]

Good to know.

Best Regards,
Petr

