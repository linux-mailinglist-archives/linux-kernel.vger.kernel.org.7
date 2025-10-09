Return-Path: <linux-kernel+bounces-847095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77221BC9D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322713A4CD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2121B9C0;
	Thu,  9 Oct 2025 15:47:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7C202976
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024852; cv=none; b=HtTxJpJWroUTJQiFAAmJ4tgRghx7cFqNQ01Iu/br1R0Ac9EgA5krvtOoNbQ+R0BVGrOGghR3SVj75K1gyBfagrYKUc++H0VCU6ToYw+jXBR5oxJ0ixTWXwG/rbnPNMn/HSYiG6UMCXYdv46M/F4QpQeYLam9es5S4nP0rE6xYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024852; c=relaxed/simple;
	bh=yV9Bomtp4L4wBEln8IBG96JD2dbLJBzmGXbmjGtvLls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1EMIMp2IHSiLVl5+3e3gdOW4uJMvLwWbOWvplcuY/dRCxylccpWGdOU0xDYdthf6nHzmDuJdkBmliDCxsJgMHpLo9Pae4cfgeRa/0wtmk3zgtpLe8104sKjzdZy05GgRqqHgtMALiajFq1FXJ6skvH06koz1qHj0A5Zwl1QGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234E91688;
	Thu,  9 Oct 2025 08:47:22 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2BE53F59E;
	Thu,  9 Oct 2025 08:47:28 -0700 (PDT)
Message-ID: <971fd0e3-474a-4685-ade2-f4563372f74d@arm.com>
Date: Thu, 9 Oct 2025 16:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] MAINTAINERS: Add Adrian Larumbe as Panfrost
 driver maintainer
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
References: <20251007150216.254250-1-adrian.larumbe@collabora.com>
 <20251007150216.254250-13-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251007150216.254250-13-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/10/2025 16:01, Adrián Larumbe wrote:
> Add Adrian Larumbe as Panfrost driver maintainer.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Acked-by: Steven Price <steven.price@arm.com>

Welcome! And thank you for helping out.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5257d52679d6..cb68fdec3da4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2066,6 +2066,7 @@ F:	drivers/gpu/drm/arm/display/komeda/
>  ARM MALI PANFROST DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Rob Herring <robh@kernel.org>
> +M:      Adrián Larumbe <adrian.larumbe@collabora.com>

NIT: it looks like you've used spaces not a tab.

Also while we're here...

@RobH: Does it still make sense for you to be listed as a maintainer? I
haven't seen you active on Panfrost for a while.

>  R:	Steven Price <steven.price@arm.com>

And given that I've been doing a fair bit of the merging recently I'm
wondering if I should upgrade myself to 'M'?

Thanks,
Steve

>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported


