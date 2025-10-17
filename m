Return-Path: <linux-kernel+bounces-857423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CBFBE6C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D44FDFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE893346A8;
	Fri, 17 Oct 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE6HaxiB"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1287494
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683711; cv=none; b=Wb3+rJSY6SqnHxmmawi5HMTtelchTEgqrA4YcuPoXkT6kq67vb6RWjckIcIzj33LmIsPEvqzpmnuDVScgJrrOQYAGGAZ7NZryN+JttaklO5snV+6GtdV8d+y8ADr5lyEIBK9kTyfpi0voNpqmgkKI4Vm7KXlISMlMm8BGM0v7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683711; c=relaxed/simple;
	bh=FfyEjb8szo74nf/ADMSUeVfwtw7NpFaWSMEpPg5cAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkbCOMmKKw/eptTjetmJVCQHLTqVoF0zuZOknXTGWswvPyyOVXRkaQ3IG/dQlXA6CVpeRq9E7dhUK4ojYZMAldP0HVgZsBVEkNUrkg0rjw8fCJXOyw4KPKy6ob5hUk9ad4ygUsmec9Hgk3eMew1rfYuM56bHc588s4jqWYQXEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE6HaxiB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7ea50f94045so41980806d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760683709; x=1761288509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thHk+LDvrFzyJQa2wHsHWT+JXdc3isPra4LuVj80H0=;
        b=cE6HaxiBKTXALq/lrIkmVDrp98QOgJOB3EJ6lsy8ibV/bZKaMvdoylghDl5tPT5vxN
         +XbMYiQgS1zF9gOxHrwdJGneNJ5KXhqM/eSinKqMFwbUW4JT+vUFSOW3KWZHhCNUKo6G
         fBGtyikyFWlwTDmppH/6ihvP+yJrl8qUdZQNWauKJ2aNWB4lt4Wk4ns3UeHJQieLe4FN
         l6F36YSkNxDgKKHRqADgw3OW5IiTJeYSZHvKW1ub61LhzQlvcqwZ+bVDv0afZT+MwaRp
         oTyyEPKbD93GP35fdUZhzblji4Xn0GetNn96MkjW4ItxbxaCtlZwt+Ppjun4h//nBHze
         moFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760683709; x=1761288509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9thHk+LDvrFzyJQa2wHsHWT+JXdc3isPra4LuVj80H0=;
        b=aBXODtLyjc5SyEfAShI/qtN+ZJYEgVVXm8YC2EFkWLjj/KUlRW7RjDscvbmLxhalpb
         7FpF0kigJERi6GbnJUr8I5UcIawXL8XpqKOCXxhQSMAJk459gA2eS5/WMYHD9IDjIeY5
         D8ofT70a94roQkA9fQAby5AqS3PlP8Ki4HIXwrTN8fd0STaKOprxWJALnrjci3kEG9kP
         pKeCdw3sp2L2MzJM/TQKovWXXIGPzkyfIsdaK5ihHKANT9YfzhElp1q4wRtXzCESC3Ma
         ybKLSOhmO+yPPQF51pr/zpKqrMEOt0MOPzTaO1+iPvVaS00J77HdTi3enGYhKEZC1u/l
         2n9g==
X-Forwarded-Encrypted: i=1; AJvYcCU/DDus2J5Kiiu8ZxuAgZQqfhjiDKklthKKaZ+f4hAb0EFuLn0vX1o/bqCppCBBvn1f9+EhQMh8YDz1ua4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDk9QDeS/UV29IKyLLwkk8hrAMo4P0b0D+jt080sZTlOX2dITs
	yfNotNyp6jhG656IgqWCS9OJtLj/xBRBUvN5uDQbXteLuFFkATbDbg2A
X-Gm-Gg: ASbGnct4DMVnLNjrr6fVlD/wS0PcVhUHYQpYbz64+5JX/6AYC+Sb714A2oFZgidf6by
	nLA5KmBDHyB8IYKwZ0QRt+m5XzWtHjJ/Xwx157pqyPO1u321fA2n4BHnksmZyOCPCdHTZqh+azH
	/+/7CXgq8n2bXZ2fq2fWGF5dc71rK+JhVsKfUffnSX8Jx6J9IK0xVEtPFhTzMiWU8bo93x5SVSe
	7TLFRom8ELRtfagh+1T/XTXYlbHffl2KFGR/l/HGR1GUdF2H69LX4MwYzAdyi3768aMv9cxZH78
	MA81s3AE79t64kyCz2AXNzjVzC5FTskSjIoNSn+d6oZVxn5xH9LWGbx0rH6ROgmE0dxcLlNtD4n
	MweIhZOitSwIF4ETJQqomJoPWdvqbrLufsMjiA1c3MBapWCRBVy/x9d2QZJvMBtZqQO2QVbaTHr
	2+XVuINHewdJfqTKWQT8vMCagBMxAI34sKEUyiXKqAaCapaNrcTN92x8vky9n2Hm31nlUa6M9j6
	PgU+tWSPgwsDu/tP0NVk90nWQ==
X-Google-Smtp-Source: AGHT+IEKl6ub2GpFRNfTcXXCBN0bOVcioIRBk8P4vMvbVGGNxUqt0lxnw7DMma/kBpbsiuZsk9Z/rQ==
X-Received: by 2002:a05:622a:118b:b0:4b0:ca36:90 with SMTP id d75a77b69052e-4e89cdeab2dmr36112261cf.8.1760683708684;
        Thu, 16 Oct 2025 23:48:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c8a20csm59703181cf.16.2025.10.16.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:48:27 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 272D8F4006A;
	Fri, 17 Oct 2025 02:48:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 17 Oct 2025 02:48:26 -0400
X-ME-Sender: <xms:uebxaIsvMTcnjwpPoT0xXasDde84kr6xdCjqUtB3HuRMVy0cA1K3Xg>
    <xme:uebxaKxVP9mr6UJXLvxDCXIVRUsGtY0ARooiRRA0LBxsqoBh5tvPg079JR3Gl9LKo
    bFgM3apo72EE7hYt8OsTzD179esBM3C8BtwAIhg89MIeF2MyONZFkI>
X-ME-Received: <xmr:uebxaP35TeabTQK3HeYuTlpZc_b1ioWFrrxZ81ehIJK_w6KmyznE64jyIW65vf0EG7-qtuEk5v24J03CIKtu8RgNK0bRpBUN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprh
    gtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
    hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrrghlmh
    gvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehmihhnghhosehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehjuhhrihdrlhgvlhhlihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:uubxaHyhldY5ITjg0gMJ3Z8_6E8mMwR0Vtgg-o_sPSaGXvQDU_-j3g>
    <xmx:uubxaPNqfDLTeWuvBQv6RWgnZCzkxlRcxKtn7VhGUCgkFV03HyVGLA>
    <xmx:uubxaM75FKm1kQJwUym3VZURGyjk9v4bQfAZUTB17gf-EVHSLiJCaA>
    <xmx:uubxaGfFDSHMIxVbXsaD4qHZX26aGL7ld3xjM2XKSOWxfuGEjIafzQ>
    <xmx:uubxaCg7JVzRAKBgyAxZIe_R-kZiTqXVVwfxMVi7_5O6LKQ2X6gbazGa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 02:48:25 -0400 (EDT)
Date: Thu, 16 Oct 2025 23:48:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Ingo Molnar <mingo@redhat.com>,	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	David Woodhouse <dwmw@amazon.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v13 05/17] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <aPHmuA9kXSn438v5@tardis.local>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-6-lyude@redhat.com>
 <20251016222421.512ca8d1@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016222421.512ca8d1@pumpkin>

On Thu, Oct 16, 2025 at 10:24:21PM +0100, David Laight wrote:
> On Mon, 13 Oct 2025 11:48:07 -0400
> Lyude Paul <lyude@redhat.com> wrote:
> 
> > From: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Currently the nested interrupt disabling and enabling is present by
> > _irqsave() and _irqrestore() APIs, which are relatively unsafe, for
> > example:
> > 
> > 	<interrupts are enabled as beginning>
> > 	spin_lock_irqsave(l1, flag1);
> > 	spin_lock_irqsave(l2, flag2);
> > 	spin_unlock_irqrestore(l1, flags1);
> > 	<l2 is still held but interrupts are enabled>
> > 	// accesses to interrupt-disable protect data will cause races.
> 
> To do this right you have to correctly 'nest' the flags even though
> the locks are chained.
> So you should have:
> 	spin_unlock_irqrestore(l1, flags2);
> Which is one reason why schemes that save the interrupt state in the
> lock are completely broken.
> 
> Did you consider a scheme where the interrupt disable count is held in a
> per-cpu variable (rather than on-stack)?
> It might have to be the same per-cpu variable that is used for disabling
> pre-emption.
> If you add (say) 256 to disable interrupts and do the hardware disable
> when the count ends up between 256 and 511 and the enable on the opposite
> transition I think it should work.
> An interrupt after the increment will be fine - it can't do a process
> switch.
> 

This patch is exactly about using percpu (in this case it's the preempt
count) to track interrupt disabling nested level and enabling interrupts
when the count reaches to 0 ;-)

Regards,
Boqun

> The read-add-write doesn't even need to be atomic.
> The problem is a process switch and that can only happen when the only
> value is zero - so it doesn't matter it is can from a different cpu!
> 
> I know some systems (I think including x86) have only incremented such a
> counter instead of doing the hardware interrupt disable.
> When an interrupt happens they realise it shouldn't have, block the IRQ,
> remember there is a deferred interrupt, and return from the ISR.
> This is good for very short disables - because the chance of an IRQ
> is low.
> 
> 	David
>  

