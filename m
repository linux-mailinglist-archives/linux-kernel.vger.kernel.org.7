Return-Path: <linux-kernel+bounces-825744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BCFB8CB61
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC607B5449
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E82F9DAB;
	Sat, 20 Sep 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHdi39/s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A712F7AC7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381764; cv=none; b=bvMVwE53aLGT1ad1i2ch68ScV4jrxvL1NKFT4fpoZQ5YCYjsU+AtqmHHBsHqr5oDK+dLUedK2Iiszl/Zjea0EgqMdIh3qHQ5ngW7Bb14f6Qht5jmxSuRcEmf04wqHeU6k53j2GcTtcz3EkPznkC8lInyoTX3KqIf6CuEGS46D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381764; c=relaxed/simple;
	bh=ADtsq7AKzm5Iw0ISFNLkeS8bqwkOPzAKJJ4xuvJ/GhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URIFDKh+2F6pZM0ru9BIGocJ6VdMRWtcDJThQiS0JYDR06addgi+r/QUOitv96WCdkoVSerYIeMtaG5psruU4W0bh94vfvYkrlbBlu7sf8iomIUL5/d1lvSgUQRqwr0xq0gqsWlgsJMYFo5lPrwnk3F9FoRIBiJU6YEcfAESYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EHdi39/s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FW2M019280
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qMvP8F7p/iDOTofUgdqZ4hYV
	jRyQ8rzwo1S3mGKqewI=; b=EHdi39/sRKMF5YFMprLKbxk2PLKoxfCXgK62NOBa
	lh3Dsw0MKcrUKng/QZ5fVT7lNhoFNhMC0mQUN5TSCmf3VM8+MfO3aAUVR6dGDJAp
	+jnND8JM0Yru8ZOCmeI8PyeXU2t8tdjskYPeQUWDsigwwIEVqvml1xzaRZX2RcTB
	oK9WskshuZpjyOQoD1FZUO9H9T6u5Bmd3W149CO7J99/IJyoQYhg9VBk+OHhIRKz
	EdF0r6z3DHdnfQ9pIMPiMyGENsHIb2Gu0mxABEEi88zkOkrgJcpbuHSBipC+C0qp
	qXJbcpCYR4CCG0V/a1bYECWjegISWElZUf6V6tev6zKuMg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeh4pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:22:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79a3c16b276so36654506d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381761; x=1758986561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMvP8F7p/iDOTofUgdqZ4hYVjRyQ8rzwo1S3mGKqewI=;
        b=ef4OyCqyngE2dw+QVvFX2UXIc+W5ivYNPcUDMtDCGZr5RhTD/IxNUNtEquChyPx9Wo
         48ftzG7IXDKiXpXXY8iuj1XPcKJNmGlTMb8yRE8ffS7WmbY+7xMqVO3M6pHTSVPJ8Yub
         rP6lJcw4GyjxuNspJqg3JFrcePGHKV2w/hgUzTr3iorf122GwX8pyxhfrJVnVZoR7nDR
         cwkBBCRw56KqTORD9bH+VaZKW2UK6mC5rbr2kbLDhxcxySStM58B7Rf7JPCv7pOax5X3
         1ykMrYMsVPdRG6akjiWf1wZLLdPGLu8vWV69fQ6S4jTjYMsDfPnXuOoCsh8D9TTpnpVI
         aqhg==
X-Forwarded-Encrypted: i=1; AJvYcCXJTFzOgAmpzB5j7NlfUcAoSGPEuiithIGqypD4WSV4jMUELrthcHSSLMZJjocCAOmuq3Qtibkwdf/yUxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+VNGLhRalA+fusXKy4Sl6n7TF8HEHrkg8kuOpmN7QVGzT7Xg
	JgSZIM6Tm/BV+FXrQh2fUl0vZrZT+OxHDQFtPogf9OfoiwU89q523WDMgscr8t38m5Nlmq7qd1B
	mjeFgi30B6vwDTce8E9fxDOXF9Rkv6RyKTsHbfB/MOnysd85+mKWftmgD2yBE1Zztr3g=
X-Gm-Gg: ASbGncvG1NJdgDxsy5jHVvE8zM5Wq4vK99UOdX4S2tB1JCATHuVz7/7qrPY3wDLfYni
	ls7aDRi0o9wW7i4PAIjph7NnFQVgcH7sp9FNuyGTSW2HKekAJW95TaaH6appwaDKUoXb63IvQ8G
	4Ht9I5HcOMVlQ9Ai6BDdQ9y27GGJziJPISxYuvUUCSr6gD/pPFZYXIwfoWn7rWI4ZDT+08DZwGR
	H9TnCi7b1Scs0jpoeJHqhI+kAFaMvkMqxYLzq/Fm2hCuCdgQMXO4J5z4mK0cdWqHwp7zqbkb/pU
	vfNpnrC4OTT+Tx8Iog5pnSuoDX3SU+9zVtIHb3pWgl0WZDXAmpu2reWrg08ma3zuK/4EibY5l4m
	lK7M0t5uKY1J5PNUC+U88sEguUMN4WDmNdrRCIaw0hCich9qJ4pqo
X-Received: by 2002:a05:6214:f01:b0:793:1b9b:4a9d with SMTP id 6a1803df08f44-7991c5f520fmr84609226d6.49.1758381760617;
        Sat, 20 Sep 2025 08:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWlAgM3pnMSdAw/Rq7z1YnN1kZKJ5qD9fwFMBKD5LFNPD+tDGwMgQD4d59xA4K90UQvVcnrQ==
X-Received: by 2002:a05:6214:f01:b0:793:1b9b:4a9d with SMTP id 6a1803df08f44-7991c5f520fmr84608976d6.49.1758381760044;
        Sat, 20 Sep 2025 08:22:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a27c0242sm18259521fa.21.2025.09.20.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:22:37 -0700 (PDT)
Date: Sat, 20 Sep 2025 18:22:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/9] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI
 PHY compatible
Message-ID: <7gvp6pshp4eiugk3qodg2ub3azu365loturidbkxqly6nhtgq7@bxnkxeqzarkv>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
 <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
X-Proofpoint-GUID: Kgbf1UIqhopq8NS9wR7DirAG8rfRM8Bi
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68cec6c2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=IEiawqspG9gC1EAg6qAA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX8biXx669KOiS
 lMTcu/eo9qOCmv64jPYGWCp8Y2Wu5ssOs6juQH820l7Y4dWDmMHezT1R3czdyvfIFwj1Dgifqjo
 HDmxNety0Buido9fIkaKTMOi9hhVpwj8JZS4DBRQawLGVTUv9HRn9c+kMJOaI2rjMTKAXwaWaDC
 haucIOO3BdR/NN/lbW1pOFV/rGnS/MrHsuHr4JYQ9p8Mas+tv8hOtY+T4GA5NbnEyCWGK15nzer
 TE4s8Q2IWez3zagfThqxpvl1s17LTqqCUL1vrzpw8YsuMFehZXYuhE8PluoDVbcU7kl4gZ+pY2G
 mgLTSxZhZtXt6lbPqwN52zo63T7bjbRcdEUmqmHNfZ+H6oBKZ7I3kPZO/DJuSFR6naQ00RVlId4
 gYLFJ5vH
X-Proofpoint-ORIG-GUID: Kgbf1UIqhopq8NS9wR7DirAG8rfRM8Bi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_06,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Fri, Sep 19, 2025 at 08:21:01PM -0700, Wesley Cheng wrote:
> The Glymur USB subsystem contains a multiport controller, which utilizes
> two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index a1b55168e050..772a727a5462 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -16,6 +16,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - qcom,glymur-qmp-usb3-uni-phy
>        - qcom,ipq5424-qmp-usb3-phy
>        - qcom,ipq6018-qmp-usb3-phy
>        - qcom,ipq8074-qmp-usb3-phy
> @@ -62,6 +63,8 @@ properties:
>  
>    vdda-pll-supply: true
>  
> +  refgen-supply: true

You've added it, but it's not referenced as required. Why is it so?

> +
>    "#clock-cells":
>      const: 0
>  
> @@ -139,6 +142,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,glymur-qmp-usb3-uni-phy
>                - qcom,sdm845-qmp-usb3-uni-phy
>      then:
>        properties:
> @@ -147,7 +151,7 @@ allOf:
>          clock-names:
>            items:
>              - const: aux
> -            - const: cfg_ahb
> +            - enum: [cfg_ahb, clkref]

Why is it being placed here? Please comment in the commit message.

>              - const: ref
>              - const: com_aux
>              - const: pipe
> @@ -157,6 +161,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,glymur-qmp-usb3-uni-phy
>                - qcom,sa8775p-qmp-usb3-uni-phy
>                - qcom,sc8180x-qmp-usb3-uni-phy
>                - qcom,sc8280xp-qmp-usb3-uni-phy
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

