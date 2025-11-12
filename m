Return-Path: <linux-kernel+bounces-897582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3077C53935
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D42C5081E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7042328B78;
	Wed, 12 Nov 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLGJkeOb"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7983101C5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961799; cv=none; b=BLB6GcTsrkELQtFQAgq1XSxlTyWg7xetj4UoODFDpBL8yhxV0VhpnUQzl0J8vSUpKAov0kIl9QRotd0zhf+ixUBU7DOlcWi6o7uYpzB3UcEA26LGDevVFRpZij7A2n7QKhw3xUUnfgqT5OfpvNY7KyxrdpmnR4ES6Re+8gcbfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961799; c=relaxed/simple;
	bh=gWt4GhgaA7NHHEj0scQGRtObc6Quxh/aMrfj5cn9fG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boJ4t7igTKutmXJhmhjB1Y+vNNpde/7sN1mavsEdph6JHo69h5sYZgXh62oWfA1PSUvxIXqyuVPVFsDK+KMzOdJ7FTegv/ppQQ0hNVwzVUxQIRyDfv3BSoCjSa5oL3hAgvCzzYeYa0vPDutmtTT1ZIWZxgr99RJbkDIf1RU7kpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLGJkeOb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78802ac22abso10464377b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762961796; x=1763566596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kqvDDCShqiS2PpLwW/nzEFL/oQKmShltN7b0zyK/U0=;
        b=WLGJkeOb6gscStONMZhQI6HpTRY3JJv4bKpP8Csf8MGESGbc85n0u99OiiPwEo10Tx
         w+Gbiowqu+/pzbvL2sAyLpnZq/rEOOYUo/jVG9GEGXFYAjL5DRMnMJnE9WMdyFHyYRHN
         c7S1+3C0zDfEzg8E5NfXDXKWJuBHReQOtV72FLn7X9hvFRg+1ooh/HvfBrrThfjaypU7
         ubUWf1gdulhNZH1lNTlq5fLqZsUwWQxDDOIMfw2RUagl4Pj9AdtBWWOvS7UEh9DYLYSC
         pd5pCTRQoNRQjHOVf258yUM1AjYD6S4GI57o+prt5wBfF7OmCkpNWRMhnJKmxphoCm2k
         r79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961796; x=1763566596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kqvDDCShqiS2PpLwW/nzEFL/oQKmShltN7b0zyK/U0=;
        b=joQwLREex8w94gAvR4kqerTQjHk2/qYBhs6bSnX1q7YmNraSdsI1goit7WG9ZiacYM
         WJ4yq9Njdc8kmu1gAhufMGNFHh8uYBFKb0i/mEvxPQt3ln9DbWG4gqk8T5zhpQa/Dir/
         wlbaVEmCxiBsAqUXH4WDEcR+urdx9kqi+7e3K222l3KYyH1DqMrP4ZLOB+c15cyqSg88
         uSnKaCwSZvmgxNyQXjQeFF/rf7WpwrrnnKmGsIv6FsSmOwNOcl4M1/+dYKlNaGEYg0io
         2gQXqlTqrEwntdQQj0nurW7amGmC0AFqC0OnX/nzKVuzEf4d77x6ONzbDJ/l2zOBLYwz
         7eVg==
X-Forwarded-Encrypted: i=1; AJvYcCXR31dyQgY/RGC8XGDb50EN48G+vmG/mf6+fLy2cOcTceOHuWvsZJ9+sZx/HMvPuhmaOgJNEArX4ccKNu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV07Zj9EeGnuoSRFuUuHC2trtg/ru58YhlEaPiWhyt7rlD2G3c
	0y12YEWJ2LhU3FsM6xthNEQy5qT4+kBBIaargL8S9SoDF29rvW5JxKfp
X-Gm-Gg: ASbGnctCwSgfbBa0r0oBveDcw/oNgMW1JCqp75R1PBPcoCTw7ubF0guEHg6SPTo9HNl
	ymDNlD+3aerFoqt8fk0OHUB3NLsF/2U1aSprA+IRqSAfsD6tP5DUZOHsCXA+/o06exnTBxN4xAh
	T7ZsvJSKwOua3lxDh7gYuuNidz928dE2+6duZxfbHRJF7/mLXQyQvd+H6U0Fo0BJOLEMdaYZbNh
	lGNdVJRGucflpd7goKDeiQJIcIqpeCIaUICaXSJSm2Q+4vZTxTsKzBSbRLFN71CDM5rghvY7FL0
	WyWLA12ohhfNgjyjPvL7PF7bXHQbB0Pf+DyGlhMBSZxNMVnziOZZLaeyVjT7CpxwKSyxdx3Xc+r
	nqinqNPiUoXjS/k9VeRVWPQ8eMjJQo8f+yEZLjyQAo8N/HYaqvB55IIUFtMtU4z3Zixa1NsqIYg
	Hsk1tqq0cXyE/D2HmbtViaYtWyhkuAJ7gC
X-Google-Smtp-Source: AGHT+IF/7lMWkBQORDv0epmRSiUZ5L0YKXN3VP/iEjX/rkuf3OPjhQ99lzIb2UMOyMdVet7zqIVIiQ==
X-Received: by 2002:a05:690c:4008:b0:786:433:1674 with SMTP id 00721157ae682-788136ee80emr24887777b3.54.1762961796498;
        Wed, 12 Nov 2025 07:36:36 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d687e26esm42526157b3.27.2025.11.12.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:36:35 -0800 (PST)
Date: Wed, 12 Nov 2025 10:36:33 -0500
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
Subject: Re: [PATCH v5 2/6] rust: bitmap: add BitmapVec::new_inline()
Message-ID: <aRSpgWa8JF07rFJw@yury>
References: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
 <20251112-binder-bitmap-v5-2-8b9d7c7eca82@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112-binder-bitmap-v5-2-8b9d7c7eca82@google.com>

On Wed, Nov 12, 2025 at 12:47:20PM +0000, Alice Ryhl wrote:
> This constructor is useful when you just want to create a BitmapVec
> without allocating but don't care how large it is.
> 
> Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> Reviewed-by: Burak Emir <bqe@google.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/bitmap.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 0705646c6251a49f213a45f1f013cb9eb2ed81de..bbbf0f9e5d9251953584581af57042143447b996 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -230,6 +230,16 @@ impl BitmapVec {
>      /// The maximum length that uses the inline representation.
>      pub const MAX_INLINE_LEN: usize = usize::BITS as usize;
>  
> +    /// Construct a longest possible inline [`BitmapVec`].
> +    #[inline]
> +    pub fn new_inline() -> Self {
> +        // INVARIANT: `nbits <= NO_ALLOC_MAX_LEN`, so an inline bitmap is the right repr.
> +        BitmapVec {
> +            repr: BitmapRepr { bitmap: 0 },
> +            nbits: BitmapVec::NO_ALLOC_MAX_LEN,

This should be MAX_INLINE_LEN, I guess?

> +        }
> +    }
> +
>      /// Constructs a new [`BitmapVec`].
>      ///
>      /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This
> 
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog

