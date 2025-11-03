Return-Path: <linux-kernel+bounces-883531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9D8C2DB52
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BDB3B90D5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9C12D249A;
	Mon,  3 Nov 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXieAiy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9551A7AE3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195213; cv=none; b=fhXf3GCJqylg8GFpF+bXh81+fHBwZLlDr4jsRMJxIMUH4pXnYbCsKmO+E1gOJi67oT/6fr8oTEu/b9ABXuosNJnHdxLqZVvTDKPoi4/Yj53oHtf/IhB6EzsaLdF8cAgN1hFmUsh/ZvUjyYeZAS7Nu0wJo5kU/+zpYCEQR2p6hEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195213; c=relaxed/simple;
	bh=e9mHAwxMs2+tM0PKaRjItovNxkGXbAcTSL/R5300xjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn2Z80e/ErVTjgFXapuRzPmgCEPMkQLUW3aoHhm63qSqAfj+fSvpcABspSCMJi9n3YjE4y8vVwfbMfqKlY0Wkf2+x7VhbqeDEg3DqBAEHNHF8Gyp0hcbKdUXJWTf7ChJMPnl3slMKkDHwjMd/0C7jO1JJhJz8VlwY1eNzt/dGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMXieAiy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59310014b8eso4745185e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195210; x=1762800010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjg0NORPD0YzwL4UUD+8RwP+2UOFcZACYrXvQ2r4HyE=;
        b=AMXieAiyrKVLfcKDOVYw5ygteqyc3y5u1ri+u7tsJCzuZZg6jQc48Y/GY8TSFwhn4d
         QbpmpufkpucXSF85wdhSgNbwB3tyAyvwlu/OsRaQ370Jtgm2UAHkS37bhDDm5Rx2pSli
         /Zin6pAmurhIPnICZowTCA3CGFpcK/lz47cCZ6hpn9wIW1ifpJzQsM0zLQ4v5PtX67uh
         iPt7lGh99Gtwgqz+X3FF+hLQY4jrX4QoxJGKuAlDTKMtSe79kj+2362mHG1iLsk8Mx41
         GyJ6ZWDvbnOsb8aWzjUJeMW9O0VxeACwO4s/yptzqNQG1NWqIcOyzQNI6AEcfYWT5+iO
         JU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195210; x=1762800010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjg0NORPD0YzwL4UUD+8RwP+2UOFcZACYrXvQ2r4HyE=;
        b=R2YU02FVMGXGjpctwk7YZNpxFkS+2x0riH50lZNqHNSy5UJTIqpPeKxnrPsR11lN64
         W0eKgeCRT8MJnQdv5Y9hJnHm9xGOGtkzVo1+zq076GeAbdu9ODFpURo0BwS8Yz7hlHNV
         uhMtPpThLWWMfQiKW2xMAhn54Ph6ZikI5iHAnnu1W9mBb+sCllEVM0zwTQS7wIiAJAuf
         0chRMWSRcwW3PIjd6xYtpKSv+8COJf4NwagxFiepnU39aGag934m31quGI1zgshN8yhg
         iRT5eYhZo5jDobbLo3U2XK3dGvxgLj7dFThdLjEOs3Xf2VKwDH3hYJSP8lIvyBC/bP3v
         HOyg==
X-Forwarded-Encrypted: i=1; AJvYcCVeY9TKJA9fsyI3nf39JIyxjN4IlT4nlt7BOG7TKWZBFSUSSdygtzB/iesK13LFnTd76t3SzgauQFnf2M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7O8bNGZtbPMbTNvjQq9mr6jMpLwmGQaOY6FslllmliHGXK0HJ
	7KtcPCF9GDU0Ii1n50Gx1Y2dL93hJ8JE/2QjUNjlT0BBC3tiItHPNRLensyNXreAu5cwL+NCkwl
	g99bX0sW/Tuh8HqkGa0Wi4YiS2QVONag=
X-Gm-Gg: ASbGnctuS1n63akR7RT5nXG7iz9nFqJjhjM0LXie9hKa5Zk3ffv3zUDhNS5nqiz15J2
	0e5nS0xkOJfHiH1XG8Mmb4mvdk+Meqva9p/jZqpNQOrzs2Zcf3/gcBrqsN2dtOll1+rek8DW/bE
	u7UipUw9RMGFLd64WyxcMaJEl2gPEMmq/cyYw4QuZOLno2CatBrJVPKwdEzZX94YR9By5OiUb1b
	gw/FCsfltAY8tX4ndAT5/C01upqIVWLoOxz5xoE+fqPjlcGg91KnzrXlG4U
X-Google-Smtp-Source: AGHT+IHrf8InG0YVbUPJlQOpnMRHCWVus3nqEpRvI8vqF+TG6Uh4sODD1cviMuv9p58GAy7Gm7Gozb3SPZgLNqd21ko=
X-Received: by 2002:a05:6512:3047:b0:594:2d64:bd0f with SMTP id
 2adb3069b0e04-5942d64c00fmr1202652e87.16.1762195209578; Mon, 03 Nov 2025
 10:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com> <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
In-Reply-To: <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 3 Nov 2025 12:39:57 -0600
X-Gm-Features: AWmQ_bkmrKbleFAu7ESCM5Htipr7i0Mg_ld8nr47Ao7g3e6yS9xY-p2wo60fwAI
Message-ID: <CALHNRZ9-XrMUkQE0cwjq-HUYsy5uerhOQ9sNpirp23kKoaPuYw@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:54=E2=80=AFAM Thierry Reding <thierry.reding@gmail=
.com> wrote:
>
> On Sat, Nov 01, 2025 at 06:15:17PM -0500, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Without the cmu, nvdisplay will display colors that are notably darker
> > than intended. The vendor bootloader and the downstream display driver
> > enable the cmu and sets a sRGB table. Loading that table here results i=
n
> > the intended colors.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dc.h  |  13 +++
> >  drivers/gpu/drm/tegra/sor.c | 206 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 219 insertions(+)
>
> What does "darker than intended" mean? Who defines the intention? How do
> we know what the intention is? What this patch ultimately seems to be
> doing is define sRGB to be the default colorspace. Is that always the
> right default choice? What if people want to specify a different
> colorspace?

I reported this issue almost a month ago. See kernel lore [0] and
freedesktop issue [1]. The pictures in the latter show what nvdisplay
looks like right now. It's nigh unusably dark. When booted into
Android with a tv launcher that has a black background, as is default
for LineageOS, it is really hard to read anything. Is it correct as a
default? Well, cboot hardcodes this, so... presumably? It would be
more ideal to expose this and csc to userspace, but I'm not sure if
drm has a standardized interface for that or if tegra would have to
make something vendor specific. I think that would be a separate
change concept compared to setting this default, though.

> Looking at the enum dp_colorimetry it seems like sRGB is the default for
> DP at least. But then it says the default is sRGB or ITU-R BT.601, but
> if I compare that to the Wikipedia article for sRGB that says sRGB is
> closer to ITU-R BT.709 than BT.601. Can we narrow in what exactly the
> LUT in this patch corresponds to?

I really don't know. While trying to fix the broken colors, I came
across the same table in cboot [2] and the downstream tegradc driver.
Cboot was released as a tarball with no commit history. And the
tegradc commit history did not have any further clarification beyond
'sRGB'.

> > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > index 0559fa6b1bf70416e51d5067cc04a6ae6572de23..286eddd89a28f7ea9e64c00=
f03af76f6c68ae9d8 100644
> > --- a/drivers/gpu/drm/tegra/dc.h
> > +++ b/drivers/gpu/drm/tegra/dc.h
> > @@ -447,11 +447,24 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
> >  #define BASE_COLOR_SIZE_888    (  8 << 0)
> >  #define BASE_COLOR_SIZE_101010 ( 10 << 0)
> >  #define BASE_COLOR_SIZE_121212 ( 12 << 0)
> > +#define CMU_ENABLE_MASK        (1 << 20)
> > +#define CMU_ENABLE_DISABLE     (0 << 20)
> > +#define CMU_ENABLE_ENABLE      (1 << 20)
>
> _MASK and _DISABLE are unused (and also quite useless in this case).

Fair. I was trying to match the style of the rest of the header, but I
can drop the unused defines.

>
> >
> >  #define DC_DISP_SHIFT_CLOCK_OPTIONS          0x431
> >  #define  SC1_H_QUALIFIER_NONE        (1 << 16)
> >  #define  SC0_H_QUALIFIER_NONE        (1 <<  0)
> >
> > +/* Nvdisplay */
> > +#define DC_DISP_CORE_HEAD_SET_CONTROL_OUTPUT_LUT     0x431
> > +#define  OUTPUT_LUT_MODE_MASK        (3 << 5)
> > +#define  OUTPUT_LUT_MODE_INTERPOLATE (1 << 5)
> > +#define  OUTPUT_LUT_SIZE_MASK        (3 << 1)
> > +#define  OUTPUT_LUT_SIZE_SIZE_1025   (2 << 1)
> > +
> > +#define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE     0x432
> > +#define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE_HI  0x433
> > +
>
> There's a section in this header titled "Tegra186 and later", where
> these new definitions should go. Anything in this section is part of the
> old registers (or the emulated ones for backwards compatibility).

I figured there had to be a section for that somewhere, but my
searches failed me. I see it now and will move.

> >  #define DC_DISP_DATA_ENABLE_OPTIONS          0x432
> >  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
> >  #define DE_SELECT_ACTIVE        (1 << 0)
> > diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> > index 21f3dfdcc5c9576580b9aa9990dd1bedcdeb4482..a381cb35113c0f3191d7204=
302f4024f33141622 100644
> > --- a/drivers/gpu/drm/tegra/sor.c
> > +++ b/drivers/gpu/drm/tegra/sor.c
> > @@ -443,6 +443,9 @@ struct tegra_sor {
> >       bool scdc_enabled;
> >
> >       struct tegra_hda_format format;
> > +
> > +     u64 *cmu_output_lut;
> > +     dma_addr_t cmu_output_phys;
> >  };
> >
> >  struct tegra_sor_state {
> > @@ -483,6 +486,180 @@ static inline struct tegra_sor *to_sor(struct teg=
ra_output *output)
> >       return container_of(output, struct tegra_sor, output);
> >  }
> >
> > +static u16 default_srgb_lut[] =3D {
> > +             0x6000, 0x60CE, 0x619D, 0x626C, 0x632D, 0x63D4,
> [...]
> > +             0x9FE2, 0x9FE9, 0x9FF0, 0x9FF7, 0x9FFF,
> > +};
>
> I don't take it there's a way to generate this table? And these are not
> standard values that could be shared among different drivers?

I don't know of a way to generate it. As mentioned above, this was
copied from downstream.

As for sharing, I don't know. If I read the tx2 trm correctly, the
display pipeline goes through a input LUT, which is not currently
enabled by tegra-drm, then into csc, which expects some 'linear
colorspace'. Then that outputs into the output LUT, which is labelled
as the cmu, which is expected to translate from that linear colorspace
into the colorspace expected by the display. Given that this LUT
generates expected colors on my displays, I assume that the pixels in
the pipeline are in that 'linear colorspace'. I'm not sure if that's a
standardized thing or something nvdisplay specific. If it is the
latter, then the table wouldn't be useful anywhere else.

> You could probably make this a bit more compact by indenting the data
> with a single tab and squeeze in 2 or 3 more values per line.

 Ack.

> >  static inline u32 tegra_sor_readl(struct tegra_sor *sor, unsigned int =
offset)
> >  {
> >       u32 value =3D readl(sor->regs + (offset << 2));
> > @@ -2241,6 +2418,13 @@ static void tegra_sor_hdmi_disable(struct drm_en=
coder *encoder)
> >               dev_err(sor->dev, "failed to power off I/O pad: %d\n", er=
r);
> >
> >       host1x_client_suspend(&sor->client);
> > +
> > +     if (sor->soc->has_nvdisplay) {
> > +             dma_free_coherent(dc->dev, ARRAY_SIZE(default_srgb_lut) *=
 sizeof(u64),
> > +                               sor->cmu_output_lut, sor->cmu_output_ph=
ys);
> > +             sor->cmu_output_lut =3D NULL;
> > +             sor->cmu_output_phys =3D 0;
> > +     }
> >  }
> >
> >  static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
> > @@ -2255,6 +2439,7 @@ static void tegra_sor_hdmi_enable(struct drm_enco=
der *encoder)
> >       unsigned long rate, pclk;
> >       unsigned int div, i;
> >       u32 value;
> > +     u64 r;
>
> This can be moved into the branch to narrow the scope.

Ack.

>
> >       int err;
> >
> >       state =3D to_sor_state(output->connector.state);
> > @@ -2557,6 +2742,27 @@ static void tegra_sor_hdmi_enable(struct drm_enc=
oder *encoder)
> >       value &=3D ~DITHER_CONTROL_MASK;
> >       value &=3D ~BASE_COLOR_SIZE_MASK;
> >
> > +     if (dc->soc->has_nvdisplay) {
> > +             sor->cmu_output_lut =3D
> > +                     dma_alloc_coherent(dc->dev, ARRAY_SIZE(default_sr=
gb_lut) * sizeof(u64),
> > +                                        &sor->cmu_output_phys, GFP_KER=
NEL);
>
> You need to check for failure, otherwise you might NULL dereference the
> pointer below. But then it's probably even better to allocate this at
> probe time so that we can guarantee that the LUT can always be set.

Moving alloc to probe and free to remove makes sense. Less thrashing
that way too. Will do.

> > +
> > +             for (i =3D 0; i < ARRAY_SIZE(default_srgb_lut); i++) {
> > +                     r =3D default_srgb_lut[i];
> > +                     sor->cmu_output_lut[i] =3D (r << 32) | (r << 16) =
| r;
> > +             }
>
> Given that this was taken from the downstream driver, this is probably
> correct, but I'm not sure I understand why the same value is written to
> the LUT thrice. Do you happen to know?

I do not, no. I wondered at that too.

>
> > +             tegra_dc_writel(dc, (u32)(sor->cmu_output_phys & 0xffffff=
ff),
> > +                             DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE)=
;
> > +             tegra_dc_writel(dc, (u32)(sor->cmu_output_phys >> 32),
> > +                             DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE_=
HI);
>
> You'll want to use the lower_32_bits() and upper_32_bits() functions
> like we do for other address values (see hub.c, for example).

Ack.

I will stage the code review changes, but will hold off on sending a
new revision. Pending any additional changes coming from the
discussion of the concept in general.

Aaron

[0] https://lore.kernel.org/all/CALHNRZ_vMy1CTosZ=3DymOhAyMNRh+oBOU9NJ8Gvr8=
EkqQ5XjFDw@mail.gmail.com/
[1] https://gitlab.freedesktop.org/drm/tegra/-/issues/8
[2] https://github.com/LineageOS/android_bootable_cboot_common/blob/034b04d=
3ac7f2f80d72e3b894d97da4f6e2cd591/drivers/display/nvdisp/tegrabl_nvdisp_cmu=
.c#L24

