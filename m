Return-Path: <linux-kernel+bounces-739429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB4B0C635
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E912318867BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CC2DAFD9;
	Mon, 21 Jul 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwUqWgJh"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1072DAFCA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107839; cv=none; b=OPISBT/ibnVV3Yw0sUK4GAWbbrim7q6oeFtZHMNeLmBqaJ1YdRmhiktDcwRB5kBw8bCEp3OPC54FMP5Aq0zkof2FRqqOvoILrl5/aD/11fp7l68kIE2lOO6GhLQ/1DnJZMVCB26F+CNCqzYE4XM1kuH/kjhdiza79EXAnwb2f+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107839; c=relaxed/simple;
	bh=9UWeOXuEiJg9VoDu4+qGBOxg4g4hjfQ2KqGwyAhrNtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLUNP011pQABN82tNGQlJ5JlLlecW+dtm6IUQo+uq+gzqMJ8fJURynUp6evfO0LnWSO5iiL0ruEatN9eRnTOfpXDRK0+nTkRIaOzGZnFENFTM+ahbrO1dk4xmdcsNvV6kFSwVCrMmfx4ZVwcDWtnRhdCtjKT2iO12a12ptKozrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwUqWgJh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so7112251a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753107835; x=1753712635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SEyx7mXp0CBN5U4A0GlAKryjyrraw4ilP0q5c6hZVxA=;
        b=cwUqWgJhQ7B2kIOfwkb+btBbx4JJaJCGrZATUSC1WR+DClfnZaEMXToo+lrlKBNIQT
         m/N5Zi90S91dhub2KSY1aw4y/ZHZDg6nZDEvuBIvk+5A3rF9Q8vJZqq6F3LFBhyXRheT
         avH+xB5HJv6w1md0JPWUSKCavVZyNSdkF0UCi5+NByRE0SUTklVaHZ+bPtvqF/OFfdOg
         8cEKE0NkEU6vT/hkl8Z98cyR/kQqofjUy8WnVf++jIEVFEvzp5CqSQQ8ltzY6HhKNv9O
         kQwGZ1PuSjbbsAt2hx8Sd+OLPBPS37ImVP9YK/lDLz9UpoCSb/L5EeynvPGorjRxoEun
         jq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107835; x=1753712635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEyx7mXp0CBN5U4A0GlAKryjyrraw4ilP0q5c6hZVxA=;
        b=gRoCzPg3muj3x3WqzTH2IKyZ47LpEmoKIT+r9J/G0H+hqd0prCXskZ3Eh/B31FbbDU
         rLuToX3VcvGHCmzar21B+WPmZFKacbaHP5eJ4XSgUZFRjsNxgLxvRPJr4uZEYn0TUYSX
         JoHBpK9Z69lf/Qc0E/vpwDS8beedhDLyaQWRq58PQQbrQzVzbRF4HVSM4Qco1dKpL1ss
         KGCTTVaZzMqJ68PKMe9jBz0ABDSNQTiJ3V7gAgzVeE1AYGFq6kzu4gnGUGJTmQndvuhK
         0hBKcYQmAvZmd9Qw08EHFkJrAvf7cp1nvwGZnc3IvVwG0HUHooSJnz8Ot/mmA7SpLoLR
         u1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRfMigcl9Rd3KtJqjEow1eWxE4gL1/l5lMvq9gv0qHw16GiSFCT+E0Es+YpSL/hl4Up7ZJ6hcDoU2rjH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnKrW+5fv/zCAPAa3lMo71qNrE1xrnAVIIxGhCkysKJ8NOaJG
	aFjjcSQPxXa+V2mHVOuW3mkuefYxGzsFTRa26bOc7ES+lztsWmuiUH7YnYqjQ4ndU1rAUxuCFd7
	S3eOTmSsS6DeM/l8uGevMQJpIw8TOar2yxZLwGhDrhQ==
X-Gm-Gg: ASbGncsUlJIQwGgTWZjZ2xo7ZrVOY8bjmtG1oejE8TT/mUNKEILnma6ygIE/9KUheWb
	Yy4rOJ5LL+UC0r7oV8ytXvomudU2SLQcQKIC7nYEAjnQaSMF9DkHf24HBfSnoDAdTKJejbliQB6
	mv5Yhhqul084Ew3gAYrh14ISS1fjqbHrMw84X+Xc35pAwxzG7azseRop7MP9Q1K3IN79HQi8JZl
	oBb3o+0l24dtQNFLkx9oy0TZc1hzqzsU2wsmv9soQ==
X-Google-Smtp-Source: AGHT+IHor38rIn1pKQ8nwqf0yJIzbBDIXbeXdkm2JdEKFu+t76hq+Bk4KT28Qumkw/JEGQLQ2XhgOcoW88Ao9YcH/5g=
X-Received: by 2002:a05:6402:1d55:b0:612:b057:90ab with SMTP id
 4fb4d7f45d1cf-612b05793femr13050702a12.17.1753107834605; Mon, 21 Jul 2025
 07:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-imx95-rproc-1-v4-0-a7123e857dfb@nxp.com>
 <175224423523.783161.17907302929832941912.robh@kernel.org>
 <PAXPR04MB845959EF2767C96794EAE6DD8854A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <aHkNS51jgV5ulsNB@p14s> <20250718082033.GA25126@nxa18884-linux>
 <aHp-_BRk7Iz81OFp@p14s> <20250721041823.GA4844@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250721041823.GA4844@nxa18884-linux.ap.freescale.net>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 21 Jul 2025 08:23:42 -0600
X-Gm-Features: Ac12FXyw4hdh1l-EicP3Q_nexU8h_sXbH3xvX_eih-XxJ9DgAS3dub9_bfFRYgM
Message-ID: <CANLsYkwZz4xLOG25D6S-AEGFeUBWwyp1=ytmu2q90NyEpkoX9g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] remoteproc: imx_rproc: Support i.MX95
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Frank Li <frank.li@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 21:08, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> On Fri, Jul 18, 2025 at 11:06:04AM -0600, Mathieu Poirier wrote:
> >On Fri, Jul 18, 2025 at 04:20:34PM +0800, Peng Fan wrote:
> >> On Thu, Jul 17, 2025 at 08:48:43AM -0600, Mathieu Poirier wrote:
> >> >On Mon, Jul 14, 2025 at 11:52:05AM +0000, Peng Fan wrote:
> >> >> > Subject: Re: [PATCH v4 0/5] remoteproc: imx_rproc: Support i.MX95
> >> >> >
> >> >> [...]
> >> >> > New warnings running 'make CHECK_DTBS=y for
> >> >> > arch/arm64/boot/dts/freescale/' for 20250710-imx95-rproc-1-v4-0-
> >> >> > a7123e857dfb@nxp.com:
> >> >> >
> >> >> > arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dtb:
> >> >> > scmi (arm,scmi): Unevaluated properties are not allowed
> >> >> > ('protocol@80', 'protocol@81', 'protocol@82', 'protocol@84' were
> >> >> > unexpected)
> >> >>
> >> >> Same as replied in v3.
> >> >> This is because [1] is still not picked, not because of my patchset.
> >> >
> >> >I won't move on this patchset until this is resolved.
> >> >
> >>
> >> Not understand why hold on this patchset. I suppose you may not
> >> understand what the error means. The warning is totally irrelevant
> >> to this patchset, there is no dependency.
> >>
> >> Others added a property to arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
> >> &scmi_bbm {
> >>         linux,code = <KEY_POWER>;
> >> };
> >> But this "linux,code" property not landed(missed to be picked up) to DT binding.
> >>
> >> This patchset does not touch scmi_bbm. I could help address the warning
> >> in the other patch, but I do not see why "linux,code" under scmi_bbm node
> >> could block this patchset.
> >>
> >> Please help clarify if you still think to hold on this patchset.
> >>
> >> BTW: with [1] "remoteproc: imx_rproc: skip clock enable when M-core is managed by the SCU"
> >> merged in Ulf's tree, there is a minor conflict with patch 2. Please suggest
> >> what I should do with this patchset.
> >>
> >
> >I was afraid of that.  The best way forward with this work is to wait for the
> >"linux,code" property to be picked up by Sudeep.  I suggest you make sure that
> >he, or anyone else, picks it up for the next merge window.  If that happens
>
>
> I respect you as maintainer, but there is no reason to block this patch
> because of "linux,code" property. It is totally irrelevant.
>
> Even if I help to resubmit that "linux,code" patch, there is no chance to
> land into 6.17-rc1, both Sudeep and Shawn sent their PR to arm-soc earlier
> before your comments. You could raise in V3.. which there was time left.
>

I don't know what you mean by V3.

> >everything should be set for you to resend this patchset when 6.17-rc1 comes
> >out.
>
> Because of the code conflict in Ulf's tree, I will hold on until 6.17-rc1.

Exactly

> Patch 4 and 5 will be removed from this patchset in V5. The two patches
> should go through Shawn's tree, I will resend them in a separate thread
> with "linux,code" patch included. There will be no more CHECK_DTBS
> warning in V5 for i.MX95 remoteproc support.
>

That is a better way to proceed.

> If you have concern on patch 1-3 or else, please raise earlier. As of now,

If I remember correctly, those patches looked fine to me.

> patch 1-3 in V5 will be almost same as V4 with only a minor code
> conflict resolved, with below change
> @@ -1030,7 +1030,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
>         int ret;
>
>         /* Remote core is not under control of Linux or it is managed by SCU API */
> -       if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
> +       if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API ||
> +           dcfg->method == IMX_RPROC_SCU_SM)
>                 return 0;
>
> Regards,
> Peng
> >
> >> [1]https://lore.kernel.org/linux-remoteproc/20250629172512.14857-3-hiagofranco@gmail.com/T/#u
> >>
> >> Thanks,
> >> Peng

