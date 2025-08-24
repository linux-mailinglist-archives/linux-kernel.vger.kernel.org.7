Return-Path: <linux-kernel+bounces-783612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F65B32F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A803A7570
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4602D59FA;
	Sun, 24 Aug 2025 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfiYk5qh"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1933F21ADCB;
	Sun, 24 Aug 2025 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756035529; cv=none; b=G01kI4uBHy5UKulRIg9kS43Lqpx6vWaO44LrBMgA/AZMwUC2COubr6EMZbQaoSyP4qB6mqsCgCaHYhgxwq6zYzVmx6ssB7h86t7KilbBQzTl9B1KsMgwCXBd7qld82bEnLAaDaH2DDBTpel9dYjwsS2lWVIgtKEq3jKcR4YNmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756035529; c=relaxed/simple;
	bh=JNDmPD5uJRY1Tp+XvOum5SPILYMIMNV+YnOPnT8UKtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNHWMLQ0y2QpuW3UmwDCuyFqJ0HEIeG16CiYryJeW6fVAFgouvHsJHVBgE6qiGQxMM0VHMYDOfQi18BWo08JsPi/XZMG/aKbMPS8BmcVhWnMg8QyniEzFqid/H5DnEeDCkMt3Bzk6w1nvwifOpXOdd5eA1od01OMEmHB/kDbWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfiYk5qh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b47173edabaso593024a12.1;
        Sun, 24 Aug 2025 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756035527; x=1756640327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cDqNbqcDUrKN9I6FwLpcYOrNjGw94QGbdTT6OM3Mgs=;
        b=kfiYk5qhcoS0V6PqcMo50orw6kEeZ0uEsmcSNO4OVoNRecNVzqSxF8b5VPxnX0pUB7
         2dxb+SOclscLMs/qtcRvjFhE1hrXE7VUn4iw6InGUuwjpK14n0TpYnFdBt19OrlcwmGY
         jnZ1ExzKaLp08Mryoj9LdYuY3OHaf6mv5b3skaL6CYU8NtcDYz8aZpVL93ceCRGMMvcc
         3ZobtVc5bGXJTIaGM1U6QA0VfhTgJ/pWhMMKoI/Qsqr0P8rJEGfcNQcvHgzdIbhf/YF2
         T7vAh8LhX5AgBG2yNgwBJ9e7TWeW7cNDKzx+xiyF4iMIH86ZCqS4FgNkyehaHGCCYaT1
         WUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756035527; x=1756640327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cDqNbqcDUrKN9I6FwLpcYOrNjGw94QGbdTT6OM3Mgs=;
        b=kFa4dacMS8TaaKGuPn726dkWhKPMrAF1kYtPzSdcYvjvsNJeyGIYLLU9Wur2A9e5lz
         iqx15KSzJcvpz3xHRU1nfSJx2orIoWl8MweEHnU8k1vEi9BVGEzyfP+ZNgXmM7Smpj+C
         xyzQlpg4xMrc47Bn4Rn3eaTjk+6ThlMbo41dz0OyZZOf07qYnM/UBeQmq5id0pDkwJtu
         9i/32nLxxQ7uK41ZSsgg7zNKHCncWJwWWTSkhqafKz2IIWcgH28YEVSM9KSqKVj7Dq0e
         1u6QS/yqh1O+ZFw2sAmz+qSUbntjs80cna3txFKn+P+1EKpUsqAcm2ACiEp5QmNk85fI
         o8oA==
X-Forwarded-Encrypted: i=1; AJvYcCU+JmFGZVqKM0KYXYTOefDVcGGE/Lmq0UGdbY6c7iTprk8REGBP/pPb33PFBxk7IxgfzXNjS0q48zZneDEG5lU=@vger.kernel.org, AJvYcCWjM0+HndN9Ip8z2xh1IziRLcof3khR+xipFAby1Viixp59yppHWq0f/giBQNgE0baQ8ReRUwKHEF8wuSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzYod3l4uGqgstfwsbdbCOs1Z8ehroX8itZn/za/DeSaIuHa2
	67qKizIbv5G2FE7X6Yenro87UxiCU4/S4yNkz2piCL3B0UQONrRc5zYBWoblUxvOE0eYHaTUP72
	qMP7WtsZHN9LB5jY83Aue7KF3WjIjYlE=
X-Gm-Gg: ASbGnctAS69Bcg3m4aCeSORuUaJo0N/wDZ1bK2WypSOWu7c91gs6tMB7wJQBl5eD+SR
	TSlvZkHv4zHX/kyXcU9sl+sDgQu3l+j9gfYdm9rAZuCGmYaIMuI05da8czFfHH/fcrnWoC+OWPx
	y9TMBwavQEYsSsW16ZIk0VBb0QcX0bPYrnRcJAquFKznsJLEfzMi7u89H1swmlbu5XUVxADXTCz
	xtTWPMwUwVB7Svyo/CvkiEkjN6nbxXLe+ESeFTWVPYUPb7BtEgOCrFPcmQ2oX7UNGMh74Ok30Wo
	5JuUWLIm4QAn1k3wAmz+YwamlQ==
X-Google-Smtp-Source: AGHT+IEDeQcH9/cmzvxp/cnplp8sqsKYB9Imynqz0W/6Icoa1vEMhVJTFtyjOb1zgaJdMSz9KZMeBG8x7XunTdy8Nx0=
X-Received: by 2002:a17:902:e888:b0:240:280a:5443 with SMTP id
 d9443c01a7336-2462ee5d589mr55989045ad.3.1756035527288; Sun, 24 Aug 2025
 04:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com> <DC38NDRET9NB.31UDI8FHB7WAY@kernel.org>
In-Reply-To: <DC38NDRET9NB.31UDI8FHB7WAY@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 24 Aug 2025 13:38:34 +0200
X-Gm-Features: Ac12FXwORJcKw5BWVPRfeLB42EncV6m0mvAs8xiRT-uFV3AfSlGlkdcdd5BVvsQ
Message-ID: <CANiq72k0FSBTB2yOjiAy9PnAuyM=-PHxL3uQQ_Cv+zwswnr_bA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Take ARCH_KMALLOC_MINALIGN into account for
 build-time XArray check
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:12=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> diff --cc rust/kernel/alloc.rs
> index b39c279236f5,907301334d8c..000000000000
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@@ -164,7 -137,15 +164,15 @@@ impl NumaNode
>   /// - Implementers must ensure that all trait functions abide by the gu=
arantees documented in the
>   ///   `# Guarantees` sections.
>   pub unsafe trait Allocator {
> +     /// The minimum alignment satisfied by all allocations from this al=
locator.
> +     ///
> +     /// # Guarantees
> +     ///
> +     /// Any pointer allocated by this allocator is guaranteed to be ali=
gned to `MIN_ALIGN` even if
> +     /// the requested layout has a smaller alignment.
> +     const MIN_ALIGN: usize;
> +
>  -    /// Allocate memory based on `layout` and `flags`.
>  +    /// Allocate memory based on `layout`, `flags` and `nid`.
>       ///
>       /// On success, returns a buffer represented as `NonNull<[u8]>` tha=
t satisfies the layout
>       /// constraints (i.e. minimum size and alignment as specified by `l=
ayout`).

`MIN_ALIGN` is missing in `Cmalloc` -- from `rusttest`:

     error[E0046]: not all trait items implemented, missing: `MIN_ALIGN`
       --> rust/kernel/alloc/allocator_test.rs:48:1
        |
    48  | unsafe impl Allocator for Cmalloc {
        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `MIN_ALIGN` in
implementation
        |
       ::: rust/kernel/alloc.rs:173:5
        |
    173 |     const MIN_ALIGN: usize;
        |     ---------------------- `MIN_ALIGN` from trait

i.e. similar to the other one.

Cheers,
Miguel

