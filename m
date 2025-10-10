Return-Path: <linux-kernel+bounces-847842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3100EBCBDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B738E3BF6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F5723E35B;
	Fri, 10 Oct 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePi0qupT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8023D7C2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080117; cv=none; b=pNc4UwDTbvR6/9a9y0a5Bodarb77hRcv8Zly4rT5Kj4cqH0sCgKDsinBOdducEIfEvbs+0hrIxdEBWexeI/8KzCmo/s0EmYj2IXmk73g97B6QpZy0w73CdioxAGWnhU4vheRAwLqyT3xm/hV6u/7CSz2fWLzlHHZdfaol6fHBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080117; c=relaxed/simple;
	bh=Qah6LtuAX2j9QhShtLOQTOP9p04jYYw3IQ7Ejye1OLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9CTYk6SMc6JKkxN7dWqGkL8EwwybpW4qHpJ6Id6/RahOL4Ar5EOkCr6VAJomjjNe/XqgysIfy5v0ozeCBxlo30K01N1u33NSGlpOEa96ZuQzM/sFQS+i/zL2VzhVxeJBCbF4mxhp/dfl8ya7ogZCq3w6W6npeM92r9fwucBQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePi0qupT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6Wm1Q005932
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Xw2joKvpmYxeQiWj5Qkkalzu
	uu9OHAViu8m2lKPfbr8=; b=ePi0qupTMVKure/+v15XU5VDZVhvBtlXo11+ouuo
	GB5tJp50JW0F3Eql1t6CTeToLy6fphhu1s9HPc+bP+J/xg3FtS50GNXU4IjMrofb
	9w1ayYENruIdPR5mdlkRBtd+Uh3LZSc4uk59IEVxWuVXKcr1RL5euH9AYNZ8ulS/
	6aE7j+gre3OV03/y5KkPRA0+f5wlfMIAtfqHgpH5yb32e7Wa9hz+kGqS/XWGZ+dw
	ocVjh7AHaXCiuP4ea6uXaWZDJO4exRsgC7k/9kHzjc+iHNrA/HkNvr81VGFrwKLX
	OvfsO/4GqkbQcMhHEjOQzbNJ+wJECXwOxTAayEb8Q7kv8Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j5fry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:08:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77b73bddbdcso2674861b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080114; x=1760684914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw2joKvpmYxeQiWj5Qkkalzuuu9OHAViu8m2lKPfbr8=;
        b=xT9yK4aLRjBT8cYt5ybKLAKzWh+UN7R119Cs1LNC+hU9f30WwmqUxk/TG/Axy/lM7f
         y0080oz0PWth4w8bQ1VWIVAQ2CzCrr95qAVaR+7zm6t2fx/khftigqhxYWrZPbXp8ynQ
         eIe3+1bYDMT5UVigSC1IJdozbHfv4qOeF9cVMXSZFxvxqO20OzNijwV9zKgP2s7zsWUF
         dDTr8B/Ik1q2lER/Se3MqW1nYNyJS0ApSZ1Tf58D6B5ZouuCRTVAWF3tKQ7X6pi3BGvb
         GmPU2Po8jT4kN4l/XBphg0M56LJkV9Kp8yrxuBZam3h7SU8CdzqjGF0oQkfEab2mU+oj
         rPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJcZrenkAtWe1+YyguOvxPhBMnLA3ARonhzLpnMFRLjk2gOSaCn7vacrq4D9BRFB2CRheIcC0C/j6TWBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9e65Bk772W3yBRQ5GS5gc9HLK0xHRUZLeuqE1wYf7uDVBGWC
	fP4PXLbOyLzqxatc9vUJlWuLJN3BNQy9ZbwztsdYbMgD71XzyokhRxzG4S4XL1Srdc83XjW/DoS
	Zpht/db1MflPsFyCHuzk1WHRenP4jZnRklB3q+tSdz+Dv/lep7O4gFtBMsaUH9inf/JI=
X-Gm-Gg: ASbGncvzzwD88WTd/pNkg08CVrCK0kHx/lweSOVq07Q4/wuhWPSd0OP0i7vrjWXo7E8
	X1Oo4vG0QcR2OtYKj8CH//NzUK3hskGK4xLaUClCsYZUfnfr3OuHZ7DZkD+4ECNlxaLzyuy65Cb
	dG/1MID2UapZi95dDEEVqARq4WQMoYg6V1kNY3aFkGbAbUCRqEMybJFRsasQser40Yu9WI6Fco9
	swbt8qMGMH6epfIbmXCkG2ttGCc4jvToERDYpHZxVIhzsX8vFDISIMzMhqY6TG6O2JN+2rz6b+z
	6nh10T+O/vGH4okX/IqX6h/u18OICSVQto8SQBHG4MAR5WzHEcPhItuLrLwblJBlF24FkMggvhs
	wL6vxriNvUvk=
X-Received: by 2002:a05:6a00:3b8a:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-79231afd0bamr12299740b3a.10.1760080113805;
        Fri, 10 Oct 2025 00:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmzhrFcPAMPGHBtZVt2ioi5eAMZgjgvwzYs//hswKwOgxEZGG1Cd23PphUugw3BHrPYFhivQ==
X-Received: by 2002:a05:6a00:3b8a:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-79231afd0bamr12299713b3a.10.1760080113312;
        Fri, 10 Oct 2025 00:08:33 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc13674sm1903782b3a.36.2025.10.10.00.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:08:32 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:08:31 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <aOiw75D0RhDNLZLQ@hu-qianyu-lv.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
 <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
X-Proofpoint-GUID: Dqh0FC4LpNodj-LTFRg3gx9964zoUU5u
X-Proofpoint-ORIG-GUID: Dqh0FC4LpNodj-LTFRg3gx9964zoUU5u
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e8b0f2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ylhLzIKeAnBU69OqGgMA:9 a=CjuIK1q_8ugA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXyYKlVq7qfoBx
 aYgbhqVFnJ28O73uYAYuH5Z4UvXIk2QnpmUd8oknP76oh6jd1DzyxiMFCn3Ts8f0S7S3EpE7GCx
 JQZLD41dD4xs1e04leZl/Gez4k/HYp1SLone1fSte8PVC0Z6CZ2euzI5gLCnOMg2vVx9RJLSoZ/
 f66uMosACaPzVdqNXJnvKByRXeH+8fV9VLs4xSPAj2b5oZh01drTRxaCZTEAIpTFYAzRpWdtarj
 5IP8Lj4Xq3mXZulAAYtRxaJnCBrSb21NXJ4Km3BRnbtG4OOcWdAS9tdFSfMuzQYLoFX6lKgTDwv
 LWSjA7Pwdzaq9GZgeNisa8H8henk1FJ+t6mOqL9cSGsi2ynEh5pvW5djunUR/UjhZ7LCFmvNbPE
 uO3Dcg3UNPoUUqdXtUIolfNqDXtH+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Wed, Oct 08, 2025 at 04:36:59PM +0300, Abel Vesa wrote:
> On 25-09-25 12:02:27, Pankaj Patil wrote:
> > From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > 
> > Describe PCIe5 controller and PHY. Also add required system resources like
> > regulators, clocks, interrupts and registers configuration for PCIe5.
> > 
> > Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 207 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
> > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > @@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
> >  				 <0>,
> >  				 <0>,
> >  				 <0>,
> > -				 <0>;
> > +				 <&pcie5_phy>;
> >  			#clock-cells = <1>;
> >  			#reset-cells = <1>;
> >  			#power-domain-cells = <1>;
> > @@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
> >  			#interconnect-cells = <2>;
> >  		};
> >  
> > +		pcie5: pci@1b40000 {
> > +			device_type = "pci";
> > +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> 
> The first compatible is definitely "qcom,pcie-glymur".

According to Documentation/devicetree/bindings/arm/qcom-soc.yaml
the preferred order is qcom,socname-ipblock.

- Qiang Yu

