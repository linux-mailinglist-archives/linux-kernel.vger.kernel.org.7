Return-Path: <linux-kernel+bounces-740435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19213B0D41A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CA617054B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59C294A14;
	Tue, 22 Jul 2025 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WndJokWB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383822C326E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171551; cv=none; b=rXMiaaDL1/ufjG7Ivg9s2LAQCpxR7ZCIABaIcotrbdXvamxNDcKlvA66bTik1F1G4Q+bhlvg4aFvtEHn84O69O/rzEQnIPrOOgdF4W+nuITlhfo6a6+BFqTMAZim3PdTTqDFYztQW31IySMUFGZ0Eh5LC5lucM/5jx7hv2selYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171551; c=relaxed/simple;
	bh=CnMJw8qgm8jE4iaGeacCGl+54rCiaQEFHAWsMGaI+Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u25F2776LiJroHDFUJGsDQosRJPClq4Sc7hK1zmPTksq0UMrpybuv2iXzEkVxxII87PD5IJEnpbyl7+iY2f8nQQmMRcDIG/mIDC5k4VXltsW3i4mJGqw0BHTOzzSo4BO17oeb3wuq0bNAITL1cCxRLrAUbiC+OrB0q/tTXyzciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WndJokWB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so52809175e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753171546; x=1753776346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfjnB0RzVX1onEBaivwGgg3zlp9uwBQhMC1tQmetXyk=;
        b=WndJokWBT28u2yETPfCC7YrlyEJifav+jIGw/xBSJPHTnDNFZ+aeuTIfpXvlb5/pHO
         jZkxU6nbu5UI8HiS5qYqWMrWIqHFMrI6JKw++CChmJHqqg3QocwhEBb9NtXHkqEH7VD6
         DJEsogX32aKuVuOCk5GjLNmIc2FclSsojwP/WjXAtv1tDu51NZcH0DCWcb5VA/+jZJpJ
         LOF0HZGpnnWpFFJJ6zMnqvVsBBNd3l5lCExs6amkDLw7mYhJfqTUpBaFYpo0gYZtUaxD
         pNw+1FOFG3NycC+KotITYl/WjqY9kh9MKMwpYn0cPCrwfEJKbrSTVnoJJlvQvaalP8KW
         oKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171546; x=1753776346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfjnB0RzVX1onEBaivwGgg3zlp9uwBQhMC1tQmetXyk=;
        b=Tt9C20poOVl1YNsVS4Rt7Us9jPSIbl1dcDZEDSQ4Z5M6R0NeXrBLwST8XJTv9V//k0
         1D8mSCHqlwr3uenTa8B8nX2Anim0kzQuCv5GuTIHYt68KNEIa1dfW3RSgslQc85pmTe0
         sNdfBOVG2+4pm8ckR1TIom+l2WjX+c26EO5i/mP8QjR7pCgcMfG1kwNblvuLHCk9kziV
         gd2UFWxK2Nu0vIx3olUIcuh1MVa6Wt1ekrc6pH1McZkdeElNy6zQUxWJvgMCPtrL4dgW
         AZOltv46TEluiOiIBF2EbmNor1kJ738rfy9gf9/HyPEVrcl02uqMA+j2c86IL8FB3o7F
         1fpA==
X-Forwarded-Encrypted: i=1; AJvYcCVSMofxHFLbcR0dLVU6t3CL/zB94ncbdjXwP058FRWPIpmu4v1MrLThLn8IYDVN5zumbgZUGUh5Rd30m94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqEjN8SS3l3erW9odfjg2UPRC5QXti916dyNyafWpZUp2303m
	KQNlDiibjwGLhNI7dAkdmdJvKH1Jd4571O3L+f5hFK289Vtq5aJiwZ7/X9aS9UNYaRDNTRckDKX
	SIMXEZiOGXhSBTe+A3L978iPi53DICsThZYpiHssM
X-Gm-Gg: ASbGncv97jLO7n5rrRpi29ceJ3/0yiAcOL+j3u2F6v9/Qvu+P+I0QwTjJVsP/VB4cDp
	1UW3gZMUCwylBfykGBW/PlWY0fqCAxcr0CwAO1falfs1Qe0XI6dov6bohi2lZI31oXoZfKpQffS
	O8YInRH/nmSYQhB1qGIVoK1hXB4qlTCkLyxSln67K5a3wVYNCkmL2HfD2MvoxN4m7Iua7HfzSaL
	2AGBgHZ7XQiIOcaLLgTaxDpdRSWNQkxYAbv
X-Google-Smtp-Source: AGHT+IEw84d53XcRHbzMwCvvvMTy56CE5J7Uzvc/tFQgaHNn6AVGRHDi9rYuYRwr5tK4BOrSh62WYx6dB29oES2mpvk=
X-Received: by 2002:a05:600c:3589:b0:456:1d34:97a with SMTP id
 5b1f17b1804b1-456357faf96mr180725475e9.9.1753171546498; Tue, 22 Jul 2025
 01:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715075140.3174832-1-aliceryhl@google.com> <20250715-glotz-ungefiltert-70f4214f1dbd@brauner>
In-Reply-To: <20250715-glotz-ungefiltert-70f4214f1dbd@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Jul 2025 10:05:34 +0200
X-Gm-Features: Ac12FXzK4ugn78BVvJfIdwke3mdfyD7-O9XOG5GpvkZVg6h4YYAhyi_ttzdDW6U
Message-ID: <CAH5fLgg-yZ3C3r7psMJ7_rAC8Ep+OUMk6Kmek6u0VAB0RFnG+Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: add Rust files to MAINTAINERS
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:50=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, 15 Jul 2025 07:51:40 +0000, Alice Ryhl wrote:
> > These files are maintained by the VFS subsystem, thus add them to the
> > relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> > relevant changes.
> >
> >
>
> Applied to the vfs-6.17.rust branch of the vfs/vfs.git tree.
> Patches in the vfs-6.17.rust branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.17.rust
>
> [1/1] vfs: add Rust files to MAINTAINERS
>       https://git.kernel.org/vfs/vfs/c/3ccc82e31d6a

Thanks! Just a quick follow-up on this. I also sent a patch for the
pid namespace file:
https://lore.kernel.org/rust-for-linux/20250714124637.1905722-2-aliceryhl@g=
oogle.com/

Also, I forgot to pick up Miguel's Acked-by, but I believe it applies
to v2 too, so you are welcome to include it in the commit.

Alice

