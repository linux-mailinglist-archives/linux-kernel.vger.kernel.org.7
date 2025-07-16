Return-Path: <linux-kernel+bounces-733231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAFDB071E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62C558256C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8A22F2C68;
	Wed, 16 Jul 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Age+C2m5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F122F2C67
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658593; cv=none; b=Y/dFpsWvSgpvRiZW+9xwFWrr7SWC/M+B1D6xlxqt0pkbDWujqOfo1TSZThJqfkf2a4Xx+tQs+S36Bhytxrfnvjwu1G//Xh8YpsrrIsqCd7I2iYqFZn73Z1F+Jv7lnzuGaHKgBtHmX6TQISJ/WdjvyswX5aCaLTX589MP2fGXYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658593; c=relaxed/simple;
	bh=EExDnkbLNMmZL89WtYKR15I/FKUZ6Ju6W3z8pst4w7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJnvBsCelGkeNPS3KOf645//kAO2KwS2pJcr0lBMfGRh0eMTf4VYWCma87CNr04DRyI/ms3JoGYPtrWzEY3zCJ622vIgUGMkhup6WD7CFSeeqmVh2cixuMRWzinse7fYDmOaNu9gNfUnC1lxOgLsTR1Cgg0jueQn66rD8rUhHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Age+C2m5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G8p9C3024166
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPPqdCVa3SCxzu4lrBFnAzC+1OUqaDheNt9bAVS/Gg4=; b=Age+C2m5BTmyBzTR
	mCfV77xZzaG+hjtpbX1GfpKwgo3tjkjZJ7nW5HwKlRPm+H6kPXIjYilQl5HLlxwT
	/C+wlDQjj1qorBdQ9jUragYA0YbNDz60zHhHc7ookMQQAgbvlG+q+PDl0FHQtdFF
	c2onUBesW56g8RnZSOZRwG3IwC7VZ1JSHMf+LL1S2prRU72sJhg8JtJrynyQgnaL
	5AMKVeDOLzTyU4Hie7MyG4EFks8tnMfMZFpUPZU3RD1fDHGHZiaEKBKLUBHOI2hX
	zQ8Tt9jNTQ01YGM/Wn6UlMhv8mfC6D6VkCs4tVEinNy77P55fMi9lI+nbBzGbQ41
	9W4VhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7g4u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:36:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7ceb5b5140eso1186512985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658586; x=1753263386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPPqdCVa3SCxzu4lrBFnAzC+1OUqaDheNt9bAVS/Gg4=;
        b=owoTtC5rsuxVTCTl97t401aZqhD3fJQ3b/61GZEmmGI/w/nE6QeuM/CLpjox46zTyE
         l/ZdvKZYiFOF55pl06omMB7nYnfjy2LBmDR2oSbG2tURzZLLaWGjbOxvCWaz06agrWKG
         nHvdLuUaUk+o3NRbghTq++m+cTEAVOVihu44ztXbSVIRdKN0cQ1NgXY7SC9Phn9cN4jO
         6SGxY0pvQRBDGAVTIx7wDHWDXjphIp688Khn3CsuldDjgpHTaC8Ulz9U94A9Jabv9Sc+
         N3GN0Pjf/KOmp1m08kZso2ZTbe7KIVi/3G126N/VF/QrucZOjpmt8+ImUjEEIqeIlX+x
         gzZg==
X-Forwarded-Encrypted: i=1; AJvYcCV3JI6AlwB3bMf5RxuC2UnCuwO8OKv8EPksFON9QOTdhy2NEMYmbYQdDUKdQ7mfCguAFeTKSQUsaaTv0FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8Wnu0quufJMIoVlnfki2CQ1OLCctZPczkgQ3L+Srk7plM70x
	Zbe4whx8FicBbEm+im6SQMdiC7Wh3RpFd2yyR4nYJuavRlYF9/pFoU0OzPs9K1+UrSmxoYUwWye
	pdj/GSZYdTUQEx1Y5+ghFVZopqgg1ZH3PVmrSHJYNgUgMX//bg3WKecgFwEG7VE8UdFgwLDzVtZ
	Cz2hFh367aJnLgwDo2OwvqSCXYKgAYXg6AI7qpAc6TfQ==
X-Gm-Gg: ASbGnct3dfP5OW2jB92LIrzYPuo+kLrJNvUgIm/rHVUarZWw2Z8vzA2aLohlgpSSdCr
	+OtSQptdaJi71KDztNDZGR/xQuHsLET0wrlnnUrRVztHtyOdQhe/8PxWCoRe9BxhZqDKJhXPihT
	O6flaLtCuUKdRavqrV09gIlV0=
X-Received: by 2002:a05:620a:1929:b0:7d3:f17d:10c8 with SMTP id af79cd13be357-7e342b5d72fmr280286985a.43.1752658585774;
        Wed, 16 Jul 2025 02:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXr4m/rEAU00SH9DRFKQSi0AhmxOWUFx/f1zI1Wgtyyg52FTZL3NGdZg2QnnuAtYu79yBXEICghW2VnnD/x6Q=
X-Received: by 2002:a05:620a:1929:b0:7d3:f17d:10c8 with SMTP id
 af79cd13be357-7e342b5d72fmr280284985a.43.1752658585313; Wed, 16 Jul 2025
 02:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
 <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-4-0bc5da82f526@linaro.org>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-4-0bc5da82f526@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:36:14 +0200
X-Gm-Features: Ac12FXxMF_KwmB0e7d8OZI-PBqUi87qmKKbR1OTMm1-rntep41MJ3C1KnX9YimY
Message-ID: <CAFEp6-0hDqgYsjOy2mCC6ssK2LkMM0z7L_szS+M_wSMeMe3pMg@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] media: qcom: camss: Add support for PHY API devices
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4NiBTYWx0ZWRfX169vUnEJhw3y
 s4URFXHy2WgM8EbzPEeHz2MF765wcBRowVPbB6BOigwK4ojELcbdMfekf6vG1Y3gNkAQhXfcpqU
 LifhCGO7aJIwMq6kVgA2bEB8e7F7fd8hu4xIsy7ZJWqv7OqD3KlbPS8fb5KRbcAMk9O1eL29qQh
 z8rCN0+zwW4TxZYu4JJsBYIbxXvR/I8T6zgimBcTwb1sEj+iGyDOjONLVErp18jl6aZk8xDo26d
 RUNjfQlqrXjomUUnkmJQmdI1TQXTChJKUBUfF8QpczKSyAN1Cn4GUYZPA7JMl320PSD6ySOrcTn
 JjK90+dIp/1quxi2K2alqQjjXKx2K2P8/2OzhEitKASFH4uvwZ3QMHKdXa3P2cUX1XbwaSq8cgN
 XNjlViFZ24iK0iJ5aIoWgvUEnyV4Nfs6r+bQgV5mwxFu7M8OYc1nOh+IZ5t+jH+x7LN9zXnX
X-Proofpoint-GUID: YLwXNFE5hVdVSLWMML2BDdjeBp7U_ap5
X-Proofpoint-ORIG-GUID: YLwXNFE5hVdVSLWMML2BDdjeBp7U_ap5
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=6877729a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=KKAkSRfTAAAA:8 a=M0yTX6snB5HZV_fW_cUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160086

Hi Bryan,

On Fri, Jul 11, 2025 at 2:59=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Add the ability to use a PHY pointer which interacts with the standard PH=
Y
> API.
>
> In the first instance the code will try to use the new PHY interface. If =
no
> PHYs are present in the DT then the legacy method will be attempted.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/Kconfig        |   1 +
>  drivers/media/platform/qcom/camss/camss-csiphy.c | 157 +++++++++++++++++=
+++---
>  drivers/media/platform/qcom/camss/camss-csiphy.h |   7 +
>  drivers/media/platform/qcom/camss/camss.c        |  56 ++++++--
>  4 files changed, 194 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/pl=
atform/qcom/camss/Kconfig
> index 4eda48cb1adf049a7fb6cb59b9da3c0870fe57f4..1edc5e5a1829e033812bbadfa=
0de00625fd0c93a 100644
> --- a/drivers/media/platform/qcom/camss/Kconfig
> +++ b/drivers/media/platform/qcom/camss/Kconfig
> @@ -7,3 +7,4 @@ config VIDEO_QCOM_CAMSS
>         select VIDEO_V4L2_SUBDEV_API
>         select VIDEOBUF2_DMA_SG
>         select V4L2_FWNODE
> +       select PHY_QCOM_MIPI_CSI2
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/m=
edia/platform/qcom/camss/camss-csiphy.c
> index 2de97f58f9ae4f91e8bba39dcadf92bea8cf6f73..185a51aa73d102b9555e550d8=
041c25c8adf9af8 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
[...]
> +int msm_csiphy_subdev_init_legacy(struct camss *camss,
> +                                 struct csiphy_device *csiphy,
> +                                 const struct camss_subdev_resources *re=
s, u8 id);
> +
>  int msm_csiphy_subdev_init(struct camss *camss,
>                            struct csiphy_device *csiphy,
>                            const struct camss_subdev_resources *res, u8 i=
d);
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index c8103f8b754a29a63e32bb7bc213bfe14b4e0748..1817fa7f922b3b30168655bff=
bcd629feeec167a 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -3092,18 +3092,40 @@ static int camss_init_subdevices(struct camss *ca=
mss)
>  {
>         struct platform_device *pdev =3D to_platform_device(camss->dev);
>         const struct camss_resources *res =3D camss->res;
> +       struct device_node *phy_np;
>         unsigned int i;
>         int ret;
>
>         for (i =3D 0; i < camss->res->csiphy_num; i++) {
> -               ret =3D msm_csiphy_subdev_init(camss, &camss->csiphy[i],
> -                                            &res->csiphy_res[i],
> -                                            res->csiphy_res[i].csiphy.id=
);
> -               if (ret < 0) {
> -                       dev_err(camss->dev,
> -                               "Failed to init csiphy%d sub-device: %d\n=
",
> -                               i, ret);
> -                       return ret;
> +               phy_np =3D of_parse_phandle(pdev->dev.of_node, "phys", i)=
;
> +               if (phy_np && of_device_is_available(phy_np)) {
> +                       ret =3D msm_csiphy_subdev_init(camss, &camss->csi=
phy[i],
> +                                                    &res->csiphy_res[i],
> +                                                    res->csiphy_res[i].c=
siphy.id);
> +                       if (ret < 0) {
> +                               dev_err(camss->dev,
> +                                       "Failed to init csiphy%d sub-devi=
ce: %d\n",
> +                                       i, ret);
> +                               return ret;
> +                       }
> +               }
> +       }
> +
> +       if (!phy_np) {
> +               if (!res->legacy_phy)
> +                       return -ENODEV;
> +
> +               for (i =3D 0; i < camss->res->csiphy_num; i++) {
> +                       ret =3D msm_csiphy_subdev_init_legacy(camss, &cam=
ss->csiphy[i],
> +                                                           &res->csiphy_=
res[i],
> +                                                           res->csiphy_r=
es[i].csiphy.id);
> +                       if (ret < 0) {
> +                               dev_err(camss->dev,
> +                                       "Failed to init csiphy%d sub-devi=
ce: %d\n",
> +                                       i, ret);
> +                               return ret;
> +                       }
> +                       camss->csiphy[i].phy =3D ERR_PTR(-ENODEV);
>                 }

So what happens if we have `phy_np` and `!of_device_is_available`, we
just continue without any phy initialized?

>         }
>
> @@ -3181,6 +3203,9 @@ static int camss_link_entities(struct camss *camss)
>
>         for (i =3D 0; i < camss->res->csiphy_num; i++) {
>                 for (j =3D 0; j < camss->res->csid_num; j++) {
> +                       if (!camss->csiphy[i].phy)
> +                               continue;
> +
>                         ret =3D media_create_pad_link(&camss->csiphy[i].s=
ubdev.entity,
>                                                     MSM_CSIPHY_PAD_SRC,
>                                                     &camss->csid[j].subde=
v.entity,
> @@ -3290,6 +3315,9 @@ static int camss_register_entities(struct camss *ca=
mss)
>         int ret;
>
>         for (i =3D 0; i < camss->res->csiphy_num; i++) {
> +               if (!camss->csiphy[i].phy)
> +                       continue;
> +
>                 ret =3D msm_csiphy_register_entity(&camss->csiphy[i],
>                                                  &camss->v4l2_dev);
>                 if (ret < 0) {
> @@ -3345,8 +3373,10 @@ static int camss_register_entities(struct camss *c=
amss)
>
>         i =3D camss->res->csiphy_num;
>  err_reg_csiphy:
> -       for (i--; i >=3D 0; i--)
> -               msm_csiphy_unregister_entity(&camss->csiphy[i]);
> +       for (i--; i >=3D 0; i--) {
> +               if (camss->csiphy[i].phy)
> +                       msm_csiphy_unregister_entity(&camss->csiphy[i]);
> +       }
>
>         return ret;
>  }
> @@ -3361,8 +3391,10 @@ static void camss_unregister_entities(struct camss=
 *camss)
>  {
>         unsigned int i;
>
> -       for (i =3D 0; i < camss->res->csiphy_num; i++)
> -               msm_csiphy_unregister_entity(&camss->csiphy[i]);
> +       for (i =3D 0; i < camss->res->csiphy_num; i++) {
> +               if (camss->csiphy[i].phy)
> +                       msm_csiphy_unregister_entity(&camss->csiphy[i]);
> +       }
>
>         for (i =3D 0; i < camss->res->csid_num; i++)
>                 msm_csid_unregister_entity(&camss->csid[i]);
>
> --
> 2.49.0
>
>

