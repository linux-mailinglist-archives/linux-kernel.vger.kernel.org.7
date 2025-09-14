Return-Path: <linux-kernel+bounces-815889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC92B56C55
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32111895DB4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5E22DF6F9;
	Sun, 14 Sep 2025 20:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTcjB1gH"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C2219EB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757883433; cv=none; b=sj/YfYMT16tia8SEm4yjX+gmFVl0t24tYZd55/I5DVhJjquiv7vp0KzobtrKrZp+/UVjnakemAL84aC6Mexj3JstmASUQhAl5U4OmnrAEauVuaWZ5UxO7RanebqYIsPBcIQ/9SXyo/MMy/U00D3dQvpeyZP7FRLCWIvJ6jyXJn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757883433; c=relaxed/simple;
	bh=E+1Rhf4TtAslOVEyRfpCz7urUP1VaTu8F6OjeI/pzV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCoeZ4byrCZX1n1Uxke8w1SSjL1r1hNvP7CJh7/6UJSn5ue1nD5O1uF1ks/0Dn6Fo5iJdYHoCsxa1XBEBFL+KuExagTkNvUokS8dHci+z2jUlaWi2dTO6c3Sdd8X7QpxUHKOLGXeaCctV7lCDLz++ZQQ0++5ox8gSX4yQ1xC8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTcjB1gH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7748879b06aso12020866d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757883431; x=1758488231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lYzC7DTlBazYH/vrpI5c9K3KG0tzYBKVkyZN0WJVZs0=;
        b=CTcjB1gH7S5mGlHx91tzrqZkCiaZtqZQSlOlv0s9MeUOE60zzW5MRYp3jU1DO1gZCV
         dhiXdSDUY2ZwkbGbRI+YCwRPKfFOmjTKTrjPJ7pGFagOX/fthJ1cQufcY1h6JM6tiDcU
         ieNUC/0CXwB9R0Na9bgx4GvhgaKdQs40PHlIx6VzFcParNR3FRaFslGZ7IMPySA+wXLU
         i+KuMrev0K7/WkQ6SUNLfnoYDHj9N9twfhSjWHwE2psw3rYTJaMwzCKqBDBTuXnJkQOw
         hkPMEIMsfWXOeYgVZMXWbxe+JfpZFQDXyKhR1MK13GZOeeZE8lkiMThyph8oi9gb3OaC
         y/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757883431; x=1758488231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYzC7DTlBazYH/vrpI5c9K3KG0tzYBKVkyZN0WJVZs0=;
        b=ld0P92vfFAjSeLqJgvZvbO6mU0pgaPCeYGAIn2iDxv3SyRO0M6jqbAIKVTlBR7jrv1
         nrFCUGUy4CvkYpleqk6OELZ9p9bVIZcUAY483EA7XKp306mRUeWM6OFZZaRFEWdrjsF/
         +LIQlOqnUsqvTpsvnu3P+q17tY6y/7R6T48XbVGyzmjqRYKDBWL1mj+Nzl71lMh14K0t
         E9AiIaG2+4wfby7UcNS368Ni8zXK8wnRhizZ3FeQtymyhJsYVb8rVla/8BBwWteHVOkZ
         SgrsONHZvxc2NeSPX4KX8L3t+OUqzRQxN6OGmRwXmhLFU0j0zWy6UTqsoUmdx7gwQ3gF
         gRiA==
X-Forwarded-Encrypted: i=1; AJvYcCUhUUusqjLVdiw7NbRqAgLTSihwUGlhIC/CmgBgb0Jz4xspxs/2nSQPR2wXBZkAEWD7lOAHB3mCDvKVP4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ap1UcSAxz7znQ8ZJn/odw8OEYRn/UDkFwxlU+2iTw1/bO7YT
	XUOErwZ3968YIwHOnL3UlZeziq5zkprtMEbLDnTnO9CxRSTDj6HHN8bQ
X-Gm-Gg: ASbGnct8Kv0PWmK536sury+Iq6eKMjA5cfmqIpHSGWUsPakRW8Ezx7oBQekQNbywj5P
	Gr/rza0hmbCvlRMDQpLzV/r6XXcLHbQP5b7d6DxmuCunJb/DqmJO2QdDj1XoaQY1OTt11TLhNOA
	44VggdFPWt2YmjUXIsX0C7hhL8pbMIA3985f5vHNwIJjm7wZJtYBkMzRLhhQiVW+io5Yz63LoLD
	dMKI37JHPZSyb65ifsElT87LfRwyuBMEs5aZqn/rpCkw27NQnlAgpMNkREXmVQixmfJ8pWYP+vx
	442nJPwsoRgl11cpsddtIxUGTLP48kt1j7iWAbA/U/vZCmLQR5P0Vc4In5JLy6B1Q8OoMnqIaVe
	JcijBHTzLkkomgywtJ9bwgWNjCW/ANkoqzg6dUIZSH0WeV2QZ79aOW3pdxQdIeN6bw2eZ33cNcK
	bRv5fxzMUBQWuIcpHtHAaWHWo=
X-Google-Smtp-Source: AGHT+IFwb8QYA51dTPTDUlRdj4ZuYKyJJ+3+ho4CbwnE8QXUiHnNdyvgLPli+R0c1GQPsHhdkVTnuw==
X-Received: by 2002:a05:6214:5018:b0:77c:394f:4580 with SMTP id 6a1803df08f44-77c394f5105mr37329426d6.51.1757883430705;
        Sun, 14 Sep 2025 13:57:10 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b6800370sm63337246d6.33.2025.09.14.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 13:57:10 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id A2F69F40068;
	Sun, 14 Sep 2025 16:57:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 14 Sep 2025 16:57:09 -0400
X-ME-Sender: <xms:JSzHaOIRsv71NhpZLHqXUc3JKAlS9Ah_ieKzQYgv8HOSIlXtBAgfTQ>
    <xme:JSzHaBXnObaCztPZKhQkyK5mGMi5MgVzCW6yhpwo8aah5JRL73g4z0x6xc-m3_fNY
    fbW75lawyS69E1pIA>
X-ME-Received: <xmr:JSzHaCjA2BULm25Bri64ocYQvXpP-HyCzdTk8tfWfoc7nCNlprW7NyWFxjimHgorLErUVh_xNz62_9_u8Lh_zyuY9lo46WXD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffiefhtdeiudeigfeviedvgeduueekfeegvdelhffhkeekgfdufeeugfefjefg
    udenucffohhmrghinheplhhotghkrdgurghtrgdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    grnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    lhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmh
    grnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtph
    htthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:JSzHaNvGer0ixFUgKKlDhw0LW9B04pndaPJeIldcJA00vo03TGYBdg>
    <xmx:JSzHaCw3VeV2-R-f7KMA66fZwlYWvIErwTVE1xvJa78Adb3n2-uWkw>
    <xmx:JSzHaCaoX_Oh9PjABqJEKtn0fjooiLTW8bv4zGFUPmXpLVt93pGT3Q>
    <xmx:JSzHaBV7GdF6-sM8vNRLc-hXyrntYZKmQvTVJyBztX30JGp4vH3HRg>
    <xmx:JSzHaDHiq1zp2fQ2qxGFx9wXFc8lKIVzj9V7aFHRtCK0NT8Ra40nNg7K>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 16:57:09 -0400 (EDT)
Date: Sun, 14 Sep 2025 13:57:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rust: lock: add a Pin<&mut T> accessor
Message-ID: <aMcsI14mzwubhT6e@tardis.local>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
 <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
 <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
 <BD4724FF-4AB7-4551-B71C-C22E6E709F19@collabora.com>
 <aL47zBoNpvjYxec5@tardis-2.local>
 <A2534940-B847-40F6-8420-4ABEAE1D9A39@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A2534940-B847-40F6-8420-4ABEAE1D9A39@collabora.com>

On Tue, Sep 09, 2025 at 04:50:19PM -0300, Daniel Almeida wrote:
> Hi Boqun, sorry for the delay,
> 
> >>>> +
> >>>> +    /// Returns a pinned mutable reference to the protected data.
> >>>> +    ///
> >>>> +    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpin`]
> >>>> +    /// types [`DerefMut`] should be used instead of this function.
> >>>> +    ///
> >>>> +    /// [`DerefMut`]: core::ops::DerefMut
> >>>> +    /// [`Unpin`]: core::marker::Unpin
> >>>> +    ///
> >>>> +    /// # Examples
> >>>> +    ///
> >>>> +    /// ```
> >>>> +    /// # use kernel::sync::{Mutex, MutexGuard};
> >>>> +    /// # use core::pin::Pin;
> >>>> +    /// struct Data;
> >>>> +    ///
> >>>> +    /// fn example(mutex: &Mutex<Data>) {
> >>>> +    ///   let mut data: MutexGuard<'_, Data> = mutex.lock();
> >>>> +    ///   let mut data: Pin<&mut Data> = data.as_mut();
> >>>> +    ///  }
> >>> 
> >>> The formatting looks off in this one, there should be 4 spaces of
> >>> indentation here; there are also 2 spaces in front of the `}`.
> >>> 
> >>> Also `Data` implements `Unpin`, so you're not following your own
> >>> recommendation from above :)
> >> 
> >> I´ll fix this :)
> >> 
> > 
> > If the fix is small, feel free to send a diff and I can fold it when
> > queueing (i.e. no need to resend the whole series). I'm trying to send
> > it to tip before -rc6 so there will be some more tests. Thanks!
> > 
> > Regards,
> > Boqun
> > 
> 
> 
> This should address what Benno pointed out:
> 
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 7191804a244d..cb00fdb94ffd 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -258,13 +258,13 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>      ///
>      /// ```
>      /// # use kernel::sync::{Mutex, MutexGuard};
> -    /// # use core::pin::Pin;
> -    /// struct Data;
> +    /// # use core::{pin::Pin, marker::PhantomPinned};
> +    /// struct Data(PhantomPinned);
>      ///
>      /// fn example(mutex: &Mutex<Data>) {
> -    ///   let mut data: MutexGuard<'_, Data> = mutex.lock();
> -    ///   let mut data: Pin<&mut Data> = data.as_mut();
> -    ///  }
> +    ///     let mut data: MutexGuard<'_, Data> = mutex.lock();
> +    ///     let mut data: Pin<&mut Data> = data.as_mut();
> +    /// }
>      /// ```
>      pub fn as_mut(&mut self) -> Pin<&mut T> {
>          // SAFETY: `self.lock.data` is structurally pinned.

Applied and queued:

	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git locking

I also remove the part in the commit log where it mentioned about pin
projection, since the pull request for that is already created and
merged. Thanks!

I will give it some tests and see if I could send a pull request to tip
early next week, so it can be in v6.18.

Regards,
Boqun

