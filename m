Return-Path: <linux-kernel+bounces-711347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB2DAEF978
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CAB3AFDF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E782741D5;
	Tue,  1 Jul 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4gu9nhB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1A273D93
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374730; cv=none; b=bnSqaMa/7LjHfeRLNfsimBJJPNF1qPqprdb/sfm/bk46Ot0v2il06xY/S7PHTvhrG0vOcVaGz5WaXXTwdk0h33HexE3Dx6W5YCp/CMiL55cL0275fRdS63ZDixXSjObis8KV0VLlHO+CI7yP5w9MdhlcJCZFfdI+zkRUQ2BlXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374730; c=relaxed/simple;
	bh=QVjsIYXh5KgkJGxwJvk1fAvS8lppUJ46HEMqAQrLa48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwB0m4VhX1TSGIfCfDqFOUqJt3diaflMNmBe6M3ZSiSoCqo5YdKcLH2b3HYjG1ZKVHxNjLygRao87raQ7Ahy+RZfgyQQUieczsVGjeFcOs+mJ/lNBLe5oTFDt3QnG+fYWmaTxJjkrTAxTFV1KGmAdoMDduxFMWkYU9y1TOwitvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4gu9nhB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e389599fso211995ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751374727; x=1751979527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzw4uNd5li2mXa+WfFMUaVuwZFHwRlbcR3UhOImbWD4=;
        b=i4gu9nhBzr9Bv2fhK58DYR9nxXSJBlsM/dx4IVDNn8oHQsRe2Pj5wgjqAPyORlznQJ
         s+Uad4DKvNYNA5ee/0whonugBBVxTIHyb7ujZwUXTnkhGXBPWwuvKBrWaIZqW1U8ldlW
         869DkG+c6BJUT2N/DYVYqJbq9gZlbBvPBdhebVIS+CvIPIi/QnYpWUOqQyI84jKCLigX
         1Zbn3B8kdO6bjwWCICWic0SRwyPRGCF9/qo8Y/07DgkSb6O8oyJ08oHbA9roBWhYd18r
         Fj7nMR/otldZEk/BpXryRIX2IVCBPVH4dlpXxdmCCWFwljPbWO23+wxrZ5Jwo79bn/vK
         fNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751374727; x=1751979527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzw4uNd5li2mXa+WfFMUaVuwZFHwRlbcR3UhOImbWD4=;
        b=gkfK2Iq3F27EwznJuKVmHrvfCF48LitCBdiR7+hCILsCby/ZwdyahraQ9lXntVX94A
         TKFBbnmd2ZChKZ9ZTLpObgk8NQJoe7UCqvECeflswsc+3yyEYVRviWi19O1/Y+3578u3
         i8MlBB+n6u9EVMatX5cKJ+24+Ci889dYRi9jLt2LeUu+JqihiAI/gOfB+wOwY9G6rjdZ
         yJSxCIV9zbYMpTnJGrs8YlszI1y32vflWdSmMBRsFyTvKMtETFhJbrypDYxwxmWNAlyE
         vLLb/HMQqmr21yRfYQHFBni5e8qha1/GFujRYUUCryB7mERmVY97iFb+OtyiNKQsoET7
         mASQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL0e4cx71YX90gkhMXldspm+aUHdjJw3yUmRd3Czz0rVuimsqK42eh37EZ2H1D2jf3MAFT25NqzFUGOzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKK1/3sKmXc5cBiaK1o2ZpHzZMpQL+JI6q+NP3vvZhQ/u/3oJO
	+XYPr0BCCp9tIEc/W5MLsBhSnuyXzUK8mCqTQMkQb7L4s5IFkSRl/JPAisvwcUF8Sg==
X-Gm-Gg: ASbGncuXQbH8QUH0krXa4RgRrTXIkTVvczOIoFbCqEY6ln7EKJmba7C58mCknrgDyQQ
	Z9N2xfYhmEFZ6YLDhvGPLXKoLaWU6DYUvGXGH8VEYczubjX4qMgeNLodEpsfDwVttX8BnGI7Pnf
	3kOUXjM4cZcqQHEBHTJezZAXxMHR25F2v0FFM1ddMHLBLyeuPiAT/UAW1KbmqvTKVblCuIsAT6v
	yhCp54kvEch4ebYqLHTkCqn/SzwHBubt/WeQoWYbh3voVLtoi8JmzLXRVMn5EIQD1pyzgd+4y0Q
	MqC3r3spCus2dT5/g2NSB9buvNyW8o6mNtjqaxOFIWow6j8UZdCm5+9WHEU6yNqcleWqpCOPsMI
	FV5cBcogTpkKRccyir26MuLDgVjN7sYw=
X-Google-Smtp-Source: AGHT+IGmj2MAzmEBH+PWX1NsLuSUKrLgxpjLMp3KA3CIsShNt/Sqit3dWlHjLZzB1pekp9REtBE7WA==
X-Received: by 2002:a17:902:f70b:b0:234:bca7:2934 with SMTP id d9443c01a7336-23c5fef098cmr2059855ad.6.1751374726581;
        Tue, 01 Jul 2025 05:58:46 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bcbcsm104502905ad.134.2025.07.01.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:58:45 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:58:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 20/28] iommufd: Allow an input data_type via
 iommu_hw_info
Message-ID: <aGPbfM2iZP7ww1fC@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <ebbcdf1437bd1f96aa76e9132eba3c68472403c3.1750966133.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbcdf1437bd1f96aa76e9132eba3c68472403c3.1750966133.git.nicolinc@nvidia.com>

On Thu, Jun 26, 2025 at 12:34:51PM -0700, Nicolin Chen wrote:
> The iommu_hw_info can output via the out_data_type field the vendor data
> type from a driver, but this only allows driver to report one data type.
> 
> Now, with SMMUv3 having a Tegra241 CMDQV implementation, it has two sets
> of types and data structs to report.
> 
> One way to support that is to use the same type field bidirectionally.
> 
> Reuse the same field by adding an "in_data_type", allowing user space to
> request for a specific type and to get the corresponding data.
> 
> For backward compatibility, since the ioctl handler has never checked an
> input value, add an IOMMU_HW_INFO_FLAG_INPUT_TYPE to switch between the
> old output-only field and the new bidirectional field.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h   | 20 +++++++++++++++++++-
>  drivers/iommu/iommufd/device.c |  9 ++++++---
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 6ad361ff9b06..6ae9d2102154 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -628,6 +628,15 @@ enum iommufd_hw_capabilities {
>  	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
>  };
>  
> +/**
> + * enum iommufd_hw_info_flags - Flags for iommu_hw_info
> + * @IOMMU_HW_INFO_FLAG_INPUT_TYPE: If set, @in_data_type carries an input type
> + *                                 for user space to request for a specific info
> + */
> +enum iommufd_hw_info_flags {
> +	IOMMU_HW_INFO_FLAG_INPUT_TYPE = 1 << 0,
> +};
> +
>  /**
>   * struct iommu_hw_info - ioctl(IOMMU_GET_HW_INFO)
>   * @size: sizeof(struct iommu_hw_info)
> @@ -637,6 +646,12 @@ enum iommufd_hw_capabilities {
>   *            data that kernel supports
>   * @data_uptr: User pointer to a user-space buffer used by the kernel to fill
>   *             the iommu type specific hardware information data
> + * @in_data_type: This shares the same field with @out_data_type, making it be
> + *                a bidirectional field. When IOMMU_HW_INFO_FLAG_INPUT_TYPE is
> + *                set, an input type carried via this @in_data_type field will
> + *                be valid, requesting for the info data to the given type. If
> + *                IOMMU_HW_INFO_FLAG_INPUT_TYPE is unset, any input value will
> + *                be seen as IOMMU_HW_INFO_TYPE_DEFAULT
>   * @out_data_type: Output the iommu hardware info type as defined in the enum
>   *                 iommu_hw_info_type.
>   * @out_capabilities: Output the generic iommu capability info type as defined
> @@ -666,7 +681,10 @@ struct iommu_hw_info {
>  	__u32 dev_id;
>  	__u32 data_len;
>  	__aligned_u64 data_uptr;
> -	__u32 out_data_type;
> +	union {
> +		__u32 in_data_type;
> +		__u32 out_data_type;
> +	};
>  	__u8 out_max_pasid_log2;
>  	__u8 __reserved[3];
>  	__aligned_u64 out_capabilities;
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 64a51993e6a1..cbd86aabdd1c 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -1506,6 +1506,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, "IOMMUFD");
>  
>  int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  {
> +	const u32 SUPPORTED_FLAGS = IOMMU_HW_INFO_FLAG_INPUT_TYPE;
>  	struct iommu_hw_info *cmd = ucmd->cmd;
>  	void __user *user_ptr = u64_to_user_ptr(cmd->data_uptr);
>  	const struct iommu_ops *ops;
> @@ -1515,12 +1516,14 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	void *data;
>  	int rc;
>  
> -	if (cmd->flags || cmd->__reserved[0] || cmd->__reserved[1] ||
> -	    cmd->__reserved[2])
> +	if (cmd->flags & ~SUPPORTED_FLAGS)
> +		return -EOPNOTSUPP;
> +	if (cmd->__reserved[0] || cmd->__reserved[1] || cmd->__reserved[2])
>  		return -EOPNOTSUPP;
>  
>  	/* Clear the type field since drivers don't support a random input */
> -	cmd->out_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
> +	if (!(cmd->flags & IOMMU_HW_INFO_FLAG_INPUT_TYPE))
> +		cmd->in_data_type = IOMMU_HW_INFO_TYPE_DEFAULT;
>  
>  	idev = iommufd_get_device(ucmd, cmd->dev_id);
>  	if (IS_ERR(idev))

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> -- 
> 2.43.0
> 

