Return-Path: <linux-kernel+bounces-877013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A64DEC1CFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A63453CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376C2F0C6D;
	Wed, 29 Oct 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUBFtFyv"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1A261B62
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765657; cv=none; b=ZclDvbJTkJE5RwtRD3vMbhEDFwZIKCyUgdd/3QAM5HBL7yh7QI7AQvNXODOUxRLO49sUKLnKzOTNNTlrDlKxz50USN13gHHzjKLfLhscEQG7zYts5UN+dfhfYcal/0oh9atm1EjR91pU4WR9W8cMhqYOKJ0CsjLAreYZorkBE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765657; c=relaxed/simple;
	bh=bUxSGUE6x4yj9mkYgOW19a5Hrg6nb81As/MFR8V8BJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AilHjdPm1VoRpDOr9VPZUP7sz+OdAPidyfDIubqzZEKhc+arXNnF5+wSpG85JHJtcS0BTsNF92REx+sOW6mHaVHFrn1i7iklwgkyk2+XFsCX+LTXRm0+1m1sXLhbRSJZ0zNh5mCo5eEtoSckEDhihPZY7CDBIOVWrG1xiyOZoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUBFtFyv; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e35e48a25so346619d50.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761765654; x=1762370454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xInHZdf3d2AKtpx353xPkwoYqlwGNev8XW2C5vaWvls=;
        b=kUBFtFyvy7uVQ/jiLglCxZGwhTz8CxTFeh96Yb0Q1ze/c8D7QOFQLnQ3TbsRv6gJNL
         4teh8K9w37bFhCazUtQ3S/tbWmNM6tjMjm2KPWO+4LPBAhudT2Y5HkxBucQxBMGfd39l
         UUzejnAEfU/nQE8QTZ7zlz/pTF2fovIxhLKglqM1oCL3QGkqL0EhwyoQdY64A/24ypqj
         WfNyPA4VXgb3nL2X1+BqbemXYgjlU4RdBnPJk/iIK/vh7aZ7GZriAcc6ufiNFFQp3XqD
         VVqSaHb3T9Fujchjfl4N6q2JkkVkEzjXiGaler/bZFf4YEdHGkP1s0Z3/BEC/zksG2FG
         5TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761765654; x=1762370454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xInHZdf3d2AKtpx353xPkwoYqlwGNev8XW2C5vaWvls=;
        b=PvpQESsVPN72dUy432hXUJ/wA8SE9Fj4PA11tjCHzL0IT3lm147bNU97b2gwFYP0bJ
         dn1hd6JdZt7N2GPjQVfOOGgG1PV5tYlOmEPquwpqfgek6dr3P88+DYmS45+sW3zyJrlw
         LdvhsVXZy3SZkFs3twzC5hQNvOwN9gnSaupa900zKoIcTHLqZfbHXb0hGeSa24Kblwfy
         9cVDZBAJCra/NFd+4+/xsoV7BFQWnTbvOlcYX9/uXIiexY+Gqzhm//zh4NTSQ+lC7c/J
         d2M6+jef4iBPQ3lpjV+IpxF2Y5blx0RpsRTp06okwj/U8e5RE1L0757C8Ugb8lF7Bjt5
         t1FQ==
X-Gm-Message-State: AOJu0YzGF3ZDGfMBe8YGesjrai9QLhglsAa1Zu7ZILP/4FljQsNmyC7Q
	PuU7YJOBVka34pize17xryprgyXAQeMPFbYVs1wnDL7sa3us8RqXKWJS9F1RZirWGCnFDSLqzNd
	RwdCmRhGPKeVITb9HjqvWNOdndYMOoYZpeQ==
X-Gm-Gg: ASbGncvw09mS8Bm6Dl7htOzLABDH6uDKtJnjFGFD31l6e2wS5uCZtpmyX6/vgYpQQDH
	1wFc9Ln7fgI9BaKJHTkKY/Mr+VwJYDPhHDBqN5I4X7GcdodbfDtT3Q817qpL9lYw+jyIDC0A4A8
	n4499zRPtUnzMpuIcVO2IpORf28q5M0Fr60TZ3g0oDm6YNESKihQ4FdCoz2KIOJArXsyo5ZK3Tb
	qei/rNP3dV9qThx0IIwTyH+XH4b61IxDtRYp3YDrZ7V9d+CT9Zs1zvb+G9Ltk1Y2m5B
X-Google-Smtp-Source: AGHT+IGNMUHSZBK5M3mvH4m5es/ifJUDIZUv+RKEQha8tkNUR80Dzrak0GxvnBnDdeLItDtmwPJOif8UnqKkFr8D2vc=
X-Received: by 2002:a05:690e:d55:b0:63d:bfad:6c7 with SMTP id
 956f58d0204a3-63f76dcda2fmr2696936d50.58.1761765654145; Wed, 29 Oct 2025
 12:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026202142.1622060-1-jim.cromie@gmail.com>
 <20251026202142.1622060-3-jim.cromie@gmail.com> <5114af1db16a396b65b798029b83d7b8a2c3aff5.camel@perches.com>
In-Reply-To: <5114af1db16a396b65b798029b83d7b8a2c3aff5.camel@perches.com>
From: jim.cromie@gmail.com
Date: Wed, 29 Oct 2025 13:20:28 -0600
X-Gm-Features: AWmQ_bked0PQgtrs6Ckp1UEteGLFWJc5brUPCZGWyfPkp1elICAAkSdG6pAEUpo
Message-ID: <CAJfuBxwEeLLoiUttroUCj4wUaWvBUqiXyHha4RgQLcxmy81_5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] checkpatch: 3 use-cases for --debug rx=1 option
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, 
	Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 5:40=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Sun, 2025-10-26 at 14:21 -0600, Jim Cromie wrote:
> > Use the drx_print() helper in 3 cases inside code which counts macro
> > arg expansions.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -6078,9 +6078,17 @@ sub process {
> >                               next if ($arg =3D~ /\.\.\./);
> >                               next if ($arg =3D~ /^type$/i);
> >                               my $tmp_stmt =3D $define_stmt;
> > -                             $tmp_stmt =3D~ s/\b(__must_be_array|offse=
tof|sizeof|sizeof_field|__stringify|typeof|__typeof__|__builtin\w+|typechec=
k\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
> > -                             $tmp_stmt =3D~ s/\#+\s*$arg\b//g;
> > -                             $tmp_stmt =3D~ s/\b$arg\s*\#\#//g;
> > +
> > +                             $tmp_stmt =3D~ s/\#+\s*$arg\b/drx_print("=
'#|## arg' catenations")/ge;
> > +                             $tmp_stmt =3D~ s/\b$arg\s*\#\#/drx_print(=
"'arg ##' catenations");/ge;
>
> stray trailing ; in the replacement ?
>
> > +                             $tmp_stmt =3D~ s{
> > +                                     \b(__must_be_array|offsetof|sizeo=
f|sizeof_field|
> > +                                        __stringify|typeof|__typeof__|=
__builtin\w+|
> > +                                        typecheck\s*\(\s*$Type\s*,|\#+=
)\s*\(*\s*$arg\s*\)*\b }
>
> This might be easier to read using a qr but I'm not sure the
> embedded capture groups and their use in drx_print is sensible
> as it doesn't seem extensible.
>

yes, the extra whitespace is better.
I will play with qr// see if the captures work the same.

> our $stmt_stripper =3D qr{\b(
>                 __must_be_array |
>                 offsetof | typeof | __typeof__ |
>                 sizeof | sizeof_field |
>                 __builtin\w+
>                 typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)\(*\s*$a=
rg\s*\)*
>
> > +                             {
> > +                                     drx_print("-arg-inspections-");
> > +                             }xge;
> > +
> >                               my $use_cnt =3D () =3D $tmp_stmt =3D~ /\b=
$arg\b/g;
> >                               if ($use_cnt > 1) {
> >                                       CHK("MACRO_ARG_REUSE",
>
> Back with I suggested this a dozen years ago I thought it was overkill.
> Maybe it is and the whole test should be offed.
>

I am now playing with an __lvalue(x) macro,
based upon  __must_be_array(x),
it is a compile-time check, so it gives a high-quality signal to checkpatch
if x is an lval, the multiple expansion warnings can be silenced for x.

So if this works out, we could take off the wart, rather than the finger.

> https://lore.kernel.org/lkml/1352198139.16194.21.camel@joe-AO722/

