Return-Path: <linux-kernel+bounces-747970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08915B13ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E8A189A8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F074D266562;
	Mon, 28 Jul 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="matGIt+j"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146725178C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707207; cv=none; b=VlXHWY5dQmRbwMCGJfBwCu+gJLhsyOTsP7IZtH3N7L4aV3PzPUMyma6F7hvuZMRLBHxpT/nWVn+9YOkXEU0CHR/HgsXG2oh+eKok5ILwmo9epWpPfOyoy4WIG9dTzf7mcEeXbakcOL+EuzetUutwE3ON/bSnzLhRuzbgmUSnvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707207; c=relaxed/simple;
	bh=qMBsJXHYzsr3CVUkyq1ay5nCxvYaIy0ErdvCISz0MaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKaBClnAomPGGxyHXsgyARBfozCH9+Fc/K3tGoKG+0R1eztuQlt4YUF3CC8knJLeGBp4C84JlCl8Y3SQGrK8odDmgSQ5TAzLzvJf03L9CWtvzamqG/mQ0wsrWsCxapd4gsR71WsTigpdhguMyYMJ8PXPWPWpymeRO0fJat/lylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=matGIt+j; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ae354979e7aso342340666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753707204; x=1754312004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BI1sNBtXSiaperYDJvrUgI2+ExhfP6g0qAUSRJ8H4Ao=;
        b=matGIt+jv02Au7s8aLMk16x173GhDPhU+1Aq/KOva6mFMcvl2JhPF0MaUU0Sp2CE2V
         v71TyjdZutro/oa9Zl9d6J7mpbVjUEDlEiQ7NJFZig3lWzR9MD4XW2Nl8imcAKyamqVR
         KsT7VRCYL+auRXmueYdHcRx4X9QRjjo0uB5TWnoZoEDXzE9ixumJ1fIkCL1RDlfIsmf1
         q//jtzzfpSnQTqcmE5YddcR4aaFAUkUcvMqjngSYzeKMze9SrjwpFpDmgtA68Xiyetg0
         4vMCncgG1tGCkNXgrrpGzzwF4zEaRGatDvl+rHzuy6owCKWcoqeSJ2UGsCV8rl891X5f
         LvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707204; x=1754312004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI1sNBtXSiaperYDJvrUgI2+ExhfP6g0qAUSRJ8H4Ao=;
        b=cTVNnrP+yDPuolSyK2cyLPbFS0dWaCUKHkU0pJcw1t5MDbWhkBuWGTP8hYBFtrgw0P
         oyNdfBNyCvBHUZNcqtHaO5ToTBWo+poQPvUs3vCLWb6BPBuQtG+shDz2JuwcAuk/Nv5t
         Z6QuEHu50POdXiPQnBmQQr7/NXWZMpK5LO264PxoplbYKDUWZtARHql6EiJjtl92Z6v/
         0zvjNPJhO1DGX+BrYI8G/HJ3igRazXA8gbLH6+14eQ3EWEsHzSaicsiURLNNgB/t7LM9
         NYxuG3mMzLgR2WQB0pWXNE16TyFzCSnZtV1IoHSQKoBta/WhPRli96bc20CP4kZ5mcAt
         /c9A==
X-Forwarded-Encrypted: i=1; AJvYcCVq4JdEz8fUJ2qQPaC5K3nHHHMgnEiUF4LPzMP3Mup8sPxlgYFVFpKAydMG+Zh52PG1AxDgWViUvJLdBMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmpxoQRe5fcp8xYYDmvrpB4rL4sk+FWAul6Sn5gus7Qf53njI
	9r39C+g+rmHZCLRhggnXxluUl9Rm3GIibsWy+7a9qdsoYISvFOkAHA27WtIH5DWMPeY9ONfM0et
	RmuPtIhz6O6d8Yr0Y3g==
X-Google-Smtp-Source: AGHT+IH05/Inz8BQqaQU0vmnc6FItf14b/KKYTp7OfqMnBxS3qWUixTLoETX12WaIgX3B3UIjmlGRuoe3ehDnO0=
X-Received: from ejcvi13.prod.google.com ([2002:a17:907:d40d:b0:ae0:aaa5:ea47])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c08:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-af61b004396mr1107148866b.5.1753707203947;
 Mon, 28 Jul 2025 05:53:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:53:22 +0000
In-Reply-To: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
Message-ID: <aIdywtMq_3ycrGNZ@google.com>
Subject: Re: [PATCH v4 0/2] rust: transmute: add `as_bytes(_mut)` methods for
 `AsBytes` trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Jul 28, 2025 at 09:47:50PM +0900, Alexandre Courbot wrote:
> This is the sister patch of [1], providing an `as_bytes` method for
> `AsBytes`, and an `as_bytes_mut` accessor for types also implementing
> `FromBytes`.
> 
> It is going to be used in Nova, but should also be universally useful -
> if anything, it felt a bit strange that `AsBytes` did not provide this
> so far.
> 
> [1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v4:
> - Add the `as_bytes_mut` method for types also implementing `FromBytes`.
>   (thanks Alice!)
> - Link to v3: https://lore.kernel.org/r/20250726-as_bytes-v3-1-eb7514faab28@nvidia.com
> 
> Changes in v3:
> - Use `ptr::from_ref` instead of `as *const T`.
> - Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com
> 
> Changes in v2:
> - Use `size_of_val` to provide a default implementation for both `Sized`
>   and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
> - Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com
> 
> ---
> Alexandre Courbot (2):
>       rust: transmute: add `as_bytes` method for `AsBytes` trait
>       rust: transmute: add `as_bytes_mut` method to `AsBytes` trait

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

