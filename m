Return-Path: <linux-kernel+bounces-752560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C8B17731
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0651C2409E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9E25A620;
	Thu, 31 Jul 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZL82j+C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814842620E4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993898; cv=none; b=rMYwIa37UCJy2p/FDToME/bPP2TIHrTjsc1ZiU4c3/lSGEXae+XPHzxLdeuGI02NxYfd6un62XG46FY+8YaNLWzNgX4KdA08E9cfj28YftrvgNR7+qbiCwJL5BIGflkGpoZCPBHrs7I4PxEFW40FnYN5sMU8fAbSBWDZJ+zbE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993898; c=relaxed/simple;
	bh=xTvLJuW/ApOSDzwWfLExf2bQhoNe2yXXWNBZO3mi21g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=furzHUQIkiEYBWy9oeR/5QQWFbgonYHTCvzlRuz3qMiO/sc5CWQtrxiHriKRN4C3NJqMi8DOYyrJwhc8lJhOfrMhrY1mys4GiYB6ukQLDz253c0wQdeUrpAH+rOKNwclg3/M0oqm7zGHjFCAIGtNKRhpG9K2Zpa9BjrbPJpSAuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZL82j+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf7Gv009175
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QoS+iD8VaUIgyzaqV2nW/wnh
	QVOn+KPVj5CIZuJUF/A=; b=fZL82j+Ci6kud5KtKv4vtcFoXel+2g4Crv6XPIQQ
	N/jcSiuABaqZxlEt4ogI3mtZKAo0tflGcZW6nb8S0IUHClc6hBafk7MBzpYl7IZ/
	McjEmYuaQ8xG7QcEwii7+KBVPtWPidFn+n0CpufnoAOBhTjOjEisdPmxe/o4FTjT
	RQUyLX4voRfXUmK1CBAha9vUH4alBgnMxML8cm8JS0OJSbJfgew9kRTMb3mQm/kb
	MFRqRrAf9+SFX+1hHUsL9fEbFU5N+UEd8bdFEeERDI/oqm9SPYBFcEaYZvkB8s4a
	U5OM/43kz92D66QO3m9JidUD53JmQ5WrWC9bn69P29/Bhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep6pmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:31:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4aeda8bf2c1so2468931cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753993894; x=1754598694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoS+iD8VaUIgyzaqV2nW/wnhQVOn+KPVj5CIZuJUF/A=;
        b=BXuQyc3BbjAQx//y6qzFaTpK2iUpM63skWEgnzWj++QiGhLtvoJFz5EAhF09JH1uiR
         gDdLrHr0mSDCSGIAIBggDYEG0MqCiaxOjbOCKFjSmFPHEkmmqFkdJZuHtiyGqFioDmlj
         /gy8jxw1OBDGi4AzrdJA+R11VF785EIOhSTXLrxMyLJDOiFgJi09d6LaGRWxixEOtJ78
         TErpTqp5pLcDxnxDanX6c19TGQOFn0sbH/qs38in6lD24c8DAoCroFi8bhjjOOWBganP
         IY5DR0ggoUh7Y4WOS2dKtS23TjAjP3xgk6oA++nO24nfPBMZcnAJevdEMTUw14A/Ajzt
         +EUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/JXyKSXHugWapwBbO2ZMjCBXhNDKL/MTbH4N2CKQusUu8lopCZZU1LkzT5zuYMxcDJrUWNOGueWSqQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/zb/9JhG3FM4jf74RxoCMm2Ds0zf9zJe8IYWtmSQIOl8X6IP
	2Ym36dYhJjofenpdPCHGKdS8bE1wcR0HtQrOmKsDhNQlPfQvZPMt6F3QCeI+a8RWSECmRxf8jcq
	ZrPgkF0IYo+Ilzs6QAm8a/g8BDj1QnR6V3iytBIFllpaoP9nbOUuSDlTyOLAE+nYHKuw=
X-Gm-Gg: ASbGncvWRFc3V1gFnnZL/qY16FDBAjqkEYi6v7sS6VBQmAUWOLrwU3EkDWPDE0JnjMX
	D8z13tBwk4+DpMcpi6nb/Ef+D9v+9UJekp2MZ0aCntBTP+3V3B54np9YSySDZyQW1u/hyqfVoZy
	kzNfFh8Ip/z/r0k40mMBrrT21egPpn9fDN5QrXPIMeZc3Nc6HxEWJ19X7HFmESg8ZbWyiBRuzMu
	FfyrVzbmBud0FtY9G94f5LZ337JEyPYQQuUUWwuaESELHiTDHirEzm6/tAGJktH3r5lr7yduFKK
	VG253WGK2bAJlP1+d2ZYKbW6qCig43ldtau/LdXz59QpsnWu9YmDaZ1WeRdCYdfp7O+2cRfmp4G
	1CWz3carWHjswO8hB722lbfrrCmzqq4U7O4E41ZhzzHULez84Y+GU
X-Received: by 2002:ac8:5fc4:0:b0:4ab:3b8b:9ef9 with SMTP id d75a77b69052e-4aedbc469cbmr126720101cf.29.1753993893928;
        Thu, 31 Jul 2025 13:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjG4KR8sIlrrwmey+SYNZ6lZ4mSTtNpoyvhRvxc6f1Wla9QXCimOwryXTNV23PvNWNId87eg==
X-Received: by 2002:ac8:5fc4:0:b0:4ab:3b8b:9ef9 with SMTP id d75a77b69052e-4aedbc469cbmr126719751cf.29.1753993893446;
        Thu, 31 Jul 2025 13:31:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a81d2sm348386e87.59.2025.07.31.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 13:31:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 23:31:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC 02/24] pmdomain: qcom: rpmhpd: Add MXC to SC8280XP
Message-ID: <vebgxvaxfuohpy2ilwzquupezzg2obaekylk7kaiyroosrelx7@dzd2f6bpgkmi>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-2-09c2480fe3e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-topic-gpucc_power_plumbing-v1-2-09c2480fe3e6@oss.qualcomm.com>
X-Proofpoint-GUID: ZUzGOQ8ev_lNwj0S8vjA8X6FOTZE0mQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDE0NyBTYWx0ZWRfX0COK3Oh5r95U
 7UE+6CMH1e1MtIrR87doTX4zfreyV8fxIOy4Kn8LCCo1nV83B/FB1hK0LeBd7xz0nK8KJJrq29K
 KkTwAnvXAYHGtx0kq0aA1RmUYT343xH4ako1j2Pwy9NzNyuMUiej/Ao8sf0Lk2RrSWeEbcuHg6m
 VqGl7dcqORgcw7wwSeVPe/BriNObdJjCLnkc8KJtxhwKh/y8GRZw82+R62MQ35EC/9EW3Ly+jUC
 I3PH6ASyiDi/gKNKC1Uoik7ZI1nep+AqtmGJ7KMHQ9ASUORl7MSsEAeErQmUpaenIjcpv8oYlOk
 mQq+Ri11HKoo7K31eM1RrS58jC99sH+lhrXNYJHs9IZ1GsYDFHSeYjB9ng8GKoh9sNW89HGI5z0
 LWcDP9bCk7mwA+hTxoXDMeG9XPTc4vNaMZJSrz96rJf5Ndh1UyqSO9ZeG1EOd2Ka47/42SK4
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688bd2a7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KHzq8nhu3g8-aHLh-moA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ZUzGOQ8ev_lNwj0S8vjA8X6FOTZE0mQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=917
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310147

On Mon, Jul 28, 2025 at 06:16:02PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This was apparently accounted for in dt-bindings, but never made its
> way into the driver.
> 
> Fix it for SC8280XP and its VDD_GFX-less cousin, SA8540P.
> 
> Fixes: f68f1cb3437d ("soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

