Return-Path: <linux-kernel+bounces-866928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BFC01102
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9F33AA787
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD84313541;
	Thu, 23 Oct 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FTtuAEou"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B087313530
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221885; cv=none; b=TSVfpUPeu1CaihWr3av2rA6mj92SjiPS3qkk95ipyuK8GMuvKhNXIwXWAhXF78lmakK+6RnPJLSk1xMGoa5ctJUElQ1u0fbc00gbVIRwXf+C3qvkus2FmNdfIZQlV4fHLBBDMIIuuM964EBrAtuDYXSwtOat2eDeqFv3+0FzMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221885; c=relaxed/simple;
	bh=LWgkqKBorpr/kjhxEBAgg7GDiTpoir1TYcClkGM2qiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8RJgXny1vMxAOt/QC58lAGqvhCepp7LBb+VR8qwZPga6+iW3Y09dk9DNb4U+jxI5GXpYr5FYh0i+ye2OPRpZjlJG77ecOXdpHTseh1l0JTS/zpWAcKlvMFCFI/0YrrPPrmu2HmjSTl2WwtCSe5wq8bLyqW4sr++bY4zNNmun7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FTtuAEou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7K2D3022504
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ROFrsQyZm8CifMY+KSTeuljF
	MGnyvNU7m+oJiV21M1s=; b=FTtuAEoupXC5vdrrdyN6IxcUq+6yZemCgio0oCQD
	O9ESPbFCoEwgoO2OgxMOD4PaaBGiBmf+bgtaj2PgIlTDRyDIqGK4mBVXszrWVpUR
	UUNWk3SbmrypTznS/u7oqEM+4wMx0ut7ONpVxXg0S1wqoD20QmgEhwYQAsFiYupQ
	7U7+ivuGwHVztmvC9c1vPYaBbzh/OGrF9se0c4J/FISDE2dUOihmXbGmNDOgROpU
	bDzmlbt3MaYIQpFWQOYba6m25ah6FsUaWCdo7E6R36UNxkqTdMWoFG2lADYTOVKh
	fwwDNkgqpLrUA4yQgPu/k3l1cBeuD+I5TmTZKWRZFYhI6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w88bgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:18:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8a2ef0249so23122271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221878; x=1761826678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROFrsQyZm8CifMY+KSTeuljFMGnyvNU7m+oJiV21M1s=;
        b=TP+mH3P0OrBi6rkhBCa6mJ8tIKNCmLvE7nPlq+m9Hrk7l5GcqrEggX7JkbYa46O3v8
         jwu9EJyJOvxI2+wHQztAKAzGf67KSd9RImNkaqVIrG8sa2P7ZvjcicNDSTVM5ICA0E/e
         LpurwTYcsZBhHss7zvjfO799FOxcvrPPUs+CfZaazoH7L0J9gQmlNeN/kSLQ7hnfqoxA
         dolPcJMqqV8E5gMt8j3HkPWDW6MoCxC497UhzN0FG8nnikX5p47oj7PQorrIdLkY40i2
         BltIh/ACkHW9nK94WBTQQC39E7W1PNP2sh23fWbvLIFKofLlEsvKB2zf5aT7Uo7vsrO2
         mmow==
X-Forwarded-Encrypted: i=1; AJvYcCUkl8SwGzi6Apz3D4DufsnogrYASecvDwLBEWUmhYTKjFMSzMXvS0WlEIZlhBtEnxCm5iaYwwyzVqw3dLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyi8Ee1cDjeRM+tbW+OfUdBJxlh8/OGPkB1g/qPlPKoMybLqFS
	fJ5dCeSiWs2LpspwqAWqtBWxJWCbGDf2rYV5vuGo6h1Ij1WiGW5Fhx0L3OyV4H+KDkO4FCffgNo
	baNH1Na8tFPL8cvbjmsaJkveVqv85s4GIySLrLt52M2FrIKisegVpPbXcfUxS03QmrFU=
X-Gm-Gg: ASbGncv+UMU2qapQ9eYk/dntZQiyq8dHGyzj2xITew4+o3/JaO3eGFnu5xR26J18lOw
	PEzWIqy7yJVN6CuvgW5PQRh7ppYzLM/J/nvSysNhmAjOdBdfN+Ue59BYd652vcDdlxsGGvjXjlz
	JafAxKh3ES1Q3jAZddtVloyDN13kISQwHVItLMbIWDJsvpleQGvYB98wyvYCSIIKpqg+wtv/hpx
	GiIGY5ZMiPu9hs3E5vu2I42vMi9asaq6KGllqdUC8l5yyRprpNAa45tnpSAWn17x5ylSBdnD83j
	uKVq2y56e3SOOkGRI3ii6/PZWpU81Iz8/H4UP27YaNM2rMXnC9gbI6Xp2gOaHyxXDlXVu0tpJ+j
	MvDbOx8JKmJ4kN36MLwSsYlcUArZyh37E+918qospfg+GhBVQzL4/prrQm4Pa9o9NRqn5XheHeL
	dcmAWR/3h0Z0g8
X-Received: by 2002:a05:622a:1b8d:b0:4e8:aa15:d927 with SMTP id d75a77b69052e-4e8aa15d9bfmr268551321cf.47.1761221877845;
        Thu, 23 Oct 2025 05:17:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM6vcDVrWNof3DbeXJ3ZyXrq6655uWMwZz0bKDp8nNSSm+wXht2S5o3XqgeX/K+hhx91DY1g==
X-Received: by 2002:a05:622a:1b8d:b0:4e8:aa15:d927 with SMTP id d75a77b69052e-4e8aa15d9bfmr268550861cf.47.1761221877374;
        Thu, 23 Oct 2025 05:17:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4aded25sm697972e87.16.2025.10.23.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:17:55 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:17:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 12/12] dt-bindings: display/msm: qcom,kaanapali-mdss: Add
 Kaanapali
Message-ID: <3jjgcha25ieekpulyc64gafyg56n66emr2ibmtdyugfsm6tjvh@rkhrs474vgdc>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023081736.1251-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023081736.1251-1-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX9/EyLu1+SCHZ
 183OHwn2SGKnsB5kJgRZnkNBd/2NKjZnkvEw7MMR00SqRuI5XW+/7I/9IMB5MVMTzMiD8KzDEvh
 L7/hivId/DvyPzSKzeYL9/7Njcwc3gzxjPqb0TJ21LMt4DvxoMvA4HEdiFn1IkQ6d6FrFG+8CxB
 yFatMN3BsPsW14Woci3u81EZuqHHd/0KBLq9NgR1wzGUgeSATmomuj7Sg3K8bcPpwIb4angSixr
 p+6f2oCV7N9UeACnWBw8oWHVnRG8LcaWv+IYMKln6dWywp5Oh/+RS7ADXk6bZDtf3ZHhiZTffSq
 nIX5txUVmKAXvOQEiB7RCHXLvueQqgAFHa/tlYkkksTJZFmjV/IhPr0dt9ao/IDu7jgszoeSqb0
 3/jU7MHYJW2mHXvXdAXqVvmwolFSTA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fa1cf8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UAfhHCFBB_nVBZkyMDUA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Vl7GNr7Y1qlQ9FuKQRjYq1H5JbhnRfW2
X-Proofpoint-ORIG-GUID: Vl7GNr7Y1qlQ9FuKQRjYq1H5JbhnRfW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On Thu, Oct 23, 2025 at 04:17:36PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> Add MDSS/MDP display subsystem for Qualcomm Kaanapali.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
>  .../display/msm/qcom,kaanapali-mdss.yaml      | 298 ++++++++++++++++++
>  1 file changed, 298 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
> 
> +
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: qcom,kaanapali-dsi-phy-3nm
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +
> +            mdss_dsi0_phy: phy@ae95000 {
> +                compatible = "qcom,kaanapali-dsi-phy-3nm", "qcom,sm8750-dsi-phy-3nm";

This doesn't match what you've written above. Was it validated?

> +                reg = <0x09ac1000 0x200>,
> +                      <0x09ac1200 0x280>,
> +                      <0x09ac1500 0x400>;
> +                reg-names = "dsi_phy",
> +                            "dsi_phy_lane",
> +                            "dsi_pll";
> +
> +                clocks = <&disp_cc_mdss_ahb_clk>,
> +                         <&rpmhcc RPMH_CXO_CLK>;
> +                clock-names = "iface",
> +                              "ref";
> +
> +                vdds-supply = <&vreg_l3i_0p88>;
> +
> +                #clock-cells = <1>;
> +                #phy-cells = <0>;
> +            };
> +        };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

