Return-Path: <linux-kernel+bounces-775203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80597B2BC89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B593B6280
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED131197F;
	Tue, 19 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RO36CdV0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A457318126
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594249; cv=none; b=TdU+WFZcu8s/D+UYulKgXwTEWZQxSdfeHcG6Rrf5rd4UC7i3VxbNdqULxHHvBMt9LvlEDTDBbiBRCDg5Z2FlBTxyjintv1066TMYuAdOwKD588yFvkhdP4GFAdZkVrFF4VHvuEZNmRjs9lds/4mS3uneUjhGS7DCxfFFo9eoOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594249; c=relaxed/simple;
	bh=j1702PwtMzDQe5/1lQ6DecIyL64vgc8wHTrATNQRhR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRhtCc2Udj1sA0YdXVQIY4Syft7XAtRPuC+fErF3i9atM55nQOEtraBkuIaOP9wgnD2E7Z/BMVMGFffGSsYdjnWe4fXf2s4Dwb4H2pUgk9K0NYfeiFxJL8s7XqzIiiDWYbewWjI9Ws1hayRbhH763ayrmIR+R5srpYVcOKRwSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RO36CdV0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0b42d5so35861415e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755594246; x=1756199046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw4/SYfYTbVLI+W3vVMq9GPldn1oSL4x6P0EM98hAz4=;
        b=RO36CdV04gbgt/gqerVwSTjPhjte3Q9sqG0/tPnAjaRQ6tphy9EyGH5C21NZudgBny
         HaniA+8LnyAYnmqplQ/7RkhOJTbN4r3ffFh0Dy5HNk9Dv4VdfY138UYaIStE/7e4iaDc
         7t96nII9LWMjtS7rIea1bS+e4yry/McaAjJM5pyLIzOsBwffWMnCNsIw0fwxWs53CKsS
         ofg3BSTxkXubERr/rD9LjamKMdy9DLj4ABmzBd9IR/xJlmGEE4HrOrOz0ULRqSrk3qwa
         vx5uUgdwxT84wxqf6A/g6VDUJC2Sr/MCh/2TvRK9HQebf7YW8DVFg3bZgwUMVWW4Vy7x
         8LBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594246; x=1756199046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw4/SYfYTbVLI+W3vVMq9GPldn1oSL4x6P0EM98hAz4=;
        b=N30GZlhI3669ymYsci+MiFu4KX2iZWB2haM21MAISV83Y/sRHtPXY3pWZ2eUU8VAYx
         8IihDuCgd0sA8HV/C80lIZ2DT+VDWx/Y/vw8qhmg7hKEd6sYPPMypSTDs3+vA9Vgom/B
         8MrM8r17opP0mCb5G98R3EfESo4KkDmVv6E7PyXix8EjK+xS3D9ByuxXvP4idU07W/zf
         lEk3uspmzzMRKu/kglsTh/uTEHWfQhC9XiOltcEu+iO9cc492PhYRi3JA/dYoyHVfoq2
         qhVuN5Hz60zmASups1cuO7QNc0omnK1hf9R7Asa8P0OEPq/F1PoiC961VrDA07UD3Epv
         OM2g==
X-Forwarded-Encrypted: i=1; AJvYcCU+X2ZZD5OI0UhEivzyltX6hbWMBZfrVCRCBQj7drCaYs1j5ie3K5FoweEQOf94mDQ4sS6ndlY2YdFhSmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuBfig8PDHNv9kCuHSxSHC4dpmJb21g5CY+40x4Z0h1BBbb5ni
	r15Gp5UZF+Za8HGnoY5ZbP0CiZ5Z5x3cffDeCbkc1EmXsmwfeej9/zwF5NSguKw76lG2mE+9r+0
	Ssi8VEVAl8X+CPpsppvrMwgLzQFRj7q2TuRnxJiya
X-Gm-Gg: ASbGncsHP/tmxiDksxU9ggnsQMRRru9nhGvU6/5wGjIByp77IEEfjf4hFcWScieXoRd
	leWB9mz5ZExXVYguWUscpgaLmGIyDF2XroLli0cqxXHvkrNcdt/biJJcM1SzsWIBi6JAHi1WHU+
	iLdh6gqxKaGd6qUy6VfvGgeNOvSnyk6Xg4GEgOpuvBInKX3qDbaBvnd6wNs71fNd8iHhQqmfbHG
	SCesVYzKmpaedA9m777uibrqVRXXLcgtRs/cOFykgqRE+Ek5RKvwh7ShxR9oGWcfw==
X-Google-Smtp-Source: AGHT+IHdcHy27qthc6ylIMnNVnNh5YNWX6Vrep+6osB8MyR7vljR5PzozjKPhzxheJhAHt+ndRzWPDYEnKmFRRYqYiI=
X-Received: by 2002:a05:600c:3585:b0:458:bc2c:b2ed with SMTP id
 5b1f17b1804b1-45b43db65f9mr12911025e9.7.1755594246118; Tue, 19 Aug 2025
 02:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com> <DC19CXUEORB7.241EQY0IXV7WD@kernel.org>
In-Reply-To: <DC19CXUEORB7.241EQY0IXV7WD@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Aug 2025 11:03:54 +0200
X-Gm-Features: Ac12FXzqmfWcGjpWA2_Z1mE6xkkkJkyW-2offzZARxXIQ07VSGbaL_je_9ZDZC4
Message-ID: <CAH5fLgggp0Nkdcuwv6HTZBo=92xCJt=8JfSVvmy2SRR_e9kSFQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Rust support for `struct iov_iter`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Benno Lossin <lossin@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> >  rust/kernel/iov.rs               | 311 +++++++++++++++++++++++++++++++=
++++++++
>
> Does this need an entry in MAINTAINERS?

I think it goes together with the existing uaccess.rs file. We don't
currently have an entry for it. I guess one could be added.

Alice

