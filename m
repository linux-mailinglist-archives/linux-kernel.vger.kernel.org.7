Return-Path: <linux-kernel+bounces-752554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA9B17718
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC8F58202A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7B257426;
	Thu, 31 Jul 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTPLz/4b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393D1DFFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993337; cv=none; b=SmxL6dXMqflBXrnfGValkJGncWU1JO8rupLqUBiY+UOuF0eObRkiMrKo9thGSEZ8PrXqd/R9u11+erbdmBwFtQoNAKTqXWgTiqLM2940uLmXgXizcOxuenULQzx4huhS8Bce9OBUGls1mwokhWO0IdAUa0FK44TfJXJDYKTEKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993337; c=relaxed/simple;
	bh=Y17KSSbTlSWOCLc5FYHmOh6u85Qe/0aBKldqGXCvf4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHaCtnRrxAL3wgbUGJpdTAnoptMoJhrIWI891GPFH+CI1euNd1vWRdpAbYdVdDiESJpUNT+lCpzQxFV0mqcTc4iy8DjenaCX5EXsGIGr0+P9yrSsMcqLtWMIUeajJ53CPZy25AzERz5WDuBmpkV6iGkM1hu0e+mz4NC+q7Ar61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KTPLz/4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf6uC021726
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5EWVTocMD9OoRHwS/gWO9hXxJgm+bBkTLNWxK3GDsx0=; b=KTPLz/4bBReYywIv
	3X0hhjfPW1TxqYVk0Acf3eoavFzTpL5p2AtGUT4pce5aKSii1MqX3CJu1EzvbslZ
	isIJ17o5ewvMsywtwg9gOGbf11nShAKaz8auvmOiEoS5sH0P7ZZfwBSQhHu1iV/c
	4NYDepR5x3NReOLGehyasacW8b8+qLOd2dYq+yzU70r5rKLR7m7itoJGP7ZqYU8F
	oAZ+fqddyzSOndaR3OoZlNnfcikgeNYtW2A0MpdV+eZsQJMEI6Mxp8ZQukTkDXR+
	Iza/yCgbANWCIx8UUucZXTLihvoU7N7RfBskgCU3xMQqhQMbd9k33injnrPBcmCG
	JfA2rQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrhdkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:22:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aeb486c46eso16959981cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993330; x=1754598130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EWVTocMD9OoRHwS/gWO9hXxJgm+bBkTLNWxK3GDsx0=;
        b=Jdd4An9VBoRloPl63YrBEmWSQgav7DHJoZIVnIbljDHamL5AA/dEJxIo8GRa9oePpQ
         pw/hZ1gN69j6BFea7lU6YALt1n6oREJ48Ox7Lee5qTiwYubF56z6gd+HCp+DOzsGqwCG
         0dtNyFlBsjDeftRmKkabMr5sZUlNNLWKWowZbrLC7FdklcLEHjVHbx5bKOauL5rvxHZf
         NYbQBsgj/yWB897T5lb3Az2sXijp9aNemv0ufYl4p+t38B/GaeT5J4Uu0g79AaWd7+tb
         1q12unTOyIZACFXofJb5+3XaxkarxJIbLSxRukria6J/ta7MUvmGf/pprqwl/fVJvjrF
         lYow==
X-Forwarded-Encrypted: i=1; AJvYcCUuytuYluY7sXB8o/jIC2u/S9HSl8G0eS2xEEQErJg3S4Jk3ksUCZ175CIxwkgUlFx7X17emWddKgGclUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLBVf9ixn4zit9C2WsHpdc9xWzYKVxUaX0n7xpPSIfPS04FvO
	B2DkWRb8/RzHowCQTmlj9YxwNgy2v6YcwI/u6JAQe4c2L02nhdyrOeWS0Fm77Ve9AA2hmCIWs+H
	g3TBA2IVuBzq4Q53CDYWb0aiYM9isgOIqNR79mba1DjKnBhj4qwe3furFvVPnaru0uEQ=
X-Gm-Gg: ASbGnctNchRhon20AU8+xaN9KodNjisy6pLBF5nJ7aNiUROOYquTe5v7eBMm2vQFspL
	Q/cOzleMYI8/Bc4yg06XtjFfzX1gBlg40W5jVJtD9kPfI9XU16o6IZLu/YSOeJ780wLuXOoZZ/q
	EiJD9DtSUmR+rJs320TZu3JwnlwdFgADNdWEAcBuNoKqFRje/btGJ0p2k4cXGpjOm8VPQkqpCrt
	OD8b8I776hMO+M3UODKfjdqO4Kcx7qEJyZq1mDwDVXjr4ZZP3Nizj7ykDXBdLWUO7llIpGcJW7m
	6RqvqcpoN1TKDkrTCq5u9E19+lDBIpTRttEcQMpsiNGLESgYEtEfb7r8BV6EpGMY0c3Mulabuhr
	lqwsbwhFbrwbbmhqwLetsEGR1Ib+xhnKEd/lJ0Ly7hplnmEV34eJa
X-Received: by 2002:a05:622a:5509:b0:4ab:6fdc:70d4 with SMTP id d75a77b69052e-4af006ea7fcmr680101cf.20.1753993329872;
        Thu, 31 Jul 2025 13:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2GUWwAvkjLqCB+rn2oPBReWxu9rbiih1y1wr1Tg7AoDB+5SqyumLK9QCXI/pVZVaoXdoGhA==
X-Received: by 2002:a05:622a:5509:b0:4ab:6fdc:70d4 with SMTP id d75a77b69052e-4af006ea7fcmr679521cf.20.1753993329211;
        Thu, 31 Jul 2025 13:22:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238272953sm3357201fa.18.2025.07.31.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:22:08 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:22:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <mlbutlxudl5i32zrqegxiefaa2sbkntriwdftn7hxo4khidtf2@oiljtmtktovu>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
 <20250729-hamoa_initial-v3-4-806e092789dc@oss.qualcomm.com>
 <pbvyog477v32s4lu72z52dhsond5yud5w3nxmcouvr6ljlndlh@ws46dncy35c6>
 <b4a3f568-f41f-4141-b421-8b158973f810@oss.qualcomm.com>
 <cawg456ucsvssm2ngbcjvpprxke7s3sfqf4fzoj5dtfj2flnzw@2e3h5ojgn4s5>
 <391b8214-37f2-460d-94d0-3bd0daa00066@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <391b8214-37f2-460d-94d0-3bd0daa00066@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0NyBTYWx0ZWRfX/XbrAIJqJw7O
 RH6b7e6nrASq1QNmZZsW7AG1CNtM/VtUWocB3JRLtSJypc42USzUmegaWJRUg7BaDaP86yb/Hhv
 VzdCKNjTB3BdJBj1WKVAc7qB8vAhPHgTJWnbHUuYJR3P6rCX3tjiAfiElsBAtanrNgVwIS4VN13
 3MjWp1xj+XGMjZsjhxk52NwFXSSVGGz+qo88xHu4oAo49yxN1iNSoebekKG/Z6t0rfVx7+/h9xp
 WWybxHWP6l1yZa3xGwngtNfR5FBq6mjWOyiLFFOUnM4JTmrtwhxyWi26JSDVmILclp47SvwYgdT
 w5Xk45ZBvf8GZ700I2GOhihhrLw7fP4+hW5fIBADR3Iyk8/YBqdOzgC4V6IsX2t/BKG0OF2aJE1
 tlRUfuFF71mpZLrLdgHXF96wr9EGD/Ff4V4wvjd+HBL3ilF8gxlQCJk8gZdonsiM1LXElpnJ
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688bd076 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=lLxyknsEbSeMOoiS3msA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: D-c-KNWRMEDxOOqshzDsYY6oV6taBgcn
X-Proofpoint-ORIG-GUID: D-c-KNWRMEDxOOqshzDsYY6oV6taBgcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310147

On Thu, Jul 31, 2025 at 04:45:33PM +0800, Yijie Yang wrote:
> 
> 
> On 2025-07-31 02:42, Dmitry Baryshkov wrote:
> > On Wed, Jul 30, 2025 at 02:28:25PM +0800, Yijie Yang wrote:
> > > 
> > > 
> > > On 2025-07-29 18:37, Dmitry Baryshkov wrote:
> > > > On Tue, Jul 29, 2025 at 09:32:00AM +0800, Yijie Yang wrote:
> > > > > The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> > > > > the Hamoa IoT SoM and a carrier board. Together, they form a complete
> > > > > embedded system capable of booting to UART.
> > > > > 
> > > > > This change enables and overlays the following peripherals on the carrier
> > > > > board:
> > > > > - UART
> > > > > - On-board regulators
> > > > > - USB Type-C mux
> > > > > - Pinctrl
> > > > > - Embedded USB (EUSB) repeaters
> > > > > - NVMe
> > > > > - pmic-glink
> > > > > - USB DisplayPorts
> > > > > 
> > 
> > 
> > > > > +	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
> > > > 
> > > > Hmm, so there are regulators for the retimer, but they are not used.
> > > > Could you please point out, why?
> > > 
> > > According to the schematic, there is a regulator and a retimer (PS8830).
> > > However, as mentioned above, the retimer is not connected to USB 0 and is
> > > therefore not used in the EVK. As a result, the regulator is left unused in
> > > this context.
> > 
> > What is connected to the retimer then?
> 
> All data lines are broken, except for some power lines.

Ok. please add a comment. If the retimer is connected to I2C bus, please
define it too.

> 
> > 
> > > 
> > > > 
> > > > > +		compatible = "regulator-fixed";
> > > > > +
> > 
> > [...]
> > 
> > > > > +
> > > > > +	usb_1_ss0_sbu_default: usb-1-ss0-sbu-state {
> > > > > +		mode-pins {
> > > > > +			pins = "gpio166";
> > > > > +			function = "gpio";
> > > > > +			bias-disable;
> > > > > +			drive-strength = <2>;
> > > > > +			output-high;
> > > > 
> > > > What does this pin do? It's not recommended to set GPIO values through
> > > > pinctrl.
> > > 
> > > It is used to switch data lines between USB Type-C orientation detection and
> > > DisplayPort AUX channels.
> > 
> > I don't think I follow it here. Which data lines? Type-C orientation
> > detection uses CC1 / CC2, DP AUX use SBU lines.
> 
> I made a mistake here — this pin switches between two data sources: one is
> DP AUX, and the other is a GPIO pair configured with the function
> usb0_sbrx/usb0_sbtx. Both data sources originate from the SoC and are routed
> to the USB0_SBU1 and USB0_SBU2 lines of the USB Type-C connector.

So, it's some USB4 stuff. Ideally it should be described via the
gpio-sbu-mux, but I don't think we can do that for now. I'd let Bjorn,
Konrad or Abel comment on this.

> 
> > 
> > > When this GPIO is high, USB0 operates in
> > > orientation detection mode.
> > 
> > What does this mean?
> 
> This means the switch will select the GPIO pair configured as
> usb0_sbrx/usb0_sbtx.
> 
> > 
> > > 
> > > > 
> > > > > +		};
> > > > > +
> > > > > +		oe-n-pins {
> > > > > +			pins = "gpio168";
> > > > > +			function = "gpio";
> > > > > +			bias-disable;
> > > > > +			drive-strength = <2>;
> > > > > +		};
> > > > > +
> > > > > +		sel-pins {
> > > > > +			pins = "gpio167";
> > > > > +			function = "gpio";
> > > > > +			bias-disable;
> > > > > +			drive-strength = <2>;
> > > > > +		};
> > > > > +	};
> > > > > +
> > > > > +	wcn_bt_en: wcn-bt-en-state {
> > > > > +		pins = "gpio116";
> > > > > +		function = "gpio";
> > > > > +		drive-strength = <2>;
> > > > > +		bias-disable;
> > > > > +	};
> > > > > +
> > > > > +	wwan_sw_en: wwan-sw-en-state {
> > > > > +		pins = "gpio221";
> > > > > +		function = "gpio";
> > > > > +		drive-strength = <4>;
> > > > > +		bias-disable;
> > > > > +	};
> > > > > +
> > > > > +	wcn_sw_en: wcn-sw-en-state {
> > > > > +		pins = "gpio214";
> > > > > +		function = "gpio";
> > > > > +		drive-strength = <2>;
> > > > > +		bias-disable;
> > > > > +	};
> > > > > +
> > > > > +	wcn_usb_sw_n: wcn-usb-sw-n-state {
> > > > 
> > > > What does this pin do? Using pinctrl to set GPIO values is not
> > > > recommended AFAIR.
> > > 
> > > This pin functions similarly to usb-1-ss0-sbu-state; it controls the data
> > > switch between signals from the USB connector and WLAN data.
> > 
> > Could you please explain it? Does it toggle USB2 signals(you've added it
> > to the USB2 PHY) being routed either to the USB connector or to the WiFi
> > card? Or do you mean something else?
> 
> Yes, that's right. It routes signals between the USB connector and the M.2
> Wi-Fi card.

Ack. Please add a comment.

> 
> > 
> > > > > +&usb_2_hsphy {
> > > > > +	phys = <&eusb5_repeater>;
> > > > > +
> > > > > +	pinctrl-0 = <&wcn_usb_sw_n>;
> > > > > +	pinctrl-names = "default";
> > > > > +};
> > > > > +
> > > > > +&usb_mp_hsphy0 {
> > > > > +	phys = <&eusb6_repeater>;
> > > > > +};
> > > > > +
> > > > > +&usb_mp_hsphy1 {
> > > > > +	phys = <&eusb3_repeater>;
> > > > > +};
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > 
> > > -- 
> > > Best Regards,
> > > Yijie
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

