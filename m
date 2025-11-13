Return-Path: <linux-kernel+bounces-899155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDBC56FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571663B4FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B458330D24;
	Thu, 13 Nov 2025 10:40:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C892F290E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030412; cv=none; b=NR0wdsF+MQVLbn+tYAV/hlRYYpkDXSeE/JujFPOlXkXKnQDsxKRvuVj/VCY9534FNHdBFPUECU/CAJ9mQbSuDaaTi4xWu+q26lyp9TVjRfu8nkJgFu+74+/qHXetgEaM5IzmLDMhwXX3XsE+sHZNKwVEEsHJhgk/QMe2V/KNO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030412; c=relaxed/simple;
	bh=8EwW6qvASrP8ByPijgvbfIm5LORCYhgOcUZz8kMmwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS5cVQZPGAFjTqXj+bkgSeD8kXgWQGojm81Q2UgHgXbjnMB5pQvcLJ01a8MVYMtNk9kCZKGZE0cJLNfGBymNRnRNj1mDSREQvVNdbHcyCrsTojoQwT4/Iisqs6onj/ah4ph8njk0a6Ygf+pyr4cCzFZ3VEn2E0VLfEjN/ZCL98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E26012FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:40:00 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 146F83F5A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:40:07 -0800 (PST)
Date: Thu, 13 Nov 2025 10:39:58 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Abhishek Rajput <abhiraj21put@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: Convert logging in komeda_event.c to drm_*
 with
Message-ID: <aRW1fobS0XbAJPTF@e110455-lin.cambridge.arm.com>
References: <20251113100623.162327-1-abhiraj21put@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251113100623.162327-1-abhiraj21put@gmail.com>

On Thu, Nov 13, 2025 at 03:36:23PM +0530, Abhishek Rajput wrote:
> Replace the DRM_ERROR() call in
> drivers/gpu/drm/arm/display/komeda/komeda_event.c with the corresponding
> drm_err() helper that uses the existing drm_device parameter.
> 
> Using drm_err() allows the DRM core to prefix log messages with the
> specific DRM device name and instance, which helps distinguish logs when
> multiple display controllers are present.
> 
> This change aligns komeda_event.c with the DRM TODO item:
> "Convert logging to drm_* functions with drm_device parameter".
> 
> Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> index 53f944e66dfc..78a4a78d1fab 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> @@ -148,7 +148,7 @@ void komeda_print_events(struct komeda_events *evts, struct drm_device *dev)
>  		komeda_sprintf(&str, ", pipes[1]: ");
>  		evt_str(&str, evts->pipes[1]);
>  
> -		DRM_ERROR("err detect: %s\n", msg);
> +		drm_err(dev, "err detect: %s\n", msg);
>  		if ((err_verbosity & KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT) &&
>  		    (evts_mask & (KOMEDA_ERR_EVENTS | KOMEDA_WARN_EVENTS)))
>  			drm_state_dump(dev, &p);
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

