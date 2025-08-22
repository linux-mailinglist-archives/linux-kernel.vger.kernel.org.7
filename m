Return-Path: <linux-kernel+bounces-781788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8117AB316C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CB1C85FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47C2F6575;
	Fri, 22 Aug 2025 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gn1DLx/g"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCE32E424F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863851; cv=none; b=uZ+2YnHkLrqO3CcfWJCzJPlmFJiqE8pfv3oqjyMsO9XHp0eV+ZIgoLsWgeg1MXwJA8q5zzus8sQ+s/fAX8q79lLpr1B/DJDKB5qJr2Y9CQeTsBHgoSuGxzJiKcCJ/fWGqShwYwBQcXDswKcqW8RcM8bSWqwmEwYBFUCV/krwQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863851; c=relaxed/simple;
	bh=nSefmbJNLEpNd+HiuHfMnSedjNJWSWzgoQMTsT+oEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd4n/ONgzLSzQTo6KS+tppbzfbDK1IIT+8081ZvCEJG/R/5qstIfqh8ELqTftZQZpMev//2DgRX7LtdsFBEltcYXEuBtcrndgCrwB7i3VWQE6OAaS5QuYH1V0xuUc6+v7+eB2fNUzmypiuHr1kTY90ZHDtAnuPfdkn/P82ntfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gn1DLx/g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UHB0005806
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IteKC1aYtouJKzTP53k7aPmd
	vVmyIyP/U396Y+IO0Mc=; b=Gn1DLx/gnD1F2d5PojLp0fimH7NVCdpKR4v7+ODa
	e/r30sdNxOJQwpJCxPkDh2IyQ6X9eL32z53S74zncE9skzscDQ5F+8FgeUc3e3tk
	m4OGIQLN9GalUPhFRWNBr1IloJiWy4V2qARkq/LVImFej1PK/rhgduge19TUaPeE
	wWLvhhnHLOp0nPZ6qbToctNqcK5t0yOe8WDRVKTzH1RVNmvKDOpgT7va5rPY5pTu
	X3sl6TBV0+KoO5bmw+MRfUmY8yh5rOJLW5KGpO2gF1B4p2LaevwfiFOEv4KzRm4A
	r7hgoZNZcnRimtBIAPMd6DssapM6G24pLI9BspffA8ewPA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52912yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:57:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso6831906d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863848; x=1756468648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IteKC1aYtouJKzTP53k7aPmdvVmyIyP/U396Y+IO0Mc=;
        b=q3bbKah/nMUoLnsL+RXemgKW7prEJ1tzNaVndzNHYHGInWvQiYXtP1plrtmI1ViVD7
         9jK1Xq/Mko/EVlbx/bADxmaOflDJzXpsMvt0pG/DUi05Mbs81s0cjfrDTSykD5yrYvtV
         85p/Zv7qNmlYkLrpW9KHX2pDaUkjb6s461FDqW9VD9nynRf/o3fdYNBVFSElNmV9bX1w
         c8Qz/ae04U30iJd8PUbqJufd/N8uPqNHBiSEvARTI2UVYhKrQfrxukkTfsWevGDba+zr
         pcj9q0NzdwRsV3TFPiBz7IkN5DGzA2/JDFgIBUBeRAFEQvp4qT1oSIKqM7rk9fE5M/b7
         NaJA==
X-Forwarded-Encrypted: i=1; AJvYcCXoS9hIs9dUl58Y8zeZRbTcV/ezY+Sn1kMygOz593F1D5yexhhfg8uTsIXduyy/5TTL+RfJzPSQLVgZiQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hRxy25oN2HNA2Nfi81AZ3vv69Wp5UXZo2OzaT6VLTUFOgZDL
	UZxszZxHpsZHcIFb6EIvW6MoZpstjpuPwHGDWMs5eD2aJx39J4fXNk/ZnW1qDbk783LY7T0Q7Sk
	s80/L2X61ZpyhcgOPFlEHHr050nwEmaja3IJd/gMMte2ZWZ42vr9DeCymNyhgVLvUvrm/Jg6ALD
	k=
X-Gm-Gg: ASbGncsb/PucDQEqs3qOyTSuJ9PFBYynSi5a8IyLtb3ezv3E69RFlNV7MiBUbyKhFb6
	VD1gOuX4y5iJVnsgzQWLoBom4sK/m7uigwxJyESaT67dZnA2YU0MhcLXEuh4Q8fZWmhQ4wW4+qe
	8sOeflAFAd0cp2VfifmL9OIxSqTfwCeEX0gylmGMABcT465WawB/EoYEr5zspWjNI/aI2qFKIYj
	spRqkxBLQZYOVzk3GFTQJ3tEAXUi2F+ljw2W+czV3x80a+TBdSEPZr8AWcKMN0y3NEpjCUm9nq4
	erarvkqYARkO+xIW4EJ/BH9ool2dY36HIr9MPGW8TR4btRTaceDeqHuz5vkBgLdB0QIdZW7QCRz
	W13PRD2VoM4YBAoIlgasYyXkzFOHGH37eHP3FAALsDaDbAAKFkCm2
X-Received: by 2002:ad4:5aeb:0:b0:70b:43c2:3890 with SMTP id 6a1803df08f44-70d97208655mr31235716d6.49.1755863847781;
        Fri, 22 Aug 2025 04:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCkU8ELIIGHVUoLs0oCCVGOKRw2eAWAdvzOHisLhC+LnbkmMk8bUy9Y1FCe4SEL5Mw4GbMdA==
X-Received: by 2002:ad4:5aeb:0:b0:70b:43c2:3890 with SMTP id 6a1803df08f44-70d97208655mr31235366d6.49.1755863846801;
        Fri, 22 Aug 2025 04:57:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm3447261e87.13.2025.08.22.04.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:57:25 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:57:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Message-ID: <26j2trl7lypmqzjnw6kwgqz32eqcags34qpgaua7zbwxd4lbgx@n54gemj42xbd>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <as7pbmhfgsg3ht3s5lu25pfjjamaxyonuohkuohono3kr2mxii@posspuko4vwa>
 <aKhYYjUuOQ7H1aPm@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKhYYjUuOQ7H1aPm@linaro.org>
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a85b29 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=3azC0ehC7UzJKJg3NCUA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 13i471flueO-pOLTFh5FOWobsGCO7IOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5MBUmpagwX6E
 DT7zHZMtgksJGMAtl5MAmnDByUbFhTbDQqrVJGzjUGoFUG4mSnIN5ViZF8sW464odtPSBVqjjFc
 lqljBZn/IX9aU3IsFf6LRFvxjEeHTC695wTRa/LfL7lTWC+3zIxpSxKhs38KmQBnJYEkMbE73Q3
 BEATZlGt6dra6t1zs/01X8HVvSKSaCaziM/nIs1hQXZfM2xnhDwc65oNZ8GQRfA1AmsDDeftBQ1
 oGbU+Ex1eaKaZ7yg3Ullr44OhWHFX8ixT8L/BOgTIcV3oyhxkkN52ra35BIDer7SAlb9qBvTKN0
 M3GIubaHOJBAFoyKwZdTqWAZGcYN0I+Ej4+P45onpTn9SutOUQEEPUytdqizMmUBxhILzhSomc2
 WtBkFCBswx8eiFzsa6plBHOZ6N/xLQ==
X-Proofpoint-ORIG-GUID: 13i471flueO-pOLTFh5FOWobsGCO7IOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 01:45:38PM +0200, Stephan Gerhold wrote:
> On Fri, Aug 22, 2025 at 02:01:30PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Aug 21, 2025 at 03:53:28PM +0200, Neil Armstrong wrote:
> > > The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
> > > connected to the third QMP Combo PHY 4 lanes.
> > > 
> > > Add all the data routing, disable mode switching and specify the
> > > QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
> > > the underlying DP phy.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > @@ -62,6 +62,20 @@ switch-lid {
> > >  		};
> > >  	};
> > >  
> > > +
> > > +	hdmi-connector {
> > > +		compatible = "hdmi-connector";
> > > +		type = "a";
> > > +		pinctrl-0 = <&hdmi_hpd_default>;
> > > +		pinctrl-names = "default";
> > [...]
> > > +
> > > +		port {
> > > +			hdmi_con: endpoint {
> > > +				remote-endpoint = <&usb_1_ss2_qmpphy_out>;
> > 
> > Please describe the transparent bridge too. It can be covered by the
> > simple-bridge.yaml / simple-bridge.c
> > 
> 
> I think this isn't the case here(?), but how are we going to handle
> devices where we don't know which bridge chip is used? I've seen at
> least 3 or 4 different chips already across all X1E laptops and we don't
> have schematics for most of them.

Open the case, inspect the board, identify the chip. Everything is as
usual.

-- 
With best wishes
Dmitry

