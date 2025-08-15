Return-Path: <linux-kernel+bounces-769780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09660B273A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7435C1CE1B79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AE21348;
	Fri, 15 Aug 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="E71loKq4"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561826AEC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217028; cv=none; b=emwrqs4t6GUtfcuhPE0SaTTcrIVIry2aavQEWm2SbUP/CScGNXS2jP3PH3D1enFUtd06uLnL+pN+iDUrBxRwmFkCWUKNVPyoG9EQlCWEoIJQkzj8gSKpf7ScYGmPnP+igfgo0E4u8ob/XZzRrLwaLKKmIPv4gxz96IolMcuaQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217028; c=relaxed/simple;
	bh=b/7uJluNZ2Dq5dHQa5IRA6PESh3vzrY/KnYcV2sm3Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s626iHrDyIh90TZoICYXXCY3dYCYpvMpCiOc3APu1KjusDfegVetyW5nozaMI/lKx+LskmNPsW5nrkSfbHSsgsYLrVLkcO+A52jKNUEdo4uxJhFOkt7ftZlmslk/dS64gZKyjXjziJY+fOZ7uyyzLoNCl92pJTJuw8lpl2XeQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=E71loKq4; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e931cc1c442so1490398276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755217026; x=1755821826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIb4DEw47nTG0SaTMqagi62gcLVr/AwhogL/DWZeO9k=;
        b=E71loKq4zRKkHkuI+oWoYwGajT/lswwJxZbqYvfH8sIYI2/aeC0YmCrld5WqHsMMCI
         /g0fttnYFU38rWJUF6whTadQWVTXlLlgInpVoH8vZS30hnynEHti5qgnGT3aNVGrV960
         Fl6sSG4VQsxU3A+e/QLK3sgLAKo31X1vdtXX6Ny+1bewCTzPAN3pQEktgVCFxNtVQRYA
         1JXYuYFdG6aGDM26xJP9qNQ7BeEo/B7pJdmzINQ9aqJROX07f1xVRQZc1TN7omW4FiWe
         cCfSWnvGYJ4z6ZbWkm+gFi2Rud6+joavUL++Q+NOl5gzTkrMpi4swKWTWXW/3MPcYklr
         ztEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217026; x=1755821826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIb4DEw47nTG0SaTMqagi62gcLVr/AwhogL/DWZeO9k=;
        b=is0fsZIY7xR3cInQmZ2qX1twZaUhHadSB++0vWxsycUzbgeSHQ9+1yUrOzqX3Ssx5S
         850crRsCnG6c5bzjMjBOrdju+7ceedCkArE1KNw4yU6TlbYxtjnLMwOjiqXnL8Cw+qQi
         K3dN0r6wnezGoyhviHIViC+/x69jkQqSWewzl1WLi03OBD5pzb3FkoWDpeIEjGkH2YGO
         UTvxMXb3coFv64OvuLixsw580H+/4j5pL4SB+rmg5egqMyPR1LIC/iRD/Ik9eYy4N/gO
         d4LM+CIVJOd+WJKOH4WcBn8/eQmR+DmWLOZOEz+ONunVaw5dSjuGY43wHE6M1sHG8YoI
         8pgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9nCE2AVBgk2OGyZnUrfv/qGa1nErYgXX+rLNQTrjeL1cxCHW9Q3SCJGx8ufTNrchSL41nq6/1KmeBVfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUgLFAI7fyQKNoNWDAYKVody4OwMQFvI6R+JiQyqYHXzZ+f5N5
	KWq/waU2ERlPMtAzhiJTkVu4KMZL0rDDdTjGMfAaZ2u+OOt6M1ykRVnvPAL3PG36tuQlEMr4tMl
	Usg0gkTNp9UFK/5vIcTsNMdYvBBQqt5kB5JHLY2WJJA==
X-Gm-Gg: ASbGncuODeooXwCm36uqoyyr5DcpSK14DIQz3U1bww9/eXN46QDUWIgkvXd9Mo95H6y
	X8c4WG81En0j+nJBXz/hqQXf2mW3lz92qqPWQ0bYGwFao8HysOVqtCAqc///+iB7KuDhEE7v71N
	7Ha2PGvjyLIM5xcAt8nZTXrn1IcODjBTQgp0T6LSjOoN94xzoIJY+CXTfkKn9+ZN7lIGjOBZXqy
	Nu5R3tz
X-Google-Smtp-Source: AGHT+IFNcAELmZCtW5xlsegSitNsfdTcRTdgg7kL6zgWJQdycJdLaDsFEfIH4/zktV/oPQX112UV7cBIiymlf91sbEo=
X-Received: by 2002:a05:6902:706:b0:e8e:120b:acc7 with SMTP id
 3f1490d57ef6-e9332110bd4mr348314276.0.1755217025789; Thu, 14 Aug 2025
 17:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-2-8b0f5cd71595@riscstar.com> <20250724123128-GYB748228@gentoo>
In-Reply-To: <20250724123128-GYB748228@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 08:16:54 +0800
X-Gm-Features: Ac12FXypsuzBkicYnVbqoq7E_JzqM7nw1pio2gCMjc_eN9bFRW8TFMqF6u8aHzA
Message-ID: <CAH1PCMZ7VbLxJbHQt4Ox_nO7yDSBMzTYiczC3FGBbG_oXgjLXw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dmaengine: mmp_pdma: Add optional clock support
To: Yixun Lan <dlan@gentoo.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:31=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> I personally find the word 'optional' introducing some confusions..
> I can understand from driver perspective, it's kind of optional,
> but from SpacemiT K1 perspective, it's mandatory for this driver
> (the 'clocks' property of DT is in 'required' section)
>
> feel free to improve the commit message, maybe add some motivation
> hehind this

Thanks Yixun for your advice. I will improve it.

-
Guodong

>
> On 17:39 Mon 14 Jul     , Guodong Xu wrote:
> > Add support for retrieving and enabling an optional clock during
> > mmp_pdma_probe().
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v3: No change.
> > v2: No change.
> > ---
> >  drivers/dma/mmp_pdma.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> > index a95d31103d3063a1d11177a1a37b89ac2fd213e9..4a6dbf55823722d26cc6937=
9d22aaa88fbe19313 100644
> > --- a/drivers/dma/mmp_pdma.c
> > +++ b/drivers/dma/mmp_pdma.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/device.h>
> >  #include <linux/platform_data/mmp_dma.h>
> >  #include <linux/dmapool.h>
> > +#include <linux/clk.h>
> >  #include <linux/of_dma.h>
> >  #include <linux/of.h>
> >
> > @@ -1019,6 +1020,7 @@ static int mmp_pdma_probe(struct platform_device =
*op)
> >  {
> >       struct mmp_pdma_device *pdev;
> >       struct mmp_dma_platdata *pdata =3D dev_get_platdata(&op->dev);
> > +     struct clk *clk;
> >       int i, ret, irq =3D 0;
> >       int dma_channels =3D 0, irq_num =3D 0;
> >       const enum dma_slave_buswidth widths =3D
> > @@ -1037,6 +1039,10 @@ static int mmp_pdma_probe(struct platform_device=
 *op)
> >       if (IS_ERR(pdev->base))
> >               return PTR_ERR(pdev->base);
> >
> > +     clk =3D devm_clk_get_optional_enabled(pdev->dev, NULL);
> > +     if (IS_ERR(clk))
> > +             return PTR_ERR(clk);
> > +
> >       if (pdev->dev->of_node) {
> >               /* Parse new and deprecated dma-channels properties */
> >               if (of_property_read_u32(pdev->dev->of_node, "dma-channel=
s",
> >
> > --
> > 2.43.0
> >
>
> --
> Yixun Lan (dlan)

