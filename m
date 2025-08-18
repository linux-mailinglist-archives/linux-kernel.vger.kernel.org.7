Return-Path: <linux-kernel+bounces-773532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B42B2A183
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8A188B501
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB149261B8C;
	Mon, 18 Aug 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QmiyIlG"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AAE326D4B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519621; cv=none; b=QJGP+6lYNiN1IspCNg0tTNG7BKsnGtzbeArEacDNLIEPpjjHRuRG95oiHrXnn2uWbcg8JOmxe31FZ0SJAsPURWnYorycq1GwAxbTTyqExT/MhgG5jvf1n5aRu703bBQSxtQNttuMWuDygyrh+56/ANCBRZliUClxSm9FbT1C4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519621; c=relaxed/simple;
	bh=cD8CE/3bhnnbXlx5QfO6l/YUWH5jZa+hBHlWEOFlU4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MaWKo4EoT5ohNLbKys50Cl+eqNlTKdkA1zvhoY6RGViopMoVwYwe9a3a/mdEnaEFmRD3qeC4XhpJCRk9T/5/Sb9OeXLSWjhZoqW9rtgu53GY9DV56G2hKFusHY/SiJAK5u5j+aRhpBC5cBd5VdmBUVKI9RpJ9RxFwnCMgs3p+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QmiyIlG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9dc5c2c7dso2357488f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755519618; x=1756124418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXVEWh+UjIimvjXTo07gyoqfE3DCJt1vnCJfigFmAGs=;
        b=4QmiyIlGrIOH1Vrmo4l+2yon7SAemGun/v7p3h5C7Y0e/XE7DprQQsABoe2v+SsQ0x
         qtM1ObCTrn6iFvBmcsezI4bYMb6E0rYcOB5AUHlvr0fRtNUPFUW7NNdOpsTW4ZSq5OhV
         VIpODr0JbhTJkZQbe4inUVoqU9MDFVbpPPrNOm0KadqBbjpyomMBsh8cpceJsCt32CSJ
         znSk3TPvmzHuAmqQRo6FbDAk7+ang/2Fu6Ym5eIcNfGWVQ1fS5a2duVSIGgN8cvPd3UG
         ZcKnGZ7h9zCC0V3oUeeVaxoLf/JkYEuSJdLSokH2uM0U0YkMveuhCAcU57WqpojuxHH5
         HZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519618; x=1756124418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXVEWh+UjIimvjXTo07gyoqfE3DCJt1vnCJfigFmAGs=;
        b=qx9wVMVNumyALe22vzQ7v00quEjt3w9AwoyDv/Fmj8PGvrL6Z5+LA8+/g/7xMBIGM5
         w4nyjs034fXegXt7q9wEjTqLkq4vi2GMJ2DGSu/ykpoOLfoWdwQHAJtgfZ7OUll9maJx
         KDCDgrsjTKGfSbR99cyw3CQxBVwpM8TOrtWS25XZako1KhUYLP4OyjHzXRotKlGDKimx
         L8zmjWva7u0AQUyIgo93qUwxmkJVr2uahZdCYX5O1gCyar/5yCexwZ2BRhFCMMNeur11
         uK177LS02I2SjxdBiCzmmRLVW4De3fZI8WqR0P+nHTiKeFsM2RqzkRd54nN3NTOLSRPi
         ApWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE/ULSeoE8MmXKRixfx16dKv7OQfEWgwBLEqfv0aO+JFZQLpcOoLjkO7ghDk6b/6q9HSen9menLRXUIuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxCFAuovqu5QspA9LFtQQSH2u7I9Jfy/wQddZ+kCEG3Yim++Y
	d79UB24kv4DsGgjvSVGsajqNJQ2HDFiIOeKbc9xVHPtsKZLd7DNvs1FzrfSaHpqG/Xa4B9NB+Oc
	sYiIcJi4VFP3L0GnKGw==
X-Google-Smtp-Source: AGHT+IEsgbrPLrIZ6y0LhI19/RSkSmWScuqCJSGurfxV+xVh2HQWIDNMmSN339uuKUPu69gmGloLDhhGrdmggRk=
X-Received: from wrus6.prod.google.com ([2002:a5d:6a86:0:b0:3b7:9669:4858])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:430e:b0:3ba:d257:b662 with SMTP id ffacd0b85a97d-3bb6710022cmr7713380f8f.18.1755519617861;
 Mon, 18 Aug 2025 05:20:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:20:16 +0000
In-Reply-To: <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811213851.65644-1-christiansantoslima21@gmail.com>
 <DC0INEKNZPSE.WLEQH24SLW1I@nvidia.com> <5204b598-7792-460b-bec2-e3a4a4c7e32d@gmail.com>
 <DC5INTQKY0EX.1T4HD6OU8C4PI@nvidia.com>
Message-ID: <aKMagEO9O6WNhIUK@google.com>
Subject: Re: [PATCH v9] rust: transmute: Add methods for FromBytes trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Christian <christiansantoslima21@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht, 
	richard120310@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, Aug 18, 2025 at 08:28:18PM +0900, Alexandre Courbot wrote:
> On Wed Aug 13, 2025 at 3:00 AM JST, Christian wrote:
> > Hi, Alexandre.
> >
> >> I mentioned it on v8 [1] and v7 [2], but the tests that break due to
> >> this change need to be updated by this patch as well. This includes:
> >>
> >> * The doctests in `rust/kernel/dma.rs`,
> >> * The `samples/rust/rust_dma.rs` sample,
> >> * The example for `FromBytes` introduced by this patch which uses `?` without
> >> defining a function.
> >
> > Sorry for my inattention, I'll fix this in the next version.
> 
> Ah, as it turns out you might not need to.
> 
> We discussed this patch a bit during the DRM sync, and the consensus was
> that it would probably be better to keep things a bit simpler for the
> first version. The `FromBytesSized` trait in particular was not very
> popular; a better long-term way to provide implementations for
> `FromBytes` would be to use a derive macro, but that's out of scope for
> now.
> 
> Instead, we agreed that the following would make a good first version:
> 
> - Make the `FromBytes` trait depend on `Sized`,
> - Provide default implementations for `from_bytes` and `from_bytes_mut`
>   directly in the `FromBytes` trait,

You can put the Sized requirement on the methods, rather than on the
trait.

trait FromBytes {
    fn from_bytes(bytes: &[u8]) -> Option<&Self>
    where
        Self: Sized,
    {
        ...
    }
}

> - No implementation for slices for now,
> - Consequently, no user code will break due to the addition of the
>   methods, which is a big plus.
> 
> The simpler version that would result from this covers all the immediate
> use-cases and would be easier to merge, which will give us some time to
> think about how to handle the non-sized use cases (probably via a derive
> macro).
> 
> Do you think you could write the next version along these lines?
> 
> I feel like I misdirected you with the `FromBytesSized` trait, so please
> accept my apologies for that.

