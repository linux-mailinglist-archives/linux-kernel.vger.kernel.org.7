Return-Path: <linux-kernel+bounces-888099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BAC39D70
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95764EE0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D28F2FFF99;
	Thu,  6 Nov 2025 09:36:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3B5266B66
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421799; cv=none; b=N/6nCAGwaYB+3tUuwwu9YfBCMbBiXjXwU8kX/AT4CV555qpxELE56Sd7am5dH5KWo8DNkt6lM0Dzs4JCR2F4JvNIZ5PQc/OqLAieqcHHemXtWHVHEC8PZWTKE03mMssmWI4ncydDYJg/5QeVGCpCm2Bng1qx4Di5IAWARKBtbzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421799; c=relaxed/simple;
	bh=70yxIt6bKMGQJcBtDHtZsRT/fntqcZbcd0DrCF/dN1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pa0ZBm08QgwgPPnsycDLssK9cPyi0vrc+nN/xmMHiI4HV3/dGqHHIwarF8YSaioi+sFDvyyqI9t8BB3QmoRdr/tYDduBGbxVYylW9JDKCddMT7GA0sfERqWvk5RjtjQ7KPFYdMK0jsg81MOBAAiTiJ48hQQ/CNcp5BIrkW+2bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE5251595;
	Thu,  6 Nov 2025 01:36:28 -0800 (PST)
Received: from [10.163.73.244] (unknown [10.163.73.244])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 333AB3F63F;
	Thu,  6 Nov 2025 01:36:33 -0800 (PST)
Message-ID: <2be8882d-08eb-4d7d-a846-d29406858bcc@arm.com>
Date: Thu, 6 Nov 2025 15:06:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: cleanup vma_iter_bulk_alloc
To: Wentao Guan <guanwentao@uniontech.com>, Liam.Howlett@oracle.com
Cc: vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com
References: <20251106063424.3381872-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251106063424.3381872-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/11/25 12:04 PM, Wentao Guan wrote:
> commit d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()"),
> remove the only user and mas_expected_entries has been removed,
> since commit e3852a1213ffc ("maple_tree: Drop bulk insert support").
> 
> No functional change.
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/vma.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/vma.h b/mm/vma.h
> index 9183fe5490090..4aa72c7e94400 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -498,12 +498,6 @@ static inline unsigned long vma_iter_end(struct vma_iterator *vmi)
>  	return vmi->mas.last + 1;
>  }
>  
> -static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
> -				      unsigned long count)
> -{
> -	return mas_expected_entries(&vmi->mas, count);
> -}
> -
>  static inline
>  struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
>  {
> 
> base-commit: dc77806cf3b4788d328fddf245e86c5b529f31a2


