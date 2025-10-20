Return-Path: <linux-kernel+bounces-860705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E3BBF0BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB42E4EFD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF952F83C3;
	Mon, 20 Oct 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vupo0rDt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE22F8BD2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958463; cv=none; b=BWTz+ktSP3LCCD+VEdPEgOjjv4sx1oeiubZLnOAtRwfHgIr/PKh4vJnFaK8OgA476VgeNfo77tUuUldunzKpnpXCzZpF7Y2zSVYgndnYRmKjNhxbkrf4+TQ8YSw+Y8th/0RfRUlp/KLUDl/I69JCBW5KMX09WKoPOky6JxnP/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958463; c=relaxed/simple;
	bh=mlCsSNgILK5VjpE9TwK87gL9txtHrlmYePkScXEF5Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJlsPOrRO4zg0DWN6Ac/cchavP52ZSDxlKDZMAG0aaCczOM9VOONjv4g5/+Qg5VFwwIIGOiL7IcIFe8p1kWbPI6qRXCyNgOAAHSqLNQrnEW7EbrNtnQ+P3gF7Qd+HWdeEjpRvlaeY0DQsSfXFE4a5jYv4nLBaEwIqZosypzUXK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vupo0rDt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMlLbZ012696
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/3XkzzDE6pgtYDQvU/LrOrAk
	KN7CmI67gQk/krP8dF4=; b=Vupo0rDtbyDoiFdRGKzMaEGFKfc1VVYpV9RhBmPS
	Gfb7yYNwj4W5B3n1gmSPHGUvUiwwTKp6gyv6bspCvIOVp1v/4M2U2XLpLMw6kOyD
	bs4+qBuWetGShrObreU4js9zBzZQVBAK3pXnen0ixgasx1NcXn9GilhkGnXfInDO
	m3vhbsDtY4LiJvltorVDNJYBX+Uk08stgGohU474ZscwgOH49IW4vhcvBnwDlDFb
	YicVkdY7Y2rr4IbTx/FI5t2zlqTKTY7axzik95mhS3CaIp/cjxgxFyC6UErImv/f
	FIvjeZAqjXH1fykxj59SFrwGE3u4jTzSeYkbWQIIfr9vxw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k4e2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1cc5a75dso230638956d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958460; x=1761563260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3XkzzDE6pgtYDQvU/LrOrAkKN7CmI67gQk/krP8dF4=;
        b=b58IpCDSHlD3Ywln4lo1N6vYRPPgwUPGrcmAK3X//TLBZXmdIbEt50ObM4MEiJLCVF
         8k+O8dSodFj5Twp6yzbFCQOCObL1+W719yL5UM8RWWjt56ILThpy4nfqXoS7/fK5pUD2
         K1+gea9aKXrXGIfbKcCMS+lgOu8fQKAO2/OJGnezd9F+ut8ko9QiuXyMboLgcV3M5/9b
         hKbUKSlA5O4mI+GIIMSbGmKpgGd8+uZtsR3mmPw0GmhvXes+fvIaicIJxK/2y/yCJ+fs
         KSoHEfzBhpGdPPoH24r7yZmBBBHoqRmy00aHGNJ/SWJxQWtXLJsJmWJXbXDgr9ufh8Wo
         y0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVC0eRzCqKbhlW1AKLk3ShBcmw41Be+XPrK5gtlzFzVQWmoP8sLqTbOk2WeTPBloN6b9x8m4DCYWhpMIzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pDrfHZZld53RVds5xlmufDlqxJNB+CX9ai8kzcXW9QTnypAF
	FyvH/HnMwL7rpwpkQkO+Nn+eKZTenjpVzFtWZxqeCzLsSCccOofejXBtpFjyZEwJXbL1/G2S20d
	wi/5fIEpFYjg6CpUz5qW8YkM3WqvzrdAvcyLRfxpmNO53EK0w7oW95ZjgHcbdLdQMVbo=
X-Gm-Gg: ASbGncvhlHLg6Pjaai35/aL7E3/Bu/2CX90KFG96phpYCdNPDnsrjoCHYOeIs3P647P
	LTbSMkimANv7KtFu+HIRvaxX72tvAvrA5ssYAep7n2F2TcSmSC4Nc1ouf7XZ5PWG9zl56uIumXJ
	0ES1n0MD/gsV3zHKj9r+DmeAYznsFonPyN3UP6WytBM029ZaClsUftmAOlVPTqltCPPGhlBQIoi
	ypYMhZQC1VoGaSMSgNI9p1VqWTTOthDUYJWrK0r7PWSjfZ4CTcrGmKP/7GJcVfHrTE0vjqwNcD4
	Vsda5+aZPqCRO6nawoAFUuVxRjpN3WOrLErQ/FjcG38DTnXlSzmCX0+w75VAax36f6+B2rkPMIF
	gDq21IbLQbt6qI1LXGZ12o9lhCNotQApJgDu3YJ/X8s/fOdvaeiPL8/T1TK+bP9f6HucYdir4YW
	8enZyBqy1vu/g=
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id d75a77b69052e-4e89d263d69mr149386641cf.31.1760958459646;
        Mon, 20 Oct 2025 04:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEukabNO0W4DISkBvNcRhiWR3IUYfG3P7NB/i98qxN5u2LvB8QcV9XfUoEO0smvsXnJpaPJ+g==
X-Received: by 2002:a05:622a:1812:b0:4e8:9402:a809 with SMTP id d75a77b69052e-4e89d263d69mr149386231cf.31.1760958459184;
        Mon, 20 Oct 2025 04:07:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deec3856sm2410747e87.50.2025.10.20.04.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:07:38 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:07:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: xiangxu.yin@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH v4 1/3] dt-bindings: display/msm: Add SM6150 DisplayPort
 controller
Message-ID: <f4dihh4z2nnkjcpsrmopycm6opellvv4mkpee72xjbn26nw544@sfc4oy6c2xci>
References: <20251015-add-displayport-support-to-qcs615-devicetree-v4-0-aa2cb8470e9d@oss.qualcomm.com>
 <20251015-add-displayport-support-to-qcs615-devicetree-v4-1-aa2cb8470e9d@oss.qualcomm.com>
 <58446b2d-560f-4a7e-890a-78ae0bb92908@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58446b2d-560f-4a7e-890a-78ae0bb92908@kernel.org>
X-Proofpoint-GUID: WDDykom2RyVhFIJfj9qLSn4W32xwnRQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX57Zigp4iK3K4
 I6CxCuANGv0XSKmUmCFC2XzjaWYXs07aB9ksCjiC2XpWOatSHwxgAsAEneh3L0yf7EHnjjTd6G6
 X+B5Zm8NabDgIWyAwyHobfDzv/Abs29JuWGj3aluqygMqTK2al4mzgyqRRtk9v0/6B4P/Ys5/9U
 FIrTMGlib2bSCfX4PzM11uebgu23G3aJ0TQzTyGMTAXiV/6D3aabL40rLOLE5QlI2Dt30llPq06
 LBJjd6Z0ufyedy2sMjUO8M0X/4yRqvQp9AEhF82VOPHyPulAdP5yBj1tVhOvUwTEvUq12iL1J9I
 rfRhUs6m0CzyciVAyse3Z5+as+zV/t4QQ0ROcO9iljG7rm9Sx2dIUETKI4f9ylIN9rDzeNXqa/N
 LgHTxUo3u9KI0Xoe7pJtqRp4yh0m6A==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f617fd cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=3eJD8ZQ_GueHMKJvpIsA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: WDDykom2RyVhFIJfj9qLSn4W32xwnRQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Sun, Oct 19, 2025 at 07:13:32PM +0200, Krzysztof Kozlowski wrote:
> On 15/10/2025 03:53, Xiangxu Yin via B4 Relay wrote:
> > From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > 
> > Describe the DisplayPort controller for Qualcomm SM6150 SoC.
> > 
> > Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml     | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > index 9ac24f99d3ada1c197c9654dc9babebccae972ed..935eca23ce6b30b81b3ad778e5fcacc817a230c3 100644
> > --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml
> > @@ -51,6 +51,16 @@ patternProperties:
> >        compatible:
> >          const: qcom,sm6150-dpu
> >  
> > +  "^displayport-controller@[0-9a-f]+$":
> > +    type: object
> > +    additionalProperties: true
> > +    properties:
> > +      compatible:
> > +        items:
> > +          - const: qcom,sm6150-dp
> > +          - const: qcom,sm8150-dp
> 
> 6150 is compatible with 8150 or 8350? I have doubts.

SM6150 has the same DP controller as SM8150. SM8150 is compatible with
SM8350.

> 
> > +          - const: qcom,sm8350-dp
> > +
> >    "^dsi@[0-9a-f]+$":
> >      type: object
> >      additionalProperties: true
> > @@ -132,6 +142,7 @@ examples:
> >                  port@0 {
> >                    reg = <0>;
> >                    dpu_intf0_out: endpoint {
> > +                      remote-endpoint = <&mdss_dp0_in>;
> 
> Mention reason for doing this in the commit msg.
> 
> Also, messed up indentation.
> 
> >                    };
> >                  };
> >  
> > 
> 
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

