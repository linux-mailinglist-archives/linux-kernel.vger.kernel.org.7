Return-Path: <linux-kernel+bounces-739189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38127B0C301
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E89F3A9537
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051C28DB68;
	Mon, 21 Jul 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svVAO455"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED620103A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097515; cv=none; b=mSBK4o0nsXZO2vKsolWagL2obH4+usxRMhYQP4Kd6VeXabOfI/OyhpTvkbcdikNsQGT08CYjcNWYbcY844qly0fY1XGanMqnmmiDVY5pNZO+i69rzo6rgd5bpedtFU4i3vxKPYxIxQjfCQ1caW8ytILCCV5U/ZR3m+YciJNqz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097515; c=relaxed/simple;
	bh=pqgHKupXxYc9eGoaZsvZu/Hhepe/bvqmRLMAf9J/Ln0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mM7dhAlyxpU22f3u4J70gN4aiSfxfPzX/jqMfaofjoZ1vCOR3otBrJSthZUZSjBpIuJkv4gOoKI0tw9wr1IjmPcm6lcMiPCNgq5hD7HzZfZAW0fPHQ75kCFRVRyJxG9FYsUSHfBt8aLJU10Q+n08Vkboj1iolN+ixGYm0jcWHuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svVAO455; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-60995aa5417so4054105a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753097512; x=1753702312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnCR6M7w8QHFyZar2EB3KK8z/WHsnwV8/M11NVYn6EY=;
        b=svVAO455VitbYjO2IuqO0LkzMwJRlSp86Jd8Y6Kvc3lKUZNJ3lwL02OMSDi7u/hq5S
         wRQAVuAgDIQisTYiNTA7FB29b5Cy3JYL1uzZUXNeHcKruSRlD6ik5ZOeQbNOZFjA2s/x
         ubXdvY1O0s0Fp9fmwQ0t30eSzDkxJf1EEO/ld/uMejB/q+YUZchX/I3o0CZIsndcGzcg
         Ccq2z3S1tGf52fY7M6uIJuhTSyWmJfgADns8RruXoQw+E/8kwhFqNmIipiVcGEUhxru2
         J386hsJYIBJBjZn0dne5pfA1l13KJTJe81IvgJoLoX4FeXhI0PNgO2d+8dop0vDIwaQS
         X10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753097512; x=1753702312;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnCR6M7w8QHFyZar2EB3KK8z/WHsnwV8/M11NVYn6EY=;
        b=M5VtdJ8s0TwOIrdAJd2pjFAv+mlwHwhwYtRTQWXLyJwzkUbcejo7jSKaEuHmq3IyQe
         T2KalWENclxsbC23CVHsZ8EevLIJhBysPmtVsl3wqWR1bfEWOKSYrXCIDWyq8/bjhDmI
         /C0jtlFoPzrHSOsNgq5l6NX1jK+En+LiFRfPCuHhQ6HinPux+euGTZMsio9diQuVGnoJ
         Gqg5Y/HY/30q7mjAmFLHPnz2E0BjDuBKIWwZ6f+pYyUgoxzRqsN+vZgodIfhCBGz9pLw
         xZrlcjsEcriSKYiD3ILdDiMKAti/XaqSkTuOpNZla4Tkpm6y5NhCh+c8+uPIzJ0sRZwK
         yJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXFUH0EW1yYC09UTBn0L2fM65FmXuyotZ/EsxNvCTAJOc2r4iQ7HirrbwXL2ESbmjTQaeOmAkA9R1RldCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95dxX4ZHUD5L1fHYkWvTFzL3NCZBFMoPu1o9NpUZqn6Tab5t2
	HlCExxLgDtCjYcYWdOiOkXXg5Zue0Pbw4dl6iHKilV6fAxNPWsZHLcTtf3tBW+sIN4qjfWFpJbl
	yyB55kXo32ZXp3YhG7g==
X-Google-Smtp-Source: AGHT+IG/c8OapuqkABauV5jrGztrxDeWojuNOWyE5PTSR+KhXio6zVHDuob8s26egoJA+WT8enXIOiJYuOISkXs=
X-Received: from edrf26.prod.google.com ([2002:a50:ee9a:0:b0:612:b678:ec24])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:d66:b0:612:9e3b:ff99 with SMTP id 4fb4d7f45d1cf-6129e3c0e08mr9912527a12.9.1753097511951;
 Mon, 21 Jul 2025 04:31:51 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:31:50 +0000
In-Reply-To: <20250720094838.29530-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250720094838.29530-1-work@onurozkan.dev>
Message-ID: <aH4lJjzZx66BqN60@google.com>
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 12:48:35PM +0300, Onur =C3=96zkan wrote:
> This patch series makes various functions in the
> `alloc` crate const fn.
>=20
> Each patch corresponds to a different module within
> the same `alloc` crate.
>=20
> Onur =C3=96zkan (3):
>   rust: make `allocator::aligned_size` a `const fn`
>   rust: make `ArrayLayout::new_unchecked` a `const fn`
>   rust: make `kvec::Vec` functions `const fn`
>=20
>  rust/kernel/alloc/allocator.rs |  2 +-
>  rust/kernel/alloc/kvec.rs      | 10 +++++-----
>  rust/kernel/alloc/layout.rs    |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> --
> 2.50.0

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

