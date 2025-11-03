Return-Path: <linux-kernel+bounces-882297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A48C2A181
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C043AD396
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA3228C2BF;
	Mon,  3 Nov 2025 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khSwx0qi"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99FC28C854;
	Mon,  3 Nov 2025 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149129; cv=none; b=bTipL9JkHX8D/2ZsilVExyPu5JmMxEoX4AFk5JjIRNkr5K82YOaANMlHh+TvLmSLvDbEoJZAzBONwzubRpROLBqeaZIK/xUzzYGffxps4NpkeGd9nAqOMGD2VoATb/eegH0b+0kGLSBAr/IbaPxk8jDfCrFgl+K9G5CH21omveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149129; c=relaxed/simple;
	bh=GkqYU67aDz95UKVMGGjfq3qSeJJoquxo+SPNeYCbvug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oy4nrv0FNfS4MHNpXaIbbJbYirqKc0infRqXl4B855hu1X2D7mW4jUm/+9Rj2KSrYM6SvPVi/h+J12VnFWWznufoa8EmkGAkhNJd0m9U2tRibLmyTcwALBL8lukx+QyOVYpFTtfdd4rdy1RxXYbyqY39gIVzaJIvuZMsvG6k5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=khSwx0qi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=npUn9EeL2QuLeu5AifQOdRVkKhKoYbwmtWuoTt9mCZE=; b=khSwx0qioRXSn5hfOK+VfF+WP/
	Ez0PnWbSnLKFEhRo+tuCc4asdVSvfPuzSSpoGViOsUZ2fcKa6HoiUJo2iTX+4V8+MFk8PsGyWR8F0
	7xkU5Ot6U7/3nmFzC13guhuJtnYh4NNtmOXxalmpI0kzP+U4v4lQ9R7XWUYu9AR+Nl1eOhYKB3c4d
	dA62guw+V6t+Azk1/LVmqjKedqBs/BNcfzza0NWF8s6ulq2BGjhH8cpnkmGdw0dJa7Bu0J5Eul04O
	G3YLpyMWxFcNQP4PpfIAuhKhIyHNlFOxmIWY67Y61o4BT4pEqmHV0YHPWXAKBNZa72VmC0u0zeYNy
	gRcVrlbQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnU3-00000009FWt-2M7x;
	Mon, 03 Nov 2025 05:52:03 +0000
Message-ID: <4ee26086-50d5-4417-b8c2-17bf24c0d1f4@infradead.org>
Date: Sun, 2 Nov 2025 21:52:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: gpu: Limit toctree depth
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>
References: <20251031023521.12391-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251031023521.12391-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/25 7:35 PM, Bagas Sanjaya wrote:
> Currently, gpu docs toctree lists all headings across the documentation.
> Don't spoil these details by limiting the toctree depth to 2.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/gpu/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index 7dcb15850afdb2..e6207b31f8dbd9 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -3,6 +3,7 @@ GPU Driver Developer's Guide
>  ============================
>  
>  .. toctree::
> +   :maxdepth: 2
>  
>     introduction
>     drm-internals
> 
> base-commit: 6fb7f298883246e21f60f971065adcb789ae6eba

-- 
~Randy

