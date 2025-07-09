Return-Path: <linux-kernel+bounces-722993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8DDAFE180
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5947B3059
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE041271448;
	Wed,  9 Jul 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSd8H5Ba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475042701CC;
	Wed,  9 Jul 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046662; cv=none; b=ds+QbPnS7F06QjO+XRY+nwC8SfqBfNthwksNTjN/cUKD3GbUCkj90ihY4r6LYNaq/QQJdfhvIB7Dc2NGY6PnqVEQ/woQC6Kk6lrsrUUirysdPleW1n0PUd84LSD/mio+9xky0WgxUbA/AS2cjuAFnuvtXW0mEud8WfMa9zgKLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046662; c=relaxed/simple;
	bh=sN1FBorFWsdlH0wPpgViuDr0g+ntVgJSYzyFcsEEdWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFlqSmq525o8WCAq17TgELHFMB8M6EO7d0Dk/lkUiBJEOlzX77or9GgQGjw6aPKXvFOdCYOZXtWhb9jimCL2P6JB/SnsyW2VLvxEgdqIdSdixvi7aL+Blcr3jUcdn7bbQIaKvymT85EqZrXK7uRhlYpYL2lkC8hQ1zNu8jj1ZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSd8H5Ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F402C4CEF5;
	Wed,  9 Jul 2025 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752046661;
	bh=sN1FBorFWsdlH0wPpgViuDr0g+ntVgJSYzyFcsEEdWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aSd8H5Ba4DqABFHmO/4o5mG5OEjOjmou65ScvWFU00/kp+bs9PzE+rSUqcT3NVkU5
	 K91fpryjaASoUJzAZkHXTsJdbritRRBpAhiIU+WgPskrQ1bbnZVQR4w3a3a9i4PEYj
	 kun0Mo32XKNjOI2OxNXvcbWUdsUctUPcj+ecG2AHQAlnW3zM8tCHoIQQ4u+DExPYjc
	 0nrhiAHhMNMR944lxXUbEP+8t53Jvl8W0fMlwz1Lh2jJZaY9xjW2wBAAeD+ocPcMD9
	 iSgZcBoXq6GLqfNLlZgYKMKMVgbHYqzvZoyp7S6VcUMWPn/NxeX6oIcEQZjUI644UC
	 YvQDxsvQRBSxQ==
Message-ID: <aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>
Date: Wed, 9 Jul 2025 09:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
 usage in literal code block
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Raag Jadav <raag.jadav@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250709024501.9105-1-bagasdotme@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250709024501.9105-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 4:45 AM, Bagas Sanjaya wrote:
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

I assume this has to go through the MSM tree?

Acked-by: Danilo Krummrich <dakr@kernel.org>

