Return-Path: <linux-kernel+bounces-781765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9DB31674
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45950A03F29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C022F6575;
	Fri, 22 Aug 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leIePJR/"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6412F49EA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862730; cv=none; b=TIucBY+x17pi0uPGy03Z7iYV+xeuKrwgOrG/ryOuuyuzcoNHsFgZUUhvIFa1pJalva5hiqJcRC/CWnzBJmHPANLio1MM/oCeYMokHJvhxrUKijhhu3hnuOOrmrCNyDDBN30Sj0qYf8KRZ7K2IAZuZ0qqv2Tt6dofTJ7GkIsc2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862730; c=relaxed/simple;
	bh=m+A9WcXi5zkO3a4udqaXufGb0jNFoo6PlkvfjpuydaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGinGDUB/QiCW4xjWWnSJltdD6VKWqF7ME2uE4Dotb0bS/mqx4z9TPyCpSI/sGlZvrxlPqFLpGmYQIhXD5O9z0ZJTP4Jj5pDkMXRcf27HU1STr8wVKjoeYxhgtcUc92n0pzgRpDwxl/keLYMM7TD4bnjJstvrC6BapkHZbhBks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leIePJR/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0514a5so9823825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755862727; x=1756467527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CFcr6uz0jG9ffYUWcqfQzbDevoZ3JeHXkrQo4S5TjdQ=;
        b=leIePJR/ntGiXCVjY7d5+6+xISvElRqLJnMhnW6QCJtaL5jUqYdyKeJ0SmLt3usA3U
         2+ydUXOsCSLoLZFNclBiOTzPfF0hR53s6StWKeAXaUb7T7aAdBsxrNjRwryLtFhKx1b4
         IEWzIy5bCi9hMU5KiDhB+kWQxvHvUl96yrA8bZT7PIjKpDjarX3ct6tIsELrOz8g7Qof
         MQUUxCKzMVJN0KOOWJBvS7D0BrgHpjFP1jQ6eDnfp0193USwEFcn39k9aThoEuj7ChSa
         VR+/oQ6iOZEu2AQAfNipAzPMUJHCltis7opfJnN9A9rLhoak7FKQV1Aak9DgoKxC4NGB
         D4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862727; x=1756467527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFcr6uz0jG9ffYUWcqfQzbDevoZ3JeHXkrQo4S5TjdQ=;
        b=tjxMFjPOvFVGRAELL1mCiJVvPBSrfpbAysS+/WMcVllq97NiqobpYclqQkp8j8PzvF
         ZghOXSxdMBGMCAD2wM6SwwjNfmaFkolyNL+m97BHA4NWN+rPv2uvLcar6iVA0z/z3uJX
         6UmhX6uJiwzgjquUQtc1HLRjxNuRh+fI4FYw7dEHg/jEq6XHcXRJp0wnDxwLBRj9cG6D
         m7gEBeO30/DPgW7XoySYB6CSV59rlXneWnvrTqBIUYxJ26SYvc96Hx/Yy6fVUWkWRTpd
         C+UX6z42SXS4ouRleaFBcRQJ+sTfLn3Oay6fFs0MqlgagnBoTAwBhghyOaE96pDwW7I2
         0iTw==
X-Forwarded-Encrypted: i=1; AJvYcCV2//Y3YXHL4lBTT6f4XBnFZGBoCcQuSRPo8ZKmgG8CC7pdOvauAFYqes+g27CrgYxHQZTNjuQrrHRxcc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHu/qZJCWt7LCeE7U9o79hiqA2GAWK2ajqV5ClPeibhwTbF64
	aWv4cfL24s32h4EXnrQAWtW2Jjsg7IdLoBDItMAvWIlKKJUt9rREuaLqxYVXGKZyjonGtNp44qM
	Ut6M0cQIuy4ZZ5mnl+A==
X-Google-Smtp-Source: AGHT+IFj165R5y0xOFN9mQjeC9un8ZkWRh+o/LKKA4frRy8x/8931NLrOa9vNTnnCurNnFmGJfO6w53TOHPIGVg=
X-Received: from wmsr18.prod.google.com ([2002:a05:600c:8b12:b0:458:be4f:f5e5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46c5:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45b517e95a3mr20199435e9.29.1755862727525;
 Fri, 22 Aug 2025 04:38:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:38:46 +0000
In-Reply-To: <20250820165431.170195-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820165431.170195-1-dakr@kernel.org> <20250820165431.170195-3-dakr@kernel.org>
Message-ID: <aKhWxpyqpneA1AiG@google.com>
Subject: Re: [PATCH v2 2/5] rust: dma: add type alias for bindings::dma_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Aug 20, 2025 at 06:52:56PM +0200, Danilo Krummrich wrote:
> Add a type alias for bindings::dma_addr_t (DmaAddress), such that we do
> not have to access bindings directly.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

