Return-Path: <linux-kernel+bounces-856805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2006BE5223
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B494583BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE6123D2B4;
	Thu, 16 Oct 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XxlSv5eq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82523A98E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641126; cv=none; b=ub0zUkrE3PDn9f/e1h6gN/SX37EszSgrM1PFIvGiEb8SVpgN4w9m3tdsdmh81dDSRswXF+W9F6aVbhgWI1APGXOkehMp8+uiVH6j5oYSomYqmsWEFDCD+BsqlM2MGTpfttvngLODO+APqY4W/vRfRITm8/+ZLfFG0wbwpNPB7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641126; c=relaxed/simple;
	bh=D3BqG/SCBySSRJrTGIto0aG2AhzurQ8aSCA8wd8TrNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzf7Bs0HDKavmU9fk8sSimHS5qdMgKgbtcifRXCLqi9YuhPB1VAl6tX+n6873ZdE6b4TCVcDXUiKhNuWmXC/OHqsCpzAQsnlIS0unpOruuz9+5qeplHevtUDG7HNgWxWh8Ot5UJFNpViekgvOXqE1PbvY2SIOPv3l265Bdi9glc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XxlSv5eq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEcQcv003418
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JJtT47iQTu8SfkI3eRVW90bR
	qrjk9X6V6doI7auJ29o=; b=XxlSv5eq3QQuuvhhc63/m0Yjc0YMIKeY0rjBpLX1
	39LQZhmQD8WKqQb7/c5GdtTBWaLfrnUMdbcThuiaHtNrEbz1GxbYMYv6DKTM92Hj
	Q8bLM7tw9ZMaIDBmLhUm4wiivhE8VsmY40e9g0/rcallRYdt17wg212SK7jM1w8p
	b5Fg+x+7Se5/T7mCzz25advpIn9Z05eCdZ88UQMNDMgMXrMr/AH/5hUqM/SLEJ8H
	6Z48fnIKvEfY30nqUjUWT7D5ldVPLlrhXFZHeWrYIObC73BvJz6yOs3CDVDWVQxH
	gC8JlBGOJx+WRPGjnUT98OGbrd7fKT+Iy4ZpC8mEUko9LQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8r44f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:58:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc3aso1130541a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641123; x=1761245923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJtT47iQTu8SfkI3eRVW90bRqrjk9X6V6doI7auJ29o=;
        b=JJLDEzZsPMgwL7VQFisG8OKlursedjj6bI8oqC46BLXwey0yQt4X0KjS7DPAqJ5XWL
         lGw0+YwLjl3pLmX3fK1DMSSWbfcWF6uLJ7ZqEuXyTsMmw4ykuZJQnbNV1ImE83sE16GK
         c4C2tNoyVLtPPxGJ+4rHv76yg8OI7ZE9FymrFWe9ItGKTKmix2ahkETVSXnWNOd6gkyW
         XmYXQ1Vdj40ErV8MI28ztorNzhi8zj60+/09DACVC3jae9vgkV2PlmlI+bpIGKYSRQAV
         vcBlXZ278CUSiY185b/j44lV7nKO7BwKMadviSwWYGy2a1fRQll4cJKK1hUqCCsWqrT9
         Vkzg==
X-Forwarded-Encrypted: i=1; AJvYcCU0X4E4ERR+/8+YoEYnpjokeg309dcs3p7LyNfQt/0HAVP1Fkhylm6qWKgThttueMTPIBVFc0EHw3wcmEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAtUALt9uU44KpPVsTkZrpfWnT1tn0jJE/f960Ff+luiTn8iS
	Phsg+jyAqnoeoC+RKx5zMefI82L7RtjkTdrwwh4tdTonz8PUHfi70NZ3mVWf3dtplKk3J6Cv2l5
	dyk9ZnDYwQMTfgJ0SKyC6JNKO+l/dmZL9l8TCA4XLMnLZlxwbmVLl3pUe8kPrz5F2OQ9RMA5yXb
	AY9+lmOsg9pAEJAUL/JWDKhHQy7nNnfEN9B8XQOlD8ZQ==
X-Gm-Gg: ASbGncuYiI65s3ldlJq96QBoUFtEF07V2PpPZ4Zb6Yi7C3XeqGBi8kWuQT6KB682Uzr
	4rB/uraijIYjrPW20pR5e7J9b7VMhXHQee+D+FnqgqHt5A+WdqhvUdd1x6vP0CPSRrmwpiUTdcr
	E6mxz3mc7KcfYSHVCDxlnxZG8tSxdU9lAopMg5c2Kig6eRnGRckPhVOiwNtyGiH3l7+tc+J4vuS
	vu3p8NieZNEwA==
X-Received: by 2002:a17:90b:17cb:b0:335:2823:3689 with SMTP id 98e67ed59e1d1-33bcf85ac3dmr1062967a91.4.1760641122631;
        Thu, 16 Oct 2025 11:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH63mBxrkF0nq6LEF4e/wR0nD2Mj8cqYHhBMgm1l7Boex0xBrCWtVGSEAGnfUQGhfbWNOgF2zb6teASzZIcpCU=
X-Received: by 2002:a17:90b:17cb:b0:335:2823:3689 with SMTP id
 98e67ed59e1d1-33bcf85ac3dmr1062933a91.4.1760641122137; Thu, 16 Oct 2025
 11:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com> <gbwjh4tqaoxq2ng7moytv5vtalxpajdid5capjfqzare6dmphz@cmnv4p2q4eov>
 <c4c40efb-ceda-c13c-115f-a473af5e8fcb@oss.qualcomm.com>
In-Reply-To: <c4c40efb-ceda-c13c-115f-a473af5e8fcb@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 21:58:31 +0300
X-Gm-Features: AS18NWAY1mmcf4ZtpL5sJ7dzpkUVwzv1FjzPm02U1BnEjVJEA1IrZIrbDYHySys
Message-ID: <CAO9ioeX3cWsy1Xu7-iWxGiT4mDFKYF+sO34vsLDit8wDX7czoQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: OQefHppkK8c6dyi7_BHbJaNNYhl8UfFI
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f14064 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-53xr1lU8vRCfamL2rkA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX4fEBC5PZ5yD0
 IyeKViKj6GNHVnrPEttG2Sf5GjwjPTTpUO9TDjD1AR+f+9zu6QTcAo9ges/NlRKTE2OYE8FiA6L
 cXnxjf4pf5UX3NSedKzA+SwqrG92guwrq+o4I+WfGc06ildha1LcZcteYQuCfebCc57/NhRQ9Hi
 tz2WHu91aVp3qKMk6qytOFHa+jh67go2CmezErAw13/jLr+dK8Z2nfddtxfTNLm2qUAD0jOt79c
 laFeiB0Au/XukQ2QyKtJiHofYQT7c57xz7g8UTgM27QG1HHLkf3bOiGk6QdeQPV3KPuho4RE5Uj
 znOw8QVSrWIz0ZaM6Plmwdv6ig80ZM7DB0I90dqNMjdKcy8WtLPxpkI2hcc/W16eKdV6b8zqeJT
 Ue2hQzP+AypAU13WC0bh0M7Jts1V6Q==
X-Proofpoint-ORIG-GUID: OQefHppkK8c6dyi7_BHbJaNNYhl8UfFI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

On Thu, 16 Oct 2025 at 21:37, Vikash Garodia
<vikash.garodia@oss.qualcomm.com> wrote:
>
>
> On 10/16/2025 7:17 PM, Dmitry Baryshkov wrote:
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> >> index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..6474f561c8dc29d1975bb44792595d86f16b6cff 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> >> @@ -9,9 +9,38 @@
> >>  #define VCODEC_BASE_OFFS                    0x00000000
> >>  #define CPU_BASE_OFFS                               0x000A0000
> >>  #define WRAPPER_BASE_OFFS                   0x000B0000
> >> +#define AON_BASE_OFFS                               0x000E0000
> >> +#define WRAPPER_TZ_BASE_OFFS                        0x000C0000
> >> +#define AON_MVP_NOC_RESET                   0x0001F000
> >>
> >>  #define CPU_CS_BASE_OFFS                    (CPU_BASE_OFFS)
> >>
> >>  #define WRAPPER_CORE_POWER_STATUS           (WRAPPER_BASE_OFFS + 0x80)
> >> +#define WRAPPER_CORE_CLOCK_CONFIG           (WRAPPER_BASE_OFFS + 0x88)
> >> +#define AON_WRAPPER_MVP_NOC_LPI_CONTROL             (AON_BASE_OFFS)
> >> +#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL    (WRAPPER_BASE_OFFS + 0x54)
> >> +#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS             (WRAPPER_BASE_OFFS + 0x58)
> >> +#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL    (WRAPPER_BASE_OFFS + 0x5C)
> >> +#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS             (WRAPPER_BASE_OFFS + 0x60)
> >> +#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG             (WRAPPER_TZ_BASE_OFFS + 0x14)
> >> +#define CPU_CS_AHB_BRIDGE_SYNC_RESET                (CPU_CS_BASE_OFFS + 0x160)
> >> +#define CPU_CS_X2RPMH                               (CPU_CS_BASE_OFFS + 0x168)
> >> +#define AON_WRAPPER_MVP_NOC_RESET_REQ               (AON_MVP_NOC_RESET + 0x000)
> >> +#define AON_WRAPPER_MVP_NOC_RESET_ACK               (AON_MVP_NOC_RESET + 0x004)
> >> +#define VCODEC_SS_IDLE_STATUSN                      (VCODEC_BASE_OFFS + 0x70)
> >> +#define AON_WRAPPER_MVP_NOC_LPI_STATUS              (AON_BASE_OFFS + 0x4)
> >> +#define WRAPPER_TZ_QNS4PDXFIFO_RESET                (WRAPPER_TZ_BASE_OFFS + 0x18)
> > Registers here got totally unsorted (they were in the original source
> > file). Seeing this makes me sad.
> >
>
> Sure, i will be improving this part in v2.
>
> >> +
> >> +#define CORE_BRIDGE_SW_RESET                        BIT(0)
> >> +#define CORE_BRIDGE_HW_RESET_DISABLE                BIT(1)
> >> +#define MSK_SIGNAL_FROM_TENSILICA           BIT(0)
> >> +#define MSK_CORE_POWER_ON                   BIT(1)
> >> +#define CTL_AXI_CLK_HALT                    BIT(0)
> >> +#define CTL_CLK_HALT                                BIT(1)
> >> +#define REQ_POWER_DOWN_PREP                 BIT(0)
> >> +#define RESET_HIGH                          BIT(0)
> >> +#define NOC_LPI_STATUS_DONE                 BIT(0) /* Indicates the NOC handshake is complete */
> >> +#define NOC_LPI_STATUS_DENY                 BIT(1) /* Indicates the NOC handshake is denied */
> >> +#define NOC_LPI_STATUS_ACTIVE                       BIT(2) /* Indicates the NOC is active */
> > Ugh. This mixed all the bits, loosing connection between the register
> > and the corresponding bits. I'm going to pick up this patch into the
> > sc7280 series and I will improve it there, keeping the link between
> > registers and bit fields.
> >
>
> Ok, not updating this part in the next revision of my series. Do you mean
> something like
>
> #define CORE_BRIDGE_SW_RESET_BIT0               BIT(0)
> #define CORE_BRIDGE_HW_RESET_DISABLE_BIT1       BIT(1)

No, just keeping those BIT() definition next to the corresponding
register #define.


-- 
With best wishes
Dmitry

