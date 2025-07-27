Return-Path: <linux-kernel+bounces-747002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A1B12E18
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863473B79F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6F1DE891;
	Sun, 27 Jul 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5hWyPrC"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA94315E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753601677; cv=none; b=X/X4v1YNCTgEQsvQtDnaIhmk53mbnO/CL+Q7g7pAPGlMlG0n9RnCKEFd6gpVAGyENyGIFBgYL8zApmWaImcj4bqwqHmP9N0PZUwtm5Kz88SSzGFgi4X9t56XdqYkZgGQkUyDJhqOZGug7G95AUa8XyPIN/zsYHduIL6M20MLbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753601677; c=relaxed/simple;
	bh=8+bnU58LaspktJem6W/nlUrpzrNHGPqCKrRuXE0xU68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7LNmsOl3mcVa23NwSg9VtcY9pirlfQYL9DJfSguj6+DOYaC/Hvsdv12reQP6ffUO7yBWP6yPL1LALI3zR8DaFksWMKC7fqqN0VW7tLACPGCPRl5AE4mnFded7lVJ69nYLOsraUuwG93NOAzDOWpKtuddjGWGkwp1bcMznRFLfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5hWyPrC; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b783265641so428985f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753601674; x=1754206474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68/AY/ySukW1KvXzDtVzgA9hvMtx8WltT8ZbSyTDtt8=;
        b=V5hWyPrCTHecPmSIwVW0kedUcbH8wJPJ7blMjqnYHd7Ft9XQOYy4qKUuhnG+wnWCvj
         hvVdzSnLciGjmNWNo8AST+M/0kAn9Hk08vc0ueNpGRs7vsGrjbr65vKQPZhZwFX1NnF8
         +nWZNVtz1GDFEwfG9Yh/YnkEFNdgSVGevn212dOMoGDPJYxkGZz4j3JzkwU/DbyiFnv6
         5mZql1WwkeWy2VNkEM1DPe5YBJSiX1+3ITfYopM7IGiSdP8gY2OPcUFabODdXjOaQcb4
         PhqhvzRXBvhxgGJuvzN45xsigmGCqW25TOVuKai8GKLE5KtiaWcqIR7LDO9kN6cXCuoc
         daqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753601674; x=1754206474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68/AY/ySukW1KvXzDtVzgA9hvMtx8WltT8ZbSyTDtt8=;
        b=COceoc3401HlRYdi9LHfjnxvk7I0PVokrzx7w6dVlLHpY4wLBIWb+05MCZ1nHE9tPf
         EEqy7+yRkacapx3LT69JJrH+OS0ghWzJZRthzkrW7cn9sLrUNwFNEEOZ+YVR2aEz+D8r
         a1QWPCoBjlAmt8YC8ZAeXeXGRqrOWbFPSmdIkQ8aZbQnfp2N0nt5KDPHnhs9z2QrJCch
         QGnQobDJ3XUuUQuF1sV6woxqZhxQS585AM0CaRUgV5MXPes0yRd/COtieLTR8o2wvpfo
         KpysEekTqpIPjErmVr+oxZ42fY0GR1gh/gS69S01/+SqvXWVDCODUSgHtiGolQCHzTtv
         QI/A==
X-Forwarded-Encrypted: i=1; AJvYcCW8SsLPx13Qcsu6F5la8qR80EixvxLaeKJ8oYAMRe+XjX5OvgU+cdc1Y+uumAsVTt8cOYnZcIFqX34ngho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8T1KRvV9nvRbBOLVfVh8IqPHS0sQd5itybfxZL7ywWqhAJEOQ
	S0iE8P9+TUqiKsL34E/VIyZ6FA+hTRlLzXF+GfEF6cprxk/kRgIOWkXDzRqWRHnoayjmQuO31nh
	7wqOkUpX7KKiodfITXg==
X-Google-Smtp-Source: AGHT+IHoTwJpLl6IfPSiJvLh0y07TsSZ8n5EfvV9N25CW1WA4KKDIWG6gN/cQjkXU4JcZHm5rVLArTDuOg174jw=
X-Received: from wmqb14.prod.google.com ([2002:a05:600c:4e0e:b0:456:1a41:f922])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:290a:b0:3b7:6804:9362 with SMTP id ffacd0b85a97d-3b7765fda75mr5447346f8f.26.1753601674392;
 Sun, 27 Jul 2025 00:34:34 -0700 (PDT)
Date: Sun, 27 Jul 2025 07:34:33 +0000
In-Reply-To: <20250725202840.2251768-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725202840.2251768-1-ojeda@kernel.org>
Message-ID: <aIXWiYB5LiFYTN6p@google.com>
Subject: Re: [PATCH] MAINTAINERS: add "DEVICE I/O & IRQ [RUST]" entry
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 25, 2025 at 10:28:40PM +0200, Miguel Ojeda wrote:
> This entry will handle device I/O patches and abstractions (such as
> memory-mapped IO and system resources series [1]), as well as IRQ ones
> (such as the `request_irq` series [2]).
> 
> Patches will flow through driver-core, at least for the time being.
> 
> Danilo, Alice and Daniel will maintain it.
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Daniel Almeida <daniel.almeida@collabora.com>
> Link: https://lore.kernel.org/rust-for-linux/20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com/ [1]
> Link: https://lore.kernel.org/rust-for-linux/20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>

>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10850512c118..ededa04ef97b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6920,6 +6920,21 @@ F:	drivers/devfreq/event/
>  F:	include/dt-bindings/pmu/exynos_ppmu.h
>  F:	include/linux/devfreq-event.h
>  
> +DEVICE I/O & IRQ [RUST]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Alice Ryhl <aliceryhl@google.com>
> +M:	Daniel Almeida <daniel.almeida@collabora.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://rust-for-linux.com
> +B:	https://github.com/Rust-for-Linux/linux/issues
> +C:	https://rust-for-linux.zulipchat.com
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
> +F:	rust/kernel/io.rs
> +F:	rust/kernel/io/
> +F:	rust/kernel/irq.rs
> +F:	rust/kernel/irq/
> +
>  DEVICE RESOURCE MANAGEMENT HELPERS
>  M:	Hans de Goede <hansg@kernel.org>
>  R:	Matti Vaittinen <mazziesaccount@gmail.com>
> 
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> -- 
> 2.50.1
> 

