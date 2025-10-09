Return-Path: <linux-kernel+bounces-846698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21EBC8C53
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5DF3A2F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C62DFA3A;
	Thu,  9 Oct 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIYZsP3Z"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD922C2340
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009021; cv=none; b=r4ywnpChJUb+rBs97/5awsEhrTQHQgu3USY4LMylgX1ghKeEOUsKgujI0wTV+j6LVKXnWf36PKuELPzm4zPK5jqE871Yg7bMkUVKaWa4GGkZDhYGS+CZMfkrEjH0zaCdfn7hGkWfSCkoKbi2J/c3T4Mz9lzkKO+A8yDCt6NgSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009021; c=relaxed/simple;
	bh=53+4wMC+Onj0pcyyb0tfum8mda0xbfemyz90dOOvrPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CP9gtlzxdXGSDhLqpmfH6bbTFVrzexhh6dSxJl5vACsi68LTDKFmTwUiglcI7Q49k1++8oKVptzlWWTZuyjH+w4J4wxtoZNg1koEuQexZ5umlag30lsuKvEWbrFUDroaCJSiVQSda8VBp4zVKEDL1QmJD/8fbKVAvCOkjO7xFgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIYZsP3Z; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e509374dcso3575915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760009018; x=1760613818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=53+4wMC+Onj0pcyyb0tfum8mda0xbfemyz90dOOvrPc=;
        b=jIYZsP3ZMtzVqywlXndbqPqKh3siGpvb4G4NLele1GQsI5qTVbkQfx8+aR7LfGYB4E
         vMoIaVwS7AyfJnQznILuSCjqJ7my0mepXBKTGfSIhxpwASrtN7nJC8jVaE+FF+1Z3eEU
         S2WjHnga+XjcBHMlu7W/FfcbCpO62aVHo7UsTAALEey23RoqgOew5Ad1gPeC77LerDi0
         Xqtdh7Wt3EBtTsWriWQfL47dlFC8cOCu3MKPQv7W6C2xlAavto1OO04U3h8t1APRdUJq
         UvNk8AatoKnTdU+yrwByNV4h5M+OwecuOeeRUoy2UYttdMe+e8ycVrQiX6SIUBrPXQS4
         Yavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009018; x=1760613818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53+4wMC+Onj0pcyyb0tfum8mda0xbfemyz90dOOvrPc=;
        b=W2C7Ac51dd+M3Zi6B7qHILRK7hYDJCYDRjAERdgnQOKb2feEnBadQCCdqbP+1z/KTm
         o2A+y43mmYoaBQC14W6j5X0Rb+fVfwV3uLmsbbgk63d3X+i2fdMFANXe6UHZ60ExVqE2
         U/kSrqnJq3J8n+s848KHXg+mMAWD2dCMq5L5oaky0JV2UTUjR25jkTyR6M+j/q+n4ZH4
         jakO8sRis6GtjHILJSzbpgypAzAP8yG1x93D5JJDgLgDoFqxPJo9TB2EKV4fAiJGqx9d
         rwO7YAPqIHcLBmmCqvn4GOX+5h2jcfjERolZle4zUhEa/dbe2bOSGjJiNYqd5l60NKJC
         VrTA==
X-Forwarded-Encrypted: i=1; AJvYcCUVmp/CAPOPJEJJuHhfZC+3kgNaA1qHZT1L3+yHfm09Mn1+xlF1cEDO2TlrMF/WKdXUNA9dpFS6H6tyNtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpdcoUiIkhBJyHL6JBNAEUKPMiBs6W6VXa4aWSRC/uNfkzH4Hb
	dxHAgdK/30j1ZYywL38CTiyeLrxQieTcvn7iQu3pOzjHQJnvIAxNPXAGrXd18bbNRLxm7FxgK3r
	5wKPDg3HnnmljcBCr4w==
X-Google-Smtp-Source: AGHT+IFjXIT5EP3KT1wMYJ4PufzJKQ9ukEXL5xHmneDlYICUhOq5Et5M4EP34H+NtT1tIG0ujZvZF/13qZWJj6U=
X-Received: from wmvz5.prod.google.com ([2002:a05:600d:6285:b0:45b:7fa6:f2ef])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8586:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46fab89b7abmr30193915e9.34.1760009017907;
 Thu, 09 Oct 2025 04:23:37 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:23:36 +0000
In-Reply-To: <20251008181027.662616-3-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008181027.662616-1-markus.probst@posteo.de>
 <20251008181027.662616-2-markus.probst@posteo.de> <20251008181027.662616-3-markus.probst@posteo.de>
Message-ID: <aOebOPvpi1sYKOuM@google.com>
Subject: Re: [PATCH 2/4] rust: add pinned wrapper of Vec
From: Alice Ryhl <aliceryhl@google.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-leds@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 08, 2025 at 06:10:45PM +0000, Markus Probst wrote:
> Implement a wrapper of Vec that guarantees that its content will never be
> moved, unless the item implements Unpin, allowing PinInit to be
> initialized on the Vec.

> +/// A pinned wrapper of the [`Vec`] type.
> +///
> +/// It is guaranteed that the contents will never be moved, unless T implements Unpin.
> +pub struct PinnedVec<T, A: Allocator>(Vec<T, A>);

Could we simply use `Pin<Vec<T>>` for this purpose? Why the new struct?

In fact, does the utility added by commit ac9eea3d08c2 ("rust: alloc:
implement Box::pin_slice()") not satisfy your needs?



Also, this thread seems mangled. Patches 2, 3, and 4 should all be
replies to patch 1. Right now the thread is deeply nested.

Alice

