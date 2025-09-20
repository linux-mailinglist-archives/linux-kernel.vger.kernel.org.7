Return-Path: <linux-kernel+bounces-825741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3040B8CB46
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F3B6254B5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E212F83A2;
	Sat, 20 Sep 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Oyd0/K44"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A971F3BAC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381496; cv=none; b=UetYV9JyY7VeC92dm2IqVPDOehQ4V5SFSo8Y9l8jS5XkHzOS9/9YM1iAFPjbrYHA0tvT5hiJicjqXbCdR4fnV35m77gjYk1YP4jHiQkZhkkkoJLPV9+PsFLG98K2jb4hIL8jimLhpjmvS1v6rqwkE4flviHNhWEarSkUFCsuoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381496; c=relaxed/simple;
	bh=GQBiatpicJdr5OPO0KSVbWpaq+NbFcO/xwFCjQmzDeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrngZKYxYldpbIWf/93Nubo7sz72R+pGa/5CkVTRvA5vN9IkPF2yo1I6CzBJgjkSYPF/VFwHF/igolRp/2xqbBIk9hYZW9nyMtZ0EUVCWUffXP8rKRaj210Qs2y0tdTyYLCGsuFfA7jTqNgmsdEyArhvaxfwWeKDxtr1YJoZT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Oyd0/K44; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3KNlR006621
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SE/TzCpNn1lm56lGm5GusKtj
	RWl26G4v81+gPtsUGow=; b=Oyd0/K44/kEUNLbydKKISKTQ26NcU2d3YKxy8W8d
	nd6HHacXfLWHjmE+B+jIoUemAdbfxCtzRjezksu011wbgAp7X4xjeuf9K17+Awmy
	yKVJ09uRmvbKb6BcDdIpFgLQN9Ect7je82uYepVLQeESc4a3eEZVUygoJIJul/BC
	H8uy/BEVqKEdE01URkdgQbFJUPIDmOzQ1khBNatovKHTcbcecgJogYdfNYFZLEGS
	01dCffNXwFPggV4PU9PMgemk/G7cqaN5cbIg6ESVQ5+qhf0wju2YoAeTKUaprbh5
	F31ruOdSpjkGYutisy3pmUAF2VdHD5f4Bg5nATyouwd7nQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k988yb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:18:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78eb8a9d229so47140516d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381492; x=1758986292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE/TzCpNn1lm56lGm5GusKtjRWl26G4v81+gPtsUGow=;
        b=twOYYMm0NMtiuUV5l/O3xpxQRoSRsFHXR6QDUN+iGIjMBpE+ZgvRJVYiOD/IThXHdb
         H18AsoWO7eOkzCuFIDb3mpOCNl+i/v2T62I/e1tuMUjLewQ7I6yYTObYMYrj8nLs+k9B
         evYI0R80mmZg/XcGY0PLJKoA6yufeDFZUQ8mG2L2FsAOyGXS17a9x+CZWD44Tn8o4QKD
         Ojq74XL/Vg/TO/A0EqXd2wj39q4IqS45P/g+qznaHrf7FRWm4eFGBM09Zcy2KOm+fgmO
         mtlJdruKcJLVYNstAx0tgou80cTriYE+A1fwGpkjVjgE9fP6DzyuIAk4AEbaIHkHqSHF
         Amiw==
X-Forwarded-Encrypted: i=1; AJvYcCXnNvPcBbn704SaEaWgXFazNGoJEDq2iSJsTZ2XuxkfHB7VFiiFUvEl1u5n5U2QudcZnfF+zUnotD1IUBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuro96nParZSuDKunXjVDTOkoVI5G4ar2anPGrJmz4bemFOl1
	OlYT+qcRGlxxqcveNHk7GRMHgzmHREGkIdpYu9MnWpPWtsnVlxl7kefT26GlRFK75nbzxmL2qyv
	Ynao96rDF1n/ImCPY7uAelPkFg2StOip4aecfmprxc4PH+yxeLjgldxgtcRP/gLU+dQQ=
X-Gm-Gg: ASbGncu2TKwZaOh0/ppAZ23pg5vz46GlfK7iDW2hfH6pAdsras0NNEWPngl8l/F/RE/
	Wbt2tnV7PZ+Zdfq8VQ6V0nspXkuyPXASF6I7MN8v8G+jt2qnt58XdQrYpc37FZckkhwR2eJBBYn
	MpV3qpFxm6wlX7mVUx2eh21RDq3XwT7o0jCmhSpxS8/D/PsDyUm981BXIyHpN2qheh2f0yxP7pE
	Q/5OHJnsw8CZyOe37nb7EhxXXEOYT9DtgCKNSpHBVIuaLTBekyAPXMRygwidRLVvcNatsgrjLjV
	kgFD8ZjYhrCZl8n0C4q8HZghh3VnK31T0AL6Q3zkUAcjL3Y4P+ybOeWjHZFOyJNKkEsvnwFdxyp
	tULp0Nv/iHmSn9dd7Bm8ELRWLDhezvrnAljY13QIbazDAGV+rSPmk
X-Received: by 2002:a05:6214:2628:b0:785:6e1b:f09c with SMTP id 6a1803df08f44-79914360a02mr61581246d6.20.1758381492249;
        Sat, 20 Sep 2025 08:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQmwINRFMEdLkNFG4kPMcSl8VW3EPEFYUe5j3w53Iw6eJvwSXX3a0dznM5FIuS3Bv41bI9dw==
X-Received: by 2002:a05:6214:2628:b0:785:6e1b:f09c with SMTP id 6a1803df08f44-79914360a02mr61581036d6.20.1758381491614;
        Sat, 20 Sep 2025 08:18:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9f1419csm1982523e87.148.2025.09.20.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:18:10 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:18:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/9] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add
 Glymur compatible
Message-ID: <nkkimxkdp3q3iiyv4ic6rxnwwedq5tnnn2zismqf4pdocvmono@xltxaqz6rb5q>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-2-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920032108.242643-2-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-GUID: zoXWc7y7TWZ0yv8z3931uYuxYxFIBkj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX9KwulkLTztoR
 qROuOtQ1WBzLA9wsTBuweLCeVRfraRS2ZFXehuTrFrphEDHOEQe0lAdthmWVqKQ0EyUeYQFTBjR
 0XYIZNOSI7LTR1wC7xnCYTJPQTr5Vfb++ipUdyHKLhRQpKinStj5DGbcC2CKjV+YBl7B48lydpO
 1I2TXWpLLFtJ60avnUABsI93I1bxJeSglrYER3u1j/zHCMiYIGxmDZzJ7AY/CQNEiAwNcjwC/Rj
 BgCODngz91Opj81eHdJj3Lj6u3ZplFbuTRPGnnRn+jZfwCL4oSZsw4sW9WwhDC+PcS7HpFIRVwi
 s3My4WSIRkJ7txbB+YSGAjAYuP1yKHo8d2bAc/3prJCuWfwh62PSWcazDB+B1m5HviTX4B3+DgU
 8U2iUfs/
X-Proofpoint-ORIG-GUID: zoXWc7y7TWZ0yv8z3931uYuxYxFIBkj5
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68cec5b5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=gizSWZE1I5L8aEIMteoA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Fri, Sep 19, 2025 at 08:21:00PM -0700, Wesley Cheng wrote:
> Define a Glymur compatible string for the QMP PHY combo driver, along with
> resource requirements.  Add a different identifier for the primary QMP PHY
> instance as it does not require a clkref entry.

Are register programming the same for both of them or not? If it's the
same, it might be not necessary to have different compatibles.

> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 45 ++++++++++++-------
>  1 file changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index 38ce04c35d94..e0b10725a1c5 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -15,22 +15,28 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,sar2130p-qmp-usb3-dp-phy
> -      - qcom,sc7180-qmp-usb3-dp-phy
> -      - qcom,sc7280-qmp-usb3-dp-phy
> -      - qcom,sc8180x-qmp-usb3-dp-phy
> -      - qcom,sc8280xp-qmp-usb43dp-phy
> -      - qcom,sdm845-qmp-usb3-dp-phy
> -      - qcom,sm6350-qmp-usb3-dp-phy
> -      - qcom,sm8150-qmp-usb3-dp-phy
> -      - qcom,sm8250-qmp-usb3-dp-phy
> -      - qcom,sm8350-qmp-usb3-dp-phy
> -      - qcom,sm8450-qmp-usb3-dp-phy
> -      - qcom,sm8550-qmp-usb3-dp-phy
> -      - qcom,sm8650-qmp-usb3-dp-phy
> -      - qcom,sm8750-qmp-usb3-dp-phy
> -      - qcom,x1e80100-qmp-usb3-dp-phy
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,glymur-qmp-usb3-prim-dp-phy
> +          - const: qcom,glymur-qmp-usb3-dp-phy
> +      - enum:
> +          - qcom,glymur-qmp-usb3-dp-phy
> +          - qcom,sar2130p-qmp-usb3-dp-phy
> +          - qcom,sc7180-qmp-usb3-dp-phy
> +          - qcom,sc7280-qmp-usb3-dp-phy
> +          - qcom,sc8180x-qmp-usb3-dp-phy
> +          - qcom,sc8280xp-qmp-usb43dp-phy
> +          - qcom,sdm845-qmp-usb3-dp-phy
> +          - qcom,sm6350-qmp-usb3-dp-phy
> +          - qcom,sm8150-qmp-usb3-dp-phy
> +          - qcom,sm8250-qmp-usb3-dp-phy
> +          - qcom,sm8350-qmp-usb3-dp-phy
> +          - qcom,sm8450-qmp-usb3-dp-phy
> +          - qcom,sm8550-qmp-usb3-dp-phy
> +          - qcom,sm8650-qmp-usb3-dp-phy
> +          - qcom,sm8750-qmp-usb3-dp-phy
> +          - qcom,x1e80100-qmp-usb3-dp-phy
>  
>    reg:
>      maxItems: 1
> @@ -46,7 +52,7 @@ properties:
>        - const: ref
>        - const: com_aux
>        - const: usb3_pipe
> -      - const: cfg_ahb
> +      - enum: [cfg_ahb, clkref]
>  
>    power-domains:
>      maxItems: 1
> @@ -63,6 +69,8 @@ properties:
>  
>    vdda-pll-supply: true
>  
> +  refgen-supply: true
> +
>    "#clock-cells":
>      const: 1
>      description:
> @@ -110,6 +118,7 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - qcom,glymur-qmp-usb3-dp-phy
>              - qcom,sc7180-qmp-usb3-dp-phy
>              - qcom,sdm845-qmp-usb3-dp-phy
>      then:
> @@ -129,6 +138,8 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - qcom,glymur-qmp-usb3-dp-phy
> +            - qcom,glymur-qmp-usb3-prim-dp-phy
>              - qcom,sar2130p-qmp-usb3-dp-phy
>              - qcom,sc8280xp-qmp-usb43dp-phy
>              - qcom,sm6350-qmp-usb3-dp-phy
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

