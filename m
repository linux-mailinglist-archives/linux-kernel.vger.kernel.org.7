Return-Path: <linux-kernel+bounces-786923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CDEB36DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E153362DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E42C3248;
	Tue, 26 Aug 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1RtzjXp"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E52C0F7C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222659; cv=none; b=F6w8Yyht/x6bJxnEolcT5VX1Z/2KF5LXM5SnMICuDBc9Ao9s9tA0ghtrA8VQBJ2VSnTeBA7Jp3ogDKe4iTIH+GnopX9YRmwfcV4Je9/mf9YqP4s0hv2cWCaLA5iyi8vA/ZOg86gykx0NACVB3rSDkxWcJ5nwM6qJEqaVlQe5ROg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222659; c=relaxed/simple;
	bh=OEA06nTeAUGwpAIDsE1dzLbzSs+2hxTR5wfFGk+yki4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9ridU2HC8Cr8cFudBGDK4NZBVmjTMaXOEOAfGUM2vgVwwrfF2Di7VVUil0N8DW9yjSKJcIj/Z+5ejIsbmjEEYr7N35H3g2kN3fZeZnALnTMXAxNCuxiTbjJphS08saf35No9NLCQFls12ALXu4/wzBLyrpD/WUELpkk1ZSrl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1RtzjXp; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70ddadde48fso3163536d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756222657; x=1756827457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVabfoeTRalARdFdnvAT75q/NwmfuXUfzr/tmDDydBM=;
        b=T1RtzjXpDN4CuE3xqOIE6vNDLflVeawOsXty1KZe9zHHAjHKsrKwh4u6B89wOK2cFB
         93n15bwHjtgUJTZwUhAjNoa18mUz9Gfm4Opf13nkj+ToumHHCng0I05uvE0r/dTvNtA6
         68lOP6Qcx25bReHt+9N6luG+rQCT0qGQ55HpVuhBcMwJgughGlMOPDjXdepOz8mw2qII
         2k0/qpPtkKhTHRCnRL91OqQH3ujpb5Iwn1rB8lPIYBXlGIzCP4H07Id/e/I7f2NeVxNh
         3ln7S4J0BaOBeugfgM0Y8e2kJ8QHC3AcEeAJf1NcXLpgIuutbYlwpbMqV7g0sKhj81+E
         11zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222657; x=1756827457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVabfoeTRalARdFdnvAT75q/NwmfuXUfzr/tmDDydBM=;
        b=Q1kTbMcv4FN5BC5AP7Vh95OMi64/SCGNin/1se2m6gzk3/2NnesIlSd0VrCXlXzk7l
         eAGmwRlYg2j92kMCSAYbcoGUDbdg42DSAfdAK3I/IfLiYgBZ5kf3Ao+LwFFomVc+ZrvM
         Epe4jC9qSjKaXTYBZ6xdpm0snyF7RM06fPGA/5ZJ1fR+2lemeJizRVSISBiLQ9l9KwkK
         9yB1Iq4zD98W4JpGGI8cQsXNvtLqTdgSGfNmxcXa4EAFWm/BWBuUjyHI8WcFgbFwE68N
         IKDmFTnwfTUhK/KWaUSaRbKcJ/2XoQ2lLft0bzZUqV0NxDci3uxM0ydMO1RWUS90hWK7
         8f2w==
X-Gm-Message-State: AOJu0YyF6Q/KdHOqdJefFNQ9WE1JMmYIhacf2Evt7Ay65d1CNe6KH2Dq
	v/Qo5qHH2i8/9gWjmitPXFsewSkZB3rz3RgjKmSbkLhjmDez279QaFM+966lPq1cwsljqCuSL79
	jAeIyadidzDDPvhfftyEGJa+f4voSt7kK11oAlIszm2aCay/W2t8auZIp3Q==
X-Gm-Gg: ASbGncsFVDmEv0D5tA7+awa0A+WpN6yVerTaFcsIReOiyaRW8wyXrH1ANT/9cGFa5UV
	3vDvAz4YxSTADQIi9c5GyXO9fcZuI/gLVlUvqtrYw6EJa5dRKuCc1N5sSs5JkX3rp+uZx35HqIs
	xlwtI8j0YVlo6j7RXtw51b37fF9gDmnAqNDdTv+ZCjhdZsAe3OMzPmLVU+MyGg2ytZkKUy7Epgl
	nFKwJg=
X-Google-Smtp-Source: AGHT+IGn4/HsaQzBgXtTuWAP/lpgRhFuhANcsb2aUMcUAyUN7Db8Yk7JceHH1d57Q+3kX/MnS38N0ue+12CYe+gWZKk=
X-Received: by 2002:a05:6214:c65:b0:707:4539:5183 with SMTP id
 6a1803df08f44-70d970980e6mr168020966d6.5.1756222656452; Tue, 26 Aug 2025
 08:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826093725.2432153-1-ajye_huang@compal.corp-partner.google.com>
In-Reply-To: <20250826093725.2432153-1-ajye_huang@compal.corp-partner.google.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Tue, 26 Aug 2025 23:37:23 +0800
X-Gm-Features: Ac12FXw_ibROh4a5HKwjNDJ18I2fbCE2E5fZrhUQZkVnB9izMMIgm1fAL4Zqo_4
Message-ID: <CALprXBaHBivkJfEUaMq0zV3nycidSJheGOVXaOhwFTi0iiQhqw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: SOF: Intel: WCL: Add the sdw_process_wakeen op
To: linux-kernel@vger.kernel.org
Cc: linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Mac Chiang <mac.chiang@intel.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Based on the suggestion from version 1,
I forget to add the tag Acked-by: Peter Ujfalusi
<peter.ujfalusi@linux.intel.com>  in the v2.
I will send the v3 later, thanks


On Tue, Aug 26, 2025 at 5:37=E2=80=AFPM Ajye Huang
<ajye_huang@compal.corp-partner.google.com> wrote:
>
> Add the missing op in the device description to avoid issues with jack
> detection.
> Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for WCL")
>
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
> v2: Add Fixes: 6b04629ae97a ("ASoC: SOF: Intel: add initial support for W=
CL")
>
>  sound/soc/sof/intel/ptl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/sof/intel/ptl.c b/sound/soc/sof/intel/ptl.c
> index 1bc1f54c470d..4633cd01e7dd 100644
> --- a/sound/soc/sof/intel/ptl.c
> +++ b/sound/soc/sof/intel/ptl.c
> @@ -143,6 +143,7 @@ const struct sof_intel_dsp_desc wcl_chip_info =3D {
>         .read_sdw_lcount =3D  hda_sdw_check_lcount_ext,
>         .check_sdw_irq =3D lnl_dsp_check_sdw_irq,
>         .check_sdw_wakeen_irq =3D lnl_sdw_check_wakeen_irq,
> +       .sdw_process_wakeen =3D hda_sdw_process_wakeen_common,
>         .check_ipc_irq =3D mtl_dsp_check_ipc_irq,
>         .cl_init =3D mtl_dsp_cl_init,
>         .power_down_dsp =3D mtl_power_down_dsp,
> --
> 2.25.1
>

