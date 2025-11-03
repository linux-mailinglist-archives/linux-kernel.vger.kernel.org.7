Return-Path: <linux-kernel+bounces-882806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0BC2B87E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298E01889B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D1306D3F;
	Mon,  3 Nov 2025 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BikFU/UH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04682306B39
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170857; cv=none; b=G4blcb85XDc7O6EXdaSFOB8AFl/nwW0NNMBtHDDuvYHnGaECl9UwxwJyJW+xs/OgKSoNd+lFKNH3ae73E0mzedWrqQ15AG5lQ+vSLEvB1lhzyzQs6Nzf0hLDD4ZsEpq94itzdf1reRklwFUt3jzQ6c91i++NpZjCNd3J5y1XRYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170857; c=relaxed/simple;
	bh=GhqJi74OJGpd4uiETpEiMG4QL9taE9b0LNg00gB6vzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnufqixVNQXDfz4Kg56TT/HdJ958dvi/I1Zwk3qgv8Yv7PHQ1wDP8ZRBpSGTR4EU7peWM/vcvjh5G+cM6Cbt3p/+R+kPHwrfgSXDM+VYxO8KXDHAeV7eQyThTqjfwQ7A5TKBBIWLBTl0kTSG23o+pn2Jy6ErYuCyvaSZQs7fosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BikFU/UH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so25663625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762170853; x=1762775653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFSaO+zOEDZdbl8gDCFU2lcSYkuFx+hv577jHTEBC/0=;
        b=BikFU/UHMV2mIIELgje32vjyGzzPhTuMIxkLx8De9jKC5JCEFN+St/zoaAOBKqc/ii
         DAulzL1D+JSWs3ex5BNv6VLp0AUH29VK1we6fM8srZppRH02OilYsyyHpqovz3ZnpFVh
         NFwYMy8vl/Hs9QX1E/06Og4rQCoO2ZnroBbLkdWkd4EcncxLL59Wvy6bSwN5GdXye/x/
         B1pRN7hkey+8T6PJu5lxkoFRH+bxfrvPXOu+Dv0QI1GGm4D6/qC47/54XiK475v1WIQw
         7IG+bTgin4NFsibwP9Q37ksBoj8nlG9lhytHoHxGKOH8jbfxzXEM3c0i0DfiFREvvQS1
         4E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762170853; x=1762775653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFSaO+zOEDZdbl8gDCFU2lcSYkuFx+hv577jHTEBC/0=;
        b=m5YlUUcjTGLO30tA0htGO8C3Z66t9u9SDN5wXR1A+L+pmeCuQvwfNEjrICAvpdZDzZ
         YI5uaNzAf9+gknvYr0KAgySaGq9kNs9hGrWtTdkS/HoMf9J6LIe/clKSRNjiqI9GV0T3
         JGOWeLGmrgjnLBonw5LUfJ9Prz0Ua7cdLJFypwK+aKOmFmZP5KQn4X28gODmTwJ91h39
         wZIQT6oGoJ0uJ0YNWvPoazcRzTBxWa1X7S35P7RZRLY1RRUJgPx6lO3+Wu9MLiGzV6v2
         m3iOW03FvES62ukzwMpjjw1f+UeqpcIz7cXen7Yia0Hhe35Pwby3V+00RJnJhgmDYM+q
         w+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfWbK6544D7+V5/47FnU1NRE9z5NtJpzZtDmuMxkVnO6aD7FD3rQ+wJz5yw3i9P02+0Lh8oPhsqJ1PnVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61QFd5dpxP+ejQILgbEUCMbpkPWT7GEyPoWhqgYFIuJjc26av
	ur2Oy5gKYl/Z3snPh3ecBCLWQw+ht8vMVQLaBu+1pfY4cRlInxhvhc1f
X-Gm-Gg: ASbGncsPqmIv0alrScXPOl4R84VIvsb/fNnFf/9TvOk87P7suCjd5IMFVhtAnbbuAkZ
	JlFfSPChG+I6+r1bZ09VdP+SKGH+xvbMJUM7fMf7W4YXygo3oMx+HqCBZHjMISGgEXqJHAuXN+b
	XKamZpmvFSo4AY/HXUTr/qvt6x01B7b5ozNrtDOWOqQIK9LmujdP5aJErKSiU7VUHDIV2VVeIPV
	3nBPU6I8qChlp1wU4Z7GGmKnN7VI5UjW4Zlz/5vmkH0LAdyorU4/5XpZqtJzq0DyRM0GSwNIioC
	0ZnQnMTeFnYcNNEEaQnTkH+5hPXSb+GjGkTt/EoJhhTAsdHFKOSMXav2p5jF/Dfw406dcxYYUDV
	nN8q7JpG5tc+pXVfqNd/tCd6HFrwx6rnDoZy0Rm76WCfA2Scymev4dzkLKwRN6v6gxOCXCUTRF9
	9wdiunl3jTsLUX38SAj9vhAoEh8XHvmaFPdFSBoOmcgOf+l3FuBgTGLnZE5gAVP0M=
X-Google-Smtp-Source: AGHT+IGU/j2S825Y4IdFwrvj+TUIRFhDN8nwfXxpaJr8pAxoK1RsZFXJKmZrLYtzJAJ3QTEk2bCMiA==
X-Received: by 2002:a05:600c:45d3:b0:471:1716:11c4 with SMTP id 5b1f17b1804b1-477308c263amr139612355e9.34.1762170852895;
        Mon, 03 Nov 2025 03:54:12 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d28f2d29sm6772149f8f.5.2025.11.03.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:54:11 -0800 (PST)
Date: Mon, 3 Nov 2025 12:54:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: webgeek1234@gmail.com
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
Message-ID: <pedxgtvzfrfzihoshhfvntin3hwwi3znleilbz4abjad74nowb@un33lgiaa26z>
References: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mr4ndssj2ip5dbdg"
Content-Disposition: inline
In-Reply-To: <20251101-tegra-drm-cmu-v1-1-211799755ab8@gmail.com>


--mr4ndssj2ip5dbdg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: Enable cmu for Tegra186 and Tegra194
MIME-Version: 1.0

On Sat, Nov 01, 2025 at 06:15:17PM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> Without the cmu, nvdisplay will display colors that are notably darker
> than intended. The vendor bootloader and the downstream display driver
> enable the cmu and sets a sRGB table. Loading that table here results in
> the intended colors.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.h  |  13 +++
>  drivers/gpu/drm/tegra/sor.c | 206 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 219 insertions(+)

What does "darker than intended" mean? Who defines the intention? How do
we know what the intention is? What this patch ultimately seems to be
doing is define sRGB to be the default colorspace. Is that always the
right default choice? What if people want to specify a different
colorspace?

Looking at the enum dp_colorimetry it seems like sRGB is the default for
DP at least. But then it says the default is sRGB or ITU-R BT.601, but
if I compare that to the Wikipedia article for sRGB that says sRGB is
closer to ITU-R BT.709 than BT.601. Can we narrow in what exactly the
LUT in this patch corresponds to?

> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0559fa6b1bf70416e51d5067cc04a6ae6572de23..286eddd89a28f7ea9e64c00f0=
3af76f6c68ae9d8 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -447,11 +447,24 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
>  #define BASE_COLOR_SIZE_888    (  8 << 0)
>  #define BASE_COLOR_SIZE_101010 ( 10 << 0)
>  #define BASE_COLOR_SIZE_121212 ( 12 << 0)
> +#define CMU_ENABLE_MASK        (1 << 20)
> +#define CMU_ENABLE_DISABLE     (0 << 20)
> +#define CMU_ENABLE_ENABLE      (1 << 20)

_MASK and _DISABLE are unused (and also quite useless in this case).

> =20
>  #define DC_DISP_SHIFT_CLOCK_OPTIONS		0x431
>  #define  SC1_H_QUALIFIER_NONE	(1 << 16)
>  #define  SC0_H_QUALIFIER_NONE	(1 <<  0)
> =20
> +/* Nvdisplay */
> +#define DC_DISP_CORE_HEAD_SET_CONTROL_OUTPUT_LUT	0x431
> +#define  OUTPUT_LUT_MODE_MASK        (3 << 5)
> +#define  OUTPUT_LUT_MODE_INTERPOLATE (1 << 5)
> +#define  OUTPUT_LUT_SIZE_MASK        (3 << 1)
> +#define  OUTPUT_LUT_SIZE_SIZE_1025   (2 << 1)
> +
> +#define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE	0x432
> +#define DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE_HI	0x433
> +

There's a section in this header titled "Tegra186 and later", where
these new definitions should go. Anything in this section is part of the
old registers (or the emulated ones for backwards compatibility).

>  #define DC_DISP_DATA_ENABLE_OPTIONS		0x432
>  #define DE_SELECT_ACTIVE_BLANK  (0 << 0)
>  #define DE_SELECT_ACTIVE        (1 << 0)
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index 21f3dfdcc5c9576580b9aa9990dd1bedcdeb4482..a381cb35113c0f3191d720430=
2f4024f33141622 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -443,6 +443,9 @@ struct tegra_sor {
>  	bool scdc_enabled;
> =20
>  	struct tegra_hda_format format;
> +
> +	u64 *cmu_output_lut;
> +	dma_addr_t cmu_output_phys;
>  };
> =20
>  struct tegra_sor_state {
> @@ -483,6 +486,180 @@ static inline struct tegra_sor *to_sor(struct tegra=
_output *output)
>  	return container_of(output, struct tegra_sor, output);
>  }
> =20
> +static u16 default_srgb_lut[] =3D {
> +		0x6000, 0x60CE, 0x619D, 0x626C, 0x632D, 0x63D4,
[...]
> +		0x9FE2, 0x9FE9, 0x9FF0, 0x9FF7, 0x9FFF,
> +};

I don't take it there's a way to generate this table? And these are not
standard values that could be shared among different drivers?

You could probably make this a bit more compact by indenting the data
with a single tab and squeeze in 2 or 3 more values per line.

>  static inline u32 tegra_sor_readl(struct tegra_sor *sor, unsigned int of=
fset)
>  {
>  	u32 value =3D readl(sor->regs + (offset << 2));
> @@ -2241,6 +2418,13 @@ static void tegra_sor_hdmi_disable(struct drm_enco=
der *encoder)
>  		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
> =20
>  	host1x_client_suspend(&sor->client);
> +
> +	if (sor->soc->has_nvdisplay) {
> +		dma_free_coherent(dc->dev, ARRAY_SIZE(default_srgb_lut) * sizeof(u64),
> +				  sor->cmu_output_lut, sor->cmu_output_phys);
> +		sor->cmu_output_lut =3D NULL;
> +		sor->cmu_output_phys =3D 0;
> +	}
>  }
> =20
>  static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
> @@ -2255,6 +2439,7 @@ static void tegra_sor_hdmi_enable(struct drm_encode=
r *encoder)
>  	unsigned long rate, pclk;
>  	unsigned int div, i;
>  	u32 value;
> +	u64 r;

This can be moved into the branch to narrow the scope.

>  	int err;
> =20
>  	state =3D to_sor_state(output->connector.state);
> @@ -2557,6 +2742,27 @@ static void tegra_sor_hdmi_enable(struct drm_encod=
er *encoder)
>  	value &=3D ~DITHER_CONTROL_MASK;
>  	value &=3D ~BASE_COLOR_SIZE_MASK;
> =20
> +	if (dc->soc->has_nvdisplay) {
> +		sor->cmu_output_lut =3D
> +			dma_alloc_coherent(dc->dev, ARRAY_SIZE(default_srgb_lut) * sizeof(u64=
),
> +					   &sor->cmu_output_phys, GFP_KERNEL);

You need to check for failure, otherwise you might NULL dereference the
pointer below. But then it's probably even better to allocate this at
probe time so that we can guarantee that the LUT can always be set.

> +
> +		for (i =3D 0; i < ARRAY_SIZE(default_srgb_lut); i++) {
> +			r =3D default_srgb_lut[i];
> +			sor->cmu_output_lut[i] =3D (r << 32) | (r << 16) | r;
> +		}

Given that this was taken from the downstream driver, this is probably
correct, but I'm not sure I understand why the same value is written to
the LUT thrice. Do you happen to know?

> +		tegra_dc_writel(dc, (u32)(sor->cmu_output_phys & 0xffffffff),
> +				DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE);
> +		tegra_dc_writel(dc, (u32)(sor->cmu_output_phys >> 32),
> +				DC_DISP_COREPVT_HEAD_SET_OUTPUT_LUT_BASE_HI);

You'll want to use the lower_32_bits() and upper_32_bits() functions
like we do for other address values (see hub.c, for example).

Thierry

--mr4ndssj2ip5dbdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkIl94ACgkQ3SOs138+
s6GSZg/+LYKyi7bOzLQ+gvTI+ufc1uZQP0fUhZK42gnn8cOdu7foHLKwQWXBYITe
ICLlUgR7tafZIoLAmnhaozGdlChzpBURHfPp7+wF8+CUZgnp2iuCgt6ekbF8sE8W
fq11DwRtGHNXxy2exNlQLtA6su9NIbnEScVxAiPmKcGAqGk3EHMHe5UXhH53zFcK
hYbO4dj5oaziGw8qT5gOQUYuFFWwvb/59aXvQj2aDPjjPSfWtA/44q9bN3KvMGD1
YluQS0GYMn+PZbu2ScbyiBlJI5yXNQCaI9Y9upgyD1XOhS3wTS1ePf7R8C8RX+hN
gJLO/HyCzYxfjNbP2jeFStDumRmCxO6VCONEByq9G6dwwpSxn+HggFeAk9GTjL7X
zFa/gGOkIBlRdNv/XgSDGOhCKk4A3U5+ToxPxD/1e2ewCYuWm84aA+Drb97K6xUm
6k7QefDUF+Kc7m5z4UW+IaKEmGv8FRDJfjUAtSU9Rq8rZORtHcQhNlnSKlRVTbGC
vy1zRFGcLBUfj1OFeT1fqGpQCZ3EHjyHcFY2J00i1JYay/zO7kSxQ03tSPkYaK07
JautY+NPe7DWLNh3q31GAPrA7k87oKbWByuWs8aM8/lgtLE6VnZUCbwn3iv4RlW+
C9ayS80bouTMsOJDnCW8KYyT1Ta1rzz5Pt2cX92LetWibQkUYYk=
=19vb
-----END PGP SIGNATURE-----

--mr4ndssj2ip5dbdg--

