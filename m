Return-Path: <linux-kernel+bounces-898299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2BC54D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4638346B04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2E242D78;
	Wed, 12 Nov 2025 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLJ44Mbi"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6826CE02
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990511; cv=none; b=Kqj+fKoFFX6Q9jKHs6XtIzb5yM8T+p7F20SsluRGePyBb/cHBS1EOb07pzL5oy1PKBIdS334UI62wHgwltbkfdWueLThk34Vok1yUAi8Cy0abxLWFdM+BwhM6QaRPG//PKIFU7g4PkCG21fvliY+zTwq9XhTUY58qv1PFVAXvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990511; c=relaxed/simple;
	bh=4mflXfgXVT24C6CZ4udA49a2AIthJmldwzXgt3XntjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=amjAihYQ/UF2C4N4cojzhD5SG3pmNDqs5ZlPAg+4/KTcHiwhkhbmO+oWxem6VtT+s4g8CZTns5o6G08s1LOx5FGlH9SY2AJt2v/4Fts62S0s05oeJ6jOMRLxMApdAKbd+6/I94qRN4qsOpY06GAYDK1d01xnkUKXvaLXIbErb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLJ44Mbi; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so72586f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762990508; x=1763595308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHGIBzZPwCgBjyzoAu2uZEsfUL+sP5QWpRjxugQAeqE=;
        b=aLJ44MbijMXx9+vDrozQXP4mmnY8heEmWPJ12aj4tvdbKhI6zpI0QBPtAp9BmPqzDK
         BfoIR5anbDRl5Nevs9lAuiP7cJthAK2AA61WgNZA63RF2jo28/lkYMFYDAHkwCMCfPVV
         TNf7mcachZTGA4xdNY0D/pNt00UfDIaN6CKvmboMhMW9FC232szqvfgEe1U+fyywfWpw
         nLjrrxhE+rhTpgqiLdflj7bQV4MbEmQHMQvWX+0yMdwgoYrxumjjKXpbVu7vF8g0OiqR
         8+vSWXZ82C6n5x9W65gAiegwiMYmWsD3vrV9Ld9OfD2F0yTsW44Iw5/ZMYDpYZbr4MTk
         KWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762990508; x=1763595308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHGIBzZPwCgBjyzoAu2uZEsfUL+sP5QWpRjxugQAeqE=;
        b=MM7Nahr9kyPIqXEcMD11LNORsJ9wKhuynRFa+npvYZHCIjsAk1UOMSTsWoxGuLK/f8
         0fQKAFHOppmdspMiuHCMXwh6OeE8q/dkUR5eakSct98eEQGVeRHvQS9WSx3rmyhb1gut
         St+nigBsWy0QRj3KC5N6bahzWIsX88YjaBz4b/ZKUfdgC1IT8tfpvyzQjEdJJ9TwWGy8
         W2uoWlymPcXhMU97SGPkunvkLoEYhZ2RIPSGOf5GGSB+Z0dUP7ET9UAKr0lxztoseOek
         F88ftRc0yU6ssX2lIOU1SWX8BfxmDX5/yRU8L2vVscgnN6kkUS4DsWbg1EQOQDOsWSNU
         AxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQtP06Bs7vGF0WukysrZsvgKPYBpVOqJCdu/Nou+A9pO4UpD8cmmCmZlP5fqtmz9JcI9wenmQK2anYvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1CItggZoJ+IZHGH6Vnu3nCevYHBxm40iSSkEPsuTd7iH//4N
	zfrBE/Riefx0xiP8kNFUxa5eXuqxStZJCyIBXp341UuOmN0SYQCOSDekAPX5QH7txi8rkEP1oEu
	LjPpSbaTbMcGu3X/PJg==
X-Google-Smtp-Source: AGHT+IEId1v5duu3TRKOpet7fbCZD1zVCY8IAgfk+57gsEvGnUh+PLJNGxA0odr0Hgnj4bvYOByusBh9faYt/tA=
X-Received: from wrnm1.prod.google.com ([2002:adf:e941:0:b0:42b:3021:cd6a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:440e:b0:42b:530c:d8b6 with SMTP id ffacd0b85a97d-42b530cdae6mr283844f8f.61.1762990507739;
 Wed, 12 Nov 2025 15:35:07 -0800 (PST)
Date: Wed, 12 Nov 2025 23:35:07 +0000
In-Reply-To: <aRTbX6RPsFf0NW48@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-6-8b9d7c7eca82@google.com> <aRTbX6RPsFf0NW48@yury>
Message-ID: <aRUZq0Fo6T1f3lOD@google.com>
Subject: Re: [PATCH v5 6/6] rust_binder: use bitmap for allocation of handles
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 12, 2025 at 02:09:19PM -0500, Yury Norov wrote:
> On Wed, Nov 12, 2025 at 12:47:24PM +0000, Alice Ryhl wrote:
> > To find an unused Binder handle, Rust Binder currently iterates the
> > red/black tree from the beginning until it finds a gap in the keys. This
> > is extremely slow.
> 
> Can you share performance numbers? 

I have not benchmarked it in the Rust driver, but it replaces
potentially thousands of calls to rb_next() with a single call to
find_unused_id(), so I'm feeling good about the performance. And the
equivalent change in the C driver was done because this particular piece
of code was causing contention issues by holding the spinlock for a long
time.

The characteristics of this collection is that there is one per process
using the driver. Most processes have only a few entries in this bitmap,
so the inline representation will apply in most cases. However, there
are a few processes that have a large number of entries in the 4 to
maybe 5 figures range. Those processes are what caused the contention
issue mentioned above.

> > To improve the performance, add a bitmap that keeps track of which
> > indices are actually in use. This allows us to quickly find an unused
> > key in the red/black tree.
> > 
> > This logic matches the approach used by C Binder. It was chosen
> > partially because it's the most memory efficient solution.
> 
> That inaccurate. You are adding a new data structure (bitmap), advocating
> it with an improvement on search side, and that makes sense.
> 
> But now you're saying it's also a more memory efficient approach, which
> doesn't sound trivial because the most memory efficient solution is to
> bring no new data structures at all.
> 
> I guess you meant that bitmap is the most efficient data structure to
> index used/unused nodes. If so, can you please rephrase the sentence?

Yes I can rephrase.

Adding more data is of course always less memory efficient. What I meant
is that this is more memory efficient than the competing solution of
using an augmented rbtree that Carlos mentioned here:

https://lore.kernel.org/p/aC1PQ7tmcqMSmbHc@google.com

> > +            if let Some(res) = refs.handle_is_present.find_unused_id(start) {
> > +                match refs.by_handle.entry(res.as_u32()) {
> > +                    rbtree::Entry::Vacant(entry) => break (res, entry),
> > +                    rbtree::Entry::Occupied(_) => {
> > +                        pr_err!("Detected mismatch between handle_is_present and by_handle");
> > +                        res.acquire();
> > +                        continue;
> 
> At this point you've detected mismatch between two linked data
> structures. It means that one of them or both are corrupted. To
> me it looks fatal, and your pr_err() confirms it. How could you
> continue then?

Although we should never hit this codepath in real code, I don't think
we need to kill the kernel. We can treat the r/b tree as source of truth
and adjust the bitmap when mismathces are detected.

I could add a kernel warning, though. That shouldn't kill an Android
device.

> > +                    }
> > +                }
> > +            }
> > +
> > +            let grow_request = refs.handle_is_present.grow_request().ok_or(ENOMEM)?;
> > +            drop(refs_lock);
> > +            let resizer = grow_request.realloc(GFP_KERNEL)?;
> > +            refs_lock = self.node_refs.lock();
> > +            refs = &mut *refs_lock;
> > +            refs.handle_is_present.grow(resizer);
> 
> Is it possible to turn this block into a less wordy statement? Maybe a
> wrapper function for it? Ideally, the grow request should be handled
> transparently in .find_unused_id().

I can extract this block into a separate function, but I think it would
be tricky to move the entire logic inside .find_unused_id() because of
the mutex lock/unlock situation.

> > @@ -905,6 +924,16 @@ pub(crate) fn update_ref(
> >                  let id = info.node_ref().node.global_id();
> >                  refs.by_handle.remove(&handle);
> >                  refs.by_node.remove(&id);
> > +                refs.handle_is_present.release_id(handle as usize);
> > +
> > +                if let Some(shrink) = refs.handle_is_present.shrink_request() {
> 
> This is questionable. Shrinking is usually the very slow path, and we
> don't shrink unless we're really close or even inside the OOM condition.
> 
> In this case, shrink_request() on average returns false, but it's
> O(N), which makes _every_ release_id() O(N), while it should be O(1).

The current implementation of shrink_request() will refuse to shrink the
pool unless the largest bit is less than 1/4 of the capacity, so it
should not perform the expensive operation very often.

That said, it does call find_last_bit() each time, which I guess is
O(N). But my assumption was that find_last_bit() is cheap enough that it
wouldn't be a problem.

> Consider a very realistic case: you're destroying every object, and thus
> removing every ID in the associate ID pool, doing it in LIFO order. That
> way you will need to call shrink_request() about O(log(N)) times, making
> the whole complexity ~O(N*log(N)); and you'll have to make log(N)
> realloc()s for nothing. If you release IDs in FIFO order, you don't
> call realloc(), but your shrink_request() total complexity will be O(N^2). 

Even if we end up making log(N) reallocs, the total complexity of the
reallocs is O(N) because the amount of data being reallocd halves each
time. So the total number of bytes copied by reallocs ends up being:

    1 + 2 + 4 + 8 + ... + 2^log(N) <= 2^(1+log(N)) = 2*N

which is O(N).

Of course, deleting the corresponding entry from the red/black tree is
O(log N), so it's still O(N*log(N)) for the N deletions from the rb
tree.

> Can you compare performance numbers with and without shrinking under a
> typical payload? Is there any mechanism to inspect the ID pools at runtime,
> like expose via procfs?

We expose the contents of the red/black tree via the binder_logs
mechanism, but that doesn't show the *capacity* of the bitmap. Only the
index of the largest set bit.

> Can you make your shrinking logic conditional on some reasonable OOM
> heuristics, maybe OOM event driven?
> 
> And even without OOM, you can safely skip shrinking if the number of IDs in
> use is greater than 1/4 of the capacity, or there's any used ID with
> the index greater than the 1/2 capacity.

I guess we could register a shrinker, but I don't think it's worth it.

Thanks for the review!

Alice

