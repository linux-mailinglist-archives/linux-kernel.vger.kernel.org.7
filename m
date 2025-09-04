Return-Path: <linux-kernel+bounces-801044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE703B43F28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F8E1890027
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4130F817;
	Thu,  4 Sep 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WR+j4onD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FBd4BEaS"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0F30AAD2;
	Thu,  4 Sep 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996424; cv=none; b=YxdhxFOk52f+9mtLwx7OXrlYqqphY/YNlnx8dYU2CeZgT79k5qH6etpZPAHLB59a38DlecpqQTX1MBnuEoSGS/t9meGgG6FeAwuirKo7ElqX1KP8zSdnP/Hyd7JrSyZK4+9I23I0aIVsLSJlSUKEZkAlq/XXPGHOwSjOsYW4ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996424; c=relaxed/simple;
	bh=1gFHQqTMswUOPeaCIGVasFV7ShuHaCbNqXR8xB/ipcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOgXZwwg4WRA9q3ArpPV7k32I+2X4eCGweQIR13UPfADqLF9NCBPFushLVTA7gpQeOazzidtf9CxhWGbDbP9N0FbhKEMAg1KmrWgALY3jbYUCRfzIaRd9Eclm4nzsoL4TOHVejbW+HEWqiaWi/aONEs9rtFqUUhDCwhugOVKluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WR+j4onD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FBd4BEaS reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756996421; x=1788532421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlqqrNZEiY7IvtFC2IBEJxofiBdzO+GTzrOpSqcb4w8=;
  b=WR+j4onDB8Z9Ftp1RG8m3Q75uxfy7glT8/vLzk0Qowrv8Kv9XiuKpHOU
   AJd8DQbwd+1h8vfb/+x9/3UwHOHKyHI4JaMVhEDje2YeklxY41qN+Z2PA
   AoK5GQzcAbPV6PxMOWrTgMdCF5wY2fDhUrkH9W2WpEmDwSKyHS/M9EDb4
   oBR8jbptN5w7YA1ThJZ6kg5XXpQgu7O+maqm5yAIlR656NhRMMIxmo13c
   1FVPnuyfDgR1GPOJsvPZQT/vpkd4xWF7VO8qnD9uAXCyZNOFLINfyVq4i
   Ajx2e5OhJBS2swqVJr9h0PM031UxXqwEFYlvixzDsUOdJU8dk+ET3LhjD
   w==;
X-CSE-ConnectionGUID: G8Hed7ClSl6WgvwutzZBuA==
X-CSE-MsgGUID: 8y9w8OLiQMyZ87BDufx9nQ==
X-IronPort-AV: E=Sophos;i="6.18,238,1751234400"; 
   d="scan'208";a="46080653"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Sep 2025 16:33:31 +0200
X-CheckPoint: {68B9A339-15-20CAA7DA-EC9DC758}
X-MAIL-CPID: 54915AE65B26EEED12B979108A0F4215_0
X-Control-Analysis: str=0001.0A2D034A.68B9A341.0064,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A97E161458;
	Thu,  4 Sep 2025 16:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756996405;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zlqqrNZEiY7IvtFC2IBEJxofiBdzO+GTzrOpSqcb4w8=;
	b=FBd4BEaS14MCTqQhaMKyPetyi2HMKe+mCbXS7zgCsuJzNmwMtXYZwLQ4jrwpSLA+PzN2up
	McSGUADKYjEVrHOUtG+izV5tWNXLmvK4mzPVM20q66XHPPqS907HHAzLPXVRhqPXytUvIK
	JuF4tG9AJStDVT/fXSdMFIQqbFTM5JFH7/yW643XqVg2eQDSMjcOSas61VgDFzfUBIFLBS
	o8RilpJVvxV3cxnYihXyXVbTDuF3DDjDLq7QHUzfxBUDTJ4K5VTOx3fAfoKNzVfrlQRQ7a
	FkKux87MuC0Amd7kiIzibz+1yYt/lN5FOFyuEDVMsHr/J5Yz2oHJ5FsT32C6Bw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
 cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, shengjiu.wang@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 0/7] drm/bridge: imx: Add HDMI PAI driver on i.MX8MP
Date: Thu, 04 Sep 2025 16:33:21 +0200
Message-ID: <13565586.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250904070600.1361165-1-shengjiu.wang@nxp.com>
References: <20250904070600.1361165-1-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Donnerstag, 4. September 2025, 09:05:53 CEST schrieb Shengjiu Wang:
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> acts as the bridge between the Audio Subsystem to the HDMI TX Controller.
>=20
> Add HDMI PAI driver on i.MX8MP to make HDMI audio function fully work.

On TQMa8MPxL + MBa8MPxL:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

>=20
> changes in v6:
> - remove mutex in dw_hdmi_set_sample_iec958()
>=20
> changes in v5:
> - add empty line commit message for patch 7
> - remove blank line in dts node
> - add component_unbind_all when dw_hdmi_probe return error
>=20
> changes in v4:
> - separate dts for soc and board
> - bind hdmi_pai with hdmi_tx by moving some code to .bind() and .unbind()
> - add "select DRM_DW_HDMI" to fix build error reported by test robot
> - remove unnecessary code/definition in pai driver
>=20
> changes in v3:
> - add space and 'U' in asoundef.h
> - add more commit message for binding doc commit
> - add bitfield.h header for fixing build error
>=20
> changes in v2:
> - address some comments on commit messages
> - add two more commits:
>   add definitions for the bits in IEC958 subframe
>   add API dw_hdmi_set_sample_iec958() for iec958 format
> - use component helper in hdmi_pai and hdmi_tx driver
> - use regmap in hdmi_pai driver.
> - add clocks in binding doc
>=20
> Shengjiu Wang (7):
>   dt-bindings: display: imx: add HDMI PAI for i.MX8MP
>   ALSA: Add definitions for the bits in IEC958 subframe
>   drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
>   drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958() for iec958
>     format
>   drm/bridge: imx: add driver for HDMI TX Parallel Audio Interface
>   arm64: dts: imx8mp: Add hdmi parallel audio interface node
>   arm64: dts: imx8mp-evk: enable hdmi_pai device
>=20
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  12 ++
>  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      |  69 ++++++++
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   4 +
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  27 ++-
>  drivers/gpu/drm/bridge/imx/Kconfig            |  11 ++
>  drivers/gpu/drm/bridge/imx/Makefile           |   1 +
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c  | 158 ++++++++++++++++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  65 ++++++-
>  .../drm/bridge/synopsys/dw-hdmi-gp-audio.c    |   5 +
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  16 +-
>  include/drm/bridge/dw_hdmi.h                  |  11 +-
>  include/sound/asoundef.h                      |   9 +
>  12 files changed, 380 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx=
8mp-hdmi-pai.yaml
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pai.c
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



