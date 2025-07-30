Return-Path: <linux-kernel+bounces-751211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CFB16678
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF981AA81E9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B12E2647;
	Wed, 30 Jul 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZVvlXiTb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942942DFF19
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900985; cv=none; b=kOwjZLjWOjQfjpSrSy8gxaPyvSecJOLAWLmU3liAGGQMMJhGOjqt+NVR+9jo0npnLV1xILrvU1M/ltP/GhwVtE7zTvBQLy4/cPY+cPCiApJCP2JCUvQ6OVO64vBh6w9aq/bSc4W1FMmdaYEamkIEX1pO/6duOcyh9MqBkdIBohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900985; c=relaxed/simple;
	bh=qdx7NrEpIGy1d3PcvacW0jr7ju/GBkM8nCqLuJ9W42U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMQR0YUApWMd0AVIyqSAqL0s3nE3ro5i+/vMjERCMh/xJZiQZN/IT2EzoCG1tzlBSolb8XnCufe+wHhk4+cvdJ+aZquFTdd6WRCERiIiKu3/Gfeiq5v8yyfg3OQnhL8XIqsetvMPAagOWXpDREoGL9/wafPFoEKvliW7WSocq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZVvlXiTb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbAih012942
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9c5QkbApR+lGMSGubJQFWOy4
	IDJeWT64QPQIBtzV7MQ=; b=ZVvlXiTbBgZH4SufusLeROYgc5lISyDizfxjI5Fv
	0/b1InLOpu3+tBuU/qkQFx4j5b4Hxspy/K6QWZ0PkkrYpy1rHKcAIJxrgPB5HWwW
	PwBGuqKqeHiAD1r0n9mkr6yWrxCYkWquygFOwAL2rqCCB5Xcg80RBkxAzrsLtcY3
	wa7Ymz6QeLG2mbriQsusvjYw47bx5BUj10EPJVUb5VdVMbvygw6SyndOgsTO7V4E
	qrRRkeIb97JscOxtBtqcANua8UnzRoelY4YJc/z0J5364wIGNXfJHKz+t9oGVvbC
	VQBhxU5Dpcf+KyqQX9X63N4kUI2vOzO2zMKN+Img0T0wNQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2mv60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:43:02 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7073f12d826so2344376d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900981; x=1754505781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c5QkbApR+lGMSGubJQFWOy4IDJeWT64QPQIBtzV7MQ=;
        b=o6CsPIN3s0eYF4UG7MRVRxTf089k1/wNzpaROJbmB9jQf42AJZt1kbJs1yJVxIlhbK
         mK0Q/us6SSKAocdBfn4ILjM30+vYJBFeiGNhaz46wkX0YI3o4ert3qv8k+A5I2sPBBK6
         fN7Ue88oR6atAsBmrTH9eVkApHDnLIcbKZPWrQOd/122K7F/TdHruQafgNIDHHia0UYR
         5EiwqQk4OAquR2yVyemJV3f5b4ynxbRyWKSK4Bl+JPp3EKQjAsM+EWyNaj+sTFtOloQO
         vRcX0UYw8AaJL5SfsgKtmqzU1yiqIEkTeDlcKmPF3P+KNLucjv6i8tU7E6jXhtcPKUZk
         CICQ==
X-Forwarded-Encrypted: i=1; AJvYcCVthbrnc7Lh2dPOuPxMbid795b3nvrFwIWIcaOHqBy30XxCDTwA78ma84PGrQQM4FukQJ82cRVRSEH3Ryg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0gwjl5Tla9FCAj7pbPraxNOydoQrBZLHRT++gSiLxCteYPAo
	/rIk0llxOgnmWM8BINMDN43w5Zem2Iv00Zf+mQrBwfz34Ph8jEEFSEJbnCipZj/gBhRz4JXtnFx
	0vtLZT0t2fNcWPmkTzEmG7X55LT86Kkr1COVRojf8rf6H+v+wE36UJOkbwSl4Z09KIYA=
X-Gm-Gg: ASbGnctlAjdyiMTLstvRSoW/VDnw0HqA0zUcKFM2wq2Xt/7xCILw/4DArukEZ1EhxXm
	gM+T46AUOCtKE+vVPFmDOjWf/G5fj3yhkEgV9iXjrGS6A4l+HNf+YYYVpDhr42iUsc1e95jXab4
	+JwNSjMVKlpjrX0OPjq8y1Ip0osY+NTvctBZkZJArLCukW6HGkvEyVfJvBoUvXgz2+N0tL0yG2p
	sFyY5TjAIzz0Ho6OBuXMN3dD3phVQvqEoQt2HMq5xPn5Qo5knu/XVLyp+0RWIyEJGwhZ1LaxN9t
	1BmxoNhJlQWw19nKL7DDQM3je+rpcnmolGfdFozbBcFlnNNv65gDvXM6zQwwLFAkKBBV++fgLAB
	Clq6uxtsDZ/g3YaC5Qbfn9kdhnBvTqDhbllNAN+w95ScalEcXFyfz
X-Received: by 2002:a05:6214:acf:b0:702:daca:9049 with SMTP id 6a1803df08f44-70766de22c1mr66949136d6.7.1753900981512;
        Wed, 30 Jul 2025 11:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh3yOcT3RsS6N0Cu2BRNc0Oq6rHJMiT0sj8uq9gs0lNela3LLwN0p2XCGTMiTfolk8knrVwg==
X-Received: by 2002:a05:6214:acf:b0:702:daca:9049 with SMTP id 6a1803df08f44-70766de22c1mr66948626d6.7.1753900980891;
        Wed, 30 Jul 2025 11:43:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4278c27sm19992301fa.76.2025.07.30.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 11:43:00 -0700 (PDT)
Date: Wed, 30 Jul 2025 21:42:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <pbvyog477v32s4lu72z52dhsond5yud5w3nxmcouvr6ljlndlh@ws46dncy35c6>
 <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
X-Proofpoint-GUID: mSk56pS-D6Hvggyjp3xItODYg4j6cRnv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzNyBTYWx0ZWRfXy83nNk4WcBed
 ZDukFTqhr08qaXeO/STZDBVbdTix7uEKhBFhxi1HI7xcjnJzYP+dEruo1Eph/JkLmLh/3Msn0hU
 NJm5eGWTxYqo7NNVWZuntnBsmMtpRx+bC3XskOTnLRhB2IPg4gSJmzwkaTqH/LqdIDpe0r9Cccs
 PLsv/ihnUxQZaEqb+/YdHttTYjmTYtigdVUeYEy+JwKm0VFX92wDD8yGAFHS+k2DvPV+RHT5X5i
 ne/ILWhqXUALLlfTEidLHD4BWfTvx4+/8sZCP+cRcSkGvJ5dh4qe8IHqw81LNu9y1IwYUDgG1w7
 ACnN/By8C/PMG2GvOoIC4c0JzYlkGmgOdFLL+YdoLsZ0fhkZ/HMpeLCcjjZrbGvbehUNgoIP/0C
 +yjZxOQBQ9HT9Om+/ybqqp4LY8bCcFWKqZWTB4IaYgK8d/d96mugW+YVDXBQdRaloopeKctn
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688a67b6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=MQaB2THTsXMMIvyQaIUA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: mSk56pS-D6Hvggyjp3xItODYg4j6cRnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300137

On Wed, Jul 30, 2025 at 02:28:25PM +0800, Yijie Yang wrote:
> 
> 
> On 2025-07-29 18:37, Dmitry Baryshkov wrote:
> > On Tue, Jul 29, 2025 at 09:32:00AM +0800, Yijie Yang wrote:
> > > The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> > > the Hamoa IoT SoM and a carrier board. Together, they form a complete
> > > embedded system capable of booting to UART.
> > > 
> > > This change enables and overlays the following peripherals on the carrier
> > > board:
> > > - UART
> > > - On-board regulators
> > > - USB Type-C mux
> > > - Pinctrl
> > > - Embedded USB (EUSB) repeaters
> > > - NVMe
> > > - pmic-glink
> > > - USB DisplayPorts
> > > 


> > > +	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
> > 
> > Hmm, so there are regulators for the retimer, but they are not used.
> > Could you please point out, why?
> 
> According to the schematic, there is a regulator and a retimer (PS8830).
> However, as mentioned above, the retimer is not connected to USB 0 and is
> therefore not used in the EVK. As a result, the regulator is left unused in
> this context.

What is connected to the retimer then?

> 
> > 
> > > +		compatible = "regulator-fixed";
> > > +

[...]

> > > +
> > > +	usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
> > > +		mode-pins {
> > > +			pins = "gpio166";
> > > +			function = "gpio";
> > > +			bias-disable;
> > > +			drive-strength = <2>;
> > > +			output-high;
> > 
> > What does this pin do? It's not recommended to set GPIO values through
> > pinctrl.
> 
> It is used to switch data lines between USB Type-C orientation detection and
> DisplayPort AUX channels.

I don't think I follow it here. Which data lines? Type-C orientation
detection uses CC1 / CC2, DP AUX use SBU lines.

> When this GPIO is high, USB0 operates in
> orientation detection mode.

What does this mean?

> 
> > 
> > > +		};
> > > +
> > > +		oe-n-pins {
> > > +			pins = "gpio168";
> > > +			function = "gpio";
> > > +			bias-disable;
> > > +			drive-strength = <2>;
> > > +		};
> > > +
> > > +		sel-pins {
> > > +			pins = "gpio167";
> > > +			function = "gpio";
> > > +			bias-disable;
> > > +			drive-strength = <2>;
> > > +		};
> > > +	};
> > > +
> > > +	wcn_bt_en: wcn-bt-en-state {
> > > +		pins = "gpio116";
> > > +		function = "gpio";
> > > +		drive-strength = <2>;
> > > +		bias-disable;
> > > +	};
> > > +
> > > +	wwan_sw_en: wwan-sw-en-state {
> > > +		pins = "gpio221";
> > > +		function = "gpio";
> > > +		drive-strength = <4>;
> > > +		bias-disable;
> > > +	};
> > > +
> > > +	wcn_sw_en: wcn-sw-en-state {
> > > +		pins = "gpio214";
> > > +		function = "gpio";
> > > +		drive-strength = <2>;
> > > +		bias-disable;
> > > +	};
> > > +
> > > +	wcn_usb_sw_n: wcn-usb-sw-n-state {
> > 
> > What does this pin do? Using pinctrl to set GPIO values is not
> > recommended AFAIR.
> 
> This pin functions similarly to usb-1-ss0-sbu-state; it controls the data
> switch between signals from the USB connector and WLAN data.

Could you please explain it? Does it toggle USB2 signals(you've added it
to the USB2 PHY) being routed either to the USB connector or to the WiFi
card? Or do you mean something else?

> > > +&usb_2_hsphy {
> > > +	phys = <&eusb5_repeater>;
> > > +
> > > +	pinctrl-0 = <&wcn_usb_sw_n>;
> > > +	pinctrl-names = "default";
> > > +};
> > > +
> > > +&usb_mp_hsphy0 {
> > > +	phys = <&eusb6_repeater>;
> > > +};
> > > +
> > > +&usb_mp_hsphy1 {
> > > +	phys = <&eusb3_repeater>;
> > > +};
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Best Regards,
> Yijie
> 

-- 
With best wishes
Dmitry

