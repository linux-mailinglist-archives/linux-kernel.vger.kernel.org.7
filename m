Return-Path: <linux-kernel+bounces-833877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C6CBA3464
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5601116C716
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FE286D64;
	Fri, 26 Sep 2025 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lwll2ny2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB626AA94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881008; cv=none; b=L3GCv331GsLRPtaRaa4oWr+hMJP2AIKpH7+Thxq5lBeOR2uEoYyFr88TZ4ABvw3XtDIGuD3FIFqycJXp+X3QuAXMVyHMEYSTXZeoFfm8NX1vMi3BdVCWtzNQPUqN3cobghDMufpm/YN1I/bpAXlYo47tjKzvpoJ12icOzORQG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881008; c=relaxed/simple;
	bh=kF/ob4umFP9kKPgy5tMXsyqO93WOIy3ot+pLXGSH27U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUj9ekpLldOEywvgRyVgWqlW+KcLU47lK0T4VB4D57cDt/ONYCaQDMihsQ4ApUPp249HYMLlsHD/8JXsbDqbuk7EBAfxdKgqKT25nUbMJS50PDOOWBRSbls/AG/MAJYPTAG5TRTubjMMGG1b3FHhf1D0r1PzgQpYc+obolQe0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lwll2ny2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758881005;
	bh=kF/ob4umFP9kKPgy5tMXsyqO93WOIy3ot+pLXGSH27U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lwll2ny24Ng1P/EnBLpX5SjIpwOve83e3swU8JB6qOmb6wd1hxotwptrhelEAPBDh
	 XCiVQHFHmhIGe+8I/si8LRQTk5RgjLAGaAcQEdLNnpLISiCUSSBkUT4Vnz3apV5l8n
	 c/rogoZlpxgrifva5FXMfIQwGWu+WwyJm43W2+4dpqXC1O6teeSyjY8SkLfsogwTlj
	 VbhuIIWuHPe5SQZVAFAI1Nqv1RTXA3WU1PtMRNdyXHKGUgFSRwCGCDO7Plt4dQpHBm
	 Wp/oeMEMT1B5s09EioVTT2Zfv0zBaLGEB1mdoVFAqL3HcXwpH5bDdUNjz0fRRaSQpC
	 /v0rKcurvYq3w==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D8EF17E12C9;
	Fri, 26 Sep 2025 12:03:24 +0200 (CEST)
Date: Fri, 26 Sep 2025 12:03:11 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: steven.price@arm.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.co, simona@ffwll.ch, marek.vasut@mailbox.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, Rain Yang <jiyu.yang@nxp.com>
Subject: Re: [PATCH v1] drm/panthor: skip regulator setup if no such prop
Message-ID: <20250926120311.33dc9fb1@fedora>
In-Reply-To: <20250926090722.23097-1-jiyu.yang@oss.nxp.com>
References: <20250926090722.23097-1-jiyu.yang@oss.nxp.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:07:22 +0800
Rain Yang <jiyu.yang@oss.nxp.com> wrote:

> From: Rain Yang <jiyu.yang@nxp.com>
> 
> The regulator is optional, skip the setup instead of returning an
> error if it is not present

AFAICT, it's not flagged optional in the DT bindings yet, so I'd prefer
to have this change and the DT bindings update in the same patch series
(both will go through the drm-misc tree anway).

> 
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 3686515d368d..2df1d76d84a0 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -146,10 +146,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	ptdev->devfreq = pdevfreq;
>  
>  	ret = devm_pm_opp_set_regulators(dev, reg_names);
> -	if (ret) {
> +	if (ret && ret != -ENODEV) {
>  		if (ret != -EPROBE_DEFER)
>  			DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n");
> -
>  		return ret;
>  	}
>  


