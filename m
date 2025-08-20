Return-Path: <linux-kernel+bounces-777249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D487DB2D763
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3360587858
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134122DA76F;
	Wed, 20 Aug 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="epGuVVM3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F351F3BB5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680271; cv=none; b=iqRbGuXuqzuaO9xQMF0o46BPE4SHx9j8/h2bYmT5aumg03GljKOkfK+xwy3/IOgd6S8ao/qHY0au66u/uRdKPq0LASLjMvJQI2x7EaZDM2EnI0MHl02Ee4woGtW0JQ1X/WE+4yrIfOZ7BuDT0k8rA60EBE9tRJR/k48ILksIktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680271; c=relaxed/simple;
	bh=qkYO27EQCIXsaD48NEJxduCJmgc4ju2NKyZ3rsjrJ5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M29NeHsllYtthqBK6qBF9gBoFromKU4bYJg2OtdCJjw3xFJkQjBCUbVW1fMWf+kBgRFNHh09KMPgaMQ1rJqQn8g8/xvgMhisDaDnCCEO9RS6qintkJn9Vp57IiTtogl+l3pbhzOHKNqcsvPDFYzajbxqccZbVmQbc4DxrRvzBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=epGuVVM3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pD56011480
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LovUKZUetKjTNqClYAkifuYXcchuuq2HOA0oOrFjetc=; b=epGuVVM3UEI+lpZ/
	GC3Gd49RLBjAts2KljoWNXZv1cVr+p/JIiFOTIni5sidKUiq8KP1lK9EODITlCKG
	do4i2ykChgNg+ODHLRPgfw/2uxIGrXvNag/dnw8nYBPZuadkJTjWfKqS2dEimX90
	VRxYcJHdH05LPhJCJKGZO3UvNU1hSJuditpdj8qQ4KkvscAWFiu7us+ZcZXANkYR
	oz/G+N7ALaYxtAwMeJeLgaOiiCtCrS7HX5rVM8sqc0Ju79vTt55maIT7bY9nf4we
	UnO0zqkurPhJR05+67EV2d164UT/MeAXMSDTmXfLQXtwX6WQKJgaAL+ChW0EZFrk
	DMzOVA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52bh393-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:57:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458121274so77327085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755680267; x=1756285067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LovUKZUetKjTNqClYAkifuYXcchuuq2HOA0oOrFjetc=;
        b=mjW2ADCNrLtJaldFHqDhABNboE4jvfWtJoP5UWOkPBWAre/9L0O3e6N2TdfiKMF2Lt
         JgEr7FVLdsUvOgNaxrkhmzU8j3L0wq+XIoWhk0sr13gJPwM4rPLvb8rNPUsB8Ny0tJit
         1i1cB6H5pjEXnJHN4PqvHALFUSRNas2DosT+QBBXm5i1wHSfH35eN+BNhZodayyInM//
         aMLLShFraVfZE9oPsydbO0qr9rsUgkNI8F7mBD8SHlKLCXV2LHSTk+jGmVwo9SYIRxrt
         al2fqO7AbBP/NvepF1bkfnAdKL9GavZDL/CbGm9HMePrnYOsui3yalV1KeJ2nXzPkCsL
         RPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9b3IPDitunq7TYI2yIYs4bwZby2XpB+1MRrS7zkJvT+VE6liu4UiYv6fLHuVdYUqG+Hl1Q7SpzFdy7qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpxz0e2IfM8NxdLH5KhilVZDF+2hOywpoEw5cG/Zvo0IEKhe5I
	H6NcIoevbWDNBRPbNZLUSpukhQhaMqDEmsWw1BceqjvXsrJDHGj/IoEfKLjlAwgT1EdPLgQ10rf
	1mOvDTxO4A8z0zZqrWuUqYZtVNnGTzb6WwIOe1kjkp3/VGANAHEXUkvqev57vLpyLzro=
X-Gm-Gg: ASbGncsMefHJ+WpODuk0nIvn4M+oin4MzVrsN3dQBwJBYCGA4cjuj5jI8etWDm7Zu5K
	aztFl1nTwvHDn0G5UB7xeQrY+MFQQ//2za2d6wo1YMj+NGc9Dgl6Il24O6YVXDu4J9OK8eJbo1S
	AZ9Z0IU2KkC1MXwAbRwghcWLQ6TL8zSbE6asLMNuFoLPCLGGqmdoYqIlLzMgvY5O029RdYEBs0K
	ojdV5NT224+plC+NQDwF/G3utySLAQBFSOL7J97ZfLjsfXfnW0iSaCJD73+JNY6mGnsId9JjrOZ
	wfTlwkjgW2Dk5sRZmXGPW/dqKFEwacPbHyEM/Yyw9kmYQMkJQKXoSGuhqZr7G+L+SdPLktc9o5M
	Dc6ztbjaOmfIpVaT0oFX7zMhmVteCRX+B
X-Received: by 2002:a17:902:e74a:b0:240:96a:b812 with SMTP id d9443c01a7336-245ef1728ddmr29790125ad.24.1755680267114;
        Wed, 20 Aug 2025 01:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5sQXiIDgpXrdgQJsAaziiWnOkOwfxl+Waxq3t4y+pSVqgHGK5588qw9DsrKpoU1yq0lXcog==
X-Received: by 2002:a17:902:e74a:b0:240:96a:b812 with SMTP id d9443c01a7336-245ef1728ddmr29789735ad.24.1755680266607;
        Wed, 20 Aug 2025 01:57:46 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed379e92sm20242905ad.65.2025.08.20.01.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:57:46 -0700 (PDT)
Message-ID: <b1eb2ed6-9743-465e-9b2e-75d5a06c1497@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:57:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: qcs615: add ethernet node
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable+noautosel@kernel.org,
        Yijie Yang <quic_yijiyang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250819-qcs615_eth-v4-0-5050ed3402cb@oss.qualcomm.com>
 <20250819-qcs615_eth-v4-3-5050ed3402cb@oss.qualcomm.com>
 <c4cbd50e-82e3-410b-bec6-72b9db1bafca@kernel.org>
 <157c048d-0efd-458c-8a3f-dfc30d07edf8@oss.qualcomm.com>
 <0b53dc0b-a96f-49e1-a81e-3748fa908144@kernel.org>
 <1394aa43-3edc-4ed5-9662-43d98bf8d85f@oss.qualcomm.com>
 <7c072b63-f4ff-4d7f-b71e-01f239f6b465@kernel.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <7c072b63-f4ff-4d7f-b71e-01f239f6b465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/xTCUBfF0ERx
 XI6AEUOuepGl22jwZnL6beASi8YEUbtwawUL+rc9rvGZwrnJBYK9tCrgtyKG6qzRiK1Di3JO1cP
 qUaZOuNQjHVOmZsoj82bKDG+rx0fgAnS6k7JMESgS2qfkHr2NZcINDagrHGWRmh1W/qLhA7fy+R
 DnEZ2DfvNbH5GcMBntXMs6VjiIECYQXpynH9fQ4KFwCKFLUhBLxy6Nt+1yrUs6lvq5e8Jf8FMfh
 r8Q+pSg1h3/HQXtuS8nafxyTGe5yUi3mBrMG3RUnSFKtN6njXHG9JF+bhgOdMwDxKJhteiiTaNs
 hjBY7ns6qpBM7b44bgNKguRXOQYgkK/W9smplZp+gWeH4gHuS6at1EAJuyUOykc8SsuvVG4Xgul
 pTrDCwzf2/6frMQ9R4quaX193hUYnQ==
X-Authority-Analysis: v=2.4 cv=cr3CU14i c=1 sm=1 tr=0 ts=68a58e0c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=DOxB7AakEuovRElI8tQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DtDxEaPUjac8yTkZ5v9L1rYhqdpaeCsm
X-Proofpoint-ORIG-GUID: DtDxEaPUjac8yTkZ5v9L1rYhqdpaeCsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 2025-08-19 17:08, Krzysztof Kozlowski wrote:
> On 19/08/2025 11:04, Yijie Yang wrote:
>>
>>
>> On 2025-08-19 15:15, Krzysztof Kozlowski wrote:
>>> On 19/08/2025 08:51, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-08-19 14:44, Krzysztof Kozlowski wrote:
>>>>> On 19/08/2025 08:35, YijieYang wrote:
>>>>>> From: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>>>
>>>>>> Add an ethernet controller node for QCS615 SoC to enable ethernet
>>>>>> functionality.
>>>>>>
>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
>>>>>> ---
>>>>>
>>>>>
>>>>> Why do you mix up DTS and net-next patches? This only makes difficult to
>>>>> apply it, for no benefits.
>>>>
>>>> The DTS changes and driver code modifications work together to achieve a
>>>> single purpose, so I included them in one patch series. Should I
>>>> consider splitting them into two separate series?
>>> Of course yes. You are just making difficult to apply this. Patches are
>>> completely independent and even your internal guideline asks to NOT
>>> combine independent patches.
>>
>> The challenge with splitting this series lies in the fact that it
>> attempts to reverse the incorrect semantics of phy-mode in both the
>> driver code and the device tree. Selecting only part of the series would
>> break Ethernet functionality on both boards.
> 
> And where did you explain that? Anyway, you did not achieve your goal,
> because you broke the boards still.
> 
> Your patchset is not bisectable and does not follow standard submission
> guidelines. DTS is always independent, please read carefully the docs.

The approach I'm taking will inevitably make the series non-bisectable, 
but I'll clearly note this in the cover letter in the next revision.

> 
>>
>> As you can see, I’ve CC’d noautosel to prevent this issue. Given the
>> circumstances, I’m wondering if it would be acceptable to leave the
>> series as-is?
> 
> NAK. Sneaking DTS into net-next is not acceptable.

Okay, I’ll split this series in the next revision.

> 
> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


