Return-Path: <linux-kernel+bounces-768216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D2B25E52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5531E5C1EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E222E62BB;
	Thu, 14 Aug 2025 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jhY6YqA9"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7E2D12E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158752; cv=none; b=lh6ir3t6+qgrYdZ4sm97gVG/Q3XQ5wiL9g5xB7S3zSmuk1Riptz14A7e7V+CK/0DzHEvOVhJVqF0Hl7VEeB5zRQMqYOcI+uyWNx3mD9j4bORvQiBIwD19oHHmHSAMex1GAheBPUJ7bh4q6wiwf4NgFWm7Y6uvzGEm1P0jKHcyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158752; c=relaxed/simple;
	bh=an+fe+pkyixQU9vVZxme5xq6n1zoaEJRMKOUczUAZr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxnQmZat584WYgENyWTqZhxIV/aQF5dubdAoTJvrvtBwBQwRGUrQi0xRExJ/0Tc1jwfzVRFnhNrdGzC1O6tOKNVV4oxjzzqQeKJEdNEEoAGz7eTi/Mc4vR/jbjLj/hyI9DgzWyXv92cRRXQnHuZG3HsdHRXHHq/tYKMkDjjxOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jhY6YqA9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e4117542so170748f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755158749; x=1755763549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9LXxrbOz6ZUqYRAh2ZKLcYQii49//1Gile44Y+OEUs=;
        b=jhY6YqA9BVKHwnKtlnnJBge1DblKLNYtAX6Z+I2txdqmk5qq9I0/zKSxE3u6lNUCW9
         i4V17EqwfVZvbwYvpee9XKhDaHV5vBPAB8c45+Z1fnFZfc0xgwj3CT08icLfKFjgptEy
         zTB08J+gzZil5/FVlNM2WNUFaM66lBdNGGpEtSaLY92hqR/ps+cTin8k+VWzUf4mLRi5
         fJkMruolKdhsx7D8mob5hJRRorOSWB7lSeQG7DkB9AuL7L5Dsnw0VSQDxCWdQpUa9JD+
         eRj5CWgeQMhEvxBA5tt8QLd57HDco1U5qZo8q1YMueig0wzVX6xtiBuw8s2/1tv+Q22Q
         UT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158749; x=1755763549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9LXxrbOz6ZUqYRAh2ZKLcYQii49//1Gile44Y+OEUs=;
        b=va/1wuFAyHqV0jw9MKjaEvMHH6ueKbDfELlDghaLYmwwC+O090DJAZYtzzhf8qleN0
         sUrFLmW5FNZM2e+PNMhBDCoe/efYRxiqGKx3jNHMmURe3Kz+swyhclIPSELbgXgqby2C
         OKshEv6w0ONv9X4ctXwnHKEBGJlQ3MiY88oMdOcapDFvHMxkxdFdSmkzPDEdb/AURzLv
         uMya4eEQciQPfHOQzVrMw3Vqc7eIFsEWITfVopY9X/YbDWkPKRStXLI9NMUNH/T4K0U3
         FSRjzf2bfYsmjYb6bJzXU1j1p7zdwdmrULCdDs4aEEGexxp0zTqpTj/gGDVzaJ6BJAHj
         ISgg==
X-Forwarded-Encrypted: i=1; AJvYcCVfTXmOf5M6QW/JVZCB2AEgyxZxlFUdIzqGmN0/lOHAS/ZUIKMFOoQvl4+FPbiwtug0811fEQiiOfPV9AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBuUNWoOvTRIzUKMrFldpobERW4W9aDqg/oLaMbqdaO0jAjoCs
	45xt5CjtpLG5cOEzHTKqRjB8WQrcexMWrW9U8++w4zs6rzNLW9MnEkegdqB97e7q09GQUT0qHlG
	DqMvk4w4pN/r3LAlqrw==
X-Google-Smtp-Source: AGHT+IE2hoWIzSbuEgXhxUd0EI6pjBljB/gE7D2tdM9iYAMHa3Cqm9j9sHtlblSRnu9eammOTk+un12zhHYbPj0=
X-Received: from wrhq9.prod.google.com ([2002:adf:cb89:0:b0:3b8:e2b6:4205])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2502:b0:3b9:1342:f8ac with SMTP id ffacd0b85a97d-3b9fc3595fbmr1665685f8f.31.1755158749085;
 Thu, 14 Aug 2025 01:05:49 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:05:47 +0000
In-Reply-To: <20250813153548.1650533-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com>
Message-ID: <aJ2Y21Yjs3a0CnAo@google.com>
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
From: Alice Ryhl <aliceryhl@google.com>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 13, 2025 at 03:35:41PM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
> 
> The Rust bitmap API provides a safe abstraction to underlying bitmap
> and bitops operations. For now, only includes method necessary for
> dbitmap.h, more can be added later. We perform bounds checks for
> hardening, violations are programmer errors that result in panics.
> 
> We include set_bit_atomic and clear_bit_atomic operations. One has
> to avoid races with non-atomic operations, which is ensure by the
> Rust type system: either callers have shared references &bitmap in
> which case the mutations are atomic operations. Or there is a
> exclusive reference &mut bitmap, in which case there is no concurrent
> access.
> 
> This series includes an optimization to represent the bitmap inline,
> as suggested by Yury.
> 
> We ran a simple microbenchmark which shows that overall the Rust API 
> can be expected to be about 4.5% slower than C API.
> 
> We also introduce a Rust API in id_pool.rs that would replace 
> dbitmap.h from the commit referenced above. This data structure is coupled 
> with the bitmap API and adds support for growing and shrinking, along
> with fine-grained control over when allocation happens. 
> The Binder code needs this since it holds a spinlock at the time it
> discovers that growing is necessary; this has to be release
> for performing a memory allocation with GFP_KERNEL that may cause 
> sleep.  We include example doctests that demonstrate this usage.
> 
> Thanks everyone for all the helpful comments, this series has improved 
> significantly as a result of your work.

Thanks a lot for doing this, Burak! I gave it a spin locally on
v6.17-rc1, and it seems to work.

Alice


