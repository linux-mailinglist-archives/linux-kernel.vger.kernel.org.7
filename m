Return-Path: <linux-kernel+bounces-896421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735AC5053E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3073B1AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217FB199949;
	Wed, 12 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d70eHzPX"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195722301
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914035; cv=none; b=rBeZPyNd3B1IlffaGOY5KtMPkhb53hJXsRc0cad4Gm8DTTb9a9GaQGmDmOF2VmD+5mnT6DxCVO12JsgVpPykco0D7jN50lEMEcBOGREJgiKjcLbWdEYyEutLM61heBvmz4td9vB3W9gYSgM949ruwKtP6nChxFFZryfWZHLpWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914035; c=relaxed/simple;
	bh=vgXKVXLg5ka/gs4146ICOeO84aHJl7Kla8+sb4iHUbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MntOK4Lv32o1Ldi1BAgDZ2ifJ+0RBea4/V/gKfgsArQk/ZK5uSIK6E8zGGKWlirnszB0xeo/KuuVfYF15EhKVPa3V5bHF0NTpB90Vk0DcySeo7bLXJmTn0lXGItgmzPwjYaLfgBIqYGQm6WW8H7XvY/VIO9Ncf2PICE2fDBUpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d70eHzPX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so328452a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762914032; x=1763518832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxUF+h7S30BNbJmH4g7pCp3lBzmymefVuj0S5lsfjbg=;
        b=d70eHzPXyCN8qyAfCjGLQ+WwqXGswhEERM7yfeyWfPz/j/3UexR2fKVTmLaJRZpeGk
         pSgzY2A9H2tAHjizQqv2atpT8TMLu60BQO0wXlolEPsMUsycHXvYNIPDUFVmq327HuWD
         xhFQ9pvQrOecJXeeKrQYBkv0VvTAOHqlOGtogLobztqqpTPS9UCVQA7Auycv+B/FBxgJ
         k8bu+pXak9gzPW1Hr08aWus8WnNcLQilb50Ikgm2Nn7izeQDEYY8r6wFGW+OgFrZXWdf
         BcK8A10fk2LMB6I80RaZYurMms0I2ZcJNTyonNbLmUuaN5c6uAZAv87YUjrVHTHe8sHz
         CnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762914032; x=1763518832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxUF+h7S30BNbJmH4g7pCp3lBzmymefVuj0S5lsfjbg=;
        b=lcvHKL9UitEI7/Do4uIyvzs3xqpZSNBFi7ke94lbpUU9C9w1Z1I21tm9Jijdi13y63
         fdB1uIEsLJw5b0UYNFBmpDraDjgSh94aBap/XZhFx3Ce67o6Ds4mmOEDmybvTOe80ZBz
         KjuozgcKtz4P/gLVFlp53ybtHUIdFLViyzjvAg/xo3l/zJDYKL0XgT0Vagkz9fM9JqbT
         Yy7lCH5uhhQw3r98N3U+NNaCqs5ZzhyPZYOZcKtKI8olWdKrgXlDCec+k1TR6QZf1TIp
         rmv0Hft5ey7AuRmXspwkZzopiCUPEqcrujU/TlhSLOVpfUMVW5jpOLsCx77/6oyUQ+nf
         bEkA==
X-Forwarded-Encrypted: i=1; AJvYcCUcc8L23ktUzmtyfihB8vPi6K7b4RmE5EqijmecSMrBz4P8+sLiOStgWLA8qFiMopvBxSEtk9HXrW7CkcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPCX/4eQfzxZNuubUjeDWxbS2+EkWqFVpq0MiWWcPohpK0f9J
	wdlD9nHImT5/CTd3MeElEGoFfLGpJRwSHg9JphQmPv87zbCCJuxsJPdriRng7pnNX1eLFO/kdTk
	VPOLxba6Kcyu7M+fW16/aNbCLVjrWSUE=
X-Gm-Gg: ASbGncuE4XFNbqVcLv996W6mjoDyTBc9R7wNOICJSQiemM47h4cnGTzChNMlkBvQ5pl
	r/DZ/HfNcrOtkZYTLOYY3ckX1PcJwxSgSerKLwbMvNH/vb1eomwAkRkfhzp8OD+8kAnytqoa4My
	aPGDNzjyCFZL6o354h6tnTKx6kx8+Fl4f9FlQbBoO4IbdzzT40uHNLrIDwtCJGw8RncOLsGepQr
	shHkYS9QaVWZAZiLt9NdBxjdF4V1CAyiNbpW4lIAkQsplxGt4yGuESV23X+
X-Google-Smtp-Source: AGHT+IFtc6HQrz/xKZ9emyb5FEGlT0SRf+ATUq6DWBXr3zYhujoZ6/yNyjXJ5nXZWWbTjr5BzqbESW0tw1NXrAGBcT8=
X-Received: by 2002:a17:90a:d88b:b0:340:be4d:8980 with SMTP id
 98e67ed59e1d1-343dde27552mr1630702a91.14.1762914032513; Tue, 11 Nov 2025
 18:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
In-Reply-To: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 12 Nov 2025 10:20:20 +0800
X-Gm-Features: AWmQ_bk8d1h8tBpBrZUtGjow-hV3gnwT5P-EgH-CH9iaE3RQY3pwj7BwDScJKrc
Message-ID: <CAA+D8APHUZmP8qfta4=YL200hJkiikru8yQPddvBZyx-+-1ZtQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] drm/bridge: imx: Add HDMI PAI driver on i.MX8MP
To: Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	victor.liu@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn

On Tue, Sep 23, 2025 at 1:30=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> acts as the bridge between the Audio Subsystem to the HDMI TX Controller.
>
> Add HDMI PAI driver on i.MX8MP to make HDMI audio function fully work.
>
> changes in v7:
> - add back the mutex which removed in v6
> - add Tested-by tag from Alexander.
>
> changes in v6:
> - remove mutex in dw_hdmi_set_sample_iec958()
>
> changes in v5:
> - add empty line commit message for patch 7
> - remove blank line in dts node
> - add component_unbind_all when dw_hdmi_probe return error
>
> changes in v4:
> - separate dts for soc and board
> - bind hdmi_pai with hdmi_tx by moving some code to .bind() and .unbind()
> - add "select DRM_DW_HDMI" to fix build error reported by test robot
> - remove unnecessary code/definition in pai driver
>
> changes in v3:
> - add space and 'U' in asoundef.h
> - add more commit message for binding doc commit
> - add bitfield.h header for fixing build error
>
> changes in v2:
> - address some comments on commit messages
> - add two more commits:
>   add definitions for the bits in IEC958 subframe
>   add API dw_hdmi_set_sample_iec958() for iec958 format
> - use component helper in hdmi_pai and hdmi_tx driver
> - use regmap in hdmi_pai driver.
> - add clocks in binding doc
>
> Shengjiu Wang (7):
>   dt-bindings: display: imx: add HDMI PAI for i.MX8MP
>   ALSA: Add definitions for the bits in IEC958 subframe
>   drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
>   drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958() for iec958
>     format
>   drm/bridge: imx: add driver for HDMI TX Parallel Audio Interface
>   arm64: dts: imx8mp: Add hdmi parallel audio interface node
>   arm64: dts: imx8mp-evk: enable hdmi_pai device

Could you please review the above two dts patches?
Thanks.

Best regards
Shengjiu wang

>
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  12 ++
>  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      |  69 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  27 ++-
>  drivers/gpu/drm/bridge/imx/Kconfig            |  11 ++
>  drivers/gpu/drm/bridge/imx/Makefile           |   1 +
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c  | 158 ++++++++++++++++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  65 ++++++-
>  .../drm/bridge/synopsys/dw-hdmi-gp-audio.c    |   5 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  18 +-
>  include/drm/bridge/dw_hdmi.h                  |  11 +-
>  include/sound/asoundef.h                      |   9 +
>  12 files changed, 382 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx=
8mp-hdmi-pai.yaml
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
>
> --
> 2.34.1
>

