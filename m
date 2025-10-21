Return-Path: <linux-kernel+bounces-863036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B0BF6D94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678405064D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A947338921;
	Tue, 21 Oct 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv7zzyab"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B6D338583
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054021; cv=none; b=HC4FHNtnJERbL6WoStVGnBZuiaKgM0qpRwUpizDKUF3+X6yN74I6mcKxRi4Xkq6gqZ1r3KK/UQ1Olqrrl8bLmOdwRZuDB3COYnLXyYdVXr1u48iJDknq9tAp46xrNv+q0u3oBRC2vcBra7koAt402KiSxvs1xYerkix1aktLHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054021; c=relaxed/simple;
	bh=yCknDotFZEruiBosDMAm3ohbAowsDur9hp3qhsJ7LEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jOQUnYAQfaQ9pmcgc80TmS/6KkodMaB918E/zXA6R0wrO53Z4EVQs6PsJprqqwLTxjWYDEVYLsLxt4foUJJXc+DqCL+AxUtD+wKBagAkl0ftNtePCEAgtC+qpnJSkrZ8QYEI0qdEj7jlaPSV3cC4Bz4JpcpEcTMUmZCWdmwK+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv7zzyab; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47111dc7bdbso45781485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761054018; x=1761658818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrLUW4qM+cn8czdjP/Pa/kJCbfN7pvqfFBtXogaAokg=;
        b=Xv7zzyabgXefPJyzLd/TMox8FWzDGyOcyZdERxUWzaAm/Y/3Qmadpq8xT6lmx2lAfK
         zWesBtPwUDm66q6m271xCNdFTOAu2n9SToPvn4ZqgTP/jD85TMdFxE2XunFZjYSAB0UL
         zbd+RnpAo0spmPLZqE26ZoV7CihN/iQf6lueSmOHyXp2OWDO86T6h9GRp5tZFIJ6EtLh
         cEp/8LRYF20nbfoD56phD2wT893dJ9IirtFbPdGgd0kXHMWrp5x/g6MsmCAgFgfTyUql
         VvO+ru4+CnxXXR31Ng0X5kIZzBdtRZcHIVMkdqqcUAFxSl5BTT+uXLVyrZN8cHabxRco
         NY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054018; x=1761658818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrLUW4qM+cn8czdjP/Pa/kJCbfN7pvqfFBtXogaAokg=;
        b=lN6xbqjiF2IOAFbDgrLPFMGxu+u05LaZK/+f2fIFEGOABpJfPA4SxQ8VsEUcSwxTXJ
         bx/ZRJvsLMfsAQHYjDaoQ0GF0coxuq2gL36WUNkuE3PYj2NBvh6wZ/XAonZHsNdhW8qL
         koIeSVHYNGl0wyF/3o2LiXZvUBt0Rm7u1zHI6yXqxGPSiPaDtgXiiIguhDEKqacTPMSd
         xX5IgjRyiqTP63tMM7xstFRlKWSkUZdBY9tIVXtz1St7Upjb1TfyfxrvLa2MxXXsoaTX
         YdFX/8wenvXQubGJhvKfocnkdlwOeFeB/bcxCrqXbhf3A6kfoTwqMyhurAPuoZeLkNhR
         TuHA==
X-Forwarded-Encrypted: i=1; AJvYcCU6aL3SNf0lxEF/fPgj7yYRy1PHnVg4ooO/y6Vyk9YHVYS3PNboFzW1TdII15Pl6LRlxHTNCd1C8SXXX0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfewBAkdvqEMeci8sCXolG8sTLPsyq+QiP0QokizjtsRqXALr
	eG0J2NqX4IrY04v4LUh/edlUo/ecnm0qq8m+HcmXieRrnrUipVXnOcV0eLYEkELF+/8qnzvmDKJ
	ePd/bqQrhcHPrGZmu3w==
X-Google-Smtp-Source: AGHT+IGyXHuIJb9pEC+yUkjKZFKKvH4sB7PMpDG624E6gHyNbBCvNk3e8BAAYh/eBkRuMgY4SrmZkhQaFvx3kuw=
X-Received: from wmcn15.prod.google.com ([2002:a05:600c:c0cf:b0:46e:25c3:8f69])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5287:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-47117874810mr123853485e9.3.1761054018123;
 Tue, 21 Oct 2025 06:40:18 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:40:17 +0000
In-Reply-To: <20251020222722.240473-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
Message-ID: <aPeNQQ725-Vdxh-9@google.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 12:26:13AM +0200, Danilo Krummrich wrote:
> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
> avoid using raw bindings types, this seems to be the better alternative
> compared to just using i64.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Please consider also changing the instances of i64 in iov.rs.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

