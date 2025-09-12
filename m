Return-Path: <linux-kernel+bounces-813519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87645B546A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2100D3BD511
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BFA242D7B;
	Fri, 12 Sep 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXZTo3fE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580E4A04
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668521; cv=none; b=NmeAJi8MCkVgCa12AdQJYremrQsW6TL1u35LdbKiIX95ZyM5sG7M2jzxHbH01erXWt7s94lUI35/2+DRUcqognq+N/UJN3e9uitLx3eD7LrIdtAoInOIoNCeEN1nAs6H78BV1OBgtI+eb2jNN5fezm565WnObq9gXEQ+K0s3264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668521; c=relaxed/simple;
	bh=8hH52IQLTSY/6ETqGyVs/NjAsxJHI1nF028y2f3sR7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzlNQyfRKWnuU8YLoYqoXwF2zq0Jzc1jkWG4FECO1psNQRdAoJHxXxvn5daywhm/Ob+pNBCS1q3yEOWJZnWtKQNfqTd/Ck9w2Wud6yK3OYx/NzHm4c48Lo6Yje6PPMwuXE2cL7crBGrFMrFcpR3L6yeJ+dkaYFQnoczFbwXymwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXZTo3fE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C7ePQ1030862
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZ+JWI9X0wZqgTIagWn90TQC4d6G/t4jpa0lbBf0/MI=; b=UXZTo3fEtGFWKdVP
	uzjrOa6CXlmqVLH9za2XzdBTlfkgdfzbg6SBRUJ9w67brX8aTaRnYpvY/vyZXrRF
	Ct0ANNZpEDZ0ELVE15S33vrHmh6+FhBL/gFUbUSM+OYRp6szMfMv/UvMun8AX0om
	/aWxPk46lOcIrDiaNVZP5cW0jumz/lRIcCizLXYwey766/7BhUheOqLZvun+laAi
	ehM8ZC0CMcuUnARK4uMT5iE0aX3Gz/e+/P+u5Wq8jbYrIMxKbGWcHwl8VM5Kt4ru
	C+0CCgdPxfFs4q9iUDoMZCocrkjR+Qrt58F92QEkPXWGRS3w2YHHTQE+CvVcwT5Q
	mWFi1g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqgaqhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:15:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-71f2e7244c7so3240546d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668509; x=1758273309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ+JWI9X0wZqgTIagWn90TQC4d6G/t4jpa0lbBf0/MI=;
        b=NGVQJX+gCcA4KCfcgqGfJd/YLEuOMySGq6PbTPJc/bAVZq+va9Zud0a+yMnov4kPtI
         V26KypREmK9CXKPNz/FiPYdwarWitF2UjpeHRh+lXFTbnz/ZBLZQhHY9Iu9w2yAOXtkL
         Rj3TnPLjqU3Yhq/lpDV59H0EdBexYgeaT9tIdCWHq4CtqIUfeXwAmViLPVqo3+m/V4Yi
         XfuMMnDTo6DZqGbC3YY9h+61zH8kRka/vS6BH0BFwRP0UjJ98Kptdz0K6wuHSh4qec/6
         X5DHuFqDhhp8kUiA5w9M+t9ebN9zc0uZ5haddp72zRrh9ETfr3XDi6QruySmnelui211
         k/3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8biTS8GALDGc0qpz+mFQ2dSevdlnSPis/uoxrvlubfQRvjZC+1xq+zETIlokXkmtqt9grepozVKdfSsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTYB+5GUG4iXLz6NVa/qkfv5mIFHS7HDyTl+ydaxnrbr5F2nM
	Ml9xWB8K45sd7CnDjCbr9fuutWONNt3DgYLVW7G01rQyk8bPNVzrvCSpGXyDi6mfrhYVTacst4l
	pxz/Wyqb9MQkmZrbcES1j+4B2g/1A6O4tiS5K4Er039dvUS/Eruyg9Ytu5f508uFdT3Q=
X-Gm-Gg: ASbGncsI6JZCA8l1ZhqDtuWZyjv73UZjndVovSF4MrvSkF1haxJe60nBXvSvhq1fCIb
	qIlWIh7nT1jqoJh+6l3IildVtYeeGFgo9rFkzDYUgxER74tosDeMV8O3t6x0oxU6T7rjvbPUdNc
	ed/MslKuGWNDFTTlojrr4faRKPrX4c0ylifwQB5Gj6e+lZihWorcuUYsH0w+8JuC65rHk+1DDgH
	AOOBCxFx5WwW0PphtwkhtLvWRBcV4nw/LnuRYpAJxvXMe1JxHywXb25rgWTRYgDfPE1OnMHeZ+R
	2knfPErltFRrKSrkyOl/ScFSitrnHG1BIJKYq8osS4zsfJdjHTEnQmF3AUKyWiydQm1HCMci/zP
	4BKSwaa6yhSFacxFsZiF5xg==
X-Received: by 2002:a05:6214:518a:b0:766:39f9:5e53 with SMTP id 6a1803df08f44-767c46cc9b6mr18965736d6.4.1757668509182;
        Fri, 12 Sep 2025 02:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHFLPs2knwRXVuLfaPYO2gi5ObjGWost5qrQbcgcq7H4G0UTAPCG0bAPwIvwmVi4F6AEwgxg==
X-Received: by 2002:a05:6214:518a:b0:766:39f9:5e53 with SMTP id 6a1803df08f44-767c46cc9b6mr18965396d6.4.1757668508674;
        Fri, 12 Sep 2025 02:15:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62edbc829b3sm1359359a12.28.2025.09.12.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 02:15:08 -0700 (PDT)
Message-ID: <cc8ba407-1d44-419d-9171-b6911f673772@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 11:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250912-radxa-dragon-q6a-v1-0-8ccdbf9cd19b@radxa.com>
 <56b5bacc-7214-41aa-b969-4f622afcd9f9@oss.qualcomm.com>
 <103424579111FE76+93c3daf1-4bce-440b-9048-74edb833031e@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <103424579111FE76+93c3daf1-4bce-440b-9048-74edb833031e@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cHC5Mnl3LLdDpBiJiLBsjAIBvl7dX61s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX/PHjKiOfzZt3
 kazzvDAo75Cuyb6v3JO8gRywo/r0QywAPlfpbHrr9fZ9zkKRqKvJ91DmXoa+J4j78G0E6n54TNO
 TOwad/Jq2zj3fCLrW+XqsDUMGGajbr1vB/ZflXRevAFJGCWTDtkVHItL1v3QWGXcrFg4+FQHVh2
 y2SVwTWREpWYkK3RMsf05FW9xgwCeyS/a0w4O0TiB1+wlPpt4VDG6qFA5zGKBfVKpl0Dl8aR29t
 icMhyXa7qyMyygJ3bsN5dBbHyZg6nwaJYP2qHPESmgwJ+0QdMEUWgvB9AIfrj4U2TSnBscwcBn6
 XS48spD9JqYThNzVtR4t+n2n8rCH1j6eexm/unODsp89NGS1bldLExJbgsrl/EGuyaEyA5rAoZ0
 /UW8DhVb
X-Proofpoint-GUID: cHC5Mnl3LLdDpBiJiLBsjAIBvl7dX61s
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c3e4a7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ksxQWNrZAAAA:8 a=oiU97pQBqXRJkV0Aqw4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

On 9/12/25 11:04 AM, Xilin Wu wrote:
> On 2025/9/12 16:56:04, Konrad Dybcio wrote:
>> On 9/12/25 10:03 AM, Xilin Wu wrote:
>>> Radxa Dragon Q6A (https://docs.radxa.com/en/dragon/q6a) is a single board
>>> computer, based on the Qualcomm QCS6490 platform.
>>>
>>> The board ships with a modified version of the Qualcomm Linux boot
>>> firmware, which is stored on the onboard SPI NOR flash. This allows
>>> booting standard EFI-based bootloaders from SD/eMMC/USB/UFS/NVMe. It
>>> supports replaceable UFS 3.1/eMMC modules for easy user upgrades.
>>>
>>> The board schematic is available at [1].
>>>
>>> Features enabled and working:
>>>
>>> - USB-A 3.0 port (depends on [2])
>>> - Three USB-A 2.0 ports
>>> - RTL8111K Ethernet connected to PCIe0
>>> - UFS 3.1 module (depends on [3])
>>> - eMMC module
>>> - SD card
>>> - M.2 M-Key 2230 PCIe 3.0 x2
>>> - HDMI 2.0 port including audio (depends on [2])
>>> - Configurable I2C/SPI/UART from 40-Pin GPIO (depends on [4])
>>> - Headphone jack
>>> - Onboard thermal sensors
>>> - QSPI controller for updating boot firmware
>>> - ADSP remoteproc (Type-C and charging features disabled in firmware)
>>> - CDSP remoteproc (for AI applications using QNN)
>>> - Venus video encode and decode accelerator
>>
>> You have a number of features that depend on several other series, and
>> as Krzysztof pointed out this is difficult to merge/review.. Could you
>> please create a "linux-next/master-ready" version of this series and
>> separate the changes for which the dependencies are unmet, putting them
>> at the end? This way we can take at least some of your diff.
>>
>> If you still want review on them, you can also send them as [PATCH DNM]
>> or so
>>
>> Konrad
>>
> 
> Thanks for the suggestion. I think I can separate the changes that have unmet dependencies, and mark them as DNM. Can I send the new series now, or am I supposed to wait for a few days?

Since we can't do much with this one, please apply Krzysztof's review
comments and tags and feel free to resend

Konrad

