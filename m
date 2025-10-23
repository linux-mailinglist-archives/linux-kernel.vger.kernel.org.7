Return-Path: <linux-kernel+bounces-867474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7158C02BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E014E8318
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEF34A3C5;
	Thu, 23 Oct 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFt3W8CW"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBF2D0C73
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240788; cv=none; b=Tg/UjBlr1mlifwa2iENARzwLE3xvkbtF4WPHI8dfvX58v8PDyfXMkjTvktXqVyWDoQwrM2V11cvYwhmaEbzCINU914/49nDKliRN2H84rEoWv5ctaVHQLItUUnKZoehnLQUq0y8FIIt9pQAbzk5oaF9C78g46AxRe24WhpVk3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240788; c=relaxed/simple;
	bh=cpJw1OTejKmslWFrWwUMdhq1fDUlcga/3sUJOW+TusQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO1SDVTb2H2SCnfU110d0hk8MsjpknW64ySXqYgam/9EdgUKV2g1RZ+B4Nhb/BtrrJ1bmsJFdUQpM1slTS91q5vokyfLgW31LuzKgmF2UsURdUYRnRo4uYGuZvCwmFr9KBTK4E2TtxdKHXFkhHgd4suAdg7xAJT9FvW+KhySduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFt3W8CW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87bb66dd224so8671236d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761240785; x=1761845585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp4a9eCi2a7gc094Itg0UZRLr0/XIELDNFAexyvEGk0=;
        b=GFt3W8CWGyplFkojZQPFcCSUSeeoJISe/JKwWC/3dgg09+fajCuHZo7jmKZIywK7yc
         ObeRKCtlnPYX94g6BfmL40PZg/DcouwM9pO7oRhnxUCcHB3Ds7OMetES1daoScL9lIk4
         9MXnOvnIKJZr87JXgV9n1tbhCiu78FNO8slyzp0i/RJIaJKs35fDdeONZ08die65g4Cu
         u5Tw465ZMWX7tn5AzXSHP7UzJiQEp9VLHmtzw3tWhF/xScwW5j7SssH6PKuzt+An5A+9
         DDPe/rfhzSSUoNutMwpAJqVTdSdTcnjxiurN2FWfqot+UnzpYAc+rlptYKI+6aFh98Pj
         9YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240785; x=1761845585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp4a9eCi2a7gc094Itg0UZRLr0/XIELDNFAexyvEGk0=;
        b=CVERv/jBJNCkAI/BnGHLjAtP68eoEBoviC495lpeuQlJpG3RWGk+9HgRSlIPaTUN45
         CynhZDDScZzTPfycMjfcGemrlLgQ89xzgken3mdFHPObudkUhH3hXltJg7NunmpGkgAn
         FDtq5rJuerQ3unjhX97bKPUwS06ro0Fac71mmBXkMmMrGDLKbibtI6QBb+1lBWw21DY3
         PM++vDQSTbos4uw0uPYfSflPOAHTlNsV5NKuTmMVhq7dkHp38p/mAYhGpkjt7mKqyF0g
         EYRnXelyIPsZ+lt3Zb1qZmgzKYmVcpz77Ur3DvnFrp0R+dFIH59e7ok5qvPdgnV08BXu
         Pl8A==
X-Forwarded-Encrypted: i=1; AJvYcCVN00bS0nRWnbIDICyAzvQDrDfWmyB3lm0jRpsZfzZFrzXG/Exu5r7nbBL/KrbbYt+7JTncXclhZVeNFXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTNj7nQAmH9w6KZpWXCgh/0gxbZjl++XIBoyuKVPlk4IR73sN
	42I/jRTdIBIbzZuPAYn66RmRmdzfCImDyDmkQRO80SGuZq//6QD/qHXK
X-Gm-Gg: ASbGncuAg+E0Ev865vWjkKX/pUwmIeDe+85YZMuKFFaLmogsFioiAQw9Ily1F1krMaq
	hyTi5HqPlYRL/r423p63KU+lDMm6dA9jGGZmMiMPHUH0Gg8HoAGiDB3YczjI+cr8Bospbpp5veh
	QuwBxZQdXDHWgi0NNis4cwgH5RaPVf6Ocxjhybq5pH+gKAOn3cslIpXDtpyVsWfzPOvCKwlgEy2
	1KJ5G6lcWVSqJmrBhivXYMF5DM80guRuhzd0Ry4ixkcH62cjqetxHqcopKHAbvA/wBzvGPdLoRd
	tK7Rtv0BXraD8CKaUfy/ixsBhE8ckOLhMwn5ypaP1v5y8IBsidcALtEk3OnzmSxki+t47+ZKNxI
	B8ZFpLnpYW6WgWVzJnhkYosqmnuazi9MHVe6ZTXwSByV87pzeJ7F0pzaOaoyViWSf0MKwDjPJWz
	yxnlCKreToDHxkJQEXNA==
X-Google-Smtp-Source: AGHT+IGHYqbeAL8vbTPvgY90m2GDo8z8aBpxsit+v6Rm+Fgk3PNH7z2lbMi924Eefb4cUQvvhl8tbw==
X-Received: by 2002:a05:6214:31a1:b0:87c:21d8:1243 with SMTP id 6a1803df08f44-87c21d8180amr257680096d6.40.1761240785312;
        Thu, 23 Oct 2025 10:33:05 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87f8fb6b1c1sm19113796d6.6.2025.10.23.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:33:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 13:33:03 -0400
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
Subject: Re: [PATCH v2 2/5] rust: bitmap: add BitmapVec::new_small()
Message-ID: <aPpmxy_oYoJeeqfr@yury>
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
 <20251021-binder-bitmap-v2-2-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-binder-bitmap-v2-2-e652d172c62b@google.com>

On Tue, Oct 21, 2025 at 01:32:44PM +0000, Alice Ryhl wrote:
> This constructor is useful when you just want to create a BitmapVec
> without allocating but don't care how large it is.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/bitmap.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 15fa23b45054b9272415fcc000e3e3b52c74d7c1..4ffe9eb0f208a3d62016e00297f5a0800aa33336 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -232,6 +232,16 @@ impl BitmapVec {
>      /// The maximum length that avoids allocating.
>      pub const NO_ALLOC_MAX_LEN: usize = BITS_PER_LONG;
>  
> +    /// Constructs a new [`BitmapVec`] without allocating.
> +    #[inline]
> +    pub fn new_small() -> Self {

Nit: maybe:

        /// Construct a longest possible inline [`BitmapVec`].
        #[inline]
        pub fn new_inline() ...

This 'small vs large' lingo is internal to bitmaps. I don't think it
is worth to expose it in the interfaces. 'Inline' or 'inplace' sounds
better to me.

With that,

Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

> +        // INVARIANT: `nbits <= NO_ALLOC_MAX_LEN`, so an inline bitmap is the right repr.
> +        BitmapVec {
> +            repr: BitmapRepr { bitmap: 0 },
> +            nbits: BitmapVec::NO_ALLOC_MAX_LEN,

A side note: after merging bitfields, we may switch inline bitmaps to to

        bitfield!() {
                0:31    nbits;
                32:64   bitmap;
        }

Thanks,
Yury

> +        }
> +    }
> +
>      /// Constructs a new [`BitmapVec`].
>      ///
>      /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This
> 
> -- 
> 2.51.0.869.ge66316f041-goog

