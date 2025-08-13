Return-Path: <linux-kernel+bounces-766174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F6B2434B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C771893750
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1352EA155;
	Wed, 13 Aug 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6rea7jY"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCA2E8DF8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071565; cv=none; b=j92rCCfhc+kiT38SKdpZPt6oBbjsIKMoohRPALkTwotqFpgkqRGKx0nnnWPejD25hwfXcNByjtAuexZOo0JOGEDLT2rfoQSoPKRbFnxtrnz+fdt5g1zmYpeDHyqrPS7SsQDPOQl3cn5I3Bn9yY9PK6TykQpeJFhwLhoZ+jCF6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071565; c=relaxed/simple;
	bh=wTHkbolkWVsr/NVVpXeCQCswoJSODOIqqyaUV2Gnosc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/mFjOvdJy05y2Pb0l4LRG24tlRm51mgedMTNYZ6N0iysndduiRS1jxcK8NdCrF7PsQQL6zmLeDqFgauzeNYuTzsSRhlLOcRvty0QCUVZoYnuJNqcDbWk+/h19968mfx+ns1jVlud1R+23hJK5KJ+8Q0u+24+IA7ricCB05jd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6rea7jY; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b78a034d25so3233582f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755071561; x=1755676361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=02qDuB/EcGaJVS8+Q8TL27euIcDkVRhwVcM5c3itE0g=;
        b=Z6rea7jYeCtyCSFwOyVUAQIaHXdyS0VCOlSr3MtzNu9Ypcd4ywiMu6dsxcp0n5pOgZ
         nXpKZ4I1T/ERUEBULOdifeV3JwtOTnXLKRyar86NkCfW2q2Pk3ZNKvxaCaFUNnaWmxgp
         2IQLbW28wSCax7DqjUwyF48ZuAlsm3+kSGs/+szAZpfB57PIEPOwk7re6nrX52rdC2Sn
         82EIr2hLkGVnVIWkqgmhCHG1iz3OA5C/HhOaggfDlHfkjkEuecEW1247fROHZdIAaxQd
         KS4dewOSWkS0VcTdyjTJK+xkNcNVRqpN/A9XQCeHiBKgZMRd17j+hP2ApmtsTZzUP9z1
         fjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071561; x=1755676361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02qDuB/EcGaJVS8+Q8TL27euIcDkVRhwVcM5c3itE0g=;
        b=CBL+qTVdIEuQFNPzk42NmksPFDqWnQHM9sPK8AWU/Sn4Hg6SbIAQONRP91DBMUAvhg
         zoFXKFCgxLes8N/Ohu8Hcdn/JKkYb79Sw9jJPKd9fQ6oJSa6Q/WCkuQuX08Xd5lBiyEo
         Ntdhaz8+qoqVH2Cq+BuUau5v9svBVv7gAqrLOaix1LIvVysVco0AfNIDbbKTI/ptMdBI
         t8xlIuI7FBmEURWLmTtI4rVQ+0wHZAfHWKZIsb+RXtz0laKcMh3slBUdkibFIveRKn3u
         vUpqbVKNKkyZjQwpRMQRxYGxknr1K6NaDndE/lqPj1dKaBHBn2818jKQtU1pfA8iwaUF
         OrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWuCjagQ4ThXG2WED5nyQcJ4zz7CFTKFxvJvSHkl+Vp4SVMuLtrqKODh5yICr1o84SSwKq9oGcoBqQ9ops=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsM5NYXbOBAq25LS3yofWo/1pPNEpSyyE7UGPDY2KzWAzzXWHX
	FQUEk4763s7C8FxzugNwWiGBv/UqrCQQdRuStghMtc9vQ+moEetcHwfMLnQrAwM2G+vMQhVNRs0
	drdKNIzjR2vFWMGEIzQ==
X-Google-Smtp-Source: AGHT+IFQOnB3WTKhyHtvWJmH83iA6/rYttG73Tf1N82jwPFXufEqb0tOp/a1EyEQXFyeHLXn1qK53ixfr0QTKsU=
X-Received: from wmbjg12.prod.google.com ([2002:a05:600c:a00c:b0:458:a7ae:4acf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d85:0:b0:3b7:61e5:a8a5 with SMTP id ffacd0b85a97d-3b917eb5b43mr1445076f8f.47.1755071560984;
 Wed, 13 Aug 2025 00:52:40 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:52:40 +0000
In-Reply-To: <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
 <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com> <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org>
Message-ID: <aJxESG0l4-kyUHXg@google.com>
Subject: Re: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of each allocator
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 12, 2025 at 07:52:35PM +0200, Danilo Krummrich wrote:
> On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d77130b374bd1397f7384 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -17,6 +17,8 @@
> >  use crate::bindings;
> >  use crate::pr_warn;
> >  
> > +const ARCH_KMALLOC_MINALIGN: usize = bindings::ARCH_KMALLOC_MINALIGN as usize;
> 
> I think this needs the following diff:
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 84d60635e8a9..4ad9add117ea 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -84,6 +84,7 @@
> 
>  /* `bindgen` gets confused at certain things. */
>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
> +const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN = ARCH_KMALLOC_MINALIGN;
>  const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 25fc9f9ae3b4..5003907f0240 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -17,7 +17,7 @@
>  use crate::bindings;
>  use crate::pr_warn;
> 
> -const ARCH_KMALLOC_MINALIGN: usize = bindings::ARCH_KMALLOC_MINALIGN as usize;
> +const ARCH_KMALLOC_MINALIGN: usize = bindings::ARCH_KMALLOC_MINALIGN;
> 
>  /// The contiguous kernel allocator.
>  ///
> 
> 
> No need to resend I can fix it up when applying the patch.

Hmm. Maybe that depends on the configuration? The constant was generated
for me. Either way, happy with the suggested change.

Alice

