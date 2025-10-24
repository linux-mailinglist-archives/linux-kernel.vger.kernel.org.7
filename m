Return-Path: <linux-kernel+bounces-868479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC88C0547E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E245F1A62D49
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58B309EF7;
	Fri, 24 Oct 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxEZX7pB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3322853F2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297180; cv=none; b=al+Z49fOtV3YTdpvcy5uNfhe0mCpIqbo+3WSkqyGZNO4HDmKSONur+AxjHy/2Rp/aYdg3d6hoOUvj6ynLlbfMrDzTFGmqlLio/dMCS0L42qpov2+JzTU69MCJIFgMoQXC88+ugCAyGtvcRh+6iRH9Wlqv3AuE+zSOtJSDbMMUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297180; c=relaxed/simple;
	bh=Py5QyIQVFVTx1zENh9xQwV4btqftsrDbHkuKSIYauzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cc5jjKMV8psvIM04PYarrF9K+U5mp2h/wAJ456uPPjC1OvIgiPneHefXJ/sbKcPUjZZwvtS0W+BP6vdyAMrMq9u1VnjV48Ad2OZ75UxxxqXsPzslomwsTU0dPHez65vWpSm5IvaJLJQcuHPu8PsYgrrkyiQ/vdZviF3GFXdWGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxEZX7pB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso15380945e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297177; x=1761901977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ulo3Id84Le+yseyETzGns1OxvWpuudj7+L+eKB87WfM=;
        b=cxEZX7pBkAACAuCU4lcVeGsAh6yLq4skBY4Rg8Ht0/tFqALP/6TQuDIbieMqyt65Q+
         WFQzBcc/Ovsqh8XV+mTqugAE7vWoWNs1LJ4Me0MpY5UY5reqUNNYnPmShdXUaAeHMBQ9
         ip07pZrZb4uB/CRAjMyHN5U2nyMrg1b1wXoCim0/I196VEub3Jwnktl2R0QdIukkA1Ys
         PdXM8bhe8FcJD+ABx84e167UX4otd4ThSc7NWb4R5qmwcOtqkHf93D4i6rBpDxiIX1LS
         PrjZ62JPI10X29+sPaU0glc8TbmuqB9YXN45mHOrhUrTTJzP3vY63q1wsT9AYIYsJak/
         m7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297177; x=1761901977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulo3Id84Le+yseyETzGns1OxvWpuudj7+L+eKB87WfM=;
        b=rMMjRza6hQnufSkn5ocsSRaWMDpVHPy0NpvxsUqQLKtjnFyHkOi8XCI8gM1yv8yfYo
         74Indcsu7+hkHH5JGJdJtvr6jnAYPIgLNExDG2AGuWnaaNWUR3kfI3UDjmJWKSGkoWdt
         mMES39hXJXPrzpGEXdXlyh3ADYP5PlxGWI7XLp9sM6YL49LxHWI2dnaLPt9tNqIcn8Uz
         t1jwyYZSJjkT+IAWu1okeeThO/DiXy3L0SKOai8kWJ/FwE6WuOWdVzvEmMU+KLmB14k2
         uUCr0A75rXk0EYkMTvKTQ7aKxv/GmzbWjjxN3ww16145pG5LGr7krrb85rK2lgPT1aWD
         PvhA==
X-Forwarded-Encrypted: i=1; AJvYcCWi+JSh+1nRp2kt8X+lqW9jpDVeBXIXMnjtXHNUT0v55yjeR107+Gk2WqwPZSUFlu9wXbQav7KT/Xzchu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEqS7lSVu0SWd8E58e49FkEKFSzQRKCIpl/H1W96In6ZAcS7h
	IlzP81AnR1kVNwIr3rL1R0MbwlZIBko+wvhggpebXUzPf9NIOKIM6yjfCOvavSOkwCBiIMLq9Xz
	YBs4qkCIBhU8XD2ZKTw==
X-Google-Smtp-Source: AGHT+IE9kXnufXu+7tMdDMKWy6sLQPlsvxtyBst07CdXVQmNvgRG+EcaYQNuGz8TSy0rvIW8NN75riZMgHZERlY=
X-Received: from wmbf9.prod.google.com ([2002:a05:600c:5949:b0:46f:aa50:d711])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr219334345e9.30.1761297177194;
 Fri, 24 Oct 2025 02:12:57 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:12:56 +0000
In-Reply-To: <20251023171607.1171534-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023171607.1171534-1-yury.norov@gmail.com>
Message-ID: <aPtDGA0JjmfDvxXd@google.com>
Subject: Re: [PATCH] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
From: Alice Ryhl <aliceryhl@google.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	John Hubbard <jhubbard@nvidia.com>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 23, 2025 at 01:16:06PM -0400, Yury Norov (NVIDIA) wrote:
> Commit 1f9a8286bc0c ("uaccess: always export _copy_[from|to]_user with
> CONFIG_RUST") exports _copy_{from,to}_user() unconditionally, if RUST
> is enabled. This pollutes exported symbols namespace, and spreads RUST
> ifdefery in core files.
> 
> It's better to declare a corresponding helper under the rust/helpers,
> similarly to how non-underscored copy_{from,to}_user() is handled.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Overall LGTM:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>


In include/linux/uaccess.h there is the comment:

	Rust code always uses the extern definition.

I think we should reword this comment as part of this change. You can
say that Rust accesses _inline_copy_from_user() through a helper, or
similar.

After all, when using LTO or other mechanism to inline helpers, it is no
longer the case that Rust always uses the a function call.

Alice

