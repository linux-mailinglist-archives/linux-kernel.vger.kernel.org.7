Return-Path: <linux-kernel+bounces-845199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34CBC3D91
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9FC84E41DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F523E330;
	Wed,  8 Oct 2025 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jn5x0UvG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0F189
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912265; cv=none; b=qmgukW095dArNvWvarX5hkT0qjjz5e7PwVEknpXqVXYatdPz9CKdYDhlUgHrlHykrtj0YQhFfLBlcNMRWhiOoNzkfK9LXJwTnAlmfcssqX9lKuZdUEgAdbbPpo9pWV5JgDR0asm3fILBHe4ZsNA5694dgiVmnHovEQf0uBoLQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912265; c=relaxed/simple;
	bh=MlOQPUrFbRM7lzb6+6+OsElMAObdrmpb4oWngR80KNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVPaN0aNrrQExP0FrETQhTMmLD8nv9QVPeMGtFGU2gent7XdYtngsNZJNWzs3Rd5RAhxf9hhwzYE+9QSQ9o1OXu8ltydDA4LSaJ0faSxC+PtAiRki7w0ZKFFqSoH7MbpND0f4oSr5NpSb34lF9KRiju59/IHlQqtmfBpVgOPPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jn5x0UvG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987aVs7012334
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+msSb2AQCXuitHlyCPM/RkFMjkfHAZ9Xm5Da/gnVsS0=; b=Jn5x0UvG1v++ZhOx
	EakpkYX6Pf8tlTjMEVCrbKuoS0APFpTQRmwfyt6QRqh/K3OInFOeX4A+mYQaGGzf
	37G3lTMUbchAcbPgRWFAnq+ztDooXRZh5yWTAPZgllN8f2OiPb9jv6N4eU60O2h8
	JrCpbFXWcj6zg/ikmwtDpC13GbC5PJMksPDO1DJTSWbvQAY9ireEFIANTTTzykqV
	Dz18+ve2SDiVXIJfzYPPgn+MLVQEtZmEur3GWwx6WUDrYweJSO4kDCniGHdktyhd
	YpZbMprBvU/EByUkOMQ8uoBOfsCjTITXoOLrmuG+cAgu3PyDVHYBZdJMnJA27lkY
	CcbQ3A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgsuhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:31:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ddf2a2d95fso25518971cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912260; x=1760517060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+msSb2AQCXuitHlyCPM/RkFMjkfHAZ9Xm5Da/gnVsS0=;
        b=bzCa8XgjL13KwtBsad6Uti+rRX0Msi/l/zlaotwA5rSN9LiUG8mpiZzPAQ3EGDTE5D
         bG9uuOdTRGIr6xW3i6P5dK+MkmUOb1gqcjpczf50y3F5RUu9Wy5luowqW9oSDgLEOapf
         0yFMtyIE+w09kYgl+iZHpLoYrpUvRFgJSSsy9/U5o2FZZ319duOKYsyFSVyLt5qb1hoc
         vYdOKMb92E7q7jed1trM8kMpDb16Nzb96qLeZUdUEr+Y70aaDDB3UEBdaHzN6g/zpHZ3
         MfdXaR2fW2whXEjI7zfYMABMIJNTx03RXeN68TsJ4f4ej4NU3ZABg24W9zdszeoKtye7
         ZIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbC24+lYZKXGQ6SeY+2WfU05wh5zrlSrP3bVe3x0FWPQv3FxrFRO+9gp/5gejUaYClG4mAoA3oRu3kBec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbPcKYtATQPBOYpjiXxad5fmdG6YKGHeR/2ow7PfIhlLa528O
	RcEtpGfYgNEBOxzCkclsA9SarLoSmydIYdY6J3zHNn9oQJaU2FBQWyuOS4rGmphdh4Dtx4RMQTx
	bzmUDMA1tsRyXAEoBEJuCr0ord1mniLvX+Y0WultfLOlq5dxNM0VvtH8T+yF/aJJWfy8=
X-Gm-Gg: ASbGnctAbtEP4RpuRRSYEuSUy2gaLOqINrCyQPBmc1pZY1NrWr/xgdhdNtQOXXZw13q
	909aQRPvlkFbzFLHr9yqxmkTTuDPNbuODrkegMYJwt3NAl8s7tzrXYUW35NosxEtj344NOoepp4
	Tts30MVzhlSd/hFARQDkCIgKx4+0OfhR8Z7JJTKqBmIU+McFJ3ljPGJHwvriCn44IB9eadjbDS2
	mKFwXMkmMulFczprWYqogXutyVc2kcIdgU7a7BoT/Qptw+P3uvUp2F9L++wp5XQEtZ5Ln31jqvO
	zKXrT0cedSNHsaqctJ9EjKcgyomO3+40eR5SdyrFSmB33O6Kb9YMcBpPA3jK2a2S6pLpW9hXfbC
	jEK0kI6aoua0rEdfkHQO0J4H5O10=
X-Received: by 2002:a05:622a:1a28:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4e6eacf31e7mr24483711cf.4.1759912260329;
        Wed, 08 Oct 2025 01:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEho6Mv27Giv6bxZJ6pXvVDhyeR4MaSk/nV6G8qKCeFZZbNjnhay6CBU2IK8uL6Zhs0P9fM9Q==
X-Received: by 2002:a05:622a:1a28:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4e6eacf31e7mr24483461cf.4.1759912259775;
        Wed, 08 Oct 2025 01:30:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881000besm14230201a12.23.2025.10.08.01.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:30:59 -0700 (PDT)
Message-ID: <6429dd8d-d610-4393-9863-b856dcfd0cb0@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] arm64: dts: qcom: kaanapali: Add iris video node
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-20-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-20-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX3u3pfeULOEgU
 eVd2QqvUQOPNbtPirprBFxfSEX0LEGmaItmDqds+P6+QGbg3cUAKsDsxm7vZJDij4dGJAoEQ7ym
 DAWGgqEynm4VCD4t0ieUjKfV2pfZ9AbBw2NGfQofMDXQM1QEESazkq6gdIBB7K373FfgWDI/Aq3
 JpRBazZGiSelktzGifVFgjEoN3eNYNxaiOWuuPa/DwW9NZ/yHDHV5CN/uIc+cuz4tN2I9T1YYC3
 z1L75CMQctsxcLYnNLnS3BCgWkj9L3ftyiTw4ilApUA6OWXBJu7YNOiGIfUE1L4iyRCNaAEn5VJ
 UyFHasmyWmPupuU40n760EDzU6L9ErvpV2nn4XHBOmefwaML92KTmS1Qe2r8x1dNB395JOF5Yk7
 LjQ2H4IlUaUfFU13nxQ7gJG6qYA1Fg==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e62145 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=nVCHojuieXwSnDvak8UA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: dzJV6YPn0K65oQ3tUt7MEKLH3G7QxlUu
X-Proofpoint-ORIG-GUID: dzJV6YPn0K65oQ3tUt7MEKLH3G7QxlUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> Add DT node for the kaanapali iris video node.
> 
> Written with help from Taniya Das(added videocc node).
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

I think you might have lost Vikash's authorship here

[...]
> +		videocc: clock-controller@20f0000 {
> +			compatible = "qcom,kaanapali-videocc";
> +			reg = <0x0 0x20f0000 0x0 0x10000>;
> +			clocks = <&bi_tcxo_div2>,
> +				 <&gcc GCC_VIDEO_AHB_CLK>;
> +
> +			power-domains = <&rpmhpd RPMHPD_MMCX>,
> +					<&rpmhpd RPMHPD_MXC>;
> +			required-opps = <&rpmhpd_opp_low_svs>,
> +					<&rpmhpd_opp_low_svs>;

I see that the PLLs can operate at LOWSVS_D1 at the same frequencies
as they do at LOWSVS, although they need _SVS to fully stretch their
legs

I think we can do _D1 here? +Taniya?

Konrad

