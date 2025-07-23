Return-Path: <linux-kernel+bounces-742457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB4B0F1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BF07B226E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEE2E54C9;
	Wed, 23 Jul 2025 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8soRlhm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D12DEA7C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272444; cv=none; b=S8+mI5LJHqKjhxIKhF/ZxHZt7Lb6jRmXrhkKFafFzV4AMVHDqz6QZWLi5GTSMV1bK6OdZRITybUwq43x7Kgmq4GcEgNK1AtDqCWYLQ3j8fTNx/oJh9GJN8/a0W6o2ewMcXDdiizrPnA8SZRy4TvsWbbl9XZE61yXdOCaMEQClS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272444; c=relaxed/simple;
	bh=l7h14Ukiz36WSUCzAfQ1B5MfKsDmhlXkecfI4fzWztY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltANI7JhUfe3Ct0uIqE43kHYWAjki3Pr9TyJqIW+6TA1xXUKQlTd9xNLqDJM9L3Lns/mO3BhY+r0hwbkQclmr5ewRsl5loEMEUJPsgT8IrDdFU4+sf9WaI3wyIF9ZrN6HwyHWllrnicxK5wFWkJJn6gzWmFyLN5XUgM6qxMck8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8soRlhm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9fN2P002998
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghA/VS95zinQDHhXlbeITIgaSp5qFlupk4F14AhAmp4=; b=U8soRlhmuc1ef6CV
	mN/IJvlU8ogmLUzycLeymbxpm8aJGHje7tKHJ14C0LJO4kWvYXZ2fvhfS+HV3KxG
	/C8fEavtkSA/3atvmAAYZ0B+dfk95e1g3cLR4He6QqaVV7qrkHpPjTerEGjKu2QV
	NRIFYw0p+9btI2HiIq4YKnUAFnuzvqE4CInE1T4eVMNHkcfJtUHqSQqkwwySEvE4
	RdzWKb4CrsgBHey4YPHCMH11+HTPkyJrujhKojLqJlg27EKjqmQcPrDYaGJ7d+cx
	06BCukdIDa/ruZjxvbYlhHTH68jQklqrAA0GQZYDObw+9WwnvDjwmSO3xPKfHh9x
	Zhx7oQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1ccb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:07:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f13ef248so6188227b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272441; x=1753877241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghA/VS95zinQDHhXlbeITIgaSp5qFlupk4F14AhAmp4=;
        b=P8nL/bKjgq6JSdfVYOAttZOf0yuSJ4m2pUH5gyyVQ5kK3Z2KygEfLnnCotgO2Hiabj
         jXZMi1LQgLNqFm8QoHOXY5D+slkuy6QYqPF9syST/GAkysSVivBX/i37RleN4bXczOGH
         GgO6W6wROyGnxNznEo+1sgXvxNCmQaV3lPjYV0dWIm+6i8+9sO+wChjF9Y+ZJGm7FiLn
         QAQmGYM3ESLtELSY6im6fdMF7UsLxoEVnXjsZ6A/UEksTiHGITWWw9b1Ieab6rSWNaNd
         HCVOnWURfmaQhDeXCnP7UNKny6BCiilHO2POEI57Y9lKivLmaR7dWtXuhz6vmW1u5NlZ
         UwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCURidJmg1F2n7PnMqp43Of29w0yOYF4pkY87OKrhT1BZuPlGaLeDdkb9QKl140/WlHBD2oUgqqaDr04wfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Tu/K7eg1DHEu1PeCh6z75QTX8cuYWlPMba/Ng8WHheBpKJeY
	PyDXa8NSlXZvR72zUD3ieypYAQ+QdcCWSrUMsZhVFtzxAiPDAY/d05P/yi5uQGG7FiECMd5Ns5t
	Br8q9neDD+q4/UWgBm40iCD38m8wAJo7aSHeifRZ7niLpJU4xf5ODlK2HvPBof+k8LBc=
X-Gm-Gg: ASbGncvnc5kkg1JmwhlA+uieAySvgo3jCIgNEmLEeOFlchUNpkCpIa6rqnmm3oru1yi
	DFvbSELwo3ZDSKtEI8lXwNowv9s37rq+4wvnigOE58FQgbo9MMchP+OqMViLYI6UoTz5UJT/3X4
	ll2jARHkouEMEiDKaPIc32JnVyP1qveozeC3N0Qj49VO/Aw8YntfoRhG+vsLOpkIdD16U+Axsjc
	8lCuZ8cpHiveVYrY4tzkYrR8uXHZs0WESHe7Yyx3qZBXMAWxYXT1EZ4k6uue8tLDtCTOaI0sV8+
	i5JfTTyjN3CyTod/bWZ4PgXhANeY6DlFsF3j66WHDU7OBiDOBPLSjRuurMHX667XzVoWcEzNWof
	Jn2jK2KUeqRxj9b/BFvhouPCtR4qXtkoBBV5e8fj3p4HiFFQ0G7Hlvw==
X-Received: by 2002:a05:6a00:1909:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-760353d5d08mr3999942b3a.16.1753272440653;
        Wed, 23 Jul 2025 05:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUboQ8jvgpdXbLokFYRCm9swkz+x1eIWhQBORpRgtnNTRDZV/f+O4yVxWhMrDrPrbssQecVQ==
X-Received: by 2002:a05:6a00:1909:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-760353d5d08mr3999895b3a.16.1753272440071;
        Wed, 23 Jul 2025 05:07:20 -0700 (PDT)
Received: from [10.190.201.48] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e25sm9630984b3a.94.2025.07.23.05.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 05:07:19 -0700 (PDT)
Message-ID: <d31c5e0f-dc50-4e7b-bd81-256269c82ec3@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 17:37:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
 <20250723103644.4058213-2-pankaj.patil@oss.qualcomm.com>
 <70277682-94e7-4905-823d-25ae76f72ee2@oss.qualcomm.com>
 <790fd85b-fb24-4d44-bdb1-706c534d1da5@oss.qualcomm.com>
 <d37879af-a1fc-41d4-8e31-2abba6fd6d57@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <d37879af-a1fc-41d4-8e31-2abba6fd6d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9NWA-vC4vW9avOfLoif-TbIOYwDHvlpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEwMiBTYWx0ZWRfX40JBkCtHJubC
 h68ykaw/sin8BdTOFORLMaznK6hG+bVK9hShtn6tTLI+LYKeU90pUwGqmjtnhvfeuveo7CHr+x8
 pZlccyQLyOG86yUxiF9HuWoTuFtiBWlErBccHF6GFgfO9wwXAnRpBUXNGhINAYWUcINqH00GA7z
 aki3iBrUvy6OlWtX17RfS+u0SmHlmOfoyJmQ/6nQ/nsj6oWppK7Ie2+uWUpsuex2MEtUq4Nwfxg
 /4Ii9zRjoLWnjcRY9dkDaXemxy8FPZyXeQn7lbsRsHtq1/iYCi0FsnVUo/9y6jk39k6LktTvnDO
 bMP0CB6j9lucEI09wmlOVJUVIDkDj6F6N4zAOdL/OuwWgFmZlCX1YdSUfhwk5qeiTAQZFHjzWUE
 KUDNLiQlPRG8TgwEQtZY6yX8c35lnaLo7j/I7ol1hOWVIuHQSBp7yOSIbil5A/1XpMRBIiOG
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6880d07a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=fmhopZmm7R1C_NTn11oA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 9NWA-vC4vW9avOfLoif-TbIOYwDHvlpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=871 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230102

On 7/23/2025 5:25 PM, Konrad Dybcio wrote:
> On 7/23/25 1:48 PM, Pankaj Patil wrote:
>> On 7/23/2025 5:10 PM, Konrad Dybcio wrote:
>>> On 7/23/25 12:36 PM, Pankaj Patil wrote:
>>>> Add DeviceTree binding for Glymur SoC TLMM block
>>>>
>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>> ---
>>> [...]
>>>
>>>> +      function:
>>>> +        description:
>>>> +          Specify the alternative function to be configured for the specified
>>>> +          pins.
>>>> +        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb,
>>> Any reason for           /\ to be uppercase?
>>>
>>> Konrad
>>>
>> glymur_functions enum members fetched from ipcat,
>> this does not exist for sm8750.
> I'll repeat my question
>
> Konrad
It's in uppercase because of the way it's in the driver,
I'll update only the bindings to lowercase and repost.
Thanks

