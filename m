Return-Path: <linux-kernel+bounces-842818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45EBBDAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985D74EA9D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17823314B;
	Mon,  6 Oct 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhcZ85ZC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD422B594
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746319; cv=none; b=X08vVzWBiRhHXqCMGrLdNJzZsGMwg4bZI2f/6dsPT34Q9vzWSSAXiSkhMGqGe4QD8FieL2Kr2VJWvELNpj8vzeoszwoN363Zcfi82rdhF5IpsaQ9EeKaYuIUT0+4IqqLyfvtOluyVTzaXZt2i2fI05tf56d+E+0bQRN8hX3ALp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746319; c=relaxed/simple;
	bh=UJQ7ATeIZKqg+H6Nc/MG5lNeEF4JIpt4M+nHiSy6knk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfN/GxC9i9cf69Tj9FhyG9FcdS0OFqOH+D4KhVgMz0I/pHpIftCirCEIIbi9H3ChS76OXsmiPBxyFFBBqGV5obURYZFGqxIqfUqcQ7Ypg/lDPfmsmo4XRfjdQkrf0ET5vtdhcSrCybKb0I4xq5MaiGfRBRV8KCVSGJVPPooyvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FhcZ85ZC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595LXSb8017633
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HBDnqR+G9iEwaHQ+SA6dOyDlxOy5jo2xatcpOEfaBqk=; b=FhcZ85ZCtkGl8qlM
	+BxR0U0WgNixSZ9oEEx+2uL9PgGDMIsVdRr9e5uJb+CCTSFGA8w/6KZyCE3l+xPC
	9kqtdR6Vw2nSYJT1epHyPozlbUiWVXmpRsfYcbOb0w6L7oZ9Cv4d2ypJYBijc1Gg
	xh/vR5o5o/FrtbTmOdvYRrIDuSD4mdf3j0L17E8LscjU0sceI5bxz/2ABFul1Z4y
	4VIYwNIyRdILSNmAjpIj2eB2874XZfJAiXkTThaHx4pZFwRvGWvNv3l+E2703r8E
	0pFPBeyfS8h519Fnuzk4oWTkDXNK9BpBxolZUhWOibmvjfacYB764zakstpQ5GHy
	ISAVXA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhkdkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:25:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-879fa4a2989so3373376d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746310; x=1760351110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBDnqR+G9iEwaHQ+SA6dOyDlxOy5jo2xatcpOEfaBqk=;
        b=irc/useVO4H5+cSsyFO8bM5a1o2t73HwSPDPIodlGQ4gatHWgndQzMNEiQuobi5Uk0
         uNAZW0qyRfn7tCfxPib1COB2wbtaYNIE+yQsuUm41lgS/xLTHDDRe1TaycZ7aCJaBmTg
         ihXzXj112jFLuCZ4x+vRwhNbtIG4LLAfXqzA3YKvac8jSQ/Ll64WJfUP/WjSRhLNEG9y
         M2mh6mFHoDqnTHlAgsaBhvTNMQduHPYAiWn0zQjLAZ9atFSEEUS5Ey5PaL27ce1dGVRC
         TgIopa75HEw/YHKGILrdM8zMvL3LQbGxl1t2B0pMAyKsta1BYtc5i3ZoWd2GVRpTcpV0
         TBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/rGox+oYLAFITDoYW95sVTf2lau4wbT0zkj8Sx7U8A50ZT6pB2W0xPt8BjNKIPhE2ZoADb8uiR3NEMD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuWgDRt2tpa62y+4eNe+FUVH/8t+RuHEtBD7qXBh+/Z7XK+Ivt
	q/qNiwfd6i/ypLwhzceF+jTaLhzViSIWSVx4pGwFgve/DSyuQTaOnaZH9NcpzUNFvjvUJ8HDtku
	H4g5xrAEtYvpztrgUqbAaxESYykXXLVlQlyXEMUigimBG5hZj5aN+Q5oTo7Mmsl+W9O0=
X-Gm-Gg: ASbGncsaTfEtyWTFy9XUcLlTHv9J46+9KwL7YwoEWcuopDLBHonzY+tkyAom03c/TTQ
	ms57E6zfCceobYgATzrSoi5N0Y/XG8mVe8NtuqcMt8nXxQAXXDuF4wCdkVYCHaxuR9nVqCbCbe9
	AqBHk9nJ9UnS9KeGMPe5J3DvbiMHnJQmjacNtKwFXIs/g6BuPSq9oyOFanYEQ3gkcor3+9+6vKG
	J0qdTLYOsWuYgOJlA7XIGBi/kilVfX9ctJuXh2TXs46MFF9LG6mIkn+sTASKqftvRQ3S0BP3+fD
	xB0ZLoKZM3PZf/nDlBM5I6GU0xasseW3FpQ8JOuo8wi5sianyI59HY0/AL5ShTwCDxkhqIOsTA+
	CRl5j0+TudcBl/peia+MxNQ+Yfec=
X-Received: by 2002:a05:6214:20a3:b0:763:83c3:5977 with SMTP id 6a1803df08f44-879dc7875eemr104493366d6.2.1759746309763;
        Mon, 06 Oct 2025 03:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAsA2+8LmsPWiW3AgLrAN4zG8ewGH8WJ0c21RL7gCTD0Oc50rVsz4UkK95aBRsmX1q0+0njA==
X-Received: by 2002:a05:6214:20a3:b0:763:83c3:5977 with SMTP id 6a1803df08f44-879dc7875eemr104493176d6.2.1759746309238;
        Mon, 06 Oct 2025 03:25:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3ad614sm9765621a12.1.2025.10.06.03.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 03:25:08 -0700 (PDT)
Message-ID: <38416f73-9570-4f01-b179-cb653a874b69@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 12:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-3-86a14e8a34ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-3-86a14e8a34ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfXxa7Jr7ihqE5x
 2kuxdzBTxSwak4oI3YpHgLm+7QD4nBIqFdv4xXpvZltXlWwbp+BfNzE5PteaYBjzSTJnOMbuCRp
 9T6AvzsMwxektm2Id9cCU6BJQ3op+OU7l/z9kvrvHLEy2sOzo9mJLUbrN0yV0iWc46sO74GnTsT
 RYDHAG92fh03y6QwY2hpw29qSBQYCLrWSw+QqwJaZijpWwGJbirW/AMomBILHJ6SEu3QlSJHUd3
 zNrZ/3IzohHRiiGhe+f5Kus4QAojufB9BZ+2fIvIaEu30JPiOPgnLkc2fo353TnGPdkURPCIdDU
 W6YahEhmXDE92ezh0BhM9y0o7wqbRt+IQ9vsewRL8IhIG7+uVUJpb7hTNspIj4QzzK86/UIIAtI
 H8SB7H0KxiX38J1vQ4VAa9kI7jaKkA==
X-Proofpoint-GUID: KcoTK2oIju-WFOfkYoLmlW5A3imJHU_0
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e3990d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=b4hOb4oQgmsngjji8b4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: KcoTK2oIju-WFOfkYoLmlW5A3imJHU_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On 9/30/25 9:39 AM, Neil Armstrong wrote:
> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
> connected to the third QMP Combo PHY 4 lanes.
> 
> Add all the data routing, disable mode switching and specify the
> QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
> the underlying DP phy.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +&usb_1_ss2_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l2d_0p9>;
> +
> +	/delete-property/ mode-switch;
> +	/delete-property/ orientation-switch;
> +
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/delete-node/ endpoint;
> +
> +			usb_1_ss2_qmpphy_out_dp: endpoint@0 {
> +				reg = <0>;
> +
> +				data-lanes = <3 2 1 0>;
> +				remote-endpoint = <&hdmi_bridge_dp_in>;
> +			};
> +
> +			/* No USB3 lanes connected */
> +		};
> +	};
> +};
> +
>  &usb_1_ss1_hsphy {

You have to move your _ss*2*_ node below the _ss*1*_ nodes

otherwise:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

