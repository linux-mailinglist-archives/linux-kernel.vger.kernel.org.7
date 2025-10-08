Return-Path: <linux-kernel+bounces-845385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B7BC4A87
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46BC3AAD57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52982F7AA6;
	Wed,  8 Oct 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7dl0iAC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DFD2F616F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924647; cv=none; b=rIKPwXDidNddv8sI6Pr4+FA+Pseq/F5ZX/83L/Emqh03beldDB3jtQTYIkhcJaEjGwmGqL1xGqayv6Zdk4TQc+dPQyb2iFiex061xiP+/6thUKc+2xaujol+NRqgq0JaNgdc5cMehr9Jbhpw8yLLafe7Qf0Vqku3rpzsS0V9dGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924647; c=relaxed/simple;
	bh=+VNqlLUrL2S0F8q0NhWGsHgRy8Zk0dmY4dvSjl9E7xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWG9x5iPGDNpFgEmzDu8ioqLTtQ2XdyfWwFU04mkPdYLuKciRT/dxu9K+2w6C7GsBfDdistcRxOiRpNDGBNidqbyDQFzWewdV+pMMTlsfPkM+DLnh64DZ263p5UxtrBxZJ1tuu7vM5E9D+5XuWN1rW6yen1d1NQ5F8mR3LfRraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7dl0iAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890eu4002274
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IvIqdTOEMlOB1aUq+P90kmaq
	VRrdMXHPXR0BptFOObI=; b=B7dl0iAC0ebQmS4RvC+0fQwC+ny7v9BhIiF2VS6m
	dF4eGP/oq3zr1qFXymAVGczqv7LfBj737K2g1uEjHKYLasujp++gGomWTbuHbqvd
	/bFgUveBUOtPciAKPK0zkrsVzQUu0mulhBusrAIgy4rvbOlDvj5R/uUjaHXYZ/Jo
	KEtcMgFNSq9sV3U/iPsb0ntw7VV93DxkUGcRJFul7chATv/Rsn8pkfr8Oc5H3Gp4
	Gxq6trVLQ0g2H5Eu8k3CoL9bpqwc1VRSOyuayswpVnDe9lfXP93KaFVwYZijVekq
	E7D9/zbyoob+BHI6GLQ+OStxjdyqRkS1yVgAvv3sziF7og==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy729h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:57:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117b8e49fso12640375b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924643; x=1760529443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvIqdTOEMlOB1aUq+P90kmaqVRrdMXHPXR0BptFOObI=;
        b=P6aUUtI13jVMXyK7aLEAYClRHZaWPc9he0al87LZ5DH6fSRhFEZemXW3QZq77IwdyE
         sg7l+mzQtW5b5FAe/JxpTajC+y3dTH1b9tFgUL4Bn0xn4z6hr9q/3jEe7mVJEiI0heob
         2IyXSFb0sagx3yk5em41mLVxAabZhjvNiD2XAZpfYMg+5J342dMioptsAuT6BqGBD7Hm
         P6lrgV3B5DhYeOGiEkhl5U/Xug7ae2GNIv636YXvIJY/LJlhWmwv/0X/+njJYxna9WmM
         Cl5Hqi7Guih99KnDsr2tZdtEwZeuPw/xwVN0lItjHD2TdB8YKmFkx0f0jDIpwoqZmM67
         NSww==
X-Forwarded-Encrypted: i=1; AJvYcCXRbnt/i14ccIu3zC1v5sgJI0oBxv1KGm6fZpV3eJdEXhtQbySmxLyzHZv7lboodIvsZ8q2ZDWu0Re5Kww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkVBX2x8KnsU9KFLqxBmJ9BVej+ZugHZtPzOXMSXGxd3jmRF0
	u2C2uB4U4ayOeCD7YeuITC4qTEiLgOcJsZ3tV8Bem6Zm8JULG7HKVfosq3Og94aE5Cc/zC4sAcM
	tn5qRvXwH+FLMOZJ4c0bvfjWGkJvBsYZcM9Qy+9nmVyO/ZN50PUmt8lgiwk4m/XCqmoM=
X-Gm-Gg: ASbGncuM9ereMu/7iFJq3r+5URbFskisvUYaWJdxtLrG+RAuEYDnzqvJh6ezLCoL6by
	KwZe9Dy6Y5JbDT6QX4wm6SyJ02P/8PLrMSL075HA6ANYJuVG2A1HAi74U0zdPhCeNZHT69z1zDQ
	SP5CyR0cnq1qrB/TQ4GSW6dLiJexL2QtIMYuRQlsw0r01JWwxt/8GYy6UodyS7fe1kTQckrP8Od
	k8lH9SycxS+BajlOn/uTaw8F1vtn/A1jPXgOSkMTecvSoJYU5gEud6gttORqFjyBWPfvtyigkk1
	ccTQSg7TUyeP4rXLgyuyFf71EaJPX3OE8yl4bPHTwkaxvJe4U6NloXKz5rC39K0dorvMiYZo
X-Received: by 2002:a05:6a00:2384:b0:781:455:df62 with SMTP id d2e1a72fcca58-79384f488a2mr3750605b3a.5.1759924640902;
        Wed, 08 Oct 2025 04:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaaV0CNad2Np/BckgB4G9x2kyiSi6m3pXTtlqh/eBx1lGlL/DyqmRyKBbMygqe5tJdC1PP1Q==
X-Received: by 2002:a05:6a00:2384:b0:781:455:df62 with SMTP id d2e1a72fcca58-79384f488a2mr3750434b3a.5.1759924638126;
        Wed, 08 Oct 2025 04:57:18 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e809sm18617848b3a.71.2025.10.08.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 04:57:17 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:27:11 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 01/12] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Message-ID: <20251008115711.hi6uby5ivbxbsjgw@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-1-de841623af3c@oss.qualcomm.com>
 <ce03d7e7-9342-465b-881b-50aad29fd9d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce03d7e7-9342-465b-881b-50aad29fd9d1@kernel.org>
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e651a4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=Nb9z0baHQhIVdLoCI4sA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hX66I71dEvCEgXtiyIF2W4Cksqv63ICL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfXwzK7ISJIVO59
 NVtmobTIu2qmbOb4X0/Zi2mORRNqT9lVLWWzNYMpIOd5NzeAGPcmwHWNrHE0vzY3QRXC1aZKbWY
 IGzV+p5I8uzWrSCSvuoCAjEb1aMGFyj8y4X5s4oiyvLwHbAWX09rIlqSHAXoCfckWExuI1KcBSV
 r8Ww8Oc3l6nZJSINSJJXtZP+pcbfoNh15WvMMGzDDTIqUTOP0nJOUHLscBjDejiVs1e5bMgOQjL
 +39gt3gY1+ZaoiEPQRIQeBsUCDX5WPBVN/P1SfGEWL56RPT4aYmo6ULVEmw73xOrXWhNWhb5psw
 Vc2rTumhHVhhYWCfLtETN+vbyE7nZ/MN232vZ5mtYu7xVYlCw/nKKNkW9bIAc+8SA77hl9UrQda
 swsl+90eNehh+d3o0XBaTYw8xGdxkA==
X-Proofpoint-ORIG-GUID: hX66I71dEvCEgXtiyIF2W4Cksqv63ICL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

On Wed, Oct 08, 2025 at 05:09:32PM +0900, Krzysztof Kozlowski wrote:
> On 08/10/2025 01:48, Mukesh Ojha wrote:
> > Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
> > configuration for remote processor and when it is not present, the
> > operating system must perform these configurations instead and for that
> > firmware stream should be presented to the operating system. Hence, add
> > iommus property as optional property for PAS supported devices.
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > index 63a82e7a8bf8..8bd7d718be57 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> > @@ -44,6 +44,9 @@ properties:
> >        - const: stop-ack
> >        - const: shutdown-ack
> >  
> > +  iommus:
> > +    minItems: 1
> 
> 
> Incorrect constraints, this must be maxItems instead.

will fix it, thanks.

> 
> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha

