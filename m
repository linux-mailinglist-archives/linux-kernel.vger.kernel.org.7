Return-Path: <linux-kernel+bounces-818960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E992DB598EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FD618848FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99732143F;
	Tue, 16 Sep 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7oRb/Fn"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDC30E0F0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031319; cv=none; b=r8SHfhLYh4PiTPYJPYmqgl/Lq0FdubZKpSOR63ujvojru2JN1TRCz3MWTW/hKYVncC6d7XDyBcor7CDprRMpL4FBO9WXAa7/X1Y8/p8s6J1QG1wnszDZbs51TJjd+WlLYndFQjqqwjy7W458Mya4+JqztfGB8UzSuRfVn/ZuLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031319; c=relaxed/simple;
	bh=jxnqzczZbbOSMi5t02loBOLyXo7kXtt+w3BDV7IeZfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nlt2ru80XRfs/xa/JwClxzw3+mLQ8Bv9FNJhUBuj3CLRVkvp6XQmUrgK/dPPz+YMiHvLQ3meNgJfJo8Rh+aiNhT0TK++sn1/1BWRcODXrHb8S+DIZ1YeRhrIOKJ2ypj8PaemaJ/4nfnSSq/6L2WOuxStMlyXQN1WKXi7Qk9ZEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7oRb/Fn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07d4d24d09so322575866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031316; x=1758636116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1/wO2aa6vwf2RnAiZIcGlD55m2MeNlNGw0Ms6XcA88=;
        b=b7oRb/FngBaBg8MUVyrJJyt3CErG5S7LRVYKHdpUNyqBj5C3NkLGvr0zF/RONe/Snp
         hmYd6LLOygfIAW4q0sU9NW5KpMm8SWEL8xFIuoZgVkqmrk771wKAvfZryrFEydSI20fI
         OwxF97041wPP/MgCpEQzxPzgg3l3BRptyfqLtNZawMQbmvl0tr/o3RQbQQ1/+128bHtQ
         TV+mga7aqVK5MpSbk8srbanZh+UAtOLqZBO0xg4I0A1FniGvilPe4c438ns8r6kDjuk8
         RIQ5WzL/KIR40KyXy04Au3fqVYXoi8pdNHGRmo9/0ZCEdD9LKViODumUAVgTp9ESSOCI
         ODkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031316; x=1758636116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1/wO2aa6vwf2RnAiZIcGlD55m2MeNlNGw0Ms6XcA88=;
        b=POVJfK5Pg+P+RCjTW4nuAfWMLcuZOJbIQSRfSMXzDwjML1wZAfcdmtrvV+BLzu/qJ1
         nPsoK3+bcHmR+3v6kGcF1qFl+p61NdRNysbjMGIX1eXJn86btWTc/NUQu4fBGcWouw0q
         TEYX6SOVRgLHZ5YuTibyFGWIe7ti8RqiHuosdbXg4vpWdnafjqySZt2g3IOwfwx7I2zB
         TwibrFbIkjGahAHAAtsZ39gHYnu2uEF09F/UURVrEVEKS0Ysxcl+OqlvCUT4zTSPFKTt
         4cTKoaag16QoIxcM9duuKjgNynxv0runLwFY3Dq/kGhaoIcPZtgnedoGn2SgKzyIbJfR
         F+ew==
X-Forwarded-Encrypted: i=1; AJvYcCVWCHrfcjRpr3wnwuhhPXpi168OdP+obtyHMmjKNcZl3Mqn8K087B3S7F/6wIL2QzWyr7j316Fc1UwdP4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszNPpJ/CJTjFLhh22pK8lF3K3337Epzqzff4+SY6RZpdOrI8n
	homxnXSlOHPnSLoCgdJCy7VUVP91QqdWKcMogyj3c6lq53dAtJv9pEybMymnqZ8udxuuqx40fRD
	APVrE1Qh0E2PxM2Qqz6v/8HwD+UkGYf0=
X-Gm-Gg: ASbGncshaOHW/QPdQptluzs+yvKLgRjgjyIHhAzzgEaJKHmthB1iNU0rCWeS5Y9VBbS
	VnKZQVxeTcmtQkx2IWP0xQ0/fD50OkUlPKRMIfCgyI9h4ctMNEHThZVoCj29FpbbA7qSjrYZZlH
	wt51PUch7bLNz8C/ukjatwF+Wpu2QJJ/yLyZgojpa4QT6XbDBzAdymSQYIZUE9IxR58IQVDvmh6
	MWBVNRV
X-Google-Smtp-Source: AGHT+IF6Zy4nzr1OXuX8lE0GqEoG4kJn0jZymLRdcAOKhzS2jAVa02oHblL7nubcp0VuU3f+RU4UUOjge2+K+7voqcc=
X-Received: by 2002:a17:907:9629:b0:afd:d994:7d1a with SMTP id
 a640c23a62f3a-b07c3ada566mr1656686866b.63.1758031315726; Tue, 16 Sep 2025
 07:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908105901.3198975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20250908105901.3198975-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aMlgg_QpJOEDGcEA@monster> <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXWVXd5FauMYNq0yXgQa87F4Z9HcGOu2O_ercQg48GNoQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 16 Sep 2025 15:01:28 +0100
X-Gm-Features: AS18NWCVgZqFQH49bSZ6oVph3-y6Eo3LOyTc2vGW-dgo3A64cLzcN5-yV35knnc
Message-ID: <CA+V-a8snd9Qeb_Fbj=_E6Y28EUV-ad+PO=cZcWrZ2F1_RwscGw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
To: Anders Roxell <anders.roxell@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andres and Geert,

On Tue, Sep 16, 2025 at 2:31=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Anders,
>
> On Tue, 16 Sept 2025 at 15:05, Anders Roxell <anders.roxell@linaro.org> w=
rote:
> > On 2025-09-08 11:59, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Extend the Renesas GBETH stmmac glue driver to support the RZ/T2H SoC=
,
> > > where the GMAC is connected through a MIIC PCS. Introduce a new
> > > `has_pcs` flag in `struct renesas_gbeth_of_data` to indicate when PCS
> > > handling is required.
> > >
> > > When enabled, the driver parses the `pcs-handle` phandle, creates a P=
CS
> > > instance with `miic_create()`, and wires it into phylink. Proper clea=
nup
> > > is done with `miic_destroy()`. New init/exit/select hooks are added t=
o
> > > `plat_stmmacenet_data` for PCS integration.
> > >
> > > Update Kconfig to select `PCS_RZN1_MIIC` when building the Renesas GB=
ETH
> > > driver so the PCS support is always available.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v2->v3:
> > > - Dropped passing STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP flag in stmmac_fl=
ags
> > >   as it is always set for all the SoCs.
> > > - Updated Kconfig to include RZ/T2H and RZ/N2H.
> > >
> > > v1->v2:
> > > - No changes.
> >
> > The following warning is seen when doing a defconfig build (make
> > defconfig) for arm64 on the Linux next-20250915 tag.
> >
> > First seen on next-20250915
> > Good: next-20250912
> > Bad: next-20250915
> >
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > Build regression: WARNING: unmet direct dependencies detected for PCS_R=
ZN1_MIIC
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > This is the build warning:
> > WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
> >   Depends on [n]: NETDEVICES [=3Dy] && OF [=3Dy] && (ARCH_RZN1 [=3Dn] |=
| COMPILE_TEST [=3Dn])
> >   Selected by [m]:
> >   - DWMAC_RENESAS_GBETH [=3Dm] && NETDEVICES [=3Dy] && ETHERNET [=3Dy] =
&& NET_VENDOR_STMICRO [=3Dy] && STMMAC_ETH [=3Dm] && STMMAC_PLATFORM [=3Dm]=
 && OF [=3Dy] && (ARCH_RENESAS [=3Dy] || COMPILE_TEST [=3Dn])
> >
> > WARNING: unmet direct dependencies detected for PCS_RZN1_MIIC
> >   Depends on [n]: NETDEVICES [=3Dy] && OF [=3Dy] && (ARCH_RZN1 [=3Dn] |=
| COMPILE_TEST [=3Dn])
> >   Selected by [m]:
> >   - DWMAC_RENESAS_GBETH [=3Dm] && NETDEVICES [=3Dy] && ETHERNET [=3Dy] =
&& NET_VENDOR_STMICRO [=3Dy] && STMMAC_ETH [=3Dm] && STMMAC_PLATFORM [=3Dm]=
 && OF [=3Dy] && (ARCH_RENESAS [=3Dy] || COMPILE_TEST [=3Dn])
> > I: config: PASS in 0:00:01.592356
>
> Thanks for your report!
>
>     config DWMAC_RENESAS_GBETH
>         depends on OF && (ARCH_RENESAS || COMPILE_TEST)
>         select PCS_RZN1_MIIC
>
>     config PCS_RZN1_MIIC
>         depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPI=
LE_TEST
>
> "ARCH_RENESAS" is wider than "ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G0=
87".
> I would just change the latter to ARCH_RENESAS.
>
Thank you both. I'll create a patch updating it to use `ARCH_RENESAS`.

Cheers,
Prabhakar

