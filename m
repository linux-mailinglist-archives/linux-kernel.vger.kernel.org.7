Return-Path: <linux-kernel+bounces-846318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA3BC78DF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6184EC4B9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3472BE03E;
	Thu,  9 Oct 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a9d11YKi"
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B091F8AC5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991927; cv=none; b=dZ8E7T4uy531b6C2nGBSFjyOKyrnZdTjRYlcf2MADoGqqNLOy1S8GDzx+iagBDCy+rEiTepuWcfOHt3+HIhaJlPVnmOLJT39zlf4sRzoT2WKvImMpZnotXQLZir58T1jTPn363f6+NrzajPQjoFeryiVypJOITO2uxoNQTSTfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991927; c=relaxed/simple;
	bh=78d9Ij1gdg7JHE/w+awIyeCt5dh1s1GzPNkR19wB18s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DWc3nTOjrljcmiZ3xJl626EO+FRzgXWjZsQo3d2qztjoOpw+LqZLiBu84DL/iM+4Iu/NjVE88/iubelnXd3V1crSVtgQCGPZOBeh/4ijNt4+DcDK9Tz/9/AHUCXv2aE7XxqTsoBCsBv/nNuMX6yosZePRkjXDUm4lFVFyz/ULgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a9d11YKi; arc=none smtp.client-ip=47.90.199.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759991909; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=A7uF0ypIDD4ce4JFBz4t/KnVpqhkIM1GtfoljNrd+fM=;
	b=a9d11YKiqRgbOM2CbBKQlQU38a2sjhXQpTvI3B0Cicu67A02ZqhhQlnc9Oy7IsZbkcuo5jmKmGeG/6O21izL+TK2E6zEfXq7E6uzA3xg7L9SMdCTPq0AVfjqxq+LVcYjQEUUPl/bBJDxqgcy6ndl7obWMl9+I1NhL+x6zDyVERg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wpj7cTa_1759991908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 14:38:28 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Yadong Qi <yadong.qi@linux.alibaba.com>
Cc: akpm@linux-foundation.org,  urezki@gmail.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmalloc: WARN_ON if mapping size is not
 PAGE_SIZE aligned
In-Reply-To: <20251009061410.820-1-yadong.qi@linux.alibaba.com> (Yadong Qi's
	message of "Thu, 9 Oct 2025 14:14:10 +0800")
References: <20251009061410.820-1-yadong.qi@linux.alibaba.com>
Date: Thu, 09 Oct 2025 14:38:27 +0800
Message-ID: <87zfa0tw9o.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yadong Qi <yadong.qi@linux.alibaba.com> writes:

> In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> mapping size is aligned to PAGE_SIZE. If this assumption is
> violated, the loop will become infinite because the termination
> condition (`addr != end`) will never be met. This can lead to
> overwriting other VA ranges and/or random pages physically follow
> the page table.
>
> It's the caller's responsibility to ensure that the mapping size
> is aligned to PAGE_SIZE. However, the memory corruption is hard
> to root cause. To identify the programming error in the caller
> easier, check whether the mapping size is PAGE_SIZE aligned with
> WARN_ON().
>
> Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> ---
> v1 -> v2:
>   * Use WARN_ON instead of BUG_ON
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5edd536ba9d2..2cad593e4677 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	struct page *page;
>  	unsigned long size = PAGE_SIZE;
>  
> +	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
> +		return -ENOMEM;
> +

EINVAL?

>  	pfn = phys_addr >> PAGE_SHIFT;
>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>  	if (!pte)

---
Best Regards,
Huang, Ying

