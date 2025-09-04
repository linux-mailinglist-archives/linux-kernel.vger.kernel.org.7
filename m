Return-Path: <linux-kernel+bounces-800292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BFB435DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182CF1BC891B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253B2C0293;
	Thu,  4 Sep 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cyj21BVX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B33596D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975004; cv=none; b=jv35qxN42tzfbajpQ08mQShkuvCcm9QzZsw0BdipUvyJHOrs7l7qldnkwMQbmCGVQDCNxAo0z3cjHZdTxsT7Qan2bxJb811fpaF1MZMD3EXUOWtj6nV4cyyMhSYEPSTUYdruBWNjPSHx4XbGOhcmjFE5J6hWRK7x8bAEAjKGXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975004; c=relaxed/simple;
	bh=wlXLu2i/WQYmekM/QAUNxFzAI8qAFenvyNsA9m4Q1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3JLgs9uiqxw5UXC0WDpbM1FhZISpUm6wiqqeAPBNMrz0bZ3PBWq88qtgPxNrnZBPxc1WQLoHFuMiwZKWXk8GZopTdFrw0iLGrlTWNFuT1+E/9FaLZshAn3gGUMkJ9SNSdBRe49SCsfU2zlHTt7OUzgxvxlClxY3cFNb5YkEZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cyj21BVX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841Pojt005058
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 08:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ob/9EPKXbAlmq/wMeNAH2aKycYOp6bcGcPl57wUYZt4=; b=cyj21BVXV4SsgpDw
	mq3KR6OkubGAtGu16ar7rYRYtUBmKFSUYhUKDOkIKlyqQhNHRTLeKxfASbUHBDxr
	Y/gJA/zaECPwGXO3MXGNbWF6efQpckYMPMcDWkye/0meX9LlOmwcEJOwm1kPkx5P
	lioAugAgFPBZHvmKQUN6SAoNhca+47+ADh+is6aTd7xymm7QoCIvdjZNtOmTORi9
	h5H32XH4D2XBff7iTmWuKWdliulxSFqx2gyA8wA56besVkcs2y2wHtkrvLS2QLur
	WTxRU6HWjH5yZdYcpe8fy3m4NZhRHWWYo4+LX7bv7+5KdIyGsuofXsqBrpNBoSt8
	UUQkGw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s6v0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 08:36:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-726ac3f253dso2703726d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975000; x=1757579800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob/9EPKXbAlmq/wMeNAH2aKycYOp6bcGcPl57wUYZt4=;
        b=V8dx6YC8EseqdMaRCrywn26QoDDerxqFZpwj1ypJv1Bg+qcNBPAQmQoKsVslbT5piS
         fY2QEw0bnxD+4hBf7Pk2XhBH7+ajq/7GS1ovHcjJTetBAhsuYjQAdlSP6acFo3FXc9mx
         50INE6rpjn+mS/k19nXJzyKY9zhYK8m9QAc9Mat+Z0JzbCVL++/Y9sRlS8txJ7Ezlzvq
         gNOMLjsBY5DYBdMAyvuK9BftKqStFvqkDt2Z4n9W9RN6gXZ1wtZ8Du9X37bYBlsl2R+6
         wJ/mPVyvijSn8QHotodQnlV7Yycmez4YidMcinIXgb2BnoVxMv52rJF1qn8zBseoSOUc
         g7wA==
X-Forwarded-Encrypted: i=1; AJvYcCUgnWXYW8c2c0cBFMiJ+JIJ3zn815u+Ctla+3G8iM4CzjnlXIG1nlfBC6EU0Y0R6qHdBQYdFfWQ1Rlx8T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpt4FxjUZXmMtkuGudT6iEfvxO/NcaEqwGyljkgYWV4vt5A/bs
	PHXdqWp4dTi4hMn9yy1vhoOabXU1G8QeA9R//tjqE1HEYMmDjzs4xVsb3g6G4FNfXeoUaPiM/Jq
	qwL/Q3hVq11HdchClP8JeodbjeZF+xNlp7AeEgAb8uXbec5WaDiHYSxYRaytQbum7zTQ=
X-Gm-Gg: ASbGnctbUpKN4VLw9S1mSZzBMjKhY3l3+EAQlilRJbPkCVs8WOuGK5SpiOLKYPxcIyY
	yco9rrf3SQO5UAwbxC+/6B5xEiL1InmPV90oXyPU7h2V2L5Y68tU6Si2uLQzQxqwczJIPjFhvA0
	U6HoWiHNbarmiiw6mDTME8zQ5udhHJKsQBMmdI7c4z0L9Jfond5CWlqdoL88RUCaoXM+49qdpuW
	73t5QgTGeveHZNyECphxQCGIFTz9NC3L6LG6hF/WEnuWk1uygQXQ8iMByzXkzlJa3OVYEV7PA7F
	WhsBjkM8W2Wm0VI20e09jWDiuA0nAN6JS3QP+7C9VyU0cQMnbayOoDUkLL4gc9/Kj36oqgLSrXk
	sb/X0oKPYAVKeLDljFq6PkA==
X-Received: by 2002:a05:6214:5006:b0:723:dfda:4da9 with SMTP id 6a1803df08f44-723dfda4ef2mr40388336d6.5.1756975000333;
        Thu, 04 Sep 2025 01:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvAsFu4ylylSfq9/uyfJ4vjffVIaIc5Agek8eq9JOpd99sdw5nqzrfMbFYkou3AOlz1I8NHQ==
X-Received: by 2002:a05:6214:5006:b0:723:dfda:4da9 with SMTP id 6a1803df08f44-723dfda4ef2mr40387986d6.5.1756974999549;
        Thu, 04 Sep 2025 01:36:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c77d0sm13953740a12.11.2025.09.04.01.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 01:36:38 -0700 (PDT)
Message-ID: <be87fb2f-7036-4039-8ba2-63d54a9ae732@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 10:36:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] arm64: dts: qcom: sm8550: Add max-sd-hs-hz
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20250903080404.3260135-1-quic_sartgarg@quicinc.com>
 <20250903080404.3260135-5-quic_sartgarg@quicinc.com>
 <6deac56f-e21a-4447-bfa7-a414084676b8@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6deac56f-e21a-4447-bfa7-a414084676b8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXz+4Da+jycORP
 5ucc/9Y+yabId9gDLCfJxE0xQ1haqK7aoCand2nfbWTTKqowV4CFODoNF/VNnLTMtag5evDE8pp
 rF7W9H3zWUhWo41K3iMbZur4wt+QByqxeTPJRewut5NMFee2H0bWrIm0XvuWN46cHv6U4BnNMiT
 SR+2HCjVKO7iBv+tSpFiXN5RisEsqNyXkcqnctuCYule8PiZoVLepTFeTVShn6UBWg+JjllxxUQ
 ZuR5s3ZDZW2yAx88MGKrVFmUYun+n5VBSsUTROPxkDMjN52ZXt0oxW98iejyzDcICRoj22MqMKz
 x+RMJRXXH3eIn+WC3tcYpY2ifWUCxtOq6p7A0BumwX5n+jOKWp6+9r3ZCpKVzGPHJLxhxMIo+HS
 pRFWUISf
X-Proofpoint-GUID: vcpUBfq92qWmrHh1_bnlYTxoguu_ltda
X-Proofpoint-ORIG-GUID: vcpUBfq92qWmrHh1_bnlYTxoguu_ltda
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b94f99 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yp4Pn_RnPQDUuFz1ZG8A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/3/25 10:21 AM, 'Krzysztof Kozlowski' via kernel wrote:
> On 03/09/2025 10:04, Sarthak Garg wrote:
>> Due to board-specific hardware constraints particularly related
>> to level shifter in this case the maximum frequency for SD High-Speed
>> (HS) mode must be limited to 37.5 MHz to ensure reliable operation of SD
>> card in HS mode.
>>
>> This is achieved by introducing the `max-sd-hs-hz` property in the
>> device tree, allowing the controller to operate within safe frequency
>> limits for HS mode.
>>
> 
> Probably we will now replicate the same discussion... And it will be
> happening every time you send the same and not reflect it in commit msg.
> 
> Bindings say board setup, this commit msg says board config, but the
> patch says SoC. This is not correct.

Both are correct, looking at the problem from two perspectives.

The bindings description mentions board-specific limitations (e.g. because
"the board's electrical design does not allow one to achieve the full rated
frequency that the SoC can otherwise do, in a stable way")

Here the author tries to argue that almost all SM8550 boards are broken
in this sense, because the reference design did not feature the required
passive components, making most (derivative) designs sort of "broken by
default" - and only some (if any?) vendors decided to go with the
additional components required to lift this limitation.

This in turn makes it fair to assume the developer experience would benefit
from having the SD card high speed modes always work (with the slight speed
cap which may not be required for the 1 or 2 designs that took the extra
step) without each board DT creator having to track down this property
separately.

Konrad

