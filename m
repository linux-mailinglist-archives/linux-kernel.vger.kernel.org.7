Return-Path: <linux-kernel+bounces-822192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B506B83424
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26765814A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1462E7651;
	Thu, 18 Sep 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3KcGxnq"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D272DA753
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179189; cv=none; b=FYDg8UAAjuWH7Rxi0CzdV3FHNE6l/bJOXBQ3sptEtIwo/zyxntUgCCtt3ksTuPEsIjfHOvT2FcHqD9pTAdN461anTqrj+JBeZZKb0XG6qgPTGnp9Qfkn8T8bQDDQJw10oqL4YhU67JtnpdCT+7A35kUqo3ehvL8J2maUzHqczEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179189; c=relaxed/simple;
	bh=4IDSaO2MoQqGUX/5Is94akHzdjhGaOyo8qsk/PPh9UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5NkcMhtR73tbn5lWNbSt6JOlqQTOzSMQaZ/mVkp/tO0Y1TBBjfYPI4xQ/9ZSP5L0PG+PzwHwf8DDMV6X6e4KNkK2ihMYQhd3d8E+e35goHIK50vB3dXaNlT3lVkGvyND1WgTLFzXGSme/JdBlWhnvCv6xwNOOu/9X0cj6aYPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3KcGxnq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b79773a389so6869221cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758179186; x=1758783986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SAAVksE0mRteO5BvlzanWiDdXV8KikuWQ+Fsq+TxSGI=;
        b=B3KcGxnql/ENGwNhcU4dGTna77o1r2Z2EULgEJLvMtK3UV+SDAz6viin4k+Ak9jzQJ
         3i1nLlUDE14J3ThGXurClX9QSmDYhIe0riRhH3iiPNKSH4mFPxYAxbPxfHXn7xr+Rso9
         jJY+dMfMXqnc28j1GX6wXvNZNulnGKwEYm33OOE4XULxoCFS4ZlTCBAF8XekAGh9t3iC
         ldbRj7QCEnvlzAqMTMtmEEqDorWWlEYUZLCqlIVmO5xqhjxdRYieVCKwM8OTQzog6fZK
         w8jgUFlzFCV2btVHq6sW5HuGu9a89DoChfuSoYhuQ+ZKuvdSH3B2jJ/405GA1tk79rPs
         4LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179186; x=1758783986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAAVksE0mRteO5BvlzanWiDdXV8KikuWQ+Fsq+TxSGI=;
        b=rxteD3hc+T2gsjovP9ZEXKSqks78Ea/PM5rzfNoyeB9y/tK19AOABK1zQ90KVjbwBe
         ja1aU4mKec1ajXXBGWnys6IT5LJ7w/NsoUI//tRe7H2oJpMTmc/kvIC/6Ui0ca848odZ
         0/WBV7hIi18xQ+TN46gFuOIsKoN67AgXhSzpTKfid9tcke+jVxiwoMbPxOXNqj1wk//e
         vZqllME8r/yk0lsg9SFUShFafvMQYMUgrS4wYrLyIfw3R0Gn60AvWnOKW/FTt04HACHq
         j/rG9KbaTlFBun0TggXZyasJnOrV5Rj39ZvpMPsR7fnk8FwzTN+Th9gj8yEJoW11ZIHa
         CzcA==
X-Forwarded-Encrypted: i=1; AJvYcCVYE3Q+6HQyGCq+3Z1vlmbB7Ixvyik8l8QvVZPa7nCZyXXCq7bIAIa3v6w+/uaodLD6GYv6wbNznELDuG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhMecTvKH6kj0/NE9Na3tHw8NmL13LcDfTXfnvK89ip0LLjsZ
	qRW09NWrtC+5DifFj0o7Z146VJxp3JFN5fABPCdebwu3dPLaBphXGFSP/fIUEC57ZcRTOUq2gO0
	wNduz/VabJRn7FurYHR1Ew4ruHZXrcL9d2yrUpjI=
X-Gm-Gg: ASbGncvN85SaDSlK0j4SJQxpl8FUAs49IYvted8YhWMkWkZ0Rv9uLcYgBaQZ+Lbvv1P
	0EtL6zN/QDlwI5d3+AiSgoy+abyx5GA1XvmNCcC//GxIT9sj6NOLSaNajXAyKx1UQKx1QOOOcQ7
	lerjNiKsIlAWntuI9kbgjtZ8Js6x5ys/lI80Ld25kxoV03W6zmTWeyeoMTspIGivQsM+Ib7/4yi
	xEIP8CFd3KavGvD9hvEi9cjdMs=
X-Google-Smtp-Source: AGHT+IFbZVQhDMTZX5lHB4SYuIOhlN6FkhvAMSCbWGjP3ldm7j7Gsp5zS04D+RgYwl9mCgd/9dZKpzCsIPW+fD5Fio4=
X-Received: by 2002:a05:622a:17cd:b0:4b6:226b:b6b7 with SMTP id
 d75a77b69052e-4ba6ca8ce97mr69471681cf.81.1758179185974; Thu, 18 Sep 2025
 00:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902022505.2034408-1-liulongfang@huawei.com>
 <20250902022505.2034408-3-liulongfang@huawei.com> <CAHy=t2_0X4_wqc+zm3Zk8aUPXmsOR57wiGmzR65PFHSa=gTrPA@mail.gmail.com>
 <bb9f8f5a-0cf0-98ef-d7b0-be132b8ce63f@huawei.com> <b9448065-f2ca-899d-e68a-c17e46546b40@huawei.com>
In-Reply-To: <b9448065-f2ca-899d-e68a-c17e46546b40@huawei.com>
From: Shameer Kolothum <shameerkolothum@gmail.com>
Date: Thu, 18 Sep 2025 08:06:16 +0100
X-Gm-Features: AS18NWDGcZI6pNQv-O1Ju-BU2j37aPK9mY1mlw4WtdW_H89-cFcfjh0yzdxwiqs
Message-ID: <CAHy=t29buypWspUjZLHfFjnbixSENfo4we5Q5h_yrSKXJgc2QA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] hisi_acc_vfio_pci: adapt to new migration configuration
To: liulongfang <liulongfang@huawei.com>
Cc: alex.williamson@redhat.com, jgg@nvidia.com, jonathan.cameron@huawei.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 02:29, liulongfang <liulongfang@huawei.com> wrote:
>
> On 2025/9/11 19:30, liulongfang wrote:
> > On 2025/9/11 16:05, Shameer Kolothum wrote:
> >> On Tue, 2 Sept 2025 at 03:26, Longfang Liu <liulongfang@huawei.com> wrote:
> >>>
> >>> On new platforms greater than QM_HW_V3, the migration region has been
> >>> relocated from the VF to the PF. The VF's own configuration space is
> >>> restored to the complete 64KB, and there is no need to divide the
> >>> size of the BAR configuration space equally. The driver should be
> >>> modified accordingly to adapt to the new hardware device.
> >>>
> >>> On the older hardware platform QM_HW_V3, the live migration configuration
> >>> region is placed in the latter 32K portion of the VF's BAR2 configuration
> >>> space. On the new hardware platform QM_HW_V4, the live migration
> >>> configuration region also exists in the same 32K area immediately following
> >>> the VF's BAR2, just like on QM_HW_V3.
> >>>
> >>> However, access to this region is now controlled by hardware. Additionally,
> >>> a copy of the live migration configuration region is present in the PF's
> >>> BAR2 configuration space. On the new hardware platform QM_HW_V4, when an
> >>> older version of the driver is loaded, it behaves like QM_HW_V3 and uses
> >>> the configuration region in the VF, ensuring that the live migration
> >>> function continues to work normally. When the new version of the driver is
> >>> loaded, it directly uses the configuration region in the PF. Meanwhile,
> >>> hardware configuration disables the live migration configuration region
> >>> in the VF's BAR2: reads return all 0xF values, and writes are silently
> >>> ignored.
> >>>
> >>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >>> Reviewed-by: Shameer Kolothum <shameerkolothum@gmail.com>
> >>> ---
> >>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 205 ++++++++++++------
> >>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  13 ++
> >>>  2 files changed, 157 insertions(+), 61 deletions(-)
> >>>
> >>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> index 397f5e445136..fcf692a7bd4c 100644
> >>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> >>> @@ -125,6 +125,72 @@ static int qm_get_cqc(struct hisi_qm *qm, u64 *addr)
> >>>         return 0;
> >>>  }
> >>>
> >>> +static int qm_get_xqc_regs(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>> +                          struct acc_vf_data *vf_data)
> >>> +{
> >>> +       struct hisi_qm *qm = &hisi_acc_vdev->vf_qm;
> >>> +       struct device *dev = &qm->pdev->dev;
> >>> +       u32 eqc_addr, aeqc_addr;
> >>> +       int ret;
> >>> +
> >>> +       if (hisi_acc_vdev->drv_mode == HW_ACC_V3) {
> >>> +               eqc_addr = QM_EQC_DW0;
> >>> +               aeqc_addr = QM_AEQC_DW0;
> >>> +       } else {
> >>> +               eqc_addr = QM_EQC_PF_DW0;
> >>> +               aeqc_addr = QM_AEQC_PF_DW0;
> >>> +       }
> >>> +
> >>> +       /* QM_EQC_DW has 7 regs */
> >>> +       ret = qm_read_regs(qm, eqc_addr, vf_data->qm_eqc_dw, 7);
> >>> +       if (ret) {
> >>> +               dev_err(dev, "failed to read QM_EQC_DW\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       /* QM_AEQC_DW has 7 regs */
> >>> +       ret = qm_read_regs(qm, aeqc_addr, vf_data->qm_aeqc_dw, 7);
> >>> +       if (ret) {
> >>> +               dev_err(dev, "failed to read QM_AEQC_DW\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static int qm_set_xqc_regs(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>> +                          struct acc_vf_data *vf_data)
> >>> +{
> >>> +       struct hisi_qm *qm = &hisi_acc_vdev->vf_qm;
> >>> +       struct device *dev = &qm->pdev->dev;
> >>> +       u32 eqc_addr, aeqc_addr;
> >>> +       int ret;
> >>> +
> >>> +       if (hisi_acc_vdev->drv_mode == HW_ACC_V3) {
> >>> +               eqc_addr = QM_EQC_DW0;
> >>> +               aeqc_addr = QM_AEQC_DW0;
> >>> +       } else {
> >>> +               eqc_addr = QM_EQC_PF_DW0;
> >>> +               aeqc_addr = QM_AEQC_PF_DW0;
> >>> +       }
> >>> +
> >>> +       /* QM_EQC_DW has 7 regs */
> >>> +       ret = qm_write_regs(qm, eqc_addr, vf_data->qm_eqc_dw, 7);
> >>> +       if (ret) {
> >>> +               dev_err(dev, "failed to write QM_EQC_DW\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       /* QM_AEQC_DW has 7 regs */
> >>> +       ret = qm_write_regs(qm, aeqc_addr, vf_data->qm_aeqc_dw, 7);
> >>> +       if (ret) {
> >>> +               dev_err(dev, "failed to write QM_AEQC_DW\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>>  static int qm_get_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
> >>>  {
> >>>         struct device *dev = &qm->pdev->dev;
> >>> @@ -167,20 +233,6 @@ static int qm_get_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
> >>>                 return ret;
> >>>         }
> >>>
> >>> -       /* QM_EQC_DW has 7 regs */
> >>> -       ret = qm_read_regs(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
> >>> -       if (ret) {
> >>> -               dev_err(dev, "failed to read QM_EQC_DW\n");
> >>> -               return ret;
> >>> -       }
> >>> -
> >>> -       /* QM_AEQC_DW has 7 regs */
> >>> -       ret = qm_read_regs(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
> >>> -       if (ret) {
> >>> -               dev_err(dev, "failed to read QM_AEQC_DW\n");
> >>> -               return ret;
> >>> -       }
> >>> -
> >>>         return 0;
> >>>  }
> >>>
> >>> @@ -239,20 +291,6 @@ static int qm_set_regs(struct hisi_qm *qm, struct acc_vf_data *vf_data)
> >>>                 return ret;
> >>>         }
> >>>
> >>> -       /* QM_EQC_DW has 7 regs */
> >>> -       ret = qm_write_regs(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
> >>> -       if (ret) {
> >>> -               dev_err(dev, "failed to write QM_EQC_DW\n");
> >>> -               return ret;
> >>> -       }
> >>> -
> >>> -       /* QM_AEQC_DW has 7 regs */
> >>> -       ret = qm_write_regs(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
> >>> -       if (ret) {
> >>> -               dev_err(dev, "failed to write QM_AEQC_DW\n");
> >>> -               return ret;
> >>> -       }
> >>> -
> >>>         return 0;
> >>>  }
> >>>
> >>> @@ -522,6 +560,10 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>>                 return ret;
> >>>         }
> >>>
> >>> +       ret = qm_set_xqc_regs(hisi_acc_vdev, vf_data);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>>         ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_BT, qm->sqc_dma, 0, 0);
> >>>         if (ret) {
> >>>                 dev_err(dev, "set sqc failed\n");
> >>> @@ -589,6 +631,10 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
> >>>         vf_data->vf_qm_state = QM_READY;
> >>>         hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> >>>
> >>> +       ret = qm_get_xqc_regs(hisi_acc_vdev, vf_data);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>>         ret = vf_qm_read_data(vf_qm, vf_data);
> >>>         if (ret)
> >>>                 return ret;
> >>> @@ -1186,34 +1232,52 @@ static int hisi_acc_vf_qm_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> >>>  {
> >>>         struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
> >>>         struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
> >>> +       struct hisi_qm *pf_qm = hisi_acc_vdev->pf_qm;
> >>>         struct pci_dev *vf_dev = vdev->pdev;
> >>> +       u32 val;
> >>>
> >>> -       /*
> >>> -        * ACC VF dev BAR2 region consists of both functional register space
> >>> -        * and migration control register space. For migration to work, we
> >>> -        * need access to both. Hence, we map the entire BAR2 region here.
> >>> -        * But unnecessarily exposing the migration BAR region to the Guest
> >>> -        * has the potential to prevent/corrupt the Guest migration. Hence,
> >>> -        * we restrict access to the migration control space from
> >>> -        * Guest(Please see mmap/ioctl/read/write override functions).
> >>> -        *
> >>> -        * Please note that it is OK to expose the entire VF BAR if migration
> >>> -        * is not supported or required as this cannot affect the ACC PF
> >>> -        * configurations.
> >>> -        *
> >>> -        * Also the HiSilicon ACC VF devices supported by this driver on
> >>> -        * HiSilicon hardware platforms are integrated end point devices
> >>> -        * and the platform lacks the capability to perform any PCIe P2P
> >>> -        * between these devices.
> >>> -        */
> >>> +       val = readl(pf_qm->io_base + QM_MIG_REGION_SEL);
> >>> +       if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
> >>> +               hisi_acc_vdev->drv_mode = HW_ACC_V4;
> >>> +       else
> >>> +               hisi_acc_vdev->drv_mode = HW_ACC_V3;
> >>
> >> The check is for > QM_HW_V3 and drv_mode is set to HW_ACC_V4. From our
> >> previous discussions I think the expectation is that future hardware will follow
> >> this same behaviour. If that is the case, it is better to rename HW_ACC_  to
> >> something more specific to this change than use the V3/V4 name.
> >>
> >
> > If the goal is merely to reflect the context of this change, it would be better to add
> > a comment describing this change directly at the variable's declaration.
> >
>
> Hi, Shameer:
> If there are no further issues, I will continue using the current naming convention and
> add comments at the declaration sites.

I would still prefer naming it differently than just adding comments.
Maybe something like
below + comments in the header.

if (pf_qm->ver > QM_HW_V3 && (val & QM_MIG_REGION_EN))
     hisi_acc_vdev->mig_ctrl_mode = HW_ACC_MIG_PF_CTRL;
else
    hisi_acc_vdev->mig_ctrl_mode = HW_ACC_MIG_VF_CTRL;

Also please don't respin just for this yet. Please wait for Alex to take a look.

Thanks,
Shameer

