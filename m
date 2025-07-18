Return-Path: <linux-kernel+bounces-736586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE1B09EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5CE16D633
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F619296168;
	Fri, 18 Jul 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OhLM6j0v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58552217719
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830099; cv=none; b=bOI/MOTZdMLBZIEwZ4C4kA4c9c5qzU0XR4F8w/a8IsWYr0dtDrd14b54KIJh8cebS4X0LzNOmz2IYLbRMhrpHjlm2MUWk6cueJoZ2zptVjU2ZQfooHHX6lNzvAjJB+HZyaPPdoUzYhZc0DXLzMQeEqFpfolnlvG5YlloDHxvLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830099; c=relaxed/simple;
	bh=sivh9ZbBaJTDzB+XRJJTKwoYziHMVoxJ1SX5MyOqOs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCJmjSHidMnthMg39nMGJ1+BqxU33vpOPhNHoIQqEJ9rT2ZbYN4UqC/wB7ufyqhYgljIoKkSwg17kYljh1cj6yI9/PTokzBjEEDIQLTiMGbc0rPQOGVzs0TDUNx1cpDRe1jPOw8Odlt+GEz8ZKB82JeL3OR0Vo2eV7SLt1Ty404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OhLM6j0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I7crSs032408
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BfoCIwxi0joR0bjBqMAXz1jJ
	wD9YiSTEZ3Usavq7MyQ=; b=OhLM6j0vd4LIIfOucB7WsJtO1v2pS7O/26isGjGN
	mxxOau+u8FgH8gq8f1S43MaOJZu/RHFCI+L+OZqYLfz0go1GD3wIAjwli9BB9yT8
	1V7IsWquneI/hKPIGywR1IQ2+qQ0xvx90uvn0WB6koX/gJTSwYECV1w2MoPzx69+
	Q8Lqj9VcbQb+1dLDJa8SqiHDyIfgpb7m9RBsFsUf228q55hhBw2Zgxvz9EpW6dL2
	9r9QVO5Sdm7TUodjY9nCv0/CKXCpLuBKrSexwxPk2TWlKQg4Rzx7R7531C53vXso
	g+ruwBfmlXsbfuODjW/w69CEAAIqy6OuiUGV/O8QpvJaIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug38b2h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:14:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e095227f5dso293787485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830096; x=1753434896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfoCIwxi0joR0bjBqMAXz1jJwD9YiSTEZ3Usavq7MyQ=;
        b=mVho5QEi2twjWrsLDKfN2XnM8fhsNoWFygKQSxATJ50p0PwgCP7mz0GPhhqUQqsQD8
         ZGDFcAcWIG3C12brhTIuUBmECVnKVFZ+2ptv7mcRyJMpaQrBoZq/5AeAKBFiIOYwLLD2
         sJPyLi1TS+BD2YE7jfot9wFe6lAqsD0IjQRZp5vaOngTTcqqCVKnENjP2HzPWjhhlxgJ
         tHAh0d+pGq6CoR84Qr6d74yNzxbuUKXOAHP+qCjzltYubX7YucWQeYEuhMot6khBFqQp
         Qhae3HbPo+PtFW3llATaGbdngOaDP2Wr/SVgz0gqXeOH8rql/72FzK1iGiw70sLVnfxm
         ZTRw==
X-Forwarded-Encrypted: i=1; AJvYcCV60P5Ur2eS0KzFWkpguz0s2PcilR9CpVex41aXeZsXWGFHIM5AOK3OUg6wg6GPFDsvnojnyXEy5B1v3Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1N/hWbznD74W4HxcnGnoOZSnI0mnUIRKD5wlHhzN+lUeuaXhh
	34sjZwFLiL6D+yN1JMrejhdOGQiAETmxWaPP7B/CdpJtbUA9CywRB+iBsTgr06MisdeN9yaCl54
	DpIJhsctlOJIyuijUbdegQblQPy1n/aAqWEplCoMekNMtvabAVEu6RfPdRAkUICjuZMs=
X-Gm-Gg: ASbGncub8izY/oPkd3rFVqYnTr8iNAWIukuSRckDhqocEDMCvEEh5ozGRYtr7Fu0wUS
	XbMILEoMb32DgPEr8bHAXngHRLq3Kae7YH4UKpuKv8isRTegN6EyTPAslwN3cOoIndgrwaWrm+y
	t+LHYXMDffN4fsEqHet/oTgDsjISqwhuUgzVMSLOszz1eG3pnY1dkRuBRepOb89MIyUehH4yXlF
	AXvtH7kTDawTe/iMJjrB7p6hwiFcZWE0d4BI5alSumIZDcO3UdTHLdBDfU2fPyjlhSPpoMtPHhF
	Y3aKH3656S3tu+WzJSF8ccDEKSI2e7qRAxmBBUMC+rnIgqffHH4CNPr+zC6iYzG0sM7AlKB4vO+
	Ejd50//3bO63V4M46vRlSzSQCMOL9OnAfdSzru3Ad08MmLpjGEoH1
X-Received: by 2002:a05:620a:4505:b0:7d4:653a:e9a8 with SMTP id af79cd13be357-7e342b72cb3mr1422084685a.48.1752830096285;
        Fri, 18 Jul 2025 02:14:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHekjEeOU1Lcp1E8DvurFzQuWe4WR22an0r1uchoUx++aHCtsJv4VB/D7whiQmgv+B7WWZ5/g==
X-Received: by 2002:a05:620a:4505:b0:7d4:653a:e9a8 with SMTP id af79cd13be357-7e342b72cb3mr1422080985a.48.1752830095640;
        Fri, 18 Jul 2025 02:14:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c569sm181412e87.103.2025.07.18.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:14:54 -0700 (PDT)
Date: Fri, 18 Jul 2025 12:14:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: display/msm: add stream pixel clock
 bindings for MST
Message-ID: <dkgt4t3ooivdp4d73aj4sbtheypcioqmvrtzxuw2uck33sose6@orwlg4m47tew>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-4-72ce08285703@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-dp_mst_bindings-v3-4-72ce08285703@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3MiBTYWx0ZWRfX/WgX9cJtn4pX
 j9qeOrwhfRp2bcNrRwhHOZahACeoeV8PL7HdHnjuE1VEDQOFBqDCKdUUtZ/1FDtHZpv8DPtR4VE
 mDjXBJGlOM+nH8oqi2jz55NgtLY48KrJ7Yl279/Ph0U4FAcsKBR8W2vJsiW6R5c7ZCW//nQovC3
 8+CR4h8HF0jCP3uYBkjdotWkPI9faqvReMAiyVjkYLumrBiIVJpBwfyDWSZp0liehIpcLKTIOFq
 gFQIh3qohi/2lmVHoY5d0myvc6TRTjcwmNlFnGZXnYeRhWPv4bITVcnXix9ls8SxoeDtPKAPt8x
 fLknBz+D2yIPtU7ALjlMLNM6c3axOk+fRvf3JFjvExtAFjZaJGQD2bqQPpSaGAYkjDNvykQOH0g
 kUlX7Ny67Vk7mbNYn7cYavyoA0ye5QI0n6t4zPQ4rm7bbl3OkSAAxNI9O4xyH6YvSO0jCWXV
X-Proofpoint-GUID: 3i7NaIGjPRmzLe3RPO9pnK-14vlwI0OZ
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687a1091 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=s_08DJon4HIwgivb4r0A:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 3i7NaIGjPRmzLe3RPO9pnK-14vlwI0OZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180072

On Thu, Jul 17, 2025 at 04:28:46PM -0700, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> On some chipsets such as qcom,sa8775p-dp, qcom,sm8650-dp and some more,
> the display port controller can support more than one pixel stream
> (multi-stream transport).
> 
> These chipsets can support up to 4 stream pixel clocks for display port
> controller. To support MST on these platforms, add the appropriate
> stream pixel clock bindings
> 
> Since this mode is not supported on all chipsets, add exception
> rules and min/max items to clearly mark which chipsets support
> only SST mode (single stream) and which ones support MST.
> 
> Note: On chipsets that do support MST, the number of streams supported
> can vary between controllers. For example, SA8775P supports 4 MST
> streams on mdss_dp0 but only 2 streams on mdss_dp1.
> 
> In addition, many chipsets depend on the "sm8350-dp" compatibility
> string but not all (ex. SM6350) support MST. Because of these reasons,
> the min/maxItem for MST-supported platforms is a range of 5-8.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 36 +++++++++++++++++++++-
>  .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 10 ++++--
>  .../bindings/display/msm/qcom,sar2130p-mdss.yaml   |  6 ++--
>  .../bindings/display/msm/qcom,sc7280-mdss.yaml     |  6 ++--
>  .../bindings/display/msm/qcom,sm8750-mdss.yaml     |  6 ++--
>  .../bindings/display/msm/qcom,x1e80100-mdss.yaml   |  6 ++--
>  6 files changed, 59 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index d8d94f62c102..2893f097df82 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -58,20 +58,28 @@ properties:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 5
>      items:
>        - description: AHB clock to enable register access
>        - description: Display Port AUX clock
>        - description: Display Port Link clock
>        - description: Link interface clock between DP and PHY
> -      - description: Display Port Pixel clock
> +      - description: Display Port stream 0 Pixel clock
> +      - description: Display Port stream 1 Pixel clock
> +      - description: Display Port stream 2 Pixel clock
> +      - description: Display Port stream 3 Pixel clock
>  
>    clock-names:
> +    minItems: 5
>      items:
>        - const: core_iface
>        - const: core_aux
>        - const: ctrl_link
>        - const: ctrl_link_iface
>        - const: stream_pixel
> +      - const: stream_1_pixel
> +      - const: stream_2_pixel
> +      - const: stream_3_pixel
>  
>    phys:
>      maxItems: 1
> @@ -173,6 +181,32 @@ allOf:
>        required:
>          - "#sound-dai-cells"
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-dp
> +              - qcom,sc7280-dp
> +              - qcom,sc8180x-dp
> +              - qcom,sc8280xp-dp
> +              - qcom,sc8280xp-edp
> +              - qcom,sm8150-dp
> +              - qcom,sm8350-dp
> +              - qcom,sm8650-dp
> +              - qcom,x1e80100-dp
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 8

The hardware can't have variable list of clocks. Please describe the
hardware here, specifying exact number of clocks to be used.

> +
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 5
> +
>  additionalProperties: false
>  
>  examples:

-- 
With best wishes
Dmitry

