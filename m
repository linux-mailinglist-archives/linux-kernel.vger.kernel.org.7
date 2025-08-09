Return-Path: <linux-kernel+bounces-761118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF4B1F49B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A2A175993
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553329C33D;
	Sat,  9 Aug 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWuCVM+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920729B8F0
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754743107; cv=none; b=b9kP1JDD86IlkFgZefCj7M1vNKEBhfSC8D/3Za8HY668Xvqzl2p8BYwn+ZiaixemM+9F0EQDFfum7AUw2vplYUL4NMd8K+CyE7uKGtKWnYvjLEgcn7SiUsHKC7PeQGuRIzsk3mrrUTOYYqyQG6NYaytjBtAQ27P7Z+En+QQaPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754743107; c=relaxed/simple;
	bh=xnFHorLNEJtWO8XBpeP45stKZBT3GxS5WM+7abvByIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk0dJnFnPxCjRJWob/hSbBitNJStcAfzS0gobio+2D4dUBf+jgFYVzW9sNtAU25Vq2r45aQ6cZsg4gFGZRup9+l5kX3GcDXhbfnBm0T+UAKERku5sRf62MUVITWjAeuL0zxe05O39Ve+/SFuZ2tSEmHxMAzKppkXPjKIHZchG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWuCVM+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1675C4CEF0;
	Sat,  9 Aug 2025 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754743107;
	bh=xnFHorLNEJtWO8XBpeP45stKZBT3GxS5WM+7abvByIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jWuCVM+5iDsAHOH2rlzPfsg5hyxs36MzYPDDW/sIf2j2jNoKzqnSSBPVSlPatC5J+
	 YG/Ueu4f0Sk4ki6Np5CbXLX8ZuCCrwgqh87VDg8wIklb9kKQnqmswUl5uN6Ct2PeEn
	 m2Ihp4VwukNfmkzRhIBaZBRpkXSzhIVOrH0UObuMXrZKayVzm66R37GMwxo5/vB/H6
	 5MfCaEKsV8+RF/zhgPFCkbzP743IiKqwzdFa2jGsMkfGpKtrsYe40a/T2TxrY+QNIn
	 SyQtEhMhY05uZgvf+hNqSHjsoFY65xUcuCm2RIUG3g0GryouyNuFEh0JejQwy1YrOC
	 M3gXhV6l4gZWw==
Message-ID: <a657ead8-7f2c-4165-9a4c-ce4d82ea2adc@kernel.org>
Date: Sat, 9 Aug 2025 14:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/nvif: Fix potential memory leak in
 nvif_vmm_ctor().
To: Fanhua Li <lifanhua5@huawei.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 liuyongqiang13@huawei.com, lyude@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, airlied@redhat.com, linux-kernel@vger.kernel.org,
 suhui@nfschina.com
References: <20250728115027.50878-1-lifanhua5@huawei.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250728115027.50878-1-lifanhua5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 1:50 PM, Fanhua Li wrote:
> When the nvif_vmm_type is invalid, we will return error directly
> without freeing the args in nvif_vmm_ctor(), which leading a memory
> leak. Fix it by setting the ret -EINVAL and goto done.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202312040659.4pJpMafN-lkp@intel.com/
> Fixes: 6b252cf42281 ("drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm")
> Signed-off-by: Fanhua Li <lifanhua5@huawei.com>

Applied to drm-misc-fixes, thanks!

