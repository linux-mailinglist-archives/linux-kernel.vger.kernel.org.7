Return-Path: <linux-kernel+bounces-844114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6216BC1099
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4C6189DFE9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68242D7DD2;
	Tue,  7 Oct 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw5qDQij"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41819E7E2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833776; cv=none; b=trtCuahs40YfV01+Ns1xktpu79uWPz3zroqdcT7BFegDSJ1mHi9N2+3FDramtC9c4Y7+a+3MnG8PD3I5SVR1F04QZajU0f16Wr3wWp1HH2OTEIbDcGsQ0Rc3MsXacvJawBNrUTbkRHZHW/ltqacxNCLVjePGQjWphuP8x+T75C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833776; c=relaxed/simple;
	bh=t48xr98QD61VaWXPvBpaZ2yaPisBwVUmg9uYlxv8ngk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie5csAJN/Z37+VMZbQUP46cYKnpjoyvo7Szno4hbWjKhxEvnvupcAgP2StILw6hx6/FVvTXd09cu9qulsx2syPLRK0YZAJkOb6BgKjSriC1aOwtUejfWOAQCKrwtgMbN9iy78QjluC07HDFc1SIZ79EYl19NoPMASVfy6eHa7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pw5qDQij; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2680ee37b21so9171825ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759833774; x=1760438574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t48xr98QD61VaWXPvBpaZ2yaPisBwVUmg9uYlxv8ngk=;
        b=Pw5qDQij8MARyxaJey5UfIJzutLT+inpNsHmY6VzuKFbvLpOE65FzWAXr6k9IPqlcE
         UoQU3irYMW2e+/JjIhW5BS/2hUF34wijzBdvRIhPjYj6/UUI1ByiM+dgBLzrr70UFDxB
         u9liFpXeVMvsxRmN6FgnJ6KYj2st/S4pu+aTXwrNf4T0eztrSC9L4qMjIqrRyjBzb6wW
         T9+Fpm/tqYjDFBhQNU3K503QQwCb2bW2XnEtBqN5+fAKVdgYZp8SDFeP9rVjI8QEyhtv
         O0yFBER6kX4HqljDxvJ1w6eWR+L1iqdb9/CAcyJNzceofePdx8AZTICTBTaBMCQ6ko2f
         CdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759833774; x=1760438574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t48xr98QD61VaWXPvBpaZ2yaPisBwVUmg9uYlxv8ngk=;
        b=FsKkLPWyVrUgsz0LiySLhH6QPcWWfKsR7TTPdohUXHYltA1ZEunJVTVIgedwb2uz11
         OfK9roz6E2tpkHqhN3rMIejWdngtxwrRNsS0nCu1iOIlP+1BUyCu82XZ7B2/vHMjzqVZ
         8Bsg/CXGKKS5iRxn3823LGQXFLsXP/I6Ssb33S0fKR9ZyxmKrrrP8H1yHMuOVhVGc83m
         DsQ52tXAAx+7CYJs+GhbDtavpWBoNXOuPePP4SZYT0hDg8wbXu929oPRc8URexXoMnYn
         gECHjKH/4Cgv8ItkwyMfYpyyIBCsxTwb9+w1q3Oxx7aw8HZa4jE8qF1penYpc7v/wuim
         /7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW/Voe0Sr9ky/EH+ThppRcBtS6IM0h5sHuhuJsRWh0U0eyCpVVQkyIeEtbOZL/OC1fEjAu1VypHmCWZFVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoj5Addxt3qfhfVYfijIcyIxQLx3t6h3uPaHcHm40iaeJK+wsi
	tCxUbzGmft4t/GRKD9kYQswLRlVxS7QiBAqumzDjaip/d17taNSdzzwfSavQl0fZm35MZbN8Ex8
	TXF1H1tT5ESQJMAcju8cUi/DzjPl3rw4=
X-Gm-Gg: ASbGncsXuTYjVe8tWXwmw5JUV6PZf/Sfs2WcICMydwXH4CnXH9QnNtHQYUIoH1swE7q
	yCPr0c8GEOPmZFruT4UhnjxoN6Jy8T/1i8UMuVU+01vk4sDegQOUMboyd1JiYaZZEtdjCovtKvL
	+jDPbP0MmuN9nYhprI4KFdZKUR1d8+Se61fOPBDWUJrhkFrIFVKTZwFy1iJLbprTSE21/Y+wePv
	AdTs3u5qQPIXPUonPuINUhxgvZZl/xphnZPa63Z7nkVtitKYw9bxkb6dij7cH0Na7mgVYkq1A4F
	n581d/3HuhgN8wMk/mOzjFSD+70U1VHQDLCFHGxKNjgwMjnmqw==
X-Google-Smtp-Source: AGHT+IG/tceer4xDFHi1fbtvymQWQEX0cfdjfz7qa3VEV1S1lLa9ROogqCppnvlWvrXrppWg7CAeyI7raGFpenio+L4=
X-Received: by 2002:a17:903:1a68:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-28e9a5a2ea2mr112471585ad.4.1759833774205; Tue, 07 Oct 2025
 03:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury> <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
In-Reply-To: <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 7 Oct 2025 12:42:41 +0200
X-Gm-Features: AS18NWDpvGktuowJke8BSxfgUaurFD3miGBpRkLVS9T4zoCecLy6NtllLzWGBNs
Message-ID: <CANiq72m1eiGVJHNyym+JwM=tQ9bGnmoW0+OuKQ3Vxo_AQOy5dg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to rust/kernel/
To: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Andrea Righi <arighi@nvidia.com>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 12:36=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> We can assume maintainership of this of course, but is there a problem
> if this falls under the core Rust umbrella? As this is a pretty core
> functionality. Miguel and other core folks, WDYT?

I think what Yury may mean is that this should get an explicit
`MAINTAINERS` subentry even if it falls under `rust/kernel/` -- I
agree that is a good idea.

Thanks!

Cheers,
Miguel

