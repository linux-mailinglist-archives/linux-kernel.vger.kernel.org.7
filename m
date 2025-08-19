Return-Path: <linux-kernel+bounces-775981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D65B2C702
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FA1BC3124
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A827145C;
	Tue, 19 Aug 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="G80qV9YX"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875AE2EB873
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613742; cv=none; b=NHgA0xyeZJ6gmJc5UB1GQLqeLUSa5WHTs3lqB6ZIraL90+BGeGeDzF365a3Vtt/hGjarDR7XHnEx5TLnM9yl3GJl2U5Co7aAlLDibV5PK093/K7z5/KyAS1T9IolGhfgurxR52uSShEel73g0ugaheD0Ifnm8zgOytpr2bUfmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613742; c=relaxed/simple;
	bh=hM0/OcX4vwlnvd6SllkrAWsEAsc1DYga68+ZsALhGq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZwK65LDGTvHADPX/VTko/2ca5UyRNvkkfUSDfIhvU7h1/1o7EXbeCtfgnNSLRASy3S+Ydk7kcklYl4X5GQPxpZRANNsnoXl7wViOUDvJixoRnCNJAtKKBvJx8ERpJsH3mT5ioZOnIXrSxxY1+qaleqF16Q9QoHtJEZstxhA50h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=G80qV9YX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r3yEuAoEomtClLGdUNtOQPUA8kM0LtyXwG1k57Cws3g=; b=G80qV9YXYXgIIVGfju/HBZP6hR
	SvGEzGyhXDH/Vg/VqXG35r1mTMCxmIaq+jJVZP+DA6d7o3sRN6HieuN3O3lWBeYzNXQUe8LqyZQbz
	1D8Shmh1NCxAiFuH6Xlm7+x9N0Ny76R4ww5cqD/6L+WWXL1E28Wlu6cHisW+hsUqK7AqRUSE3Kl9S
	GbfJ4HQALpLaWYHko5AK4Amooi/E+xLfT7D0F9hOTB6cjp9+PRfZQQtOfO+z0gbvFh4SzEPsZsiKi
	xZCSuP+LBm5Yo4KIgHLu5A7JplG3CKEp7EgNztoyzIoUJRbfRpBxQ7GIBu3WZ2biSwNIiUxLUIcWV
	/xuk1gPw==;
Received: from [84.66.36.92] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uoNKD-00GKzO-Gd; Tue, 19 Aug 2025 16:28:33 +0200
Message-ID: <94832307-8fed-42a7-8539-1a329d9db4d6@igalia.com>
Date: Tue, 19 Aug 2025 15:28:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched/tests: Remove redundant header files
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 "open list:DRM GPU SCHEDULER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250819142630.368796-1-liaoyuanhong@vivo.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20250819142630.368796-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/08/2025 15:26, Liao Yuanhong wrote:
> The header file <linux/atomic.h> is already included on line 8. Remove the
> redundant include.
> 
> Fixes: 5a99350794fec ("drm/sched: Add scheduler unit testing infrastructure and some basic tests")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/gpu/drm/scheduler/tests/sched_tests.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> index 63d4f2ac7074..e25b8b9b80eb 100644
> --- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
> +++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
> @@ -11,7 +11,6 @@
>   #include <linux/hrtimer.h>
>   #include <linux/ktime.h>
>   #include <linux/list.h>
> -#include <linux/atomic.h>
>   #include <linux/mutex.h>
>   #include <linux/types.h>
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko


