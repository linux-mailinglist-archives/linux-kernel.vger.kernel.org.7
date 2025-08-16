Return-Path: <linux-kernel+bounces-771764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946EEB28B46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53427AE5192
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677F221DB5;
	Sat, 16 Aug 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biWRzoO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C51F4192
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327942; cv=none; b=YKRBXFJTh8KP2sr6/Ok0L5OXuaFlFhfAVjBoMbp6T9URx4Q5q5D70i+pEgjYH21gJF9WJfI/RlVvq7gWACc6Z2CxEC60xA8I+248fskjThO1CVmJqXA618hhQT7AvTX9p2T4rE6Z8UwBQPEsneSkPi8Oy8hkUig73C4QkE4QVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327942; c=relaxed/simple;
	bh=hu35BagZj+Xff393XimS0+DUXx08BEHNx1DZd0VL3n8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jmMiCloaNvc8orQVRLxdjUd+JZ8zxpBwkbR8jfMXdK1cAmP/wy0CRg4ReZ6/OEn0wSiVOw8cieIXo+dAbw+h6IpeN7gSYliJpyp3lRCWbJToXUvJtNvTydoI5rsOSMoa+qLs+PT7+5PkpdTTPxonzMZ/SznOfy+3uGdFMOAdQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biWRzoO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443DDC4CEEF;
	Sat, 16 Aug 2025 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755327942;
	bh=hu35BagZj+Xff393XimS0+DUXx08BEHNx1DZd0VL3n8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=biWRzoO7D0f7WgMAcfNlal51qjai10RqQdLphxz+4Gy7ZbirG01y7L5VO/MgSGVxA
	 B+vMEkwQBsJXFRg6cDGUvYsPxA8jtvZataFIynXXbTGaVGKHA9f1xYQ8bNa0E7C6hK
	 2oRErCKELVTrFnusXfCKHHOV5kB0Z7UKuDw8oNDAk0tXs1zeM2LPrGwGVRc1NP+2Hd
	 zAd3HAXr27W75JMW9GJDMv9pHO8qheRZT/K3GQ+GmfGZSAGAxzmI3L0ekKw+tSIXvf
	 wdXSkoKVR7MGLMvNzhbz5+0sj6UxFfYdbR34c1l7sbgAFpomrzh/5YbSkiG0rheS2e
	 fJnSyoPJIcS+Q==
Message-ID: <e7a7d935-a43e-434e-9fd7-ba145255d3f5@kernel.org>
Date: Sat, 16 Aug 2025 15:05:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: show the list of donation files
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250812235814.960924-1-jaegeuk@kernel.org>
 <aJy8KS3fLQ452d2r@google.com> <aJ9eTaqNwkQZtA8E@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aJ9eTaqNwkQZtA8E@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/8/16 00:20, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This patch introduces a proc entry to show the currently enrolled donation
> files.
> 
> - "File path" indicates a file.
> - "Status"
>   a. "Donated" means the file is registed in the donation list by
>      fadvise(offset, length, POSIX_FADV_NOREUSE)
>   b. "Evicted" means the donated pages were reclaimed.
> - "Offset (kb)" and "Length (kb) show the registered donation range.
> - "Cached pages (kb)" shows the amount of cached pages in the inode page cache.
> 
> For example,
> 
> Donation List
>   # of files  : 2
>   File path                                              Status     Offset (kb)     Length (kb)    Cached pages (kb)
> ---
>   /local/tmp/test2                                      Donated               0         1048576              2097152
>   /local/tmp/test                                       Evicted               0         1048576              1048576
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


