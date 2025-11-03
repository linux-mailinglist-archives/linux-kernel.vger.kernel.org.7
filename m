Return-Path: <linux-kernel+bounces-883715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A2C2E2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF1E64E1C43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001362D47E6;
	Mon,  3 Nov 2025 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1wsCDHt"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01D2D46CC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206034; cv=none; b=fSI7B354AvYC3s6l9SK5wbTP5XgTCF1bOuejjUxBFg5/HdgYknjiGE25yHhuDJICJ0RE//8rf30LuhgfuunnSDCbi+pY4lcvDf6HC/Y661BIaP1oL8jVZn+bvTmY4ndhrOVZ2xiObkKabQFXVTwol/L4+k+WMp9zaLoLEPtSfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206034; c=relaxed/simple;
	bh=M5BLtt0oJ1C7Mj7ZYqd3ehmQGMSK5z0x1HaTkJAWhfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCyLkZcQW6NUCZTtxPkJcatJITYcfUzu7cz2wfds3zZDwDGGKUdZVVouqy64XWoPKjHrI/64NFqDYF4vJzcNMiuTwzK6KHwanVDtaQq88ljrEwetmM742zq4mXgIDhJovf2k4yWntRBg1TboUU5g4YaFW/XRrN1Jt/VH/6qCMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1wsCDHt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426f1574a14so2985632f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762206030; x=1762810830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5BLtt0oJ1C7Mj7ZYqd3ehmQGMSK5z0x1HaTkJAWhfI=;
        b=C1wsCDHthn2lH4R4xGoj7Jo6aRLkfyxAU2jWKhpGrZF3jU5mSA2fTKN/gb9NdxsnBw
         6r/9NiZrIbm2V1WD+6i/p6YLyFPop+AebZNlYjTwTI09O3ABy8mrZNuvPnWx9FBEllUN
         2Szn2nbAKbUXVzBw7Ymqf6gbRYYDAd9JTSGi25v8e53aXLKWpSoYJG9OxgZKSZ2kMZWS
         6u7HutWKOmTBtYqGIihBHzIkF1MTlaPACWq4Jdb2ezdZzYQ4Xyn4hIJRaOK9tb5IKGvU
         ghYq+7G88BhE75qLwToh8Tu+f9+ryHqilgxjY6imkCFIh/EEzTTyK2JfK7b4PiZABmP9
         6DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206030; x=1762810830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5BLtt0oJ1C7Mj7ZYqd3ehmQGMSK5z0x1HaTkJAWhfI=;
        b=XlwbT0kDsG1Q86nKC/rXqvmWpVg8O1u+u8whTeOji/TycQmAQdykiQpXcE9iMKhtlC
         EGyZkd9x9KwkEWQlOpne+Zrf/v4S3dOH1s8nV0vAr4Kh9iln0K4PpgwFz5X5/IJZblIo
         a2AHT3i3Iy2+TOvUaIc8xFptkTzxWUsN0I+GnpZOXSeik6XRC9p2KGi8YC/+RhJ6jX66
         yM6MnkCJ/R+0Vp089E3zAGfZXb19ShpVYQrEVJcCSZxE/Zom+Y0k7elR7ZNXTR/FO3uV
         M2w2+Ix5QmREgEJ9q/1fpof6n4pECKGrXEz4YbdzMjoHYgUcZW5dwBdyz11h/6kt2V5U
         YYbg==
X-Forwarded-Encrypted: i=1; AJvYcCUHgXXTvbxe68Lf74Y8y8QuJicUe6XhzIxV6JElgL5HysbSkQq0Lqm8FWWnagb7E4nQVoEkAh4G3JgxABI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyusTPBJeWj+SbYysRox97PnYO24L0jQB4RqXrI4eq3YQ/6IgBx
	iCIs2sQ9c7qCzixo+eRUTTb8QtEIluE2pBSf8yymLFnEQ8S3ns93stwUTqAzAHvKKWPMbWcrhdi
	J8w2CEMd+vQpeE78MqXw+9f/k5QXyIRRVCddOXSGb
X-Gm-Gg: ASbGncuDsdTGo4FuUM1+YZe1Aj19+qsdDPgdl2b9fYz8sazTtE02wL1JbGtN9x1MYbG
	Rkov2AT82l28lZajwtaAVoWCdBwyNSECTCHstCvH+CUCXVkkTNFh3oLW96Jcle2AXuMVUwztCzP
	5JO81tJPEdDBxUeDoIljnZS/ehNEZYz5rQoNU2Qsm/fYBTCaqmHsK29VomyrEBiMzKSmcA+cwJt
	HDo0vk/wpCLlVew15RsDbPu8zV0Ld47bebLihFZmSTNLgDDYbkZFKgc9EgBIg==
X-Google-Smtp-Source: AGHT+IEuFnIaZN6WfGMOdc0tXnKdQIIdvasSa9Vioulg9CkoAWPpV2bvhMhTEfw0tHc5BmSkqWg4m2ehKMYVnHNRZzU=
X-Received: by 2002:a05:6000:41fc:b0:429:c505:99d0 with SMTP id
 ffacd0b85a97d-429c5059a93mr9269366f8f.25.1762206030384; Mon, 03 Nov 2025
 13:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-4-32822d4b3207@google.com> <aQEOhS8VVrAgae3C@yury>
 <aQE6FOn_9Z84NMnG@google.com> <aQkcuwLWy5jIQKOm@yury>
In-Reply-To: <aQkcuwLWy5jIQKOm@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Nov 2025 22:40:17 +0100
X-Gm-Features: AWmQ_bkz6iBdC1Ep-0LvTCOaYpRdM6fDpRDhzWWTVBeDRdoiR6bODU61VsV9rAs
Message-ID: <CAH5fLggeVXn-OGv8fgYUd3oHFyo7W7tSfi1Y0FJMkS2i9aVBmA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new ids
To: Yury Norov <yury.norov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:21=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Oct 28, 2025 at 09:48:04PM +0000, Alice Ryhl wrote:
> > On Tue, Oct 28, 2025 at 02:42:13PM -0400, Yury Norov wrote:
> > > On Tue, Oct 28, 2025 at 10:55:17AM +0000, Alice Ryhl wrote:
> > > > When Rust Binder assigns a new ID, it performs various fallible
> > > > operations before it "commits" to actually using the new ID. To sup=
port
> > > > this pattern, change acquire_next_id() so that it does not immediat=
ely
> > > > call set_bit(), but instead returns an object that may be used to c=
all
> > > > set_bit() later.
> > > >
> > > > The UnusedId type holds a exclusive reference to the IdPool, so it'=
s
> > > > guaranteed that nobody else can call find_unused_id() while the Unu=
sedId
> > > > object is live.
> > >
> > > Hi Alice,
> > >
> > > I'm not sure about this change, but it looks like a lock wrapping
> > > acquire_next_id().
> > >
> > > If so, we don't protect functions with locks, we protect data
> > > structures.
> > >
> > > If the above is wrong, and this new UnusedId type serializes all
> > > accesses to a bitmap (lock-like), or write-accesses (rw-lock like),
> > > then this is still questionable.
> > >
> > > Bitmaps are widely adopted as a lockless data structure among the
> > > kernel. If you modify bitmaps with set_bit() and clear_bit() only,
> > > with some precautions you are running race-proof. The kernel lacks
> > > for atomic bit-aquire function, but you can implement it youself.
> > >
> > > I actually proposed atomic acquire API, but it was rejected:
> > >
> > > https://lore.kernel.org/all/20240620175703.605111-2-yury.norov@gmail.=
com/
> > >
> > > You can check the above series for a number of examples.
> > >
> > > Bitmaps are widely used because they allow to implement lockless data
> > > access so cheap with just set_bit() and clear_bit(). There's nothing
> > > wrong to allocate a bit and release it shortly in case of some error
> > > just because it's really cheap.
> > >
> > > So, with all the above said, I've nothing against this UnusedId,
> > > but if you need it to only serialize the access to an underlying
> > > bitmap, can you explain in more details what's wrong with the existin=
g
> > > pattern? If you have a performance impact in mind, can you show any
> > > numbers?
> > >
> > > Thanks,
> > > Yury
> >
> > Hi Yury,
> >
> > This does not change the locking requirements of IdPool at all. Both
> > before and after this change, acquiring a bit from the pool uses the
> > signature &mut self, which means that the caller of the method is
> > required to enforce exclusive access to the entire IdPool (doesn't have
> > to be a lock - the caller may use any exclusion mechanism of its
> > choosing). In the case of Rust Binder, exclusive access is enforced
> > using a spinlock. In the case of the examples in IdPool docs, exclusive
> > access is enforced by having the IdPool be stored in a local variable
> > that has not been shared with anyone.
> >
> > It's true that the underlying bitmap supports lockless/atomic operation=
s
> > by using the methods set_bit_atomic() and similar. Those methods are
> > &self rather than &mut self because they do not require exclusive acces=
s
> > to the entire Bitmap. But IdPool can't provide &self methods. The
> > existing acquire_next_id() method has a race condition if you tried to
> > perform two calls in parallel.
>
> You can use test_and_set_bit(), so that even if multiple threads will
> find the same bit, only one will actually acquire it.
>
> > But even if we changed it to perform a
> > correct atomic bit-acquire, the fact that IdPool is resizable also
> > incurs a locking requirement.
>
> To address resizing, you can use RCU engine, so that resize is
> possible only during grace period.

Considering that the actual use-case for this already needs a spinlock
to protect related resources when it touches the bitmap, introducing
rcu seems unnecessary.

> > The only purpose of this UnusedId change is to make use of RAII to
> > automatically clean up the acquired ID in error paths. I avoided
> > setting the bit right away for simplicity, but setting the bit and
> > unsetting it in error paths via RAII would also work. But there would
> > still be a lock in Rust Binder that protects the bitmap without this
> > change.
>
> OK then.
>
> There's still no real users for the IdPool, so the above performance
> hints make no practical reasons. Are there any plans to actually start
> using IdPool in the mainline kernel?

Patch 5 in this series introduces a user in the mainline kernel.

Alice

