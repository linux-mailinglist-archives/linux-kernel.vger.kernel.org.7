Return-Path: <linux-kernel+bounces-893033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F2BC4664B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2AF64E4049
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C373093CD;
	Mon, 10 Nov 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wO2hCQc1"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD72FFFA4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775600; cv=none; b=nu2OxBMCgJ2EX6YRvVmTs7wRUYwf6IMDPOoMgoj+3tEnWyl8T/0Lo4kcPwdkpRiGl5bFAk+L4PhQteJRn5TWo7rIIBTzVd6cHSA2qXd9xnnQPN+g90oR0ureTDrQGrLHLiW2AyS4rhFHaYTbJtklDYrNk2htzr3xycDpcDBOzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775600; c=relaxed/simple;
	bh=EDZJblRFOBVaS7V9swh66M5uzKZEQn6brygnQ0u2oxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0Ws+m+gCIYlIS3vrFJ2kRt6jpKpSCWqVQHXFnPmL0nfcoQeJzI5Gd/biBOUtLComX2ze643ixhvmEaZJAQWYRCjUFNhhK7rNPVfGEfghuj9NHfxo7L2yJXrSbvr2019q6q7Kx/Y3ti1f+piQ57cDs9OAVUOHk6A6mUaWoyAhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wO2hCQc1; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2ffbba05so735632f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775598; x=1763380398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEKi6XUPcJTxR8kCttvI9av/95c/Ll+7Tji2AuMb3UQ=;
        b=wO2hCQc1pDp6U+DbazLKOl9cCy6NhQ3O12tRziaJ2PPRzd2hFYWEMMDIxq0DgUOeCx
         4tYbbsJ5mGg2rY3lYM2hXOV1qPNJ4HFHogKZuBKa1nUrIELAtecSTd0eZOkDB9Ca+FNl
         2/VUne8RYKuI14DLlUfjn9Y9DLcRR5UHPd/cRYixc1293zhyUtjSjiOdloUzCN8aSEEz
         baxeU8hRzmw6333HEj9v4qmQTvjezBjL2us0WIaJa6GHjbpPLJf/or1WkMvU8P4NAc20
         NX/2hw8UFSW08eVk2j0pvkb0kCYqnscbHDirqI/oXPP7rFppDb+yzq+F3w13iIZr07Bo
         rB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775598; x=1763380398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEKi6XUPcJTxR8kCttvI9av/95c/Ll+7Tji2AuMb3UQ=;
        b=sTpRMi7OFLwL3G60orbDgzFdP3pgP8AWfyuiG//jfIG+oiUnDGlvpiNeurMMgKFdBE
         PNb9TQFPOmVXISNjCPE7/Gv11aRLvObuYEA8phLDz8fDylDeK/3GxvdJ4dnMOBSEuVP4
         W+iYECTAfkrXarOgE25VbDzQWJmIm+C7dfCV3+JIjOu9Zn/Xbp4Y5ofXaR5r8GK0enw0
         wJNigreJyZLieRzpHuEtbSlYQ5M4TDanM5ghNSxqF3/bEC+nvyVnR5mFfoXDjMV1Y7ea
         U9TGXCg0kinfdgLMDOLU9sRqjgryGx+9FPD+zKkcgrcIia3akksU1Xgw1qcj1YFlRyR2
         QRzw==
X-Forwarded-Encrypted: i=1; AJvYcCXYuOTVTXeCs8aGb6d4ORV0kXVuvXQosZ21goqu1DcQhfXkQbGnvwgdoaEuVxttILhJ3GQhWaqTldABIOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCNiflm3Ai34BweJPu7d3KwLRRhjP20glnZDF2u2tqaF2Y7eC
	cF3T5N1Y/C1jmp1FQGAAYGTgC1lUhrQVCiu1qjiU/huIPlErt6hLf9lhKCZCQ7nhhfWVPZWEzPH
	OG2z8GTvVdvBzd1s6cg==
X-Google-Smtp-Source: AGHT+IGDXVa4jR2Hvr+m+drHIkFWVJ9kU5jgqj0CSyP25A++0dFEDi+XQZITKlDq83CPddiTCOmKe1l7tbj1AWM=
X-Received: from wrnp5.prod.google.com ([2002:adf:ce05:0:b0:42b:33e5:eba1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4710:b0:42b:2dfd:534f with SMTP id ffacd0b85a97d-42b2dfd557dmr4843170f8f.34.1762775597658;
 Mon, 10 Nov 2025 03:53:17 -0800 (PST)
Date: Mon, 10 Nov 2025 11:53:16 +0000
In-Reply-To: <20251110113528.1658238-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110113528.1658238-1-ojeda@kernel.org>
Message-ID: <aRHSLChi5HYXW4-9@google.com>
Subject: Re: [PATCH 1/2] rust: allow `unreachable_pub` for doctests
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 12:35:27PM +0100, Miguel Ojeda wrote:
> Examples (i.e. doctests) may want to show public items such as structs,
> thus the `unreachable_pub` warning is not very helpful.
> 
> Thus allow it for all doctests.
> 
> In addition, remove it from the existing `expect`s we have in a couple
> doctests.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aRG9VjsaCjsvAwUn@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/init.rs         | 2 +-
>  rust/kernel/types.rs        | 2 +-
>  scripts/rustdoc_test_gen.rs | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 4949047af8d7..e476d81c1a27 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -67,7 +67,7 @@
>  //! ```
>  //!
>  //! ```rust
> -//! # #![expect(unreachable_pub, clippy::disallowed_names)]
> +//! # #![expect(clippy::disallowed_names)]

Maybe we should also allow disallowed_names in doc tests?

Alice

