Return-Path: <linux-kernel+bounces-842795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F745BBDA09
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361501896C28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499E223DDA;
	Mon,  6 Oct 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSyLqFuk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7858D221721
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745373; cv=none; b=EbehuqUVYDn7MV9ow/lwzKWOd+Vi/8A+vCleoTp2Qr5Tv2uHhiaE+GXFOTGwjpVmaVd4W5G9RC5LcabLUZHMK3nfV0xCZVFIWe/87+4OvYsABknff7VJDE8m/HypjXOg7IUVGsng/XYBq7/WX/bsnVd9E1/HbZXAWLS59cVmFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745373; c=relaxed/simple;
	bh=DrdW6KuanUEELI37kvWGxZFB2M0jpb7t2yKI7aSfsIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR6JyJ1f5zhoOJJDc8MeW2UxQ9y7uNsWnoSITg6EGG4HOOAl8FdtX1h3SqTi1HCqScYA6dANr/frlK4aeWY2R/nc192lyvjeOMk/L8GvysfFDs+n6v1FedY4kS/A2ZWjBsUgUDw1s5GINnJZHo4gtM3IQXXQsuFJPuKADRaNpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSyLqFuk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960lZmt004958
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bXYSL6RF+4InEd3ZqLPZ7ukK
	78ULLvWwWztGrXPi/Lg=; b=NSyLqFukvnIpuOu0VLpXrMUvszqgIVaaEH8fuVtR
	tWz55tSwDwm2jpHH1++YsLnANV/+mQiFLa9Ywznq/mBSdWVwcvlsf2rFgq0jMqfl
	Gc6ARMtgS+x5tAVeHlG/5UkpDokjLECeAJSEzBb4P3F5xswVzQYwsSoKwd+k2LDR
	nzl7KhZ/RidNcWa/n0C0w5/YqznBux5sMRFjfTNVFg2il/aUXJC98g1ai31NuLM8
	AQf8NdRIQvkktvAujGf1LL0hSICTipG5K0+jEJQJs7uDSgin/RaeGwTyav9+8mv2
	yVI8l6B32zzL6fz5TOyZcMjW24C/o+4CvytdoVb0VG1EZw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhkcj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:09:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dec9293c62so117156701cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745370; x=1760350170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXYSL6RF+4InEd3ZqLPZ7ukK78ULLvWwWztGrXPi/Lg=;
        b=dWGd44fbIigr6KTKF8l0hOFNU/FUq+rKYgc9GZR33F78JW4w7emyBcODrI+17LN5x0
         zL9RyRsdAvW6UAdFqx6tv/4O3ZrJA7Xqvp17hM2+w4AFWHNmtRTnkWsetMysMUeo3+vl
         YkAVUKLMgz9D4JxyShAkKEu3U7bPJvoV+RqMkbgTUoLKyRX2F8U+ESJJjemgZHXcbQDU
         Mk1IQUMucOlr1vYAnErF9BtP2pFNPySwQCi6JQ9vTIrygNF85g45yHmfRQ20w9lb297x
         dRHzkhpMI134rjPjEOcYIUtsu95FRMIA5A1WTy8ppMWGuI4cgkeRKnAaZkHWTeVc5vGF
         K9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5KWKgIcWSSAXjxqsXpaymf3OMHKBtygC0FsUJ0XSQHeV+SqPNiQDqWkuw5ZVYgal3F1WpO9iLZK1MsoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WsEzJcm3F7yrx7giG3bZf4AyWLcHf1lFfHcI23JoXAn8PXdx
	OWoqyaCP3BuUw68r0LTlseyXHKXSm7ez/rc+A2VlFYS0eWDvyU4aVpvVVd5AU5zZd1kYgjVRF53
	0+h+xd3DZ4vLUtKHADaVZKIyz3YRpDPbtsTq8++/B8w1uvTqMy/PSmcSXhnB60Cgb78g=
X-Gm-Gg: ASbGncv2HaWIR/QZL8I5LyHlOJFSYZUrFFqK0lDmrzV58DuIJWIUF8WeFEr8fSbewKQ
	5WEczzgPTjJCGfmltJBGUSRpBxwRbDGckL2Cz8AXXyyZ5l3VPbpUApGmzUWi7FbIB8jmVcoBHNw
	uvTBItkumTi2Vqj2YecgLWYIaeJ+/EdeJmU4H0L/9icDTadCo/uTKItSYypynuey0KpxalhAbtz
	IOwiT7ZqfDnTKUKkTNQi0/kfM7qDuNp5JASeNljILvW/0CooJflcajVNJXdPSyZLj6IqbVqJY4Y
	5ZS8c6ax/Bwq7OGzMF4jNE47homXofNMBQXNQSpDAP69l/ZZFjGF2yULJfCWdie14R/VgsP+JGK
	WpHkfoyPPnNi19LT+iop0BtJXNdfEKTw5mO1ktoMfCV6byz2dOXgFD+pMiQ==
X-Received: by 2002:a05:622a:1f06:b0:4db:f0f4:9661 with SMTP id d75a77b69052e-4e576ad691emr146555151cf.65.1759745370167;
        Mon, 06 Oct 2025 03:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/EFwvYFDtuXYBmDcVcbVZDXlZvHJf8WdbRFA9SctOvGp2clXL+AeK+d+ABYU0RotnUXbOKg==
X-Received: by 2002:a05:622a:1f06:b0:4db:f0f4:9661 with SMTP id d75a77b69052e-4e576ad691emr146554711cf.65.1759745369675;
        Mon, 06 Oct 2025 03:09:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011ab24fsm4891035e87.120.2025.10.06.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:09:28 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:09:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 2/7] dt-bindings: msm: dsi-controller-main: document
 the QCS8300 DSI CTRL
Message-ID: <anirh7smpjsis24pl4k4wckrimujbbodwnl67n3ipebprz673c@kdaowpncrzia>
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-3-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006013924.1114833-3-quic_amakhija@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfXy5cM4piTbD9G
 vbpvYQcrbAVA11yINBRO6yPb1FNycX34fCQRsh4wzsnxr3nY171fVyiY5jn/A6+PTbfsOiGkJMN
 LLpnagXQ92AP/Kxj15VMad/lg9iOea4GvfTPJDaEB0+HF6t9BgRRCht/iTKNffGLD0odvupIGvA
 xgOhyX29ElR3V89T+C53U60WvqENBFfqiTm/VBMDOghB4renMe5BEU+aUjMxcRkG0bse/zbvInO
 AttlPR/5aK+xMATE4FHM1WGhB7qMoNVeh1Mdy4CaOKdrpFbPZzM/W1ZbI4Oav16IuE7gLjf08X2
 oRq2+rJuy1hJ8teaEAtpCkaRfDzSjI3EpAjIQ0gM1YAnrPEj8D+MQ7b9cqxHNa5LNqG0L1whjDd
 aMMhA/251EvyhPIdwq0FwDiCNTtheg==
X-Proofpoint-GUID: iBO3TDjcZQh9ZrqZFPKE4LDfYXwZiPEI
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e3955b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=F4Q9eJ9c0RUMKujZamsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iBO3TDjcZQh9ZrqZFPKE4LDfYXwZiPEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On Mon, Oct 06, 2025 at 07:09:19AM +0530, Ayushi Makhija wrote:
> Document the DSI CTRL on the QCS8300 Platform.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  .../bindings/display/msm/dsi-controller-main.yaml           | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index 4400d4cce072..8ae08d3b0200 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -45,6 +45,11 @@ properties:
>                - qcom,sm8650-dsi-ctrl
>                - qcom,sm8750-dsi-ctrl
>            - const: qcom,mdss-dsi-ctrl
> +      - items:
> +          - enum:
> +              - qcom,qcs8300-dsi-ctrl
> +          - const: qcom,sa8775p-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
>        - enum:
>            - qcom,dsi-ctrl-6g-qcm2290
>            - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
> @@ -329,6 +334,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,msm8998-dsi-ctrl
> +              - qcom,qcs8300-dsi-ctrl

No need to, your compat settings already contain the sa8775p string,
which will match this clause

>                - qcom,sa8775p-dsi-ctrl
>                - qcom,sar2130p-dsi-ctrl
>                - qcom,sc7180-dsi-ctrl
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

