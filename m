Return-Path: <linux-kernel+bounces-892876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48280C46059
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D148C3A6502
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AB306B3C;
	Mon, 10 Nov 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCUJFWQq"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7663054F9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771392; cv=none; b=QBa048sQm/aV9iv7DdbhCJ83uUktJA7MxYLgs6XqeudjTh8X/22PskNJ0tZOKFa8gKay7AWCOx6ISpp1Vn5GzZQNkGhDysexvFqbidKgGbs3YN8opaZqO35KIhTTTqJgNXv4nX/zMJA4AxDsIgniz+Njb5fvC892S/jxmsFMkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771392; c=relaxed/simple;
	bh=PaK9aaWb78+gpE3XwxvDFLq4iKRgKHKKrEr/MVH+uOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIftdmRSQljoqytZ7sUykizix7G6T3Fu5RxoW0gcWKS1IQoOBHkT+XjuI6obpg+tHLNPOcQTmUcXdQDDt9xVDFVwzUSflbZvRtxB7XQSt64zeFcnFqySM08cq+njuAX7MI0FRBuhrMthq6jwRfxgfQctrqXUJr7cillkqgLHtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCUJFWQq; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b71043a0e4fso266432166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762771387; x=1763376187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6sNizUOGkciptOGTci4SybgbOhVv6AEZQncHw0dXTs=;
        b=DCUJFWQq9EqGT7G9n7V/5XKEkgwo5+kB4E3oqDBF6+9bH7f0eddbHtyvP4xOkRQWl5
         7tZ+rMy7ONx72/XtWTmduxdR67YIjb45mFyfIC/tnGgTaX8RHZNw5QWbjDEQC90u2oqs
         +n/yCcRFXCkj9mqxZNNpIp40UWsEDGNDtz3ahGbhpsUNCWpSNzyVWYszDr5YJq659jiB
         4SVQewPPNerZf7tNyDqTRE6z/Sc/DRSeHbV8keZNpz9THNl1auMlPMbsQYqTRclpmX69
         J1Sb7C386EMWYKMOyHFKEwdciV34OnAwAa6DcgFEDXU4y2gZpb9ir+j3A6LTmisSE6Hw
         897A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771387; x=1763376187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6sNizUOGkciptOGTci4SybgbOhVv6AEZQncHw0dXTs=;
        b=L/21oCiyEvAVFS2gBcVBrMlGVH/CevlLv5/YmEY45qnzZlx18Xw0GC0xqVIP2pnf8b
         QNeddlVC8TLuruVKkXzGBEHZfxWFBUImN1xuOS/5PO7+HvDzUu1xi+p8IeBAyuYVLryC
         SjqVAEc5GMR1M3FaXKw/8K7u2RZPtAJ0cRASnbj7GwttSTmxp219wTVjOZm3z6wpylpy
         mMYH4Q18NRZUmE1iH9YM6BZGaUATeVLe5tLce0PgIUoZifPIPyXmon86fotJz9ps/Bf7
         8bZ2MtN/sXOkzduxCFMatCJAss/wgY+LcO+sB6JhtjRMOvwh/rebShdGfFYvx+Fg1n9d
         acPw==
X-Forwarded-Encrypted: i=1; AJvYcCUxM+1dP9E3IRTVdvl8SNBkXFQm0yAonIe+RAVLA85mO6cjWaG9sB+Vh2v2fT7L8McV6y0lVelP+EXRVo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/JlJ4q8VNjpgRMJ5BGxkh98anJDX4d7WJhyvB9AMxB+yqu1l
	RIHIURITJPMVUtrhmo4bbrKq5pXOhbimh7AGE9h3+Uk9e2PDtrETRtbv/RM8xXbhTgDyAHCkmu3
	gQFYqzWKfnWuKCDoreA==
X-Google-Smtp-Source: AGHT+IFY61ejHKFEIykzrnpB2o0ZUucS0nhTdm30eA2AKho8jI6G1MrYig9/jVIr/y6CqyP5/ec46LFxxBld4FU=
X-Received: from ejctp27.prod.google.com ([2002:a17:907:c49b:b0:b72:ce97:7786])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9812:b0:b71:34c3:d5a9 with SMTP id a640c23a62f3a-b72e03ee841mr671805366b.38.1762771387730;
 Mon, 10 Nov 2025 02:43:07 -0800 (PST)
Date: Mon, 10 Nov 2025 10:43:07 +0000
In-Reply-To: <20251110095025.1475896-5-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-5-ojeda@kernel.org>
Message-ID: <aRHBu3RoOLTrMA8n@google.com>
Subject: Re: [PATCH 04/18] rust: kbuild: add host library support
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

On Mon, Nov 10, 2025 at 10:50:09AM +0100, Miguel Ojeda wrote:
> Add the a host library rule that produces `.rlib` files to be used by the
> `macros` crate.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

We currently have two kinds of build rules:

* cmd_host-rust used for host binaries such as generate_rust_target
* cmd_rustc_procmacro used for proc macros

This is a library for the second case, not the first case, so it may
make more sense to name this rule procmacrolibrary?

Note that HOSTRUSTFLAGS is passed to only the first category, but this
naming makes it sound like it should be passed to this new build rule,
but I don't think it should be since it is not passed to proc macros.

Alice

