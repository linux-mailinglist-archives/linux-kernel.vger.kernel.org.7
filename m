Return-Path: <linux-kernel+bounces-887346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05426C37FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137853BA111
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6834D4E1;
	Wed,  5 Nov 2025 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6EqqMOD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC76434E776
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377265; cv=none; b=e+JlwpTx8hGZMP96/OFnwiYk2x8IjU9Zn0MNkmaBex9xs4oNMVe5Ic+GbTzX1eorwx2D0yVDa17maDDcLr5i83ka9oO7VnHILYdtdew3f4XEUdRq63gVArd3zfIaZg/kklbnbqEPe7SaqldAR53cvpYdu8Ix2iz60SGq5PC61+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377265; c=relaxed/simple;
	bh=MQvsWeDQVn/3Ah+sMEwFHizhxAHJ0b7a7QFp7wzzuLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C27Idy64UamwtlfErjDUq43JwpWUIWTFAp6eM7O/SVHwR2j6pV6/yywfgcU7b5TgPjC78kH5Ic6SSOH9Nd4RLrk4cANIt/HyXezpHD4B7emnboHWcwgDF71qJt5rm1cqbNbzlXySTrYsrnpE++bzBTHOx5dJUtx6McmunFNS40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6EqqMOD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so38175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762377263; x=1762982063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1a4Yyw4cqtm7g2w2aJJeYA13ID9gFvTcA7MB5XSqJcE=;
        b=G6EqqMOD4IcpDZUNIFdt9tKaRuF/qFVyHDOmbKdXAUxCAZiCnndsHRisrfuCmsuXQ8
         neDZ5gujTyEmJlgw3Zu7YcNHXzuTl3HON+nfNq+O7Cs4M2QukRERuSoBzG350bvvQsTH
         bBIy5Vhw6Fg7nDRmWdST+1NgMC0+p0M+4ooR4FsgtCGV4E/eNhsFCMynRI4UI3yY4Q+5
         qAE6b9U+i4jKAmfPDYx7PxFa340MlcGZZ/E1vMLWAQ77E9R84tKH+LObR55fya5G3GhY
         WTXSEA2MiL1AwNwlhRP49LCv+3tpSt+C41OBYTWmR1E6yYyft9yVnt17VW9KVBqSdk7O
         ppww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377263; x=1762982063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a4Yyw4cqtm7g2w2aJJeYA13ID9gFvTcA7MB5XSqJcE=;
        b=Ucg36gtb4WyOTVM6GghkJl5+X3wLkdJz9brlbi706OyEISqS1Nh8JQ83Mm2s70F3Yv
         UYCJlxpQLO2ghXyXA1aAnWQIpk63o5yOnhRthRDSyxvdB5ENr0jVatVIhpnnzT7huZWp
         tbEloNVCqfhoLknBpZA+hsLjkRPB0kqmq5vAUV2FqCCmnTRwLJRp+7sc/Np9agfz7KnO
         +/z/G5HO9QUCMFmUiS/JI/E2drxcf50T88eaqHkZEmfVcuURcrI4Xo4TN8F22WCbkhwH
         Qp6n1FVyZSHZFZ/ojDBBeTMgWDEHew5nWmpPtRvylThGIkKjeJ73+pAiS+lVlez61US9
         ZlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/nFxzcXKGwARpabwTSd4BST7g4k7CypK4XlEwiC0YfLnYK5e3JeTCiKZJx34D7aCkdmCmnvQidIF7aig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflID81JroqgdMch+ulEzVbyuqUcT4dUigRMeQiCXJ/0VE1j0E
	bztPvC7YbjhhvbOrJKR8DH6/GkLouV/T6JFUppnJE7/ySxnzVK+dTqw9fW9PPBOj/A==
X-Gm-Gg: ASbGncuTbO6r0W4btgwXsAPSH+JTdqxu3ZEJG3L198MeCm0igfHlE/VCrQuZKtTXAYS
	koGR0eZcA6PYIp2Q/mkeAyrbAXZM6lZo5B6np9A9fuP8ozkjThyvhW9pYd59q+ZeT1hHJtzNOlw
	QYrzP3mEnrNKzVxUB5hMxQ1UNLrk00qMb0ykM8sp3C5gny7ZoGK7tHssEpz1iWQiY+Gmpg7p7dt
	Y5KDy1N24JZe3gZzCG8J0Hg2AxbPJs5l07PC25xL1p/p1IGfrzgpbROac+aZUC+gBtQTgJRlP2P
	ODuzIPFi+cVDh+I80Ny1rbXbgnNPmeoMYYvE4em5lr4leLT2FL3Ms0smsr2iX7NKFpGfjNyHMZR
	Mmu6Py0IHP/DZW6FuE+kfUmSCkWpcE27HNzyQZDrOrfkaIJopfRC3yBDm8VSAa13UvifxzTxKAY
	n1kboMUWm4XAOKMQ1PyLELz1h0WKbAuP97X9arpPEXo9R5LuGo
X-Google-Smtp-Source: AGHT+IFP1YxRkoxKG9m5uY31RvKem02MIvxx/qMo4X6r12qFFAqsYxQUQt6ctZOzHEsowBEgNB2RGA==
X-Received: by 2002:a17:902:e74b:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2965b17e891mr190525ad.7.1762377262520;
        Wed, 05 Nov 2025 13:14:22 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d121cf9fsm21677a91.10.2025.11.05.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:14:21 -0800 (PST)
Date: Wed, 5 Nov 2025 21:14:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
Message-ID: <aQu-Jy27_PzxqVvt@google.com>
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>

On Mon, Nov 03, 2025 at 09:27:55AM -0800, Nicolin Chen wrote:
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
> 
> Changelog
> v2
>  * Add Tested-by from Shameer
>  * Skip vmaster allocation instead of bypassing vsid=0
>  * Revise the uAPI doc to note a corner case when CR0.SMMUEN=1
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 ++++++++++++-
>  include/uapi/linux/iommufd.h                        |  9 +++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 8cd8929bbfdf8..e5fbbdbdea242 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -99,6 +99,8 @@ static void arm_smmu_make_nested_domain_ste(
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain)
>  {
> +	unsigned int cfg =
> +		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
>  	struct arm_smmu_vmaster *vmaster;
>  	unsigned long vsid;
>  	int ret;
> @@ -107,8 +109,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  
>  	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
>  					 state->master->dev, &vsid);
> -	if (ret)
> +	/*
> +	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
> +	 * as CD/ATS invalidations and vevents require a vSID to work properly.
> +	 * A abort/bypass domain is allowed to attach w/o vmaster for GBPA case.
> +	 */
> +	if (ret) {
> +		if (cfg == STRTAB_STE_0_CFG_ABORT ||
> +		    cfg == STRTAB_STE_0_CFG_BYPASS)
> +			return 0;
>  		return ret;
> +	}
>

Skipping the vmaster allocation entirely for the GBPA-only case (when no
vdevice is found) is much cleaner. Thanks!

>  	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
>  	if (!vmaster)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c218c89e0e2eb..225671603ade6 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -450,6 +450,15 @@ struct iommu_hwpt_vtd_s1 {
>   * nested domain will translate the same as the nesting parent. The S1 will
>   * install a Context Descriptor Table pointing at userspace memory translated
>   * by the nesting parent.
> + *
> + * It's suggested to allocate a vDEVICE object carrying vSID and then re-attach
> + * the nested domain, as soon as the vSID is available in the VMM level:
> + * - when Cfg=translate, a vDEVICE must be allocated prior to attaching to the
> + *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
> + * - when Cfg=bypass/abort, a vDEVICE is not enforced during the nested domain
> + *   attachment, to support a GBPA case where VM sets CR0.SMMUEN=0. However, if
> + *   VM sets CR0.SMMUEN=1 while missing a vDEVICE object, kernel would fail to
> + *   report events to the VM. E.g. F_TRANSLATION when guest STE.Cfg=abort.
>   */

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

