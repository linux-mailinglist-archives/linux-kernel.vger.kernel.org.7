Return-Path: <linux-kernel+bounces-723895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C49AFEC20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6ED3B4484
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4131A841E;
	Wed,  9 Jul 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RPavAYeI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8C1EA84
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071791; cv=none; b=LKf6bA/DGBWipfMgevIzqwkNh1Ol53A9KrN+lAtnpNJ5Jc0AagG/4A+fWCzwAOMWGKs5lQuBIRNiuPGufDOljB364QL/RBIUsVRCcjZQnMnEd8vDaiepor91mh8ua4bvcLf48W32HK2768rG4Ivk8SfznFQr2tWjsAuPvHOgcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071791; c=relaxed/simple;
	bh=sv/H/HyWNkZZmZDvxOBObirCr13ethXeQqHLTtwYGC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4BgiIUrQLCoiT+ZfM6c3r5SAT70oP6ud/DJaIcg37g6n6f6ReRpHYnVpqN9cp9zuScEboA5c9Mk13IpCKkwRvRDHtGdykgzsRiSF43e9aSFWtkpyJPkDNBmEDks917wojchgDliSTP9zkcFgh8pCG6yNyq5JJVpfLvkN1HEJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RPavAYeI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CoiPk012560
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GH/ico9gvqryEnV/YdeaNNNe3tHOcfG/8CWf6ZjZbSo=; b=RPavAYeIgxXBuFhr
	hQMOOytkGv0fzgzpeow88+4/SXnF6wIckztMsucC/SG48eTn1wWZgN4sbQdIK9ib
	ouMI1Zd0rm/5OGMlf2OeopArI5RJ/hPGtFUhauqKJsCpCTWmf1/VnB/NLG00QIcv
	Qna3OrWU9rVcqdcrxrThtjIp9Bt5nHf2LkHYm8HVrwI/T1i9+BW925P7jBFbRNwI
	YwNxRjyU+oi0mr8i52TBzy58Ul0cNsmeTYBhajVCn2rYtp+Dvxvs0DMidNhNCj4U
	RrjOT0qnnuLfMFBCCJ+MNrBuXwXIPxkAeee3I/azEUX+a4Z4Mh/2MRia6QCaW2KC
	VN9o9w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn4xd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:36:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a587a96f0aso169039191cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071788; x=1752676588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH/ico9gvqryEnV/YdeaNNNe3tHOcfG/8CWf6ZjZbSo=;
        b=X1ZC7TgCFT8MU4zSGElWvt/+yjjI4E5YOFxuDhpJsLZPWnGtEo6anI6h3EAbHwkazO
         GTKG1HnUzXQeVbztj/k9y3zADKJVxtOGSQu9BoO9EOHhBMG3I4+/UT8TdLOvVQH3vNSx
         3FAUfAckMSbv57WW+Ff6F1B9Rh6eTkU4jp13n+CStRx+bY0muWWlaNJNituUPctrfwvv
         FUQMHF5Gi8hD6vcoReW5A1I8btEGgBzMSff7DII894yo48KuoYFjnLCeCkkbVz4z7gCQ
         nDCD6MzS4LQ0MHD+t8UwbwYu516CdYUfZVj88hKPjb45oX9270l4PeFVO3RAgdyuQR50
         oURg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+goZQag8U+bk17zW+obt9nSToidn/IYDxOi4rtXbsrPro0cHs9H1193Y7TclaP6PopWAuR10DtNHf3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyUl3IA9Ql8/qBmwhdDuwjvuJp+eoEklfeS876NYmefrS7Zhz
	A6+k2DWuVq9///mZh/LOOEaAcfqA3n5JKkzJx6KZQmaf3/OGq6my3FC9MmDg5ysjpuf6JFWWAVx
	/KBN3XMkc+X9fdGKIuoP+xR/vtKpVGYxoOWO5xp9pOOzEvY3H+eJ/mMnYiap/9cvcbxIx55ZYWd
	BVfNmqRtikBCMHO0uvJhUYn6TtoJ24YK33zmAMRHj/0RYuLN/cMtLmSh4=
X-Gm-Gg: ASbGncu+7gYqDCuiZNOVIwvfehBpSLbmTOMOlQFq5egQqq5AUtxYGcWzmNX2hed30hR
	GhtGCL7Y81muurkCLXLWC4vt2DD1zckM704Ftep2F35JdZAYXHoBbOWFEUAX5mUbWgSdvBpn1IZ
	vxcVPo
X-Received: by 2002:ac8:5f8f:0:b0:494:5805:c2b9 with SMTP id d75a77b69052e-4a9decfa987mr37257061cf.31.1752071787905;
        Wed, 09 Jul 2025 07:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDu0dcoZtXKGCF/d9TGz4O49NrlC4vyEc4o94yqcgexOyu9zx6O6XVFZJfpYZI0LVYto2NUEJndHgIujg1rjk=
X-Received: by 2002:ac8:5f8f:0:b0:494:5805:c2b9 with SMTP id
 d75a77b69052e-4a9decfa987mr37256441cf.31.1752071787309; Wed, 09 Jul 2025
 07:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709065533.25724-1-komal.bajaj@oss.qualcomm.com> <2025070924-wilt-dreamt-fb25@gregkh>
In-Reply-To: <2025070924-wilt-dreamt-fb25@gregkh>
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 20:06:16 +0530
X-Gm-Features: Ac12FXy8WkTNVHPUAdigdIeD1NVFTXRsrAlyhx4EcH1ohwyzfYFh1LevtGM-yXY
Message-ID: <CAPHGfUN7k_oLrjvXPJj84Q5NayXFab2QSQ+g4iYjrAsPqO_KnA@mail.gmail.com>
Subject: Re: [PATCH v4] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686e7e6c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ag1SF4gXAAAA:8
 a=aoTH-x754zP81mJImO0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: dc1XrnB8CI62DRIK2wttzxIaFv00TaT2
X-Proofpoint-ORIG-GUID: dc1XrnB8CI62DRIK2wttzxIaFv00TaT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEzMiBTYWx0ZWRfX40VtwG/UrpbW
 9AEyBQ7zKB+j/yvewlTzCHejXSgKVs9cBxulOxmbV4pbi5sRK0iz9pG6ctssxg+wz/OB50MDBxx
 eC03ciwqhLFKtrrawllz7EKyIVpNwZOBwzx/P7+ADOPPCYbBIqVjWjViPTJcMbEEaVqY84JbLro
 no4BvKnvMytJcrfDiO2+Y+OFtb4IhBagK6SNr1Z52xXQV7oNcagziQx7mYMuj1aW3A16UjH9q4Q
 RxjwD6TA8g6R8m0QhrnaL4r1OX279dcudFE41hpKkwM46goOBcZadDrKToPSXp0PmEFs9iZf9+l
 nO9eNviZ0MYbl/2hQyiEpDvf7z688KX9cNz8IcBvg1kbXJyWnZJjCZKc4QUxzwR36kwiuBZV6UE
 zF5iVsbyTuh0x33KN96qt8b7fSDimWHnTyUaGTsv4cfA/l71xLFv/wc0FCXh1b4u7PIFOLHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090132

On Wed, Jul 9, 2025 at 2:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 09, 2025 at 12:25:14PM +0530, Komal Bajaj wrote:
> > EUD_MODE_MANAGER2 register is mapped to a memory region that is marked
> > as read-only for HLOS, enforcing access restrictions that prohibit
> > direct memory-mapped writes via writel().
> >
> > Attempts to write to this region from HLOS can result in silent failure=
s
> > or memory access violations, particularly when toggling EUD (Embedded
> > USB Debugger) state. To ensure secure register access, modify the drive=
r
> > to use qcom_scm_io_writel(), which routes the write operation to Qualco=
mm
> > Secure Channel Monitor (SCM). SCM has the necessary permissions to acce=
ss
> > protected memory regions, enabling reliable control over EUD state.
> >
> > SC7280, the only user of EUD is also affected, indicating that this cou=
ld
> > never have worked on a properly fused device.
> >
> > Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded U=
SB Debugger(EUD)")
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > * Added error logging in disable_eud() for SCM write failures, per Konr=
ad=E2=80=99s suggestion
> > * Link to v3: https://lore.kernel.org/all/20250708085208.19089-1-komal.=
bajaj@oss.qualcomm.com/
> >
> > Changes in v3:
> > * Moved secure write before normal writes
> > * Added error checking in disable_eud()
> > * Use ENOMEM error code if platform_get_resource() fails
> > * Select QCOM_SCM driver if USB_QCOM_EUD is enabled
> > * Link to v2: https://lore.kernel.org/all/20250627125131.27606-1-komal.=
bajaj@oss.qualcomm.com/
> >
> > Changes in v2:
> > * Drop separate compatible to be added for secure eud
> > * Use secure call to access EUD mode manager register
> > * Link to v1: https://lore.kernel.org/all/20240807183205.803847-1-quic_=
molvera@quicinc.com/
> >
> >  drivers/usb/misc/Kconfig    |  1 +
> >  drivers/usb/misc/qcom_eud.c | 27 +++++++++++++++++++++------
> >  2 files changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 6497c4e81e95..f49d5ac0e957 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -148,6 +148,7 @@ config USB_QCOM_EUD
> >       tristate "QCOM Embedded USB Debugger(EUD) Driver"
> >       depends on ARCH_QCOM || COMPILE_TEST
> >       select USB_ROLE_SWITCH
> > +     select QCOM_SCM
>
> How is this select going to work if COMPILE_TEST is enabled on
> non-ARCH_QCOM configs?
>
> Please don't use select if at all possible, use "depends" properly.

Ack, will switch to depends on QCOM_SCM to avoid build issues with COMPILE_=
TEST

>
>
> >       help
> >         This module enables support for Qualcomm Technologies, Inc.
> >         Embedded USB Debugger (EUD). The EUD is a control peripheral
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index 83079c414b4f..a58081f53db3 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/usb/role.h>
> > +#include <linux/firmware/qcom/qcom_scm.h>
> >
> >  #define EUD_REG_INT1_EN_MASK 0x0024
> >  #define EUD_REG_INT_STATUS_1 0x0044
> > @@ -34,7 +35,7 @@ struct eud_chip {
> >       struct device                   *dev;
> >       struct usb_role_switch          *role_sw;
> >       void __iomem                    *base;
> > -     void __iomem                    *mode_mgr;
> > +     phys_addr_t                     mode_mgr;
> >       unsigned int                    int_status;
> >       int                             irq;
> >       bool                            enabled;
> > @@ -43,18 +44,30 @@ struct eud_chip {
> >
> >  static int enable_eud(struct eud_chip *priv)
> >  {
> > +     int ret;
> > +
> > +     ret =3D qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 1);
> > +     if (ret)
> > +             return ret;
> > +
> >       writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>
> Nit, why is your local writel() function in backwards order of
> parameters from qcom_scm_io_writel()?  That's going to be a major pain
> to maintain over time, don't you think?

The current ordering of parameters in qcom_scm_io_writel  is the same as in
qcom_scm_io_readl, possibly to keep them consistent. However, if you believ=
e
it's more appropriate to align the parameter order with the standard writel
convention, I=E2=80=99m open to updating it accordingly.

>
>
> >       writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> >                       priv->base + EUD_REG_INT1_EN_MASK);
> > -     writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> >
> >       return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> >  }
> >
> >  static void disable_eud(struct eud_chip *priv)
> >  {
> > +     int ret;
> > +
> > +     ret =3D qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
> > +     if (ret) {
> > +             dev_err(priv->dev, "failed to disable eud\n");
> > +             return;
> > +     }
> > +
> >       writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> > -     writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> >  }
> >
> >  static ssize_t enable_show(struct device *dev,
> > @@ -178,6 +191,7 @@ static void eud_role_switch_release(void *data)
> >  static int eud_probe(struct platform_device *pdev)
> >  {
> >       struct eud_chip *chip;
> > +     struct resource *res;
> >       int ret;
> >
> >       chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > @@ -200,9 +214,10 @@ static int eud_probe(struct platform_device *pdev)
> >       if (IS_ERR(chip->base))
> >               return PTR_ERR(chip->base);
> >
> > -     chip->mode_mgr =3D devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(chip->mode_mgr))
> > -             return PTR_ERR(chip->mode_mgr);
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     if (!res)
> > +             return -ENODEV;
> > +     chip->mode_mgr =3D res->start;
>
> No ioremap() call needed anymore?   Why not?

We=E2=80=99re only using the address for qcom_scm_io_writel(), which operat=
es on
physical addresses and doesn=E2=80=99t require an ioremap=E2=80=99d virtual=
 address.
That=E2=80=99s why devm_ioremap_resource() isn=E2=80=99t needed here.

>
> thanks,
>
> greg k-h

