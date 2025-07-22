Return-Path: <linux-kernel+bounces-740050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E03AB0CF10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD31C2070C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99888191493;
	Tue, 22 Jul 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o4gphrwF"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550D1547EE;
	Tue, 22 Jul 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753147826; cv=none; b=vFVZz9sOVm1KrWzv8HG+tAwXxI7Gzf7nTvCM0DU5QBo06NUYohf8nJgA0nyad1IuHY139os+tFojcZoRgV2pV+E94OOI8g+UXN9qPsqX5QNHquS/qiS+xcU4/YhTWJtKWcF9gnOYC5urxLVPLgYgl4nfYSoHLMfixpbAwZ5Nuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753147826; c=relaxed/simple;
	bh=RXPL4ry4HcaZwFaVrwlx1/NTG0wnNsLOEinZ+HERIrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXGi3nz0c4eFa6t/Nr5Ojy4kjANTp/EnCcHgr2WhAyZ/NHhAoDvZBzlrEXkj+HwYRiFVQR5YJxk8r708AP6C/VipVT+86JxVv6IEUwGWWCMv8gfdAlSA1yO05Eh/Bj9dGempH7pJfeM++W8/EKST7XdegZ18AoGklBAgQNheRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o4gphrwF; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753147820; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yDsSa2vpjdL6lUQSt7fc1x97fEipTiYa9vEWTQ5DbBQ=;
	b=o4gphrwFiXp9nizZMQiw+jqj6vAvh6WC5WSuMc+fux5+3av9CyYTCr2l17kLOpkKVzxMkeQ6dDqSRbGAok6VGNCydL2grKGY+goZAvh1jmxefLiIVEuiTTqHd4DyoJoa15k9kRzKh9s59TqFLGXL16e3cvnuj3F7Hp8vo/m6t/k=
Received: from 30.74.144.108(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjTedEk_1753147818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 09:30:19 +0800
Message-ID: <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
Date: Tue, 22 Jul 2025 09:30:18 +0800
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/21 23:55, Lorenzo Stoakes wrote:
> Rather confusingly, setting all Transparent Huge Page sysfs settings to
> "never" does not in fact result in THP being globally disabled.
> 
> Rather, it results in khugepaged being disabled, but one can still obtain
> THP pages using madvise(..., MADV_COLLAPSE).
> 
> This is something that has remained poorly documented for some time, and it
> is likely the received wisdom of most users of THP that never does, in
> fact, mean never.
> 
> It is therefore important to highlight, very clearly, that this is not the
> ase.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index dff8d5985f0f..182519197ef7 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -107,7 +107,7 @@ sysfs
>   Global THP controls
>   -------------------
>   
> -Transparent Hugepage Support for anonymous memory can be entirely disabled
> +Transparent Hugepage Support for anonymous memory can be disabled
>   (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
>   regions (to avoid the risk of consuming more memory resources) or enabled
>   system wide. This can be achieved per-supported-THP-size with one of::
> @@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-THP-size with one of::
>   where <size> is the hugepage size being addressed, the available sizes
>   for which vary by system.
>   
> +.. note:: Setting "never" in all sysfs THP controls does **not** disable
> +          Transparent Huge Pages globally. This is because ``madvise(...,
> +          MADV_COLLAPSE)`` ignores these settings and collapses ranges to
> +          PMD-sized huge pages unconditionally.
> +
>   For example::
>   
>   	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> @@ -187,7 +192,9 @@ madvise
>   	behaviour.
>   
>   never
> -	should be self-explanatory.
> +	should be self-explanatory. Note that ``madvise(...,
> +	MADV_COLLAPSE)`` can still cause transparent huge pages to be
> +	obtained even if this mode is specified everywhere.

I hope this part of the explanation is also copy-pasted into the 
'Hugepages in tmpfs/shmem' section. Otherwise look good to me. Thanks.

