Return-Path: <linux-kernel+bounces-813648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC28B548C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8FC1C88028
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4DD2E22A7;
	Fri, 12 Sep 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUQeBxIS"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA891F4C9F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671708; cv=none; b=LIP/b45+pNA7xggRA4iJXjQopdePzod9H6Zgzb53qW/MaltnA9NJT3IHGBIe66J9ZoaB67bGYXtn8IViAABOyiW5otjZgFmayfz+iwj04WX5H0lize4PtGKwM72C1XdTb2zkXLTCWsc5XjnIUgB1Y3ClCeAEhZbgE64niUZt7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671708; c=relaxed/simple;
	bh=1hO22WTszQUiOOn2ymdABjLhmL5qLOEUS3j8TjLksi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVHzrxcwBFYMSF1ByTtQdvbfk6q3W0k0CAsFbtHVUrYaTNsz35/djxB7ewBMuVS2Ui6mji8aG8R4OdmPy46MFRI+yC/3og8AZ+kpdgOTJUrNXsWFCLtmpSW8C+BmyGH3zEZXt/+FSXcgm1AW+ba3lVMqI61LljQ471pmSsFRwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUQeBxIS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24ca270d700so2584775ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671706; x=1758276506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hO22WTszQUiOOn2ymdABjLhmL5qLOEUS3j8TjLksi4=;
        b=QUQeBxISS3Bge0937BI1fkrBWuJbnA7g+BKHhLyS/LMtNCdY2EoObjZPs3dcSfz1d/
         4xlpB/zP+cGkZWzFU+zZduUC+dptP0CupV5xU4X4E9mQk+LjJEcA4ymEyJmLWinlnJch
         jz2vIkZKueoR1/zPJc+GUBlJYm2oLStKS8fr88fLGs3VU5SWpReuwZXng0CbbIXS0Hpg
         8Micmqib6rx45+NZ7Vb+ewa9+E9AP8Q4aCZf6cFEcFiGZBgMQffsS5aEVD7UxBgMJtOi
         9o+aLqxhN98KGh9dcwERcZh2PHSYKB+Oas7Klu7GfsVQAJzYYeAD4Gq7z9Kl3zoXQoGY
         CaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671706; x=1758276506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hO22WTszQUiOOn2ymdABjLhmL5qLOEUS3j8TjLksi4=;
        b=s5sdEZCSVN2SrF2K+LcvfF2++YBwqQ4otip159WuQA0ADGy5yAadLL5n4zaC2AuSPJ
         RaRrdj06YYjXTsuWXfLzhtTC++y1TmknGHNzoNvnaSjKWEdNdxVI37g7vcOTx7/Zivw9
         9nRXcUvm8Ao3AK/81osEaeiurnekxaMvXjch5jncFv86qJJFwg+qdMDBz7m8Qa+AvZyT
         DRIUqUUbL7n+R3lj215fgzIy3Wo2/MQLTN+8lycJH7sHlyaWaH/qjza3bujPk0wCoe6c
         0MBq+KsHbl16a5P3NN+oaHaMUtQN8jPWafpFrgzrhPbl0tHbYNc33x92I673r7il2Dve
         KmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQKXms42UZjNvJcozLJSl4PhyRqjb0i/iul75JVNvAc774IULE3twttVU6rs0hjgvKf+MczR5uVmocfSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAH/e7LJfMQNl+0JykcejaiepBmDajqdon1XxDUYhPMdfrBsG
	/bxNOwaqU1AIe91IAzmrzs73g/PXSxQPZffvJ3lqgeaOTnPobsFSfEUfRIC63ZGTtbFeCAnY+6n
	f/4kDaLwAmukWgG6+T0WTKBsW8fUVwQw=
X-Gm-Gg: ASbGnctUAlMIXu1w/f+JJp6Mgl9sjp/8oeEGKkuV91lssRP9zITDR4LXMGQN88GnKoK
	n73PAYS7G/KqH8HaxUH90QvIvfwGsDXcdvRzl46a1oFgUvp1n1lPY4nUCRDf6soTsAZeIn9InYO
	KOirbXRdzsI9VyYw/R4EuvUnatwfTKTdmzXjzo6I2IdpOXJL5zjpCmRTERqJ51ECJc99PB7tx5d
	Bm2uhtXi4EAqO8Dm1YXrP/+CNA+yj+fArt593FsUol4w9NxnsZWOB/sSaTaXM6JZc9ub5rdTnhM
	+DbNfC7BwMc+RjhDMcIe+2pVBId+28tlyRC3
X-Google-Smtp-Source: AGHT+IHQqgeTLWd69ii0h7rl5fFlUKx8SePmbFP0D2U+jaqBaQg25KiFArA+FTLhQ2AISsw0AP7/WNmwmwYZfmun5FM=
X-Received: by 2002:a17:903:120b:b0:25c:9c28:b425 with SMTP id
 d9443c01a7336-25d2752ec54mr14668875ad.11.1757671706025; Fri, 12 Sep 2025
 03:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911213157.GA1039411@joelbox2> <aMNo7qRCp_yprUAW@my-computer>
 <20250912025343.GA1376629@joelbox2> <4940aa5a-18d0-4bcd-9125-80f5a9920627@gmail.com>
 <CANiq72kZgZdU4Dut3rmcWT-cujyJaP_99ekis_XdfQ-7LmgZ5Q@mail.gmail.com> <CAH5fLgiP2DRcGy04YdsWS9+N1=_CCNEtAGrCn31vUHjnDLW9xw@mail.gmail.com>
In-Reply-To: <CAH5fLgiP2DRcGy04YdsWS9+N1=_CCNEtAGrCn31vUHjnDLW9xw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 12 Sep 2025 12:08:12 +0200
X-Gm-Features: AS18NWD4HXb9lW_s1SuGtIZzZ6y8l5yEzJq-b0E0GkqyxH4Mxc2RoG_2ansHfds
Message-ID: <CANiq72=89-22iORBttRtNeMN1ZHzH=MRvqfS5qPufHsMx8C0ng@mail.gmail.com>
Subject: Re: Printing with overflow checks can cause modpost errors
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I believe this code is using an immutable reference and not just a
> pointer, so it would be UB to use it to write to `offset`, and so it
> would be valid to assume it has not changed. But I think that in most
> scenarios, Rust only optimizes using that information when the
> reference appears as a function argument, which is not the case here.

I understood Andrew as talking about the C side, i.e. a guarantee
coming from the C side.

Callers can guarantee in other ways, but I wanted to clarify that the
C const pointer doesn't really do anything.

Cheers,
Miguel

