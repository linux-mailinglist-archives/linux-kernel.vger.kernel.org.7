Return-Path: <linux-kernel+bounces-865186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703BBFC684
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C02B4E99EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66634B43C;
	Wed, 22 Oct 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddO0zmVf"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49C26ED29
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142317; cv=none; b=jfne7Sf3UIjAM/itBaIC1pLg8wo+Rp1W8a77nt6wo9DrTrcGKOqIQ+c80d42ekm+IJI2aRMZ5oqXGlEbZHNdQqEJEtl5RROFajg111f1atOIcecqHJpe0xQay37KpMMz5IO7duR2Z+tMxlEj/rNrxxXdUN1cVVR/oeg9AET1jG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142317; c=relaxed/simple;
	bh=bTXngrKwJAC0PgSgIdnFW1ls0SVJx0tCQFC0nZRMXb0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MrUReNd2hV7t1IwgJ4KmvJbH5o8K5DTgosNur9kZSz33pA+l3JQs6pL4BkJuusYXYA/Enf8X4lECV4HDpbH/fUOTZrbUnUHu8Su2Q4hbVuo2p/wFB8QvTyc615EDOc2+E8p1SJcgQgGsuyT2s6Yb1Co+c98pmZ3dz+iyPxf0I6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddO0zmVf; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47113dfdd20so21926175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761142314; x=1761747114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHfNryw5chUyQVL8AhFXOPzXxI8CaYFqteiEPSdeM9E=;
        b=ddO0zmVf7/79yuNh8pvePb13YEe3FyEjahOMlGiODZ9Ti32RSlvUBP0q6GOG3FnJuq
         gNyl4VhlRMXboqAMsbCAD68rAldJ7HZz67Mp4ggjhbC1tPdxsQDfVcDwfa+mqWhRBScd
         j/Ga7Qig/3H8brYuUGItIhrPX8cjNgvTHXYNfzK7MOFc2ViZCaOJpjpmdfN83kS5lgbU
         9VEyErnmtnB0giAZho63oEOkBKIaygoS9YWPZ1DsFA3d82om9xMG5WSqH0n8lyQ/ooi4
         GzVpEnQHHzFLi+8GqPFvmzqdbdITEqBirZpdSQCvM5v6TCFokXctm6bW4XEFFOmTWGeo
         oLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142314; x=1761747114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHfNryw5chUyQVL8AhFXOPzXxI8CaYFqteiEPSdeM9E=;
        b=RTM5cEs8ar6t5GRMVgiC4KTemmrBAvFG1wvEp/uDS3Hon5V7mQzuzLacpKxAfHP500
         tsxl0sZSD5uF7te3eglhws+MJBxn6H/k0e7Yq5lnapUJQyDL5zTb1GQ0gf4UVCjqZ+2s
         Qx6V4M6iOV56jXuB8aLbNdcfUBQ83brpSjIJvny6pQPs51p2sdOidPQai8IiFqUjSad2
         1niG7dzhu9tB68mCIFKnTDW3Ralh8BqEGz4DzTiC/XjePF6MH9NwYrLm2ZqJfoWpguRf
         rlbmtZjZTTTal09cwtZL/mDy014Rkhj1VGCXE1Go6wJ0dm6pmT+re9+OHaG7auQhTjWA
         XzyA==
X-Forwarded-Encrypted: i=1; AJvYcCXnqeoWWOrT4EIXm0Zz97fjeDJtpcCbXA1qqCEMhL4d8KmL80g5+WwB8+p2birUvFGsGd2PclPZgMuQQqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkbQnknCik7xD2far2PTdiXnZln/faY+t2exUNHC3w87iTtpJ
	wqR0U3pZZjmycqINM3IR7Lp91W0huO4ioJ+lUfPDoqk3CHRcTEdSvLdM9Y6ADGMLHbvlA7wQ8NV
	QOQYAHPdoM5FW/c7V2g==
X-Google-Smtp-Source: AGHT+IFkqdllbNl34eMzwvx7CHPnSm/L3O6tYExq+epl+LyNuTYeKLR1SA4LPS1EG/NgPCY4RiiyiMddZ+bZ2GI=
X-Received: from wmbg1.prod.google.com ([2002:a05:600c:a401:b0:46f:aa50:d718])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:6357:b0:46e:3d41:5fe7 with SMTP id 5b1f17b1804b1-47160986ed2mr83729665e9.29.1761142314552;
 Wed, 22 Oct 2025 07:11:54 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:11:53 +0000
In-Reply-To: <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org> <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
 <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org> <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
Message-ID: <aPjmKSrETqrchW_e@google.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: dakr@kernel.org, miguel.ojeda.sandonis@gmail.com, 
	daniel.almeida@collabora.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	ojeda@kernel.org, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 07:32:30PM +0900, FUJITA Tomonori wrote:
> On Tue, 21 Oct 2025 17:20:41 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
> 
> > On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
> >> i.e. if they aren't sure what the value is, then I would prefer they
> >> clamp it explicitly on the callee side (or we provide an explicitly
> >> clamped version if it is a common case, but it seems to me runtime
> >> values are already the minority).
> > 
> > Absolutely! Especially given the context udelay() is introduced
> > (read_poll_timeout_atomic()), the compile time checked version is what we really
> > want.
> > 
> > Maybe we should even defer a runtime checked / clamped version until it is
> > actually needed.
> 
> Then perhaps something like this?
> 
> #[inline(always)]
> pub fn udelay(delta: Delta) {
>     build_assert!(
>         delta.as_nanos() >= 0 && delta.as_nanos() <= i64::from(bindings::MAX_UDELAY_MS) * 1_000_000
>     );

This is a bad idea. Using build_assert! assert for range checks works
poorly, as we found for register index bounds checks.

If you really want to check it at compile-time, you'll need a wrapper
type around Delta that can only be constructed with delays in the right
range.

Alice

