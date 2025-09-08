Return-Path: <linux-kernel+bounces-804973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512AB48285
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DF6189EDE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95AB1E2312;
	Mon,  8 Sep 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg9s0/EY"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273119D8A8;
	Mon,  8 Sep 2025 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297618; cv=none; b=dlL35zRVO7UJKDqiXFUPkon0Iqfts0tEOC5TAv/gE+itgzrcFliD8Rlcr0cT4KMagUccD3ZE2sjkdl9SAOLahQlWOHny0UKvflm4YaIfsmBSunE949mja+vmBah5DuHj9NLuYrYqA1bbL8zWyAqUxIE801H253qMXwuM350P8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297618; c=relaxed/simple;
	bh=XjbMZ5/5Hc5SEZyQ+8sCJ+FX7X4M7/wRBJtPIsMCAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxlqC1ZofhTMSOTd4nmZP1knQ90POoMyNJkP9iVuNQB6PXQvQQRmCgcKRbVhKexDnQXHHpIyEnOF9KLiCTLRdwL6jQ6IDJqmcQU26r0DKz9xabvp+ji/TfTGqHH80LrgmjKxd/33iFDLqLxyGg7iTMGKOKb/a4UlXQzAAuc2eIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg9s0/EY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70df91bdc53so33571446d6.3;
        Sun, 07 Sep 2025 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297615; x=1757902415; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=llF9fv7z/uauioRJ7KgGNNzGbEHa5eBbrTZiuDHegvs=;
        b=Yg9s0/EYcZVg56yOFTuOPK9VpDCIvT2aJhYrZjrxDztJQMpqPsw+90SSXF+vDIXv9y
         NolmIF13cFrBXKNtULuEylXd4A7oEEnra6JryYyJDXgVPvZoURW5wdWXo/7RXWPJRDmU
         fF1TMb2ezd8d8pn90MzQZ2uOgzhZdoblhFNKTnlRfn60FIBl8001MhWl9GN1ksMXZtee
         9VG4V3GOtWzQxX8bu6Dpmkno7sGX6XeT7yQpbpD9usgGaccsMPFKdgmkO76PolQeBku9
         pm0X0zJ5H+pn/NswJJ+xiwT80PaJuC9dwKwir60iRWOFtNZSO5TncMFlqAOgmTNBjvLl
         Tsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297615; x=1757902415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llF9fv7z/uauioRJ7KgGNNzGbEHa5eBbrTZiuDHegvs=;
        b=tEI1ARrnOGvlsSh6LVuwSdkBIv8IShmbilfGP34jRlLZU8J7Z6FOz9RNdAwj1FkmRA
         PWQolD3XKaWoPhWQGMJ7IpQ/+oa5u+xBswTldwHsRAnxoqSeAtDRlMTAIC1R6cNfI8nn
         Strx8Nym+1825Js01Jl06mvRSlD1Ofo9EvIMRgGvu51miDSWYXlni4W/nlr9qOPhaA59
         gwpbejbFVIwohE53SdsKukoQOqzEmgers5Ni3UcKjxFdgCwqY60xwrjR1ukZ3+lEinpB
         Wt7p34az4t3oXcs2AuBG3BPysNOXCMQ1flkGCoghMBaN+yS5Li1Cdw739+RPBKhJ3OVc
         AuDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVREcwx2XTnEDZf6HfazzzkqR3PUaXo6LFB4DTefj0muvFIBvVAslX3BjJXBeZGkMo23DOB7HCXgS65EQowhAk=@vger.kernel.org, AJvYcCWJnTVpT2QF/T87HOt7wmXafDGnnSAn9rLbUflHrNHbuq2DFJCop7kVffdElQcdAQu/mF/hBRqLHQxqTmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrdYEzhwUPuV8N/c7tD0wSd/DUtioZpI6YVwdgPmnfYGQHMB6
	ArrGv0yLOmHBNOO0rly4a1//5WfR2oAgbDr6lkyO0RCD/ugX3GnARKSH
X-Gm-Gg: ASbGnctYDgi+yXBHwT5gRzWlNg5sav6m2ClRs9q9yTc2a/ldkyCH8lHEraPNZUHD9UQ
	WNQiES0cEVJWhFBNVwSJDTmSrrm3kBuDwqVXQKo28BwoXGAVufY5dP3uL3HrgsHOFxPRbEDpGdE
	f1nWBJKhKQNSMa1u9QFit8MUd1rp5YKi5gMdc2ukDw0l8GSSwwB6+lcUX/HuvlKWPABtAszdawi
	zbtKikoF+Lyf+ahKP1ekwl9TsR70YEaJ6Sh708HukOx3C+brNktxszBifMr5HrDjy6DrUVJJWFe
	+6c34B2nVcJlu62dVATQmUJPrenctZ4gVrGze6SQeiK0eJOFLGbCJHybeaAOr+8zi3hUX3f2jP0
	Eqq5eFipw9Liq7mXKUZ5SmFhfewr+EQF/G/Fd+8xR3UvvogPWIyzZ5z3yUbuMGyNoQgpuCUhOK2
	yVsVGpNuX+fltfINtXlXpZ7VlAvj8nERS7ag==
X-Google-Smtp-Source: AGHT+IFV8MLUB1BXD3moIleBpEEpLwODqEVtt3dDUQDxMwa40denbLv0lUqBXrbH+Dne/tQmY4Soag==
X-Received: by 2002:a05:6214:29ec:b0:72c:3873:2e52 with SMTP id 6a1803df08f44-738fb0ce2dfmr57649196d6.0.1757297615294;
        Sun, 07 Sep 2025 19:13:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-727f26995desm85411306d6.48.2025.09.07.19.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:13:34 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 53F1DF40066;
	Sun,  7 Sep 2025 22:13:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 07 Sep 2025 22:13:34 -0400
X-ME-Sender: <xms:zju-aG-HasYFMboQIUjBHCskS7RbknhcUdZWDJ7w6EvkinHu6CTD1A>
    <xme:zju-aB6iXB2Guba2JCqbqpFKMEvKIgGc0HQ7EN6FS-xSBukDUJBmm_-jDLuA2zzzM
    O78DKPZmD_9M5f-_g>
X-ME-Received: <xmr:zju-aP14-G21F09PPDK4lGSmaR0JWmAq6qG77H5WHoSWr3VNVc7Jiv0QzL7iusPreiKBR8lAHuo18YMlCRDAKvEfXuWfYCGK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetudelgeevudegueekueduiedtuedtfeejveejfeelhfethfdufeelveeujeef
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlohgtkhdruggrthgrnecuvehluh
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
X-ME-Proxy: <xmx:zju-aIzXZ92e_jbJCUVY2nBVSJAhPTa6vXX4i5Z4-u3OmLwlmjRSeA>
    <xmx:zju-aIlYcFsH2FhFRAg5SHmQ2NMGAWHytwm_HW5cRzVOgYAisXkKCw>
    <xmx:zju-aL9qogSwsxdq5IgAAzDtLszwNECdv9nOqS-uVFGPQdRHxZPTnw>
    <xmx:zju-aDrMZziBrzRcHzCyLcg338uJHKu8nK_jmyT7FaTcduHCLJbQlg>
    <xmx:zju-aPKsB5ovIsQedyVbru88ox4f0qV-iqoFwMVVOMzmObKSAPCar3M4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 22:13:33 -0400 (EDT)
Date: Sun, 7 Sep 2025 19:13:32 -0700
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
Message-ID: <aL47zBoNpvjYxec5@tardis-2.local>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
 <20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com>
 <DCK43W485VCY.3KE72NNMDP32D@kernel.org>
 <BD4724FF-4AB7-4551-B71C-C22E6E709F19@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BD4724FF-4AB7-4551-B71C-C22E6E709F19@collabora.com>

On Thu, Sep 04, 2025 at 12:15:43PM -0300, Daniel Almeida wrote:
> 
> 
> > On 4 Sep 2025, at 12:13, Benno Lossin <lossin@kernel.org> wrote:
> > 
> > On Thu Aug 28, 2025 at 10:52 PM CEST, Daniel Almeida wrote:
> >> In order for callers to be able to access the inner T safely if T: !Unpin,
> >> there needs to be a way to get a Pin<&mut T>. Add this accessor and a
> >> corresponding example to tell users how it works.
> >> 
> >> This is not useful on its own for now, because we do not support pin
> >> projections yet. This means that the following is not going to compile:
> >> 
> >>    let mut data: MutexGuard<'_, Data> = mutex.lock();
> >>    let mut data: Pin<&mut Data> = data.as_mut();
> >>    let foo = &mut data.foo;
> >> 
> >> A future patch can enable the behavior above by implementing support for
> >> pin projections. Said patch is in the works already and will possibly
> >> land on 6.18.
> >> 
> >> Link: https://github.com/Rust-for-Linux/linux/issues/1181
> >> Suggested-by: Benno Lossin <lossin@kernel.org>
> >> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> >> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > 
> > Reviewed-by: Benno Lossin <lossin@kernel.org>
> > 
> >> ---
> >> rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
> >> 1 file changed, 25 insertions(+)
> >> 
> >> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> >> index 9242790d15dbf65d66518d060a8a777aac558cfc..7191804a244da05db74294fdec598f1a4732682c 100644
> >> --- a/rust/kernel/sync/lock.rs
> >> +++ b/rust/kernel/sync/lock.rs
> >> @@ -245,6 +245,31 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
> >> 
> >>         cb()
> >>     }
> >> +
> >> +    /// Returns a pinned mutable reference to the protected data.
> >> +    ///
> >> +    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpin`]
> >> +    /// types [`DerefMut`] should be used instead of this function.
> >> +    ///
> >> +    /// [`DerefMut`]: core::ops::DerefMut
> >> +    /// [`Unpin`]: core::marker::Unpin
> >> +    ///
> >> +    /// # Examples
> >> +    ///
> >> +    /// ```
> >> +    /// # use kernel::sync::{Mutex, MutexGuard};
> >> +    /// # use core::pin::Pin;
> >> +    /// struct Data;
> >> +    ///
> >> +    /// fn example(mutex: &Mutex<Data>) {
> >> +    ///   let mut data: MutexGuard<'_, Data> = mutex.lock();
> >> +    ///   let mut data: Pin<&mut Data> = data.as_mut();
> >> +    ///  }
> > 
> > The formatting looks off in this one, there should be 4 spaces of
> > indentation here; there are also 2 spaces in front of the `}`.
> > 
> > Also `Data` implements `Unpin`, so you're not following your own
> > recommendation from above :)
> 
> I´ll fix this :)
> 

If the fix is small, feel free to send a diff and I can fold it when
queueing (i.e. no need to resend the whole series). I'm trying to send
it to tip before -rc6 so there will be some more tests. Thanks!

Regards,
Boqun

> - Daniel
> 
> > 
> > ---
> > Cheers,
> > Benno
> > 
> >> +    /// ```
> >> +    pub fn as_mut(&mut self) -> Pin<&mut T> {
> >> +        // SAFETY: `self.lock.data` is structurally pinned.
> >> +        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
> >> +    }
> >> }
> >> 
> >> impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> 
> 

