Return-Path: <linux-kernel+bounces-757224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC40B1BF69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAA18A5C59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC171E2614;
	Wed,  6 Aug 2025 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzCGJaoS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6A4C83
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754452028; cv=none; b=TihN88+QMiGtSRg6MEQjFvfv33co8PocJdtB65fJstceWKb4fMhO4UgMmQd4YORt1edxt7Wk9HCUBYLiTvuKauLRcqn4roMRIwq+GxYuVKwIPE3QY3r3Axw82sb9540ARhRzQN3yM8ki3cJOSwx0tovZyuxrHTFtgCoTLrU5zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754452028; c=relaxed/simple;
	bh=SZNNbsaDOLAUvUge4L4R7nT1OmTDf0tURWgAzVUteLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjdTD6KbPwTL73Nuka/kQdlZpg1PkJ0ELe9CvBHe8C0f/7RwtE/vt33ssE7YqlitjR7OVaIBMGj+H3vQROqz7Xq8V+P9UU0qFbLys4Dnl1SSyLSHUdeOwlq+zk0lcDitxRB8AdVnObZGww5c6EaPF4GslNMBW/vVrYnsf8m1Z/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzCGJaoS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761f2Of028486
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 03:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uzO3gUvM2oUa6aLeaVCj3dH+
	MS759piHbjXm21lQVQ8=; b=mzCGJaoSZ6f1FgMO9zeG/iAb9tlRkfedI/WzWEC4
	LcHol/+wg/+ZmGqYtYExKN+kWeXgPNAnDtg7+NSuTtEFo6eTiSJ+82NQ4022vci9
	/ZZPLtUY9J03B1W7pLyDCk/C+3Vlw5NTkBwXkOy9/rnXC6vT2dV2bF5mQk/TBScH
	d9VD6cpp7NxN14fnq39hAg7sBv8X6RvRmxeyiLbuy0h9lsy48MIwCDw2wNrBlksj
	2PAY6PMSpoFvIKhwzv0b23KCPbDqyG7+VekHY/Z8D4CybckxEOcswoxN+sAkRBPn
	r90iR0zqHIBrTP5DYFUetO0iG+Xv9YvdSC0e8s4tgd3LDw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy7say2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:47:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7ffcbcf7eso479410785a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754452024; x=1755056824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzO3gUvM2oUa6aLeaVCj3dH+MS759piHbjXm21lQVQ8=;
        b=vZUadBQWjVcCBZBliYH19q21JxVRMCDAtDsBHwrSFoXc/dTnS+ARWOtuq9L7sAYp1C
         C/riRzJtqWWP/brfP4LCB6gUPXRs/jgP5l7I42sUeSlYRKs4EztW+H9G9XiLBnPEJ7ji
         1dkxsDsOgPeoApq9ldgCfHhCbtbiE6YipGszrSkWZ+e+uuavt8M+nwrh3ExI8aHxT1w5
         Cy0PiMg2EzNfIfV6IBx1yDFSRHLfZ5QEIXjMNzy3PGicY7oNuvdUNO3IWEMxVFNE5jA1
         AUFHsih0J9A5TqvHbHrlCXZ/Q8Mo2csvMbXTYuNxFLlL/kUDkG35sAKMx2rZ6F1KcD5B
         kzpg==
X-Forwarded-Encrypted: i=1; AJvYcCUbUurpH0PGzcPBZZmrQjHGIXqmrJ2+DMNbQN6f1qxkkRIM+Ya9PaYye+9I1Q+EXfHV9u1j5qwopJer6u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtP+R8wZXNdwoGWzZTa2Oh32hNLsTMPDnsmyeJbAZv3IrmSQx
	lgdyj5sVZxoESO0RS2YscovbwgVD9TUarh4pAMqAIyAVTZ2mZ4swhk/IBIyuBJW7nICYKnoTuxu
	JTsqikYInQpJaBGVllAWwgXFSuKhhjkY5MFIXLaJVNHqGj0WgBxpnpFFC/kZj22kWjQU=
X-Gm-Gg: ASbGnctND770ujeQLJ/gey4sZtrfLb9EtGzZ17jmTrtf5nsMXFk4t/40OByyOIbSF2d
	dAFNu6K3GqCun8K6FBwfswpck2nLtf4asDP3Brr1doT7nFU9b9i3V1HUuTJjXe5t0EKtyQmfcq3
	DjVda/0sI9HOjtM9KVZD82UoALdyOXvWSXPjUJRDE/fdbkumY06O0RiyENMVHSEGG9PfQN6DFSy
	wi6WZ6zVu8SGcV7uRRUwWkhvIR9WNLeQhkbpMH8UnEjVbEhQvbEnGkpogZv0aF+MJ2JIMWvRQSj
	GD3pxD9ueaazI/NIw52MAR5YfjNL359kTiFfNlIRZeM+CaQw7nDfJnr6+FvnoJgDQIdA35eIBX4
	TD858RDHyX/oBM+c4ibGINQ3Jy54Y9HK4lpp4Dl2Bvess0Gb/uKv+
X-Received: by 2002:a05:620a:aa13:b0:7e3:49b5:d53f with SMTP id af79cd13be357-7e814eec6ddmr188020785a.34.1754452023481;
        Tue, 05 Aug 2025 20:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETZoK/bA2Y9Krb11P0NcogumIV9weE+6Fu9JMkAUX39k+KYb80V4r912KnrkZIKfzAnXHpaw==
X-Received: by 2002:a05:620a:aa13:b0:7e3:49b5:d53f with SMTP id af79cd13be357-7e814eec6ddmr188017985a.34.1754452022876;
        Tue, 05 Aug 2025 20:47:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88db2214sm2114064e87.177.2025.08.05.20.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:47:00 -0700 (PDT)
Date: Wed, 6 Aug 2025 06:46:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/6] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Message-ID: <b24ln55wgmjzksugbowgilxqbnp6d6mgq4cdqljrj4jftuefa5@gjcszc3t4bqg>
References: <20250806-mdssdt_qcs8300-v6-0-dbc17a8b86af@quicinc.com>
 <20250806-mdssdt_qcs8300-v6-2-dbc17a8b86af@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-mdssdt_qcs8300-v6-2-dbc17a8b86af@quicinc.com>
X-Authority-Analysis: v=2.4 cv=Mftsu4/f c=1 sm=1 tr=0 ts=6892d039 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=q-PZGS4JpPPfnBF8F2QA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kkoY2AuQx4QtU83d8v2QV6_JDGOhYkvC
X-Proofpoint-GUID: kkoY2AuQx4QtU83d8v2QV6_JDGOhYkvC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX9eyxbNvVl0Pe
 UkgGohNL0piHxxmHLROlQCEp4xNgP++aPsUCGfro+3Gctxax8QmPxGoES0+SYHCkCtTFNwnQ9NP
 AZRov8hiNuAcERfNFswXUyLjrgnxS2L3pb9CZBZaaw5cXmSh/3HcGwqs/ijxXEy6xe+LvXDDUv9
 R0Wu5ul/0znDu0g7C2gvsTGD4unAEpb+NC33hpNYaFliVuKnc3wy5eFWtwAGiK1p8Xc42P4PsEL
 2VzIbkSLONyTPPD2HSg4dayFZjupupaLkujNCw+6m7YV7msLaW7/M0W5lGbNJs6hgfFi8DQ5ni5
 xX2rTa13SprZcMKctc2wkaQmCz5J2+9jj6kCVOBIX6ri42HAXym940ziAgtX3xByWuo4xD0U5sN
 3mJSq/Tj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On Wed, Aug 06, 2025 at 11:16:46AM +0800, Yongxing Mou wrote:
> Add compatible string for the DisplayPort controller found on the
> Qualcomm QCS8300 SoC.


Typical comment: you've missed the explanation, why it can not use
fallback.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 2893f097df826a5f941fbb754fb4a96a1e410a70..f5930f29c91ec95e9182c7b8ee83c0549c6657cc 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs8300-dp
>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp
> @@ -186,6 +187,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,qcs8300-dp
>                - qcom,sa8775p-dp
>                - qcom,sc7280-dp
>                - qcom,sc8180x-dp
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

