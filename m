Return-Path: <linux-kernel+bounces-898680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B2C55BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 518A14E5AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF9303A15;
	Thu, 13 Nov 2025 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PH16gCAQ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE672FFDE3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009900; cv=none; b=Z4OdJLsJWKKajbmX2vBKxQay+VRMksYf6MnqVelac7JP34n6rYNqf0W+N6K6KW+Su01rqy+CKYOqWake7LBg9/xcr/gPTaeb/+RxSVyOjWdBkNq8FhUQ/h80Mh+wbXXPFts85e3IDkDVQYDLTHaJ7qemBA8ubkIeCUvVlUeZOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009900; c=relaxed/simple;
	bh=JXEQ94gC8AKcwEqd0xnmXVsYbCNVVJOdtzUbRtiW0OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhMZ+PuLguYMpiB3ZxXInUFS5r5fz9/AP8RSd27gt9G/rqzObgGR/b+IeeYjOQDVMd8SECv7HZhUlbMCfYCkKG1J7wTjmmnZOiVOM2MB3FqCLtkNUc3Ow3xrmfOy7nxHYTNor98n0q6pnhNkmc0vVM3Q611F5qibHu+Ee/QSVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PH16gCAQ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763009895; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+MkJwqqWw91q4/ackBiFDAnwT9h6GJR0xtDRL8ERyWE=;
	b=PH16gCAQBZRR9dnEVZp89ZvLPCdM8nGVJo2N4dXpG6g7K2F30GRygSPq/89WWT2wH1N1E2S12pOFCQQMsGJm8HtaiOlWycKfYja45+idg18Z573XVVPO7a6CPC5z0Z8bxVsfZXbEtf/CNTCEnokGRsOqmZ9YPuARwRMn0fWnPpQ=
Received: from 30.246.165.27(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WsIBh2L_1763009894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Nov 2025 12:58:15 +0800
Message-ID: <f4a17ceb-06cc-4ef9-93cf-430b60cb7599@linux.alibaba.com>
Date: Thu, 13 Nov 2025 12:58:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, kevin.tian@intel.com,
 praan@google.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, skolothumtho@nvidia.com
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 01:27, Nicolin Chen 写道:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
> or bypass vSTE. Note that device on this attachment won't report vevents.
> 
> Update the uAPI doc accordingly.
> 
> Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

I've tested this patch and can confirm it resolves the GBPA hwpt
attachment issue.

Without this patch, IOMMUFD fails to attach bypass hwpt with the
following error:

   smmu_reset_exit
   qemu-system-aarch64: [iommufd=303] error attach 0008:01:00.0 (304) to id=6: No such file or directory
   Failed to attach GBPA hwpt id 6 for dev id 1

With this patch applied, the attachment succeeds:

   smmu_reset_exit
   iommufd_cdev_attach_ioas_hwpt  [iommufd=303] Successfully attached device 0008:01:00.0 (304) to id=6

Testing was performed on top of Shameer's vSMMU v5 series:

   https://patchew.org/QEMU/20251031105005.24618-1-skolothumtho@nvidia.com/

Tested-by: Shuai Xue  <xueshuai@linux.alibaba.com>

Thanks.
Shuai

