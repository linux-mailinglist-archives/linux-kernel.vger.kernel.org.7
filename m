Return-Path: <linux-kernel+bounces-846434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B665BC7FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AF91A607F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D826B97E;
	Thu,  9 Oct 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fEmoujei"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547C269806
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997943; cv=none; b=n3Cob3jGxhZRG3WtojQg05AU1rV7hLXzpLQsYJYJoRcTIkxdo1nygt7hfdfb7m0WXVj8tcQb5Jnqt2/rk3SKi1jD8Z7Hb3/t2/IGcrVdWOo/FWqgDUduBedkehxhVubipwp5EDhkQ5VAMswb+RGrxzMPsrirab9ozemZrUVAHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997943; c=relaxed/simple;
	bh=zB8TNQPA3Wzg8xVPOTBwKcKKHslhPzrMFME5cZusnCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcfbhQWEZIDlGKcTpFkmuX/qZ5hEAzZqOCVZxxjPHmYPVpOdT6iu4rHDn6N4zhxFVX2YeKOCYMu5Ve5qSdMgI1keJVAjZdyoalgwuLSD2jQu/YLY0TSH8hzdKZgNXBDm/2jSXX/Su1fnWhqmLzjzt0Qvf/TwJmreR0pguaW3iBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fEmoujei; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-279e2554b5fso5905585ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759997941; x=1760602741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faVDqKCdKWIn3NWkm8sNO3VSI1X3h4Cs5MtO9NYvbBo=;
        b=fEmoujeiO8qeJU2AGLVkRPeVGgOlbhq+maEo7w2FW+DlADD3pbA+CH/6T5wL+lQW/z
         F9X0cy12J7hwMab9W7YhVJJZ9gbannF0AcUWdXcmCP5XRWEPdsht74B9AlXU6f6LVrYl
         RFTGxUjRKyoLNJamf20TsqafyMmbpOZi/9Fl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997941; x=1760602741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faVDqKCdKWIn3NWkm8sNO3VSI1X3h4Cs5MtO9NYvbBo=;
        b=ghEfzsm9MRSF5i/mgag5a7tXM4YBJqo9/SllXwL1sXa6vLW4FSAsihwiPW1K4096QJ
         Iv1kFqHY1UyRr7sch4Io6Mcgrj5v1Ug4if+63rMVSuH2Y8FvfFKARsEPEXJpvbzGWYvU
         LlCK+3/Rlwg4eVNqYfl4g5e+mY6o0/9ggFoWmp9EXQbsipe3V8JnK7Y+HXoWl8fmjJs0
         owUHV9h4+mM7ZDZ8vXZziS9E5Zxy2mC5i8RA2prxXB3AcHHerTZHbdxfjPYbwoCqeccH
         oLpw4iYzRHlsNQzCu6mqhHAaveoMVWQkZ4h4weoOsN0fVFhlD5Vp74noy7X6FWquIv/i
         dJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfAwodqm4EPq4QOuvf64hTSfjGR6CzemzMfZsPk3bd8WKp9HB0riyhQG58tM2mJ0UFxW0fKgpDWzjmix8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeuEQ1B4kd8/eAD/y0rJMXoV6ROW4IG+pWbRmVH+G+CCuMA83
	cYGgvyufpf+CvS+bXrfm5Hkn4RR7qZXfwSJpqKIITIPmIJqPlebqIHWlQ5gJIfz/0BgxtxYGKpl
	MOzoMDbwvFB/eYW9pliKh02DnbhRaI8bAbw1MLNd2
X-Gm-Gg: ASbGnctFY24RlE8atEDr+3sPV11WTKpccktm7iLQyQ3w8TiX9oN8f0DZiWDUpmwJo36
	dYOCwBX+PI+8JGhHGuxL1Av+yFtRxOALwbVFAgBNUW2om8bj94N0A1DGrNCIZxUlKU1pb38GJNy
	nQWWrKWw8/pKEXsOdtzPTLFR5qQ+3ZNtd0hdyshHOeC/sTbRBfRYgV5Qnlzoqu1G3kksGrzQznx
	tuekb2IHcsewfJnqIbAA4bo9DNPlxwW2aRQiYq3qUGrpyfnmL/DvajBAX9OCQ==
X-Google-Smtp-Source: AGHT+IG8hUHTkL+0dXNTRX/4yTjjacHxUhJpfIwq4JvXFm1KYIbTsH15Oh51ajo74tr7nKhGrgMAEZfz3BlrBGqWW9I=
X-Received: by 2002:a17:903:28c:b0:267:8b4f:df36 with SMTP id
 d9443c01a7336-28ec9cd714amr123635935ad.29.1759997941215; Thu, 09 Oct 2025
 01:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-2-170ed0698560@collabora.com> <2477df4e-c89e-408f-bb2a-d5af51f78ef8@collabora.com>
In-Reply-To: <2477df4e-c89e-408f-bb2a-d5af51f78ef8@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 9 Oct 2025 16:18:42 +0800
X-Gm-Features: AS18NWCTXFo8_XU732GoC_EADGZOvbHUHoSmyBMCpLqt3ZP7mbYJfRNT_Vg0jY8
Message-ID: <CAGXv+5FTg3VXpbav5c2Gx2vRgaC=jYURRp0b5tQGw+ScACRSew@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: mediatek: Refactor pll registration to pass device
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Chia-I Wu <olvaffe@gmail.com>, kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 4:09=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> > As it stands, mtk_clk_register_plls takes a struct device_node pointer
> > as its first argument. This is a tragic happenstance, as it's trivial t=
o
> > get the device_node from a struct device, but the opposite not so much.
> > The struct device is a much more useful thing to have passed down.
> >
> > Refactor mtk_clk_register_plls to take a struct device pointer instead
> > of a struct device_node pointer, and fix up all users of this function.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   drivers/clk/mediatek/clk-mt2701.c            | 2 +-
> >   drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 4 ++--
> >   drivers/clk/mediatek/clk-mt6765.c            | 2 +-
> >   drivers/clk/mediatek/clk-mt6779.c            | 2 +-
> >   drivers/clk/mediatek/clk-mt6797.c            | 2 +-
> >   drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt7629.c            | 2 +-
> >   drivers/clk/mediatek/clk-mt7981-apmixed.c    | 2 +-
> >   drivers/clk/mediatek/clk-mt7986-apmixed.c    | 2 +-
> >   drivers/clk/mediatek/clk-mt7988-apmixed.c    | 2 +-
> >   drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 3 ++-
> >   drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt8183-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 3 ++-
> >   drivers/clk/mediatek/clk-mt8196-apmixedsys.c | 3 ++-
> >   drivers/clk/mediatek/clk-mt8196-mcu.c        | 2 +-
> >   drivers/clk/mediatek/clk-mt8196-mfg.c        | 2 +-
> >   drivers/clk/mediatek/clk-mt8196-vlpckgen.c   | 2 +-
> >   drivers/clk/mediatek/clk-mt8365-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-mt8516-apmixedsys.c | 2 +-
> >   drivers/clk/mediatek/clk-pll.c               | 7 ++++---
> >   drivers/clk/mediatek/clk-pll.h               | 6 +++---
> >   24 files changed, 33 insertions(+), 29 deletions(-)
> >
>
> ..snip..
>
> > diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-=
pll.h
> > index d71c150ce83e4bb2fe78290c2d5570a90084246d..0e2b94b9cd4b56adceee3b0=
4e9ab24c2526471da 100644
> > --- a/drivers/clk/mediatek/clk-pll.h
> > +++ b/drivers/clk/mediatek/clk-pll.h
> > @@ -78,9 +78,9 @@ struct mtk_clk_pll {
> >       const struct mtk_pll_data *data;
> >   };
> >
>
> There's a forward declaration of struct device_node in this header: with =
this
> change, that becomes unused.
>
> Please change that to a forward declaration of struct device instead.
>
> While at it, I'd appreciate if you could either:
>   A. Remove the forward declaration for `struct clk_hw_onecell_data` and =
for
>      `struct clk_ops` (as both come from clk-provider.h - which this alre=
ady
>       includes);
>     ...or...
>   B. Remove the inclusion of clk-provider.h and keep the forward declarat=
ions.

Prefer (B) since no APIs from clk-provider.h are referenced in the header.
It is up to the implementation to directly include any and all headers it
needs.

ChenYu

> After which:
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>
> > -int mtk_clk_register_plls(struct device_node *node,
> > -                       const struct mtk_pll_data *plls, int num_plls,
> > -                       struct clk_hw_onecell_data *clk_data);
> > +int mtk_clk_register_plls(struct device *dev, const struct mtk_pll_dat=
a *plls,
> > +                       int num_plls, struct clk_hw_onecell_data *clk_d=
ata);
> > +
> >   void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num=
_plls,
> >                            struct clk_hw_onecell_data *clk_data);
> >
> >
>
>

