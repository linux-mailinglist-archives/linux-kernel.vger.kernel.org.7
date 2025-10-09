Return-Path: <linux-kernel+bounces-846602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338EBC87E6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AC3BB4F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BE2DCF69;
	Thu,  9 Oct 2025 10:29:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2512DCBE2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005761; cv=none; b=H8K7Ye7xSUr1evNq3B/be8EH4ykX1blAzj/Bi7dxD4Cy2kwCTzQz6zGGIbfT6AGX6Ns+boGacrCQ6YUWr9g3U1FEawnN0U8RgorS6xohcAPXFI5eEYkjiy0zqAwk+Ph5Vwq7KV0oVeZUtrAPb8ZlfMpkfX3bxXPZgjANbMQ/iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005761; c=relaxed/simple;
	bh=r7qz1AAPkBQtYd2TmdEoC1fwaHp5mQgHhybeRRdqQxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkXUm1gZwCk/yFm9gcOO4Ko9i+ETFb5TyuVuxZjBDdEwKnQVxaxQhH0Cta+ThlulYyi0OiuP3nBr9YI2UfJ3AO97L/b6YII8GWn9BB+lG+FwtZciQRj/ep9ujCSQ2p8+JfZkykVa6lmw0CQURWm8w23hNa/EIcXXOA2Y5fztJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4A7176A;
	Thu,  9 Oct 2025 03:29:10 -0700 (PDT)
Received: from [10.1.34.29] (e122027.cambridge.arm.com [10.1.34.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF7F3F738;
	Thu,  9 Oct 2025 03:29:16 -0700 (PDT)
Message-ID: <d526aaed-b29d-4e19-aab4-aa735282055e@arm.com>
Date: Thu, 9 Oct 2025 11:29:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Ensure MCU is disabled on suspend
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251008105112.4077015-1-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251008105112.4077015-1-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2025 11:51, Ketil Johnsen wrote:
> Currently the Panthor driver needs the GPU to be powered down
> between suspend and resume. If this is not done, then the
> MCU_CONTROL register will be preserved as AUTO, which again will
> cause a premature FW boot on resume. The FW will go directly into
> fatal state in this case.
> 
> This case needs to be handled as there is no guarantee that the
> GPU will be powered down after the suspend callback on all platforms.
> 
> The fix is to call panthor_fw_stop() in "pre-reset" path to ensure
> the MCU_CONTROL register is cleared (set DISABLE). This matches
> well with the already existing call to panthor_fw_start() from the
> "post-reset" path.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Do we need a Fixes tag? Or is this only actually an issue on newer GPUs?

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 9bf06e55eaee..df767e82148a 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1099,6 +1099,7 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  	}
>  
>  	panthor_job_irq_suspend(&ptdev->fw->irq);
> +	panthor_fw_stop(ptdev);
>  }
>  
>  /**


