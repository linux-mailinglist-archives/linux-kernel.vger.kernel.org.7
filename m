Return-Path: <linux-kernel+bounces-885057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F98C31DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8D189BEAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B543246BD2;
	Tue,  4 Nov 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbsk9FMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EF246BA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270403; cv=none; b=C/fLNSSGRBUnT4f24SY+V+MoUdvJFM5dow/nqArh2bIgPn1noMl7sPlnHJ8MsFnH2yuPXFrBZACIFTKZFj3cQGxufRKfE/FRyrAchjjHFEl9xkOZbFt2E+aSnG3UoNZNBb+Qf6EIs2qeYS7oFMCrY9pD9GAica09n3XjbsU5qBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270403; c=relaxed/simple;
	bh=f++VnN38RrRh7tBcY8Lg4121Akt4PJm9fR9Yk4mIizQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPAACSsUFqoXev9mF4NpEqTfUMfJ8eKFeILFmjTHT0SadAUXMQgLWtPFgZnnThAOc2dPpmssJ0VkSlTt9OOmnQC5cne76/qVsQVtiUBrbGJYeKWmLpwnac1tAwkEjPA0yxs6O4g4CXeytna3ZwDm80z9z0xE96X61JmqYroKfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbsk9FMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F40C19422
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270403;
	bh=f++VnN38RrRh7tBcY8Lg4121Akt4PJm9fR9Yk4mIizQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mbsk9FMo7XhQa+d8QAP1Hs6TT84RQyv57B6Ea6iQVdD9lywYH8LBAbL5gBiVCLH7K
	 ocnsgIC0oCf9E00l/BqfeUgQrA4+0PVRD8RlWeJTIDkKqC47l6OE+2sJXczbdX4lE2
	 +Y+lMkW6Pq0XOOB5Hus5KNPQP8PtMYLNG90gc6YaTcQhRcETfkcrOtucoZBKXYpeGV
	 xvv0d35sAX0JwLzEyAIKG/jgl66HX3U6B5qAD2lHxA+0fvoY4IMBez26xatsNWq6dX
	 zaUiqD2ZrfFKncFSKqT9A8DpLBL/wdcKpwh6TjGdRVhAsZgqDnsg9wFm1vh8AhZmjH
	 7npCt2ms4YLUg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3737d09d123so73658411fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:33:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2htpO1JW2xC07Qy5CjEggbmAy+GPp0PHgGDhILGpsBG+gIk+iotcl9AMMsD2fiySO36EBJH03sXL1yM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuWaQ6/FPeoqfukX9+lWNIJtXFw8yOBL4anheywsbF9FKRs9Z
	hVoAa1gZMIy9sZohb16yvo6j2gQBCijjaFtEi6BeVd/iZ2S8puM7rMtD033y1JTaNfQQfrSObVL
	CxFMzMwRnRtNPGnEUC9MfNZWvghizUag=
X-Google-Smtp-Source: AGHT+IEKnpnsC7p5XtLkxLC9JR3u5FEFduRd9fmeYqvWlVV5Vs+63IMBDac6pX6vo12h2zepGwKIRnQv2nq2fiVNuH4=
X-Received: by 2002:a05:651c:555:b0:378:dd6e:104b with SMTP id
 38308e7fff4ca-37a18d869d6mr52577391fa.1.1762270401532; Tue, 04 Nov 2025
 07:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-curve25519-hacl64-fix-kasan-workaround-v2-1-ab581cbd8035@kernel.org>
In-Reply-To: <20251103-curve25519-hacl64-fix-kasan-workaround-v2-1-ab581cbd8035@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 4 Nov 2025 16:33:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHxyPyH7JYoM=dKt5POza529xXHiT7PaditovMneXnCoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmgGT2WBLavywj5Uh9McBBEgxLcJhrW5LZhEadYCQnQfDtQVmuVtWPyIC4
Message-ID: <CAMj1kXHxyPyH7JYoM=dKt5POza529xXHiT7PaditovMneXnCoQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: curve25519-hacl64: Fix older clang KASAN
 workaround for GCC
To: Nathan Chancellor <nathan@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:11, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable KASAN with
> clang-17 and older") inadvertently disabled KASAN in curve25519-hacl64.o
> for GCC unconditionally because clang-min-version will always evaluate
> to nothing for GCC. Add a check for CONFIG_CC_IS_CLANG to avoid applying
> the workaround for GCC, which is only needed for clang-17 and older.
>
> Cc: stable@vger.kernel.org
> Fixes: 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable KASAN with clang-17 and older")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Check for CONFIG_CC_IS_CLANG explicitly instead of using
>   CONFIG_CC_IS_GCC as "not clang" (Eric).
> - Link to v1: https://patch.msgid.link/20251102-curve25519-hacl64-fix-kasan-workaround-v1-1-6ec6738f9741@kernel.org
> ---
>  lib/crypto/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

