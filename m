Return-Path: <linux-kernel+bounces-837619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601FBACC66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19E77AA3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C22F9987;
	Tue, 30 Sep 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaoRTpuk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE52D29A9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234007; cv=none; b=IUzm5W8Kaw0Ki3SZXY+MQD2J+5r/UW5h357MNtNSh+Z71gEfvUuYYw8JXqj1dmKkJYI8+5e0njogkAZRZVeNyp9k/h0BkOm0wv0fptuokhjnSEaA0oswwZbeHDGS9/uW7zYMCeLeHXo6c5tEFn2sDak3/v9BSuxTxEbbAtNgdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234007; c=relaxed/simple;
	bh=kTN82QZE1YVf3HwRi95Em/EAWrMW/V8K6a1OaEPGfc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuZ/7EzKTXUz3bBYCwZ5ZSXaO/8wfgxNF7JZcJ891+A3Z//hLuwtSKYUrbdCR4vnGOrBfVDAIVizA391HEZGwzkWGLr90MJ2YoHXzv7ROs9ngY8eD0xZXT5erNAsf4rMpbsFhIV9xU/8bwfxyK6DGCVqV6VWjCrh8OKZqO4NmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaoRTpuk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4HOq4030546
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EkaBsegfjzyeBh8oOxCHkshGj1/Y5QRA9G6enyBN7ZI=; b=iaoRTpukXHuTeq3S
	WLKzIuWPnKgcExCUnR1/FE/rtI4GSCTocagt+tSpSP5xWZuIJ89ohsASpQbu0Po4
	wh9QAIzmHjyDDYOI5YmDH8XbeEwcGKO9RaZFHMgW2Ce4B0Y90UdRX4L6ipdcH5v/
	IOoPXA7Ju/MEWkKFMP2ANKt9OWGNADLETSx1k3wCFGwODocFPE+GYb2WRHT14z21
	nuCg6nxnlHJavri9aAhtp7BNjwFUwNd3fNtRznewsRtqWMXpE8onEQ1M3wC6M0E6
	XVPmX8UD5C2SkX+df4Q80a5ZnEt8QoKyVlfy+efBSDMWJmUQaszLZXDXOfWMiwmT
	mT5P4Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdgm6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:06:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-781269a9049so6093761b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759234003; x=1759838803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkaBsegfjzyeBh8oOxCHkshGj1/Y5QRA9G6enyBN7ZI=;
        b=w/GAVT9lnbHrBTG3OmiXLZTzQT1ecp/1guQwLa/9vAguwY43/m7bOcsEa4mikXq+T3
         BacfZoG3Jw0aKLwvhhVdUIgGPFuNWrfcoXIqjbRn1Lh0Ntzq6rM96mJTofYbL7o6RrXg
         fqUYrKWFT+GgPS7qDKLheWfGlOcBVLwY0gbhrEcEJdRH6/VkoJ787ladok3mNjm8RW3c
         5FY1GCyCuJYQE93h+pCv2J8z6yGgpUoOD6cefS4mZp+/W4PQB3UMEdMsID6GRznpNtsZ
         ccyZPbo+VoA8nj0GxUUo+8vSam4LSj0j7qmhzDzcOjMi+GZYzgEg7JL8I9ZR9xjihWd+
         Gb2A==
X-Forwarded-Encrypted: i=1; AJvYcCVjatGvp9AUVgK/CSz4t91fIldYbguL+s6dLGNRqW2S4EKRbSZam+TLkzs53hj9gnXs4zIo5OoOjshNk7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVLY6kH/fh6Fn8nSUaM10Io5mDNr70UDdIM3TeAAIoC0iPIS1u
	A8euTQ7/iVsMLQH8Mpe235uGKpbCbaVP/WAO3EDhIpefYpm94+hTrakun0UED6j/imAgnTiZR2i
	ggKz0wdYtrh0lGbSAcnQp/1B63GrdYuoRDBbjbeoWSvlFAd/7tQPZdb6RFvQlKrF9YC4=
X-Gm-Gg: ASbGncvbQ3f1BDnksO3TByCR78bUE9XFXBbA91nerOeeFyuoE0jlTd2rXbmTh/zEPfv
	dv49VRaZrRQfOQ3rm5Fz4fgC1T5kShBAyGbhmz+rDCCYe9V+3ziiCZiCV1IxGsvT8/7eYR8eRrL
	1WPZz7wHD3dYy6B7gvE3PzlhB4WcVzJMK0Mj5L7t683jwL77yZA7iNJaLx9en1whs0UFmOxOeUc
	WKxvFpPELPXS1Ym+HejCVEAdWVmIrgh8zIZJsLOMyqO4upZVjUhrRxIMYdsX6jZyO48RO8G49g8
	C+mbqx83aMfemm3hkfhFIMNF8TwyDUcS+3GEhml1oM6RZ2VrXfg14NX3IjIqEuYUTf7yZ/2kAq8
	AqrE=
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr13271681b3a.10.1759234003374;
        Tue, 30 Sep 2025 05:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAWC6qZJiFW1T+hfkMFajhkKgE2qQSFj6mEYH92+MF2n+0pztInszFB0KjM2zlM/1ETInsQA==
X-Received: by 2002:a05:6a00:3e27:b0:781:2538:bf95 with SMTP id d2e1a72fcca58-7812538c1afmr13271630b3a.10.1759234002835;
        Tue, 30 Sep 2025 05:06:42 -0700 (PDT)
Received: from [10.219.49.214] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c07696sm13638107b3a.74.2025.09.30.05.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 05:06:42 -0700 (PDT)
Message-ID: <51637d37-aa5e-492a-851c-e5d6bfbe421e@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 17:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] arm64: dts: qcom: kaanapali-mtp: Add audio support
 (WSA8845, WCD9395, DMIC)
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-18-3fdbc4b9e1b1@oss.qualcomm.com>
 <CAJKOXPfY-CpE_aKd910PQ2+u9ux2EvuVEt9ArzhdVCJcTQJUQQ@mail.gmail.com>
Content-Language: en-US
From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
In-Reply-To: <CAJKOXPfY-CpE_aKd910PQ2+u9ux2EvuVEt9ArzhdVCJcTQJUQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n5SV1jG9CRPfMjlU-LA6re11AQDIjQbN
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dbc7d4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LNC-FtsJvgg718asVBsA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: n5SV1jG9CRPfMjlU-LA6re11AQDIjQbN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX1pBWsxzvrwvk
 d5mCXnp2oHSAJ2omvL1to5yxCXbuSvhqowJA2ZOrnd0HBtwe/wN9yoSZ7OnLIa5k91Ry2yUxuj3
 35wDrBjKOrsAgnhrS/GVeV90/mU2n0A2VWHdFMfI+Di/UCRaN/BkTaiLjK2VFWebbuBnaVO1bVp
 u7smvn4q4rx2IEeyVAW97hpkFySoN0IeuTf+j5hwiTBFRKTHOXk6djgMCvlbf8k8MnKl/+Ovy83
 lDGbD++I/FtAlOK68wnyuHOdq1kCSRLA2SB1Vc/KSqNsodvDByYWZuu60CqhRwyj7QalEnEQBsq
 I4qeDkUZPwBNi+8r1Cq7i0eLJxEC8ET2zFzX8TafiQrZL/xJMrJNu/mErasgj6sHPFgX6Y5jB0n
 mIiWkCiIKeKfbf9Yee7rFg3+i6skvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036


On 9/25/2025 6:56 PM, Krzysztof Kozlowski wrote:
> On Thu, 25 Sept 2025 at 09:18, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>> From: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>>
>> Add support for audio on the Kaanapali MTP platform by introducing device
>> tree nodes for WSA8845 smart speaker amplifier for playback, DMIC
>> microphone for capture, and sound card routing. The WCD9395 codec is add
>> to supply MIC-BIAS, for enabling onboard microphone capture.
>>
>> Signed-off-by: Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 226 +++++++++++++++++++++++++++++
>>   1 file changed, 226 insertions(+)
>>
> Audio is not a separate feature from USB.

I didn't understand this, Could you please help me to provide more 
context on it?
Is this regarding Audio over Type-c?

> It's simply incomplete
> picture which is wrong for case of submitting everything at once.
> Either you release early, release often (which I asked you many
> times), or you submit complete work.

These patches enable usecase for Speaker playback and On-board-Mic
Capture. Do you consider is there is anything need to do to make it 
complete ?

>
> You don't understand how your own SoC is organized and create fake
> split and inflated patch count just, as someone admitted, to have LWN
> stats.
>
> This work is incomplete, so please start organizing patches per
> logical features, not per your patch count and company KPI
> .
> NAK, incomplete patch and previously communicated as non working

Earlier there is an issue with SWR-TX interrupt configuration so did not 
work. As i fixed/configured
interrupt, it worked and validated on Kaanapali-MTP.

Thanks,
Prasad

