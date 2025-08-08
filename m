Return-Path: <linux-kernel+bounces-759980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5876B1E537
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37241799D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893962641CC;
	Fri,  8 Aug 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zH2v3BAk"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32526A0EB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643690; cv=none; b=W8si1pSayw5irRxg1d32Shd54y1gc1yp4aGc30F4hnv2ofRXW10xo+jbtmm8JlL/bphe95RXlsoLwGk90R4rZ/UXt9CZr3jrbSUPQoe6ziAA1Sey0hZI1zPo8s/DssxHVJoR5LrYGwaxCLP9tzaLGmLVQDEzLI2tujJqS64rpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643690; c=relaxed/simple;
	bh=S5BbbIBMFeUFbhVaPxRSNFTw0qJPKwRkfes0nfiMt2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jm68Zqtu61rnONlw9oH4CswyMNdZhouEkJV4hOkQMUMMJZ7LZ/uydpi934y6sb3L0uqCGNtZSMH+E0hrjOd05btH3Bzp8+laJu5eHwee5C2Dk8elJDC470TckvkOe1fC0CIwfalQaQg4xw+gnvNptDYVeBEbSjbO3IcFygQsTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zH2v3BAk; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b793f76a46so1321199f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754643687; x=1755248487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hx28fY710hmZoCtY9ahIDUPzjy3OpjuLmB7MR5G0+g=;
        b=zH2v3BAkT80x+kOFvVoarcmDRXobGOzWMroobniNI+b+YFCXidrBUdOWNAyHQLaC/Q
         /FQ/fy/Mj6XcRMn4nHICjokz66qzuCEo5nmg4SWUwDhjJESHIP0AL1hiEex/qmmPhyWN
         g1c2ZeKjX7K/+AEUwTjmrFdHcalwSelKgWlQwPBQPZyUSZ0mnqDuQ+ZL5DW8TmG6t/V6
         Ik4vg18oMiPvcHSn9MoP2KhaX/zizcMElbUxlixnoQPu+JfjDgFL5kEXttipGK+gHVso
         ccgUd/lCzJTcj6qAPAkHZUJoNEUJBLTeBUFgmtEoYBXkc8RjznYt0+FWhit4e14vBwmO
         5oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643687; x=1755248487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hx28fY710hmZoCtY9ahIDUPzjy3OpjuLmB7MR5G0+g=;
        b=KPU2Za5AUQU2nRoBQ1NbRFFVCn4vLFd0AXnQckcVmwD7L7ASqoRTc8MWAgKCsIFNYK
         hbEvtSndQvS2CMPzBCzU8Kz4e5Sviv1u7HvEhk3oDWK3PiTj+ORWBC3TfRrEg3e0dzDW
         vksDrT3as73moMKiwKFESEbOIBGtTeLb7LccVaGu8VwkbURyojrAWE57zfUaNfHYDi6F
         azXYg6c9tQtQVEw4JPgjcWWB8rKLW7e9YYBah/PJwthET8Pgw0CzuvJV8HWfv66o5pM8
         ijxhidcxnHl0OIntd86rc43FjmfitsR6Mg5GTbkFo5S58KKklQwE5KYg0c8hPT0rKNbN
         8MTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/imi7tZFd23Jyuzqpmh2ZsStvM1WYo8HufaqhUPqsOfVYIotK+iRryvfSs/cg11KzH2GkH/io1L0L00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eaziEpE+n/y3x/BOAHGiW4MPaOwtpSTdM2bm2h2FIYa4HQLY
	+CoAhAevORDSWskKTeqEQIcbeGN/Dl1sKBT3ks4B/rvL+fxrfQf0nQ9AyaK+kBUedckmtGMUOOu
	ggE4kVx3+t2mk2mgyRw==
X-Google-Smtp-Source: AGHT+IGVMPGcjfQeO4iXzfFefGzFkTgDTQfi5FOkH2u+QnZpAFGbYE5Kja9UGZFhuBG1gDCKVyHoZXsb7yxPdmY=
X-Received: from wmbfa15.prod.google.com ([2002:a05:600c:518f:b0:459:d639:5949])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1885:b0:3b7:8146:4642 with SMTP id ffacd0b85a97d-3b900b5031cmr1618025f8f.20.1754643687418;
 Fri, 08 Aug 2025 02:01:27 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:01:24 +0000
In-Reply-To: <DBWGKO6W6BK3.1ZTUQ8EI9LFJ7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807121011.2317762-1-vitaly.wool@konsulko.se> <DBWGKO6W6BK3.1ZTUQ8EI9LFJ7@kernel.org>
Message-ID: <aJW85LX_mp6pOBM6@google.com>
Subject: Re: [PATCH] rust: extend kbox with a new constructor
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.se>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 07, 2025 at 09:56:09PM +0200, Danilo Krummrich wrote:
> On Thu Aug 7, 2025 at 2:10 PM CEST, Vitaly Wool wrote:
> 
> Please start the patch subject with "rust: alloc:" and make the subject more
> concrete, i.e. name the constructor you add, e.g. "rust: alloc: implement
> Box::pin_slice()".
> 
> This makes things much more obvious when using 'git log --oneline'.
> 
> > From: Alice Ryhl <aliceryhl@google.com>
> >
> > Add a new constructor to KBox to facilitate KBox creation from a
> 
> NIT: You're adding it for all allorcators, hence "Box".
> 
> > pinned slice of elements. This allows to efficiently allocate memory for
> > e.g. arrays of structrures containing spinlocks or mutexes.
> 
> Sounds reasonable, can you please mention where this will be used?
> 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> > ---
> >  rust/kernel/alloc/kbox.rs | 51 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > index 1fef9beb57c8..74877afab0a3 100644
> > --- a/rust/kernel/alloc/kbox.rs
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -290,6 +290,57 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
> >          Ok(Self::new(x, flags)?.into())
> >      }
> >  
> > +    /// Construct a pinned slice of elements `Pin<Box<[T], A>>`. This is a convenient means for
> > +    /// creation of e.g. arrays of structrures containing spinlocks or mutexes.
> 
> Please add an empty line after the first sentence.
> 
> NIT: "slices of structures"
> 
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// #[pin_data]
> > +    /// struct Example {
> > +    ///     c: u32,
> > +    ///     #[pin]
> > +    ///     d: SpinLock<Inner>,
> > +    /// }
> > +    ///
> > +    /// impl Example {
> > +    ///     fn new() -> impl PinInit<Self> {
> > +    ///         pin_init!(Self {
> > +    ///             c: 10,
> > +    ///             d <- new_spinlock!(Inner { a: 20, b: 30 }),
> > +    ///         })
> > +    ///     }
> > +    /// }
> > +    /// // Allocate a boxed slice of 10 `Example`s.
> > +    /// let s = KBox::pin_slice(
> > +    ///     | _i | Example::new(),
> > +    ///     10,
> > +    ///     GFP_KERNEL
> > +    /// )?;
> 
> How would a more complex example look like where the slice items are not
> identical, i.e. the impl PinInit<T, E> objects returned by the FnMut?
> 
> Do we need a temporary Vec for this? If so, it would probably make more sense to
> have the following signature.
> 
> 	pub fn pin_slice<F, I, E, Arg>(mut init: F, &[Arg], flags: Flags) -> Result<Pin<Box<[T], A>>, E>
> 	where
> 	   F: FnMut(&Arg) -> I,
> 	   I: PinInit<T, E>,
> 	   E: From<AllocError>,
> 
> 
> Where Arg is some generic type containing the arguments passed to the closure
> to create the impl PinInit<T, E>. For the example above Args could just be ().

Forcing the user to construct an array of the appropriate length seems
unfortunate. Right now we provide the index being initialized, which you
can use to index an array if that's what you want.

I used a temporary Vec because its destructor does the right thing we if
exit early on error.

Alice

