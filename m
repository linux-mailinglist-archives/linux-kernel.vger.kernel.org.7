Return-Path: <linux-kernel+bounces-849203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63081BCF80B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 799A94E38CD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BCB2797BD;
	Sat, 11 Oct 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bX0M0XzY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC1277C9E
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198289; cv=none; b=mUEnxLBRsXkU4qykE0oH3eoCxxZ7hbNCWn9lGI+1//mppJwHsmNyha0aC9kcyUm5cUq835PcNp5zOmaTxGvCo1RGfz8pft32hD7uTXKqFLSR99OetEV5cOggtuu6IK4jKUkT25ib72AlfYGvyD76zZc4pR/s/ldb/CbTMJBg+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198289; c=relaxed/simple;
	bh=QrFNimHkmBUitC0NhobSk0gO8m8J2JE3xLAa/9ZchMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZxCrjbwVJdVsN1t4PHBQfgesy7GgP6BU7So+7jA4nJHlqT35woyLRIFAvd6JLPgOcv5NRaDcIS1ISfi4reK/3H52xI+EtR+SWfthnL4Apxy/zzkGFWNb+xzzPYpSDL1vkJCyO+VPWm781YBeu92guXbxjuUoNgqSOXWaiMZ0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bX0M0XzY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BFj2nC030693
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cM/ZSWfIMQPPzbu9K7XPKBar
	oba+VrIv+X2/BKJAmw4=; b=bX0M0XzY2Z+sf3v64/PypxcJ6qR8iw+sIsProsBN
	6iTtfACpMfsALyEIAkiBBK2hPeDaFtCpGOreEkQgv9uJ856YE16+GxsUzVjMIDlL
	SwXRQH32NxfWbKZsA5kEqm8tyTQe+HcArfvVs3Q7SVG9+tJblFJ/0yqviw2VXO61
	i0oB+3VdZX4TAAr9F7IBa/Z01XWQa1z4okDqSuAN2n74FYShAjkho7m9M+9CRZVF
	rPBxd13j/G533vK4+W2FP4eguadai1WRCLGHXyDKAmroq0lDnEGc7ENsD/q0rTSh
	TIjCjpk69OOELXTL8trkrcZu4WCTNU8l4fE/nQHa0+Im3g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhrvdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:58:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-86b8db0e70dso209159606d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760198280; x=1760803080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cM/ZSWfIMQPPzbu9K7XPKBaroba+VrIv+X2/BKJAmw4=;
        b=RNyGRwhIw2mpunsfI9RSADkLNPiFv/73xAfUedU6X8kos7aEbV25fbbdMt4s9zyxzO
         L/SnEUcFT1NGTPi84nPkYcZDshs3B5ujHzswjzQsZq9/5nhrOwOCN2HM+XQfVFe9zOWD
         e+Kd5xYqAsta3a/vMK/mxSWw+Q79U15qXNue3FYxyE6uDJHLAVNdC0usJWdFfEyuA5JC
         T6ucz0pEMDJp/MN4lzFzxS8GphHu483uDxV+uuRJeZagxsxrFPcQTVSZqueTIRUNIgzI
         iJmHIVlj12jrLLm5Se1FIZ76V9zAbT/M2xP83SIbT6Mtl7W4/HaGcS9DejGkCsLqFez1
         FoYg==
X-Forwarded-Encrypted: i=1; AJvYcCUtSa+mEhVABDvb1dssgazbouwmdgvbJTTRZG/QvejBJpITUD2fE7VLkYrzjlciYLGaqTfZlxL+mC/D3iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikanyG8+I2bI1nO68wnaS2zAzzdgIxYHZPl+bzvpwhV+HNyz8
	hfCX5iWp2m5vqTjTjRZCZMLG2Bg7jhz6MwOaKYIwNC5FyvexX05cJvPx9wONGGz6XceUGOPudBe
	SK9dezpCE9FYp/j4p2YxceJMceu3+LhSu/eBB09APkFGqzQ9fPneOTZN6j6ivtimx8VSrU41Rzy
	M=
X-Gm-Gg: ASbGncs2zciGjJ2EfKkwsHzhPl4vGEoKqvT1mRmOamEZCb4gtN15u47jGuCBekuF/Yv
	rt0WnuI0L5vYIKQn5isvonO+V7bYKCalhxpj9Z8PaYBQYYzTj5QwarCCfAhyc1A1kf/mh+xl9x7
	T18bUswTeeliD/xok6CNrKYO6bUtK/WLjoZHxFoq4AfBr5DzvOAljJ5o0zD7Dp0KeCRpUaMfZI4
	7IHwpBk7R7vUXtkLu5XqPnN59S7YhCJRuI3TQPLS4wGOqdoVlFa7qW/FBqF9VTIujKH55tyQgMS
	czTPKVxYyTGCo1O5dajhZGj5//DvHy8iI0nPw6WIZjb+fKK2fFxyM4IovEirjJ4OvY4vwCX/393
	57SYUwrcF/Te+bZKP6cjkugXNyVqhHvr2ZlFKMWt63aXFBRwFnru6
X-Received: by 2002:ac8:758e:0:b0:4d6:c73f:de88 with SMTP id d75a77b69052e-4e6f396e281mr159605281cf.3.1760198279623;
        Sat, 11 Oct 2025 08:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKBCQ8VLuqm+YCoAg6hZ6hNnnm6OhLtm7zHiupmtWpKVZOf1M08JlLk7WABuseyTLvzmjuiA==
X-Received: by 2002:ac8:758e:0:b0:4d6:c73f:de88 with SMTP id d75a77b69052e-4e6f396e281mr159605001cf.3.1760198279171;
        Sat, 11 Oct 2025 08:57:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563bf6sm2022640e87.71.2025.10.11.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 08:57:58 -0700 (PDT)
Date: Sat, 11 Oct 2025 18:57:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH 19/24] arm64: dts: qcom: glymur: Add support for PCIe5
Message-ID: <a75ndv2mzwy3niihi3o2ux7lrkue7h5avj2vcxgqhs3hasunfg@cosy2knsveey>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com>
 <da2vvejbqdteaszzwyktczqivjblyawzh2k2giyoxdxlxcdrcb@fkuqivjmaggf>
 <aOiw75D0RhDNLZLQ@hu-qianyu-lv.qualcomm.com>
 <ilr7iaasabiwynzdu4ca6bhcyu5ubznc4yw4chfa3hkqsxjauw@2y6smgstv624>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ilr7iaasabiwynzdu4ca6bhcyu5ubznc4yw4chfa3hkqsxjauw@2y6smgstv624>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwC69pNNO2c6/
 ukB7N2U9jJu9rYpHbLvQwinfJDwsScE/4LfJaXXLE4TNu8lT2b9p8FijoqQGIRXDDpePKzmRPjM
 KYgSg7QdwJ3MM8o2zLp+C3vU3E2Xt5BOZi7h8WWE/+8SnA+f/PlWdh/+UT4cURtk2AWp2Hy8sUB
 sjCdvu2EtMI0NBTYU16OCzJdm7xhf+SgIirEahAz+3oNmNwEoWuqF4wxAJay+k9H27xsQfF6nY1
 IcrQgMN4m2Aj3ZFZWuuAKjKoPOavsweCa/rASOasIhDQ/vt3+pKre5qIvnqNHYN4VZzTG/dMJk8
 cW1ElTcL0jU51V8CVZ872xVGr1ilmiCKXH+NBfTbqtBBxrZmFBSuSNSMsYZGGvJWuMNc5Jfd24E
 /xdOcn9qhi1XR3gK8YkT1RzkcEHnaw==
X-Proofpoint-ORIG-GUID: 2h8wAsSqXWbsTooPOTKnGuu_Ntndejng
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ea7e88 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=gVcGzzVyn95359E6DnkA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 2h8wAsSqXWbsTooPOTKnGuu_Ntndejng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

On Sat, Oct 11, 2025 at 02:43:14PM +0300, Abel Vesa wrote:
> On 25-10-10 00:08:31, Qiang Yu wrote:
> > On Wed, Oct 08, 2025 at 04:36:59PM +0300, Abel Vesa wrote:
> > > On 25-09-25 12:02:27, Pankaj Patil wrote:
> > > > From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > > 
> > > > Describe PCIe5 controller and PHY. Also add required system resources like
> > > > regulators, clocks, interrupts and registers configuration for PCIe5.
> > > > 
> > > > Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/glymur.dtsi | 208 ++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 207 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > index e6e001485747785fd29c606773cba7793bbd2a5c..17a07d33b9396dba00e61a3b4260fa1a535600f2 100644
> > > > --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> > > > @@ -951,7 +951,7 @@ gcc: clock-controller@100000 {
> > > >  				 <0>,
> > > >  				 <0>,
> > > >  				 <0>,
> > > > -				 <0>;
> > > > +				 <&pcie5_phy>;
> > > >  			#clock-cells = <1>;
> > > >  			#reset-cells = <1>;
> > > >  			#power-domain-cells = <1>;
> > > > @@ -2511,6 +2511,212 @@ pcie_west_slv_noc: interconnect@1920000 {
> > > >  			#interconnect-cells = <2>;
> > > >  		};
> > > >  
> > > > +		pcie5: pci@1b40000 {
> > > > +			device_type = "pci";
> > > > +			compatible = "qcom,glymur-pcie", "qcom,pcie-x1e80100";
> > > 
> > > The first compatible is definitely "qcom,pcie-glymur".
> > 
> > According to Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > the preferred order is qcom,socname-ipblock.
> 
> Fair enough.
> 
> Now I wonder what happened when we added the one for x1e80100.

Our PCIe hosts mostly follow the legacy approach and nobody wanted to
change it up to now.

-- 
With best wishes
Dmitry

