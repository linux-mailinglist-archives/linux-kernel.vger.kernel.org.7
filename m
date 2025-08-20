Return-Path: <linux-kernel+bounces-778399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6506EB2E508
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F368AA22852
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C053273D67;
	Wed, 20 Aug 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/FjGWgG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2421A437;
	Wed, 20 Aug 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714741; cv=none; b=JWt9lPoSQGIOPYY2s18D9JJej6J156agzK6JZdd+l1PUdiBunkFcbQh/5Uxjz5yQapjqtQs3FVpoa49A1cL628PfHx2YPwOi3Pho5tscuMfqlCW89A2tZi5fJyJDhfyTlUcXRwu1mOuQPfH6GKK0G1lOVbcKS0HT8u+NRHz1QIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714741; c=relaxed/simple;
	bh=sPmqSitvB0v6mEUeWYf2NHAGdyCmTuIzM9XDmsGb5Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfP9s/+MCJrKlJ0q4Z5OqZDUAyVh1Tp/mEt+Lr2uyOqmcN6jWWjmW7vapQBI/ARIP/eCxugTt2MqnXOK/70qeUK7saklpUH1wxqVCk5spOLtYuKWkjEnwI5PIWlhwAYhl3763koF2xSQLFQTuKE5SLQiS085otqV1qVA8ahLg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q/FjGWgG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/IcasXGt5PbdoVVXgghzry42yNZ+BKaeuG0k8SwqEiE=; b=q/FjGWgGcZoyCpEvqzRf8l3Zr/
	JIlfqELevVDHITw5RFmNo9AMXsyBB/1XndCSGlTd09RzWkrSjxKUJIjufaLYz8yxfwKpy8ND60NJs
	76hOsgpGJ+w0JikLmP6MoRsLeA1o9dfAEBPJvORLXkuEWebNamwm+TiBY4A3uaZ+rhmjKxj4UFaBg
	hZKIUQcipMHbmvUS2rvgor0hab0mUAzjR3Y34FzVMejhHia/4mMiFgK2cGU7j54FxNt8M8wez2KoO
	vyvtac4XHa1fdJm5170GVZz3r2HJ+QfgDdX+AwW+PcRxDvPmBvIDOlXXXC4jpx5TO5d5arqEghy9q
	ZHy/YFwA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uonbe-0000000EgzN-1F8t;
	Wed, 20 Aug 2025 18:32:18 +0000
Message-ID: <1fc93d62-eb77-46a6-964f-c0bc7348d482@infradead.org>
Date: Wed, 20 Aug 2025 11:32:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: gpu: Fix spelling mistakes
To: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 corbet@lwn.net
Cc: tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, simona@ffwll.ch, siqueira@igalia.com,
 harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
References: <20250820182259.11227-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250820182259.11227-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/25 11:22 AM, Rakuram Eswaran wrote:
> Fixed following typos reported by Codespell
> 
> 1. filp ==> flip
> In Documentation/gpu/drm-mm.rst
> 

No, that's a "struct file pointer". filp is correct.
See include/drm/drm_gem.h

The others look good.

One more comment below.

> 
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
>  Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
>  Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
>  Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
>  Documentation/gpu/drm-mm.rst                               | 2 +-
>  Documentation/gpu/drm-uapi.rst                             | 2 +-
>  Documentation/gpu/todo.rst                                 | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 

> diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
> index 6b6d70e357a7..c1297a9e4d09 100644
> --- a/Documentation/gpu/amdgpu/process-isolation.rst
> +++ b/Documentation/gpu/amdgpu/process-isolation.rst
> @@ -26,7 +26,7 @@ Example of enabling enforce isolation on a GPU with multiple partitions:
>      $ cat /sys/class/drm/card0/device/enforce_isolation
>      1 0 1 0
>  
> -The output indicates that enforce isolation is enabled on zeroth and second parition and disabled on first and fourth parition.
> +The output indicates that enforce isolation is enabled on zeroth and second partition and disabled on first and fourth partition.
It looks like "fourth" should be "third" here.

-- 
~Randy


