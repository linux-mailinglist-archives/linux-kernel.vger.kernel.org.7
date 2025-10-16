Return-Path: <linux-kernel+bounces-856301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322ABE3CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D19587BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1581033A01D;
	Thu, 16 Oct 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4W2Hmky"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81333A002
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622437; cv=none; b=dv9TNwBwpZMBJ+wrpUyNFlwX54PFj/pw/dObi7unShjm48a5ChfRMHZLQoMo77fOgcdkuP9wfFqiRgAmZESP5z31ab9R4/y4Zv4VtG/DQuCKMz6wh/lbFzJIm2vg6DtjpOiHM8mtYkX0f3oDDWJKtCUTQtwyZtf1A6CretgIfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622437; c=relaxed/simple;
	bh=yVzYk7iAXOmZR4zNr2Idxx6CcOc8TpqsoVAJ4tELSJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctss4jDbDBV2Q9516/9L9xYTqYxsKcfvfdsOXcNteqozLoBqmZa3Q7ZMwlSyA1m6q601foAELn3cYTOHz9bM+8R/1VjNrOPrCszx46bdbs7LT7NNcj/RcvXHImEZUzB2qUxY4FGfVXOItlAPwr7r/asRvuZxMV/lkEyniQty6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4W2Hmky; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDLNtd022472
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Zoz0VeVMOnao2Q3x5RK8NlkU
	vHUVM0E1Vb62tgX5qWM=; b=K4W2Hmky91H6D1TnGKbxhU7H02poQyBkNxSVCgpv
	sYgMZgZNLQq2xVTRw04gubXtKab4DE7cicImLqWgMPM7eh5p5HqhaF3VMUxKalP+
	ejeHMyvtJSDm8lXL8odER13AyjjlWZeWHyQ27l/Ek1skZLzijDJHJKtsH0bDdj+O
	monB5/VFeuVTjOQqQ8Roi2F0Qmi56n9YrqFU/6dXk+MeEeS/3MagIhn6x01QZ1Ys
	b+SE13AweIZeBtRMp/aQgdLXxY4BA5aKVMHlxH5Ghjee0qg2vYbwP6zceCj02CVE
	bOOlmxK10SdA0Aj5npH8xjZkfQYgPpWoD4S/1mG5T+sxFg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49u1h0r26p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e133107adso292851585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760622433; x=1761227233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zoz0VeVMOnao2Q3x5RK8NlkUvHUVM0E1Vb62tgX5qWM=;
        b=vl4FP3X63NtchyyF7vSXwAvmbtDJDUuJes3iYlS9FknxVgjEPllBT+8lrP+JtrwC3l
         nNLqY+Jmk2cpsaX7YwhOEnfSXs5juhshfBKRkt56Yi4vxkaMPBtlYPbxXroCn3a/bgPa
         UYrxyfJfXql0lsvldLpBO449TuLsiTaKaUXETIDQf+ofXVu96fsi3wX+TVc3Bz72488f
         ec2D/AtZzhFy1qakzaj5zTWLkc7tDFHkvzgTsnHViK3rZMdgRhVXgTvJ+3T97ztcqpJM
         Tk5I/xjZXB/HFgWDQ8cQQiE4CtpDTetu5f5Iu+RGm1izdO9ILS2dVX6Fme9U6oDabDYb
         B/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr4TGJ/3t+F896wmkp8x6pWkrVO4rgWDntFYxwhmmybwNBt0n2JKoROOccEMmqZXxDc5gTRNaxM8cZa+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLdWK2Ci0SvGAjyAP7oW5TilqueyEAGk51RzdHXupYUStMvKW
	7Vpn3DR5hQXEsz93LE64e9UZlKk5p03TXEuQzP81tnw/FyIVN8zBKlJnlnbj71OMyBkkTTeZVMJ
	A45xjkHPrZXzj8A8jXzou+IctyAb70mY0pBs/Vz2nblZ7Uw9yuY1/0UR2FZaCq0d2aI8=
X-Gm-Gg: ASbGncvjaRa6DGMUVuXr1aLspgBTr9p+gDkNZfBG0TmVEGXTu5gcsu5m/s08A22JKCS
	beonf8MzPf/hKn+EdLOX6uES66QQZ5+5POXu63SrWE8siIdvK3BrJ99DAo0Pyj6tDVGb/YVChwt
	T1OyD3gQpDe2Ibkflh1yFjSDJPnKUJZleCAy61LKL7DvbCXzN0Nneyf9tVXa9+a0HzefG1mbx0u
	uEFYE7+CWV2wP25yxU/IQgt37RKaizOOFT6m49Y5AaGUB56nr/kyUPTJehKbFGmhwwSQD4tMegM
	TwiF6Shgl1F+Pp9tadC76V4NZV94x4kLgHMskjzGpr/36zIrUBUndmWbsGkKa9rAMzGDzGWWJDZ
	fZ/aatYWKe68s4dS3TSHqc+Jmlzf//PqCs9xFJgxFVvLYKXX7FFYCmr5VPaCrzRrAMbIKxvD8JW
	xceW1DMBop4LE=
X-Received: by 2002:a05:622a:1895:b0:4e8:8b6e:7827 with SMTP id d75a77b69052e-4e89d3a480emr2310621cf.66.1760622433269;
        Thu, 16 Oct 2025 06:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcyJKmhQOG7iLkOgrsKwRaHI3ZRlEBKHgfzUT0aELnO1brTLqronfq7nvUhIamhy1jgjHbNA==
X-Received: by 2002:a05:622a:1895:b0:4e8:8b6e:7827 with SMTP id d75a77b69052e-4e89d3a480emr2310211cf.66.1760622432779;
        Thu, 16 Oct 2025 06:47:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4dd6sm7088908e87.17.2025.10.16.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 06:47:11 -0700 (PDT)
Date: Thu, 16 Oct 2025 16:47:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
Subject: Re: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
Message-ID: <gbwjh4tqaoxq2ng7moytv5vtalxpajdid5capjfqzare6dmphz@cmnv4p2q4eov>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=esXSD4pX c=1 sm=1 tr=0 ts=68f0f762 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KXxo3aNfgb-G34jaDLkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: t6YMPSyDbNzWeNBhFDkrbn7WDXBOYNRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5OSBTYWx0ZWRfX03Vo86nX+VNJ
 qpXzaXwiXE1WNa3u+t3199l84IrxQBujP9a9eyjqmBFweUzocT0aoR/xgCgjjBM/Is5ecVhdLqc
 RvikdTefx0wMU7rwK4RupMO8ptMIshA5cxGpdskWz82eQRzyf7Rxh3WA9BwJDgyr2oaAQMrknxe
 pc2Zx2gBFOOI/zdD1FzdB30rsBunNmUv/kkuGWmN7hgT3T6iJymPfu9PW6nv//SM5XE2TP/TVhz
 xyGmYX7ND4kl5BNgfsRrueEq4VFyUKK8qqfKKI+tPyKXaaoISsESdBy5hb8ozspIUI9M9y7bMnA
 x+FCkkX0ae8yOsNcVF36AlcTU0gmJM04UQjL8Byp8ryJczPVHB/Q7E41jR1X5mymvye1xC8zRRk
 4vh0y/IcdJqPcnWXFUP+EwvjFjpqng==
X-Proofpoint-ORIG-GUID: t6YMPSyDbNzWeNBhFDkrbn7WDXBOYNRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510160099

On Thu, Sep 25, 2025 at 04:44:43AM +0530, Vikash Garodia wrote:
> Some of vpu4 register defines are common with vpu3x. Move those into the
> common register defines header. This is done to reuse the defines for
> vpu4 in subsequent patch which enables the power sequence for vpu4.
> 
> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
>  .../platform/qcom/iris/iris_vpu_register_defines.h | 29 +++++++++++++++++
>  3 files changed, 29 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 339776a0b4672e246848c3a6a260eb83c7da6a60..0ac6373c33b7ced75ac94ac86a1a8fc303f28b5d 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -11,48 +11,12 @@
>  #include "iris_vpu_common.h"
>  #include "iris_vpu_register_defines.h"
>  
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
> -#define AON_MVP_NOC_RESET			0x0001F000
> -
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define REQ_POWER_DOWN_PREP			BIT(0)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> -#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> -#define NOC_LPI_STATUS_ACTIVE		BIT(2) /* Indicates the NOC is active */
> -#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
>  #define CORE_CLK_RUN				0x0
>  /* VPU v3.5 */
>  #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
>  
> -#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> -#define CTL_AXI_CLK_HALT			BIT(0)
> -#define CTL_CLK_HALT				BIT(1)
> -
> -#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> -#define RESET_HIGH				BIT(0)
> -
> -#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
> -#define CORE_BRIDGE_SW_RESET			BIT(0)
> -#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
> -
> -#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> -#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> -#define MSK_CORE_POWER_ON			BIT(1)
> -
> -#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>  #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
>  
> -#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
> -
> -#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> -#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> -
>  #define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
>  #define SW_RESET				BIT(0)
>  #define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index bbd999a41236dca5cf5700e452a6fed69f4fc922..a7b1fb8173e02d22e6f2af4ea170738c6408f65b 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -11,9 +11,6 @@
>  #include "iris_vpu_common.h"
>  #include "iris_vpu_register_defines.h"
>  
> -#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> -#define AON_BASE_OFFS				0x000E0000
> -
>  #define CPU_IC_BASE_OFFS			(CPU_BASE_OFFS)
>  
>  #define CPU_CS_A2HSOFTINTCLR			(CPU_CS_BASE_OFFS + 0x1C)
> @@ -38,10 +35,6 @@
>  #define CPU_CS_H2XSOFTINTEN			(CPU_CS_BASE_OFFS + 0x148)
>  #define HOST2XTENSA_INTR_ENABLE			BIT(0)
>  
> -#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> -#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> -#define MSK_CORE_POWER_ON			BIT(1)
> -
>  #define CPU_IC_SOFTINT				(CPU_IC_BASE_OFFS + 0x150)
>  #define CPU_IC_SOFTINT_H2A_SHFT			0x0
>  
> @@ -53,23 +46,7 @@
>  #define WRAPPER_INTR_MASK_A2HWD_BMSK		BIT(3)
>  #define WRAPPER_INTR_MASK_A2HCPU_BMSK		BIT(2)
>  
> -#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> -#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> -#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> -
>  #define WRAPPER_TZ_CPU_STATUS			(WRAPPER_TZ_BASE_OFFS + 0x10)
> -#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> -#define CTL_AXI_CLK_HALT			BIT(0)
> -#define CTL_CLK_HALT				BIT(1)
> -
> -#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
> -#define RESET_HIGH				BIT(0)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> -#define REQ_POWER_DOWN_PREP			BIT(0)
> -
> -#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
>  
>  static void iris_vpu_interrupt_init(struct iris_core *core)
>  {
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> index fe8a39e5e5a3fc68dc3a706ffdba07a5558163cf..6474f561c8dc29d1975bb44792595d86f16b6cff 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
> @@ -9,9 +9,38 @@
>  #define VCODEC_BASE_OFFS			0x00000000
>  #define CPU_BASE_OFFS				0x000A0000
>  #define WRAPPER_BASE_OFFS			0x000B0000
> +#define AON_BASE_OFFS				0x000E0000
> +#define WRAPPER_TZ_BASE_OFFS			0x000C0000
> +#define AON_MVP_NOC_RESET			0x0001F000
>  
>  #define CPU_CS_BASE_OFFS			(CPU_BASE_OFFS)
>  
>  #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)
> +#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
> +#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
> +#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
> +#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
> +#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
> +#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
> +#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
> +#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
> +#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
> +#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
> +#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
> +#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
> +#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
> +#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)

Registers here got totally unsorted (they were in the original source
file). Seeing this makes me sad.

> +
> +#define CORE_BRIDGE_SW_RESET			BIT(0)
> +#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
> +#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
> +#define MSK_CORE_POWER_ON			BIT(1)
> +#define CTL_AXI_CLK_HALT			BIT(0)
> +#define CTL_CLK_HALT				BIT(1)
> +#define REQ_POWER_DOWN_PREP			BIT(0)
> +#define RESET_HIGH				BIT(0)
> +#define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
> +#define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
> +#define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */

Ugh. This mixed all the bits, loosing connection between the register
and the corresponding bits. I'm going to pick up this patch into the
sc7280 series and I will improve it there, keeping the link between
registers and bit fields.

>  
>  #endif
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

