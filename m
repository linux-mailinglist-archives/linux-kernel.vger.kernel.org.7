Return-Path: <linux-kernel+bounces-883697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B368C2E22C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760373BC101
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D2A2D0C99;
	Mon,  3 Nov 2025 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8ZQJtmv"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D72C375E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204864; cv=none; b=UpGRXLvRw6MqnwaXo0nfShU6NDJbsiz5NJuvDYTP/sv4ApV//kigUIjiqu6Suhg1oDzgH3UzgxCBkTVzxo06vJJq2EuD0/cUhZK+NrA/D3Cmxt0rYdYvw/DxsKR3rO7IwFLBVemE0eoSx8yvMHM3i/q3/6xZvq20Eza762+v+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204864; c=relaxed/simple;
	bh=i9NQQoG0WAodkG2cQoejmNP+ufomDOB66xEEdAsBtaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gs19zOv2hBTPVkzGzmj3FEtchGoOS7MuNXTiE1ITe3ZjKyTVqz2lKxLj4bgHM/JbAGhmpBYuwe9bmf66XfWN9La0Yi53jKbSBUOwlblryknMHMUFDl0otQKlUNAcT4Edrs7x3Qnt1yDzRlCZ9qAw6alrMolrQVzzlXLnhMwNrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8ZQJtmv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88051279e87so18767986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762204861; x=1762809661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V+fyoi5TB82zTmtTdng+j8xd0Sq8XLzsS2JilniK7bw=;
        b=C8ZQJtmvIMGSgkqD6j/o+ECPYwo+RiZ1LjqakFikhMdkHnN7lRITnRHyLQIeueuqrv
         LNvE7zby+SwLOe67wu7TLICXZEGr6z1tSHkWVuk5tu2rx6usvN6oxaTRpguuncH3p66z
         yZkZnNBETnN++DkmNMFRo0ORgjOSA9gU0u0b/50Njy04SodUhsIfLiP7OjYBgcuj6AJf
         hzxnO9t22W5+lGPjoWebktj75fK7p6fHgg9Rg20uNkcxY/R6X414eMxryo6zunNyvR8f
         jmuGSwEbRXllzXxT8SNAwxLbtKJscyvit6PeXchVwdQ53zXNi7sLfjfSvo8wwGaVbJFf
         dtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204861; x=1762809661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+fyoi5TB82zTmtTdng+j8xd0Sq8XLzsS2JilniK7bw=;
        b=Cz9+YqhL5ulephVc6rR4YAzY+Qi281V1QAZRlypqHB9XDU7N1b7lvnVfhM0crj7H5Y
         NLbaq3aoIYQf/dRKiApyxKULS/3PQOO4xe2AG1kWVLAx5EKaAVno2eqqlzW82GjXuTYB
         xxbiBUgU9h/fEqnl6JdUe1h2hr2yc0HwuJYqTTHNEOgIu5lbpQPuz1dvPEPfWyDSdxr1
         /p8bqQEp+/QuWQmU70ONEoRXvRWiDwBr2sVg1h5JaOI+3OnS9JOfR+1phuqgxWLBS+fv
         z5iX5fktTPUQtW2O8qwsCMwU+qrrvBEsRiU6hR880nJAo+ZVqhJo9/0hcNO33PsKjsV8
         xFgg==
X-Forwarded-Encrypted: i=1; AJvYcCWha9sGa0oWDqrqo9iS2BMR6/HmyMe4t6iQKZUZyElflOoAoukVO2NLQm8KID2pyTzjSpyohN3slynPPTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUxYYIeoYDbHe3VzhCnIA/MTdnMnm/6viWlEo+G5VK3lpt7DP
	mX8UryVLgyDgJyRyneISIPR93PaFJVYBuHguWPjCKzvyUgcHRSx6jU6O
X-Gm-Gg: ASbGncv18ouXvCHSacUwEsQXyQu0D0T4Q97hENIBriuCAWAn7RDSrQGCYyPAFndImgI
	czgKTmLvB0Csr1sZZrwf+ahJ+5575yWGeTa/vs1qRDQdtdAXaXrZXAPqpXNpTlvE4g5efn72QLq
	hFzJr5a4dEbfcpCBJRsvMlIPp4RFd8g9vgEu/jMpiHVmsOyb+xJLAweIzLE2S2MQzpUfJ8dQrKw
	KqaWdXPEhnuGr9DVI+QPTY48g+CJiC8ZNOhM38cX/dOgay4xw0a5rwRsYbV+TDkKgplRAIgrXqF
	5h4qIWc19iLYMvZVcn6BRqsHdcdubjWBIbdsIoU83h2+M2Pb3oI6ojijHbmdZl6nQ5ug/NzErvZ
	FsIZBY4PTRTI+60ghLBMzO8tnQqyAHFdD838ynF/S+HhhLyYxayecZve0wQH9B4UO6o6koV2B1y
	ch/tVa4tk=
X-Google-Smtp-Source: AGHT+IHnaEAKMgi61yPbVWzk/Uif2pvSAYnMIcXNyjWts9mwpC/T1DSAOow3x1Mx9USJ5wUFa838bg==
X-Received: by 2002:a05:6214:3319:20b0:880:5cc1:6923 with SMTP id 6a1803df08f44-8805cc16b4dmr33476206d6.36.1762204861186;
        Mon, 03 Nov 2025 13:21:01 -0800 (PST)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db32acsm9101786d6.3.2025.11.03.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:21:00 -0800 (PST)
Date: Mon, 3 Nov 2025 16:20:59 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new ids
Message-ID: <aQkcuwLWy5jIQKOm@yury>
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
 <aQEOhS8VVrAgae3C@yury>
 <aQE6FOn_9Z84NMnG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQE6FOn_9Z84NMnG@google.com>

On Tue, Oct 28, 2025 at 09:48:04PM +0000, Alice Ryhl wrote:
> On Tue, Oct 28, 2025 at 02:42:13PM -0400, Yury Norov wrote:
> > On Tue, Oct 28, 2025 at 10:55:17AM +0000, Alice Ryhl wrote:
> > > When Rust Binder assigns a new ID, it performs various fallible
> > > operations before it "commits" to actually using the new ID. To support
> > > this pattern, change acquire_next_id() so that it does not immediately
> > > call set_bit(), but instead returns an object that may be used to call
> > > set_bit() later.
> > > 
> > > The UnusedId type holds a exclusive reference to the IdPool, so it's
> > > guaranteed that nobody else can call find_unused_id() while the UnusedId
> > > object is live.
> > 
> > Hi Alice,
> > 
> > I'm not sure about this change, but it looks like a lock wrapping
> > acquire_next_id().
> > 
> > If so, we don't protect functions with locks, we protect data
> > structures.
> > 
> > If the above is wrong, and this new UnusedId type serializes all
> > accesses to a bitmap (lock-like), or write-accesses (rw-lock like),
> > then this is still questionable.
> > 
> > Bitmaps are widely adopted as a lockless data structure among the
> > kernel. If you modify bitmaps with set_bit() and clear_bit() only,
> > with some precautions you are running race-proof. The kernel lacks
> > for atomic bit-aquire function, but you can implement it youself.
> > 
> > I actually proposed atomic acquire API, but it was rejected:
> > 
> > https://lore.kernel.org/all/20240620175703.605111-2-yury.norov@gmail.com/
> > 
> > You can check the above series for a number of examples.
> > 
> > Bitmaps are widely used because they allow to implement lockless data
> > access so cheap with just set_bit() and clear_bit(). There's nothing
> > wrong to allocate a bit and release it shortly in case of some error
> > just because it's really cheap.
> > 
> > So, with all the above said, I've nothing against this UnusedId,
> > but if you need it to only serialize the access to an underlying
> > bitmap, can you explain in more details what's wrong with the existing
> > pattern? If you have a performance impact in mind, can you show any
> > numbers?
> > 
> > Thanks,
> > Yury
> 
> Hi Yury,
> 
> This does not change the locking requirements of IdPool at all. Both
> before and after this change, acquiring a bit from the pool uses the
> signature &mut self, which means that the caller of the method is
> required to enforce exclusive access to the entire IdPool (doesn't have
> to be a lock - the caller may use any exclusion mechanism of its
> choosing). In the case of Rust Binder, exclusive access is enforced
> using a spinlock. In the case of the examples in IdPool docs, exclusive
> access is enforced by having the IdPool be stored in a local variable
> that has not been shared with anyone.
> 
> It's true that the underlying bitmap supports lockless/atomic operations
> by using the methods set_bit_atomic() and similar. Those methods are
> &self rather than &mut self because they do not require exclusive access
> to the entire Bitmap. But IdPool can't provide &self methods. The
> existing acquire_next_id() method has a race condition if you tried to
> perform two calls in parallel.

You can use test_and_set_bit(), so that even if multiple threads will
find the same bit, only one will actually acquire it.

> But even if we changed it to perform a
> correct atomic bit-acquire, the fact that IdPool is resizable also
> incurs a locking requirement.

To address resizing, you can use RCU engine, so that resize is
possible only during grace period.
 
> The only purpose of this UnusedId change is to make use of RAII to
> automatically clean up the acquired ID in error paths. I avoided
> setting the bit right away for simplicity, but setting the bit and
> unsetting it in error paths via RAII would also work. But there would
> still be a lock in Rust Binder that protects the bitmap without this
> change.

OK then.

There's still no real users for the IdPool, so the above performance
hints make no practical reasons. Are there any plans to actually start
using IdPool in the mainline kernel?

Thanks,
Yury

