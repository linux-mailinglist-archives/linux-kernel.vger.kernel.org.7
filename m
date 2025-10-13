Return-Path: <linux-kernel+bounces-850778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C326BD3B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C2EA4F7AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F3309DB4;
	Mon, 13 Oct 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOdC+aq/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F803093C9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366795; cv=none; b=kX48sYdjE15EcUbPd3cdT2Kta0P2XSky6Foja2fWKVSGbGg6xJlBtNw55N3dO77kqoTc4ktkUkU2LWSKgPziYKYYtQamabP2AMG5kmx9LD3ZimRVk/uV50QpYlnROQCCEkicetTW+kfjT0zCRawJL616hH5MOl5gOl1tR+Un/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366795; c=relaxed/simple;
	bh=Baafv0dkbATo2Vjt7gb2iGQKBDq/hh7OJ4ohJRpLxVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVWVsye26u2BmJGWIgy8bJOKChVq/xuX/XusyA2FpEUDL9S2YMDvy9SWEIqCsWh1IuZW1J13q2zE1e5fQknXdyeEoVCcFwRROlUnXDaCxi32tgmrb+UAoYF/NJTjP6/jM5S84c4HXLv4rVTpu2mCKQVSZn8fgSDKFLMZKa/TtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOdC+aq/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DAkAI5001858
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Baafv0dkbATo2Vjt7gb2iGQKBDq/hh7OJ4ohJRpLxVE=; b=KOdC+aq/Nmh8Alt3
	hMaeHSfF3b7DKH/A85WEszhDu7c6cVFkQdzL73AuC/zJbAj4lDXiAL5c9wvC6Qjy
	rOIvMIpC2IDLaNhHAM/HiCWPn2KCbrz7iIu6oY/Y9LrqpCguvuM69/tV0Lu8jTtr
	9Nfc6DMG2yN9Vj/OraxUAmVSDVnUZ63tKDhXzKsN7f8a/8KVFOUk99LKsSl3NH8L
	V6WEHlKFnb4t53weTrwxIjhjxsmgPYIh88r2TN+Q9AtOgegmGok0Wb3iI4peboTo
	AQvQx8Nsqe+8WSbrZ26cUNaXjk/z9fh03w7cOOHhCz+x4+/I7kcjXPo/NU6pOCC8
	BCP6xw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8w1va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:46:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6097ca315bso13172812a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366792; x=1760971592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Baafv0dkbATo2Vjt7gb2iGQKBDq/hh7OJ4ohJRpLxVE=;
        b=AISIUkv9LeqrRzAHWIOFCJwLFiapGUDU6a1Ar0synY+CCJBmgf7gDb1K/TWKbChQ5r
         FMOFNnKzRb50N51EGgQkayuoPSDhfTNi89uV2Gw93I2IpL5IZGN3bTh0yqgtPVtaLg0E
         M8OO0scTLDoqmw5l5wnyiBffhn0Cg9catkugx/PpI9fG7t5UsxEed8G3XgzbrbnkrzeP
         v6EE7cBSJc1fmkqUWdykfRrbtFrzF5eKaRun7C9LhNmfRgbOc4q6fqB3YRwhZJxbfOsP
         kFrfdK9fZ3BVllwOA2Fo0mkhFybdCnLpkoEaecXqDEGyn8laM6sRt9UpNt0JKtD0A7hP
         Ddrg==
X-Forwarded-Encrypted: i=1; AJvYcCVwi1bhSBfEMwTHWeCR5dkriCdSKrJ6ObiKP5mkxCeBgZ1ZhuHr+mXy0ix+pIwaD4Mmhtjfvbolh7qcL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBe74f9illL/4Vdi+Nv4LRnMwkCRQ2TtDR1Pcua1PMVY4C0o7
	iBybvXCwMIygUr/+07MbJjq6oBeIhZot2A9sy94z8E4tSJHYByYB9YkO5VjpgQynBVhu6l6E8+E
	GKdMLZm3VbXUXRDr4iTYp2sEy/y+gF87SLZ43PbTBdXk2kNjK7YFqluCsfF1FfyD25U4=
X-Gm-Gg: ASbGnctx6uXs7LMALm6z2dJs2PuHTNgJJqgmTUoIcr9JwxWE/+ATovQyN1FITT14d/n
	LpalhDNuzU1kXoN+kiysWsQwnh5hoRAZpTewADoOumY/taPSScWgR/vf1VNd/E2LODCTVadqblT
	jNCWc77Rx/zC2YAdcRFgUe770yRPIFwgIXUUuBNJzt5Ja+25ExqwoPL7hwUDThefsm8e1MIE/ui
	re5JE6o2G92ayF2V5N0nDgvqU8SAGyko27A3qlUoDdambAWeszoWMDABoMr+DDjgQJGSJyJRSva
	h5Sl+h6Jpr47PlDjsG6QuSzT6pqGl6EyxtQ1yHAjSVWcwFoF1Oh5XoAzHI6kZj4SJYKDaT7n+w=
	=
X-Received: by 2002:a05:6a20:7490:b0:2e9:d6ce:e125 with SMTP id adf61e73a8af0-32da80ee0aemr28439805637.5.1760366791949;
        Mon, 13 Oct 2025 07:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsp2b2NHE9jGWw3Rw9mQwSkk8mHNUW9ttGhh+qp/1gDWG2urxuMKeyyd0PiKH8o9pWOalrXQ==
X-Received: by 2002:a05:6a20:7490:b0:2e9:d6ce:e125 with SMTP id adf61e73a8af0-32da80ee0aemr28439756637.5.1760366791441;
        Mon, 13 Oct 2025 07:46:31 -0700 (PDT)
Received: from [10.219.49.211] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0964c1sm11703138b3a.54.2025.10.13.07.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 07:46:30 -0700 (PDT)
Message-ID: <1d2aba24-f73d-4b60-ab8f-1c9d9bc775ff@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 20:16:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ASoC: dt-bindings: qcom: Add Kaanapali LPASS macro
 codecs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, jingyi.wang@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20251009143644.3296208-1-prasad.kumpatla@oss.qualcomm.com>
 <20251009143644.3296208-6-prasad.kumpatla@oss.qualcomm.com>
 <28de0f76-24eb-4033-a1fb-20415cfb8d82@kernel.org>
Content-Language: en-US
From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
In-Reply-To: <28de0f76-24eb-4033-a1fb-20415cfb8d82@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3PGLCrYti5SrvqELiFi8ijn2kA9rXwtA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwUtHjVhM7Gx1
 3RuzLd/7X/KJjobdgzjKhaBiW4vyyDGk+Djz2ZJVckoHO3Z/mIy/SS/VhlA5vhM/j/Uc3NBMY6l
 roiZNIUwT1EP3eJQZG28HSP9PxWNNLOXMOVt6vfNc8L3kXSjqxSzvEGjcgDXJJoNIlBCxksKg5M
 dJtsvjOXsCuh+9AjeZXSkGH8uu1t816w/p/MZoc+/rqeLpAHoI55ATE++KohrpKcrgp0Y6TivcR
 U+v9yc9ITCAlvTUE7Wskjz4joaEe3ufE8rt6yI+Fv9cQfvFiXxIiFJFrX8w7n8DUDzSLB8GiNd4
 0uGMlr5V/TVOIk2+M4GYbG8LZ7EDgnjZIcFiZWekLj8+wYVDDbKS7kn2n9aKLGFbguGSexxa+2O
 Ksp9gbhIfphVQrarHoGXEnQw6fym+A==
X-Proofpoint-GUID: 3PGLCrYti5SrvqELiFi8ijn2kA9rXwtA
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ed10c8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=-bz6CWZUwYRBO4YHzmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/10/2025 5:54 AM, Krzysztof Kozlowski wrote:
> On 09/10/2025 23:36, Prasad Kumpatla wrote:
>> Add bindings for Qualcomm Kaanapali (LPASS) RX, TX, VA and WSA
>> macro codecs, which is likely compatible with earlier SM8550.
>>
>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>
> Now it is incorrect SoB chain.
>
> Please start using b4 - v1 was sent with b4, so I do not understand why
> now changing this.
Sure,  let me send new patch with b4.

Thanks,
Prasad
>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

