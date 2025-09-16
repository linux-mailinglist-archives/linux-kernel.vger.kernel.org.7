Return-Path: <linux-kernel+bounces-818890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD0B597AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0961A7A8DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910321ADA4;
	Tue, 16 Sep 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IYJ1APij"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D220E029
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029462; cv=none; b=PtAEDM/hyQgyVxVmePzlkSAxduFjUUSXimcAPQCVTAyuJpyZoLMgAIGrvo6Kez1QxM8XphCV/jzQy87kFgYATOFu58zje8Qeo5IoioHiUDRf42vcrG99eMS4Jx52rqaSPr6u/KnQHPUom5X5rwB0FFmh1ojobjudS3/wHqw2bsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029462; c=relaxed/simple;
	bh=vHGeoc6gZ+/27XjQT7Icf4xx8n94wIYqdOJfkABkoDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ofw2TN31Psje+TBPRRWboQzdgnVdGUcFLAvxGBSYvo5tYjPWhzwh07oXLpR6PATeGGdGjAGC6G5n7r/5B2xW7DyKsxvKPhoplu+iGONYE0CTVjVqS7GrOTyi7IhphpHl8QW/Dmhtp3c96SOqF9APUEdjJa28VBGJUvb9jf46ues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IYJ1APij; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 641E9C8F462;
	Tue, 16 Sep 2025 13:30:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCE9B6061E;
	Tue, 16 Sep 2025 13:30:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A0ED102F16EB;
	Tue, 16 Sep 2025 15:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758029456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tUyzwXW4458dpExn6r1iPeVrMvWBtYuEhb3Ju7KaSQg=;
	b=IYJ1APijKsoPsmylpXB1reCXjld/uQqgECM+pnJVPqDiw15H3pG8uQAqDIGoKPMA0+d306
	HHdU6PEy7Aidx1OZH6BH+CTrcWkLtunt63vvp3q17Dsd9Nw4DD2bRhsYlCfD4M7BGiN/Sl
	NPiOODnElalEawczpz7eSqn4lPNPFQE+L50fP4nBfcV/ea0soFr+OLF0NLhzPsIBsMpGuc
	IVj6TCVouLXWiSK9ElBNvUlb8u8uuIGwLBqYTxFgjzDpfwhMZIAhBYPT2YVZ3eVWe21DIe
	ccSk/qVsKJeAQMtt36QM1HGOhrPx5kButftwcY6pPVBQpuC3F40r3Ho/Hvh7XA==
Date: Tue, 16 Sep 2025 15:30:40 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Liu Ying
 <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/9] drm/bridge: get/put the bridge returned
 by drm_bridge_get_next_bridge()
Message-ID: <20250916153040.0eb77a92@booty>
In-Reply-To: <175681953112.353165.466531296795467773.b4-ty@bootlin.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
	<175681953112.353165.466531296795467773.b4-ty@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Tue, 02 Sep 2025 15:25:31 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> On Fri, 01 Aug 2025 19:05:22 +0200, Luca Ceresoli wrote:
> > Note: the cover in v1 was mentioning by mistake
> > drm_bridge_get_last_bridge() instead of drm_bridge_get_next_bridge().
> >                ^^^^
> > 
> > This series adds drm_bridge_get/put() calls for DRM bridges returned by
> > drm_bridge_get_next_bridge().
> > 
> > [...]  
> 
> Applied, thanks!
> 
> [1/9] list: add list_last_entry_or_null()
>       commit: cb86408b1fc2e3f6fe45ebe8509a5404060e01e0
> [2/9] drm/bridge: add drm_bridge_chain_get_last_bridge()
>       commit: d77ad5178e90f5aa4ce6085510b3b2f742abc5f0
> [3/9] drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()
>       commit: 5849eff7f06709c98baa7989806165fe30bd0cbe
> [4/9] drm/omapdrm: use drm_bridge_chain_get_last_bridge()
>       commit: c3183f71c3f1f004a0ca0b84c45c40d8b84dce3d
> [5/9] drm/bridge: add drm_bridge_is_last()
>       commit: e4cedfd4f0fc839bb3c783d7e827e9755e1af5cf
> [6/9] drm/display: bridge_connector: use drm_bridge_is_last()
>       commit: 306734a1c76ce35fa613ea823a31ddbcdbf1eef5

Last 3 patches applied (but I don't get why 'b4 ty' fails at finding
them to send an automated thank-you e-mail).

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

