Return-Path: <linux-kernel+bounces-804622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C6B47A8B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE09B1B229CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F3259C9F;
	Sun,  7 Sep 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2abBnTsu"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197A23FC54
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242483; cv=none; b=vA9PvEz8VXUdZc2UnG09QRPAph0GS+LKytLFgL1/adz4qVrZg6ISqQgmmEuT4KGqtPPT9j5MrUqfd3HV9/6PgPaONbbXeRGox4pNYiOvzYx7N6J7jdglfO5FzOYFDwCGBfnEFzwf+9mtb+MDAzgrABMGmseeSqpO4I8JYoPkTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242483; c=relaxed/simple;
	bh=ytHxbY3F47M7fJR68ZHBsTiypjUB8zZRP0Xegx525Xg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yw2I+2n7oKq3ORIn0b2lZ3TH1ajM4YTOnCNGjgcX13ndNfHqWR+tGRiKCgWPG7s7l6Kx19Lx8O6OxJdDrZl/jqnfj00BFLkSC3XE5/s84bqKEXAAARggObIlWCxPqzdy7LBoiHBys+TMGkbSnvU8eB1IbUyuPGbyVe0+jDSnCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2abBnTsu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3e1260394dcso1714000f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 03:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757242478; x=1757847278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm92e08KH4OnBIzsiipqMiydD9ZOdg2vH6XrUgmumFg=;
        b=2abBnTsuCsJMnlfoi+AFpXSRPZRbnWTw9IYfScIe65RbC75keerVHoKsT7ZfCCNhqu
         uKbCgHVB7cIh7omvXz3K167hC8dZIT0mnZ6Yo8l/DLQQ0Veuo4LlqcwfYrydLbNm+RBR
         6/rbH4h4ZBhowJGHE+moL+RXSanj4rW8Lp0fm2inGzRELsXWgPGf6iTi4HnUzXcYLB1F
         RSaglV9jGHhj9NaQLr1be+t+pQQywu6D8jfbmMp/dmUnYBmNDEDfkgebDDfS0iLbT4SK
         Y20tm6TgL/61KZcj5nztQj48nI29SphLIXDspRgn/yr3tjVvHWJckIXwqqyCZAJpBi5z
         rc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757242478; x=1757847278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fm92e08KH4OnBIzsiipqMiydD9ZOdg2vH6XrUgmumFg=;
        b=b0Y81l0dFoRknymS2Cq6loGTBalBmVo3bepU83HjFv1oetxeBitKmNky+rSuVW02Pu
         jiZ6aSga6VEStAR/da0zih2FW4vN2uzF+AWpoxVONpK1AMG+U9oG8lM/U5XGuMuywjau
         FCTIgjuPB0Df6AoqKtMZjum67YxixWMttyPdvLgz53x0CmeRJByibTbgeGRlLD7y6I/h
         gsGVpKrhTLBRowLv81OtkaWtSKlWNSXLBzLZBXPXsif7eCe1X9UwNfvBLhMjEAPoZPYx
         QOeQ1dVGPbDqtNXNw1gBk1K59EkONYpEx1Ha5gW1rCQ5/7vN07lSr1wOwzvliWo+1vg8
         d5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1wRmTYe/mBBAKjs/jtc/ZpvPnLGOw2SwTYnN5eCe3tI+aQYcDqNX4Vc6wzqMnV0okixUJEpOZwB1yTOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKkuhi9a3TjVFyxuxGQZLKNo8rMoyeg20Q4E8QynbVOnW3hG4
	S1KsKUhonVtiHWPDSDVFTwzC/rsa67tMGwJYcSYKHg94z1s6h3lqHl6toxVdxzKnm8l8jDURy1O
	D52rODQLtHcdGAUr7Eg==
X-Google-Smtp-Source: AGHT+IGwczkNJ4NDT8jycdLKjKbJyfREabPo6DFwIEEwqw+DK/OSgFh7CarHw7NidqX/vyfwf7K8GuXRp9GGNlE=
X-Received: from wmbdq15.prod.google.com ([2002:a05:600c:64cf:b0:45b:81de:b730])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584e:0:b0:3e5:2d1d:3a2b with SMTP id ffacd0b85a97d-3e64bde928bmr2809860f8f.39.1757242477540;
 Sun, 07 Sep 2025 03:54:37 -0700 (PDT)
Date: Sun, 7 Sep 2025 10:54:36 +0000
In-Reply-To: <20250827082015.959430-5-apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827082015.959430-1-apopple@nvidia.com> <20250827082015.959430-5-apopple@nvidia.com>
Message-ID: <aL1kbG0YYy0FQCGM@google.com>
Subject: Re: [PATCH 04/10] gpu: nova-core: Add a slice-buffer (sbuffer) datastructure
From: Alice Ryhl <aliceryhl@google.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, dakr@kernel.org, acourbot@nvidia.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 27, 2025 at 06:20:01PM +1000, Alistair Popple wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> A data structure that can be used to write across multiple slices which
> may be out of order in memory. This lets SBuffer user correctly and
> safely write out of memory order, without error-prone tracking of
> pointers/offsets.
> 
>  let mut buf1 = [0u8; 3];
>  let mut buf2 = [0u8; 5];
>  let mut sbuffer = SBuffer::new([&mut buf1[..], &mut buf2[..]]);
> 
>  let data = b"hellowo";
>  let result = sbuffer.write(data);
> 
> An internal conversion of gsp.rs to use this resulted in a nice -ve delta:
> gsp.rs: 37 insertions(+), 99 deletions(-)
> 
> Co-developed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

This seems like duplication of the logic in rust/kernel/iov_iter.rs [1].

Alice

[1]: https://lore.kernel.org/r/20250822-iov-iter-v5-0-6ce4819c2977@google.com

