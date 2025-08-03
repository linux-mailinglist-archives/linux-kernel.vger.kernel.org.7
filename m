Return-Path: <linux-kernel+bounces-754466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94AB1949A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11C2189451D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB01DDA0E;
	Sun,  3 Aug 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mVoJDvG3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C023AD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754240195; cv=none; b=SbDIj9kwJVTEPHXZMe2spJRmfM87w2EEEUb7WWcXGq1weN2vje+wH4jz4mkbe/DcYMrxw7GnviLJxQV3uEraz68nKvFHoX6ZEBjfSslwbXzsfox+kaJxtNzS6zSSegk6ETBjTOkPnAIUIIuItb/nYCAXbMXfvmdjm4fU61VKbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754240195; c=relaxed/simple;
	bh=x2IpmnMdAlqi/Ib8WWxe81cnXXbkIlq6U8CKXJRCfjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GULx0kUbZV3fS9V50f4CH26UESsB/PPwSgwONRqrXVFSHfMHSqy5EvZ+6562GOBtIcecoepNBwSP1CwaLTUaccWsZ+fBqe12D/7ovw7DNE9tDAzFppXm7hN1/aUFTes8bb9p7ELCYhVPfpm90txjdQ1nhpaN+apUlRWT8gRrBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mVoJDvG3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 199D7446;
	Sun,  3 Aug 2025 18:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754240138;
	bh=x2IpmnMdAlqi/Ib8WWxe81cnXXbkIlq6U8CKXJRCfjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVoJDvG3QStRnCwLGYaJqUSGW4si6XnE+T4AcT1U7DVAOyVUSWebx5OB77G1EJZo2
	 H3mU9MABRX2esNlFewaD+wUz5kxlh5riOXqOJwGmz4w4JCDNcPN5QYDhU21mkUoC+2
	 oX3QcUjyBn/Nt+5nSF5W6LvjI0Fe/TTUeO+lq9QM=
Date: Sun, 3 Aug 2025 19:56:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: Re: [PATCH] drm/drm_bridge: Document 'connector' parameter in
 drm_bridge_detect()
Message-ID: <20250803165611.GG4906@pendragon.ideasonboard.com>
References: <20250802161309.1198855-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802161309.1198855-1-hsukrut3@gmail.com>

On Sat, Aug 02, 2025 at 06:13:05PM +0200, Sukrut Heroorkar wrote:
> drm: drm_bridge: fix missing parameter documentation
> 
> The function documentation was missing description for the
> parameter 'connector'.
> 
> Add missing function parameter documentation for drm_bridge_detect()
> to fix kernel-doc warnings.
> 
> Warning: drivers/gpu/drm/drm_bridge.c:1241 function parameter 'connector' not described in 'drm_bridge_detect'
> 

A Fixes: tag would be nice.

> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index dd45d9b504d8..387a3b6cda54 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1227,6 +1227,7 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_check);
>  /**
>   * drm_bridge_detect - check if anything is attached to the bridge output
>   * @bridge: bridge control structure
> + * @connector: connector associated with the bridge

"associated with the bridge" isn't very clear.

>   *
>   * If the bridge supports output detection, as reported by the
>   * DRM_BRIDGE_OP_DETECT bridge ops flag, call &drm_bridge_funcs.detect for the

-- 
Regards,

Laurent Pinchart

