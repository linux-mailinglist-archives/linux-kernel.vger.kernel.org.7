Return-Path: <linux-kernel+bounces-884927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B57C31857
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E122189562F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D532E759;
	Tue,  4 Nov 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJUOWZ3X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwxD78op"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191FA32E159
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266484; cv=none; b=tSbr+CwB2nOyCjefeta4NHJVSX99CENmb+yDTiMrn+/H9v9cFfJF1xDtVosT0wPnognSv4NuUMLocLfENZpuHS3Vmb3dR7UiAQump0IJYfSnVN1JRA7RWUXWL09Q3FITK0LC2AudRPcWuRR6skdK2jVLmbObe861GnxwMKg5jtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266484; c=relaxed/simple;
	bh=FlnDwNrJFJmqPBwkTdjJOC5TZs/1XiJe4Y8W0n/8/Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VloTMIXg/DLDvFsCkWbK4nn/FO+mDiO2ttsw40MfBQWEjKKfKWzBoycO+XvG4vzXakVM5R2seCcJlsxKXkpEUA78uXw5sgbjpohzwxNknFEEdT2b//GYWK52UWuyhCoiADMYS+TIt+pllBhKjHotWJTTVamJhpjMKR+vJNUWkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJUOWZ3X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwxD78op; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfig22098977
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 14:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vMooj6nQEjhpvsQbqOx+QSNSWMlut6t0Tcg77EZzlM=; b=HJUOWZ3XZK7vGT5H
	C4nJ5B3RjqZhrfAZ4xDMHZoLUy8GZDjM8aBPWxSy/9xdnm3fMQkn+R5i5qX8qIGD
	fmjCn80SvSOFtiwcD2OnMoL5SAs1CO6tcJm1S9ckEozoPKg2PQ2lAk3qCx7T4aD7
	Abh1MC4dquOmkRfDmib7Z2bT4+ZbDAj7/K+XzReEB/K8iy2CYm3C9RZfVrQQ7B0A
	ANz+dbTgoQopiN0QUvUn9Qa/5FoOISTEueyYgPu58nPA5sMNnwQcfiSHXfdV/M3V
	G9IJm+xQ0FFxARZmo/0G5nNcIDHDcVOKjUqAlUuQZRSsJ6Y5+/hDAtZmNwL/ig7j
	GaJA/w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a79jjsqay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:28:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed5ff5e770so2794881cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762266481; x=1762871281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vMooj6nQEjhpvsQbqOx+QSNSWMlut6t0Tcg77EZzlM=;
        b=SwxD78op8asA1uEdGgrMqYo2OMt+O/BxOWyLUpA+XPGj4glrCX9mOm/9AgV42SH4VF
         2jIwxcp9OG6FdBq3d4znVoXVwZOQUDTpVvCHEoRD+54oykXiB/G25jN9QoaqjfPtdBWv
         WKpDLCjJ9cR6BmPIB9cg6yJZ4SPDdY4meAxI4OFUgNzKgkTbTu2lIY61NFdUASj5TjuB
         bOiARQoV8OL4zSsT2VKJFFIWKqWA+JXbhnU/Qgx/0Rnr99fJ6k6f+OkgtY+gvBt6Gd7D
         l5/lhFw4md88UA1T4a5Vq2se4N2D/BB3kVaX1J6EmRu21oocV+jYwXIARDtK1zCWu84n
         WiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266481; x=1762871281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vMooj6nQEjhpvsQbqOx+QSNSWMlut6t0Tcg77EZzlM=;
        b=JgFGCmiB1jGZZbS5DS/gMcIMjgW2ag948GNms1fuRXVYX2ZUcuz9IAPDfUIUuQ9JEZ
         wIKsxrNY+bNrc1byVi5gbSRNQM5C/NHpXTYgQEkKvYq+fVeI7i/L1p9pvWIupWVX+wKI
         uZe+FsF98eWzyylpAg66vpBBCwLIpwQJLbbh2r0lJ6kVoJVN4ZBnV6jMNttFQ3H2dde2
         jGfJxzn1xTK9suGteQqj3rAKi10AKlEY6yyhZBRJHQhYcMFsNwgJgPZqlPU1QqoLNo7R
         31w+VFHRqT5qc7iG+8pv7+gZ1MzP+Gx6y2MZYqCjIrXbqNcGdb5NThG2VPPW2fndXwFY
         VYwA==
X-Forwarded-Encrypted: i=1; AJvYcCVtb9zDMulR2ySPIltR9V81saqpw3za0MzzyuZ5LplI2dfk+yDf9Cu7dyYtV5MWlHHEY64OGqVK17CZeu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnZV0e9a0BZgYdjoPkoUehKH1Thr5jZPVkeHfclCRti/dA5t1
	fZTg3+TVav9fCRidn+yuvdF335+U1d4t+pNf+/eGv3yO4KsNLUOdXDEXVliR6MsI5YMjeUhSbtO
	Pt5r5xm12pHDU1K4NYK9fqomShuW+Pd93ZEtM66j4dblBnuqLlAu+Ufje6chNx33P11A=
X-Gm-Gg: ASbGncvB/8EKaOxi5lYjY519pWXJCJbPyhz9kksy92iPouEa1eTPqAc6kPdL/f/80tu
	a9iu6vN6xYPGtQ39Ll4H/I+4jQMTovRH7tHqJTnDvRVbKOuSqucfowawGgXdk2+OTstr0kVGbDu
	nLMmTF9Fb9d7jgwI5RCnyAUz/Fsr+Tmku30+2YM+M2ZHblnQ8hRBe7qPzYhST/wK3H8w2wQ11vQ
	NqpN+fFtCeapUIlWNvsI1i90iRbOOK/1JZz95k5mdBcP1/Dn6Rut3jVa3ybh6vao4FkCl7OXqYA
	EroGszL6fT4OXgBlevUD3w5hBGoBAhxDbxO6Eo71H3iC6rlUE8b+pbypaA5zbN6hym4WsBnB61+
	MOV5A98pqk8wxhZN2QC888TnsXfqXDxlx5hKepPMBK1rN3coifOTcqBrK
X-Received: by 2002:a05:622a:1a93:b0:4ed:6ea1:ceb6 with SMTP id d75a77b69052e-4ed6ea26d3dmr5168801cf.3.1762266481159;
        Tue, 04 Nov 2025 06:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcuy8dFebGaXBPucoUYrFWUWiOv4h9ZlBQ/EW+321APZlZZj9bXttm3CnufIKewnbdiOh2Jg==
X-Received: by 2002:a05:622a:1a93:b0:4ed:6ea1:ceb6 with SMTP id d75a77b69052e-4ed6ea26d3dmr5168391cf.3.1762266480564;
        Tue, 04 Nov 2025 06:28:00 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f273fsm221158366b.17.2025.11.04.06.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:27:56 -0800 (PST)
Message-ID: <27f51013-9276-4e41-b57d-fb0baaec5bc6@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 15:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: talos-evk: Add support for
 QCS615 talos evk board
To: Sudarshan Shetty <tessolveupstream@gmail.com>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251104125126.1006400-1-tessolveupstream@gmail.com>
 <20251104125126.1006400-3-tessolveupstream@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104125126.1006400-3-tessolveupstream@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KfN68QnYUudBACquoHVq6j43k0tEP6Ds
X-Proofpoint-ORIG-GUID: KfN68QnYUudBACquoHVq6j43k0tEP6Ds
X-Authority-Analysis: v=2.4 cv=TuPrRTXh c=1 sm=1 tr=0 ts=690a0d71 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kaRI8otYv47dkxnPBlMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEyMCBTYWx0ZWRfX1xXT8wuogm0W
 2h/F+RazsJDiM6f6RF4DgDLnLEc3EhmvwRRoZVv+eXO9LpMLWkE3symq/bXhRX6JEwObvo5oAsI
 csyJSLHv82P2eV5xTJqIkBovxhiIME+uyVaLjf6fMo4TCcLaIAilyFuEheH/AVkxTXnwp1e65xS
 sZ/MZDQGbuKQomBvdJpfhC7YdA/drjmO97Z7+ar+35wI0zd06j1hKL40iy57AOwnaq9RNdpiv4v
 CSd8JpT7WybWOQ0rK+DVVW1y/qL0g/jiCopWEAzGv48Z8cmelCVW4efBvTVkDn4dRtuj30QQd+A
 a5rtzRevVUymxLh3lHXPbV85cPRTwpCj4H+BJdel2GEW3B9g3aX1eijh1FfGRfsL0nb16so78VN
 FiiT03IUdCaBjaQB/YH3JjNYi2fQDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040120

On 11/4/25 1:51 PM, Sudarshan Shetty wrote:
> Introduce the device tree support for the QCS615-based talos-evk
> platform, which follows the SMARC (Smart Mobility ARChitecture)
> standard. The platform is composed of two main hardware
> components: the talos-evk-som and the talos-evk carrier board.

How is the carrier board a separate entity from the "talos-evk.dts"?

[...]

> +&mdss_dp_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +	status = "okay";

Please apply a consistent \n before status

[...]

> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7535_in: endpoint {

and between the last property and the following subnode

Konrad

> +					remote-endpoint = <&mdss_dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7535_out: endpoint {
> +					remote-endpoint = <&hdmi_con_out>;
> +				};
> +			};
> +		};
> +	};
> +};

