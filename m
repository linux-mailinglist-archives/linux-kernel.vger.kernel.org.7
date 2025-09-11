Return-Path: <linux-kernel+bounces-812358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7EB536EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D152188C9D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E653451CC;
	Thu, 11 Sep 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XEipPzJn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96532A3C3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603087; cv=none; b=Gxjpo4JFhiq1/HC1F2acVyCNmWMJo44NgUFDY7lZJojTruPikekaF2duWBC9VlIni3Qg4AcAK8zA7l+r8ff4KITuPD4Jkqi+qKrb2fIWWWmK7mFEnuRhEwsaiiQvK1kdV5iZ6Hbb6OKyFpj53JKIenyKG5/9EeeEQlyKG6t2UnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603087; c=relaxed/simple;
	bh=4YrZyyB8Rfh+T+OQdySIWTJZ0Z8Gm32c75Hx6y54/Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd3Ho5HC673NPp2YMX1w1PFuTo/dQgR9Q5aM8+vRhlpItMFmrG/n8naFtXokkY53p2eNr9g/Be2EvknFS1uOyMCHaA/Y+vS0JNUAd/gVEopyRIBP8do31KXFxGHYMiPgEPYg4wPkfVeEaAtXsXCXqrvIU501So57YIUCX57+RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XEipPzJn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBSICs025658
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FKGH0QcPq3zUDyOCCypdh5UbCID7mN5vXsMYkcjroE=; b=XEipPzJnvAcMMuSp
	rQ3ee6JkPG3R8DPRaI7rTSrrfrayqYsM6hwMWsZfks66TdYvX/cx4bnBGuROXhRg
	vot5BBI/Fs1CmMWqS7rSc2e/WVQqmYqLP6hbJPuX1jn2A7sGP1fr5+Q24xFUVQxt
	Qp+DpKkv6bjRzSmeToebculihMnO5yxbEyHTo4l7eiicZiavfJ3imkGhX3mtaTOq
	m0gPy8oZWiLBDBzb94AQ7EZVMvg1cLFrQrnoYw4Wdq7oKCp4j5Z+yDqkl1OsKXbI
	jS7DthkM8CUeyLTHuReci23rdT8UgocSEzDSHvy2GLeu+MKs7R2E5RnlG4ykO3W+
	pLZwIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj105f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:04:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b612061144so869911cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757603084; x=1758207884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FKGH0QcPq3zUDyOCCypdh5UbCID7mN5vXsMYkcjroE=;
        b=WrBO+J+rGZgS8VHJNwtDCANXTshkEXtlu+onL7yX5mYtH38xy34s5Tbd92IYUgLWMJ
         APmt6mibAowryhVs6Wh/YQ9jhxDCxoCkIa8GjFInucFrmtyfAnlZehDNfRKB2PRC3ETi
         3yJDOE104LMX6i0wNIRvuE8b7dQl5J+hH6v8RYFJaHD9gvViWN5AgRiXbwpCU9G2+2AU
         TaQQdrRj62vioDZETaMfbwHZEJ7CxVbT9mf0i7MoyiE8uS36f+IjLFS/WPvBdqKAlOg+
         xO+aaY3ZiAEQ2uDyHotmeHbLMKcvh3tWZK8NT2Ab8mQoL36/VFtolqGIvcjYMofZq4T8
         +2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXOI1MY7DDWb5XYAH+l0WxxbpNhVV1tk6j/BBWRWpILb3Qm2EEIOUI2QPbSF3wzKf3LKZiWRiF1bGFpLmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxlJfvuUh1JkkH/MErR12oI1+TWSvz4SS+rrpr6QT84Qhfcq0
	6IkMPSIlNtKl9wNkQQseGdRCMp1EGaHObO6f2BXWB2Hg2hdsQIfnq7y7nKjZux419UoJgYTRcdH
	3kF22OINASpScRPLYU8AU2zTakIL4A36X7aTanH57FaK6tJOVwyz4cBiXKkK7tBraYXE=
X-Gm-Gg: ASbGncvuGGLwAqCoMETT0d3y/VYjF51je94Pne88TeoJ02QFLYOAXETzDqObeK4rVNn
	dDp9g5p6qsu08/XLhZo/zzet5gojTCVTH5k7J4BWx30+OyhWFei4vQr33FGAtoVZDaI3AGNQ+92
	JMFfwjB5hc4EU1yuwkeUN0J0GHtvaKhlSQ08VP0cMo0PhDLBDIQm/ZPz8Txi56IPNN3WGZI9DaP
	e6osuipxAqgtSc5d8IBRq2fAJDQUi17UP0/NA78kDtRH92HH+n32IYn5FUUSr+PumjvR+tu0z+s
	13NsU7lxcdsByeCd791zaIcO19qGYBOlYiOFdAY23i0B/WUfRGTIRkjNe3gsdlSHXOv+jSx/y1D
	arJEN9idh7CTazk9whpzxSA==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr151528361cf.0.1757603084224;
        Thu, 11 Sep 2025 08:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0FppMif3cYGizhNCQ1L/ibDbAQ5mYytEfu5gYANTSlZP+Xwy1nadB0B3Hzn2U//SYcIlZqw==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr151527391cf.0.1757603083289;
        Thu, 11 Sep 2025 08:04:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b317124esm149966666b.46.2025.09.11.08.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:04:42 -0700 (PDT)
Message-ID: <53f1e121-302c-4b35-9dad-114d16c2a9a6@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 17:04:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] phy: qcom: edp: Fix the DP_PHY_AUX_CFG registers
 count
To: Abel Vesa <abel.vesa@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
 <20250911-phy-qcom-edp-add-glymur-support-v3-2-1c8514313a16@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250911-phy-qcom-edp-add-glymur-support-v3-2-1c8514313a16@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: deHHCEVPndsAHP-BohHGppF6h-OcyRDI
X-Proofpoint-GUID: deHHCEVPndsAHP-BohHGppF6h-OcyRDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX8eFY8Ds8FRdA
 OAdemtGeNG+lcsprgxFCgD4a4dVXVobFZVl6+e+sQVysG84sHkropsAoQv7r6tgMFKsVttNSIXB
 XBwRuvESGhWNiWc118tE8tEAVbXDJ6MHLLCyJmk/KgnbgUW8vutWiA9bb/EOzcfesRsAz6N93F3
 ECrasZY8DzMBA/txy9ZlYMNnTvHWYooxQ/CYLjOt08tYGa7JflkcV6TDQIIq/N9zFg8dpznCI9N
 adPsD4f5sQtSeia0Pqeo3FTA5zvag6uXjWaL2ITFNRfw1jYdGZn3wBF2XQ2bHTqNWBaXk2pEB5V
 FgdIxvo2IvnC7RHKGh8mSBxG8g9+7snnu2h8gJDIV6YJIS6o4v+NudD1JmRvpNOkjFR5peWNnIC
 qzRPBR2p
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c2e50d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=c4sUNlcVcd6a9V-9oyAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On 9/11/25 4:45 PM, Abel Vesa wrote:
> On all platforms supported by this driver, there are 13 DP_PHY_AUX_CFGx
> registers. This hasn't been an issue so far on currently supported
> platforms, because the init sequence never spanned beyond DP_PHY_AUX_CFG9.
> 
> However, on the new upcoming Glymur platform, these are updated along
> with the rest of the init sequence.
> 
> So update the size of the array holding the config to 13.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

