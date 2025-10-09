Return-Path: <linux-kernel+bounces-846804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD1BC915C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958563AE2F9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96C2E2DFA;
	Thu,  9 Oct 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSLn1sWS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478602E2845
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013686; cv=none; b=buTmBWdy1CpBJ0NHw9IMpIiOxNzSGXmkjCaXkHmMhuo5E9Av+CcnVU7YEopru8wIgxI0sjrqanCIfKYMBkqx4dZKu3jUuyAIN76SbaQsecTBuNlXt0rJve2FrbNAZYDEQM9DVobmlbjQAR/ugjDIL6njjgpYPzwYC60cWvQsamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013686; c=relaxed/simple;
	bh=X1oa2Opgwt86ZgTlAHfUOPHzjmWzARhbTh2OGEMTJFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jS0eWKljf20oAk2WPJ3ZMmAwWAXqYljSTHt/PO43ne1cG4A6uU+UglfCaz0EWy6hOUw7OO1/BZWR/yQE9ICTOgLJIcaNQIiuP8rja2nqXAcGejIx+ehkTOmclFpTEw6nGYOWrE5BN7Dy853SDHCcvpJI8J4am1gaT6GwMpKEb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSLn1sWS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996FS7g006842
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 12:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZTbeb8JtSoGShn4747twCq9ITGkpUoqhfkcNYUr82qo=; b=SSLn1sWSmfpL2OgU
	0658n3ll29JfHEgDaZTbbF1a5zmen66CZ2rVGdfnBJ/kz9lMDcEMjX4ziuZjTUbi
	mL0XXowkItiB3TVJfzUPaOsQiAL/SRJ/qPt/ir3fOEBABQwLZv1ZSixeJwSxdfx0
	dqGijEtlLIFtNEm+kb4f1iMROLZ9Xs+hhr48FRLzLaA6FPC9CjBjdA3VS1Vy9hjc
	vRKDv0eSshuDhmKjeVafoSUZ6dnq8ZBIg5VAdcFtGEa633NQ7RtSC6CqqXlgBMcn
	5SnNXGs2bIapB52aAfzY4q0DLwFtc8UXVXg/a+dNT7RyIAsscqrocMpZf5w8NK3r
	8wlpVQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u2sqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:41:24 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4deb3bf6b2dso2611991cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013683; x=1760618483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTbeb8JtSoGShn4747twCq9ITGkpUoqhfkcNYUr82qo=;
        b=dmfrMPlRLT9zopQJgAIY6R6QOezpTVxPzA9ZL5EbpInV1E/uwxlwaGDnMuO1nqmY5O
         IDS7QgxVZo9XSQgDetpEZI3MIV/7W7r9HAaSqekeWy2LIddRbolbpdq6rzPHiCTSKcqD
         Sds9zFpd+y9cjMEca7PAdZGaFObKHqMUTrefZGgh58DT2Pmhwr5a6tIvj69BhcygehUw
         DRAWnZcYRYzz1e97Zn6hN5Ob3ggPzycfJoz0D2qlLAvIftFIPsvAKWP9iuH8Ts+X8B8j
         NAGObnmsrEek1KmLx1enJ8rodI8v4zF7WY1gir3bY9jeCo5jaYjHzJbhSB11Bsk9wFR2
         fGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbCk88x27C7CVipfKw/uW03vWxzwRISOiDLownHHNISl/Bad7QQvzMRsLkVT/Tm3oJb6T6r8RUk0iHdsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCd92MBKkHLICZheX3TUVOuZKA3MMwBAODUsxjq5HWaBBJAafX
	tjJZVIqqtcf4bHPqZF1Ojt2x3xf2+iuI1DMOwsXU/xqGD0m36VVqB5OhRVVP4g5MKSKRmRx/1JO
	DYohJmoDAx2gE8t9dhuUJuwIFwZ9AwOG67DtAX5JMHTNnUBuSgjTMZ2yhmuZVTahRyng=
X-Gm-Gg: ASbGnctwfqDUfTcC1G24XQfU2qw42f+6m4WGZ2HgoeBH1IbQuM2MB+dbZuM9mMhTHH0
	5NOxQFHrrSC5ooFjo+o265LyDkUSli5vKa7ZTVBW/j64zkUwVS7Ii6gxa4rfb/R5ezWC4w0vdX1
	s8WKzLJfL9JK8Y5i41B2cqPI3zqzPUEmrrLMDvha0uJ7aDc7dZfnMFQNP84d28FtjTa3+iqLQ1F
	WS1S9mXkV6nVL6hxQno1MCEix9t+P74SKF8DTZops3F5uokVgKqF7LHAgxtdTnUqeHl1DirTVf2
	n/rMFATzL9qum9lxEgPfqLsJiplY8RN4ZbRhl2brEkzREypEoXAcELy7jiJf27e0t5gnW7BFu2M
	iTDm+0ib76UpCGc+yZz4JhP2tKE4=
X-Received: by 2002:a05:622a:14ce:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4e6ead2c674mr63640401cf.9.1760013683188;
        Thu, 09 Oct 2025 05:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8vZzBR/cCVwVs93I5MExBLM2zASHRyGAJj8t92r2vWzVp2okk/WgeWQ+4wqfpf0OQhTpPRA==
X-Received: by 2002:a05:622a:14ce:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4e6ead2c674mr63640071cf.9.1760013682606;
        Thu, 09 Oct 2025 05:41:22 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4c83adec08sm1189038366b.56.2025.10.09.05.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 05:41:22 -0700 (PDT)
Message-ID: <6ede6425-6b99-4505-a231-de819bab9ada@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 14:41:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
To: Jingzhou Zhu <newwheatzjz@zohomail.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251008130052.11427-1-newwheatzjz@zohomail.com>
 <20251008130052.11427-3-newwheatzjz@zohomail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008130052.11427-3-newwheatzjz@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e7ad74 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=l4nIPSqNMi1mnKGloYcA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: arKmed7tTipE8mxvRpaOxqCmgFdj-muQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwYjUDKdSDLGR
 x7e3fDpIi+culuZvSyBaYmk7CvTPBNQSxDVV/5fLowe1ITXnJfSCJct3BxjehdC50z+CtjKud++
 vl9TBnen5KredaaenTvJJwodAr/Y02aQobh7fIvYoIfT0Cn4WTc3IkwtuRN5oyi8ODmLsAtQBBR
 p8f/jpexQi8W6yMeSbEL/Viop5vdy8PVAngItov3tXpnb7NhnTN9ZQn8pGGPEq9C8Zzwn5j7b08
 KeXt/Ocf8dRAheuzUfUsnGz8l1Do12h0uc7yb0p6r9b6wY86rj0TRy8yvPlNbC+JxjWlasxiRvX
 Q65vNnLoDCbgPmGvBttvnFP4IVUx9Mv/4xn/N9yO3mNouXiqu9GDk3ouC7j0tgvixhAUJ5VY8U5
 /Na3Jdunnt3MIkR70cSlSVxyjO5ILg==
X-Proofpoint-ORIG-GUID: arKmed7tTipE8mxvRpaOxqCmgFdj-muQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 3:00 PM, Jingzhou Zhu wrote:
> Add device tree for Huawei MateBook E 2019, which is a 2-in-1 tablet based
> on Qualcomm's sdm850 platform.
> 
> Supported features:
>  - ADSP, CDSP and SLPI
>  - Volume Key
>  - Power Key
>  - Tablet Mode Switching
>  - Display
>  - Touchscreen
>  - Stylus
>  - WiFi [1]
>  - Bluetooth [2]
>  - GPU
>  - USB
>  - Keyboard
>  - Touchpad
>  - UFS
>  - SD Card
>  - Audio (right internal mic and headphone mic not working)
>  - Mobile Network

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

