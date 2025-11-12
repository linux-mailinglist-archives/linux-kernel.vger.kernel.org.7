Return-Path: <linux-kernel+bounces-896832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DCC51579
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A30D4F93AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50F2FF150;
	Wed, 12 Nov 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3mRdK1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbEM29D+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263A2FE07B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939113; cv=none; b=cVlocvNpqSx+aVaX9G53R3JgGUeIuFHuaqkIg+0P8lCUipPN0a0d7uX7StuKMDH6aBSmI1NhSbJh0YoieJ/Gl1lc+zkjdZbdEaHkgR3XspVrv4PqYOjdQvdNK5QlK6u9PuBZiWxWbPA+7/0zQc72+TMYkgQeOX5iQDgxZ+JsA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939113; c=relaxed/simple;
	bh=U5QUgzFTz/IvlVLx3nP30IouyyraN4noTBTIRMQEoCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebxZfiHDjX0iW9EiI7jOanDYJ0Ahh4jIgGdIsrLhzOZc265KXlze/HFzskCFC8u9mrq+7ByEXbogPe2z4HbqfdqVTqgvjGlnTUF1loZilIJnIbe+ORlf3Sz8SybdKko6zcE5jN5+7JkJ6wSH04aiB5ttUSLnZ7UfAPldycFQYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3mRdK1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbEM29D+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3o5953060214
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=; b=M3mRdK1RR8PQNY60
	GweKj5OB6mJQfS9anE5lEstnPMnkr5UfAh/gaNwnTtqGpmGiCJMT6tcjd7c9qK4B
	n06Npwsl/bcr0LXw40fQGofnf/AHhZzy4R3Tuo9Nrv9nVGG8OyhuFgpjkq/R+UAO
	KzXT50zZ4T9qKdreR4L1xDAObsSajZ01aLywFE2KOmNeIPAZxLAVTeqURbCNphOl
	qWzmmjG2UuQHVbPiA0XF45h6XtmWFTNBcynHdR75QGuTX+UotG+kO2kDbGhw3qwt
	flYPbOPio5XHn4VvNlWJQWhX8hpC1KgIBi30zF+VUTudBNjFM26Gp8qIpij4OZYD
	2+S1ng==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ac988jdyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:18:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8800460ca8dso2473316d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762939110; x=1763543910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=;
        b=WbEM29D+xUQc2CZ3jEx9xtILvtC/Aa003eDOM9qVKOimJlUxYNdRcPTzbf/WVO9UXC
         kOUExbWxRvAMODFxpRqU6gRVDdCaJKMi13l2fecb+q28LtLurBarzeGVZoLW4RS724mD
         xUoDkbUjpfLAeJGaWjXb/+w8UN2XwKew3GL6MSoX+86md6yb99aWRPPsRlgWRdnghAEb
         b9TcdA6tFctaehnPASvVsjEDpt4QWSgwtwUM99DKnV6x1TjS/0PKCDw4cecHcLZ/dOR5
         XU+/kK3yzo8XC0ljyY31MhFxLGXknJSKI2OHLKk74at4oBct/fJtwIAKi56/QnbPm33C
         7wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939110; x=1763543910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=;
        b=qkpMvXXkmfZLFPm4w6ciQy9YjIUaOJoW7F4FJcMPO771P8ZVobYFD9RCjM5CPoICed
         x9DpTf4UC4KNjtrHP4XBUD6g+9AhRNNOuK+qdbchcIwQAxgJcjHu8bIQgD5LXf4fgnYj
         BJkdrlYDAdoXzdMIuQQWIwGxCx2RUnQKdfT1JE/NVF9QoeLYjDcYlh1e2FiFJNwK3kI2
         vIGSbycwAz4JapYmTG4RQJ9F80A/26SPUg5sS/WGMUVj34Ql13CMqWeDLsRu0F+1X4zH
         xq2kMwwB/9ViRPfj9jm853wchKdAHIg9eXZYzEwEqh+3XOaKDDbl8o5FziAMKrS0Jv9z
         /K6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9qTwdOPa9Zgvzbf5l46QPTmpZImgrEWtRAcjTmm7/PTOulAcm/1zkKAVIseDuwjq+FXnXktQgLRvXH1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80P1jbwcbqgWD0ap02wiPq0vFrleFj6vl7Dl8VpS8dGRP2y+U
	+meNQJ/j4GmtbkNF5pzdb8qnZrVCYhjkrVY0i+BFANmcOJbrSIEZH5J4HQGtQGi17zxd9SeKfZP
	cauXqqH7tdj9VwMmSxG69GhzU3WFnGFWTXOKXcdTP1ertGxzXdJHY88P0xP/BPGH/XWSHuRAIov
	M=
X-Gm-Gg: ASbGncu6gEzliUNY+WOyWmeytKKqB57qDjNjMaAY+7f9PpFOqqR3rf1tbto4sqMjuwK
	kmNLK1ArNIrxYtnrDe8Olgbrcv//WCx2oc14iqyqqxNivO7NUIcgAlsGh+yGO3AtOh4efw8+lyU
	9jGOt38Z86V3J8XlS3s3wSEScD7YjOzR6dKFLqEAsR9SbPbCyH5uM13DSNT6yyR3/sffZDxMcXn
	MaWk++dvYvDnezYIgWpDPqPNtfsm8KL6bghMS1fAJvWITs9D5QgnnZns5BpTLkgQoqOxWviKhJ7
	7BgO2b/adQc/lcgyqsf7wLZNMFxA9OS7J1eV9GqGhxBTljtZqiwvJ84tENpQC5Yn00x1/5laaO5
	ya8m0Q1SbpXb3BvE0/15aQsCaieFS85wJELuBIjCT7nBP4nVd8HdgYFUX
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr19582951cf.0.1762939110387;
        Wed, 12 Nov 2025 01:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4l5nO38ZbTUUbjYXNEyin+4V4OUbwvGEdR+rVes2WfMKu7BFS5vDlEA3PIIQEduH3Cw7aqg==
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr19582781cf.0.1762939109964;
        Wed, 12 Nov 2025 01:18:29 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1618141566b.45.2025.11.12.01.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:18:29 -0800 (PST)
Message-ID: <a0c267b3-535a-4f38-9a9b-d7b141b8fc64@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: xiaomi-beryllium: Add firmware-name
 qualifier to WiFi node
To: David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Selvaraj <foss@joelselvaraj.com>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz>
 <20251111-xiaomi-beryllium-firmware-v1-2-836b9c51ad86@ixit.cz>
 <wxvtfyfdso3ngqvnhvryeo2w6udoolfp46smv2r3qny2cl7n4o@iawxfnj7qtrw>
 <5c6a1434-1f43-4434-b6ed-0c5b98ee8d2b@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5c6a1434-1f43-4434-b6ed-0c5b98ee8d2b@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8rirVLTAaO_zSjWFKsiLghFJ6OMHX8jm
X-Authority-Analysis: v=2.4 cv=eO4eTXp1 c=1 sm=1 tr=0 ts=691450e7 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VEnwf-grGjUPgLEjvqIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MyBTYWx0ZWRfX44SfDNgV0kZ6
 NCsxt+FhC5HumUGwBVGiQK6WFbWBYXGJzN3nKobeDcO4UNS91X/ILfCXGKhb5EpxemJXf4aK7zC
 5Qdr0J7pY+eCbc45/NlvYmcecraLVfmBpDgiEvYpjzNUYAhx2ML48XmTqVcrK4lAjs3czTEHudS
 l4cIilwzmP4GQqUAMcxSIibvCoFH4p14xHDbDsbyzoA48nnBsCMfeOUC8AGG/ycw0OP9GLMvndT
 STa5YXH4yrXXoH8+5vbNhsvpAA76URiufnmRNvwA4yUbD1J+qdNBo3tusm2pFKlnqrKyk97mUKj
 FfsE0ZzBWh6YS7t8BKQvCLVtQLqagF6kcg3hITwmOGb8kBE+h4MURrQw40qbr2VdDCSWp7gc1Fo
 VlytqVdqz0Ejw/PYI7ty8bfCeMbG+w==
X-Proofpoint-ORIG-GUID: 8rirVLTAaO_zSjWFKsiLghFJ6OMHX8jm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120073

On 11/11/25 3:23 PM, David Heidelberg wrote:
> On 11/11/2025 13:46, Dmitry Baryshkov wrote:
>> On Tue, Nov 11, 2025 at 01:34:23PM +0100, David Heidelberg via B4 Relay wrote:
>>> From: David Heidelberg <david@ixit.cz>
>>>
>>> Add firmware-name property to the WiFi device tree node to specify
>>> board-specific lookup directory.
>>>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> index 785006a15e979..9b0b0446f4ad3 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> @@ -631,6 +631,8 @@ &wcd9340 {
>>>   &wifi {
>>>       status = "okay";
>>>   +    firmware-name "sdm845/Xiaomi/beryllium";
>>
>> This wasn't build-tested
> 
> Sorry, I wanted to send it more like RFC to get initial feedback, I got user with Foco F1 who is willing to test the changes, so I should have new version with T-b until EOD.

Nothing in this thread seems to suggest this still awaits testing :/

Konrad

