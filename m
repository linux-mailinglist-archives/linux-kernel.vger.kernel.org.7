Return-Path: <linux-kernel+bounces-828977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330CB95F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2834D188F041
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EE323F5A;
	Tue, 23 Sep 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il3P0xHv"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9B321F3E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633104; cv=none; b=NHmFn51+GZq+vd9VatqNQEqU90NOKYKlOY91B8sYVj2SsaPzAF10ILx4OCC+W37ijPuWvTBlJVz/PtfhDz+3pr2CLOveitKaE58xUIWCqQtSY7F9tYSBTtAPJnq004mZG/IQ/x1wZ8BXp/OMn0xRjx9cqCtO3oZLjNzaYo1gzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633104; c=relaxed/simple;
	bh=+jMu3mWxHYwqLRuWyAD19NE2SkDUi2oO5dL4rd/KzTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaGTZ9Tvbv7fv/ejWooViD1ygayR4gtshGMILFVrwCkgmbZA43geJnvGB6fozG7ToeDs4w7OlYcKz9n+Q75GVTzfxSRE+uVeFcS8YkOB17cCt7m26D2BMGb7de/n5QIWrCOauJWcl852+OqpXdaoMqTwBtuKgcwOkzLpJKEa8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il3P0xHv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-33158d9dfc6so5014008fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758633102; x=1759237902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYLukBQ17FPEmEKg/j/keCvoGNFtY2B2OCdn9YrZHqE=;
        b=il3P0xHvu23llByn47+ZGri26hWfzRGMEj9Qc+6Qor0nG2k248L2dcjYLNw8a2eeA3
         7Cz1NEsfwJp02AUE2NW7eVdnxwPpy3oARYCTvuXsma/uYod0qNdpoZdg9VKBaYmoGVy+
         YCX95YW9UcTi46rJDJUugWTJq/jNTjrjEOgpKywNA4I8oY7xcSTctgwWtcCzEOS7ic8R
         zoM2YuEBmT2Sy4D6XohQSDaUfeB2p3zha2Ihi4J+sJUZA1sYp0enSCXhPnCFqtcrXP3O
         6keoYF6OhGLoxl98YSB3OzK1chfVdUxK6mTHCClBWVg1V5juGD8lKbtIqMyNVhfVutFt
         GVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758633102; x=1759237902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYLukBQ17FPEmEKg/j/keCvoGNFtY2B2OCdn9YrZHqE=;
        b=mqE6DAzW/tHixywo9tTzd+AFSOVNI12EK5WQ2QQylUw6k8iYnG9oa1RfQ2GDAVG1WS
         sXdJwFQn+1T1kWbTq4VHs7p5rDdPWsid88m0oAOPYQVTtKCRB434Rq9ZuiqVlx0dsxLK
         zkoAK98LFb993mlW19dewsVm1PssR0B7iqBb4LGxicAelyiBHC6zv4653BrZzX//bsV4
         KWi0vQ0S55g2IJ5oTVRBMA1eqXDB34DNYr6lvWoTO22tNVdkcP0UrSL1CBj4xJwS5QF9
         LgDjV+ISKVYBGNAcYJl95vbbmws/C/TrXBWNreJjsv3Tgbnv9xnMPLyYT+TGpRNIYJ6J
         2mRw==
X-Gm-Message-State: AOJu0Ywzq73H20wfhJanUkeRcZUuOzyBL61AzwV//+eOjpJxsSY4gIA9
	VxADGXOI0zkt4fD5PBeXksgBnQ12gkxyGArH0Rv95iPEDrpyE1bG/ObKrnvlqn6xmuEw/Un/rsg
	dczQgcSp9vdQjoyXjSoJhr7Ujo1mCujU=
X-Gm-Gg: ASbGncsMPvt9W71A8OKtxZAeQhI+/YeYIEFi1+AYAAQCB4yS3THrqAGXVAiiU5R7/bk
	A6WpTqzdRvxzvbVbPuepBZnit5H15bPvvsWkDaIZyBUgAk3ao+fjTMYop6HzVq5Zq1wyrafG8rU
	bYtOOMZaja4XtGSRobbF1u3EAYGQO6Pr64a+bDDg01fEvHWvFKex6w93fyqMEqEzqS57WMk7TUb
	bPj4Zly
X-Google-Smtp-Source: AGHT+IFk37z9A5OnXp4wGR0Qz6tmc2B/fCuFkSXnr4AQAOqobsq/8dZcTNp3FhmVzy9qfW4xwfMc32NUWauN7gIvh50=
X-Received: by 2002:a05:6808:344c:b0:439:b1eb:300e with SMTP id
 5614622812f47-43f2d445abemr977911b6e.33.1758633101752; Tue, 23 Sep 2025
 06:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <20250822021217.1598-3-jjian.zhou@mediatek.com> <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
 <24a916ece6971d3ab9156dd8277eb23935e9cb13.camel@mediatek.com>
In-Reply-To: <24a916ece6971d3ab9156dd8277eb23935e9cb13.camel@mediatek.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 23 Sep 2025 08:11:30 -0500
X-Gm-Features: AS18NWBF4NguOxMN8xnesFe-YY3RY5n_pyTUQl_94Lw7IZuBIdJPh4k0eaZQ2eo
Message-ID: <CABb+yY0njdWUd=HWT1rSYSpNM9QoO_jf6piY9ny1enB+rZZF+g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: =?UTF-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"wenst@chromium.org" <wenst@chromium.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"robh@kernel.org" <robh@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:46=E2=80=AFAM Jjian Zhou (=E5=91=A8=E5=BB=BA) <Jj=
ian.Zhou@mediatek.com> wrote:
>
> On Thu, 2025-09-18 at 18:50 -0500, Jassi Brar wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <jjian.zhou@mediatek=
.com>
> > wrote:
> >
> > .....
> >
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +struct mtk_vcp_mbox_priv {
> >
> > Maybe 'mtk_vcp_mbox' is a more appropriate name ?
> >
> > > +       void __iomem *base;
> > > +       struct device *dev;
> > > +       struct mbox_controller mbox;
> > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > +       struct mtk_ipi_info ipi_recv;
> >
> > Maybe also have "struct mbox_chan chan[1]; " so that you don't have
> > to
> > allocate one during the probe.
> > Also if you have  "struct mbox_controller mbox;" as the first member,
> > you could simply typecast that to get this structure.
> > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> >
>
>
> ERROR:FLEXIBLE_ARRAY: Use C99 flexible arrays - see
> https://docs.kernel.org/process/deprecated.html#zero-length-and-one-eleme=
nt-arrays
> #81: FILE: drivers/mailbox/mtk-vcp-mailbox.c:24:
> +       struct mbox_chan chans[1];
> +};
>
> Can we ignore this error?
>
It seems single element style is deprecated. While we know what we are
doing, let us placate that error by
       struct mbox_chan mch;
       struct mbox_chan chans[];
and set  chans =3D &mch

