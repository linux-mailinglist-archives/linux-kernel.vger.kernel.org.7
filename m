Return-Path: <linux-kernel+bounces-847850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE3BCBE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EBC3B7F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B7524466D;
	Fri, 10 Oct 2025 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SABTPONg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAB257431
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080411; cv=none; b=T91Zg06Zr8TIffLvvFih+kRJxon23hWYz7lR/IjL1aePAGkqiIWAnmWnm8DoqctFwvtMYtu64OD/rFIwMN3gjxDCBf/Xwy0gJnYTPlCptaG51vub+ePrWsUzTIJ2qLIPKN97GdlNjIdlqIF2s0JB+MxLmlNRsCy54t8yY8vS8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080411; c=relaxed/simple;
	bh=ts9kOQV52xX2ipkuJDjIaYy4QbG40eTx4UG+9BV7Wxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCRAeUxrtHqk0b3uAIVDFG0DncyuL59ACIAWITkoHUaTfDUhtfbTP8iPuObo/JPWfi+qIl+0aCZUGLycUm6q/hXh3etsjXNMA87iWJ/ZUVPy/ze4bNZXK/uRB99mgrq9ASy+yCh3vgG1hGXeF8zZfSbhuHbE7s7XT/rG8KTAXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SABTPONg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6Wx2I032492
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KR/Ios316oNkK2GJ5MYH0w1E
	L7QWbrsGiZOp+JqAuJE=; b=SABTPONg6XJeCij2J5BfYfXwx+rYlvoIyOjXwfay
	h2M6Y5GAmx8to10ygS2uH9EzQhp2qsbWU3wf2EF9++qhsNaAEc7hLto+3FgQPEti
	v3IyZK4QKThOmgKLq0zDuf42DO4xBKc5Tr4BVbuMBcNyaKFdzP6eSegBxspSnJYW
	s+hhBHWb43B6O4Krdf8XaLuwywdkMr6yGwAR7Odn9OKyUbER10lycwq8aORZetV7
	YyibFS+AubM9r/EqqymE8UNtxrqU1VrqzCmMnLT/WHxs3/valwN0BaiGW/x2/zLQ
	P6l4jDoZSW+uLZmJVM8DG2cMxyC84JFZMwzEvEH1k7zt3Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kwfer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:13:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27eca7298d9so81833565ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080408; x=1760685208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR/Ios316oNkK2GJ5MYH0w1EL7QWbrsGiZOp+JqAuJE=;
        b=mXY+ZD+Iq3lddGNcqMQLYGdaBWaE+TaQdFgIjqIUKBVypalOtnAcPyU2VxD417JQOF
         KZc4p3LzGeSQ6Rs9LF3jDK7dERkcAf3POZ+0mWMxPyXHV6JKvJmSRCp/y1SSTXfxTr9S
         5iuqFPXtjPTKoGivqGk7ca91BeGPcdhQaoaRDzCGN2wzQqXcURBZ9SCV7mrG5U2WiTSn
         0tSzc+QC74YhnwXvvTZiPUgPrTfFzCAUWjbLS9ofaXtj02YmNcV1CcOMpQluRzCd8owc
         64BcK1FpvYSaDsXnzC2ozP90K9a/YQp6KV18/3HO+jiw/rgj17a4vj4o5ZEN7ezdIFDn
         d5pg==
X-Forwarded-Encrypted: i=1; AJvYcCVi0cQbukYY4c/nxRIT9cPRHOgJK3DsVPgxWbiAUYg0r4xQn/XUgN8YAWXUw2f1121F2hRnBvhEUOG0ckE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDRpjJRCAJH3ADY4Ndc406ORy/dq5IU6vXwVh+IN30Qgq8wEt
	T/BLsoWHaHu1zy+AcqU05+pDaqDciuKRASGl5S1S5GFNMSjZrj/T7IPgZiP1RnMuGlJDdBTR8Gk
	iEABKxJz0G9+80uTwvKleIFGwdANLctjuXD7jTTicDuhm2LS95Gbg4fOTPMFC3rvSeuZZh7uRAR
	qxaw==
X-Gm-Gg: ASbGncsSOu/cAytfkbebqllTuX4F0MaMmROtTbDLyaVpRnyn4HKI33WzwTS+VgjboyY
	G8tFfsDlSqyvkSm0gmW5UpxNtzr1bU0vfp4a2gcuW4gwSlHsJkFX7y3uuk9DU7VCNByuwot7nB/
	i0RDUVg+8iY13GMM9jdRA0dzdmD7ODc/SoCV7g4oYeZIQXxYSyFypiT+lojFMAueWQ82TSjvB7J
	9C8eniupcEbYOtVK8XjvbM7r1IY6B45cR45yaFKss0cpYLbmPPrkR/u876goFgeP080baTcbke6
	VZeySittfMx7mhwrosab5sCAdDw2XDBiVU4wKUYPw4ajJnd/2GBZeJROGV1qWCTL16chvFtZ0Fr
	HOT1cDD8uHNI=
X-Received: by 2002:a17:902:e94e:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-290273ffbe6mr131256125ad.47.1760080407483;
        Fri, 10 Oct 2025 00:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZomklByII8D+XieFuJ2V77oyKee3Dzlu5Ztu8yLBuVQK2BdzUtqGP5w8pf/EdEOpW5U1eww==
X-Received: by 2002:a17:902:e94e:b0:26f:7db2:3e1e with SMTP id d9443c01a7336-290273ffbe6mr131255795ad.47.1760080407019;
        Fri, 10 Oct 2025 00:13:27 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e45568sm48077925ad.55.2025.10.10.00.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:13:26 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:13:24 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/24] arm64: dts: qcom: glymur-crd: Add power supply and
 sideband signal for pcie5
Message-ID: <aOiyFI0gBDh8YwLL@hu-qianyu-lv.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>
 <qudnwwle62rekkuaeriqhvkvk5xukl4fmkhkzjse5zud37vlxl@gek6nmscgvgs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qudnwwle62rekkuaeriqhvkvk5xukl4fmkhkzjse5zud37vlxl@gek6nmscgvgs>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxkABml+8iJGr
 QA+t6drF4tVtbaBVEx2aBbrW/xP3sEKeixBmwVJTjVTJgUFn1okLSV2Xfj4RWcfhuexFEDuzXGx
 3W3bGVFSgxRSi9st/FMLSPIw8dA9WdFJndd0h4Vjr3QgcX1s5+vC1Aic9fhml0gRF+bf/xL1LFG
 VCKu24ayVq2cwnWd3J5HgMbWJ2GflVA2gwrC6js7rmzCBOBbk6Ro5YU9BtxTJnZrk5u7pD4iOO1
 1tAmpSJgA5M5b2sPsV0eGnQuku267JcqBvz3lsAM5f/y+xwSeBIKwNDhfF53PAoQCQ/mdwiAvx8
 ZfZrKyLVkmwWNE0bAkxzzUZa4mtWFG//sip3rlHK/WEaEXo3XJ57Hs+A2jJ1b2/dXkdBYV9FERf
 be27/zFx8faIQmo4qd3e3snuIkBKng==
X-Authority-Analysis: v=2.4 cv=CbcFJbrl c=1 sm=1 tr=0 ts=68e8b218 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=CFs5gaHkoshYMbNuCBMA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: QDvjAl7bTWnGpDMsAt-S6nkt3VSCmkpB
X-Proofpoint-ORIG-GUID: QDvjAl7bTWnGpDMsAt-S6nkt3VSCmkpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 12:53:24PM +0300, Abel Vesa wrote:
> On 25-09-25 12:02:28, Pankaj Patil wrote:
> > From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > 
> > Add perst, wake and clkreq sideband signals and required regulators in
> > PCIe5 controller and PHY device tree node.
> > 
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/glymur-crd.dts | 68 +++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > index 3f94bdf8b3ccfdff182005d67b8b3f84f956a430..03aacdb1dd7e2354fe31e63183519e53fa022829 100644
> > --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> > @@ -107,6 +107,20 @@ port@1 {
> >  			};
> >  		};
> >  	};
> > +
> > +	vreg_nvme: regulator-nvme {
> > +		compatible = "regulator-fixed";
> > +
> > +		regulator-name = "VREG_NVME_3P3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +
> > +		gpio = <&pmh0101_gpios 14 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +
> > +		pinctrl-0 = <&nvme_reg_en>;
> > +		pinctrl-names = "default";
> > +	};
> >  };
> >  
> >  &tlmm {
> 
> so tlmm already exists in here, but ...
> 
> > @@ -461,3 +475,57 @@ vreg_l4h_e0_1p2: ldo4 {
> >  &pmk8850_rtc {
> >  	no-alarm;
> >  };
> > +
> > +&pmh0101_gpios {
> > +	nvme_reg_en: nvme-reg-en-state {
> > +		pins = "gpio14";
> > +		function = "normal";
> > +		bias-disable;
> > +	};
> > +};
> > +
> > +&tlmm {
> 
> you add it here again.

Will move this part to above tlmm node.

- Qiang Yu
> 
> > +	pcie5_default: pcie5-default-state {
> > +		clkreq-n-pins {
> > +			pins = "gpio153";
> > +			function = "pcie5_clk_req_n";
> > +			drive-strength = <2>;
> > +			bias-pull-up;
> > +		};
> > +

