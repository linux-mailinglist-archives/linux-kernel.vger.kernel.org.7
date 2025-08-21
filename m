Return-Path: <linux-kernel+bounces-778827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A293FB2EBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFA5C5E56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675792D6639;
	Thu, 21 Aug 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQWMeOsc"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC52D4B4E;
	Thu, 21 Aug 2025 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745604; cv=none; b=hmJZ/VFW+qv6lPCN6WTe74f58JjFtS1uoU/86xtDVq7hh8IbHZe1uMwPBT70F0QQxellTZ6GEkI1lrRWFwORjrjflFjcCUXQkwEyOfErr0fTQmsk1qjfOJNihzRga+L/L9jFUS6UWaZgOHDGBllw/BHf1vj+9Tz0a3OaVNUikVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745604; c=relaxed/simple;
	bh=bF24w49KxhiqPN4eoMYn+dEQt0aAYbwmA0oPyP/PBnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSZooTZY6mylyaiCnqVjyp3DIpHVxcXngWnuhmuuzhPhLsyVxqdl3bOYGvHVan5RCUnE+rhFwK12flczpkZyFGU+RxbAQCLimH50SnXgG67oO+/k4LoJMYf+Hw993XOr0UMefhYgKds1zdRpx8ZfiPtJxascxE7sv3iXVHz0OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MQWMeOsc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tIDAFgFXP+KfCHaBZYFy17v8lTqJ/ZVxo+olFKcoIuY=; b=MQWMeOsc+RDyD8Tr1/R8PmI0OQ
	iu1epjTKc78mfsv7VX1uKwZfZ8nTGPaOrPpF7e1+Xjsv6Od3IIwmNjTmuMNz3rPNeGdKtSuG3Y5uk
	tn9sQcda55euFysdFxBzGWMfXp5kMfNTiDVkN/V/b4qsLj2t1Wq6Sz9VMtCnkEswt1H4ZaS1G/JJy
	KMTPF50GwCSFjdDhJmDeNE7U+GwBpxKYy0Jfels2bQyjBesPWsUUsL9xih/z4o4sYWkv4T+WHASMI
	ktdoospC+Y45wsC/cOKnxhRi8HsIXdwE2lvpVo9Wfnn7HLAgUiCMN7D1cU7PymKMMeKWI3TSKIAUJ
	EH6NzA4Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uovdS-0000000Fb0r-3xFG;
	Thu, 21 Aug 2025 03:06:42 +0000
Message-ID: <0f11100e-ca60-44a8-9826-03c80675446f@infradead.org>
Date: Wed, 20 Aug 2025 20:06:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs: gpu: Fix spelling in gpu documentation
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 corbet@lwn.net
Cc: tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, siqueira@igalia.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
References: <20250821025957.22546-1-rakuram.e96@gmail.com>
 <20250821025957.22546-3-rakuram.e96@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250821025957.22546-3-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/25 7:59 PM, Rakuram Eswaran wrote:
> Fixed following typos reported by Codespell
> 
> 1. complection ==> completion
>    implementions ==> implementations
> In Documentation/gpu/todo.rst
> 
> 2. unpriviledged ==> unprivileged
> In Documentation/gpu/drm-uapi.rst
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/gpu/drm-uapi.rst | 2 +-
>  Documentation/gpu/todo.rst     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)


-- 
~Randy

