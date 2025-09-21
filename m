Return-Path: <linux-kernel+bounces-825995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27C8B8D489
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DB6189E54C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 04:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A51798F;
	Sun, 21 Sep 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI1PsFbU"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515122F56
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758427370; cv=none; b=GjX6wNyDMiYyYCBl7GUum8/pyDQXHcv6taxhrMpNJM7ke2VyXr3NqBenA26DHpLSnRVzQBuKMuovU75MeubxcGUsc6EwqdePfS6VoVfyjmEHayQT3PIKDeVM1xCbnnsErdRPij0wu7IzKWxb5KAsdvjowMK1iLbvBYtG8UQ+KY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758427370; c=relaxed/simple;
	bh=kCwSIctQbPgcIO81zHTIVaPbfoK5UccVGTjW1aF7hWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8kZyouesnp9yvSE9h4eQn3L+Z+qNZSOmNaUaTuh3m322Aj7YklfcL5/Ntn3kTHmxHxn+hC+ViIH5CAnZi8MKyfFbKeBzzY4V6UffXfdGDzL8qGe076xts4NrX7zjSClBXJ4VUcmZiTXYesO7meZFkE7OKl1Kd4rMnXvi/KXmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI1PsFbU; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccec59b4bso2491175fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 21:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758427368; x=1759032168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA18vrXqBDWyLf0pzyXROoXutYNoxoKmYfGadP77a2Y=;
        b=YI1PsFbUDjwqgnaDa0+gVO50zh2+Qg3W4v4vN54PnqTXicvS3O27sGYNZWp1htZehJ
         tbHE1rrds9lkEuxrarxySkOuoQPpm3jwxZNZiKYBc/Q+dJH0L/xP/UsDlPMhicdFKjPt
         FAd6/Wh1psWteO/iFPs7Mj0d4P8M7Mnrll3RtWGCGhWI7euVzAQktZJCs/oTCG9Mxusv
         NBZ9msckVVr6x557KZeZ6LcAbb3vHw5vCk8dG2rVY+GxGVwQ789WwkbjbmZ1qkV5MX3x
         8PSARxMvQ+EG5TnRodKwcvGnMJUnfVXWkdiKv8OlduyXFCdqM4k1IH4OCAqeXxGlBgs2
         Cxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758427368; x=1759032168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA18vrXqBDWyLf0pzyXROoXutYNoxoKmYfGadP77a2Y=;
        b=xOgFFLROh8DB1rZ7kIh9DVtP+K723r8lmoqmGnNeNbnwVMreoUa/nI1G9XGpLyjzjE
         pBcay+3Qf3Wevd/6wBRIxXtUAOXtDMTUH3k+BxYVU1BEYi0ZohzKKibEFhFq9WDUc+5I
         Ny2KlFGkQ2Bqay10JlathxKAYySYkKWohLa5BffiRCqRcrx6jDfrvqSbhfKDciPoqNZ3
         CqVg+WVXqwoodZmXJLC3f5kkpSKb58qxTwZeaQcUQXRwoeP2B4xGFg87masRcn2lF9Z5
         FU5+fpQLKdwD+dAyd2QEyF4dbwjeU92V4doOARmUORSaiW6ugX1+Gw4S71NWp447WRZ1
         lzsg==
X-Forwarded-Encrypted: i=1; AJvYcCU8v/HLpEY1ak3EvpI5vZhRMqvYHODaFThw3YPJOKZEx4OYml0DPuJlDpliacz/v0VNUDOO8g2+wODmHiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeod2PWqNUm7Ry8wXjefnMaPUOl9Yy3JYdOUX+ITLiDRsK3ff
	tFfj+chaQdqFQrZVZO7D3YkkXMjQ1leXVLtg2gc9WNNAPnSr9frvfqBHoFEPZCFu70rzWnG5b1e
	leEK78uZcWPPXasNftZPby3Vw011WltI=
X-Gm-Gg: ASbGncvHaQGzNJaJ/TizjfujRbKyqJn7t8JBuYbopfIkMIj5LPNjQTUDwD5zQHmxuUv
	nVSxMNFs2sOL36wn/GocDdAJaFgIP7fYo7AukSw3rLfarfeQaP0cveuEvWOCduExYdC6/w0CP2p
	DfathWQeOiPJsMqlo/VD5z7jTPhA5GA8tbwfL8X/amwNU2ShA1geSehw/QkAKkjWqthIUyIMRO/
	31TmmjC
X-Google-Smtp-Source: AGHT+IFZLr/xsThdfBtqHXf4ZSYYWdYKPhHyHU+8bF5NmoloZBLoe+bOTD86dgsH7ivu1U7543S8yu2mTI8ezy8bXJU=
X-Received: by 2002:a05:6870:e98c:b0:315:8a2a:3f59 with SMTP id
 586e51a60fabf-33bb46243bbmr4362489fac.21.1758427368277; Sat, 20 Sep 2025
 21:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
 <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com> <5789241.GXAFRqVoOG@workhorse>
In-Reply-To: <5789241.GXAFRqVoOG@workhorse>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 20 Sep 2025 23:02:37 -0500
X-Gm-Features: AS18NWDJ-i7DOGCOG3Z1nAPhjBByGeEhge0EG9gSltw9wqhDLGlBL0w1VItqTxU
Message-ID: <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-mediatek@lists.infradead.org, 
	Jjian Zhou <jjian.zhou@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:02=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Friday, 19 September 2025 18:32:12 Central European Summer Time Jassi =
Brar wrote:
> > On Fri, Sep 19, 2025 at 3:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > On Fri, Sep 19, 2025 at 7:50=E2=80=AFAM Jassi Brar <jassisinghbrar@gm=
ail.com> wrote:
> > > >
> > > > On Thu, Aug 21, 2025 at 9:12=E2=80=AFPM Jjian Zhou <jjian.zhou@medi=
atek.com> wrote:
> > > >
> > > > .....
> > > >
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/slab.h>
> > > > > +
> > > > > +struct mtk_vcp_mbox_priv {
> > > > Maybe 'mtk_vcp_mbox' is a more appropriate name ?
> > > >
> > > > > +       void __iomem *base;
> > > > > +       struct device *dev;
> > > > > +       struct mbox_controller mbox;
> > > > > +       const struct mtk_vcp_mbox_cfg *cfg;
> > > > > +       struct mtk_ipi_info ipi_recv;
> > > >
> > > > Maybe also have "struct mbox_chan chan[1]; " so that you don't have=
 to
> > > > allocate one during the probe.
> > >
> > > > Also if you have  "struct mbox_controller mbox;" as the first membe=
r,
> > > > you could simply typecast that to get this structure.
> > > > Something like "struct mpfs_mbox" in mailbox-mpfs.c
> > >
> > > I read somewhere that this way of subclassing is not recommended.
> > > Instead the base class should explicitly not be the first member.
> > > And then container_of() should be used.
> > >
> > > I don't remember where I read this though. But I think the explicit
> > > container_of() is easier for understanding the intent.
> > >
> > And how does container_of() work ? :)
> > typcasting the first member to its parent is the simplest form of conta=
iner_of.
> >
> > -j
> >
> >
>
> Which is why it's completely equivalent and since code is supposed
> to communicate meaning to humans, container_of should be used.
>
Nobody is suggesting typecasting cfg, dev or anything else.
Typecasting between mailbox controllers is fine and arguably easier on
the eyes than using a container_of.

-j

