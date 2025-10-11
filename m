Return-Path: <linux-kernel+bounces-849110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E61BCF39E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20BB189B884
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BEC258ED5;
	Sat, 11 Oct 2025 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7JDfBnb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F93222A7E9
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760178798; cv=none; b=QLaE/5mmGBPhOEkrimesGkhob5WjJOHy7LuPcIgyriYajZZc39zBXzsw7uKtYu9G36czn7k/maxrX1fbSGK/EyGjd8oFq5QYGDZAl2amwzOMx1HjuAoMtHgLwc0xXWgdWNisLmVZZWLLakomNH5Kohfl9ldZBWZSDgoLQssJtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760178798; c=relaxed/simple;
	bh=KWJNoifW9mKZ2m7atmfernWYiEqoHW9QI0fSKHHtBbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CNLbOcVpzRTYnxVNEK5j7VMJRsiKkYd8/pGnvy6PJqtWX30MwAmYyKGPE9M+il4hPHHwXOUF9ZJc9lJo/U/O3jVROOP9yHWkJVuoaI4LKW2iq9p+n5x2QDzXNKm7Vhm/zk4lDfZyaAPR3OOnNcDTEs1iyNPst0ZYeIbywVbhef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7JDfBnb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e3d43bbc7so15803145e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760178791; x=1760783591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEMAqpRvkk1CnOEEkWJ/ybbuyMvUoPKtuwUvs4qymvU=;
        b=m7JDfBnbU4E9OeEKfYdEAV/J8LniUpq6spCzUl8FcswFo+uHZiikqGCAToF+1XU7t0
         dLTn1YLfYyvutnQSLnfZRiy6CZwJkGHD/2SapnowvRdCvSFWBZZQJwjCxT0ZmOREnzt/
         2acm0S9QfcPxyX7eaPrecIy245LfpdKRVlnDXB8qm/kcRHXE8BtSZSnuopKVs6DzDKZd
         qcXlrJkxI0xXKYCIr4QqFMYQLoS8+jxGlkQmbNX6xX+DJ/3aFC0UA2tqkBsORbh1Musz
         LYO6y1RV1MgWe+DCvu7he2ZUoWMCgM+kCBU5y12dBYxrfKZNbw1XaaFYzHay93C6nXQU
         e/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760178791; x=1760783591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEMAqpRvkk1CnOEEkWJ/ybbuyMvUoPKtuwUvs4qymvU=;
        b=inu9SdEy9TIGqoBBRD7mJTko4xgEhOkTHLyobO0GbrAiyPJkvZx3d1mHNmJK+l9D8q
         gSQSZhiYOfdqN3xp6BFLFGz3o8AHDZb4q8iJHxU7hYMINR1nlns9CdeiylqZF7OeYEZH
         q6/agMCpYxBQLSp3MG2Sc69waD3JSMEuQX/hvrsCRCqC9mA9QgmBSgNsC0u4sEDaKJxQ
         kq+NwcY2QWwd6yPInxmUNRYzGACdhbYNUtqDsddsQLh85/0bPhqyo0yl0WImDl05vzH/
         RAqfR332ZshEqWINmChYyUcP4cGVc5St92vgZKHGF+ldFmCdgte6Q4mvJGVvcNof5oYr
         mafg==
X-Forwarded-Encrypted: i=1; AJvYcCVgUhWWyOLR9ZqCHwQJPFEo57Wxuk8Fqt7zRsc0ZPkKk1POUcONqtZb6dkW7MRkuhI+GLzeu28R+N0OmUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBvjBIFyxmCi3RCNJJmtPsxWIwxmlDO650n3kLaTjD85pFU5L
	G+0y+CNQooDLaqye5jBLnE0EpmVoIBeeJWVxMVv/TQJ/sQAhZs4HN80KkjilHqXHzjhGvC3tAv5
	lQOKMRHPsUfAVI5Rjcw==
X-Google-Smtp-Source: AGHT+IE95szyP/U8+8WhwLLID98VXllUKscYx6ym55wS0AieLc/ikoex6vLfoIyhhX1iRrMI6+QUlbXsF49wksQ=
X-Received: from wmcn2.prod.google.com ([2002:a05:600c:c0c2:b0:45f:28dd:87d9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:416b:b0:46e:3dc3:b645 with SMTP id 5b1f17b1804b1-46fa9a87f3emr103546595e9.3.1760178791259;
 Sat, 11 Oct 2025 03:33:11 -0700 (PDT)
Date: Sat, 11 Oct 2025 10:33:10 +0000
In-Reply-To: <20251009-bounded_ints-v2-2-ff3d7fee3ffd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com> <20251009-bounded_ints-v2-2-ff3d7fee3ffd@nvidia.com>
Message-ID: <aOoySkWjPcJLVDrG@google.com>
Subject: Re: [PATCH RFC v2 2/3] rust: kernel: add bounded integer types
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 09, 2025 at 09:37:09PM +0900, Alexandre Courbot wrote:
> Add the BoundedInt type, which restricts the number of bits allowed to
> be used in a given integer value. This is useful to carry guarantees
> when setting bitfields.
> 
> Alongside this type, many `From` and `TryFrom` implementations are
> provided to reduce friction when using with regular integer types. Proxy
> implementations of common integer traits are also provided.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

> +    pub const fn enlarge<const NEW_NUM_BITS: u32>(self) -> BoundedInt<T, NEW_NUM_BITS>
> +    where
> +        T: Boundable<NEW_NUM_BITS>,
> +        T: Copy,
> +    {
> +        build_assert!(NEW_NUM_BITS >= NUM_BITS);

This assertion can be evaluated in const context.

const {
    assert!(NEW_NUM_BITS >= NUM_BITS);
}

Alice

