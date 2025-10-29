Return-Path: <linux-kernel+bounces-876427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50489C1BCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA90660A30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94452DAFAB;
	Wed, 29 Oct 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vO9eJtLd"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8492D94B4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749084; cv=none; b=f+rJi/70txGIsGMLeFh97wXeu8QoHuYvaW+0/tA4yKDZjSqoEk2SlQNPjXr8/oO3aOAiPqk+lDQ/NFZeF9HoeCMzUelGiIz7IxIiTZZ6wIEdo+8QzeBMEhTupcodG8G2wUmdxB+dYcYR4AyFnRsKJxCMbKPOjHMzHoOVtzR0qJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749084; c=relaxed/simple;
	bh=KbzdHXEbVlDlQVEHVqxCj8rf4GQt2DPt4Mr2sPu2bWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1xhbTIWU2EeXkr1VfUIF58G8LH9jGAtZfbecVsDWPm5WUgTxqzJqle8aGXqqacuVvO5jnd/ORK2cqNIEs0/0lCvvkqQbwUIpLTTlUit9a/3cZ2umyp0nUa9I4xfHoF3tPAIbH80lAgd548XnuZQhc9ZduIxvo5ChvDDxfUfk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vO9eJtLd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761749077; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3zGx80a4YZeGrER8I7XszlHOAinQWCndn8ZE8cKElfg=;
	b=vO9eJtLdM2DfgsWd0dwpEL8k2bwAr9VYpy5nwUeElwe8J23kcxAqKYUOw9XAAvrF0dPsn8V97X4fPCnAtPpFpAev6fmnulafGxi5EqK9BrsQNC+SZ38ERFXWPs/X4CJbex0DtJifEnvs/QZ1/h5mW6mrhkOVQx1BTrH5K2NI9UI=
Received: from 30.246.176.102(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WrGMq3h_1761749076 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 22:44:37 +0800
Message-ID: <a63db6a8-e9d8-4f79-8212-8710ce2e60f4@linux.alibaba.com>
Date: Wed, 29 Oct 2025 22:44:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in
 iommufd_ioas_map
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
 <20251029133434.GL760669@ziepe.ca>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251029133434.GL760669@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/29 21:34, Jason Gunthorpe 写道:
> On Wed, Oct 29, 2025 at 08:52:26PM +0800, Shuai Xue wrote:
>> The iommufd_ioas_map function currently returns -EFAULT when attempting
>> to map VM_PFNMAP VMAs because pin_user_pages_fast() cannot handle such
>> mappings. This error code is misleading and does not accurately reflect
>> the nature of the failure.

Hi, Jason,

> 
> Sure, but why do you care? Userspace should know not to do this based
> on how it created the mmaps, not rely on errnos to figure it out after
> the fact.

We run different VMMs (QEMU, Kata Containers) to meet diverse business
requirements, while our production environment deploys various evolving
kernel versions. Additionally, we are migrating from VFIO Type 1 to
IOMMUFD. Although IOMMUFD claims to provide compatible
iommufd_vfio_ioctl APIs, these APIs are not fully compatible in
practice. For example, with VFIO_IOMMU_MAP_DMA, iommufd_vfio_map_dma
doesn't support MMIO mapping, and we can only rely on the implicit
EFAULT error from pin_user_pages_fast(). (I initially considered adding
explicit checks in iommufd_vfio_map_dma, but I noticed you plan to add
dma_buf support there.)

While we certainly aim for a seamless migration from VFIO Type 1 to
IOMMUFD, as you know, this isn't always feasible.

For GPU-related issues encountered in production, the debugging path is
quite long - from business teams to virtualization teams, and finally to
our kernel team.

Therefore, having explicit checks with deterministic error codes
returned to userspace would be greatly appreciated.

> 
>> +static bool iommufd_check_vm_pfnmap(unsigned long vaddr)
>> +{
>> +	struct mm_struct *mm = current->mm;
>> +	struct vm_area_struct *vma;
>> +	bool ret = false;
>> +
>> +	mmap_read_lock(mm);
>> +	vaddr = untagged_addr_remote(mm, vaddr);
>> +	vma = vma_lookup(mm, vaddr);
>> +	if (vma && vma->vm_flags & VM_PFNMAP)
>> +		ret = true;
>> +	mmap_read_unlock(mm);
> 
> This isn't really sufficient, the range can span multiple VMAs and you
> can hit special PTEs in PFNMAPs, or you can hit P2P struct pages in
> fully normal VMAs.
> 
> I think if you really want this errno distinction it should come from
> pin_user_pages() directly as only it knows the reason it didn't work.
> 

Aha, I see. Thank you for pointing out this issue. The check indeed
needs to be more comprehensive. Do you mind use pin_user_pages() as a
precheck?

Thanks for quick reply.

Best Regards,
Shuai

