Return-Path: <linux-kernel+bounces-883067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F89C2C695
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E76954E3BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A803128D8;
	Mon,  3 Nov 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1YNP1cE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F54311976
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180182; cv=none; b=MWxEa+ZYyjx3qvOUewysIpzrVAIOE7XNfXZe1wtfK99QjuqNfXzJ5EzIGaUUIrU7vlS9M50MDf6ygUOVcO9W/z5p2Uo49Dcx7z6XKXly8qhiRjy8yrI4no5OkgBH9YgkDPjgLjuCVSZ2JaOf/QfGXBPi53esa9I8b48OMC+50Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180182; c=relaxed/simple;
	bh=kopMZhSSVjSpU7vbwiXfUO/3/NCj6jgZ4saCZU03NSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb9pXH14XHlExM+3MLUzUgwRq4gAkjzehxoI39KJEMvTgMTXVdD/Y/xVgC1wtqXA1D9jDzUBmlcDXxPQPnbmZiOp50nLrUhGwOtbNd1UuWs7WOey/3ZD/FEiQmFncN+oBB4FjnxBb1wQh9HPuMIfdT+Tgjh+u9gMPZdlmgYAmEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1YNP1cE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2959197b68eso279155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762180180; x=1762784980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ss4O/i4KxhkbN9o8nJ4rRjGt4fkGep+vaOCctZv7Y=;
        b=f1YNP1cEaMPE5m0oiVJeEfxerb1ZgrveP/HD4+83zyNOIQ6pkKYSPRYNYLumT1uCQ6
         a7c6TjNNYCblweRZCysFJJbPI0yX2uhHg3JhCHDBRnJMIbokKUibPAl4q7XxKx5k8WA9
         rbPsolVrQV7thK570BgZnmyJokCkZFBPyeKmtltgcbJZrPX5Wr3TlAnRDE5qyXYO4lxF
         5vMEmfQ9+AFRoESzkiScUFBYKKLT2wN0Gp//ZdHXG7otzZ044OtzoSWQzHJZl3Ht/AMc
         KA8VfHt2q7cqqfWt1NHM3TFVvmytZCcAEy+YrLvVi0ToCPNWfVjIX8R6WO6goM60otqq
         48uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180180; x=1762784980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2ss4O/i4KxhkbN9o8nJ4rRjGt4fkGep+vaOCctZv7Y=;
        b=UNJkRdffwS9cdUz1n2ekvRwzfjnuAPyRKCeTldyPEi/yYYpAzva4ozGvXp2FW9XxnZ
         cn1yb4c/59N5Opq6TfBzAIC+LqcnOYPxYzi8NeMTGrKPkRle3Wz35+98QwLJ8BPYq5vS
         c5kXPNyhOmX7dEt81FF7ToQ0gJUK9QrJEfT+gh5V+LO/j+Bu6Vtk/DaIpcQD3rf4x1Xe
         pU2IN3imF7Ctuhwy+BOzidt7G57ERdLegDN9fvj8eUC2aVWE4kL7ixt4A7hppZvchDGA
         gNyNraCooUvLzFU8WDaELyetyJRjOsnu9tBzm4/sALuzFd5MTMmV5Rys/Z6CDeTJ5BVl
         85HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiBid7jvOpdTaAroPPc1K1T9K6Sfzh/9UIjDmNERyNA8lnVJjZZHh2FJu3fPN7x4b+456V3usbWwl3LQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZybnWC3TjON00NK52gACcceQBM8HigoMX0nWBf1nXdK48ozE
	+S7j7m32Uo3ojv5piyZKPPH9C/JYVLvXiYD2qiqSXGFehxGYCtsLutQsSt4jluV4Ww==
X-Gm-Gg: ASbGncv3uKi/1coHDbcDEPF45dX89UOi8tKn1pfNrBrl5AagLtdkU4iKKrrQYlMuOHC
	FnikPNRhTPScADULVQl/aOcH8+uK1jbqEWzrmwdHshirp5oWB6zaPNnrLhLHQG9aZ4BOB6Bgydj
	Nbc+S8yP9AofM1ImkVjkxt82bRKAf5mQjyBhk49JSL9rMvZwO9Cuic/Zmc7evuehC+c1fpc+1rK
	ouQ+oADU+MILvPIOTr60OEpfkmg50RnyvGZD1TsAmFyDITM/ZUr9XAYFSeN+h5r9ZW6UWTw3+Fv
	HwzFDgOsAE8movmi0cLy/Q9cyjZ/GflH3KDseiyDnW50IGFYRW3y46RPitH7b/Q0+YWBS0CwQKV
	MoySGUw9w1uVH4XnY4CAWEWHo60t65+F53F0Lb8o13E4ZyRLSxBdtMqTHLaji/MmfUbEY8JE4sX
	btinDYdoqOSVNEjp71AYFIB9WAd/oBYG7tWyA69A==
X-Google-Smtp-Source: AGHT+IGgprIYvEObzhmjpC9qpNiNgXC4S+j2D9xeUV3N2fiXTSvqkcZt/SDTOp4IK0p25zBW1FXM7Q==
X-Received: by 2002:a17:902:e548:b0:26a:befc:e7e1 with SMTP id d9443c01a7336-29554bab74amr6694685ad.12.1762180179869;
        Mon, 03 Nov 2025 06:29:39 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29556d61c4dsm87954645ad.56.2025.11.03.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:29:39 -0800 (PST)
Date: Mon, 3 Nov 2025 14:29:34 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3-iommufd: Allow attaching nested domain
 for GBPA cases
Message-ID: <aQi8TivdgmtAyb7v@google.com>
References: <20251024040551.1711281-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024040551.1711281-1-nicolinc@nvidia.com>

On Thu, Oct 23, 2025 at 09:05:51PM -0700, Nicolin Chen wrote:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Add an additional condition in arm_smmu_attach_prepare_vmaster(), to allow
> a bypass or abort vSTE working for a GBPA setup. And do not forget to skip
> vsid=0 when reporting vevents, since the guest SMMU in this setup will not
> report event anyway.
> 
> Update the uAPI doc accordingly.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 14 ++++++++++++--
>  include/uapi/linux/iommufd.h                       |  7 +++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 

Overall, the approach seems fine as it adds value since we can't have
vSMMUs with ABORT / BYPASS config with the current code.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 8cd8929bbfdf8..7d13b9f55512e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -99,15 +99,22 @@ static void arm_smmu_make_nested_domain_ste(
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain)
>  {
> +	unsigned int cfg =
> +		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
>  	struct arm_smmu_vmaster *vmaster;
> -	unsigned long vsid;
> +	unsigned long vsid = 0;

I'm a little confused here, can we not have a vDEVICE allocated with
vSID = 0 ?

IIRC, vsid is given the value of vdev->virt_id, whereas vdev->virt_id is
allocated in iommufd_vdevice_alloc_ioctl() using the user-provided
cmd->virt_id.

Thus, should we mention this in the uAPI that vdev->virt_id 0 is reserved?

Because otherwise, a VMM may actually allocate a vDEVICE with vSID = 0
(which iommufd currently allows) and we'll start dropping its events
due to the if (!vmaster->vsid) check below. This would be a functional 
regression for such a VMM.

Perhaps a separate bool has_vdevice flag in struct arm_smmu_vmaster
would be clearer and avoid this ambiguity, allowing vsid = 0 to be a
valid ID for an allocated vdevice when user-space explicitly requests it?

>  	int ret;
>  
>  	iommu_group_mutex_assert(state->master->dev);
>  
>  	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
>  					 state->master->dev, &vsid);
> -	if (ret)
> +	/*
> +	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
> +	 * as CD/ATS invalidations and vevents require a vSID to work properly.
> +	 * A bypass/abort domain is allowed to attach with vsid=0 for GBPA case.
> +	 */
> +	if (ret && cfg == STRTAB_STE_0_CFG_S1_TRANS)
>  		return ret;
>  
>  	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> @@ -460,6 +467,9 @@ int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
>  
>  	lockdep_assert_held(&vmaster->vsmmu->smmu->streams_mutex);
>  
> +	if (!vmaster->vsid)
> +		return -ENOENT;
> +
>  	vevt.evt[0] = cpu_to_le64((evt[0] & ~EVTQ_0_SID) |
>  				  FIELD_PREP(EVTQ_0_SID, vmaster->vsid));
>  	for (i = 1; i < EVTQ_ENT_DWORDS; i++)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c218c89e0e2eb..a2527425f398b 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -450,6 +450,13 @@ struct iommu_hwpt_vtd_s1 {
>   * nested domain will translate the same as the nesting parent. The S1 will
>   * install a Context Descriptor Table pointing at userspace memory translated
>   * by the nesting parent.
> + *
> + * Notes
> + * - when Cfg=translate, a vdevice must be allocated prior to attaching to the
> + *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
> + * - when Cfg=bypass/abort, vdevice is not required to attach to the allocated
> + *   nested domain. This particularly works for a GBPA case, when CR0.SMMUEN=0
> + *   in the guest VM.
>   */
>  struct iommu_hwpt_arm_smmuv3 {
>  	__aligned_le64 ste[2];
> -- 
> 2.43.0
> 

Thanks,
Praan


