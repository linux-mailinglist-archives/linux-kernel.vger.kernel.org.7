Return-Path: <linux-kernel+bounces-892711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C43ABC45AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F2024ECE48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C62F7AA2;
	Mon, 10 Nov 2025 09:31:55 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499121CC64
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767115; cv=none; b=KO0KojtVwfx+++XCXrHN684Pxgu4GOpx1rzSiGkgTNrssjHi0HXCgynzoJqM7rx6HD/0zsSHN2PBpc+Bf1nDnEiJI2WKoM24v44+YQ34K+9JpM1D7Wp62KJlsA0mNzca3eeJxhmSU32f58AeSEvd4PP+sNVN11RGcUtR4uI9hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767115; c=relaxed/simple;
	bh=/fJzjpPCho25zV5kgp+Mt+JXbM7T0RiVyjwGWi7iCBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApgY/6uGLXBoWUb0kp9rpNbhbsi2YhGW3nzb/AxiSIWhrRQKU97ehoSvx3AuGzT6kkMpovERmQI+/sTLoghtWaShBZsOlfr8ION4RqtlbmUFU8P0QjiO12dWu3X0enoZ2/QbgocEd4vFzbmdC9F8e0faCUDXEZaYeV7swqaPyv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-93728bac144so896081241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767112; x=1763371912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRtPdzI1Yw78zykFlB0XCziKqeVOXzigJtW+jsiVzcI=;
        b=Yq9x9y4C1Eqx1NZgv+VyFC9xsm9aIv0HP/HHWPbuS3eCNfxFDHIuZ0LjTFljgAiZZp
         vSFTVc0MjTq3u1+3HF2qBPqzQQX2lzkORHE/OSueyHda+UtcHxNAb9711TCP0aoY371v
         9dioTZYzTISJW8xiFqgDlG75GM/CXYu+ANIcqOAm6JK0TymGfQmwH9YfLUk6pI89uFtn
         wLO8B8CrytmLVdSkfObGsOz5Xn0tyFMtkghhRdk4vYWv4yTLcTw1j7HMR8Ru5C237+0/
         pabKR470Jlj8Rxth71qpKxYbStk+t6PtCigDCVEkHedjd6C7//hrVFabOXGUgqmX46by
         i1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXoIkQewBgtUJBh8XQv0A1045nXGBGMlOV8vjPA81Vy2J16r4mbhLtsDZw+FWj88mvz/nSmxVe1IhbtSEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOe4V0Lo5SM+NE6tZz6llLOrex/oyrlUCZY7Bk//f16hZsI+3
	eHASaKp3391H9KD9LtSCMUu+BKVVr5uQhelHFNBqyMAKP7fLJpiyz3jdpI97kzpN
X-Gm-Gg: ASbGncsAwmoPAnsAg8xVM4I9y5oA6NWwDaUIhWgQurufgVcOHiS/R1yk5ZrvycdeSch
	BsRP2dnlzemYKSoImLJyhw1ZYJCAaT6luR/6m82o7FlkcI5Z28HWGDsD8r+YOri3jZod1cvwFCR
	tuL/jVU1++lBVMEas8Rgw3lbtbHDE7A9BCSm5jLbebkVUEQQ27x/f4cF5PyGlwctJstwC4qCxU4
	m2FiMo5JQ0LF0Au2VRIDC3x8eJMrozrNkEucVzU7TTozFqEV4zvMKLR1+nRCdQSTVK0g714IWks
	80jT8PaJ8rsC9pKhtNdXXFqb/fryVNcO/of1QnvAwGCk1gQ5n7AuQc4QdVJz10tvD6IenuflgJf
	F9/DIZHTeAIbu1LiEJuDQvWxySXh6YI3faGnJYqZvgQqnbiojnlbt3yPpbl8cDwumFK5NvQMYY5
	WYf/FgJ7aym9h+5e6xjfTHkZhN3gUWNOGNQhNGopxwOBCjpA+zr0ka
X-Google-Smtp-Source: AGHT+IG5Vp0xzxbCiYDpAa+JVIHtZeOL1Se1ib3jhgG2rrdY7Y5iwBn2y6Yi8VKjcbIbRcn5WN0s0g==
X-Received: by 2002:a05:6102:2ac7:b0:5db:d07c:218e with SMTP id ada2fe7eead31-5ddc47e44e7mr2429135137.41.1762767112365;
        Mon, 10 Nov 2025 01:31:52 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dda1d06baesm5554719137.2.2025.11.10.01.31.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:31:50 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-937268fe284so895365241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:31:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeU/8tJmTYHjmRNDB2iaDGvQI0fDgB2MiNwTNZ0dZbOGPnFuhNZsjOK+zljuX1x3rEOmZwt2God1R0HZ8=@vger.kernel.org
X-Received: by 2002:a05:6102:c04:b0:520:dbc0:6ac4 with SMTP id
 ada2fe7eead31-5ddc46497a0mr2779273137.2.1762767109934; Mon, 10 Nov 2025
 01:31:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107-b4-m5441x-add-rng-support-v2-0-f91d685832b9@yoseli.org>
 <20251107-b4-m5441x-add-rng-support-v2-2-f91d685832b9@yoseli.org>
 <CAMuHMdWL76hY-Pv30ooSM1J6XkVWbRXSLTDCjfpPOvhFN4tKyA@mail.gmail.com> <12779401.O9o76ZdvQC@jeanmichel-ms7b89>
In-Reply-To: <12779401.O9o76ZdvQC@jeanmichel-ms7b89>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 10:31:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW26uKBUnYB5c3XAzKPKFVGNoOOwra_u_NOjPCV20Y-AA@mail.gmail.com>
X-Gm-Features: AWmQ_blSVM0mC21k2j7-_pQqo1T8ZhoFgD5EPrlyILfYI73Lumvke_itdhGi4eY
Message-ID: <CAMuHMdW26uKBUnYB5c3XAzKPKFVGNoOOwra_u_NOjPCV20Y-AA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: coldfire: Add RNG support for MCF54418
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

On Mon, 10 Nov 2025 at 09:34, Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> Le lundi 10 novembre 2025, 09:15:11 heure normale d=E2=80=99Europe centra=
le Geert
> Uytterhoeven a =C3=A9crit :
> > On Fri, 7 Nov 2025 at 11:29, Jean-Michel Hautbois
> > <jeanmichel.hautbois@yoseli.org> wrote:
> > > Add platform device support for the MCF54418 RNGB hardware with clock
> > > enabled at platform initialization.
> > >
> > > The imx-rngc driver now uses devm_clk_get_optional() to support both
> > > Coldfire (always-on clock) and i.MX platforms (managed clock).
> > >
> > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/char/hw_random/Kconfig
> > > +++ b/drivers/char/hw_random/Kconfig
> > > @@ -270,12 +270,13 @@ config HW_RANDOM_MXC_RNGA
> > >
> > >  config HW_RANDOM_IMX_RNGC
> > >
> > >         tristate "Freescale i.MX RNGC Random Number Generator"
> > >         depends on HAS_IOMEM
> > >
> > > -       depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SLL || SOC_IMX6=
UL ||
> > > COMPILE_TEST +       depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SL=
L ||
> > > SOC_IMX6UL || M5441x || COMPILE_TEST
> > Is the same RNG present in other Coldfire SoCs?
>
> According to the RM, it is only present in MCF54416 and MCF54418.

I guess that is sufficient to make it depend on COLDFIRE?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

