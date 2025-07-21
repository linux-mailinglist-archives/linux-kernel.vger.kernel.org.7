Return-Path: <linux-kernel+bounces-739490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C917B0C6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB4E7A47F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2042DCC1A;
	Mon, 21 Jul 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rs9hlKkK"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752B2CCC1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109303; cv=none; b=bxpJ2vG/67T5qQm59Obc1Dw80f2EdFe507I3QF2g5shg6999NzPAnsEQLH69KC7q3fLEiRLNAIwNj3LI9+ygpp1/s/WXG612N4NUy2PegMdWTF7wfB1Rcf84WJZvIL2EmDt9iR6MjoP+6wUYe2zWcNMYJcPLLgM5YFAK9cDwmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109303; c=relaxed/simple;
	bh=I4jLIWmwGVUJJ/6bdkDboyVQrOENRDt9C4hsL58GpWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TtN7LVpOrTNmiMF2P4xx2knzhglYkt0bZP5XhX4vFdswbOMsgbxYJsetk648FRi6G4YLfkjgC6yN5138sWLXy1zA1YCrE+btGEli/6pyxGCwmmckmbBqiAqbfGTcgCqZ5krqW2UJfo1f3rWQbhwGdlT9E/OrIA4ooNAWPYBcXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rs9hlKkK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4538f375e86so40041545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753109300; x=1753714100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBPEQ6OO0ExtlokldbPFHvDP61N8dRWQ/XgYp6jRamc=;
        b=rs9hlKkKHg42FVbsZcAESXc79G6FmMkFlsIPvkIYXfD4yu0sJzdaN8Pa9D6EbviyN/
         AfLvkrwo9DUCycX2maseLqok3SAs47Rszc9fpwOo6DjrgImyIlA4A2ECStRW5zeo5ycQ
         rFGsTBWYuFRnaqMKfNrhF4NbneBc9Nwkv1HG4pTFkWPsT0jclOJXuunh7ZhL5X5M0ciK
         16VS1CfULCHPope4t3c/bR05X3/wmxcfjbU3YcYH4//LRIHcoCS6FWGCRRiI2x1XhOfF
         kVdqdUepU9yKEQSy7/7LfQatU/umE1PDmslUqiyQJbBt3Ep/GTC2NLgBta50ioLMl4Nw
         W/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109300; x=1753714100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBPEQ6OO0ExtlokldbPFHvDP61N8dRWQ/XgYp6jRamc=;
        b=ZiU45+RAU7cjrXgigIt3rfpmY29x5H8swFTE4yIjCd5BV2k/7A4osoLVh2E7ysX+95
         8/6YKO9QLx3jSjx9rP2RjjONthThiZRcP9X3/9mhfagV7ldwrm8QVWJEwiQfsrQjj6MT
         Pxc4Cs2u+1hIRsuZViGftItGB1sVjMae9SONY2/x+FlNkrUV2faXfSb4nu3Q467kBjib
         UgXYpVjGsxhP+Gl35QXmvlz4eRqysRiDqFEaCFSXzJz+RKJNuNa+bO+YjUWFomopJMwt
         5VzPQhAd5lhz5o8fu2ksNFZ27ihBbrrR5alTPSVdMPAUYQb0geqpqzrc9FxW4hXtAp/z
         Zc+w==
X-Forwarded-Encrypted: i=1; AJvYcCWN2mmpFN2tpQLmDMTUw8XU4X8WrW38yyElfci8AkS0ZaYOcBROP3JoCG21LLLcrQMg6wvVBRahItOXM20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt79f4heTfiKa2rqI9kRJqa0c2BSzcVGaOmoINtu59QQxTv4I3
	0ekIyq/KNelIEkPIILQSJJeGaDIarDJBmvltFCJuiXzsNjd4PsbrTGodjZImm0CupRjD9Abx5Ej
	yf/97mKtagf5lAY0znQ==
X-Google-Smtp-Source: AGHT+IFvYQFbKyyXgMmMx9nK9PaDmq8YZ8gpFhGULfqq/Qkd8G+UVvspeqGM9WubACmqo9Zb7EKKoa6Ux0XDoYY=
X-Received: from wmth21.prod.google.com ([2002:a05:600c:8b75:b0:456:f62:301d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310a:b0:456:58e:318e with SMTP id 5b1f17b1804b1-4562e29c660mr212367875e9.30.1753109300316;
 Mon, 21 Jul 2025 07:48:20 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:48:19 +0000
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-4-d469c0f37c07@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-4-d469c0f37c07@collabora.com>
Message-ID: <aH5TMzJGqzg3wNjK@google.com>
Subject: Re: [PATCH v7 4/6] rust: irq: add support for threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 15, 2025 at 12:16:41PM -0300, Daniel Almeida wrote:
> This patch adds support for threaded IRQs and handlers through
> irq::ThreadedRegistration and the irq::ThreadedHandler trait.
> 
> Threaded interrupts are more permissive in the sense that further
> processing is possible in a kthread. This means that said execution takes
> place outside of interrupt context, which is rather restrictive in many
> ways.
> 
> Registering a threaded irq is dependent upon having an IrqRequest that
> was previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

A few of the same nits as on the non-threaded patch apply here too.

> +/// impl kernel::irq::request::ThreadedHandler for Handler {

If you import ThreadedHandler at the top of the example, then you don't
need this. If you want it to say irq in the path here, then import
kernel::irq::self and use `impl irq::ThreadedHandler for Handler` here.

The same could make sense for the flags. You can write
irq::Flags::SHARED if you import the irq module.

(This requires a re-export in the irq module if you don't have one
already. Also, I would make the irq module private so that end-users
import everything via the irq:: path without a sub-module.)

Alice

