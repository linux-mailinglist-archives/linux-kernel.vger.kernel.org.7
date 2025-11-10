Return-Path: <linux-kernel+bounces-893460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E18C47782
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190F518929B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852DC329C5F;
	Mon, 10 Nov 2025 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+3I4qJu"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA9B329C43
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787398; cv=none; b=S7PMrl1BwMrYQQlYQCCQ1U2WXitNaZJKOkn72blPGQ6cvomM4pKHjyN3+0Rt4g2Y6pRTePQpw6pKwvTJVOkT2wBwwzX+VPQBCMLrk7oxeOoPtZcJV42pPD+AGK9VQY9+kCE52wzIVa4CB2xjbqxop6zqqLb9VGJxHIPcF9NfQmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787398; c=relaxed/simple;
	bh=Rj9G8IFEjlzisLHEn/O9WORrl+0cZLi6zlkht4lv9Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgDaQvGLGdf+cLBA+Qb/WSK5PG28eNQccIYe9roYfgbxayFZW5JR9Kx1zUNsauNRpgKIaCO3yRZU7YPiWSLM6Nd+rYDvU4OdtvNdb0G4/hc2tR3ACEwOllwCKkM+EBVhf8l4ojOoJzPyJfc0PAjhezrN9r1+cw6tCu9juyN3CzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+3I4qJu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78665368a5cso28871097b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762787395; x=1763392195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KbWyUnaltl9mde3lXFQpujvquSvJb+LnnWGVBKXm7v0=;
        b=d+3I4qJuPpBCju+7Ga5lk1Mav2ICwuVB+UMEIssiIsD+SOCMAESN+JpjQQ1AxUi2Xc
         H2viDCx6fMXUb8WGaKsUzHqto4/S9yMLpR1VKWWjEw6bbyxbe9W1P7s0vipwzk1ua291
         Q8y+i1mxx1Y4bHuphNYNtUfDZ9SqbIaZjGw/gAWWQAd3Cl3ioLoLfwhNun8u08ZYGQjN
         iJelm/oXPQGDUYw8K4wy8jjayaKlNzJmQ6r95H75BjIV6yxaiV42iPTqvd/pdhQ5Ujpc
         qRIK+SYlVLkKPVFC1UCWUmh0neq+3x7gm36OE6SO3wJKCIiAgXwZReX6xNhgfNj6p7If
         /0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787395; x=1763392195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbWyUnaltl9mde3lXFQpujvquSvJb+LnnWGVBKXm7v0=;
        b=IvlBexCBVH3GcLthNtQyVtdd/cMvZO09OaaZinaSDiXsohuK6NWbBK81OKH12H5BrF
         D8aylOHQamoZf/Zxkk8c6cps+PxaBmkcKXTHuDz2p+9DLN/wgMn+ZsU2V6dw+nqYEE65
         XxRFrW0u1csO2F+c8EVJIHYmx68BzCq30+OJqwuhbxkKfgit4ZlqD6KGqM8M5miAUvCO
         Vi3TMAw7xpIYPbQGdb2KIeStpRUZ/sqkIHCvzKvo4IoXtlDqsmd7bcSl63XnREsPgk2B
         zuK4G+krpnCpTp1D1OCp+bxlTSMQoxUsgDit5bx/+Pqvcn8I9dexEY0a+nAbQ5IvXZWK
         2JNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzvDoPAzauasRzcefF08r42Byguc2SG59eeQbS0Y27eeTJGyO/waj5TwaEDivEzP0QtRwYKygXeLhJJdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4EC6fs3W8hf2aOdhbjvC9t+Gnfp4IPDO2RnfC1P6t9vUxOFFv
	LkR09s4gL61raDuiojpVQTp7HjnhBNMxsmWxf4TOfHOxkJhUkJc80cHM
X-Gm-Gg: ASbGnct0RXkHdoUPvAC7OiKy++Gk7h8zw102ulGvK9pKk6zIoIvCI/s4i4Y8KSzi9ia
	heFkDJbkINSXeouR0I/18vhJPIuw7+8ar/Z2l5rvYoN4DIoX4LbJY6W/gUnSclwi8DTkbfVt4Kj
	P0fia1Z3NTAgW/iORu270zM8OJvbMm/AkRTNc9YuOmD+/ngx8sIZAwpe/gyj3y5dHY/AkTSKLrk
	J9JjxrKCSLwZE9wFS3G4xJDF5J6yRNAdiolXdOdur+tLbjBTnOlfUzDSZ1NKEqtirmEE3E4IZWW
	HMFhNotz4p5aUUdDedWPBRLgqV/nXdweSa2wGMX5n+1jLrvmwebIbJqlCQWqPBGGjETesAfjTAu
	UZcCqNqYes1a7+QeIagEOovZAG27dZxyuyLWMQnuzkSfhW62YnLb14mrAbC8aInoPK38P2MWxQ/
	BH8/OjuPiS1hgJMs/Njz766X/ZD7L5n9as
X-Google-Smtp-Source: AGHT+IFrAjrniG9BqJ1S9xPDXhNH4sZLvzscceoEFbHM4PmfHq9Xxx41lhZiVBUQ/FUix83x+tNDww==
X-Received: by 2002:a05:690e:d47:b0:640:e6aa:b2bf with SMTP id 956f58d0204a3-640e6aab4e1mr3921691d50.43.1762787395046;
        Mon, 10 Nov 2025 07:09:55 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d69ba646sm23716177b3.30.2025.11.10.07.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:09:54 -0800 (PST)
Date: Mon, 10 Nov 2025 10:09:53 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN
 constants
Message-ID: <aRIAQVjLiM1UKzXT@yury>
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
 <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
 <aRH0oRU5JXKpAKpB@google.com>
 <aRH-ScufjvGYPx5W@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRH-ScufjvGYPx5W@yury>

On Mon, Nov 10, 2025 at 10:01:32AM -0500, Yury Norov wrote:
> On Mon, Nov 10, 2025 at 02:20:17PM +0000, Alice Ryhl wrote:
> > On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> > > On Mon, Nov 10, 2025 at 8:06 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > > >
> > > > To avoid hard-coding these values in drivers, define constants for them
> > > > that drivers can reference.
> > > >
> > > > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > > > Reviewed-by: Burak Emir <bqe@google.com>
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > > >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc000e3e3b52c74d7c1 100644
> > > > --- a/rust/kernel/bitmap.rs
> > > > +++ b/rust/kernel/bitmap.rs
> > > > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> > > >  ///
> > > >  /// # Invariants
> > > >  ///
> > > > -/// * `nbits` is `<= i32::MAX` and never changes.
> > > > +/// * `nbits` is `<= MAX_LEN`.
> > > >  /// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
> > > 
> > > Should this and other references to bindings::BITS_PER_LONG be
> > > `NO_ALLOC_MAX_LEN` instead?
> > 
> > Ah yeah it probably makes sense to update this in a bunch of places.
> 
> Yes, please. 
> 
> NO_ALLOC sounds a bit weird in exported API. Maybe NBITS_INPLACE
> or similar?

You add a 'new_inline()' constructor in this series, so this parameter
should be LEN_INLINE or NBITS_INLINE, like that.
 
> Also, at this point we're really close to:
> 
>    pub const NBITS_INPLACE: usize = CONFIG_NBITS_INPLACE;
> 
>    union BitmapRepr {
>        bitmap: [usize, BITS_TO_LONGS(NBITS_INPLACE)]
>        ptr: NonNull<usize>,
>    }
> 
> That would be a very useful addition for some particular scenarios,
> I believe. Even if you don't want to make it configurable, let's
> keep this option in mind?
> 
> Thanks,
> Yury

