Return-Path: <linux-kernel+bounces-892846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C8C45F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384951893AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3130595A;
	Mon, 10 Nov 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14uCg/K0"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD928B415
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770461; cv=none; b=QOrrdqq2AX+nu2fa4Xb1jeGMeBJbU8suPelG13ue/cDZ5+Dxb5SZnxs8GaPQUfLX3Uc4hL8f/UqQJzIrQHvAROXmqWGjOs0glF12E+R7KH8tOnPREoqASkTA560IYBVETFUl8jfzRepvBfOJY7Osa4bWGXzNjPQ1+S0xe9S30D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770461; c=relaxed/simple;
	bh=qOc2Yc90dsMYkDqxDQPjAtDHWYmR39nkh+FTIYhuNTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xo0BcPRLJ702pi6X69XYj9H2vL2mEaZ0nf7cXy9ZR9F1vycT/ZX1nRwK8nEQMscaUgPalpUBKQaxvw2mIkzbAS7JOzxmC7ntjd3byLc1MHK8Y6v/4S5UMwDjah8aLpJAtMMMM0IJosqJ4MGvrbSK2WdSywFKMoejQwQb9uSDX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14uCg/K0; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640cc916e65so3886846a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762770458; x=1763375258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Egm6bH8haTO66pWlj9ItuOdMEFY5snjzdOZKIxF5pdA=;
        b=14uCg/K05sXC7gfX4vga9G2yabPKBdqsO4KoHzBNH60iLvtW6bzLwitFjNBTVJlXoX
         3MC/R8xNtWBssqSDJEKj995QqFgQznCHfSOPd17WK90k7amx8MT1mUHZNUnLdpr33tmv
         tLB154QCX93MF9M5pq39XEh4/RQONltfx7HYlu3rSFWJdYD+19pjpp07deqgsVydT57x
         +nl6dj+A2ggIdFLBL0wUpBdMwW0OfUfo03ecFmhgb7Pb1e+BQVZ5Qv5nTXuAECufCOLM
         ugoSntFqvY/AKRVKHIi3YV7h950/zTeduP+4IQU5VMhKKeXage53x/QPWJuTixDKC81X
         Ikhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770458; x=1763375258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Egm6bH8haTO66pWlj9ItuOdMEFY5snjzdOZKIxF5pdA=;
        b=peUqS1dlpA11xH/53+5ovs+W9TuqTx5VkutuKEDu3gzOZyAgDn8PzA+2Kj1WXDR3Bj
         5D5cogbAnJBYaIWpUnd85J72DBliFMB4Tvi9PS/c+n5lqP89AKbcPbUGabf3AknK3dsw
         AE6W2MYAHEoo3nGHE7r2bJiuXTlgyGD0ZTMC2UjdTMv//eATP7lEi9dw1W6BwGXuvPMy
         wYfi3fAfvwx0Xj4UA0tZUhSaZ56YR70rvfV2c8y0xUIks82jPMlFospKDcTF7HtMaio9
         GSsBhPZhEJL3IOlXfLwTfG8aW2Orh+69Z54357/2dg57BHXHGcv094MeuW+n6kUbaO/j
         s6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo5WTN6BvbqRLwThjkhMfSVeHZuvBvhfR1B2dvNlgNSdUevoyi11KEq3tv5r48sGRRwWwmbFB5O7iWP2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5Fioorfgad++0Pvm/WkibrRGHDkoSiOidfeeaz3QHfsddAHe
	r/WEYhgl5LZx/HRJpaNrKxmxz+DhyytWH6uOQP2jfmsuWuJCdFN3zKp9Wsb7eCrvv/BQgLPFY6k
	X47W70SNZspovYRCUlA==
X-Google-Smtp-Source: AGHT+IGusiuHZLT3Jzp+Pn6pR0ClVUPAC/bjvfmAH1j2yaYh3CBjTcnQebjmD6hy9yf32AJb1ySOZAn3SaTPK0g=
X-Received: from edhr13.prod.google.com ([2002:a50:8d8d:0:b0:634:4a04:b8ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:84f:b0:640:c95c:be17 with SMTP id 4fb4d7f45d1cf-6415e6e759emr6717600a12.16.1762770458616;
 Mon, 10 Nov 2025 02:27:38 -0800 (PST)
Date: Mon, 10 Nov 2025 10:27:37 +0000
In-Reply-To: <20251110095025.1475896-3-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-3-ojeda@kernel.org>
Message-ID: <aRG-GU_I3MjT46dQ@google.com>
Subject: Re: [PATCH 02/18] rust: kbuild: introduce `core-flags` and `core-skip_flags`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:50:07AM +0100, Miguel Ojeda wrote:
> In the next commits we are introducing `*-{cfgs,skip_flags,flags}`
> variables for other crates.
> 
> Thus do so here for `core`, which simplifies a bit the `Makefile`
> (including the next commit) and makes it more consistent.
> 
> This means we stop passing `-Wrustdoc::unescaped_backticks` to `rustc`
> and `-Wunreachable_pub` to `rustdoc`, i.e. we skip more, which is fine
> since it shouldn't have an effect.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

