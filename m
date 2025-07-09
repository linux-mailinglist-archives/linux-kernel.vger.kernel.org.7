Return-Path: <linux-kernel+bounces-724249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EAAFF06E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98083189E656
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76492235055;
	Wed,  9 Jul 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VkHrX/iB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADE233735
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084283; cv=none; b=skNyQ7yXANZQh8ipQVrFgjwh61oiYqm6J+a0GPksIDYNJJA/FJVGgmB9WbnDoQi/AdzINMSyJLAzURyF97RoEtPnBxhph6wj2cFJ0zMewK3w05bbYBgY1DANMeAOzmNYuULx4FZFI0tS3cxGZ+ZRmcg8ZkJeeXo40HvK0a3Slcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084283; c=relaxed/simple;
	bh=BwEHDnFF8g9BwbRZ7s5wgYOhw4vNQlfGkcQ79zkRIZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLVt8NIT9JrjNtOxQhqPamv8evARgf5Y+sJJSWo2ZQVAgeZNXIne6ISsxXArWXGpLlKcC5ob3rtOHlid6cVpx2aP52XNzMTdxnP2ZSz20gTchJkQAO4UuIwSyKHtvcltJByacVP4fQSurRrjNLTlaH/7AfNsC9bq5QkMYoJCjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VkHrX/iB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CohD5012482
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 18:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A2ietRUbMDbJ4mE4kCJF5gt9v+ZI/BJHpjh+AfLfssc=; b=VkHrX/iB1owUSxld
	0k+fbo6IcOvwtEYGSSRlKjHpAinC0RiWd73EPPUC6SOM4iBvvYejo9Hir/sSs1M+
	BimAHnZ5h1Bm7K6EukFdGpofuYt4/4mVpL2Pvk1zuKqdOPMAEA0hUXCuPSLOmkJI
	uxhP+dVMdAmPY42H33WwyFKvhLTjLI7hykoi46pR/kn5Hgzte68IRcBVaBSbbEgM
	cHTfSuCq3FFJOsKCluYO73ZuMuweN68F4RZKBYnZjt9JHLQRIPG83VqGx6D6sB7x
	NYtuDq+MO3CE2+WCNg0do2owYKfya9Fs8n2UT5JIvD2kgG7SZnFYVVqX1VOzqctq
	+OrFUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn5krg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 18:04:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7dbce38d456so3113885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084280; x=1752689080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2ietRUbMDbJ4mE4kCJF5gt9v+ZI/BJHpjh+AfLfssc=;
        b=cKeSArKNg22wK4jjJHg+0+gS3o5b6LwO1ZFGwBV2Juk1tUrkxbmPJO/iBqWjzo9WF9
         plcG3auCiiWpkTJp6co31e0cz+hJ8CirS1Qqzt5d4cO/YUTW0RkDNUUo3rBzxOG6M55f
         bMe5qPezC47VtYNrO57SliqzbII34P6IkhCLBgiUQ1sWql0uWr/oYd+ONhvrKtTi3/Qq
         nL1AfGdb6aLqC1h0KQAAUf6eFd1mWsRfGTbwjJ5CkAul2Cs4QBrbFdACwyFt6gft/dQf
         fgteXGon14ExSEuPg7B0El6cQeJMwGQ1Y4EBp7gyHo8ifkz3cVd+xjUmcFhNQS5Et7cH
         iUzw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ncrGCwPU/FzLG94KpMduSVgN/L9GV1/BtuHorYU6SSQF73F3q9Te2ZBnS+xkfoL0XsdlTcKX6XD7z+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WTQF9jXv1aI7mzgBK7z4W5ry65n3LM/SsrxqBqJ2NBhD9OSA
	LMNZGvughhr/g9XTrTKwB1wxG0h/oqXAVOqVx27DCSpkX0g4svUE3nrmGt0SyFQVE1yDzKtMKrD
	zfV6oUKqtrqA8fS1njkrTP7K0amGF788DqbXCOEs6lFbs+1/IL81QiuY3voOQDBM2Kq4=
X-Gm-Gg: ASbGncsMwOkyyKRzV9DBTwwwE7dm9vQmL2nZaaWYASfgtAuR1sJW3lVkEenh7EubD76
	GN36PXQHMMrRoiS4nj+EktvwrLO018P25+b65xkUPKKWH9ZTU8TAuzvOTcpUnXH/hWEn+G8uJAw
	lCUEcaQ1htU0jh/UkfNqszPD2xaEJnWbcXxVCOeHz1+9V2GUCPyElwb5T24vY9c41rh0IjTJrfF
	rIAhrXc5PKWXDApjpgcJ4O/wJ0eo8CRYTParVJkNyWOHq1qoej0ZufvuUbFw6swdbJVTvYVY88h
	DhiX3C555Led8H0j29GYOjJ5ojrp/byf8q5oQWykz7S0GMWUkgBaRe4u1tyWtcMosUx6o5FyXwh
	M+VM=
X-Received: by 2002:a05:620a:2681:b0:7db:3fbc:d71f with SMTP id af79cd13be357-7db8b3307c8mr183721685a.0.1752084279992;
        Wed, 09 Jul 2025 11:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRdyICFCZxRrKtqyaPtAi/LxAqDz5IEHfkpkf3qpn9haIG2NUFS9hpsW2SKi6yjsOjwAtEOw==
X-Received: by 2002:a05:620a:2681:b0:7db:3fbc:d71f with SMTP id af79cd13be357-7db8b3307c8mr183718485a.0.1752084279403;
        Wed, 09 Jul 2025 11:04:39 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692f555sm1156700766b.60.2025.07.09.11.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:04:38 -0700 (PDT)
Message-ID: <256e01fc-fdba-4006-be8b-236fbbdf9f25@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 20:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] pinctrl: qcom: add infrastructure for marking
 pin functions as GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-10-b6135149c0d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250709-pinctrl-gpio-pinfuncs-v2-10-b6135149c0d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686eaf39 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=NA2ShB3TTlD8ZNnRZVMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: wsI6AQA8OTvbzixIlvjQkx0oMeRMQFHv
X-Proofpoint-ORIG-GUID: wsI6AQA8OTvbzixIlvjQkx0oMeRMQFHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2MyBTYWx0ZWRfXxEtQaAofC8TU
 ChbQ8mlAyw31qKBGAs7rsCPANZPkAvfQP1Wmf2J++ehe/iPXv6goIv7BtVIj7ZzOkmwa+SwysSg
 aPAfMVYCGsV794+czmJ7MfFjZeyrdintlApJ5YyG4UFB0HnI5OwalGNlfhR0Zi1PM/UuL4EOUIb
 ReWqzx0kmftM0w2BRvySl5zV9MFboFrM8FASTelHrsCaN24mWr9zNfyfZ6CpHDx8Zp2NRLTkmez
 +5NOA6QcwFKp5m4bwL9YjGR9LQbuPXWXnGkVtbrnG++atxB0+lXZO9pSVDDjwO0e2Nqy3GLlqBu
 vIHMSHvgBBVvWGZJ1UWyBVkgQ3i2yF+RqchU61DQicLkOL1Z4FVSn+Y9QMCoxAVbIN37VtIeVJo
 OAHcG/Ok4qIc8FV45fYcxnnpk7A7SO4DW7oNlHFsHoK+jU9Q5lmiXxMC2nukvi+ChSqkHfQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090163

On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a helper macro that wraps PINCTRL_GPIO_PINFUNCTION() for pinctrl-msm
> pin functions and assign the .function_is_gpio() callback in pinmux_ops.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

