Return-Path: <linux-kernel+bounces-893017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F1C46588
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028FA3BB135
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE853081CE;
	Mon, 10 Nov 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTmhAi2G"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14236309F08
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775047; cv=none; b=jcZECkPv2g69HofKplXniiBaZVKdg52o5uhNVGTxMmNFNr4etTJ1PD7cur34+T+XvFCupsnHxd6+pukWZFZdWyBwiJaWBoI/U0ipkk43J6x2AIfSRpOaVKTHYy4qmklYiTXghBoWYGZI1CXyj6/0NCrgwXMktHxeySImNuidtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775047; c=relaxed/simple;
	bh=KHlEJ3ZcFOvOfciC05S5x0Xt1y97nhfIAVEf/vmkfg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SHd3Od1qDPX55xI7Sc2LaCY5Ixkbz8r/Z+TRN9Ochm6HnIdiKpirjp1sTmWBJTwIAcLiiaPUf1HWaoaAHfFeUGS2Ugv3rMw5miAP5iQrIJqhdqYjXJpbZ17OOEOwbxgmVvv7VrB6gExoQV9SgWTI7EX0fxAfP2JB2hbV0CdlN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTmhAi2G; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d110fabso22755145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775044; x=1763379844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjIkKq2mWwIfqO3bEG9TIc4WKN6b5GBEeKQWWDEpLnw=;
        b=DTmhAi2GRC5/ozUW5FI0/rOwl81sPZduocy2op1eV4dYPJppBB7NqvN8RlibAG/jg1
         /ZrvW1pGpLkAzxXlRRIkTWvuouko3aI5YXxiPRyTa7QP7uIKtZhupLcxtPQk7yH5blAe
         1arYaNgFy2+OEk3CMRjYh9bc6R8Io3/FmRHjvilSpUeUXqECial2ucC8l72Ayx2uEOOX
         ZK+hNpp5jrynxgeD0aLvsU6KxfMQ1mikbKUMt3Hk+RvgVKkNWVJlOx0TpOzOjbKwRCGA
         fAb2CFPTCIuE5+F7xZx8X72SjzeiKFa4Xtdoa739NMli+/+hKYOz9faoH3qKmuJkP0X7
         xV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775044; x=1763379844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjIkKq2mWwIfqO3bEG9TIc4WKN6b5GBEeKQWWDEpLnw=;
        b=W9+bFxQ15ELDkV9tUGr7RoInoKkOjOfmDt/nzM3fi57UYHmwlWSTAyMmW1uaFTnYU4
         LSmYfp+ir8T8+e1cFIDRxbnLaNxjebd4Rowl5NFFdjhevnXhV1VcdtFNDvHB5ar1GKRg
         wpAbYYguBN8m8ORuZPqZXGXvorsLv3v52sSQlbbfhV8vxrn5dhUnVH2fNAag7HQmsPs/
         6KsquQeZb8xYn3YpnflONb9pzpQIA7xw9yFKB/BfrpWNh8vS/5U1wVtEZeII1taj08gW
         IPdAv0/q0dMWdt2w/ETPYIerUnXuXj2Dlrzv4wUVfJ8KhM85sk9UwTULiLSJqyrduoyg
         ORzA==
X-Forwarded-Encrypted: i=1; AJvYcCVxkFgCO603VFIHUMLC67KGY6mx5UUOY8zkI2SwPsRiJHl6RyUfLzD0R2uuWFHXgYb+TVcTrUsscra+Zto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4k1TC8GnAisc8TaE2u1tq6bT5mKh63HkCvkX0DhUwlI8ulZw
	9t+u1FSxwthWQJMFIJCqjEbo4QGbtPRhAJ8n0NCaBD1QsGs1uhCGWtBb1XWfOzuX4w6PSf+hRhB
	W+yqCAkY+xADhH5GPkQ==
X-Google-Smtp-Source: AGHT+IGkuNbhhInDD1ZmUt1/NhCQQS/t6wQ2i+1z9bpocdva95THZTedwTKnj4SLT8o++qExerTsl+FlUO1zVo8=
X-Received: from wmom20.prod.google.com ([2002:a05:600c:4614:b0:477:77a8:8918])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f94:b0:477:639f:2ae3 with SMTP id 5b1f17b1804b1-47773288ba4mr64880965e9.40.1762775044443;
 Mon, 10 Nov 2025 03:44:04 -0800 (PST)
Date: Mon, 10 Nov 2025 11:44:03 +0000
In-Reply-To: <20251110095025.1475896-14-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-14-ojeda@kernel.org>
Message-ID: <aRHQA6FEoxACerIQ@google.com>
Subject: Re: [PATCH 13/18] rust: quote: enable support in kbuild
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:50:18AM +0100, Miguel Ojeda wrote:
> With all the new files in place and ready from the new crate, enable
> the support for it in the build system.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

> diff --git a/rust/Makefile b/rust/Makefile
> index a614a23023cb..801a8cbf3bdd 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -199,8 +218,8 @@ rustdoc-clean: FORCE
>  quiet_cmd_rustc_test_library = $(RUSTC_OR_CLIPPY_QUIET) TL $<
>        cmd_rustc_test_library = \
>  	OBJTREE=$(abspath $(objtree)) \
> -	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> -		@$(objtree)/include/generated/rustc_cfg $(rustc_target_flags) \
> +	$(RUSTC_OR_CLIPPY) $(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
> +		@$(objtree)/include/generated/rustc_cfg \
>  		--crate-type $(if $(rustc_test_library_proc),proc-macro,rlib) \
>  		--out-dir $(objtree)/$(obj)/test --cfg testlib \
>  		-L$(objtree)/$(obj)/test \

This change seems unrelated?

Alice

