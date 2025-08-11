Return-Path: <linux-kernel+bounces-762484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E7EB2075F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B6F3B3FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E5B2BF00A;
	Mon, 11 Aug 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BwaX5EH/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD72BEC57
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911134; cv=none; b=S55IqHKqQdgzmowSGO/sC6FypWChnqC74QelwaOviU7WbErTBMuhyuXpyobsW9aNaAkJ7kogz3nRzRxtjdS3BE8/y2wzYNE6eyuhNl5Bw/in/qKnBMk7+kgbQ4v20eKun+qyx6rNBPEk27F6PKQZG2SOcZoIiX5qt3xmIthLVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911134; c=relaxed/simple;
	bh=7qGIv2VMmoh53/xPrZ93lE5MyP7wZkaBAOl0Dkqa0Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZ3Ufp+qFCq1JmzxYp24NohEEKJNhz8k7D+84psLcvoW9JyARfl6qEUL5oyMtsIJBf3SQR9THwLRJaY8QXQkDwZGu6vvi+l2Ff3nZL+OX94hPcHVaoz5LzesNv5cJ0KtD07oaOjEngFTK/XA8AVTBqf76Ue69husV9iGK2y5WKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BwaX5EH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCOm021620
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zSz6n6RvfTQOfYt/pcVGk94yjTXS1qFmv6HDJ4iF3Wo=; b=BwaX5EH/9h7AZl+H
	GcfeI6p1RaaUQOd2Vz8pY/6KKqSrkrlUqi7r4va89isjWvnfFzuNvceYy/LaF+He
	loZ3Xjl0zQQaOPr8DVBiYX34AhS1DT8xiV2nOiM+uMIavrJxJG4hlUs9aqOA7Pud
	nj65I8ncZb6EsGWwP1N5Lebq0f9AlYLdrK4hQolAa22sbKpzsDrCb3lEIHKfG08e
	LuBPDDi1VA3zEs5kwm8niClQWvKVEbOAg9oYtQTY5aLdo7AR2LcGkqLhfShjK4x6
	G5W/Oq9Vip6tQMh3oEU2nlIIIAtDcBQdTM7uqW2G4HhXo7l+1DiPudw3+MdBa/KN
	Th2ASw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxj445ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:18:52 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-30c66d2d64dso542406fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911131; x=1755515931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSz6n6RvfTQOfYt/pcVGk94yjTXS1qFmv6HDJ4iF3Wo=;
        b=vAoqsl3Wlr0ogWvCcqFjpQmLk+iiHqZ0Ycxu9W2UoMbCDAw+5p6tKyPSqoV3NGNyUn
         zWdqjpFvRg4Kw3RI1XijV+OEFTJV1vzuYN4H+DQxNhF1kZCo0n4H8HwE6aRJp8EmqfA3
         eRfhhPsE2mKG60AzHDh+Dv/QMqoNytHaeNhqiGLVx4ayHDMwC8gnLa8lFMzpK9HOF2UP
         FNyQxlRlSJ2nr8Sb0l1nogHNyQeZ58teTLguxAFbBrKU6zW2+CHKyAbLwdvuQrjjQR37
         DlDlK9QjBXjMNPkamEOW5lo8gTxbZpTEFdSCzq2DqUqhG7WL8hefTqGfYfwfe/wrbY5x
         Yuwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgTyEtz/HzyDdVQClXojC1aoSNfoy8trehlHgqyKBnUWFvA4WBjSc5ZsGu3IdsG5wZxhaiBnvt4msmj1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28HCPBmaX/pKMGXEwQ2n2ksR6YdfluKb/8edIgziQE1RFQTIn
	Imo374D3tLhpE5zio3BjRGu0Ju+nAhHA1uArXR8v0mn82fOaANT34gvf1KFOUWZmgtd6g6XTzga
	t+wdriv6qXL1UZS6Nsem+AqQ/VjRe+fWw9LY2DlA0OvIIj6LnF+E54AyPxLMbKbYoNxg=
X-Gm-Gg: ASbGnct5j9oX8GGd9ymy0bVHMo0F8QLMtyoffBj4Lv6dfqowWbIiF8jp+0ZRngd9JOc
	zz/krSpFdgMKWZi6bv/z6EbaImuSxFxDfoeIbzZOXAGjbXBjosf5oKodADnpoUgL4UVFeSD6nck
	hSrWzxaJ2jM5r46s0tT9S6RkBP83nVYEfD2jFzZcKXwE1e1b11s5r1P+9M+aUAH+4/QWMhKAWD8
	t5OnbmQEfHs81FkwMyqv4td3oFVNwedaJ7rO0DdwWWyYwDxIOoeQxBGrAyiQEmU4xAGk7ubxpDQ
	YvDjvntW0aNAK77sVtPBbZJCKVSsNA7GK5vf99MOYdVQqzEup+cOMQfLxJsYnKkg0xKyrHVP3oU
	ee1aJ7ceg4Svr7xWMNw==
X-Received: by 2002:a05:622a:4387:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4b0da992a42mr19224051cf.13.1754910418663;
        Mon, 11 Aug 2025 04:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHezk0S2+X+438LvPdPc+q9fDLwWz5D27Izg9g5C7RUB21t8vXyV84fmt0GHdVE3MsjAtpv+w==
X-Received: by 2002:a05:622a:4387:b0:4ab:5ac3:1347 with SMTP id d75a77b69052e-4b0da992a42mr19223821cf.13.1754910418142;
        Mon, 11 Aug 2025 04:06:58 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24370asm2000917966b.128.2025.08.11.04.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:06:57 -0700 (PDT)
Message-ID: <53644b36-2eff-4b1c-9886-591afee8b589@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc7280: Add nsessions property
 for adsp
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ling Xu <quic_lxu5@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701084905.872519-1-quic_lxu5@quicinc.com>
 <20250701084905.872519-3-quic_lxu5@quicinc.com>
 <nsdj4ytpdn55mn5l2gr23w4whpbt2ogxbaomimqoarvskz3uzs@5mbrq7jvxnp2>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <nsdj4ytpdn55mn5l2gr23w4whpbt2ogxbaomimqoarvskz3uzs@5mbrq7jvxnp2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNyBTYWx0ZWRfX4lFYIRbHIlrL
 UA5JbOijmFxHTd+dWw+n4Vs/+ftpw3TpGEZXh3y8hTBqIrsfvUEL7J4NwZ+VqWrvv9PIA8mBjVI
 9S2kp77T/bZ9Gec/7VZdC/z1DSJ/0Zg6RXW8rHxyGo+fBJpt4WKZYH6WkmqtAO+09uJzaCO697y
 2nutOAVyV8SR3uUbINKJBAtrSg/xidSjfRxadCiI8BJg4+KZG5F6tFw8D81EgF/Or8ZYRyRI2om
 ooxG1e2Z8DvXsOaMgVSi+bV38LlfvzJOQr2IdzP0954gRQgUfHxd3g1yFnO8gQ0PdhkQhsXnHfu
 mg5AXwK/ZEQ0Fzw/iZg9fXlBorG7C2Uc3p1Toqz6D7FlX957fxq4jEOnjmAC8iZzqOwXldj0dVU
 DxUapRPg
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=6899d19c cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=z0GXuPKBCmORgo7IezoA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: ME37UB5uxGmKgdtWcSwwTfJFMAaS7McD
X-Proofpoint-GUID: ME37UB5uxGmKgdtWcSwwTfJFMAaS7McD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090027

On 8/11/25 12:42 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 01, 2025 at 02:19:05PM +0530, Ling Xu wrote:
>> Add nsessions property for adsp context bank to make sessions
>> available for ADSP offload.
> 
> - Describe the problem, describe _how_ the commit solves it.

This is pure software configuration, the only real limitation is that
the total amount of sessions per channel can't exceed 14 (because our
driver says so? I have conflicting information where this number comes
from), but no more than 5 is recommended for optimal performance

I'd rather waste a couple of bytes and pre-alloc the maximum amount on
every channel, so that if someone decides they want to use the DSPs ever
so slightly differently, they don't have to run around changing the DT..

Konrad

