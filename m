Return-Path: <linux-kernel+bounces-826323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25696B8E31B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D70179D25
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA622750FB;
	Sun, 21 Sep 2025 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5ujcx3b"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F4239E88
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479179; cv=none; b=j295dGJSSXNwtGbPXt8grG72fz8ZysD3F72KdAARtc8x0x+gLn3dNTmx9gDy1RCguUbvpZ2fkeWqYGWsnqlBWRMLvsooGDg0M2uXJrRaJthOy5k3Z/ZtX3X0tbTPhrNKA87dtPYkFi6WUQ09pgjV12gm7hNwK77QWpWJw7u2MJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479179; c=relaxed/simple;
	bh=F4zmkAHPjhKHpB7D8+DDrYGAR3U5WXK9thJ0sK89yEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5CGFpBMpL8dMov9e7wL60xQ48z/LTzY+oZVtwGF2gWfXG9GM6BuKzliQm0ep0icpiGczdBpHOe6Z2to4+L3NAL7XYGzRnkgyWhphZ/fwMqy2/V0Pr1ggZ4DYun0gtZdoTsJyV2Msxn1e5UkInW8ExTqvXNJ7/Yuz/G7iqSx/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5ujcx3b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b28e1b87aa7so153518966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758479176; x=1759083976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4zmkAHPjhKHpB7D8+DDrYGAR3U5WXK9thJ0sK89yEc=;
        b=b5ujcx3bRpv6ptjgbdoFrXy6150FCHUzWqfq5IhcJEQteVR/6CKMEo6Yavh1vLPQ7l
         0l52QmsOiEsXdGnuLFxf3+9I15FoDYZb99yTpMSXDvY0BTCcGrSL/7xxiqvZMG2ZsG1h
         wwTVbrxHD8Dt1U1tBFxsbMrJPNXiDdbtwINoHeUzbqCLB/Zan1uz/bWcVps1m7ECophb
         COudEbdoPNBxFP2ohdMx4vRqqXRfhzuKRaWNr9uX2ee+FwqwRRnkTHbwMjfKdkcPKvyl
         cJ8b/+9xjhc1qbzsHSJdXx6W1xTOyKw+I2IfyTfLdWU0icXOIk7CxDj6OZqWjebkQVOo
         0z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479176; x=1759083976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4zmkAHPjhKHpB7D8+DDrYGAR3U5WXK9thJ0sK89yEc=;
        b=COVS2O+ZOdZslbvE03ZWKakh117t8ujd76iJeIt8Ef99Nj/6+YSmk8fq4IF7E9goac
         oSlOCVXFEPWMcDL3iNttE8MnrA6t5t8KqokbQdRbI+xCOvkj7e9byQUDxGzm9udNr0ry
         gOIpW33LCrvXCjb+B8Kx0emFc8eET2m0P2DdLjhtFNv0xHZne7aLB913PJU1YAPDPZ5Z
         6LGe471PXOZOLHeVNy5rHvV7OcvueBOhF2/oCDVPoRc+4M6MXVKT6Xa5u95t0p06l6Q+
         00YncGjXJ3FtsTjKUUegJayabHoMylJhffHIRhNoInXK/AWMP+nDrQJhIWDQfnulielf
         eAdg==
X-Forwarded-Encrypted: i=1; AJvYcCWFhAxQF6eqGKfkgK4lRd3VJh4UQN+ckJ6QETNNoQYHbRlUadHG0/hIiq1aW1OsnIwubQPNCkVE3IMETZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kRK+l40JwdxzHLG7aPn47vCIrvbnLgP+KdZYLNDYCBv9LACK
	wFtvnqxvsnTk6wb7aDoEqGMElT/HjhON/WjBRx5rIF+YfdVy2840XPale2lZS5xihTkRg+Qx3f9
	Twa6ENttQomCdiSEkR4j/FJi79aSrIic=
X-Gm-Gg: ASbGncvgcrgkSpMl5ULiXZikPMFwZAvG+V3gplrZx4XW18KNiTmbZ4vNczLVKiHij5B
	am6rdvNKk3ifos8lM7xM2s0J7QB6e6EFN6ZL+wbMzNoWRR/PtsPVfL2BwzIMCX7RUvp0YZnsVLW
	CJt8uKt7jEBtd+EXYydKkV6z4UPLzWVCeuWMfIDQFW1nuahYBEqSWI6jjK0GOcb9RCVNwmxWacC
	DkWtTM=
X-Google-Smtp-Source: AGHT+IHh9e7xoMHQuFzPAPTA2CQWR9c/d79fb3/OPULapQmLwjGLq95LNatOsDtZ/08h/6VJ4lMyXWHqYMA+9gMoEKQ=
X-Received: by 2002:a17:906:c155:b0:b04:6fc2:ebb9 with SMTP id
 a640c23a62f3a-b24f442d968mr1064293266b.45.1758479176060; Sun, 21 Sep 2025
 11:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
 <20250919145750.3448393-9-ethan.w.s.graham@gmail.com> <CAHp75VdyZudJkskL0E9DEzYXgFeUwCBEwXEVUMuKSx0R9NUxmQ@mail.gmail.com>
 <CAG_fn=XTcPrsgxg+MpFqnj9t2OoYa=SF1ts8odHFaMqD+YpZ_w@mail.gmail.com> <aM6ibO75IidHOO3m@wunner.de>
In-Reply-To: <aM6ibO75IidHOO3m@wunner.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 21:25:39 +0300
X-Gm-Features: AS18NWCeZeZJHwiXQSoRlyelBxs_br4n2Gp5Ptss7c3DoCLdwMlYv5AhZy2eILA
Message-ID: <CAHp75VeyCujEX3dFBVF=ioHOqPbWQRtuB7_zFGndAejYbMW05w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] drivers/auxdisplay: add a KFuzzTest for parse_xy()
To: Lukas Wunner <lukas@wunner.de>
Cc: Alexander Potapenko <glider@google.com>, Ethan Graham <ethan.w.s.graham@gmail.com>, 
	ethangraham@google.com, andreyknvl@gmail.com, andy@kernel.org, 
	brauner@kernel.org, brendan.higgins@linux.dev, davem@davemloft.net, 
	davidgow@google.com, dhowells@redhat.com, dvyukov@google.com, 
	elver@google.com, herbert@gondor.apana.org.au, ignat@cloudflare.com, 
	jack@suse.cz, jannh@google.com, johannes@sipsolutions.net, 
	kasan-dev@googlegroups.com, kees@kernel.org, kunit-dev@googlegroups.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rmoar@google.com, shuah@kernel.org, sj@kernel.org, 
	tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 3:47=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
> On Sat, Sep 20, 2025 at 02:08:01PM +0200, Alexander Potapenko wrote:
> > On Sat, Sep 20, 2025 at 12:54 PM Andy Shevchenko <andy.shevchenko@gmail=
.com> wrote:
> > > On Fri, Sep 19, 2025 at 5:58 PM Ethan Graham <ethan.w.s.graham@gmail.=
com> wrote:

...

> > > > +/*
> > > > + * When CONFIG_KFUZZTEST is enabled, we include this _kfuzz.c file=
 to ensure
> > > > + * that KFuzzTest targets are built.
> > > > + */
> > > > +#ifdef CONFIG_KFUZZTEST
> > > > +#include "tests/charlcd_kfuzz.c"
> > > > +#endif /* CONFIG_KFUZZTEST */
> > >
> > > No, NAK. We don't want to see these in each and every module. Please,
> > > make sure that nothing, except maybe Kconfig, is modified in this
> > > folder (yet, you may add a _separate_ test module, as you already hav=
e
> > > done in this patch).
> >
> > This is one of the cases in which we can't go without changing the
> > original code, because parse_xy() is a static function.
> > Including the test into the source is not the only option, we could as
> > well make the function visible unconditionally, or introduce a macro
> > similar to VISIBLE_IF_KUNIT.
> > Do you prefer any of those?
>
> Just add something like this to drivers/auxdisplay/Makefile:
>
> ifeq ($(CONFIG_KFUZZTEST),y)
> CFLAGS_charlcd.o :=3D -include $(src)/tests/charlcd_kfuzz.c
> endif
>
> Alternatively, if the file in tests/ always has the same name
> as the source file but with "_kfuzz.c" suffix, consider amending
> scripts/Makefile.build to always include the "_kfuzz.c" file
> if it exists and CONFIG_KFUZZTEST=3Dy, thus avoiding the need
> to amend all the individual Makefiles in the tree.

Thanks, Lukas, for the ideas. Yes, something like this would be acceptable.

--=20
With Best Regards,
Andy Shevchenko

