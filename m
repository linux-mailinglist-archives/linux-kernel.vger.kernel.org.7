Return-Path: <linux-kernel+bounces-848627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C4BCE353
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A14BB351E35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DA2FC02E;
	Fri, 10 Oct 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw1oXBdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32C3594A
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120516; cv=none; b=NSV63IRFAZP4o+QFwAi3KGKuLELH//J3ShHLa4sKu1ZNtGiUZjvikVzpYE7yNl2Pz0fUSKi6T088Zd9uQzpGqKrM21gXjv3Cnn7uFqqSEhzT32jIaJOwgkDhi5qkvl1+wyCO85wVs0CnK6P7LtbNCxnnrwc8v6V0yPFtoxRFujs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120516; c=relaxed/simple;
	bh=B74xUW6B1dkzhI1p0wyaWpMe4jQ6pt6RZTrVVE+n/hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3MLU8tLsZ4QCpz/1e84FZL4hTEAG/0lAYHLRviyKGn9n5wFz0kwN2j3SKhHpOKglOV84ozQ1bc1azbAGwE7vKQadJxyFQ2Nr8MuOJ8NE5RDkDntFeB9g6JXwxS72l337yflPlkztZnQyAQ9A5aPxFLR2jIZ2JYnlkd0//ASkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw1oXBdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D99C4CEFE
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120516;
	bh=B74xUW6B1dkzhI1p0wyaWpMe4jQ6pt6RZTrVVE+n/hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pw1oXBdhDMg3RbVffCJtsi7vKkpq3kFBOxxNHUiaKiA3EQqbZQWUicH2jXaTEEUTw
	 e/nu08y6LZFc5SCH0bOX6fJoKqfxShdTqTPi4GN88lY1VbxMm1iWeQcn59RRfssf9k
	 lSy3VpdDxRWMXOkubU9gnAS2KZplHtDcT0oarHpTqBCpHJAcMpGBeJH42EltJ7Z2LS
	 f5bI8zsm05fpKanuw7tvi/rsJSsaxtqpw0f1JGSxAHuUufTFWaaAq0mPGSkWCkilQD
	 zSBDSIeFoB6P8+sZkTq/BfzyAHkhfqWb9XZzslNpcCqnA1SC+Q27btMs6/7Oth46qp
	 n13CbkwwSGrxw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso2740391e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:21:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVswYzo4ZuuJh2uWyayT5hoMrHeSDViwOJM+y/dxQBC6R6Rg4orKlZ6O9r1RbmIcHu9PiUeSQ9/4afhuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6oxFYAVh7+68GlCbNV0kaRESlidLSjNZYQ1scohFwgWYN+2cY
	56NVAcf3LlkHccGNDmyG9X9t1sggkBjQiX+TNVbeZkAmIRY/O3e4otIV6RIV718/gavwcB77rYO
	MfTSjDenSk512N/tlIGjQW6jmCiCWfNw=
X-Google-Smtp-Source: AGHT+IGfeZluMSTknZ3xz2Mf8yQbyEFIabg7WQ/7AB1mUCwma+kzJsj5Fc5fGNDkd6pAk2KfgzN85CyXSI22l/zaoXs=
X-Received: by 2002:a05:6512:3c87:b0:58b:23e:5ec with SMTP id
 2adb3069b0e04-5906d8e5b43mr3597112e87.26.1760120514446; Fri, 10 Oct 2025
 11:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002023117.37504-1-ebiggers@kernel.org>
In-Reply-To: <20251002023117.37504-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Oct 2025 11:21:41 -0700
X-Gmail-Original-Message-ID: <CAMj1kXH8WRJ+J2a1i2f-E+=MWS88wn22kNfurU50c2sZYQheAw@mail.gmail.com>
X-Gm-Features: AS18NWAWDlu-lTrQ_E1KPxGYn3u8Sqw2cqubqbNlW_mUVHVVTKJI4UHXX4wmhcE
Message-ID: <CAMj1kXH8WRJ+J2a1i2f-E+=MWS88wn22kNfurU50c2sZYQheAw@mail.gmail.com>
Subject: Re: [PATCH 0/8] VAES+AVX2 optimized implementation of AES-GCM
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 19:34, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This patchset replaces the 256-bit vector implementation of AES-GCM for
> x86_64 with one that requires AVX2 rather than AVX512.  This greatly
> improves AES-GCM performance on CPUs that have VAES but not AVX512, for
> example by up to 74% on AMD Zen 3.  For more details, see patch 1.
>
> This patchset also renames the 512-bit vector implementation of AES-GCM
> for x86_64 to be named after AVX512 rather than AVX10/512, then adds
> some additional optimizations to it.
>
> This patchset applies to next-20250929 and is targeting 6.19.  Herbert,
> I'd prefer to just apply this myself.  But let me know if you'd prefer
> to take it instead (considering that AES-GCM hasn't been librarified
> yet).  Either way, there's no hurry, since this is targeting 6.19.
>
> Eric Biggers (8):
>   crypto: x86/aes-gcm - add VAES+AVX2 optimized code
>   crypto: x86/aes-gcm - remove VAES+AVX10/256 optimized code
>   crypto: x86/aes-gcm - rename avx10 and avx10_512 to avx512
>   crypto: x86/aes-gcm - clean up AVX512 code to assume 512-bit vectors
>   crypto: x86/aes-gcm - reorder AVX512 precompute and aad_update
>     functions
>   crypto: x86/aes-gcm - revise some comments in AVX512 code
>   crypto: x86/aes-gcm - optimize AVX512 precomputation of H^2 from H^1
>   crypto: x86/aes-gcm - optimize long AAD processing with AVX512
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>

