Return-Path: <linux-kernel+bounces-777454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA0EB2D983
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702E85C5722
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A612E03FA;
	Wed, 20 Aug 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6zW90U6"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B42DCF63
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755684127; cv=none; b=dnKMKIr8fOPaGIkjjZfe2YZInf1NDkE4cvY2+t5MvlSYAvSo8Up7Ga3xWOm8B04FCmwLsIxCAtuo54TP/ba4zXdT7CWxp2Zt4obvnRURMZQVhItFeD6Kj23YOl6aJWWN6u1C0oPUpJh15Edox2bqJk2aXr8eBLxAfpAGGKGOqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755684127; c=relaxed/simple;
	bh=EghTE8Su2wFNb2wdtd4lL0HzIsRAjeS4B7EszInp8NE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGRxBKOAwgyMNILxHueUCTWCitDgcI2VmBjfwF+YMXtcxHNAavYj5gQhPsBoPwZMp943jystPF+Xb3WPd146mfw/Gr+cAooLtyQu1Js6xtw6XnpsLEHW1+4DIduNZusgQ8iwhx5sfaW1hCfTd4QtW8cX/6H7es0bVF7KHvoAuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6zW90U6; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5366so29522845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755684124; x=1756288924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pmKl7AjHxkBuQuyGuqlxx6fNULDA0e2THQiTh0AAAP8=;
        b=B6zW90U6cnZLa6ehjXWwd+/Qy8TDCC722KOfiLcR/hJ4mNgTIjwbBdeyHnvNtwAyZs
         UCL2SK0GP98XdSe190f03Ir5akRh4EN3poJoJDpluCYAaaVjZBBMCo3kBv6aTkhpP3l0
         y1A0YMl8cRG0ft9PN31xE1YYIh0mo+Ddedoqe83v+y8wd3SCa5YwqEWrLz5IV2JfF5CC
         yn1KWr5ghR5j5frFLBal2TO5Q2a51mLzaz8xS4RcxIVeL8OJ44QcV6sd0aeB1ijZzGj7
         0nc5DkPlB3r/SvQQOFK3eEtPz2K21IhUaQHL7qn4QPCkjLYdQFVy6fU6nUs/j7ogFgTW
         ptxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755684124; x=1756288924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmKl7AjHxkBuQuyGuqlxx6fNULDA0e2THQiTh0AAAP8=;
        b=psdorJr40uTCM7VHEDn+GueewedIYqX5ZFtSPDgPg5oIqI8f/y0QC5XQQKY6rpc3b0
         J6f/fPDucM38hstHLefb4sfnF+BBzewXLEN05+SUdJHdZ2XNmh9l4p9me7u5+xg9BUyU
         3qUhN/XJEZERMdgAcuD2GM0orkNI73oNTyfh1nresbvQRSiOZ0XIOOU0cvK/CNPpS8NX
         yfOESfS12gd4Cd/B4A5yGCPq0tbHzsLXSCUW8hyzVW57epoCp/Qq0YW3rh7ryJRPeA7A
         eTAc5kLmcUIKBZPOLc59gbInkG9HtuGZPKrcMUQGQAjN7UY77vuz05XaydUK2CSleyy9
         kCkw==
X-Forwarded-Encrypted: i=1; AJvYcCUbxsLc7QqfWyrYCWzAq/3btTnp8y4/TfPUylSUcQRchSDMct4VXQiS1fkb2dTqpm6HCi4mYW9Uej8uqRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/W4GpuaSbv6WDuqw3349rjxEAj1LJB9uvScQMoSks7EtyS3/
	NtqXz+6DzhMlZRmvzZtP7nHhHvJKJrZbUvAaaf1qnPETmnZpoqTusERDrh8NObP6lLA/ooNzOTh
	UemjdllSkze9Yp14bPQ==
X-Google-Smtp-Source: AGHT+IHeALkRz3Zj+iokcWQaLB6L1xFUH2I9sMR2ETzQnsbNqXkbGU/GtzFELzc07d5ahDJazaxqo/s2yy0QlCw=
X-Received: from wmbes27.prod.google.com ([2002:a05:600c:811b:b0:456:2003:32a5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468c:b0:456:8eb:a36a with SMTP id 5b1f17b1804b1-45b479b77fdmr13646495e9.13.1755684124107;
 Wed, 20 Aug 2025 03:02:04 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:02:03 +0000
In-Reply-To: <20250817044724.3528968-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com> <20250817044724.3528968-3-fujita.tomonori@gmail.com>
Message-ID: <aKWdG6ad5e_B_flD@google.com>
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_timeout functions
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com, 
	Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 17, 2025 at 01:47:23PM +0900, FUJITA Tomonori wrote:
> Add read_poll_timeout function which poll periodically until a
> condition is met or a timeout is reached.
> 
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
> 
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
> 
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

