Return-Path: <linux-kernel+bounces-780419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62909B301A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02EF1787F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16364342CA9;
	Thu, 21 Aug 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfecmwHs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132220B80B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799282; cv=none; b=dOcQgxj3Uj0dZg86zhh5iS9sNbRizQlVQ28w5F8vK00dLjH0lQR6GHxPvPcdhv2Nce+gCtPxhJM9uvgosxD7GQa98kmFivSbGlp3b1Xy8G/Ybxthr4PhFOplc47b+i1C42VTy/QAhtEzUpymjkLEruw5GGfMdIMwDhcRgFthr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799282; c=relaxed/simple;
	bh=rwrZ1MK9qMs6TAwoTdtGZ/Fp86rXufY46UnJ0SYOrhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1S7HQ36hdbVYORbi3HTCmUUlK1YChxTe4XB3xywjAGN8WDl1fHHNDxTaZQDeJClAQb6/TAg56BnsgUK6AoxSbcwn2ZIvYj0VH3KteNbrTBrwv5E82p/crQuGev7Zdg/BS+FP1FYxqoGQJT7m54mg3FAZrDFLhZL7j/Y0InEGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfecmwHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755799279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jf3vORzvfVQScDyhKM9vvrzvYH2efDDECf9Y/ePn7L0=;
	b=VfecmwHsj+iILRLpIoV87aJqSx4qTeHWEqSUNl8B0QLYC92BlL4FlWQvDZm6bbH8UKY1Py
	SaUAsBaTi9WBCQRV3nvXDgq7y3xyxJm8+Wvu4OLc1Z8vdlvd6mpKVfqrbNvN3hnyWMTsCg
	3vlEwS/GZxWZIUFLrCSIwVqN0RJ5uCY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Gbp7i_YmMrqZ0uFOW7rSzw-1; Thu, 21 Aug 2025 14:01:17 -0400
X-MC-Unique: Gbp7i_YmMrqZ0uFOW7rSzw-1
X-Mimecast-MFC-AGG-ID: Gbp7i_YmMrqZ0uFOW7rSzw_1755799277
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e57ca10703so207405ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799277; x=1756404077;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf3vORzvfVQScDyhKM9vvrzvYH2efDDECf9Y/ePn7L0=;
        b=fu1uBB1NXqgkOr2HqjeCJ9QQIkjlvMic/4MNNBLj+wC2OZlRAsKfHtPYc/L7vF7l5F
         1Y8RmGLCdSRpe4k/fT2/OPd283qwh/1H2rR7UJQVXM23/cdVcT7qzKjficGO7JZNkCIT
         56wuw4kPA9mAHpZvfScOSeyuZvVosjcn32gE5TQmQR0UFu3ekErxkUfGzV6ENmOr9IQN
         SO9HG2+SLiwTKEuXcnJNkmTtoj1ejIM5RZ4kFFhfyyHfb0XqHJ8HdQmRtevNjNEJCLse
         NOPTUEogswuvyhkw1jwkL6ZXOFtrufvAjKEoj1DoutNhZ8SGyZ4XZfqvtIpCIc2Ht6F7
         1q/A==
X-Forwarded-Encrypted: i=1; AJvYcCWRg+mlaMpRJC08MH3TTl0zPsq82hpBXtr2SreKmvC37HBgpk2xfTJa4BF5myiL5bb/mnluBoU4jT+vU+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO4KwLEtaaaiRFiwoT7aTGwLZVL6lzAgDxeMc7VteGqnUqQkM
	3g3iikLN8eYYMBAkNSs914ICqTJTt+Fz1sH3OztRbr3MCOrSIx1iSQatZ3TfQP4op9747DMeajK
	F7YFmrhIfc2swouzr8E7odeiGVbfSSF7Snm42ke925jE6oGOCIpIcSsJ5GrhRRBMjwg==
X-Gm-Gg: ASbGncv3v7vLS9uGPNYiCaK6JzCt1xxQN8GZWPi381ZxJscpdCpAAopY4x+2Xh253jx
	ofK6kyawzq+FfM896AOp7UKTBwwE+I8Qrtl4lqFqmfzz0B8Bqlk9eJ0lK9K/knHraOrPYD142ar
	Ow+lv4vs3jUz5ROo5ujhTCugfd8IZen9C8W28vgyV4d25Wx3jFai+m0HSsgMezCk4RSS+vWqLtR
	hCAqM2/vKHNaUD1FH6rp+Y92r4JVF+CNVkSkHvW3qXdPvrMpIe+3l+vt9vo4h2CtCwJzpg2evRA
	p+T2jJXIUs53FP9+hVaSKVfX2RrBvwhgmCJC5/6PcMM=
X-Received: by 2002:a05:6e02:1a86:b0:3e5:2e10:4e07 with SMTP id e9e14a558f8ab-3e92176fa72mr1500985ab.3.1755799276551;
        Thu, 21 Aug 2025 11:01:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8F5O26fAnrp/jKcWunWcBNxGZ7+GOKiYxjnN0rb54zQsK18lwYCVRiP0aLnKckHTRavK7+w==
X-Received: by 2002:a05:6e02:1a86:b0:3e5:2e10:4e07 with SMTP id e9e14a558f8ab-3e92176fa72mr1500825ab.3.1755799275910;
        Thu, 21 Aug 2025 11:01:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6a6c23sm76294035ab.42.2025.08.21.11.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 11:01:14 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:01:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerkolothum@gmail.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v8 3/3] hisi_acc_vfio_pci: adapt to new migration
 configuration
Message-ID: <20250821120112.3e9599a4.alex.williamson@redhat.com>
In-Reply-To: <20250820072435.2854502-4-liulongfang@huawei.com>
References: <20250820072435.2854502-1-liulongfang@huawei.com>
	<20250820072435.2854502-4-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 15:24:35 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> On new platforms greater than QM_HW_V3, the migration region has been
> relocated from the VF to the PF. The driver must also be modified
> accordingly to adapt to the new hardware device.
> 
> On the older hardware platform QM_HW_V3, the live migration configuration
> region is placed in the latter 32K portion of the VF's BAR2 configuration
> space. On the new hardware platform QM_HW_V4, the live migration
> configuration region also exists in the same 32K area immediately following
> the VF's BAR2, just like on QM_HW_V3.
> 
> However, access to this region is now controlled by hardware. Additionally,
> a copy of the live migration configuration region is present in the PF's
> BAR2 configuration space. On the new hardware platform QM_HW_V4, when an
> older version of the driver is loaded, it behaves like QM_HW_V3 and uses
> the configuration region in the VF, ensuring that the live migration
> function continues to work normally. When the new version of the driver is
> loaded, it directly uses the configuration region in the PF. Meanwhile,
> hardware configuration disables the live migration configuration region
> in the VF's BAR2: reads return all 0xF values, and writes are silently
> ignored.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Reviewed-by: Shameer Kolothum <shameerkolothum@gmail.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 169 ++++++++++++------
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  13 ++
>  2 files changed, 130 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index ddb3fd4df5aa..09893d143a68 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -125,6 +125,72 @@ static int qm_get_cqc(struct hisi_qm *qm, u64 *addr)
>  	return 0;
>  }
>  
> +static int qm_get_xqc_regs(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> +			   struct acc_vf_data *vf_data)
> +{
> +	struct hisi_qm *qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = &qm->pdev->dev;
> +	u32 eqc_addr, aeqc_addr;
> +	int ret;
> +
> +	if (hisi_acc_vdev->drv_mode == HW_V3_COMPAT) {
> +		eqc_addr = QM_EQC_DW0;
> +		aeqc_addr = QM_AEQC_DW0;
> +	} else {
> +		eqc_addr = QM_EQC_PF_DW0;
> +		aeqc_addr = QM_AEQC_PF_DW0;
> +	}
> +
> +	/* QM_EQC_DW has 7 regs */
> +	ret = qm_read_regs(qm, eqc_addr, vf_data->qm_eqc_dw, 7);
> +	if (ret) {
> +		dev_err(dev, "failed to read QM_EQC_DW\n");
> +		return ret;
> +	}
> +
> +	/* QM_AEQC_DW has 7 regs */
> +	ret = qm_read_regs(qm, aeqc_addr, vf_data->qm_aeqc_dw, 7);
> +	if (ret) {
> +		dev_err(dev, "failed to read QM_AEQC_DW\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qm_set_xqc_regs(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> +			   struct acc_vf_data *vf_data)
> +{
> +	struct hisi_qm *qm = &hisi_acc_vdev->vf_qm;
> +	struct device *dev = &qm->pdev->dev;
> +	u32 eqc_addr, aeqc_addr;
> +	int ret;
> +
> +	if (hisi_acc_vdev->drv_mode == HW_V3_COMPAT) {
> +		eqc_addr = QM_EQC_DW0;
> +		aeqc_addr = QM_AEQC_DW0;
> +	} else {
> +		eqc_addr = QM_EQC_PF_DW0;
> +		aeqc_addr = QM_AEQC_PF_DW0;
> +	}
> +
> +	/* QM_EQC_DW has 7 regs */
> +	ret = qm_write_regs(qm, eqc_addr, vf_data->qm_eqc_dw, 7);
> +	if (ret) {
> +		dev_err(dev, "failed to write QM_EQC_DW\n");
> +		return ret;
> +	}
> +
> +	/* QM_AEQC_DW has 7 regs */
> +	ret = qm_write_regs(qm, aeqc_addr, vf_data->qm_aeqc_dw, 7);
> +	if (ret) {
> +		dev_err(dev, "failed to write QM_AEQC_DW\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qm_get_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
>  {
>  	struct device *dev = &qm->pdev->dev;
> @@ -167,20 +233,6 @@ static int qm_get_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
>  		return ret;
>  	}
>  
> -	/* QM_EQC_DW has 7 regs */
> -	ret = qm_read_regs(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
> -	if (ret) {
> -		dev_err(dev, "failed to read QM_EQC_DW\n");
> -		return ret;
> -	}
> -
> -	/* QM_AEQC_DW has 7 regs */
> -	ret = qm_read_regs(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
> -	if (ret) {
> -		dev_err(dev, "failed to read QM_AEQC_DW\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -239,20 +291,6 @@ static int qm_set_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
>  		return ret;
>  	}
>  
> -	/* QM_EQC_DW has 7 regs */
> -	ret = qm_write_regs(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
> -	if (ret) {
> -		dev_err(dev, "failed to write QM_EQC_DW\n");
> -		return ret;
> -	}
> -
> -	/* QM_AEQC_DW has 7 regs */
> -	ret = qm_write_regs(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
> -	if (ret) {
> -		dev_err(dev, "failed to write QM_AEQC_DW\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -522,6 +560,10 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  		return ret;
>  	}
>  
> +	ret = qm_set_xqc_regs(hisi_acc_vdev, vf_data);
> +	if (ret)
> +		return ret;
> +
>  	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_BT, qm->sqc_dma, 0, 0);
>  	if (ret) {
>  		dev_err(dev, "set sqc failed\n");
> @@ -589,6 +631,10 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  	vf_data->vf_qm_state = QM_READY;
>  	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
>  
> +	ret = qm_get_xqc_regs(hisi_acc_vdev, vf_data);
> +	if (ret)
> +		return ret;
> +
>  	ret = vf_qm_read_data(vf_qm, vf_data);
>  	if (ret)
>  		return ret;
> @@ -1186,34 +1232,52 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>  {
>  	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> +	struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
>  	struct pci_dev *vf_dev = vdev->pdev;
> +	u32 val;
>  
> -	/*
> -	 * ACC VF dev BAR2 region consists of both functional register space
> -	 * and migration control register space. For migration to work, we
> -	 * need access to both. Hence, we map the entire BAR2 region here.
> -	 * But unnecessarily exposing the migration BAR region to the Guest
> -	 * has the potential to prevent/corrupt the Guest migration. Hence,
> -	 * we restrict access to the migration control space from
> -	 * Guest(Please see mmap/ioctl/read/write override functions).
> -	 *
> -	 * Please note that it is OK to expose the entire VF BAR if migration
> -	 * is not supported or required as this cannot affect the ACC PF
> -	 * configurations.
> -	 *
> -	 * Also the HiSilicon ACC VF devices supported by this driver on
> -	 * HiSilicon hardware platforms are integrated end point devices
> -	 * and the platform lacks the capability to perform any PCIe P2P
> -	 * between these devices.
> -	 */
> +	val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
> +	if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
> +		hisi_acc_vdev->drv_mode = HW_V4_NEW;
> +	else
> +		hisi_acc_vdev->drv_mode = HW_V3_COMPAT;
>  
> -	vf_qm->io_base =
> -		ioremap(pci_resource_start(vf_dev, VFIO_PCI_BAR2_REGION_INDEX),
> -			pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX));
> -	if (!vf_qm->io_base)
> -		return -EIO;
> +	if (hisi_acc_vdev->drv_mode == HW_V4_NEW) {
> +		/*
> +		 * On hardware platforms greater than QM_HW_V3, the migration function
> +		 * register is placed in the BAR2 configuration region of the PF,
> +		 * and each VF device occupies 8KB of configuration space.
> +		 */
> +		vf_qm->io_base = pf_qm->io_base + QM_MIG_REGION_OFFSET +
> +				 hisi_acc_vdev->vf_id * QM_MIG_REGION_SIZE;
> +	} else {
> +		/*
> +		 * ACC VF dev BAR2 region consists of both functional register space
> +		 * and migration control register space. For migration to work, we
> +		 * need access to both. Hence, we map the entire BAR2 region here.
> +		 * But unnecessarily exposing the migration BAR region to the Guest
> +		 * has the potential to prevent/corrupt the Guest migration. Hence,
> +		 * we restrict access to the migration control space from
> +		 * Guest(Please see mmap/ioctl/read/write override functions).
> +		 *
> +		 * Please note that it is OK to expose the entire VF BAR if migration
> +		 * is not supported or required as this cannot affect the ACC PF
> +		 * configurations.
> +		 *
> +		 * Also the HiSilicon ACC VF devices supported by this driver on
> +		 * HiSilicon hardware platforms are integrated end point devices
> +		 * and the platform lacks the capability to perform any PCIe P2P
> +		 * between these devices.
> +		 */
>  
> +		vf_qm->io_base =
> +			ioremap(pci_resource_start(vf_dev, VFIO_PCI_BAR2_REGION_INDEX),
> +				pci_resource_len(vf_dev, VFIO_PCI_BAR2_REGION_INDEX));
> +		if (!vf_qm->io_base)
> +			return -EIO;
> +	}
>  	vf_qm->fun_type = QM_HW_VF;
> +	vf_qm->ver = pf_qm->ver;
>  	vf_qm->pdev = vf_dev;
>  	mutex_init(&vf_qm->mailbox_lock);
>  
> @@ -1539,7 +1603,8 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>  	hisi_acc_vf_disable_fds(hisi_acc_vdev);
>  	mutex_lock(&hisi_acc_vdev->open_mutex);
>  	hisi_acc_vdev->dev_opened = false;
> -	iounmap(vf_qm->io_base);
> +	if (hisi_acc_vdev->drv_mode == HW_V3_COMPAT)
> +		iounmap(vf_qm->io_base);
>  	mutex_unlock(&hisi_acc_vdev->open_mutex);
>  	vfio_pci_core_close_device(core_vdev);
>  }
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> index 91002ceeebc1..e7650f5ff0f7 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
> @@ -59,6 +59,18 @@
>  #define ACC_DEV_MAGIC_V1	0XCDCDCDCDFEEDAACC
>  #define ACC_DEV_MAGIC_V2	0xAACCFEEDDECADEDE
>  
> +#define QM_MIG_REGION_OFFSET		0x180000
> +#define QM_MIG_REGION_SIZE		0x2000
> +
> +#define QM_SUB_VERSION_ID		0x100210
> +#define QM_EQC_PF_DW0			0x1c00
> +#define QM_AEQC_PF_DW0			0x1c20
> +
> +enum hw_drv_mode {
> +	HW_V3_COMPAT = 0,
> +	HW_V4_NEW,
> +};

You might consider whether these names are going to make sense in the
future if there a V5 and beyond, and why V3 hardware is going to use a
"compat" name when that's it's native operating mode.

But also, patch 1/ is deciding whether to expose the full BAR based on
the hardware version and here we choose whether to use the VF or PF
control registers based on the hardware version and whether the new
hardware feature is enabled.  Doesn't that leave V4 hardware exposing
the full BAR regardless of whether the PF driver has disabled the
migration registers within the BAR?  Thanks,

Alex

> +
>  struct acc_vf_data {
>  #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
>  	/* QM match information */
> @@ -125,6 +137,7 @@ struct hisi_acc_vf_core_device {
>  	struct pci_dev *vf_dev;
>  	struct hisi_qm *pf_qm;
>  	struct hisi_qm vf_qm;
> +	int drv_mode;
>  	/*
>  	 * vf_qm_state represents the QM_VF_STATE register value.
>  	 * It is set by Guest driver for the ACC VF dev indicating


