Return-Path: <linux-kernel+bounces-720936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F047EAFC24A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C74C189FA7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF921C184;
	Tue,  8 Jul 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EU6Dt2Iw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06782215077
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954051; cv=none; b=T25X6tc4uaY4ivx5uG9mp68a7nKCtwcgxbY+S2kejkjEoPmvvHLjlMwc/8VdeEfWByIHc4JHjaN/WaU18DCDICmANU7q+xoJq2RChKayCVBmfr3/tR0NGmDr35oPkogBje8rO7K2XMA/8shaRQqBYIiczTEXKDjMR4zDYjGZsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954051; c=relaxed/simple;
	bh=Ts/erfI/1U95juCnNCnHSS+t4688tJmeinxH2Afpx9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmu2NwRkk/cyNwk17DnlEGipotEx0325NEZAmCbjny6frpgz6SaWzkRpqzVb/90Bnh8NMeSapxKbsZXDpVVX02DC+g9/Zc+wtI/ICTBz41S6vHynkS7rRUJ1Sj5kyGYPl933EedE6eSX7b18ebnEp1OUvIvkaZuUf6o2dnV0UW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EU6Dt2Iw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567JKv5O004574
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+GmNWG+f9cfzqdcMMSlVKHfNJeTBBI9yl9OtdiG/Ptg=; b=EU6Dt2Iw39reaJ9o
	JeBZHeaE+aHBIAWsOnsMtTCfrXUfBe6NnjyjDhcWPloxGShENUaXZicEalIbUgds
	tn0OlKGBsV+eKnEyQOsbc7JPV2teRdPmhHEvGjEfj93WNNpzjqhldga88XrBg3se
	jkq+rOyhjTwiXvICusrUK8awrfzYhy+j1aHIckrHafxgANGfUjOT7cyOsRiMeAHh
	FvjxhidYG2NzzWcrcHp0q3dL31fHg3wPsvmTXq53BqMn7N8VC34H+xuoQnItYbfh
	QT0WY0NDW/eV5s/SyS+yWhILu6RmcXAlXeEl43+4xcr9TcoxJ4Pi3setmFbcuCny
	HKry8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefb97g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:54:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a587c85a60so81000001cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751954048; x=1752558848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GmNWG+f9cfzqdcMMSlVKHfNJeTBBI9yl9OtdiG/Ptg=;
        b=MjKOWBvJ5IEOe3CIaAYy3D5Lgxoovba93a+I3SGCe8YRyYoSRWG1x1xUWONcAJPuC4
         gIatgUG95193jtBlEiDpKb00+pacVFO+IBG8mc3v0m1e56h1hBSxUX1Z2lNBBsKvhsuH
         kdElCxWyQxyfBovalZamDnBPh2spvHEkyNx4Y5XDy9KZPUkyEEZy1tfgOK/cHyH1O1Hp
         Rut5ZHIJlwrCdfZAIq8oPbftSYLRP/oUOlIM81L4ViTh2iPIY/D5kaU57hhpEEvX/kHY
         3KXEXrf+yNO7rbzkgF6YG3R5sSAo70Kp7YdSu8r5LqIN3pYcZI4xRNDBl5AZg3kqEd6y
         jxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi/XB0h+yIPhduYXSSynASKMujD8Zk/X5e+FqLbYosdH00rl1m0QG9MgnuWVJkShajDn+M9ZAPpTaaruw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLy5BskgXKghi8a8wW4V+DwqiCOgt2x7hLUrMxow5+kichh3ro
	KXMtHwGLq1pP910tiPcuUViDNxyeDTanayJpL4PCeDJ8KgSx2bPYb0tLFnReG+VCfhZmxUQe9K3
	XbcX1Cyk4fwMCBTqe1+x7veFAwSQN7YkD3sFY4PIWbU0iQnjd55UA4r6CG94KkzzKlySyl/kP9n
	mnWAUezumj4rksE3FEU+2s0oA/1UTgaAi9RNdaBZ+psw==
X-Gm-Gg: ASbGnctZ3A6a4rwFfEI9yVH7YdKOvmJzlLG63DYqDzp4MQAWEHs9xWqB0whftgz8YfM
	QxwD3Bi61FLKT+ifMkxFM8W2H1cD88f4BR/86gi0Ebcr1ACU5O4viN++0Yap8uLGEtdOvl3rShZ
	Wvlmw5MA==
X-Received: by 2002:a05:622a:11d3:b0:4a9:a8fd:e9b6 with SMTP id d75a77b69052e-4a9ccde0c6dmr28981681cf.43.1751954047891;
        Mon, 07 Jul 2025 22:54:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkG1/PSmURffRz+0DyrY9TkdVduj7SqUgcOww7V+BMUeR9MlSOMnFuQ7oVlpqf/7eAZK6d7px/g5X1y38kNsY=
X-Received: by 2002:a05:622a:11d3:b0:4a9:a8fd:e9b6 with SMTP id
 d75a77b69052e-4a9ccde0c6dmr28981421cf.43.1751954047335; Mon, 07 Jul 2025
 22:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627125131.27606-1-komal.bajaj@oss.qualcomm.com> <2025062812-passive-untracked-1231@gregkh>
In-Reply-To: <2025062812-passive-untracked-1231@gregkh>
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 11:23:56 +0530
X-Gm-Features: Ac12FXwC05pfIP0vuicV5_xxuQYsfA7JDBPhIFqXwHeQhoKpkWFA1t07QrroD6g
Message-ID: <CAPHGfUOUR=m2rq-rFbUbWjF93qwY5ikHc+M0_KuHOut86z+Mqg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: misc: qcom_eud: Access EUD_MODE_MANAGER2 through
 secure calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0NSBTYWx0ZWRfX8BQu9uGFoCF/
 iQu44ouqrQkUebNFBGtl3QrR1BwIMC7vU3C76DuZoqAkZgL3J8THCSY5fUhDCu45PXlS0r0+pQG
 JUAyiWSr8+4s7U4NANVZ0DthymADdgEkIrS0cR+ZMWt7I7o4zxRPRrfRQCYxrB4IKAaTxbHUO6S
 XLaWIHmhjsxU1riOywdUBEJonhU0yLo+WnKxtMTTetSQhPkwsLjfI+7/3v1Ri1WUMVWxMB6uM7P
 p4IYuxlyYxpUNynd29g3STYpbaAzy31qzhOqakKOmPI2IdZxVZY2p+LDXNXy6lJmmUSL3sR+HzJ
 Xjisho+MqM4Jbi5HRDqUKRY2t4DfdpOG1IunsTvNkNeTj3u6TUONeInKeC5V5e8d0AJ9r/xbnJO
 Sb0MbOxcyP3PsF9vUlOkneeepP6dLIZCBo7/gMy4vNfCfDbjxn1jsv0EPmX1XDxhb/1f7zmK
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686cb280 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8
 a=3Jk0H8i_qCR-h2oskiIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: uN8PpFOJY4bx0UeJVUk_9OpYSk0SdcuX
X-Proofpoint-ORIG-GUID: uN8PpFOJY4bx0UeJVUk_9OpYSk0SdcuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080045

On Sat, Jun 28, 2025 at 8:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 27, 2025 at 06:21:31PM +0530, Komal Bajaj wrote:
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
> > Changes in v2:
> > * Drop separate compatible to be added for secure eud
> > * Use secure call to access EUD mode manager register
> > * Link to v1: https://lore.kernel.org/all/20240807183205.803847-1-quic_=
molvera@quicinc.com/
> >
> >  drivers/usb/misc/qcom_eud.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index 83079c414b4f..30c999c49eb0 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/usb/role.h>
> >
> > +#include <linux/firmware/qcom/qcom_scm.h>
>
> Why the blank line before this #include line?

The qcom_scm.h header has been placed in a distinct paragraph to clearly
differentiate it from generic subsystem headers, with a blank line included
for visual distinction

>
> > +
> >  #define EUD_REG_INT1_EN_MASK 0x0024
> >  #define EUD_REG_INT_STATUS_1 0x0044
> >  #define EUD_REG_CTL_OUT_1    0x0074
> > @@ -34,7 +36,7 @@ struct eud_chip {
> >       struct device                   *dev;
> >       struct usb_role_switch          *role_sw;
> >       void __iomem                    *base;
> > -     void __iomem                    *mode_mgr;
> > +     phys_addr_t                     mode_mgr;
> >       unsigned int                    int_status;
> >       int                             irq;
> >       bool                            enabled;
> > @@ -43,10 +45,14 @@ struct eud_chip {
> >
> >  static int enable_eud(struct eud_chip *priv)
> >  {
> > +     int ret;
> > +
> >       writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> >       writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> >                       priv->base + EUD_REG_INT1_EN_MASK);
> > -     writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +     ret =3D qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 1);
> > +     if (ret)
> > +             return ret;
>
> So the previous writes are ok, but this one could fail?  And if it does
> fail, what did the previous writes cause to happen to the chip / system?

Thanks for pointing that out. I will move the SCM write before the direct
register writes to avoid any inconsistent state if the SCM call fails

>
> >       return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> >  }
> > @@ -54,7 +60,7 @@ static int enable_eud(struct eud_chip *priv)
> >  static void disable_eud(struct eud_chip *priv)
> >  {
> >       writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> > -     writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +     qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
>
> No error checking needed?

ACK

>
>
> >  }
> >
> >  static ssize_t enable_show(struct device *dev,
> > @@ -178,6 +184,7 @@ static void eud_role_switch_release(void *data)
> >  static int eud_probe(struct platform_device *pdev)
> >  {
> >       struct eud_chip *chip;
> > +     struct resource *res;
> >       int ret;
> >
> >       chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > @@ -200,9 +207,10 @@ static int eud_probe(struct platform_device *pdev)
> >       if (IS_ERR(chip->base))
> >               return PTR_ERR(chip->base);
> >
> > -     chip->mode_mgr =3D devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(chip->mode_mgr))
> > -             return PTR_ERR(chip->mode_mgr);
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +     if (!res)
> > +             return -ENODEV;
>
> -ENOMEM perhaps?

ACK

>
> thanks,
>
> greg k-h

