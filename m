Return-Path: <linux-kernel+bounces-896354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C7C502D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5B4E476A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA392253A1;
	Wed, 12 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQIKJIod"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122321F5EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909844; cv=none; b=qibtbfKIO5HjrJtz1aX3U7ZqVk1oLtYnC5t0xu/gEi20VFkU50RbBASZHWF0kBWaVWpx5BudOrFQc7xM2dW2QEwxu/scuK5L26hjWDfdZ7w5QoOfnC8KRPiv35SMGfxbw5nyC8JZ84nWHQ5yjuBjmZLxcOMGdtMqxhuBhz6e8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909844; c=relaxed/simple;
	bh=M+Wlr7dck3mCcnmw/K+6olCTwOKBfh9yPz2t0HUN9nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkOjlQEZTu1L944EbKVwAwZMvwoqorRZEigK+1ZA/4xFmr8VSRu5orSyZrvN0v2owhY38qwx0/JrkDeRVGCaoXk7b1SP77Z5syzg3eQipFLb96cFkihlC0+DCBP39y3I9pMxUgcJghCM5HXyE5galywyztGfmhEpdCtHUV+lgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQIKJIod; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba3b6f1df66so49059a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762909842; x=1763514642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+Wlr7dck3mCcnmw/K+6olCTwOKBfh9yPz2t0HUN9nc=;
        b=KQIKJIodcDAPfEzX5Ng5YMAcxpG8ZAZXdI/NBo0aUs5h1dgxb6JnnV/mw6XnoEvA1M
         5gIW71Lzjnkq0MxvUiT2QnXejlGt8PgEyUgR8d92xrp9xRTuaLEXRKfHCNMqGQPfFm8v
         H//IQ8adppnz1+Rcj3WAbvv4lyIGCDTgGHeoqlsPiiz2AC3tOg5gySmhduzvZEgVYSgp
         atuMnXBBa/SzzOTbtRwyEFriHpIQmQO8659JPMVR3GQ4ykqOQ5sE7cMYbJMa3QsbgVxa
         sCq/7Mf2B/t2+STuHobPSNyhN/nxUwaEETJ1bo1O1MkGWj23yp9VN/PbMTorMc/Ni3xc
         l3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762909842; x=1763514642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+Wlr7dck3mCcnmw/K+6olCTwOKBfh9yPz2t0HUN9nc=;
        b=aZjMpW0TTiRIngwX1Ou9K8OmgNLtzPQNt883VNV43vtPHseR81dm6nMelBE4lDDE1n
         zY9l6zG7/3wDHOW/PvHlj7gWLIj1ScbL/nx8xj9p9s3cw7obRJfSso5ghd7eJZpnQ83b
         XLgDwZq3nnKj1KKof8HxoigX20RQcgiV4GCrIi3s5KxR3clhdNV6i7Aukb6p+4uYi4Rm
         Xrj1857KAjE1HlLwYRKRty6zBRt5paY1FDtPtn8sKMuLrhPXki0pTjo388FEZj6kkReh
         YerQsu74sqiPP2N2Im63SBEFCL5G9onGr2x/kNgmWZj6tju78XWApCzCeEOX69YvLu0b
         /iqg==
X-Forwarded-Encrypted: i=1; AJvYcCWFigijEAoYJ6Mzx9MvXmHqcjL1Q2+RizlWJFFSufKrvZY1th+kNtYZBeIvIZy06pE6lwsuotFl1+8qf70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QLCaY5Qjhg7Hm1Qsiqn6hmDCSSloeU6h5UMA351ESdEra4iQ
	09Ieh1fljJAD6PwhGsbRNlrVZI3YVRfgAs81YK0U3G9iGF09gxKTVN92gUg1FOgQJDP5BZgmYGL
	P+9+nbRmgsjDPPe4ckwrvLwcWwRJeo24=
X-Gm-Gg: ASbGnctL4aLL4jXw9yz0zmsDtnssHsu69YXcnBmT9Ioq8rL/ID2X1TNVqL4lBh4zAxK
	8so4BXu3O6LVLg8gLr/Jlx/v4EoDnHhQeb/2gX63sFyynjUH/Oy1g7TrQnQ841PKLFQgg7XhXPs
	TV8Aovy6s7TSTqZLOmBqN9ibkb2wjTwJcpq0ug4xrcldbt20xGJjIvoWC9F4pFAT5nM9/6r7nWi
	IYdpj93NHCyTAPnXx+VkTqMIo4Fg58IaF/VvoTlPki9sVtHNo4Eez/bio1Qdp4o99Jb4JF2mfvY
	ryvus6WpYAGac3chN6ZkEFsHPbAnfRk5AG3/+MzjF3irD0PeIwqH5lDtMs8E5mr/A1OnI+i1uTg
	MZdE=
X-Google-Smtp-Source: AGHT+IHB0ZG07UiacYVnMQc5E8b9SGddaCc8KnuTcyd/zUb48n+AqmKQETj5Hxf46NdhwddaUrthZzx8aXIQGO+IW+s=
X-Received: by 2002:a17:902:ec82:b0:295:2fa8:cceb with SMTP id
 d9443c01a7336-2984edf389bmr9400935ad.10.1762909842321; Tue, 11 Nov 2025
 17:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108-bounded_ints-v4-0-c9342ac7ebd1@nvidia.com>
 <DE5PQ3927GMS.31N4JGGZK3M1N@nvidia.com> <CANiq72nYgvsTLvaXkGDN6ZReHipZVSgg1BzCgjC05h+dmsFe3g@mail.gmail.com>
 <DE6B1Y80A2EF.80GLFFRD9VR8@nvidia.com>
In-Reply-To: <DE6B1Y80A2EF.80GLFFRD9VR8@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 02:10:30 +0100
X-Gm-Features: AWmQ_blq2-Ss3usAshuy7Mp0GK3Xayw-H4mq4mt53WujsxFzzz_bAaPFhKnocIs
Message-ID: <CANiq72nhZnUXDowLB_j2yYp7-B_PyG+a-WxExdiZh8ROYni5vw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] rust: add Bounded integer type
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:55=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Thanks! What is the path from this to linux-next? IIUC we wanted to
> merge this series (minus patch 4) through the Rust (not drm-rust) tree.

Sounds fine, I can take them. Thanks!

Cheers,
Miguel

