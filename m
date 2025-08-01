Return-Path: <linux-kernel+bounces-753128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50042B17EFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1E11885B26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B62222D7;
	Fri,  1 Aug 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZfpurnM"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00844221DB4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039698; cv=none; b=IJ4Yh0MA4VQeOKnryxtneDZTjdfZ83OYxZFYkMf2j87wOfVP2+otsE8lCv9PMcrPwh6M1Lz/FeripTRHhx/bk6ter7F1zxNLHBjP+Zr/Xmf3C4ThWLUOBxvOve5s1qJlJiVyB2yidJasZPRlCrKCbYQvq72kCT7bLxuaJW6Q9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039698; c=relaxed/simple;
	bh=mFtCOx/ocfy44fLE9/9Cbz8hih5ak3+65Hx/cX8sxpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rhp7C2aUXC274KVy5JW9Y/OE2X//eFxNAJ6eBDFK/SwUlmf3VUyKunugu1PN92traIdXOe1DXb0e47qXsbc+fSJGqlrMjo693EO5BdaciPbDr7+3lzy7iLY49II1iM3O21sbLjcL/YxxWF24l6IkC9mT8ZMozzCvLlREHbrvH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZfpurnM; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b793f76a46so1663687f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754039694; x=1754644494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpQjiOjYgpF0fuxQTSWWz9JedYu06n/jjylXo74pt70=;
        b=qZfpurnMDow25yVtPbxw+OGyS11bZrhBZtMrFhHRoMQNg1ueRWyADQ/e0v8+x6+6KL
         z1Sa7bqsh2PC9OXhkT8/bhSxzufgckL1bErOuR0fEpNCaiRVzB+7nc0Y/KA+mz9F8deX
         B5lvWbDZtNeV3Wmn40TnB2eUd08xdEQBH0ivUTbKzXOtx3PcmL4dshQaL8jI4Df0E2fm
         Z4inmaF/K2PZzBtgBSO73S4dJ1Xa/9EiSbHhgDtchb1P3y5xX3tCX7Zh4hLDafIqwRsq
         8/L0K0c4QaJMunQGtaLywsaPjNwkq6DwnYuWilikHgQYCso3uY1wyQYYO5xCAXGvWXdN
         YZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039694; x=1754644494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpQjiOjYgpF0fuxQTSWWz9JedYu06n/jjylXo74pt70=;
        b=dG7BTwlkfrzg+MUWDiqczCmWCFEKmC56UAeX74dPSKHTZr6XUGMZCXTq+b7PDOcnN5
         vO9PQAwUYINxdxZX8DkTQSbCj5Fp7wkerMvjwZnveDdwkFvDVsuDNNowhslV3M5fjefk
         YcsjXlbIBWPyRzsRD2VZyH8G5/nTsblgSAV6EylBj6cHAMEmNq59mpafQS/Uo+pOtmlg
         3uVPcB6fp3Qc23HCUR1xBggPDNKJyn9A7ev0AsDwmbg6/Vs+lbtpoxShcO2lhiOzyzFs
         fNnXfbd7cSyWJ5XPpXqFLPYKDk40Eh07Fc8NEWx7oWO11XdQXiakfEthso5wAp1/2Ja7
         T71A==
X-Forwarded-Encrypted: i=1; AJvYcCWm9XKimim21SJb8xPAd6LVb0jQWUF/R1vZ/BGJ6VOuW0BYg3+8AZyAy0Vlsh8fsVlwAb9vfcwyOlfUZ0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHqQn7JWbjgq192ImuYIGa49vs+KEHm4yF5zFiuNL4uIcYngm
	dgWE0ggWQe9RZ5XTK437+roDEY8B+ryE9+l+adzviJzkIB3pwt7oknt8nCX2unU0e+k5M4Hg1mX
	FgNfvrpU70ez1eT5TqA==
X-Google-Smtp-Source: AGHT+IESDRZCEwF7SL8d5dASeF7/YHXUd7DUV9ClWEwuYXtRvBgcLkdVZT/KeZok9+iJf2HhJER5jHKLA9aDBQY=
X-Received: from wmbhj23.prod.google.com ([2002:a05:600c:5297:b0:456:21f4:7a98])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2907:b0:3b8:893f:a184 with SMTP id ffacd0b85a97d-3b8893fa74bmr4215393f8f.52.1754039694365;
 Fri, 01 Aug 2025 02:14:54 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:14:53 +0000
In-Reply-To: <20250731154919.4132-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731154919.4132-1-dakr@kernel.org> <20250731154919.4132-2-dakr@kernel.org>
Message-ID: <aIyFjU67jPkK1BUt@google.com>
Subject: Re: [PATCH 1/4] rust: alloc: replace aligned_size() with Kmalloc::aligned_layout()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: lorenzo.stoakes@oracle.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	urezki@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 31, 2025 at 05:48:06PM +0200, Danilo Krummrich wrote:
> aligned_size() dates back to when Rust did support kmalloc() only, but
> is now used in ReallocFunc::call() and hence for all allocators.
> 
> However, the additional padding applied by aligned_size() is only
> required by the kmalloc() allocator backend.
> 
> Hence, replace aligned_size() with Kmalloc::aligned_layout() and use it
> for the affected allocators, i.e. kmalloc() and kvmalloc(), only.
> 
> While at it, make Kmalloc::aligned_layout() public, such that Rust
> abstractions, which have to call subsystem specific kmalloc() based
> allocation primitives directly, can make use of it.
> 
> Fixes: 8a799831fc63 ("rust: alloc: implement `ReallocFunc`")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I guess vmalloc handles alignment in a different way ... ok makes sense
to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

