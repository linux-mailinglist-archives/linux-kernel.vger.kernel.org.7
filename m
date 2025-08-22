Return-Path: <linux-kernel+bounces-782019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEDEB319FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B239E16B5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10220302CC1;
	Fri, 22 Aug 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1A9+pX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4D2FFDF3;
	Fri, 22 Aug 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869698; cv=none; b=Y5ipbWN9sWDbIp74mlHnMpiXqqVtKKZvKwOZKyQEV+XNWlZ8wH7oJzWY74Gy65p8Mk7b7Q0X2TJnDKjvRHzNR4/rVTAAwrC0hvlsYEcfVgv+IGEx2TlCSmx1fnPEmRsSxfGRl167OYIUdrV4UT7CDoK2ArpTw0BWPnlp5AYNX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869698; c=relaxed/simple;
	bh=FrdD8HO82GHssBpSmKjbaPQSVpS4OUvibF5tifAwsKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBcsT8o93WqnIxB8w0AfHNeJyZoufgMnCu2wthuEiRMXHbaBDZ7705D9XAiePqqT0CEQNSONZeRqkQyjCM4A8cQmfTFBMOMdubYp+mlf1ghOhAj6oudc8+aWfpPrwmDT8CxsIO8tpEPupz3ns6KprZ4wyqlIXljVr14H245XgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1A9+pX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86D3C113CF;
	Fri, 22 Aug 2025 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869697;
	bh=FrdD8HO82GHssBpSmKjbaPQSVpS4OUvibF5tifAwsKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b1A9+pX/E4IdjC0uILsgxMhqBQemWjTAjNOPmxzBN0O6a5la4Qap+UymM8/UBEfx4
	 Z4zJ+aI7NrH8jp6/H+CEQ6dxYyYnQOOpnCXd6UwtTmzhk2lUyHhPAf5nWwI/Ky8A1+
	 1pgi/RguJzUrlrgcY+YaTRBGSxIuZG7Bhfh3Gdk7P3HprMyAdMti12y3myxgwfrykh
	 etEDyV0cAnZxCPztYt6b3trfny8hVe0GnAFbNmnsZ9Bl2uZheN3s9SVWqdiHEb6g1I
	 wnrFgyALpCgo5Isp9K2HuCpf0K0sPTARsTGlMJelzA4TfwG1B+PIVFJSiS94LEdPLK
	 twUb38GdxAkfw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7aea37cso277310466b.3;
        Fri, 22 Aug 2025 06:34:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtMJOh5PbUvvRxDzGEmYhmdVmMfWQkluxTEZyVXAilp3qLoewj+wf10KaoBM4RrzRhi8pR3C7LE/bn@vger.kernel.org, AJvYcCVdcDc4wEWhfJ+r9sPnDOgnbMEO0tId4T7i5BSQQEQIsBVgG4RSJotVMvRAeVkVE+9W4hrECKtjCAklW5OB@vger.kernel.org
X-Gm-Message-State: AOJu0YzOP1VM/Y2GqAHz4SX8Def11MK2aUTn3udSAjkUf0NnN9zUyQpW
	bQZFQXLjVhsJHb0s4G2cq2zUwxrZUSvnNTngSNpS6E2HZrzjGtxhRMPKDwm+G2FFLB5fyK2IhVD
	BuLRqMENmLDWcByqUlVJIpQBf9ThBsA==
X-Google-Smtp-Source: AGHT+IESCIYaUj1361Ru8jSWyGXtqBuI4FVQaliMDU3J04yvjuUpryjegQFzizN6g9GNF+2T2FvtqQVAFlT+tmwc/ZI=
X-Received: by 2002:a17:907:980b:b0:ad8:9997:aa76 with SMTP id
 a640c23a62f3a-afe295c0defmr253420866b.37.1755869696343; Fri, 22 Aug 2025
 06:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822060417.52935-1-alex.t.tran@gmail.com>
In-Reply-To: <20250822060417.52935-1-alex.t.tran@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Aug 2025 08:34:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQEiGvt8H+7vO38PkMsmb3+CHvb=d2QcLd6zBOfNLs=A@mail.gmail.com>
X-Gm-Features: Ac12FXz5da89Z9fM999DhvPFtTsDWpxigD8RKy2_wOvMRSuDKergCkUsY3c2BSo
Message-ID: <CAL_JsqKQEiGvt8H+7vO38PkMsmb3+CHvb=d2QcLd6zBOfNLs=A@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc/flattree.c: stringtable_insert optimization
To: Alex Tran <alex.t.tran@gmail.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:04=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com> w=
rote:
>
> Increment string by string instead of character by character.

Why? Are you doing something where this provides measurable improvement?

>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  scripts/dtc/flattree.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This is a copy of upstream dtc. If you want to make changes to dtc,
you have to submit them upstream.

>
> diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
> index 1bcd8089c5b9..156ca5da89b2 100644
> --- a/scripts/dtc/flattree.c
> +++ b/scripts/dtc/flattree.c
> @@ -222,9 +222,7 @@ static int stringtable_insert(struct data *d, const c=
har *str)
>  {
>         unsigned int i;
>
> -       /* FIXME: do this more efficiently? */
> -
> -       for (i =3D 0; i < d->len; i++) {
> +       for (i =3D 0; i < d->len; i +=3D strlen(d->val + i) + 1) {

This isn't equivalent. If 'd' was 'foobar' and 'str' was 'bar', then
before we'd match. Now you don't.

>                 if (streq(str, d->val + i))
>                         return i;
>         }
> --
> 2.50.1
>

