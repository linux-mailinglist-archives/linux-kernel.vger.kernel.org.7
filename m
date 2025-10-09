Return-Path: <linux-kernel+bounces-846211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3FBC74A4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB58519E319F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C314235061;
	Thu,  9 Oct 2025 03:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYrFrQm3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318F233727
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980277; cv=none; b=aHRfsAxa0SWeafD50SoD0bSQGGlh38BhcYWWBTox3WsqjLSl80C6yLpr0mdmqp3M0sMhbvcA5SoweEW3m/0WvEY5sbnqC8Pm9ws3/jGPoSjd+LiPRzyY/3qli371CUxlSf/KcWlZlY899GZBM4et4KaTEJC7cCHQrv5e/Gvu5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980277; c=relaxed/simple;
	bh=wuy3By0Y2Tg+b7ZCa7mieVDm5ZYxL2laIBVprF635AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7b7/P5MeTdkoEUgewXaYpLr29c0RH1az00BomvqkSLjHsBTxd43SP7BwoXBCsp0UfkTqYAjfGOOhsFfIStuqn4kWpLXgRbCv2sHKUbmijQHGTY76Sm5TBRoN3CIJF+oK7hBE5eB5aB9NfVp7eVPz4iUuLms8DEGRg2Xw85AYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GYrFrQm3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37612b15a53so5111001fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759980274; x=1760585074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsJEEsv3A5O4v+d0q0gbe7mKpNJ5lsVKHfbN1hMU8aU=;
        b=GYrFrQm3fi3pGBJKPS+qGpuA3qOFL6L16bTF+eguk8lzNkVfKM37rzPLXpTSwSxkQT
         KMujxl2GTdtN6yBSSs+COtObM64ZfRl2pS2f4Pb/2JfwEukxSLAYpjYilNAYHCVOeDuC
         I4ij7VliPlT3+HYicqFf6pO/ksdQf3uKsMwZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759980274; x=1760585074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsJEEsv3A5O4v+d0q0gbe7mKpNJ5lsVKHfbN1hMU8aU=;
        b=eottFL/vmcwXmRQKe81SU1i1OV0ElsYe5yvhNlpf4Z6+zN/pYcXHqnAQRpegw6wZh5
         aVn30YsDFCSUXV6LEkdWOzh9oWEKAXite6QCsTnzrrkyVwWAcGCFE40gK2JCY1yK+dB2
         7bF3IzteE3Sovemm6e5/jRDsOz0G+Lql6akXANA/WXwONGM64WprMKDly+arlCS8nc8k
         VyxDY0avU9mHobEDOkGS7dBkeOXKadkful0JGAZ8/k10q2pI5vH3YOHY7hszN8niNpxa
         tZLD3+eE7T9ymH7l4aeX4wWlazaLidx4/U+3UVihx4UBFy/AL3EdvYKwlKFWAFlW1//t
         fGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb09d8YATfd7PdLCK/ognK37RLXgc5R5vW6xTOg0b3Kb4Fl9oo5n2W2BzSCPh/UL4sxeUbkwKq02KhEJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgojchDo/TFjkzUoEvp/bi+2RsnVIcNu3OJvP0GQaO4RFrYUZe
	G8nxTw7R/etCNEWlc9Bphb+4jabmkuJ0OgCw47VVfIOcS1RHrnB865aJaK7+3+Mzin8VGyQBFox
	cDWh2tVpLMfaNpzmjUPdevUlawwjw+ifXOPaIZqgj
X-Gm-Gg: ASbGnctw01k9hX6gMRuEBAO6Qq20qdTkMelkbIp+ZXje1XFOvBjkWa1URDIbRBvTQoS
	fSszaJB1ObX4uhnkDW6SdeRa1pR24SkIdBKvLv3NOMiv54UDGRdePgeewGsZCVvZluti3xuXQlZ
	K9d+5tVrCFWYkw+6NdIz4xDSGNOJtkKnPtNe2TcFnYI2tiYAydGjRWD2wZZza/+aGGomCufuiRm
	PQrc7x1tqKMEyZf5BTxHru475hjzQKvld6+pIlUazCmnJOst6axar/Kh8ZR8A==
X-Google-Smtp-Source: AGHT+IG+QPrYaBQEcc1m0DbO6LG5DEjR0TPM5uYoLtJqrCmn8hGuxLighHMEr0XBvn54MH/J/Jg3LC3BrvSJqr9grVc=
X-Received: by 2002:a05:651c:2125:b0:36a:925e:cf3c with SMTP id
 38308e7fff4ca-37609e92df7mr13074921fa.31.1759980273543; Wed, 08 Oct 2025
 20:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002092036.2504858-1-wenst@chromium.org> <aOb6iNR9T4R9Hp3R@redhat.com>
In-Reply-To: <aOb6iNR9T4R9Hp3R@redhat.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 11:24:22 +0800
X-Gm-Features: AS18NWATwDeEXLQ-tcqHs03KqOOqKmAvfXttBG9nKH4eO_votAHmlfrLRfdR9ao
Message-ID: <CAGXv+5HPjEnYh+zUi67+Y=nmFfdRFw0xd=rT7L_-GNxouga4Ow@mail.gmail.com>
Subject: Re: [PATCH] clk: tests: Add tests for clk lookup by name
To: Brian Masney <bmasney@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:58=E2=80=AFAM Brian Masney <bmasney@redhat.com> wr=
ote:
>
> On Thu, Oct 02, 2025 at 05:20:35PM +0800, Chen-Yu Tsai wrote:
> > Clk lookup (by name) recently gained some performance improvements at
> > the expense of more complexity within the lookup code.
> >
> > To make sure that this works as intended and doesn't break, add some
> > basic tests for this part of the CCF.
> >
> > A new "clk_hw_lookup()" function is added purely for running kunit
> > tests.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/clk/clk.c      | 11 +++++++
> >  drivers/clk/clk.h      |  4 +++
> >  drivers/clk/clk_test.c | 66 +++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 80 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 85d2f2481acf..a17d0070d11f 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -778,6 +778,17 @@ struct clk *__clk_lookup(const char *name)
> >       return !core ? NULL : core->hw->clk;
> >  }
> >
> > +#if IS_ENABLED(CONFIG_CLK_KUNIT_TEST)
> > +/* This is only provided for kunit tests to test the core lookup funct=
ions. */
> > +struct clk_hw *clk_hw_lookup(const char *name)
> > +{
> > +     struct clk_core *core =3D clk_core_lookup(name);
> > +
> > +     return !core ? NULL : core->hw;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_hw_lookup);
> > +#endif
>
> Use EXPORT_SYMBOL_IF_KUNIT instead for consistency with the rest of the
> kernel. In clk_test.c, you'll also need to add:
>
> MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

Didn't know about this one. Thanks!

> Since clk_hw_lookup() is only used by kunit, why not just put this new
> function in clk-test.c, and use EXPORT_SYMBOL_IF_KUNIT on
> clk_core_lookup?

Then we end up sort of exposing clk_core_lookup as well?

I believe Stephen wants to keep things contained as much as possible.


ChenYu

