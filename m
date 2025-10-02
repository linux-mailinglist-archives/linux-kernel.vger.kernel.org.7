Return-Path: <linux-kernel+bounces-840816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC38BB57C0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A10619C362D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82942512D7;
	Thu,  2 Oct 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oaGJQ4Tx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B43BB44
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440964; cv=none; b=JL480s/iYlGWBOCtotJPut6ESsGxioaZfRGsEU6AbtMRKiH710jawa86rTdd/TjDycw8RPtN7+eQpmUQMFKc1PnRRIWu1+tP+J6yC8oB8EqGTSKe3K1C1mY0+PlkxwLN8CMX5NA9dg+D5vNG40NRe5t8oOQUAiG9w6+cA6188tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440964; c=relaxed/simple;
	bh=zMeuhyrGmKv3Vy1hEV7bUGE0hRvsTCbCldYPgrOEYKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5fqPtDcSH5NEg6gMHsNWDH4DwWgFlhwfiu/KnoH0SMwjEARBy7Kax4qSLX94IPvrNMnDkZoOlSNS9jSfb+mvtQ/A8tbOF5pcmB8GpEJlhexV/MEokFV0kPD0as9lsGQbaQlmZHXcIkxfbTlu3B2x3TnhxTGsN2hUDIq4Y4V/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oaGJQ4Tx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-271067d66fbso14416885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759440957; x=1760045757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tb5ZhFKHgn3PI0RL+wA56er2lYPRbzxVlrU7xzkMbM=;
        b=oaGJQ4TxaVJP4SaFW/7mmbQhsfmutQZ7UciR5XT6swi7+/XlGIFH2Bp1QHr9UaPMV6
         uN8SClKGOlRJhUkmwntzwLknmPy+C5vrbAFpEqVEXuklnvQZB367RG5namUmMrMxTdIm
         Qp8pCQ8kkRyKcvqXBdbnVhcVRDD00rz48CD9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440957; x=1760045757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tb5ZhFKHgn3PI0RL+wA56er2lYPRbzxVlrU7xzkMbM=;
        b=Skg0ArNANP69JD1SSSFo9QghIhu0CQbulqLKWSjMQ0Y4rrxW6/kL6VLZEwu0i4j71U
         v73OXgCsirhsYxNTKIX3RLdWdV8zdvPPRXnOMWp0AnOiCEtj2ZdtdDYCUCZYVJbv3SW+
         HsIRYHmndBqsyzPb5U80DZn4ZJKptLC+iMmg2QMMwXek8tMDFWxDfEt2qGwFuWxnunVc
         5bXMXu9DJHZMPZleWkE0mXQ1TPocm+hbbTxC6Yom/9fzYgiA5qGQRunpgwLpwBoFAd7E
         KUjRhpiHEEaqpZtc19Z+R3X4RrHUhjsEUQSzkuuzqGJJw1ehCIT6ttRtssyqO7XUbNB5
         ZBfg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRjk9YX8xsZO7Q6Lt0s55ppxYKrDfqWgr0vKCUwYktW4aiecpwtkoj7fZ+J0LStHHBA7c+KI6suMars8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MhO+Z+thftUEkfDKx5Jv/+xkpUEWZNIDv4Krq8aFf3GLyN3U
	mo1Ng3tTJA5yGxrYUkNuIjEZdJ//KJEXsHGauG8PvaitNrv1kLhX8WjGAuHS+6H3+To0NlnqGn3
	QJu8=
X-Gm-Gg: ASbGncs/Qp6GcLjK3d0XoQBh7lkbev0GLCV9IHH+ag4iCIebHCgYVnsH8aH+0/XQ+4k
	uNYD8uW5OFRg8HbOzpRGqW+PFd1EKP1SjFiH/mRLrEIozb2SodHwb0WjavWMflKDdu6DQhAMTbz
	3V1mj1oWaIhshaqKkLELnpBsiZserIR63twICtUfnyt1wQhh9TxtmIVajoBvdGNTpanwJnWcw5F
	9o1xh+1jKOrOmAVwoHupUdTjbn0djmcwbP3o/PVy8NuxpgbliBtfnk18S+HjthFsHaAJyWt7CZg
	LI+XDznEUZxpseD3PGrK4TkNU+WYvhknjvFvUrmG7T6rC2H1pDpIpBPXD/NYNGG0GTtIG41pevY
	PBFya74Tx9c+ToCkJQSvBegpAjIwasaCeuYhz1gnyvQANUdyli4/dCR4h8AwUf+9IUW9UTJGOqU
	Oe5Z9Or2IYncEryg==
X-Google-Smtp-Source: AGHT+IHQrNr0Es/V98xa2sfZ8iPWxYIQGJAQuYb8mndeQza0yOzruoOGboVIWszZBsOsprdDFjPifw==
X-Received: by 2002:a17:902:cf08:b0:24b:4a9a:703a with SMTP id d9443c01a7336-28e9a5eaa79mr8822105ad.17.1759440956838;
        Thu, 02 Oct 2025 14:35:56 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d111b3dsm30385805ad.10.2025.10.02.14.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:35:55 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-271067d66fbso14416015ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAOvWAjAuZXoqFzT5XLZA2CmqtJe/Wcxq4eYOiHo+8TtMlpUwTbOIbwsi7UQD7OyL5OuAGZovQiK+jwno=@vger.kernel.org
X-Received: by 2002:a17:902:ebca:b0:265:604c:17e7 with SMTP id
 d9443c01a7336-28e9a6ff040mr7217865ad.60.1759440954340; Thu, 02 Oct 2025
 14:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-2-clamor95@gmail.com>
 <CAD=FV=Vd=muLeMJYszC2SqRBThN=Srm_bKXBEmjjqND7bqHo2g@mail.gmail.com> <CAPVz0n23qNrnyP7ttchaCoLit=gBm_++7RX7B8MxR_nx+8LGHw@mail.gmail.com>
In-Reply-To: <CAPVz0n23qNrnyP7ttchaCoLit=gBm_++7RX7B8MxR_nx+8LGHw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 Oct 2025 14:35:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCcQ1AweLwNucYP8kNHx+K1UF=VbEZdqE4hXN=bHqGuQ@mail.gmail.com>
X-Gm-Features: AS18NWCyCoeGl8UyyLw_R0kuFN-88oe-Wi6XpVX99MGsfcmrycek7SZgv1oi908
Message-ID: <CAD=FV=UCcQ1AweLwNucYP8kNHx+K1UF=VbEZdqE4hXN=bHqGuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] dt-bindings: display: panel: properly document LG
 LD070WX3 panel
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 29, 2025 at 10:03=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
> =D0=B2=D1=82, 30 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 06:12 Do=
ug Anderson <dianders@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi,
> >
> > On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmai=
l.com> wrote:
> > >
> > > LG LD070WX3-SL01 was mistakenly documented as a simple DSI panel, whi=
ch it
> > > clearly is not. Address this by adding the proper schema for this pan=
el.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/display/panel/lg,ld070wx3.yaml   | 60 +++++++++++++++++=
++
> > >  .../display/panel/panel-simple-dsi.yaml       |  2 -
> > >  2 files changed, 60 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/l=
g,ld070wx3.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/lg,ld070=
wx3.yaml b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yaml
> > > new file mode 100644
> > > index 000000000000..0a82cf311452
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/lg,ld070wx3.yam=
l
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/lg,ld070wx3.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: LG Corporation 7" WXGA TFT LCD panel
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: lg,ld070wx3-sl01
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vdd-supply: true
> > > +  vcc-supply: true
> > > +
> > > +  backlight: true
> > > +  port: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - vdd-supply
> > > +  - vcc-supply
> >
> > I suspect you'll get a NAK here because you're not preserving backward
> > compatibility for existing device trees. While there can sometimes be
> > reasons to do that, you'd need to provide a very strong justification.
> >
> >
> > It seems like instead of breaking compatibility you could just have
> > two supplies:
> >
> > * power-supply - The name for the "dvdd" supply.
> > * avdd-supply - The name for the "avdd" supply.
> >
> > ...and then you make both of them not "required". Maybe you'd add some
> > documentation saying that things might not work 100% correctly if they
> > weren't provided but that old device trees didn't specify them?
>
> Schema describes hardware. If it does not (and in this case it clearly
> DOES NOT), then such schema should be adjusted according to hardware.
> If there are any users of such binding, they should be adjusted too
> (third commit of this patchset does exactly that). Panel datasheet is
> explicit, panel has ONLY vdd supply and vcc supply, names are taken
> from there too.

I'm more than happy to defer to DT people on this, but the general
argument is that "device tree" is supposed to remain forever forward
compatible. In other words, someone could have taken a snapshot of the
"tegra114-tn7.dts" device tree at any point in time and then shipped
it in some BIOS. Presumably the old "tegra114-tn7.dts" (for some
reason) managed to init the panel properly in the past and the idea is
that there should still be a way to init the panel with the old device
tree now.

Obviously, that's an ideal version of the world and sometimes
hard/impossible to make a reality, but it's supposed to be what we
strive for.

From a more practical standpoint, the dts changes and code changes
will go through different trees and so making them mutually depend on
each other can leave people broken if they happen to have one patch
but not the other.

I suppose one way to handle this (if DT people like it) is to keep the
bindings the way you have it but then add some layer of backward
compatibility in the driver. It will mean that anyone with the old DTS
would officially not "validate" properly against the new bindings, but
I think that could be OK as long as it was explicitly mentioned in the
commit message. Obviously, though, DT bindings reviewers would have
the last word there...

-Doug

