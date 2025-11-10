Return-Path: <linux-kernel+bounces-893023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6BC465EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831341882E92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECC30AAC8;
	Mon, 10 Nov 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zge2fhhe"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0F1BCA1C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775397; cv=none; b=OOM8KCKcQ1zg9cRo0GJAx0pVmy5Hv4SNe2PGPjJbxiB6zx/0hhu5yg1bffBObIXGm223ufDGULDdM9wukzHNqTmLzMZBc4oJSaYPZnOxhQrKiGRG/aVN0R7klLQQkvCRxgdv9RwhpZzOauTCoofchNnoxRuVZ1MMpFTAIsYaz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775397; c=relaxed/simple;
	bh=NTkuc6uDmedR+Q04RzwdAyOhBfZ76Ug/d7nYzNh4m0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YB1RWBk4F3XqdQ0nVLrxVa6qKPxiTAcjGsxGDU0BdtGi7vxmANyF1MpdIqXtPWKrg1HmHcTNcTdnaT8A7bA00SzRdypZlA32YP3Pt+ZTFZAqjLc1WPBLt/2C+3am6h3fBJRYUxyRkrAH2o8MW3sCJS4P0nG7YWLDd6mN4/x56SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zge2fhhe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso822377f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775394; x=1763380194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI7BOd97owyrjUzzXBWgb/eTwB7JOAn2nWeIJhsXI4Y=;
        b=Zge2fhhehCxPEOiaTSL8urKNpDp3ZZkenYJCvy/SmXJmmF94D0R4b5+KVNMVBIQNF2
         WAz0felVu3AU+e6i347jo+AsKETUGP1zK8EMt7QWE+0BXunqHfUcCHfLvtUz/1SRwcO/
         6Ux7Ejw8Mb5aBE6yDCUyJq2dkwqhuH1GO924k3fvAuemoYjaNOnFsTvcR52Q7pz6gnH4
         Hz6SrecARspi6NZb70+cKizKNUdD8OpStX6BrrlGgn8gwhK879p2wQykxbzQkXSeDE9e
         99i8nCHfpEjpfQGwGxeOhdzim3G0YnZjWoMOz5IIu0eDJANaKdCQmCawtr8SeEWh4ljX
         I8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775394; x=1763380194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI7BOd97owyrjUzzXBWgb/eTwB7JOAn2nWeIJhsXI4Y=;
        b=B2zXxL0d4dMf+/e19cplSZJMeMrIJxcRW0UHJbr6aHN9Yjl9iLJ8k5fPH6wx6YA3pL
         Of90lcJAshvsK0JuUglYa9z3YSNeF4itrBMzNOYOf2al2EUTO9QYl7qgQQixolJejwlr
         ltOvNbGVnG5hUCKix7ao7jkRCI0m680d5txn4/ZQ7jY96gtB7tE3OGoI9Ful2xmuxsi+
         mtfzAj12+h9qGxM3bb7gWwIqqMPRsSD48W0Srxgwrk1L3/jlHTgGxaChPBu+AY42mUJK
         nWBJjdEfN79qaTAHSYrwYRgsUz6/sOkvLVzp2OSRoNh61C27v5vnCeJCo+ef1VGFLzXV
         D9xA==
X-Forwarded-Encrypted: i=1; AJvYcCWa7ZoQNk5mw5gcsQRGMUoLqJta9Tuu4rOyWMkyHcgfThORvgYMroSI1ujTGx40pNqYEwhQLYwwIXI0eEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmfo4p0L9rdQMKRveYwDXuQubhHuxxlMqVBTp5oFY00yciJ6EK
	EtcrojwvvnNI48EIDc1ms2r5aC5h0X4bgBWQiBG/w8nG716CNIAQWOuVoIVX/2aSycfS/5LLDp4
	8d3xsDq4jEhm4Sh+qbQ==
X-Google-Smtp-Source: AGHT+IHheI/7is/zs8xoYCCHH9TJVBmfgjIXrYT6nk8rB54oQU3DED9esEnZdNar7cXaooSPlLWXVMMw//Gx3p8=
X-Received: from wrnb8.prod.google.com ([2002:adf:e648:0:b0:42b:33e5:ebb6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2210:b0:429:d725:4125 with SMTP id ffacd0b85a97d-42b2dc62281mr6378454f8f.54.1762775393891;
 Mon, 10 Nov 2025 03:49:53 -0800 (PST)
Date: Mon, 10 Nov 2025 11:49:53 +0000
In-Reply-To: <20251110095025.1475896-19-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-19-ojeda@kernel.org>
Message-ID: <aRHRYbHIfxMQ77eh@google.com>
Subject: Re: [PATCH 18/18] rust: syn: enable support in kbuild
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

On Mon, Nov 10, 2025 at 10:50:23AM +0100, Miguel Ojeda wrote:
> With all the new files in place and ready from the new crate, enable
> the support for it in the build system.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

>  quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro = \
>  	$(RUSTC_OR_CLIPPY) $(rust_common_flags) $(rustc_target_flags) \
>  		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
>  		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
>  		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
> -		--crate-type proc-macro \
> +		--crate-type proc-macro -L$(objtree)/$(obj) \
>  		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
>  		@$(objtree)/include/generated/rustc_cfg $<

This change seems unrelated?

Alice

