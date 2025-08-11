Return-Path: <linux-kernel+bounces-762308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA177B204BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2703ACBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B0C2206A9;
	Mon, 11 Aug 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zUn3UluP"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3E121D00E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906261; cv=none; b=DmjAjPNA7QkkgNdCdKHbtJv9swmKL6orc7UhKjynC/IAcQi6ofrYB/0hRWJaCBfuR06w9DJdqUnJbhYDJdIIdmgojPa5Na2F2SLp8VXuZg5roveiFe2PmvanuCrYbvH1TN1s9qvMIVLDdHA3j1FIfRZeoB/fppqB4ZiCpuBII+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906261; c=relaxed/simple;
	bh=5PPAq7zQ+nHCI/xWeUgCbm+CvBHJb1ncJO1VqxdJOEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlD6o/mbvojKJP8XYJbUSZ+GgdtND/XXVeFYna40Kx0TQrEdFFSJ7YndZFicBMkx91KO49EwsZ6PnF7TsGJ3UkXk/lPbDOOcXKLTKVOt/KyqyP7/uN8zwdSdnfP2Vr40ILz4R7BltJ2pGITcTip8iuBE8QAtVAQxLcsZXQz20X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zUn3UluP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b8dac70703so2132556f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754906258; x=1755511058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XgUyq597PLhdmrHv4R9AdRxrC+BasBMYjIqsUBUMvzY=;
        b=zUn3UluPzQNPteWnZvcm4AQHoSK85AUZ8y3T0igulw459OjyC3ovc9P0sp9iA80Ynf
         JW5FWP05Ztzo4ph4b/xwsNw7i2xQtYrKZV39IK6osBrmNDPVNuqDcNruufGLVEAc3noC
         A8lQkX63GoFsTJJLy0n7VFN7qeDJLR4Rw3VyUgJQJ0UozZOUk+BOq+Ooi515HoLxvQpU
         cVxeMdoJmAGiwy0iIUvgrkztE8lDyQIJiUjxrxDm1xxQIVw3IzdqVFXL2Bovv0XBwmB5
         DiSIxk6p8FIV+vyNVsdXmCc5RTE3Js65W3NhrnJm8z3HQpESfLoc5c1pRCQso9KGHs1z
         GXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906258; x=1755511058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgUyq597PLhdmrHv4R9AdRxrC+BasBMYjIqsUBUMvzY=;
        b=AHbg0xy2qbXWQs1smmnxX5MaCmOemHi/UrLCjPpqcbFQbJy2yPRj5QjSqCN/3pwnk1
         hGlLkL5DJAYtJKXN90Ax4ywjL3Whb+g+lGu1Jj/YYA+1LXmFNsDyTFxWPKbyFJC5MvuV
         nPF+ufyE+4Kmrdefj9DmzOMNfNpaNIpkGO/8IpOOxNj3i+PxWgLHT0BRrVuzeSdayFpk
         MQC0sDntJ/3AJQ9FcLWkh57R82R8VIHbkF8UPferkMRg5zI/+FqnK0C0AOajKBbE7ipf
         CJA8Ye8jUJ7q8M3K2yyLroBcs/7tb7OfZQ6NZtOy7R4xtByPYOdnVjpafEYTDVAoHyox
         5H6w==
X-Forwarded-Encrypted: i=1; AJvYcCVTt1inK5ntSaZJ/HKuENkqB14lbS/RKAJpE/4oFykBXjih7mo0GJTKwlNEbmYILqf6XsY0LstS+vs2/lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkvf53y4E9lFp87YGETK5tc/2VKiLe2RCMs64lc4wxrYwSTDQ
	11CvymELefdlcSENC8ofaBAYm6jx9AtLpsGFUcO6fgMSMSVgbcGIBGE60aKGLQxT5fKnD6iPTqT
	9pS1owC5bsvJU9g6Y+Q==
X-Google-Smtp-Source: AGHT+IHSeW9L4d6bbbYYcWTlBn9UOJ0o3JKIgssvda35McCGGelkKcsfXIZYlo6usbn103QEqGqi8VHNojgSTxg=
X-Received: from wmbfp26.prod.google.com ([2002:a05:600c:699a:b0:459:dd37:a6bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4029:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b8f97bb949mr12320547f8f.5.1754906258085;
 Mon, 11 Aug 2025 02:57:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:57:37 +0000
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-2-8163f4c4c3a6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com> <20250810-topics-tyr-request_irq2-v8-2-8163f4c4c3a6@collabora.com>
Message-ID: <aJm-kdPgCL09Gqr4@google.com>
Subject: Re: [PATCH v8 2/6] rust: irq: add flags module
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 10, 2025 at 09:32:15PM -0300, Daniel Almeida wrote:
> Manipulating IRQ flags (i.e.: IRQF_*) will soon be necessary, specially to
> register IRQ handlers through bindings::request_irq().
> 
> Add a kernel::irq::Flags for that purpose.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/irq.rs       |   6 +++
>  rust/kernel/irq/flags.rs | 124 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
> 
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> index fae7b15effc80c936d6bffbd5b4150000d6c2898..d6306415f561f94a05b1c059eaa937b0b585471d 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -9,3 +9,9 @@
>  //! drivers to register a handler for a given IRQ line.
>  //!
>  //! C header: [`include/linux/device.h`](srctree/include/linux/interrupt.h)
> +
> +/// Flags to be used when registering IRQ handlers.
> +pub mod flags;
> +
> +#[doc(inline)]
> +pub use flags::Flags;

Minor nit, I would drop the pub on `mod flags`. Then you don't need
doc(inline).

Alice

