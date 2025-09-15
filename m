Return-Path: <linux-kernel+bounces-817083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7933B57DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D0C17FE82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE6231B811;
	Mon, 15 Sep 2025 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOeYD6WY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311A31A54C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943786; cv=none; b=eJxTKPzT0g0jxfAu1uM5bCd26Tr5HoKcrZhhsdjx8kf7CTJfpZPl/Zgvou1tpjpfVV+eWblD9++YD9XboxMTzmg8beGvPPafNUzk1HlaDcEDNCm1X+WprXLhZHKOUM2QGmS6oL2b9XaBrSzzX+kwhfBJolYsx509ssoOYOuSReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943786; c=relaxed/simple;
	bh=v+GoUr80T+Uq7qzt0nWDvFetOFhw/gwsgJSHNNUYMnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e25nyyilaVdYQzGQ76NDOaIX+QaBBzZH/CCWafPNPkPGS5dqQtquolofDbWBVhR4MneBHKt/a3u51MRsc0hDWkjM4/qNadDN5wdg5GupOd3gSNB4IvkYX0zuTp6bQnwlpny9SqYqHV29TN8vHw89WDKcP8I4mWMbxcb7/N2bgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOeYD6WY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fgbw002161
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lD6LjevKuZSuVw1MwwNhO02UtoMPI94ONWJFlaUQpwA=; b=oOeYD6WYNtuIxRyn
	LU7Oy1yTx8wpxZkWRPLzdI8rNvfSahfXDaO3I67aEkOto4uqNGeE7aNXLWSCFK6j
	7C9jJrsnwJfQzPQ6WaWaQKT+Lnhbvs5oZHGoK2EB7SAdiCEi3kksO+qhEP5D4R+p
	GP7Q5kZutYzAxqbYWUl2soD3QTs/fD808BS74bnXY4Idtk0cJkFGt7koer2NzixD
	vd1S3maOYf4ks62t39FZHkESOjeshjCPk2ldrYEMT+0vXPrq+OfIusKF1UZpMtqK
	Tr9wk3I6sHGqTU62j5JyX4xE+8KlFb9FKvZpJJlRyp+I++gYT3V2VvoTPSOimEbi
	PlkLNA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da99g1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:43:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b604c02383so19062571cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943783; x=1758548583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD6LjevKuZSuVw1MwwNhO02UtoMPI94ONWJFlaUQpwA=;
        b=xHzNglHdMEKz5qvGDqwEotQ6DajSU0h50+vZtAcvO/ywBGneDU1RZ4qCOt8r9kDZRW
         MAo93ct3uxoD1yRlGEGPIytiFW3O3znQj5lnS9gpx4gTp4VfZVBAJGvEbzqoH6K4y7I+
         PfK11WctLQBwPTxbm1XXxerr00BmpKx9LF5kcXGKOkZUNjXVvasX0iURYg05dqT9ayoK
         IoA72LTYW8jE/XyRMIBK3T72xkfGLqrCQw07hCcfsrs+aTmlqVQ442WazwXMo/bksVgc
         C9bU7K1iAEjmdNl4aCQV4n4yHmNEvup7uEPIEGrwQWKLv8LpCTZpAyjklaIvST6cmvVK
         E1fA==
X-Forwarded-Encrypted: i=1; AJvYcCWGtAfYr2T+zGcw6sQzzKdUCG9qyyHDCgBJUCGktd3AD78uDxWQs6GPB9mwmnOBduA14QCscWqGeEFV9N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlM12AWY7fFS2HB8Xg+AH89T8wC5g579OoFr16rYZm3ymr3rWF
	B6ZwJzglhVMLm4Pwk9W4nj72ag05g6coy0PrtrIh7U18a4DB2gJFoldicgFWOOjoSO7lzhsGmdq
	3Xja0q+QtJN3YzTix1WAC9anm6ES+QNPIocQ4EJ/2sI8oCXCkASL8KFcwi9kPr5W7GPA=
X-Gm-Gg: ASbGnctQUpJFZQSI1I2NgDI9BF2s1hXr6XLeiQFVdEjlXuEl2M+ivscd/GpYMmheiyk
	ZWs3MRBZh8i8jHVQjY8p4jI0YrHnOazoy1hXjH5a6fDL/olzZlWwa5DVhBf7nBH2hGcib6LcTWo
	QqZMbVwgrFI3Dx8zORS61CszhOShZJ2lpNUJMXDvYZLMVLkt9BkwB52wEVO+iH/BvjEmQVBKGit
	6MvzQ2Xa0onuqIkW5DneiH4afaF2cupVI8Bcnal5bl1uodHsYb+FcxhPY9/1M1xM+jIM3BxiJN3
	A5wQMdyPCyAoAQNIlgcofb+mpQl0TrLulDG0BIPL+iafoB4T2Keoo9DFA3kV26V3kyEpPzeOq1+
	TeceetzjJ0R02AYSaKYZ6Sg==
X-Received: by 2002:a05:622a:94:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b77d04cad4mr108187861cf.2.1757943782429;
        Mon, 15 Sep 2025 06:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP3kdo769sVXIACSYekBoAYJrLURvAqBx9QIzbVx++xX3t2rsgq3d8IWcWVTyOaowCkgO/Ow==
X-Received: by 2002:a05:622a:94:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b77d04cad4mr108187601cf.2.1757943781920;
        Mon, 15 Sep 2025 06:43:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f35b41d2esm2595935a12.6.2025.09.15.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:43:01 -0700 (PDT)
Message-ID: <b8d9abc9-47e7-4398-b840-aff1bed96025@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 15:42:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916: Add SDCC resets
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-msm8916-resets-v1-0-a5c705df0c45@linaro.org>
 <20250915-msm8916-resets-v1-3-a5c705df0c45@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250915-msm8916-resets-v1-3-a5c705df0c45@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c817e7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=63aoMBMVQsRI4Mpv6tMA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4_4T2RNDADON5uxpO-a6Av_BJ_4FdhfR
X-Proofpoint-ORIG-GUID: 4_4T2RNDADON5uxpO-a6Av_BJ_4FdhfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX3hKivSwTPf2Z
 sj2WFuGIUpHUQaa6I/qFGq9x579AXtBcoy4t456AFXbb+W14Wi4jIKEd2p1OMeKY+Phg7dGsbCF
 Hrf8isQxRcPFEwnreVNJ/XXEjWP1Puq0YfO6WxaC4JCG+Gs52uizhgQdlyK5nUb8rUzO0qKuFJn
 KbFXWVHDgO/Q6QaGLjyY9ye3/NGVWLVOxgnloKXkUVu7+8CA3HlumaV1QaPxce9XEzoJTuqB01S
 HU/CuHZ1iPhh6Mck2QqUyNl8inRhbpGvCkXLRP0TWN0SiHROAmhA4U/H3p7jG8mHeK9Vm6VJjcv
 lQGObJ6toSEbApFLR1jPwjFHgCdl+100aRuZ9bMRKHrh+hA4KbU9FwCsWO5a4gDB9nDWWAhjgu+
 wdUAu3jT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On 9/15/25 3:28 PM, Stephan Gerhold wrote:
> Add the missing resets for the two SDCC controllers to allow fully
> resetting previous hardware state from the bootloader.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

