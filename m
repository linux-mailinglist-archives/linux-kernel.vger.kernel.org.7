Return-Path: <linux-kernel+bounces-781728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C1B315F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552FF7254C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4F2F90C5;
	Fri, 22 Aug 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lAqfUhGa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A9B24CEE8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860233; cv=none; b=bRctUEeOAlw17Wh/CpUVNtfU/zPxRC9sDfFhqqikzFxrbjzgZcHGvMfEasvW1cbJzJ7Ed59oDlyXPGN2QZJD7pRXRcNAiFRk6KhpBHQFbTkMGSW8QaXWiuUix2dBP3l0k0mVwCFj6Q5r+5s2MznbumkAVZrehscJwgyiKHIbdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860233; c=relaxed/simple;
	bh=UfiA5LSSLvdOsSgP5c+PQ814BcBr0jYp6fSxRFsuPUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usJS4set4PdV0JVeRHa4IhdigNwB9pSE3oouP6c53VwG+kcJpWBDbisxUs4clneUvq/mL1zTG9SBjMLle9BwrY2qgI6hb9werXLtA5EYZRM1g9HZ9Vy/uC5+fUN7glt7/X7/AgN5RsHmRNY1wmjyqs/m9welIe4a8XwgNmyij44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lAqfUhGa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8ULvC003591
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3UQrGVqjSSQmpliOJA4Xb1OO
	EwV8MQbwtqNERrXa4jA=; b=lAqfUhGaCj3cvEsrQ1qieqfNR4feDyAk0ZYKpHej
	n0rgynhAy/xBSToDOgjPUK+nIUF8LYGr9r9M34aInEyIiALxi8D6LRd+m5xXFWOw
	zEDsnwr8x7rUBH92hfCISqdP7wg4kqyUvt5t1hKP+LK2UjYuO3bGeRqoWCbyoN+i
	jWHpWhiNqTU38wZvKk+SJDH1eR6LIs6bid+jA2axGlLJ3hQ/zh3PV2sz9ciSwHXq
	4Pgnsf77VBlx1pHHHDMz6GE9EGzp+ER4w+0b7bzfdDLDq4i2wCtlzOYW3hlli3za
	ejQTZRl/kpDfzPSMKqUMef6ahfcqwboRFG8JKkKFXvbkqg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5298w5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:57:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109bc103bso46983931cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755860230; x=1756465030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UQrGVqjSSQmpliOJA4Xb1OOEwV8MQbwtqNERrXa4jA=;
        b=U+dRlPqpC0yEEYnHMwuHf156RtRSpK5T+9JS48lYcRr8w9sNwwtCo8dQmwlKlh3A4O
         YCqttyG4yF6ep6BKiplWUVDRwIw/9qT5EzpfWAZMhqpTCTRojd43Hq46MV9MrIq2Ubvk
         gmwTI2cNZnGUBdRYiPVIWNzI+saXjZt3wKMj2otRfuxkpb5AvDm99QZ9CfmBCAQvDCg8
         Gv8Ei7Y+olgzXxW10ueE6jX9UeHDmbnkQrr/MKDR7AKrHUotxcsfRfdRwbOsj83/NzDX
         X9uZilLZFKJ4A/rMReQ+Kxe9HJsckrYby8VUPwFtzKyozgO2PzGL9m/ChYtpVxK0C89M
         llWA==
X-Forwarded-Encrypted: i=1; AJvYcCXaW7uOh8mLyYe+sjwULCaDJ3zIzS0M5imrbLZ8NPb1+c9IVB4fVZhRvh+BOGL44zLIY92kPPmDjtFYq0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jpZjaZkI167K8I+n34Zx0Y/1KGvdh8aaNcoUMDd5HBp5cpSb
	snRXVEDfD5RR4nb15ikp64F+khM6KydiOCr7M6e3hgc9h0ZZ8S7Rm4n2T3EixS/QypzgalAE3Ie
	q4qF306XnLmxu98Uqly9JI+7vMvn5udNf2c/AYTHAm5E4j2plhw+6Y3mSrYvKCryZjvI=
X-Gm-Gg: ASbGncsnBtTyS3fNhjiuHVUM3zwOx4PJorhkdxt1BzdBpUT1SPTNfqAZXCbSarSoLl6
	EgxkHWr5SsFK37pFW3md82TeUyYR2KgxFIC8YiIeO6dFc+DYmDlLRxGTSc0hRUIV61SnH0WcXQF
	JrVMmK7B3wPoa2ri5RbPIKF2elOOYCA2FIkzdnnQRtMbXg3mFwPJEO5GaOj3FwGhorz+0Q5alr9
	c8oU5NF13SnFu00bBCccN6lN/fYiNPyHLBD6T/v/tc4qBioIdu9LYZHy8kdqN97YF1x8llLKwjy
	P6rY2W+UA67IetDeVwBfhgfWjSIjXUc1pOLSWiZxXHZ6Jk+DkxknrAxdat+gec9tOM9Xrs9ivYh
	EsRqNiHhptA3W8psJQ2ZFvA7pwl47nUdleaaElZy5QX/afkzdM2kW
X-Received: by 2002:a05:622a:ca:b0:4b2:8ac4:ef70 with SMTP id d75a77b69052e-4b2aab40c3amr29596621cf.83.1755860230196;
        Fri, 22 Aug 2025 03:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuLWCCZnI5In7y4ErM2MToO2IgEg0s/ty1U+t0OKmjsrE3j0h7gWXUiKhn+W/Ngv68PUajSQ==
X-Received: by 2002:a05:622a:ca:b0:4b2:8ac4:ef70 with SMTP id d75a77b69052e-4b2aab40c3amr29596431cf.83.1755860229666;
        Fri, 22 Aug 2025 03:57:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a481a13sm35509521fa.34.2025.08.22.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:57:08 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:57:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Document default phy mode
Message-ID: <yc7ceoq3bn3lkxdwkrk64ecubej64vblpwlwzyj5cuep2wmjui@nln2t2yicu7o>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-1-f14ad9430e88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-topic-x1e80100-hdmi-v1-1-f14ad9430e88@linaro.org>
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a84d07 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=QmbdcxT1eW_NYhLIMYYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PydVqQL0wmcLX_SFUX3tWhmZiNjQ1VNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0rKnAv/uTbaP
 o9HELEZBaUukNY+0dJhlElbYgMFmZUBNCmPEdZ2JWqZFDrv+XuZQw6i22sMe/TsgYS8qaw352H3
 l5GBtZ+8zymZBjQWnkxKyQ7JCUltGt1TXlnoPenJoADvI7Yx/LCj76u8mYgYmeqpmJI2oqLF7M0
 vnqb59x7+YvBgRb4qWCHb39cVO91kNjgjQpo9K6qkTa1APppHYy5bmhZrHuyQvyBOct4Rxf2NEq
 I9bH9SXr/rzdLgp/KxDQ7fxBk0cjQLympSqs6Y1ddjFffn9XuqEuf8eFrtHXbiCpLiVs4tam50A
 SLh5mYdJKt1VHJLHrSvxpBk4hOTAZup6t2j0VCWViFUnuCZvBoL1TOtwOFWluthsLhF1Zhvjn9y
 EKCZFzUsLmIZr3S1zsxr+gFD5wrFpw==
X-Proofpoint-GUID: PydVqQL0wmcLX_SFUX3tWhmZiNjQ1VNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013

On Thu, Aug 21, 2025 at 03:53:26PM +0200, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> And the layout of the lanes can be swpped depending of an
> eventual USB-C connector orientation.
> 
> Nevertheless those QMP Comby PHY can be statically used to
> drive a DisplayPort connector, DP->HDMI bridge, USB3 A Connector...
> 
> But if a 4lanes DP->HDMI bridge is directly connected to the
> QMP Comby PHY lanes, in the default routing 2 or the 4 lanes would
> probbaly be USB3, making the DP->HDMI bridge non functional.
> 
> Add a property to hint in which layout mode the QMP Comby PHY
> should be as startup.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> index c8bc512df08b5694c8599f475de78679a4438449..129475a1d9527733e43ded5a38aad766f9810fe7 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
> @@ -76,6 +76,19 @@ properties:
>    mode-switch: true
>    orientation-switch: true
>  
> +  qcom,combo-initial-mode:
> +    description:
> +      Describe the initial mode of the Combo PHY configuration.
> +      The Combo PHY is a wrapper on top of a DP PHY and an USB3 PHY,
> +      sharing the same SuperSpeed lanes with either DisplayPort over
> +      the 4 lanes (dp), USB3 on a pair of lanes (usb3) or both
> +      technologies in a 2+2 configuration (usb3+dp) as default.

SPecifying this as an initial mode means that it can be switched later.
Should we generalize this and desribe it as bus-type (from
video-interfaces.yaml) and allow it to be present only if there is no
mode-switch property?


> +    default: usb3+dp
> +    enum:
> +      - usb3+dp
> +      - usb3
> +      - dp
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      properties:
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

