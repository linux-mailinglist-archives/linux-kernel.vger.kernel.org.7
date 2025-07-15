Return-Path: <linux-kernel+bounces-731358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73732B0532B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5D97B00A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5B2D0C61;
	Tue, 15 Jul 2025 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZAJDKp5"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007552C3262
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564284; cv=none; b=diQx/AyU5ImXnzn0Eynq02D12wCoWOVdkkJpTCojsyNcnYvDVU8QurLYjd5vSnj3J6a5Q2b9T8I8+diL3dy11Vp5L8CbDgsHm1aQ74oZBjg0Ti/ddiOZVUUOsnCnJSzwo07ThHlckNIaSdLAgujhRk2HcLSVc2ZbCKO2cICoX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564284; c=relaxed/simple;
	bh=BXyko810aRn/59qN8Dbms+0M26EAE50MrFLbT1Q7m3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7irbSJZfNBD8y4EdX9FxA3zctUk3qtdI3NOfRDqfgEdsFMVEvpUcQ1RvslxjJMWUfmDEl5q3JrxWcMHCKmP+fr8l9DjGbNTbP0gkoQT+XRP5V3NWpmbHq7Kiktn0yFQK2rV4sBJuOmjVrx8fM2c9QVqHxj4gy7V6oulJQ2Lg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZAJDKp5; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so19668175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752564281; x=1753169081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hdGlrGBQEUJXzp/eQUuBesk+Ba02ubRYc7z27fwLas=;
        b=3ZAJDKp5gMkvtQFoz9oCLqY/4zptncbFCX2N+UDO2JZDuXyfPVs70sVlBKDWdGesFf
         n9Zcpeo0YQzmA2uBVYvXBwLW2anRUrXzOOOTs0U53r5Mqwa+hZBovyZ60wumWuZZOOpB
         PMi4lxfIMOa3yIKmRWpf4u+PTc58wnDJjvEguW/oK4EiP2EXRm+V/t1QprT5dUKr5kSo
         qzzBNFpxHBBti7DTZ1CJC0NeqRRGoyBqhRyRF217TKQpXM64gXg1r4y/QR2G1qXxQec8
         kRa2QETo/vuaC4sNOXth63ZB545gmjI4rIQyJuS4pVktZVuTmhS3GtAG8VDJREYeaJj9
         f0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752564281; x=1753169081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hdGlrGBQEUJXzp/eQUuBesk+Ba02ubRYc7z27fwLas=;
        b=U2J5Z6iqY75F0UADEuK4pdZovItQtaLzY4dABFnvibydhFFC+4z4EY+loCQnnuEHL4
         NExMuZvGZtLjn8+UJybxuw6J7N3Fd4xCf30NboEe3F079ui72PSpG5Px1AoQparjp188
         ies8N4bq9PIYDLacCqeBvqs5x+W0g29pCKynqwfIlwD3DfdytV8p7gn3oMDYducMuWKP
         0nrVhnstAnYDV5ehwfrGfC1nlcRXwO/zKbuNMYkqVIs0j5mGf7vIXOaG1PyGoPVqgZLX
         2ER4qSej7bSqBN1/EJ8e4oUZmbcmH13nnW52DfiNBWvJJUFJUF0O/CYvRb/JMXNJjjNo
         8IkQ==
X-Forwarded-Encrypted: i=1; AJvYcCURKUCNya8AZMnY5J8GzCpyGy5gbBBoZjqHvYYxmgFOwkKM5C1Q7/g7h+2k8t1wu/Jk1PTby5hH99Zvkzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLgjtRnKKE7eopYZrHTGc6grfRRG+vyHhvA1fjRTYFzgW1ged
	+u+wMi7Doo6418S8z8QjoT2hHF5mdwl2Iyc0gniBWKzxttHD9TvVQOEuTpI/8S90kLz51llxLxd
	MFXIv4I3xS2NpRMeooA==
X-Google-Smtp-Source: AGHT+IGiTh9nWGxvf+BwXvOy41jNPCHQyebs+bv6UB1TIYkjqU2al/w8X2e+nEmDmdxBxEESnLif+UC8q+e1VRo=
X-Received: from wmbbi17.prod.google.com ([2002:a05:600c:3d91:b0:456:506:259c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d93:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45619eb3240mr60493535e9.8.1752564281284;
 Tue, 15 Jul 2025 00:24:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 07:24:40 +0000
In-Reply-To: <20250714113712.22158-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714113712.22158-1-dakr@kernel.org>
Message-ID: <aHYCOFZZYbgP39nR@google.com>
Subject: Re: [PATCH] rust: devres: initialize Devres::inner::data last
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, daniel.almeida@collabora.com, m.wilczynski@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Jul 14, 2025 at 01:32:35PM +0200, Danilo Krummrich wrote:
> Users may want to access the Devres object from callbacks registered
> through the initialization of Devres::inner::data.
> 
> For those accesses to be valid, Devres::inner::data must be initialized
> last [1].
> 
> Credit to Boqun for spotting this [2].
> 
> Link: https://lore.kernel.org/lkml/DBBPHO26CPBS.2OVI1OERCB2J5@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/aHSmxWeIy3L-AKIV@Mac.home/ [2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f

I couldn't find this commit. Where does this apply?

Alice

