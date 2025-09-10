Return-Path: <linux-kernel+bounces-810015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149B4B514A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83647A708A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644DA2D5925;
	Wed, 10 Sep 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvFPZhWa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7D262D14
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501852; cv=none; b=PZCJLYLb4g/Q/fzUYIK7gt9HvDWcW9oDgBtmhblKkMESGpHOTbezPBYWk1uGHSnOFCqa+wR5HtEuZs6UC7H2PK9as85eF4sVMDK2gt/iCv+RmVkGFqE0dYt1roZGpchLCTmD3Vvso8QqOjuDspOOAKKpazHpgiFGzKd2ch/o5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501852; c=relaxed/simple;
	bh=ETY73F/1juZbW7WCW2HFqawiQ2oZ4Ab2w9qPn8AUR8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JeVL6NJ4klETwSq84eeS0sgAzN0VqG9Knr7wk5ekKRxpTymzx2IA5MWpdnZgS/tnv01MAk1xVBM9581/DAOmSbM7K1dPete6b1WP8ZjOm+WCsV5M4lMl2jBScxX+QfXfxXRbJkKLFlVFURSzg612EaGYqxzRn4LBqxkA280ONvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvFPZhWa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFamR032363
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lcfYeUt7GVAfg53FE5BnAJF8/ug/A2SYlkIbbEr5UUU=; b=lvFPZhWaUOLfnZ/6
	iXAPHSGtZbqd76CGVBAtm3Yj1JFF3XoM1WbVrSaOw325d+hiqQjQzDHyDGkxl6f0
	gv8ONfdqlwc6qcPagsY8wwE4n8pNrbuQlHGrXO8o0QAzQB3KZiVRWn5xPvg86rsn
	SE3kUFztYTqpkEYlnG+zQpV5Cc8PRJaw5oTTpT8pmvntYKsU8Rt26H5jErGI0W+R
	nx2HTm7W8ex0O7DXMNQZU7BvmLlMEgvzj5/77SfZkCHocB9YU78Jqj5v9hD7BtLz
	Xz3r3MAIIdkRzVqAbgM1/257bA5Y9GYCvF9vUzzHrY58u0r61XbMm+2R5H1uqLEG
	iaxESA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by93krx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:57:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so7083980b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501848; x=1758106648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcfYeUt7GVAfg53FE5BnAJF8/ug/A2SYlkIbbEr5UUU=;
        b=I5a8slerSFp6KY//iC+ZsAgGNhoYpGtA3PBJq9HFvVEY4b53yMCNevPGtcxLtQsN3j
         Jr4mWgnIJGJHTbnqEmXlo3XLf5olCc7WYT/oa3PzzTxURfAhcHegDRI6Hf5QT106fiV+
         bqyq8z1edDA94h31EJldl2BjwKXqtw6M0eLuDlIX1yof7LnAefAerxXtHx/gSj2oI3AM
         T4e0vyhq+ChhXn6qkqvhn6+AdxhNHgMTwPUoB4FGhxwf8FCkpDhhbgld1BOtJnGJY95a
         rUlRlyE3if3aPjUB2w7Ch0wdBKxiqiUOMRf53L/WTVcp/btaK6enBNDCg3gu05tFe30o
         gAig==
X-Forwarded-Encrypted: i=1; AJvYcCWorXwSX+Q5WVliLEQY5PVMVDgRC2OL7v+xmA1ffv88hz+svZ1GORXDnE1ip2c7DlZoZo0EAmAxsUo35NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYIiakYrCC610eq1SJyH5seFFkz+DPh1I8PRvAgXLfRhfSR5H
	uSlTAIEJRz4YZxMsGxfMZxG71DsS+P+t+q/7GpVwtd2qPofZAO7A0fnjXikmhph5M7+hxmwAeig
	PcwrIc2frQJk1MZ02Fm65SbW1Y1pt482c76p1PuMZC9ZXBZHGaEQ8CksdO5ucdjXr+bA=
X-Gm-Gg: ASbGncsO2Pg35saCJ1ijGWu2PZHmEU9nP7o835bj8aMGEnvCmDBojBrdFWgVhLC6p9U
	8aRZByCtttrbNEag0MKRlIfwDYLEe5j2kksdJFKxdJfaYP1zD9EPEpI9oruNKX3mnw9yscnFLQh
	D7501UIXkj0hPvJzoYQ2/nY8DZc1fC1xnoV7DunT+RbCNAce148hIfwrFURpIyeWXQWwCrW7eNa
	ftzI1GCagLsEvvhEYc3+tSxSZmGkVOK/c12szMVEJ4yAZ5n0VHjp+U19ZLa4GKZ+GGuHs4PxHCn
	AmWEho4E3AzvlHsktjjIjD+JJe6O5VuTr06l8Jle3ogAzOOMOoIxF9gawMMo0h3e1713D9M/OdA
	=
X-Received: by 2002:a05:6a21:6d9e:b0:253:2fae:5287 with SMTP id adf61e73a8af0-2533e18d170mr20798148637.26.1757501848586;
        Wed, 10 Sep 2025 03:57:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAd+1N4v2AfeNoYwFOl+bjuiXGrs3u3rlBpUd9S2XvNr6uBsVx1PO/O6R0zKylE+mie5ldNw==
X-Received: by 2002:a05:6a21:6d9e:b0:253:2fae:5287 with SMTP id adf61e73a8af0-2533e18d170mr20798121637.26.1757501848153;
        Wed, 10 Sep 2025 03:57:28 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775f4976bcasm2333665b3a.100.2025.09.10.03.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 03:57:27 -0700 (PDT)
Message-ID: <d37765f8-2cef-4c15-8423-b82a0fba3b54@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 16:27:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
To: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68c1599a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=x1LqVQa0TBYraXIDtAYA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: haC0PMXtFwWrbxtfGvio6GP_cMGmL2s5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX77MpB7CxYigX
 Pe/BL2assGEY3wLDyiCRLx5vrpl77j1hS9GshIUHbvFslmO6o8GZBtvRFOytcoA7e2bKJM4VIcU
 GRqRHlaZu7lq5I4JC4vWvlR2jJOf3RMq9YEV5DWi5uKnTzXv6ElZX9S2GS/suvoroaRDgzhUD4C
 BIuwUHAW5qw8c6JZUv/4lHzOB5jJFdiRNiw9mXnsw3gg2XwaX6BobR9/YK5/e5+yXjWuJCsaNH9
 E96y0gi6d2Tv+Oc4gHfucVUwzeKdKJANxK8+Wb77AURo3siNjQCK9IYjlG+GsitC4DHwN6ezzw6
 GW2WMFk8QnTTNO07KdrbF4EylzS6bRol5rYjDY3YAzhsQ/PNGDyh5B6XLykUptMQSdvVQIkyBTf
 xYAcsUg7
X-Proofpoint-ORIG-GUID: haC0PMXtFwWrbxtfGvio6GP_cMGmL2s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018



On 9/4/2025 8:01 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The CCI clock has voltage requirements, which need to be described
> through an OPP table.
> 
> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
Typo: 37.5 MHz> (which is a value common across all SoCs), since it's 
not possible to
> reach the required timings with the default 19.2 MHz rate.
> 
> Address both issues by introducing an OPP table and using it to vote
> for the faster rate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
[...]

