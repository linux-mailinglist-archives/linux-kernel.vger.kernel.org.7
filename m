Return-Path: <linux-kernel+bounces-740224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457DB0D193
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00E26C144F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051C28D85C;
	Tue, 22 Jul 2025 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iz36moVP"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2F28B507;
	Tue, 22 Jul 2025 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163996; cv=none; b=j/cNOkHMfXriMpudbEeJC2J7vzRCfWndFtLeKY85zdxImiwMSpSXTh/Ons5/maofCGUm3TclsfwzkLCn/CfyewEPy9QU4eCsEJiHvhiXYdMh/Qa4kjg3lroc7d7EO6iRpLEpf/f+hwo4K8JqhH5y06BCYewqk/fKViSiEusSbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163996; c=relaxed/simple;
	bh=hdMrxJ8Zr6JIBWaI8Iy3x33b6Iff3LdwD8t3CXUT3SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYVbsyRAKmnGWGgGDf7Zki46M5qbPda3TAMzPWFT3zUsdV8I1AoJo56t//XOcLw/AiCFYxZKDUeURBszHOslIpwDCWXQ12T5/xwobNKBNATu5/h7THGbEziK3dsxajRBMo5j/xFoD9NF8XtRJwYyWfAA/W5U+1lxGLLBzTdehO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iz36moVP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753163984; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ySiCGZAtj55OzR0IrY3iVRy0mm6ioSQe3uf0JRqArwE=;
	b=iz36moVPk2dom6dlJW1RxPVksiKYXMFR7OaliGSOZvdR846s+UnDp8lR99WKY9bZgbYL+ZR0Xu066un1nnKJr2eBeT1clycTRErjV+qnTwxqqA7GzraDhj9xhQj3MXfk5AXmv57LKuTEhhCOH8xOnwnH7rZ9qCi9HcIznvfaEyE=
Received: from 30.74.144.108(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjUhTET_1753163982 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 13:59:43 +0800
Message-ID: <bea04294-3302-42f1-ade1-e4ec6aa80b99@linux.alibaba.com>
Date: Tue, 22 Jul 2025 13:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never"
 setting
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <d54d1dfb-f06d-4979-983b-73998f05867e@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <d54d1dfb-f06d-4979-983b-73998f05867e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/22 13:34, Lorenzo Stoakes wrote:
> Hi Andrew,
> 
> Could you apply this fix-patch? It adds the caveat regarding MADV_COLLAPSE in a
> couple other places whwere the sysfs 'never' mode is mentioned.
> 
> Thanks, Lorenzo
> 
> ----8<----
>  From 7c0bdda6a633bc38e7d5a3b0acf2cef7bdc961af Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Tue, 22 Jul 2025 06:32:18 +0100
> Subject: [PATCH] docs: update admin guide transhuge page to mention
>   MADV_COLLAPSE everywhere
> 
> We previously missed a couple places where the 'never' mode was described,
> put the caveat regarding MADV_COLLAPSE in these locations also.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 182519197ef7..370fba113460 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -385,7 +385,9 @@ always
>       Attempt to allocate huge pages every time we need a new page;
> 
>   never
> -    Do not allocate huge pages;
> +    Do not allocate huge pages. Note that ``madvise(..., MADV_COLLAPSE)``
> +    can still cause transparent huge pages to be obtained even if this mode
> +    is specified everywhere;
> 
>   within_size
>       Only allocate huge page if it will be fully within i_size.
> @@ -441,7 +443,9 @@ inherit
>       have enabled="inherit" and all other hugepage sizes have enabled="never";
> 
>   never
> -    Do not allocate <size> huge pages;
> +    Do not allocate <size> huge pages. Note that ``madvise(...,
> +    MADV_COLLAPSE)`` can still cause transparent huge pages to be obtained
> +    even if this mode is specified everywhere;
> 
>   within_size
>       Only allocate <size> huge page if it will be fully within i_size.
> --
> 2.50.1


