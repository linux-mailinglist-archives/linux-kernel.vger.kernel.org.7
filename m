Return-Path: <linux-kernel+bounces-839993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99952BB3416
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3516FE45
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019F2F49F8;
	Thu,  2 Oct 2025 08:21:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D852EF646;
	Thu,  2 Oct 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759393307; cv=none; b=C8I88iV/ifoCO1Vr6Bweeoy9y7e9bV1UJqAhQ5cQJEEp9AFuqEXL9YkXlhiET18K7lfWrFGnSWvX7x4lCkkfLqLqffSwqkQ/6YoXTK6hFVFArAvFiLplLlBs3150NKXCYujjtL46nVpAZ8vFHuspzextyBvW5xQs3U5fB94/KhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759393307; c=relaxed/simple;
	bh=JvILfezVGXjcvObUkiycAukBWXntv+HyOrufPHelMZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUrBdaei7fu9O1Lw0Xwm5i4nvvNWPG8S7AZJpRluyVqhdmlJPUab1UOXLsLnSMvZTv0Zv8dninGcJeTto4hM5jjcj5sWbDhodg9TXdhdRXJ9ypZzTWILDn3ou09T0iliUg0qbyLnHgMIJCIVjrzlOLBydgJ7MX1xK4b9QZW+gWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE10B1692;
	Thu,  2 Oct 2025 01:21:35 -0700 (PDT)
Received: from [10.57.2.240] (unknown [10.57.2.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4774D3F5A1;
	Thu,  2 Oct 2025 01:21:40 -0700 (PDT)
Message-ID: <67b8e65e-3caa-419b-acc0-61ad8cbc463b@arm.com>
Date: Thu, 2 Oct 2025 09:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: skip regulator setup if no such prop
To: Rain Yang <jiyu.yang@oss.nxp.com>, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.co, simona@ffwll.ch, marek.vasut@mailbox.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Rain Yang <jiyu.yang@nxp.com>
References: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>
 <20250928090334.35389-2-jiyu.yang@oss.nxp.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250928090334.35389-2-jiyu.yang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2025 10:03, Rain Yang wrote:
> From: Rain Yang <jiyu.yang@nxp.com>
> 
> The regulator is optional, skip the setup instead of returning an
> error if it is not present
> 
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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


