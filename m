Return-Path: <linux-kernel+bounces-861180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07EBF1FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7E34C5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C024501B;
	Mon, 20 Oct 2025 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yi9/90Er"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6323E320
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972801; cv=none; b=PFx3+klbaLoV8lXhlIHf+EODsu/TeSMeXHD96ZVCVtGULE0nTjSeFzWTqhob8CpUsKPCVKh3Z9v59MSk6k0PKxhh+A5ahZhUbb9w2KjmFTMK6t3EXkMi7tp9PCuAu6oc6bhDtkKtwo8olQctPrv1jfxwkalilBZTxCwTAeevZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972801; c=relaxed/simple;
	bh=kMa+cTp7cVtK7Jj4wowRZ8VBCMhE7dbUzz+E3JS3cDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZACUvRmczlftZGtlDU4BSZ+A5qSmYAc3gDhXl+TjjWdQ1eYs3NaB28DoNVBMeeV/C7NNPg4y25h/ZiQz081nTwxjmDPcj4e5IhyMG+CON0mJF9JWzEmQgJplpilIyJvN1Lvz0RXRCJe+S2SQmptivMy+fks+IThON6MIU6+Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yi9/90Er; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3c8f257b7e1so4554710fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760972798; x=1761577598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cvsTdM8sR9r6i/ag+L/0S0SgN8lzV9ZSbMcaKYBLhg=;
        b=Yi9/90ErmWeO6r0Hx9UPFZFIyQxPZn0kHfpTrcPb/A+ieq0sLo3slBIqFxzcq+4J7R
         3i6xw6SA/4xj3gVGBaIDP5zAlUGwenrKyB81GKFSMi5U00+vGs2pLyMtSaTs85eKRYSQ
         g49oSdb2/NOPzsVPWHDCZ+8LvkEBCiefjxu7k3akhRUeBFH8ok6lv7eGowAcz/6cVdf4
         AIJ2o+m+1t5PDJ4g8ul1cvC8PuJtHg6k0O/IEuBwmUrt8lvyncLC7K5uS8sBt5lzgtMx
         kMUKLLCCAI0UdnjMvpHsGbvtSIr5cIT46KJFabw0/e/QVsj2dRiiHcOhhnlr2nOyQ48c
         wg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972798; x=1761577598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cvsTdM8sR9r6i/ag+L/0S0SgN8lzV9ZSbMcaKYBLhg=;
        b=jTRb2ca0lH7z3pqVJftklEQwdhPLeA1UqpVHQHmeIDmujOfcB2JolRSyU+puzc3okl
         u26/aIIh7On1vpgF04IAgGm/Awrq/o/9RiNzS7yLXy9ZyhWypElP6lxpoSLmzw3qAejT
         uGKIo3y3yaNQCJetgctQssfcRVYHTyQZqsYL/MlABFqlXZUr4qgEVqdmAD4XEAMZMzjl
         ONozaRXQ+nZal8ssu67eMsxr7bMU3u7PBzHszWx4Fk6m0GsdyDaxheP0P1EVxst3O/Oq
         Wyhp7mdcl2ntusiiT7isapvTtudqXPgykgXZ9DCz6LqraBOgt6WJWtLiDUB+NXihMi6+
         cBGA==
X-Forwarded-Encrypted: i=1; AJvYcCVBVd4frHJeR2t5GYLp9z7D6kTeLmt1oDeomtx6VdBdFON67BOgxuQBYbVlBekiUXv/P+byHuBQ6q0O45M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuK9JsCjbpJicBdFxbVGuK+eYslblwqJ4HgYEfDDApGJOezQBn
	2BQFEjd7Rf8Rk8fdHx1d9vbN5TZJc+L7dQvxy0PxNE8Oc2UH8fzMLYg9pUQAoIMXGKEAluGlzLa
	vk+vPhUASZCzFzFKnArWAyN7UG2LJDX8HaYYpIceS
X-Gm-Gg: ASbGncsHchAI1q/7mEy8hWtzxZvd3qq4Wz8H/da/COf5ff1P9CN0dDF/0IL4jB0h8SC
	LdRqadEGGL5ldvOUz469xOnMJNtzhaC32cIoLpPXk8KTTSzRcPkNy7cj6UdNp4Q7UFLDl3A2mq0
	iWA2Uvzc01ec2QCeocmABsjdblYl1uFjxr2WiwxGefj5+XcvjaBjxroHxf0hr9aXtie2YCyJdLW
	Dmz1QRE+zHbkuPsTQ4pn8xe2YkjL1wSR/rGmwy3GhXZ3Oi7frEpIg5KthH7g5GJPE6wbOY3jF5l
	ikrUeTwRE7smLdg=
X-Google-Smtp-Source: AGHT+IGLApVWeMQeO2fByoBO6Pij9zwwqsFyMyfj5mInanMo2LWamObX/M8HcZHeuRe16SDET/aQfPPnuwGDKLSGDRg=
X-Received: by 2002:a05:6870:d915:b0:3c9:b8a0:943f with SMTP id
 586e51a60fabf-3c9b8a0ef0bmr5166842fac.12.1760972798212; Mon, 20 Oct 2025
 08:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com> <20251020-binder-bitmap-v1-2-879bec9cddc1@google.com>
In-Reply-To: <20251020-binder-bitmap-v1-2-879bec9cddc1@google.com>
From: Burak Emir <bqe@google.com>
Date: Mon, 20 Oct 2025 17:06:26 +0200
X-Gm-Features: AS18NWDhszgBSdCYYXPR0bNQToESj1alhjrfmUHCoV3_XLimQiINBLGNymMG2fU
Message-ID: <CACQBu=VLPGq0nx6PJSnw3YBhMe4QKHiiFG0k9_Kwayj9w6nfLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust_binder: use bitmap for allocation of handles
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> To find an unused Binder handle, Rust Binder currently iterates the
> red/black tree from the beginning until it finds a gap in the keys. This
> is extremely slow.
>
> To improve the performance, add a bitmap that keeps track of which
> indices are actually in use. This allows us to quickly find an unused
> key in the red/black tree.
>
> This logic matches the approach used by C Binder. It was chosen
> partially because it's the most memory efficient solution.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/process.rs | 110 +++++++++++++++++++++++++++++++-=
------
>  1 file changed, 90 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/p=
rocess.rs
> index f13a747e784c84a0fb09cbf47442712106eba07c..357ba1b577c73ad3f2b525a85=
73424420577e92d 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -16,6 +16,7 @@
>
>  use kernel::{
>      bindings,
> +    bitmap::BitmapVec,
>      cred::Credential,
>      error::Error,
>      fs::file::{self, File},
> @@ -367,6 +368,8 @@ impl ListItem<{Self::LIST_NODE}> for NodeRefInfo {
>  struct ProcessNodeRefs {
>      /// Used to look up nodes using the 32-bit id that this process know=
s it by.
>      by_handle: RBTree<u32, ListArc<NodeRefInfo, { NodeRefInfo::LIST_PROC=
 }>>,
> +    /// Used to quickly find unused ids in `by_handle`.
> +    handle_present: BitmapVec,

Are you going to delete rust/kernel/id_pool.rs, too?

I have no opinion on whether having an abstraction vs inlining the
functionality is worth it. I mean just in order to avoid id_pool.rs
hanging around as dead code.

Cheers,
Burak

