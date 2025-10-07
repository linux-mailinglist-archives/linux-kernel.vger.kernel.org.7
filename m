Return-Path: <linux-kernel+bounces-843766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76771BC0321
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 021DD4ED9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8D200BBC;
	Tue,  7 Oct 2025 05:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSBR0j+/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D51E7C23
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814661; cv=none; b=expNhFM6OBejCgJHrDHyOztnK6xX5wH/UcuPvgJ9HVQNPaN9bvtTeNpPX+4e+TKV0DVaceoFyQore7fTS6g/+nTxjvAzxr/meMvnX1dHoeuGJ3j/SWebLTR2BmE6S2+PWCg9uK30W0f8N82vcxn8S6uHxOdgPe7R/OfgKRMVqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814661; c=relaxed/simple;
	bh=03ukawHLBBiuq3lXimxzPdIM3F7QbvULRv7gKC39Z/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/zHtbHsz05cBJeEB6OL7Sg9t9ZnRaY/StSlFbuNsZjzXTj0elSM/q+bEfVBicXcSwn7Ngec81Ctx+41dbEqgjX2OPcNajI+C96WNMCkkk5aZA+0pmmYgkNHyeT2IiHuy/XtjDJJHiPKZ/YELdrS3ZMp36+pxXzQEgk1tFRM2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSBR0j+/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3514157f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759814658; x=1760419458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLnHbmNpMD4epIcKjnyPaJrpyCwbEXYNf6ehl6bEb60=;
        b=TSBR0j+/M7cfPExgvPBQqJVH4ou6kac2FBJG4KDVhNfVkhbILOKx8wBRumLyrqFDEG
         TOr3GNpr/qeWqiSrKpMonQoeNlou7eVqBLkmJc0xS4URvCpaYLstJRw/Ark5Eubqqvoj
         AhnRQU5mqjbdOV+qlqSy111etQooFm3hHSEwB44UIm+CU9mKc2RucVyRxzscUyCKSK4M
         C1rWH8Z93Lxwbw6KdJhqtdQMPBDwomNxxDhBOiE9VuCGanrQ4Cq20QRmk1EAcOT3wF2i
         NZu0JDfZ6VY8FTJQ2xUIUNNt79yTtE29usrIPWZ+p+FP32eAsLMMlCzLmq4juHSJQ1zZ
         DB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759814658; x=1760419458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLnHbmNpMD4epIcKjnyPaJrpyCwbEXYNf6ehl6bEb60=;
        b=slsmHiol63gu5NcNW7uorPl9GsbBcPtWwBpAU+yVYWo14yQF8CO1kkkG5PO/AYpOPs
         7qbul+hV7l1A/rjtey6TbsqsPUqtf1ibSVC6Ujvs+hFTINC0SL1JfndEzK3Hoj2RaqhP
         loolLDLxTPssJslxXKtF+7UsdJuzt1mZuFil5ePrWy+ErYHq9+O23A1tcg7K15kwxEX9
         MhaHPWwLz1+syj5gfS4eHvxQzDnPV/ItiBScNcixBy5env5IY93+i3pNuMMwkLJP7a8P
         TDHlOgYq1n/7UBWY4LylDY5hXlRxemdLXKViuRWsj1LDrqyyzoIQl0lwdIdInd+LCQoN
         3PAA==
X-Forwarded-Encrypted: i=1; AJvYcCVTgVqlPvgHWK/n3FZsIgoOWHbYavNeQsklwMfqEMOxDvMPJBqSwzhRGHd+G0ufD4tzAyOqYhDQ65Cvius=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29ofgAcibpJZP7qfC9HnzZbCAqN8pERLmMVPXZE/HRCsy5axJ
	+FCra9JmY1V4aJCM14uIqq339qKLL+Ky6B7QoW1hM69yIf3quoH8GbvVy+aLQz+nfiWmaNAtrop
	+o9fLEY1C/TuCtVt6pli30+JRYG0i4vk=
X-Gm-Gg: ASbGnctNIptbEgczyJH+iQDz0dnt+idj4vRBmZcDADHiNwkG60cFFAnOKNAqoHaFfK6
	GKn1mLp7OVrTeFd2FPk2nM4hxsX0b1tLLmdKlWZrcfaWo6HGWM5hI50ibWWt5bL+hvWqTdXDcTP
	/SrO7p7DZo3RJVP/lrGF7B2EBUBqEn3k+nZvqmSyL1389oRWbWUAytEIFrMLd32DcoSJiMlI7VX
	WvCIOpAMA7oRU9bjHxmwHlixT5zcHjJ
X-Google-Smtp-Source: AGHT+IEqm1Cnm5JSU8P7+erEx9aLkQi3brzS+KjxKcgqGgPXKaswgBRSqgdDnMzPTqldRk/rKa7ILjK4DFwNEE+3/5s=
X-Received: by 2002:a05:6000:24c4:b0:3f4:ad3f:7c35 with SMTP id
 ffacd0b85a97d-42582a0534bmr1024206f8f.27.1759814657634; Mon, 06 Oct 2025
 22:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-2-clamor95@gmail.com>
 <CAD=FV=Vd=muLeMJYszC2SqRBThN=Srm_bKXBEmjjqND7bqHo2g@mail.gmail.com>
 <CAPVz0n23qNrnyP7ttchaCoLit=gBm_++7RX7B8MxR_nx+8LGHw@mail.gmail.com>
 <CAD=FV=UCcQ1AweLwNucYP8kNHx+K1UF=VbEZdqE4hXN=bHqGuQ@mail.gmail.com> <20251006221308.GA653118-robh@kernel.org>
In-Reply-To: <20251006221308.GA653118-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 7 Oct 2025 08:24:06 +0300
X-Gm-Features: AS18NWDToXA58gus5hDUvN4FNyaQ6Lgn-00bI-Bbb3jdyK_JaChVX5A0PwIJW1E
Message-ID: <CAPVz0n0VfjW_=E9oM0FAhjqzAQnPXaL40gDqOsz2mwBaaA_0Fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: display: panel: properly document LG
 LD070WX3 panel
To: Rob Herring <robh@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 7 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 01:13=
 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Oct 02, 2025 at 02:35:42PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Sep 29, 2025 at 10:03=E2=80=AFPM Svyatoslav Ryhel <clamor95@gma=
il.com> wrote:
> > >
> > > =D0=B2=D1=82, 30 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 06:1=
2 Doug Anderson <dianders@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@=
gmail.com> wrote:
> > > > >
> > > > > LG LD070WX3-SL01 was mistakenly documented as a simple DSI panel,=
 which it
> > > > > clearly is not. Address this by adding the proper schema for this=
 panel.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  .../bindings/display/panel/lg,ld070wx3.yaml   | 60 +++++++++++++=
++++++
> > > > >  .../display/panel/panel-simple-dsi.yaml       |  2 -
> > > > >  2 files changed, 60 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 Documentation/devicetree/bindings/display/pan=
el/lg,ld070wx3.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/panel/lg,l=
d070wx3.yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.=
yaml
> > > > > new file mode 100644
> > > > > index 000000000000..0a82cf311452
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3=
.yaml
> > > > > @@ -0,0 +1,60 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3.yam=
l#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: LG Corporation 7" WXGA TFT LCD panel
> > > > > +
> > > > > +maintainers:
> > > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: panel-common.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    items:
> > > > > +      - const: lg,ld070wx3-sl01
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  vdd-supply: true
> > > > > +  vcc-supply: true
> > > > > +
> > > > > +  backlight: true
> > > > > +  port: true
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - vdd-supply
> > > > > +  - vcc-supply
> > > >
> > > > I suspect you'll get a NAK here because you're not preserving backw=
ard
> > > > compatibility for existing device trees. While there can sometimes =
be
> > > > reasons to do that, you'd need to provide a very strong justificati=
on.
> > > >
> > > >
> > > > It seems like instead of breaking compatibility you could just have
> > > > two supplies:
> > > >
> > > > * power-supply - The name for the "dvdd" supply.
> > > > * avdd-supply - The name for the "avdd" supply.
> > > >
> > > > ...and then you make both of them not "required". Maybe you'd add s=
ome
> > > > documentation saying that things might not work 100% correctly if t=
hey
> > > > weren't provided but that old device trees didn't specify them?
> > >
> > > Schema describes hardware. If it does not (and in this case it clearl=
y
> > > DOES NOT), then such schema should be adjusted according to hardware.
>
> The priority is:
>
> 1) ABI
> 2) describe h/w accurately
>
> IMO, if there are 2 rails on the h/w and you have 2 supplies in the DT,
> then you have described the h/w. names are less important.
>
> > > If there are any users of such binding, they should be adjusted too
> > > (third commit of this patchset does exactly that). Panel datasheet is
> > > explicit, panel has ONLY vdd supply and vcc supply, names are taken
> > > from there too.
> >
> > I'm more than happy to defer to DT people on this, but the general
> > argument is that "device tree" is supposed to remain forever forward
> > compatible. In other words, someone could have taken a snapshot of the
> > "tegra114-tn7.dts" device tree at any point in time and then shipped
> > it in some BIOS. Presumably the old "tegra114-tn7.dts" (for some
> > reason) managed to init the panel properly in the past and the idea is
> > that there should still be a way to init the panel with the old device
> > tree now.
> >
> > Obviously, that's an ideal version of the world and sometimes
> > hard/impossible to make a reality, but it's supposed to be what we
> > strive for.
> >
> > >From a more practical standpoint, the dts changes and code changes
> > will go through different trees and so making them mutually depend on
> > each other can leave people broken if they happen to have one patch
> > but not the other.
> >
> > I suppose one way to handle this (if DT people like it) is to keep the
> > bindings the way you have it but then add some layer of backward
> > compatibility in the driver. It will mean that anyone with the old DTS
> > would officially not "validate" properly against the new bindings, but
> > I think that could be OK as long as it was explicitly mentioned in the
> > commit message. Obviously, though, DT bindings reviewers would have
> > the last word there...
>
> That's fine, but then I prefer we keep 'power-supply' as deprecated.
> Then if we ever validate that drivers only use documented properties,
> it would pass. We already check drivers use documented compatible
> strings, so that wouldn't be too hard to do.
>

Sure, but ATM there is only one user of this compatible in the
mainline Linux kernel, which is Nvidia tablet Tegra Note 7 and:

1. Node used in its tree is addressed in the third commit of this patchset
2. Its panel is broken anyway since it cannot init properly if
bootloader does not leave a pre-inited panel, it cannot suspend
properly and it has a loose regulator which relies on always-on
property rather then being hooked to the panel.

I can assure you that besides me there seems to be no one interested
in this tablet.

> Rob

