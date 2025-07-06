Return-Path: <linux-kernel+bounces-713487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151ACAF5A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D111C22B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4423286420;
	Wed,  2 Jul 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2VCwfGG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C928541F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464983; cv=none; b=TFspmwYhkqI7cAlNnIYVjmbyJ5menBNVJwfxfBOWz/xRAh2wK1Wej7qOnqUfHyZ16r8C0nsnvA24mtRrTNhkAot/Ffm634gFUOOdbM4kkXT07laNpz/sRP7amm70ghcL6ujkhtc1L4YRwLSgapdm5LxSQO7vzxoHJzYPVC7UVOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464983; c=relaxed/simple;
	bh=w9xLP90+ayLc+1sYeBMpVBhY8AdDb/1wgWcz4K04vhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=trniYvCD2j3UUwR4sX7yV1hXyLhVCZRJuMl6YgJUsoKMigo9Fx4vWNx5ypFJKB3GIFL9Ndp4M+s9Qiqp4xPELWErsADL7zVTMQFB8m2tEEdLtz+w7ZBLv7ZfplACZSgDgRbV+hLfe9/LTOTRyFRfP4xpc/Q4h/GP9ohifE5mnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2VCwfGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Da05m007067
	for <linux-kernel@vger.kernel.org>; Wed, 2 Jul 2025 14:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UPCD0AbKy4uQjUrZK3gQh2e0DrRheClUuURBVYRNDDk=; b=N2VCwfGG6NBuKXHl
	QLYieeoIO5cNYNHy0ETMqS/cMpNi53RZpa2PRAYEB9+Xxxzo30D9i77nMXNfdVi4
	2QvdK7Shto7WW0OK4FIyJzp8ik9foWgBgS5uMBdVD4w0GZPpxzmWlbgEUrrhegmf
	FUS9wvDd6kt5dZUEvYxpT/uH7n+0dSPY+2G36CegYyBS+EF3WINN8aVXj+zydmu/
	hT0RxAZiarDcmyXT31LzpK2kfB1gmsXnPpaoKTU2RwLM/JIHMebdC7WeCuy3guU6
	0ixW0EML5rSg9IGyzMTexIj+MN7cJHN/qEiheQAPJjZzhX7Ek4i8OHbFErbn3qgn
	5pQLfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jh8aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 14:03:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d09b74dc4bso148223985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 07:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464978; x=1752069778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPCD0AbKy4uQjUrZK3gQh2e0DrRheClUuURBVYRNDDk=;
        b=Y4Z/Ve1x3yniJA809VarhaDd7a9sastPLlweQteCbkorD2wz2h6Kl1JaAuhnGMfz+0
         Qf8ENXhHwcZxI2EdD0LRkUITc1iylFE0ik0cQMud9QrFHjejSVmO3G+cQ6Grgz0eKn2s
         yZTcdwMfFsw76v9e/NwV1Xv5FDw3sYJitVFDZDO4YqfJGHx51j1V5kxPt7J+lz28Y3mk
         SbuRlDjRRzmen01L6GouArKx+cYvcIT2GqV+oDWHpo6gamSOGHoOAGuDIq742XADmuSy
         yiBNKfItD8LrT3uPkWZ77F13HW6Bgvd1bRiCXCctffaMYhPiMt9pAEoK9VpL1xzFutJU
         m9eA==
X-Forwarded-Encrypted: i=1; AJvYcCXWqE6ylYXKof+KcgVAYWwfbb78Lov6io1K1DwB0mBxQcSlTN+7WiPiOvbB3vW7R+DXtF1w3AI+ZRux8OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNtiwD17XiDPZ/6LwQzPz0N/H9R1nniZSNA5AqyI8pbJTSHvW
	OS2rCAQPiya2z/dlUuyLfOJDE8zr/wp6LDxbcbhXwEFkKldAI4aFcROuGqIfXPtEYUOtq3dZkfu
	/jDTdtDiKtkfWniJ7Up5jaNtc6NBDZPnVgHqyupyE73ri5uywz0vV3SKMMS1XcTNKPLs=
X-Gm-Gg: ASbGncvjcIRWiDQ7gRZvF8zHO9s7G+54SAhaNLOG73r0GnlZAUsIOILs6B0SUhtp4u2
	qTwIIjq8SoFFXxZBbhANB1cIWY6hSdvQAQb53TO/QxdpDsEG2Kzsne32vZnw9W7kxNH3pXN7dfd
	NBeHtkkLkxfhUSVdc8cUcos5HRQJAgFt+bdGdAb0ZxN+sh+bRRklfo0CGJJhXDyS18eWM3DFQJV
	qS8pkcjnvfxAtUThgMF8Dy3GUaVaI1Yjo1A7keDTbKGhamp+CFMq81+RlOFXQa7WPQH1bHl+Caw
	ltspIwZq1wynSpbSvjm9DTvOXzACkKH21Xg5ODlYwbqDy4dx2sTCBZp56daXBhFKoQ2Fha4E5VS
	BuZA=
X-Received: by 2002:a05:620a:6009:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5c4712edamr157508585a.1.1751464978151;
        Wed, 02 Jul 2025 07:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK0NLQr9opky8nQy86TjPixbKtYzWYESdBlrd9f6gMI8n3YCnfEIgoK3ktCcSinV5RnjaizA==
X-Received: by 2002:a05:620a:6009:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5c4712edamr157506685a.1.1751464977525;
        Wed, 02 Jul 2025 07:02:57 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831cd0dbsm9185926a12.58.2025.07.02.07.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:02:56 -0700 (PDT)
Message-ID: <803adfad-a601-4d65-b877-e8ec10969698@oss.qualcomm.com>
Date: Wed, 2 Jul 2025 16:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Be explicit in naming of VPU2 power off
 handlers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250702134227.211104-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250702134227.211104-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=68653c14 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=ORHsN169zhdEUPBzc4IA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eOwDv9lRBTPHA4wLixM4f76TDzDvfviS
X-Proofpoint-GUID: eOwDv9lRBTPHA4wLixM4f76TDzDvfviS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNCBTYWx0ZWRfX+qe/33tujYvB
 i/StdpfU7rTbQTkH52okdJP5FfWbJk4Onwzb68UWRrNO1t02khIiOj0QpeLE7gXrJODRtEpAVin
 jkYjc4HcPD+IXsvv3XJIV6Mr/OsvKL8fN9u9CnoqmdiiklLvEVuZQWa2YNlqf0dWk12PG3BoVWg
 Gx0hm6Qp2q6Rw75tG5HildkziZjCtfNGr0CJMgBTh4RSwlQwKlRqGYYyaN+ExIT4hwXLC5BBqcg
 56UdFrUh7pl83BmBFo3O78wsKw8sVV99E/el11JJc3/4de2+UR2uj0XZo7jMft9Cl7+SZbgtG3r
 htEXHUGT7LFkKQ3UyMtaS4/mYTjK3jJBMap3UnQ5bMnqECAei3HFebFcx7TbTAc6V+o4nhYwDua
 JznZRYWLhQSPqTeQMuCmKOnhMtiPglZo2DZ17BfRdq1Dj2kpdmtQV7YsTpCPxxBuqDpsTbsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020114

On 7/2/25 3:42 PM, Krzysztof Kozlowski wrote:
> Driver implements different callbacks for power off hardware
> (.power_off_hw) and power off controller (.power_off_controller):
> 
>  - iris_vpu_power_off_hw + iris_vpu_power_off_controller,
>  - iris_vpu3_power_off_hardware,
>  - iris_vpu33_power_off_hardware + iris_vpu33_power_off_controller,
> 
> The first group (iris_vpu_power_off_hw() and
> iris_vpu_power_off_controller()) is used on older VPU2 designs but also
> called from newer ones: iris_vpu3_power_off_hardware() calls
> iris_vpu_power_off_controller().
> 
> In the same time there is wrapper iris_vpu_power_off() which calls
> respective callbacks (the VPU2, VPU3 etc).
> 
> Let's make it more obvious which function is a generic wrapper over
> specific VPU/platform callbacks (iris_vpu_power_off()) and which one is
> the callback by adding "2" to callbacks used on VPU2.  No functional
> changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

[...]

> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> index 9b7c9a1495ee..a2c8a1650153 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> @@ -104,7 +104,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
>  	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>  
>  disable_power:
> -	iris_vpu_power_off_hw(core);
> +	iris_vpu2_power_off_hw(core);
>  }
>  
>  static void iris_vpu33_power_off_hardware(struct iris_core *core)
> @@ -142,7 +142,7 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
>  	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
>  
>  disable_power:
> -	iris_vpu_power_off_hw(core);
> +	iris_vpu2_power_off_hw(core);
>  }

I don't really like how v3 calls v2 ops internally.. and there's
nothing really vpu2-specific about what the function does.
Maybe something along the lines of "iris_disable_resources"?

Konrad

