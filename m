Return-Path: <linux-kernel+bounces-893020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D43C465CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E13B24BD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EA8255E26;
	Mon, 10 Nov 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INJlm9ib"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5190309EFF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775250; cv=none; b=tZ9I9vo9Qa5E9LEpDIFR2zPtjIEN1Jh0ASYGDMDCejWCGbFaJOM83l+Xcnjps0IwniPR0Exnpg4MZFWg0CumAukEzxjqqy9mvkPhSXpAGQNrXjF3ZrV6pb3RN/DfrTizl9S5D45Z5zqlFZ2L8j+h3yeiqdVnjgiwAKnKz43Htew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775250; c=relaxed/simple;
	bh=Certre8NKMBWjJMOdCkjiT37S95gzPpjFWT1M8r9T2M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DmY+6bjNb30mytMUnolv0EcTg/zpgpZDc2GwW2SzwcA88YQo0wuDbawZB+2sdjfUANEci15yAT/QxWjQ8rCasLiGRfpEUtB5NW6LuiVXzcIA8sAKDLcV1x/8JuMJluD4jktcsASeOn3cGlWJps+6w9H33btDY5DhPaskMOg2saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INJlm9ib; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b33d2a818so460757f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775247; x=1763380047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yAt7Z27w/lXRkHSeX0o2zGMIVMbZvME2esCv61DwS7Q=;
        b=INJlm9ibIvrZ+wYgtzhvboaENtDAIrI6dy3Bk/JMDydCdFnSUiXqjD7wvKqFVdnP/b
         Zh66kWpa0/fIZyN7bKajxWBttrBPzrFesfyZb7/+vqav8nAErFrtiDBfKXVjRmICqPhD
         bm1CeInN4XTcIa7xCGC/5IAgqKqX2FuS+icLLEH7TRG4EthIvJlFcjS2i/0CGvwqywFG
         W1PyssSUcVUs8JlGMWDN6dG9gOjobpL1Qw97yxu8UhS+9wEfgLgrq9lrNzjNh2F128gz
         9JEFv+qHyca98L5DbJQCAn/4xuWLRSIziK+vBtrcuEHQxGaACM0Fmot3486cflJvJkPN
         PJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775247; x=1763380047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAt7Z27w/lXRkHSeX0o2zGMIVMbZvME2esCv61DwS7Q=;
        b=DU+BZGiKZm5UeUBDCRH/CTLs8wwxXErAZmVd5ksQjd8u4Q4WnlfVKsqyTnJD2P32Ea
         K0MielEpnVxcgtHeNGae8i0vG8gu4z+SLtxFXJrctKmm2rozsFD6QTeLKMUlg17N1DuN
         JtxmDtnQ/MIUqbSTPAHCqVZp5aCLDyiroN43aLMeNSICJMQudZ9rgm+xSE4Tso7Wpsl/
         Cgp4ZoDfUSIq35QCzeUswJJeJpRL7KoRNwlC6S2VsaaWSiobC4rFEeRNemt4bnSU6b14
         juytozRrjbPh1jewcC6lwfYsK7/JupkQfWg+rmyjOaoO/1yZ7qsoLnmWQs2bioaxg8D2
         sx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqErMx8ewqSrG8KQ2YKIcyJ0xUABzhF+H/O6ysEiitjLixo3dT7oX88Zq5LCh+U7Cj3KmOZalCsHfl2vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuziMUclDNMKZsbV3blpE4z8vMfvwX7wCleO7GQyCLXK2EZjoy
	s2BIQCFsibBYkW3OdeVx3fDHorQTFQyDe0fFCsPQLHELsYCbXSuMvGQo4dYgXRtZS9y7GxjC9a2
	PQw9mOaw7HtBu/6S8IQ==
X-Google-Smtp-Source: AGHT+IHCLy2mdnxpnK0+nxJnKpheaCzAh9ChVq3lvYBA5uZFfrDQycfDIP5ZYdgDCadZ+3ZCgwyWUNwt33mUhMs=
X-Received: from wrbfp24.prod.google.com ([2002:a05:6000:2798:b0:429:ef2d:571d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f96:0:b0:429:d004:bb2c with SMTP id ffacd0b85a97d-42b2dc6c8a9mr5644715f8f.57.1762775247005;
 Mon, 10 Nov 2025 03:47:27 -0800 (PST)
Date: Mon, 10 Nov 2025 11:47:26 +0000
In-Reply-To: <20251110095025.1475896-18-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-18-ojeda@kernel.org>
Message-ID: <aRHQztaAl6Hi67FM@google.com>
Subject: Re: [PATCH 17/18] rust: syn: add `README.md`
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

On Mon, Nov 10, 2025 at 10:50:22AM +0100, Miguel Ojeda wrote:
> Originally, when the Rust upstream `alloc` standard library crate was
> vendored in commit 057b8d257107 ("rust: adapt `alloc` crate to the
> kernel"), a `README.md` file was added to explain the provenance and
> licensing of the source files.
> 
> Thus do the same for the `syn` crate.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/syn/README.md | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 rust/syn/README.md
> 
> diff --git a/rust/syn/README.md b/rust/syn/README.md
> new file mode 100644
> index 000000000000..d3e3981da2fe
> --- /dev/null
> +++ b/rust/syn/README.md
> @@ -0,0 +1,13 @@
> +# `syn`
> +
> +These source files come from the Rust `syn` crate, version 2.0.106
> +(released 2025-08-16), hosted in the <https://github.com/dtolnay/syn>
> +repository, licensed under "Apache-2.0 OR MIT" and only modified to add
> +the SPDX license identifiers and to remove the `unicode-ident`
> +dependency.
> +
> +For copyright details, please see:
> +
> +    https://github.com/dtolnay/syn/blob/2.0.106/README.md#license
> +    https://github.com/dtolnay/syn/blob/2.0.106/LICENSE-APACHE
> +    https://github.com/dtolnay/syn/blob/2.0.106/LICENSE-MIT
> -- 
> 2.51.2
> 

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

