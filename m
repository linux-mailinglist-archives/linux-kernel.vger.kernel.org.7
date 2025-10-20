Return-Path: <linux-kernel+bounces-860329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C1BEFE23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987D0189D49B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA02EAB71;
	Mon, 20 Oct 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCEu12VJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2D2E9EC8
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948333; cv=none; b=a/JN/u54w3fqzo4lMfayDrCwQCkr490cNeCrSYKTHNWdWw83kbo1n2wIrte6TkoEBhf23TXSLMbO/J7tEvLtzgKpwbLuFGqs4w4PCboiM4HUq2GcaHsB5fhXX3oo+PxQXFwviUM8zuDXLZXhQch7rAlA9b4Lw2XeBAeQBrSOj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948333; c=relaxed/simple;
	bh=imvN6OIlDvER3dnhuPZTK+cbR4jLuWrSlQXSWBmvKsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PPMdzJeXb+5pLwEvKW8vWHyDriEUJxD0XggS7mRmWLyklKfVcD6VXOuX3P8WO0KJP9J6hEXrven5t9h7Y8WsboKXEvJ0z/W4dTlh7jMHGqbQr5qVtMwedhVEX+kZkb/VihUSooBBWzKZdWoWOWXBplbIqX8sHTWVSlEpHGsQlP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCEu12VJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47114d373d5so42352515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760948330; x=1761553130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+TidoBM6UYTxK1t76ZQ0iqUFS3cENqqtCJBnIaW78OY=;
        b=PCEu12VJ//CKm6HUi5w5ug0snNU2foDOcU2pU4awLYhtlviLxFreHMzPBZnfi/hPaP
         0jrvGJrc85AwjWNk73o6eA/2L/8yBMtl6ew4qo5gRpRbm4o09FUOVyzs8NbVIa3ZRTmM
         QWH1PcekX9a4lR4QRqik+qgc+FevA1O1lBPrr3+GWkG2K754c9rtnpLWjUSrRbCjMwwP
         bhE0j4yuOgOECLwpufI15oiZ2zZMOQCOwpUieoLht7/IH/mllKXDbVPPhpaOJo0SN1Y7
         wHWJznJ+aMYDJdHqjovbTAyBjaUBwOh5+jLk1fruv34MRIzGMjpHzJHWz6Gdz94R4HtQ
         f1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948330; x=1761553130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TidoBM6UYTxK1t76ZQ0iqUFS3cENqqtCJBnIaW78OY=;
        b=ES4JcFD7PPOE/Iv7F7k0qvyZma+iBPNUzuoHhaWD3bW6wC90LLVe5WrXDMTlYZIhEr
         bIVI82RaDWz5a5Hmnoi/9Ify6v5VVmQEp+V8rzuyOASGCiR4Dl9wmRnoAKjAAzMCk6NJ
         jYxfC1PYAFT2XNWYz3qEk0ZgzefbCVRxAwzW9raV1AF980vDsfrWhK523Osi4NktpcSn
         sBRztSQCYH6QFt8TVCfaPW8zMwbm8pEf6hrrqOOhGSX9dfXrBuCYVQizU+7q0Mpes1Jm
         wcb0tRGUKKdQEJlzEJr+LNEbP0IS8k3POdSUCuUaYfpZZGd4Va+9oOE/T4gC59f80iBb
         pHVw==
X-Forwarded-Encrypted: i=1; AJvYcCW7PXaCMuD0XffUW95RXfoMvuLndj4B9535S8zbHP4PqXGuFigzDGJdlpI5SFCkUUM1wGa2OTxK7ImITi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIkI2AUwsYuKjfEgmrKz+xAGHu/4bdIr8ona3yyRjdLKJVOEc
	HGGh7hVJotPHRhuuzAcSKzGSjDqNuoHZeSJ8COXU4tkzMMb9LkPmzJh02SkTyu8iCqTtQBWw6hL
	/TjnnbjOgbBYwHpq8dg==
X-Google-Smtp-Source: AGHT+IH6cTvgvqBVmanxid/HP3GehfJar/GV5OoQ4tMxA1m0oJwddpwo/mBB/g6vXikA+BLp7VSPyKDcGfE3VEA=
X-Received: from wmwo28.prod.google.com ([2002:a05:600d:439c:b0:46e:6605:3ac2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr82363995e9.27.1760948329742;
 Mon, 20 Oct 2025 01:18:49 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:18:48 +0000
In-Reply-To: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020031204.78917-1-huangsiyuan@kylinos.cn>
Message-ID: <aPXwaDI8RUjMzMKI@google.com>
Subject: Re: [PATCH] rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`
From: Alice Ryhl <aliceryhl@google.com>
To: Siyuan Huang <huangsiyuan@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Oct 20, 2025 at 11:12:04AM +0800, Siyuan Huang wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Siyuan Huang <huangsiyuan@kylinos.cn>

We should make this method accessible under kernel::ffi:: since that's
IMO a better path for it for cases like this. It doesn't really have
anything to do with pin_init in this use-case.

Regardless:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

