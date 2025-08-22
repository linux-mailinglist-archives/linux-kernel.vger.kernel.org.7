Return-Path: <linux-kernel+bounces-781768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DCB3167B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534EE622750
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCD2F530A;
	Fri, 22 Aug 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ut4ZmXNN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3BD1624C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862845; cv=none; b=EcKYoABukUgDnNrNcFFYBOjp6AZtxzRhlfUykcfKFlGRshS46aCnXQBc++xNFpPG03DyyC9FbnIm8F5CNgrLkJbv5vdVU+t9//NMZKT9Xq9F0Pz/uTMqfdG6Y6tEvhd2/cMxlYs+AlOzwmiNKLDWSN9GI24t9v9WZsx12oyTvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862845; c=relaxed/simple;
	bh=z3dg3+uFGdtg0oNaTcQ0qCnHDKy+RCFkNf7fAl1o4fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpTu7Te5FrCpAs4tU6g4jYNY/CLErZdFqD9CAwt3A7YmvxVHpQfzuzmRUIfq+wySHRYs5fCONRtIAfkR+f4fab529CaQc01jLb5gC8LMXPK6uCOfU7QyKD0wpVGkglX1rtGF2ocUHXe97BIFPt/V/17wVD4jxKViKmkkIUwQUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ut4ZmXNN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UOXY018005
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=R3VBpF5unS5o4qUNQOe4EEFU
	h9fh4aEIJOsFeee/U5g=; b=Ut4ZmXNNyrfpyfc5sOajrSXqKleaNdKErZTKNrYa
	hhfX4lFu8Pwk39eh2dml0oUoi5eAY9Wa/aqCJ38bUR4Yc/h44ah+Kiv1+KYjhUVw
	Hu4u6BNMBJnOVcqR7HNWRVed7m7TLTkCxwzU8M+IndULAsTPZnujyh58u9fqRQUb
	7EweY/wk6S90VWr8dREaM6dmdu9DWMtyNf8a6EVQvneiP8JoKdBkBNas6NUZ1Msn
	gI6ymC9IHUfGYl1g92YOK6DDzozIcWAS0bdQRWgEgsjRSDdqc8uhAnQ5fgTqRFgb
	XaKJmhM3fmwpbCgEjkWPKN1CsZLYAZGH9l8olNoG8Gqpbg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52b0wt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:40:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d9eb2eb9bso6353986d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862842; x=1756467642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3VBpF5unS5o4qUNQOe4EEFUh9fh4aEIJOsFeee/U5g=;
        b=ADJ4AYgBoWSTc+CGwG2fIHG0K0aCVNlI7Gz73IEfIz0wgreTDfVb7/un7smVb1NOaH
         uWsU8K5RZ8vYj+EuoSoTbE81XYZ2dp2MUHrtjVRTmAyhIa//QVj5bu/ZNKDuOMLAiXeW
         d6B1XlwA1oYJeyLG3B1U6rgJweWJJFpWH/NsmgadptHbrXCO+DQnyBz914NamBKLqv6L
         lj2pkSu1fVuI0c8SZD5C3sXII/HqBn07vKgjR5wEV/KVzFGnt7uD1NkRLjhbEl655DfN
         UfqIeko+EKCRK38q4w7XNSRyxGaYlFLDln5dVKncBOp/e+R9Dv78G1QAySXy50wPJDRO
         O9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVTJcc6D2MG1KcdWb3CQNjmBoJjWE9ZjwS4XRtWy77F0KCCfr8XjfoFtRRKNGfMoB0khZXVP/aBlwOfwDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa81NRJl9UAsFq3DdCSPiUJ1WdppoxMHafn32s5gogQc9pP7Kt
	pyNdo3gI3cXBFI6NUJfDR3BrKRbqV2ibFiOffEsKsHEZip78OKBEWY4p8eZw1vN7ZeqoUFvGrEK
	8E5+pdt1C6U2zfmLMiyEqTbNrrjVm4M5pkZa9rbL88jKj2loPIgwVSFXEBvMTo1MWgOs=
X-Gm-Gg: ASbGncsuC/BX6fHsGRCWhX1EBxVnM02e3zyH4EAyOKTBsRgICd6pf+xV9xGon0m/aQ9
	sAXNdlJ1iNvKcc5Jr79IqIv6m7EtkBNy719udJvrPC4qBkt8SldYYGyDnaGZKXth7n44+nybmzM
	0BvtgR0bFa87BigLUKqVuFUZsDVCd+llMBNdeDM7FhZEGjxDB24jYq7sItkMnH4IvLrUB3PmY6M
	Bgdhfkg+3UspOgZwQwmcOR7RqVd8pvRkUquWL6UHmnLwumWIFbSwNMlAPjk9MjCFPBW8iv2G8go
	Pi+unt+filqylLssQnP2UiBzIdwCSauEXkr6XeYyMUW3yK46q6ChiyFCEZrOPfqTMG8Bc03uuco
	N2wEt1VTw1I+8whn9hO5H5OhtPlp99ILU5KW+oMhRmEYDl0SY39Ra
X-Received: by 2002:a05:6214:d6d:b0:70d:8d5d:59a1 with SMTP id 6a1803df08f44-70d97205d99mr36224816d6.45.1755862841801;
        Fri, 22 Aug 2025 04:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqTyhMMs7n5KY1lW09izaZu/eTxO2Ydf4e+xDEopme0nS+sjhxdykVOhMlGGOSceWoiv2AyA==
X-Received: by 2002:a05:6214:d6d:b0:70d:8d5d:59a1 with SMTP id 6a1803df08f44-70d97205d99mr36224116d6.45.1755862841093;
        Fri, 22 Aug 2025 04:40:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3153cddasm255874e87.125.2025.08.22.04.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:40:40 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:40:38 +0300
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
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Message-ID: <k6n4ojdhsr2sjxoyrvo7qdoajdxbrjuuxfuhw76wrmpegdyayo@arumyjto7kpp>
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <as7pbmhfgsg3ht3s5lu25pfjjamaxyonuohkuohono3kr2mxii@posspuko4vwa>
 <431de5f8-2dca-4ec0-9b94-fcc12480e8c9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431de5f8-2dca-4ec0-9b94-fcc12480e8c9@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX96DjNzY6l0MJ
 fWy5oztbQ7g9oSv5ZALCpmUym7Tx9U0/gdZHe7ioOsUlMjq33HRH6SMu8Pd+a7jb10j62ucIA3h
 JwsgfUBftbgmP0tTrl/yegigXhJsx8C+KdQc6L9r1pyp/f3lwMdJS7fQSXKPwdQCpQsrjuL9L+A
 VsZXJEuVKKMSWsFFuqoxg1oaa0bz1CTssSKONT+U2ExFG0fnNjPT/EW8ZG84QOYUQg3VMk38WE6
 JWj88s0IrH+1m8ie18mECWBDUvp3X73CZz3WryHCzv2E4aRTA/lFvHU83tjrIoPE8Xpx26RZ1bR
 aKbsNYS6rAri5irHAqtBZp/f8xLYNPNdcRYs2287tTxxSTJE1/jRD7RBxGZ15WxEMbFYU9zzAhi
 wf6cuBxAy/LUUOw6PwEEaT2Zh6sBEg==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a8573b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=0Y_XMaiD5XwD0HHrWAcA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gHzjQTdEtKo4Pq99-YAfrrRPIBOSq5tL
X-Proofpoint-GUID: gHzjQTdEtKo4Pq99-YAfrrRPIBOSq5tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 01:02:56PM +0200, Neil Armstrong wrote:
> On 22/08/2025 13:01, Dmitry Baryshkov wrote:
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
> > >   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
> > >   1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
> > > --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> > > @@ -62,6 +62,20 @@ switch-lid {
> > >   		};
> > >   	};
> > > +
> > > +	hdmi-connector {
> > > +		compatible = "hdmi-connector";
> > > +		type = "a";
> > > +		pinctrl-0 = <&hdmi_hpd_default>;
> > > +		pinctrl-names = "default";
> > 
> > If this is a DP HPD signal, it should be a part of the DP device.
> > 
> > > +
> > > +		port {
> > > +			hdmi_con: endpoint {
> > > +				remote-endpoint = <&usb_1_ss2_qmpphy_out>;
> > 
> > Please describe the transparent bridge too. It can be covered by the
> > simple-bridge.yaml / simple-bridge.c
> 
> Ack, indeed it could take the pinctrl thing.

Pinctrl, enables, etc.

But from my POV the HPD pin should be a part of the DP controller
itself.

> 
> Neil
> 
> > 
> > 
> > > +			};
> > > +		};
> > > +	};
> > > +
> > >   	pmic-glink {
> > >   		compatible = "qcom,x1e80100-pmic-glink",
> > >   			     "qcom,sm8550-pmic-glink",
> > > @@ -1007,6 +1021,14 @@ &mdss_dp1_out {
> > >   	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> > >   };
> > > +&mdss_dp2 {
> > > +	status = "okay";
> > > +};
> > > +
> > > +&mdss_dp2_out {
> > > +	data-lanes = <0 1 2 3>;
> > > +};
> > > +
> > >   &mdss_dp3 {
> > >   	/delete-property/ #sound-dai-cells;
> > > @@ -1263,6 +1285,12 @@ &tlmm {
> > >   			       <72 2>, /* Secure EC I2C connection (?) */
> > >   			       <238 1>; /* UFS Reset */
> > > +	hdmi_hpd_default: hdmi-hpd-default-state {
> > > +		pins = "gpio126";
> > > +		function = "usb2_dp";
> > > +		bias-disable;
> > > +	};
> > > +
> > >   	eusb3_reset_n: eusb3-reset-n-state {
> > >   		pins = "gpio6";
> > >   		function = "gpio";
> > > @@ -1486,6 +1514,22 @@ &usb_1_ss0_qmpphy_out {
> > >   	remote-endpoint = <&retimer_ss0_ss_in>;
> > >   };
> > > +&usb_1_ss2_qmpphy {
> > > +	vdda-phy-supply = <&vreg_l2j_1p2>;
> > > +	vdda-pll-supply = <&vreg_l2d_0p9>;
> > > +
> > > +	qcom,combo-initial-mode = "dp";
> > > +
> > > +	/delete-property/ mode-switch;
> > > +	/delete-property/ orientation-switch;
> > > +
> > > +	status = "okay";
> > > +};
> > > +
> > > +&usb_1_ss2_qmpphy_out {
> > > +	remote-endpoint = <&hdmi_con>;
> > > +};
> > > +
> > >   &usb_1_ss1_hsphy {
> > >   	vdd-supply = <&vreg_l3j_0p8>;
> > >   	vdda12-supply = <&vreg_l2j_1p2>;
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

