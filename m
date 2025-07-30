Return-Path: <linux-kernel+bounces-751259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFFB166FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8E33BD42D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A87202976;
	Wed, 30 Jul 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJWe7/+Z"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BB1F1317;
	Wed, 30 Jul 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904319; cv=none; b=QCSReinjeaypwqj1puAz30SgRfVGf1VP4scUBz8BMJMmiOKyauS7CR8Z9nbSY/zE5F/4Y1iCVOcJ+OzzQOKaEoPJxgQPrygWq36D34V7CODn52rPX73U5GKanoCrOwxA/L9ZaVzsFyxjdoddVPG6kF33O+1wrzN7/sJFqZ7PwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904319; c=relaxed/simple;
	bh=4M7AzI/3/zDLPdS96jEcXBDqNN7/BeqzXLyMEYLWlmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBkvTYRwSWBPGzWlDMYpo84de4dSJsHDWnO6cw/UP76Hxr3V47pvpMFj5rXYgbV9+keSg+Q2lQOAeU+QnH+Btw7k6w0Aw5F0bxAENT4XgKm57x7r9npQ5U/vcX5Lnn0yTqyObbKjq2R0RzdBNLTXwTO7KvxD8u+HB6tRB/geFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJWe7/+Z; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7073075c767so2274446d6.3;
        Wed, 30 Jul 2025 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753904317; x=1754509117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDgOdRVFYXmgY94Q9VdZfJkqVycKNrgMqzC0tVZym3E=;
        b=aJWe7/+Zwr7cuzHnKrKuv1Fy3/0s64KI9UYwIT0oEld4dV7IWyoHNeiWqaMQ0/C1Mo
         mdc7aDGoW46Z86ucP8yfwFATOo1XjdjWcBu9SxdTvXwen681EKaM0xPRGXjNpxQRAmu9
         T+aWb7ZnsJpZygTAE0CJlcFCQvlxnLtw29W3skWDj6Zhjau4KnQWI7b80WxOPtorfbgd
         5ouJLhxSbwdPu0XxOoQS5y9Z/vjJE8Z+h4Jxe0KeXJmqM7gWwm33GKQ8390J3Rxw5iOV
         BbGrNewjjJenfdAeXH+7aHWgGqDpEk1iunRF34Ns9QKqauR454MZamu4MGPRxsDbFABc
         Qixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753904317; x=1754509117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDgOdRVFYXmgY94Q9VdZfJkqVycKNrgMqzC0tVZym3E=;
        b=IE7pkKdEY/T0LMckKGnw5rtCux2NU/Pg4ZsrZT9S0e3JAk/wR3BO/mOYdaMtxxzUkS
         YPP4QEU5XIaDepjtJU9D9W0oNAbAf5fpvGMFWymAtmr1PPiJpLIuWrmr3Wj32Hd4hcbg
         eVTvRh7EfAplPz9bRVAK2bZMDdNLUR5Mm+UxPv2rbca6mGg0xPuPwkz0D6XILHR36Fcp
         csNcxRpOcpA2eq2mgFqRMOA2tQVwpzbnKv9NJVRSAC4r/040SU0qt4AdbXPQzDje/ud8
         EkQdRqKCyzOABaPifJo1XanN84jBS6THfbsdq0N0V6Caw+DjzJCvIhguNr8lLrMbv49A
         FVPA==
X-Forwarded-Encrypted: i=1; AJvYcCWBrlTr/waalApzNPA/jwSAvJVTHHmxfXE1bA3gBv5aASVAVrxGse4TocGcwnG/0xWHhh7NTBMmn7AQEyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNdoFjtT8FkcOF8gRUA6vH9EZ5ARAxSSEa1ROf4b6ELagGYeI
	oJ+LfApPAQ3nQgoL5/h/eXzLlk4t884eRbau5Pqr1XM+pJ0JSsDbwcdg
X-Gm-Gg: ASbGncsWj1HISx8RrEs+GC9JDDv+cd1egUY68jMhkACGh41AbYwdFRFccgo8XWHJEH4
	kxarDvC9FCCVmbifiXZHd3kRN4KEAymRQ98lmdkIXEOniY70RcI2uRsxu8PKs3Xo4WNmAJPytEm
	g+3XYcvEOxJ+P8MT5HlJ5p2xIV5iXSW372KKhBR0BkGtlGB28Xmf27mZV/cq7Q17fGnFqPeYGme
	DxVcyx9IbpmsPebfPVa3LKEAKpLzUNOdjqiR3lmilrKBgHVnunen/nfcq41k6iAorjj0rBGc3zg
	a7X4L4FQ7tcPKipccTI0Wnv0ZYKvYl7Mf8dFH2+ACooy27D9LM2/Ehm1pVOtkypVdWm7+Y4alsk
	DbitYkqEHsbrdjy3jsv4+1HSsfVM+W0R818aFxs9cgNZuEhVav52UAu9kuobzFn/xoP+9kPHocP
	x6h0Z+KroIfnGUzHtX8X63w7Q=
X-Google-Smtp-Source: AGHT+IGEpJNsXbY5cy9w/RAlkGT7QlJ4G9A9X0kdQS5XNhIpPA86bqK1uZP24u6C8xvmoIlFEe/a+w==
X-Received: by 2002:a05:6214:f2e:b0:707:49e5:fb8 with SMTP id 6a1803df08f44-707672c6ec9mr74491836d6.40.1753904317099;
        Wed, 30 Jul 2025 12:38:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c15a84sm63838146d6.48.2025.07.30.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:38:36 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2FEB2F40067;
	Wed, 30 Jul 2025 15:38:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Jul 2025 15:38:36 -0400
X-ME-Sender: <xms:vHSKaOKrlRP2Qm7aLiY15o_6gEEuHL-pSQPvMMTSvrn3yuzjxAq-jg>
    <xme:vHSKaAbuPkwZentK5vwegcVdQyfs7BftaQj_yxvdslitfr4gTqoPw01TgkPW_VGQe
    tElEPMjgO3SO4YJQg>
X-ME-Received: <xmr:vHSKaEJYVT-Pk7DOaHwneoR9S5AyfCjKa03TcXqxub_qeFRFAMHgRYt4-0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeetffdtgfeuhefghfektddttdegtedvueekteeugefghfehffefueeludeifeev
    necuffhomhgrihhnpeiiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghg
    hhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdr
    tghomh
X-ME-Proxy: <xmx:vHSKaJr_GIi_wgkYhynDVlXBFhwh5qs2opYK8F1NW4vlpM-Y9dBBGA>
    <xmx:vHSKaNDHW_inVbpsOYLk3U8dBWQOPpyJ9CuJ-zMJ7hCnDvr3rYkxTQ>
    <xmx:vHSKaPeyD2RpgtrffhhkERYmzXmIXYZr70C10zl-6hdyzArK8v8iUw>
    <xmx:vHSKaNLTI-fFs0-wm_zp7raVW2AFl7Oh1A3_dahtQ2UiEJ8O1WSsFQ>
    <xmx:vHSKaPvlzRFTI15ToGEEaL9OHz_vI_FOc7o3djSXvyDYCFAkxWRSiIU4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 15:38:35 -0400 (EDT)
Date: Wed, 30 Jul 2025 12:38:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Alban Kurti <kurti@invicto.ai>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH] rust: workqueue: Add an example for try_spawn()
Message-ID: <aIp0uo5y9O551HW9@tardis-2.local>
References: <20250730163439.50753-1-boqun.feng@gmail.com>
 <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBPMYTZSIEQ5.3NPJM1CYVO3CK@kernel.org>

On Wed, Jul 30, 2025 at 09:28:05PM +0200, Benno Lossin wrote:
> On Wed Jul 30, 2025 at 6:34 PM CEST, Boqun Feng wrote:
> > `try_spawn()` could use an example to demonstrate the usage, and
> > arguably it's the most simple usage of workqueue in case someone needs a
> > deferred work, so add it.
> >
> > Cc: Joel Fernandes <joelagnelf@nvidia.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > Miguel, Alice and Tejun, while I'm at it, should we also rename the
> > function to `spawn()` because of the motivation mentioned here [1]?
> >
> > [1]: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/topic/.60new.60.20or.20.60try_new.60.3F/near/529533317
> >
> > Also I find the `{ <clone> || { } }` is really good if I only need to
> > clone the Arc for passing to a callback closure, but I'm not sure how
> > people feel about it, so criticism is welcome ;-)
> 
> I'm not so sure, see below :)
> 
> >  rust/kernel/workqueue.rs | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index b9343d5bc00f..59c1a5e14d12 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -331,6 +331,33 @@ pub fn enqueue_delayed<W, const ID: u64>(&self, w: W, delay: Jiffies) -> W::Enqu
> >      /// Tries to spawn the given function or closure as a work item.
> >      ///
> >      /// This method can fail because it allocates memory to store the work item.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::{alloc::flags, sync::{Arc, Completion, new_spinlock}, workqueue};
> > +    ///
> > +    /// let work_done = Arc::pin_init(Completion::new(), flags::GFP_KERNEL)?;
> > +    /// let data = Arc::pin_init(new_spinlock!(0), flags::GFP_KERNEL)?;
> > +    ///
> > +    /// workqueue::system().try_spawn(
> > +    ///     flags::GFP_KERNEL,
> > +    ///     {
> > +    ///         let work_done = work_done.clone();
> > +    ///         let data = data.clone();
> > +    ///         move || {
> > +    ///             *data.lock() = 42;
> > +    ///             work_done.complete_all();
> > +    ///         }
> > +    ///     }
> > +    /// )?;
> 
> Not doing your pattern and instead adding a `2` postfix we get:
> 
>     let work_done2 = work_done.clone();
>     let data2 = data.clone();
> 

Yeah, the thing I want to achieve with my pattern is: make it clear that
the work and the task that queues the work are sharing the same
`work_done` and `data` (well, no the same `Arc` exactly, but the `Arc`s
that are pointing to the same object). This pattern here doesn't show
that clearly imo.

That said, I'm not really against using `work_done2` and `data2`, just
I'm afraid that may be more confusing.

>     workqueue::system().try_spawn(flags::GFP_KERNEL, move || {
>         *data2.lock() = 42;
>         work_done2.complete_all();
>     })?;
> 
> There are some discussions of introducing some better syntax for (cheap)
> cloning, so maybe we can use that in the future.

Do you have links to these discussions.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno
> 
> > +    ///
> > +    /// work_done.wait_for_completion();
> > +    ///
> > +    /// // `work_done` being completed implies the observation of the write of `data` in the work.
> > +    /// assert_eq!(*data.lock(), 42);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> >      pub fn try_spawn<T: 'static + Send + FnOnce()>(
> >          &self,
> >          flags: Flags,
> 

