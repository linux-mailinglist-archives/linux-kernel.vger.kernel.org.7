Return-Path: <linux-kernel+bounces-722807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F81AFDF3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E173C1BC7728
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEF126A1A8;
	Wed,  9 Jul 2025 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ru37LWJ6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6E18A6AE;
	Wed,  9 Jul 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038816; cv=none; b=PrnzcLuQaVGKbfXyWwKaarlOKDSD9XjMKzQq5F750HFuqKN8g84Ti6FOr6KqTjbSptE+PP094zc6bOXyhTkXEftnGTdFrqA8xFnVppFGnpTjcQwoWSHiNltuVD2xf6IOL2c3QYknXdWE8zl6nM6EJ5Fme8BcI59j+Qxr1g9xdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038816; c=relaxed/simple;
	bh=J3zTTmCJxvUBuBboEAuu182Tn48ni4t7yWkd9I7MydM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9K8VMIorwmsIt5MgTKATXXfcplXWSPCb3D4GX9L+Q8jnkZTSyIOEtZnfSqiJjw17yFt3lMlwz/L6oSRYYJ9KYCfwM323yTpP36QmXzS+0pr+n8fu73WOEgcjlbqQAswq+Z/+bMEoo62bf128LgV5cXGb7UZa78zOiCyRb88g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ru37LWJ6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=JEnnyFaI59W4HNdgSd7HYPu9jFz+8K/pGInaewzc67Y=; b=Ru37LWJ6vsD/V/WrcrSQDLICEE
	wQGb5JRwdBFhM0W9QsHQVza6wLt2ViP4ykDdhkb8XYtGijVD85CRgSayLfaQtHNfL/SVEufmOlJat
	7R9FPkl986PP0UXCk73gyo30OerlWcy2+lxLf9MLt8rE/hWtjnYM5vjVm4MVep7DDfbhYyyYeClhF
	JtwRbu6Dkp7L4yv5Y7NHIRMgPoFky28XEXTxV8vJjqEQilXMNtynhnE31F6/4O5U+1YCOfiWWzVrX
	+vpUTh1qvITQWC5+iTWjTODQaW2dNVTm7Gcw48SIKBrsURt9pQQDLclm+KYEChWkpp/w3YUvEKRtn
	+cVIb/uA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZNKQ-00000002bK2-30bC;
	Wed, 09 Jul 2025 05:26:46 +0000
Message-ID: <87031b13-88c7-44c3-bb4d-adbae2b92d13@infradead.org>
Date: Tue, 8 Jul 2025 22:26:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
 usage in literal code block
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Antonino Maniscalco <antomani103@gmail.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Raag Jadav <raag.jadav@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250709024501.9105-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250709024501.9105-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/25 7:45 PM, Bagas Sanjaya wrote:
> Stephen Rothwell reports multiple indentation warnings when merging
> drm-msm tree:
> 
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2445: ERROR: Unexpected indentation. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2447: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2451: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2452: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2456: ERROR: Unexpected indentation. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2457: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2458: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2459: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
> 
> Fix these by wrapping drm_gpuvm_sm_map_exec_lock() expected usage
> example in literal code block.
> 
> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250708192038.6b0fd31d@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpuvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index bbc7fecb6f4ab4..f62005ff9b2eef 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -2430,7 +2430,7 @@ static const struct drm_gpuvm_ops lock_ops = {
>   * remapped, and locks+prepares (drm_exec_prepare_object()) objects that
>   * will be newly mapped.
>   *
> - * The expected usage is:
> + * The expected usage is::
>   *
>   *    vm_bind {
>   *        struct drm_exec exec;
> 
> base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

