Return-Path: <linux-kernel+bounces-781787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B76B316C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7AC1C85CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191802EFDB2;
	Fri, 22 Aug 2025 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jiPmadLQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFC17B402
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863795; cv=none; b=tSmIs6qrwzG0Cz98qLWKvTfJbF3pVSe8YHgow1Ri2/CJtWMaVXOwGWgFJHhY9Tqfd3z0pyxsLvWHi8fFJy0cfda7CbwwICy/Q7wfo/kBx79itw2cyGOjlys+kZm3sXDm8/Mup5ALOToJp1BtxOMr5iPwQMe7UfntMeh748quzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863795; c=relaxed/simple;
	bh=l5e7J0T/OUqNKqSTaG94Vz4CDys5nKZK1+9uZnepPZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgwbDLwLI36OFxNjMBQFFORYCzz6w3Biv92WUlwgtdcmNRyvaKqknwlk8yZChItvmM8z1QqX7Eihhc4qOkUR/9Oz6nn0fa6WsAGR5xvOjgPiF3iM7JXsbCsHXJ9P0Das6hig85RilsduGxxkxEROVkA6RY5qk+kp4/Sz7HiZOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jiPmadLQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UNZ4020900
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vbW62LEHu74Aw44VkkkoyZ3F
	tXR0sTC79991GoTUD90=; b=jiPmadLQIJvc2xlQHTF5aiEolhpn10h8HyS+rBgU
	zUYR7SGg/NH7UfhCp9GRXY45p6hCsYwbQ7GXvx8LV1Ha3f1hT7qN0RDQHp0FdkKr
	w3aIPUNuNXAHSe3USwf+VZKKGAUUuoLl191LhswqpKqRVGQQWt1I90ciRtw7jWKM
	ZSbM9MdOF1p2UKc5shhQuXNeY5M7bjIEpOaKmAohMK+r45RglMmJwGsTrejSZb/R
	JHtD6JiCF39wDn0paKtWY1gYzd9CPpIHokrNT+5lEVS21RCwo+LskzPzwgITBPNN
	OMF3k30TKQ2SaePYK4hlwBtyomm2FIb8MAvW6Bqk+Fr/Ug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52913wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:56:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d903d0cbaso29390926d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863792; x=1756468592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbW62LEHu74Aw44VkkkoyZ3FtXR0sTC79991GoTUD90=;
        b=ubt26HeFPnoOdKVUSGphBbzMr7TABMHz7XGm2TVbHn/SiSS78MKC/njomh+xcImWiU
         kpqMY1gSaMyYSxpO7QwE4imgnpWiJGf7w/R4UVIop0JMR60bRod0+Uw/6ClYncm6nqsn
         jMvaGiO2StYX+dMWvaPBBmXiBli7ZVuCehEZgHgIDwJZkulqWEXs/okwVAsQYc1BAFVg
         lB16Sllrhz1MJtd86+YWTnZBLcRie1s97hoPFYFy+NO3kp6+6iEnr1OaRFB/O1CSc2f/
         zGMwtScB+cDzQFrPy8iBX8BYXypqDnErkXDPOvqL1c7FyEBjy9ZO1/7IprDWzQ3m1ugQ
         Y0TA==
X-Forwarded-Encrypted: i=1; AJvYcCVwwUqaF77M2VY33/ffRbIQ1QsXeIOVJ3jEA8p1PqwsAnsQ22dosz0OXfnFSXvkfJ4toCmPx0hQtNDI6Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLOZnGvdaT7fOAm0JYvwwlzA74uaFwwJgJmf0S01qhm+vCWaX
	cFq6t1p9/HSVNdmRK3aBRDcPFGySfUJaTm4oGP/Vs8J60kUEYp1IDhESkwI/xUqpn7W/HG9M9hK
	uSSdlXj6mDScrjFE0JhzHWd+Csb0PgShe/Fm/XOt9WcT86yUA1rVVvh1Qvk4Iy24pUXA=
X-Gm-Gg: ASbGncs3aY72t/7r2LbNdeFqAOGhhZPezbLC0ew60MFfEUvwkOiaFGciB6GzkWzmZtE
	x9O6CaFd1YgL16fsOQ+izrBvHLqF8HqEH3TrqDrXKIvctVD0qHqKgJn9dVLGioGGghMyusne6EE
	dh5C0nCqG9AVdhnNpFBOluOnycN3A3mXsNGj6bviKjN90Ni8T52lnoLGBnnfruMx7zsf5H/2S2M
	TMnsqg9gouKPxA5kI61v0GcnKhnpi8KLdlSPoT0+h1L4g48kZWQ2OPsS+S4g/l2Y6+jT7Fq2iDq
	N/hD1Zfajfz8dA5IZKfyEsqyop3uK++zyTrp4/uUct8Ueuk4YGZ1GFuaDxcuMl8csuiMnhFz+gj
	2txMJM6AYmmId8n0FpEGUyTEktLcQKdotjujjuTJMzvIoa7eNhkuk
X-Received: by 2002:a05:6214:407:b0:70b:c8ae:1849 with SMTP id 6a1803df08f44-70d983dc528mr23596046d6.27.1755863791862;
        Fri, 22 Aug 2025 04:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9iDidXcu270WCLKEtYSzRVAzAXu+4qdGyYfnvgVEY1n02/TXreYV3lHvsEsLT/a/hYKhQA==
X-Received: by 2002:a05:6214:407:b0:70b:c8ae:1849 with SMTP id 6a1803df08f44-70d983dc528mr23595746d6.27.1755863791394;
        Fri, 22 Aug 2025 04:56:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a64d34asm34230181fa.73.2025.08.22.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 04:56:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 14:56:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quill Qi <le.qi@oss.qualcomm.com>, Jie Zhang <quic_jiezh@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <jj3mvad27kdpfxo4p2c3jfpjq2icao6mltpx4uu3sretqgkfap@vpqgfwzl3sjs>
References: <20250821-hamoa_initial-v6-0-72e4e01a55d0@oss.qualcomm.com>
 <20250821-hamoa_initial-v6-3-72e4e01a55d0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-hamoa_initial-v6-3-72e4e01a55d0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a85af0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pXZBga7SBimYmxK1G2sA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dOr_ANxg2wfMbfUI4UvzJqpliKkHYDG-
X-Proofpoint-ORIG-GUID: dOr_ANxg2wfMbfUI4UvzJqpliKkHYDG-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8VkuskKoqDww
 8wj/8DJS4+YVN1SA634MVRanz1V7odqz6Btann3q6oyffSwmiSHRSDVCiiUCAomATJDM0lgAJYa
 oOeNcCR/skhuRgofUA3whfWW8vGdMkng+1WEdPAr1s78BsxUPonnLXj1CkPnIEsrIvYZV6juHF4
 NYonPYXj1ZzqJdtldboL85GzvRAw/spBFayTL+Nu/LCb4BTNSjzi+UOOX07nxa0+BaCXlqaf/wp
 mlN6UqlRTI6uzYgwYbGTbapGgXbAclhkyVNq/aJr1Y4mQw96ruGqq0XPcB0uXMTyfZmePEEWLpL
 lTRZapxkiHG6HtKR+2V9JJqJp+wizdj7YdtH8c0Cj+zmy18xCAl/AH5WUnf64sbJDOp2CupT1gw
 Nqlc5KohO7sAr5NKdNKxZESh7dVx4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Thu, Aug 21, 2025 at 04:20:24PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> This change enables the following peripherals on the carrier board:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> - Bluetooth
> - Graphic
> - Audio

No WiFi?

> 
> Co-developed-by: Quill Qi <le.qi@oss.qualcomm.com> # Audio
> Signed-off-by: Quill Qi <le.qi@oss.qualcomm.com>
> Co-developed-by: Jie Zhang <quic_jiezh@quicinc.com> # Graphic
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Co-developed-by: Shuai Zhang <quic_shuaz@quicinc.com> # Bluetooth
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Co-developed-by: Yongxing Mou <quic_yongmou@quicinc.com> # USB DisplayPorts
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1247 ++++++++++++++++++++++++++++
>  2 files changed, 1248 insertions(+)
> 

> +
> +	vreg_edp_3p3: regulator-edp-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 70 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&edp_reg_en>;
> +		pinctrl-names = "default";
> +
> +		regulator-always-on;

Why? If it supplies the panel, then the panel should be able to control
its power supplies.

> +		regulator-boot-on;
> +	};
> +
> +		wcd-playback-dai-link {
> +			link-name = "WCD Playback";
> +
> +			codec {
> +				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
> +			};
> +			cpu {

MIssing empty line between nodes.

> +				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6apm>;
> +			};
> +		};
> +

-- 
With best wishes
Dmitry

