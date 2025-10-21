Return-Path: <linux-kernel+bounces-863082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5225BF6F67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C01C19A3D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035F33B94B;
	Tue, 21 Oct 2025 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4ieSrPW"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EE22F77E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055397; cv=none; b=LNF6o5z1NqbmSP5XkG6hCP7oQdgx3BTF68+fXLq9toEfButLYh3WdR6smpS0zkAONV0ut41IxjVtIYi7FcmcPEjYTyzCFICPxqPEfVi0EmOyL1fOs05G96CKRq7VSBKYJTeRZQ+WDt3DVErFZoehdWhJCockX+4oiZTwPKizaCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055397; c=relaxed/simple;
	bh=7G4waim0VeJfYc5UImM1ILNYZsWnKxbZqSwSOW0PnuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gg5b/R2OQWPLx/zOCQGiZ+lZG+MJG8l7dU+rHtrnyLPDuheAevU8n5vk+bxcD9t7bbdXjeJ7qi4spxiJ+xjjD4FgSgESAqWEu52WCv30gS2rQICG5iDbmbhAz6CTv1oKqTQVUFWl42wVWppVcsH6j31jwO0FiGXp/JJUkht2HxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4ieSrPW; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso62376725e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055394; x=1761660194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=shyGPfyT7UZA3DJZBC7WKsd1LwTAS0uHQ5zFBJIRGN8=;
        b=P4ieSrPWVKoIm/lC3yWjg90PbSAHzu3T6Sau4hmFsN5Jl9CtRaakSvc7ZkOI6QTOQe
         XKgoscI/r/u0QTnA7/0AkCw0Q/TLP0eduwPoMFecMAbE71mpni7DRRuzM8H/a5eXOv9a
         rrpU7GG2nl0LREd8G0LXkWDNCxyF+MsYGCAsWojwBdraHihmkAx48xnyea76gWYHprS6
         cWB0mVcViBFFvnr9x6hSSYEIGjRSzYvkCelD+okad2MoycQl8oOWJIqIZpObxJ24SEDc
         pFG9P9g9dBAmKUUHgGVfpaOdGCSi8UyNmPSCoPdN5knzuXF0+0c9hN7CZEjIIAfbutbe
         iQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055394; x=1761660194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shyGPfyT7UZA3DJZBC7WKsd1LwTAS0uHQ5zFBJIRGN8=;
        b=pIu49JkdZTjjMZJYjWJP3D1ouwrzghiuVHixSru5+kgZIn67ZFXoP3CdcvPHTmj68l
         uVzov0m/JSTk3v8+b/md4Nt1autVeM1XO4lX8wtrmvUOCs0lJg9CphiQfqadw/7cijKT
         0D84LPn4YVoYkyrGEy82INUrpmzOd+JOGy8QAt5ELaDNI3mX2wJVQRzvRwECSqnkNTQw
         I8rBiqGoC7R27Rq0pvm2Mg1X3vj+sV7XnulWp1bV7WxWAVmTxQsrSmKgw/0dktHvZI6P
         iZZmFQMUmSelEv86SN5AwcSJK5zjZzWLShl/A2zhXjOethf/7z8n5RySSQRHW4mGHXn7
         ifCg==
X-Forwarded-Encrypted: i=1; AJvYcCV4p+GMvab/4mK4L7DO+UsUlV51kIDeia9sd648BNI0daoHDQBWCD2OGU+I/fVQlz3IUkRE8sSI1IsWAws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbPu624MPmF4WJzJxJte2wEHqiRipoY7MtDp8jLfeDPT5EXFF
	qhea13TiWwIfuFTtXf/Q8zwERFd33XE5VDL40ztIeOjX2CksJnQkMfz419dpY81AAx4gQdu0QBg
	/pHr79vcckwgCO3dZug==
X-Google-Smtp-Source: AGHT+IHLLpKviw22ar27K/HuMjAHYEeLK4Z0OurwlILZBXJxSn9ItdjvEht0eB96eARzWNyuDiLwIyb22ASCFMM=
X-Received: from wmc7.prod.google.com ([2002:a05:600c:6007:b0:45f:2b4d:3c2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr133621965e9.36.1761055394121;
 Tue, 21 Oct 2025 07:03:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:03:13 +0000
In-Reply-To: <20251020222722.240473-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-5-dakr@kernel.org>
Message-ID: <aPeSoet6KY9kxzqX@google.com>
Subject: Re: [PATCH v2 4/8] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 12:26:16AM +0200, Danilo Krummrich wrote:
> Introduce support for read-only, write-only, and read-write binary files
> in Rust debugfs. This adds:
> 
> - BinaryWriter and BinaryReader traits for writing to and reading from
>   user slices in binary form.
> - New Dir methods: read_binary_file(), write_binary_file(),
>   `read_write_binary_file`.
> - Corresponding FileOps implementations: BinaryReadFile,
>   BinaryWriteFile, BinaryReadWriteFile.
> 
> This allows kernel modules to expose arbitrary binary data through
> debugfs, with proper support for offsets and partial reads/writes.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> +/// Trait for types that can be constructed from a binary representation.
> +pub trait BinaryReader {
> +    /// Reads the binary form of `self` from `reader`.
> +    ///
> +    /// `offset` is the requested offset into the binary representation of `self`.
> +    ///
> +    /// On success, returns the number of bytes read from `reader`.
> +    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize>;

Maybe this should just take a `&mut Offset` to fit what I suggested
under the uaccess slice patch?

Alice

