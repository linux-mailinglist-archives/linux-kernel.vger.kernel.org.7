Return-Path: <linux-kernel+bounces-730684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC91B04818
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E8C1A65722
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0682233722;
	Mon, 14 Jul 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGPQ++58"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AA230997
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522671; cv=none; b=tSG9AM7t9PiA2is8lIhSmu/wZg9sOVMnDrC7I+qdQTsQk90FjV3j25PlE0EuYz8POIBApnMCqRt0itBGrZfW595VKT7xRb8clUnOI4ToZbwZCxqExQO/3L6fAXh+TlX+eR3ETwxMjiVLLYzjc5Eq79lL4HgLmtU+04oREmP09I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522671; c=relaxed/simple;
	bh=P2DjgQqNmhul/3Tjrh71ORmKHZE60e0bzK86Zvefny8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7TFQKFb6+p9kF/s+hoplwyxwej748wGqpf0fxUuqxCkYAq4+F6EWlHA1qJfCo9bY9d9eC4lPfrwF6RggnYQiVtH9BmizMFvP4Va94KYVa4HwE6MA9fFAMSyBICK5sTr8FBL0633fAvzs+9y6hRlfBr7ayxaNcGFpo7q6gFnO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGPQ++58; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGJsQ8015971
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=cHAxU5EnEHUmmvSd/XnW201tIJmHnogoSkLScD389cU=; b=WG
	PQ++58bGoF+QZqX8R59+SGOPQ5PGrMacju4rWcCYnLEkDxTgEJpKP7YkBwD154sq
	9WiG72nCnuXda1yJIvewzAF2zawQFDgKGOrKExlFBKoLj/C5y2wPx78Nha1PiqBX
	Twqo/auhtkq8WhM6evSTi0ZYi8n2erpzgm1acGEMk5bghAeqxykWQAqEBUU4Ed1M
	6px2RztULwEMNBz7M641NHGu5GdxX+hx+qOrB4EdMRESJYB1B3te87vDc7l/x3OX
	87+DDYTkC0cUF5H7GaNoudRFJssKsuEC7qnwnBxO9NyxB58x4yf3P3OyrQRN9MXf
	LIGd1bQId2+prm6eMjow==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxawss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:51:07 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-61573600cd6so979229eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752522667; x=1753127467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHAxU5EnEHUmmvSd/XnW201tIJmHnogoSkLScD389cU=;
        b=tW5IvPHCwPltoeLQ6ACUsDF87hC904gB09iS8mrDb6gybnSi3c43LuOkBfk3Njd5Oc
         ytGtOAUhp0yV9KHLWWTgXWLbP3tkp/d7OkRoBWxfBKj4Kr5kW5yoFERn40zaBWuXNj/S
         MGpbo0+j1KV6ThDpBWui63F5LFgg9iDbwUB63rjiPHR9pBJq/1/c3A84Pl4PjI8bWdcs
         tF7lY6zFz2xMY49Kt+FHn+bF0hXtdFHajGWlg1Hfsc6k2MWNMF9Tg3vD2KTbpNJNej2g
         zP54xiYWx4plcdFCBEm4JcPcTrNJ1nVptXeSqybOVGeDjXtr1nP6HxcbU8q1lbqV4Xco
         wKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgJWjp42iQsnKv0B8o8TXeJ7/jYZPP+wPcZ0wnrXlkSDLqi1jjcvWuGkXNmkyzM4s3OVWPAD9PupHRFew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWy5d9CVai0bTGfFZjY6LJAtX7LtBqz6ETwGRg5blFuYBSLME
	W/gszUh81ROrTXwrxKu8jOZGS/ZRW8NDL+HmLHTwwPQVLRNFSFQata2ROg9bi3Q24K7ZT6dJWEs
	BPBZwIliQkNR26R3E9X/Z3wtFqpBuD6NQiUef6lIK372C+KvWoMjGmfSYHtleRzcxOB+LrzYPHv
	lM6iqUgO7hU5gXwph+DmN1CVOjrtiBFiXKRrM2T3moZQ==
X-Gm-Gg: ASbGnctA0PauaqTEA3VQK6KG/BfqUPUKQP7o9k4waiAWpLIqCsK4e1k8MJpNoQ34wEG
	3dM/jrZl0ATa+B00hyGqOo0RiCUV48P3hgWOIyKuva9akU6wemayQbTB6ZTB3vQ3HBa4AYhy/ei
	600P2p4vU7rbv8ZokfK26AS9aNMlolVFCO/qRiMskV+gNLIQI1BbMk
X-Received: by 2002:a05:6820:2b14:b0:613:90e1:729a with SMTP id 006d021491bc7-615933298d2mr395646eaf.4.1752522666664;
        Mon, 14 Jul 2025 12:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvNOTRr7nTbzGLFYFpm62n4sXgSE9iNBusqXlHlebIghEEjvoyILcY8+9jbV1NxN9chrsAuYDFxtNto888VVg=
X-Received: by 2002:a05:6820:2b14:b0:613:90e1:729a with SMTP id
 006d021491bc7-615933298d2mr395636eaf.4.1752522666307; Mon, 14 Jul 2025
 12:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714173554.14223-1-daleyo@gmail.com> <20250714173554.14223-7-daleyo@gmail.com>
In-Reply-To: <20250714173554.14223-7-daleyo@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:50:54 -0700
X-Gm-Features: Ac12FXzMmQvS5rnzO5-iDknQYE-6ywvsNV2cxkydI09oPN8GV7Xk6HdI3xrZ3s4
Message-ID: <CACSVV00-DDnQYp-65Pi-XwpEKT1_jYik2=zH_bK_oJiGLxX48A@mail.gmail.com>
Subject: Re: [PATCH 6/9] drm/msm/dp: Work around bogus maximum link rate
To: Dale Whinham <daleyo@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Ma8NxEuTrtdmOOglsLcnJ10VhyvqZZAD
X-Proofpoint-ORIG-GUID: Ma8NxEuTrtdmOOglsLcnJ10VhyvqZZAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEzMCBTYWx0ZWRfX1g5e490TISaH
 LH6Gzej/8ZJVQSbcE8i/TJo6gAUPJVzU4tGK8TyUGiu1zh/JmuQFY24f+zpMi3xKy4sAoOTsNJ8
 gdy1mSWdT0rTisb/9U+UiCG/WDAqUpKE9oqLcl/+2+dvw3wiHzb1l/3oqUXFJhpW/ZNMDwIy9DQ
 NspCnOj+9d1HPnVW5gc3PJI5DJtEIlHYFtHqgGplomYrZyzDkEcP7IU297nganCj8I4LkaKo+Ue
 vXggKPjn3IZ3oZDRcnHuKT6B4ie+pXVvrIz7n4cr1ovXsZ2uPsjwRDBRZQ8jjBCeMDwde/qa2K3
 VUYXCN69QEJ1DxhoHhrxBpsBte4zuWw3MFAyvUacbxlNa/zwKPWxd22F0UcrKK5ZhdyW6VL5ROd
 41iq6jc8mYzOXbebQ9Esxpm0m8qNOk0n72owTmQMY9yCtle7DXj4A1YfpK9GKqYFgzgASNBd
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68755fab cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=pGLkceISAAAA:8 a=B0QqisOVu6ZhBNclzXcA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140130

On Mon, Jul 14, 2025 at 10:36=E2=80=AFAM Dale Whinham <daleyo@gmail.com> wr=
ote:
>
> From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
>
> The OLED display in the Surface Pro 11 reports a maximum link rate of
> zero in its DPCD, causing it to fail to probe correctly.
>
> The Surface Pro 11's DSDT table contains some XML with an
> "EDPOverrideDPCDCaps" block that defines the max link rate as 0x1E
> (8.1Gbps/HBR3).
>
> Add a quirk to conditionally override the max link rate if its value
> is zero specifically for this model.
>
> Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/d=
p_panel.c
> index 4e8ab75c771b..b2e65b987c05 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -11,6 +11,8 @@
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>
> +#include <linux/dmi.h>
> +
>  #define DP_MAX_NUM_DP_LANES    4
>  #define DP_LINK_RATE_HBR2      540000 /* kbytes */
>
> @@ -58,6 +60,17 @@ static int msm_dp_panel_read_dpcd(struct msm_dp_panel =
*msm_dp_panel)
>         if (rc)
>                 return rc;
>
> +       /*
> +        * for some reason the ATNA30DW01-1 OLED panel in the Surface Pro=
 11
> +        * reports a max link rate of 0 in the DPCD. Fix it to match the
> +        * EDPOverrideDPCDCaps string found in the ACPI DSDT
> +        */
> +       if (dpcd[DP_MAX_LINK_RATE] =3D=3D 0 &&
> +           dmi_match(DMI_SYS_VENDOR, "Microsoft Corporation") &&
> +           dmi_match(DMI_PRODUCT_NAME, "Microsoft Surface Pro, 11th Edit=
ion")) {
> +               dpcd[1] =3D DP_LINK_BW_8_1;
> +       }

Not a dp expert myself, but..

In drm_dp_helpers.c there is dpcd_quirk_list[].. which applies quirks
based on the oui ("Organizational Unique ID") of the dp sink.  I think
this would be the correct way to handle this.  Although I guess you'll
need to add a new quirk for this.

Idk if the surface pro 11 has multiple different panel options.  If so
you defn wouldn't want to match on the DMI.

BR,
-R


> +
>         msm_dp_panel->vsc_sdp_supported =3D drm_dp_vsc_sdp_supported(pane=
l->aux, dpcd);
>         link_info =3D &msm_dp_panel->link_info;
>         link_info->revision =3D dpcd[DP_DPCD_REV];
> --
> 2.50.1
>

