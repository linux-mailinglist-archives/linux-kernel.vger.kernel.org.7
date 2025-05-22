Return-Path: <linux-kernel+bounces-658579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4EAC044A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 07:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544DF4E3C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633C1F1500;
	Thu, 22 May 2025 05:55:54 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2B1A5B99
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893353; cv=none; b=DKPplf5h3KBZRM/lh1ngdaOVpV3UYGQjXB4JnHaxMCJfVhVYD+8nyQzMys3yqJ5ecD0gUjl6lXwqTGwhO1pBgzKyTqlXNlzdA9upE7dk1V89d/sTEacTWAv+kYtDt8TGaGA9MvZE/Lo6GI9SDaFF9cSMBTki27rbRXzS3+dbMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893353; c=relaxed/simple;
	bh=eaPQ5tlfp3WTenA4wusw9SWHS4vbRJXn3V5pTkR5FvU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u45MtNO6rbdHZEF1mQe2Z2a1jLaEbD2tr5WnfORASoxHDK0ufCfK0hYbCIF0rP/UpK6W/zKm2e6WzzcNs4GjJ0BpXGPfGFyeZ1Vv+MsPc4zMuicvfSY7f6uaVoiKGgAFP28/bnhl86LEJ4N5qIB9qkXsKm5OtruBu6VLEZoasGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c7-682ebc65e99b
Message-ID: <574262b0-6dd1-4e0e-a2c0-0e22aa885c6e@sk.com>
Date: Thu, 22 May 2025 14:55:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, damon@lists.linux.dev, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon/Kconfig: enable CONFIG_DAMON by default
Content-Language: ko
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20250521042755.39653-1-sj@kernel.org>
 <20250521042755.39653-3-sj@kernel.org>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250521042755.39653-3-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXC9ZZnkW7qHr0MgyeXrC3mrF/DZvHk/29W
	i30XgazLu+awWdxb85/V4vDXN0wObB6bVnUCiU+T2D1OzPjN4vFi80xGj3MXKzw+b5ILYIvi
	sklJzcksSy3St0vgyvj4uo2t4AxPxZy7v1gbGDu4uhg5OSQETCQun93K1sXIAWYfe1UDEuYV
	sJR4d7KdDcRmEVCVmHD3GxtEXFDi5MwnLCC2qIC8xP1bM9hBbGaBGolZl1ewgtjCAp4S5yY8
	ZIaIi0jM7mxjBhkvIuAj0bI8ESQsJBAt8ffdNLAxbAJqEldeTmICsTkFjCWe7DjHCtFqJtG1
	tYsRwpaX2P52DtAYLqArd7BJXNn6iQXifEmJgytusExgFJyF5LxZSFbPQjJrFpJZCxhZVjEK
	ZeaV5SZm5pjoZVTmZVboJefnbmIERsKy2j/ROxg/XQg+xCjAwajEw+twQDdDiDWxrLgy9xCj
	BAezkghv7AqdDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTByc
	Ug2M/vaqzzOMHPJWmU3P1DG7pxZ+Zwvj0Wlm9VNEj+8U3/CxXL956ezsaW+/LWqJCvtxaC27
	pfdD3wuPtX4Y+wZYbLtg/ekzYzm3IfeDSFvf82vrglTzk3U7+l00/bqW8XPzWu3r8nuxvT01
	YiOTxS+vWQmOCy09Uo2TVSovlzr8sJnbzL5jg48SS3FGoqEWc1FxIgAdkgNFgAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXCNUNLTzd1j16GwcOfWhZz1q9hs3jy/zer
	xb6LQNbhuSdZLS7vmsNmcW/Nf1aLw1/fMDmwe2xa1cnmsenTJHaPEzN+s3i82DyT0ePcxQqP
	xS8+MHl83iQXwB7FZZOSmpNZllqkb5fAlfHxdRtbwRmeijl3f7E2MHZwdTFycEgImEgce1XT
	xcjJwStgKfHuZDsbiM0ioCox4e43Noi4oMTJmU9YQGxRAXmJ+7dmsIPYzAI1ErMur2AFsYUF
	PCXOTXjIDBEXkZjd2cYMMl5EwEeiZXkiSFhIIFri77tpYGPYBNQkrrycxARicwoYSzzZcY4V
	otVMomtrFyOELS+x/e0c5gmMfLOQXDELyYZZSFpmIWlZwMiyilEkM68sNzEzx1SvODujMi+z
	Qi85P3cTIzCsl9X+mbiD8ctl90OMAhyMSjy8Dgd0M4RYE8uKK3MPMUpwMCuJ8Mau0MkQ4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYDywu+9mYsXkpyuk
	l9TfOlJ2wjrqjS/PU05FX9YLznvncBouCrhqMuO1z9Fq/X9K4lUGG0u8YybKy856b+F8wCeo
	yraudpX4pG2bNs8/+02nfd3aFbPtTjX96cpeKjHJL77p1tNJnGpzFgqss/saujIt6nrQovVn
	Z24p3KAe3L5oY7FM8KKpkn5KLMUZiYZazEXFiQCJH8O7ZwIAAA==
X-CFilter-Loop: Reflected



On 5/21/2025 1:27 PM, SeongJae Park wrote:
> As of this writing, multiple major distros including Alma, Amazon,
> Android, CentOS, Debian, Fedora, and Oracle are build-enabling DAMON
> (set CONFIG_DAMON[1]).  Enabling it by default will save configuration
> setup time for the current and future DAMON users.
> 
> Build-enabling DAMON does not introduce a real risk since it makes no
> behavioral change by default.  It requires explicit user requests to do
> anything.  Only one potential risk is making the size of the kernel a
> little bit larger.  On a production-purpose configuration, it increases
> the resulting kernel package size by about 0.1 % of the final package
> file.  I believe that's too small to be a real problem in common setups.
> 
> Hence, the benefit of enabling CONFIG_DAMON outweighs the potential
> risk.  Set CONFIG_DAMON by default.

Agreed.

> [1] https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=DAMON
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index c93d0c56b963..551745df011b 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -4,6 +4,7 @@ menu "Data Access Monitoring"
>   
>   config DAMON
>   	bool "DAMON: Data Access Monitoring Framework"
> +	default y
>   	help
>   	  This builds a framework that allows kernel subsystems to monitor
>   	  access frequency of each memory region. The information can be useful

     Acked-by: Honggyu Kim <honggyu.kim@sk.com>

Thanks,
Honggyu

