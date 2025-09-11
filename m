Return-Path: <linux-kernel+bounces-811739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86069B52D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DD51C84E72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8B2EA49E;
	Thu, 11 Sep 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BN8DNZeu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463C2D3218
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583011; cv=none; b=ayvW/uJtVsC6V4xfa1IVxN9QpG4UJyRjRSpmazCfhYQM0ubqkBYcBy7oROwrVNpAr2vtSUBpM0eiIUhx7CBB91dN2NdKenr6MDPdR6i7JshAm0sKN3Mq0PP1O0AY05wFFTMEOSRJGX+5uL21jhccM/KND5IoAzbKQh5uyaFTJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583011; c=relaxed/simple;
	bh=9gYtag9MLEOCAGI7tG4fC8gYTxz7HysnYeVHwJfhGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYpPLCkiaA52dDedmxFTOyB6orb7REqrQShLlaVWUnIfL5aW8TRGLuDnOvWuglkk+0FIdYRJZBFGplxg9gxG3OQ8dDDCahQyujMrtyExj1buR/yN8yNEeTXCHc2RXKjpR9aLxmW/4tciaA64GuxjwxiMpvObuSuT14ZyOMgu0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BN8DNZeu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8VoOA003774
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4zEnPzFVE8t3bC1R9rCg0zuwA6Ldkx+mgUvoY3rTxV0=; b=BN8DNZeu+8SuM/Zt
	ubyblklFV4TBsBtcvSlCa3YYL/fKjTtbAxMGIY5EGTx98snDFeQEvNV1uv+fr6U6
	pE7DVv6JRC2n/LgbwTInJ+92NMjiuXmneW+76eFUXw9ogHh4ZxtJ5HK8x4mps8bh
	z/Eq8BX0gkk/M9GHq/c7nuswTXXPKJLyREDUlChhXfgfDzEwz66IP6M5Odndo1n4
	IUws9MYf/twsG1VPSMRdjczq2R0TijdGzDMTsS0L+ni+YF/8JI6riJ5Xc2mj4QIn
	fvotVWT3gBJJ9nI96oy7ujVnaRFK5z+zValRjkgZmEccmDDM3+jWm62mUOfjSP49
	XoKbKA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493tyxr64p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:30:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8186ffbcd7cso16976085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583008; x=1758187808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zEnPzFVE8t3bC1R9rCg0zuwA6Ldkx+mgUvoY3rTxV0=;
        b=rZuZyBXvbNxSZ+suWOow+L8BDzswjDgr0Ow1D12r7yL6FeU6MLygfdOrZRNQz333pQ
         UWJ4UZlVGJrszr71EKGpy37bYwX3ziwJDAep4uFbPK/klcNL5uKDzqt29hQhJJmtNsJB
         UO/xWoav81tzpzMQPZihnqpXgUNm8f6D6zUA/AuuUFbBKOVElmTAGh1j/3yz8FFjpaRs
         2+fklBSaifY0JIxzUo6Io2YpqvD0WwDUeoRkIpWgec11zC5qaXtlwHwXrLgO4v0UCFYE
         2Sa082s1qYOC7vZOOaajstIzCgJEPoFHhFyf6v9ldAz/d3+t89c6oAqYxorhk+4K/u/X
         HycQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhaBkM5SZLa6YnAhNtuiDzBAGpFMli1Xws5GsQM0WtUO5yaI1QJ5bifEXXNHm8YRbRLIaici64Q3IUlpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7oUN6i0sAL+09XGbFKcWpoWQuHT8LNYgWkAKwNgQ+vOUf9U8
	vOQppVjqjXlbVCVC3N6UuUZXmsu7ku0Th3Pv2Q9S9PXxWW6hHvlu2gJhsLF4mVnFVdcymT7DAmt
	I12vEN5h/mZ17D7ETBRyIfunp0EqowtPHVaNzlR4c+2GodtZa+f7LePzSrPr6mwcB2wQ=
X-Gm-Gg: ASbGncvEhEJqJLr1n790DJ5QtOIOrtB68qyb+7B94qwxUu/n3WBscF6jOv2uqqgGCXh
	ElnqONK3VqJvGmfhDokCMiGQ732GOLyJqBM8sTRFlAP2b8n/1r8yh89kRyYh7TV77N6XQbqOkIr
	8JRrMQdPo8BR4v67sA7UDlE8M05hUwryVHnCOLDudcac7dr6xwW7Zh7wG3g+XgWm06bQ15lSWR7
	DVrKhUBr8f4nyI+amLwRQAZfnenSOyUo6S8WuXqjWepUhu3mkVYUNF+kiyv8gEQD8LgYp6PKPON
	e0PTTGnQB/zsUwQYsvoE2Aki5G4Jk1MzOvdv9Er4qunF1hRyVsbDU1ZTT6OZRRYMRdS7PeVdEpL
	JNuNFZIS2yjm+j2SuaCgSqA==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr137696291cf.8.1757583007547;
        Thu, 11 Sep 2025 02:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVS5MMc+bsMDXcW/LDyPpJzdvX7Md47Pa7qu67qrv0jvmEfxL8qsY01l4Lv89+nv+0uNmnfQ==
X-Received: by 2002:a05:622a:190f:b0:4b5:f4c0:5fd with SMTP id d75a77b69052e-4b5f8531717mr137695811cf.8.1757583006940;
        Thu, 11 Sep 2025 02:30:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31287a9sm91470866b.41.2025.09.11.02.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:30:06 -0700 (PDT)
Message-ID: <96f7cd40-e5ef-461b-9dc5-44e23bdb4bfd@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 11:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh@kernel.org>,
        Giuseppe Cavallaro
 <peppe.cavallaro@st.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>, Vinod Koul <vkoul@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski
 <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
 <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org>
 <175751081352.3667912.274641295097354228.robh@kernel.org>
 <CAMRc=Mfom=QpqTrTSc_NEbKScOi1bLdVDO7kJ0+UQW9ydvdKjQ@mail.gmail.com>
 <20250910143618.GA4072335-robh@kernel.org>
 <CAMRc=McKF1O4KmB=LVX=gTvAmKjBC3oAM3BhTkk77U_MXuMJAA@mail.gmail.com>
 <b83a59f9-16ae-4835-b185-d5209d70a0f6@oss.qualcomm.com>
 <CAMRc=Md83STGFYya5eu4j33=SQ+D6upcP-7fnBwKo2dPdTtX+g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=Md83STGFYya5eu4j33=SQ+D6upcP-7fnBwKo2dPdTtX+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vOwfhoXIxRDJ3Fx3yXlu0KsNXoJ2odWX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA3NCBTYWx0ZWRfX8iCkVM9G46ZE
 9pMNYcAR07Xp75JSWoAC0Z+J+qaIUCR9uOW1CwPTVpLQZn7wQMKaGaD3UiS8cZ3jHeOTAyxVw0Z
 6F3W4vSPuiPdax3EQ6TQ65ONoGEfMFhPrwo7Zdjte4adzXmzSjUnjsXpsCs+VlnayNeTXz7uEbp
 v2d0LkdR5QnWlfZRwbaFNQF1mAnOsZ3jFZAusqU0cKNYx0+hSoGrvwx7SAFddonbdaEVUyfq1Y3
 VFi9col69kXCQA04pC/XZleNBQdZlfHC/AjEIsFIP/BBcUwgjJW+GseSExZWmqpuDQCdSgHy8Rd
 6KG+b9/AzsqGCnu220Vc2yQYF5TkrMdAe/D7oIpYTlsk6SKt9hfuaxs6LWSL6rWiR1NnSCNuJQJ
 RkneDT4Y
X-Authority-Analysis: v=2.4 cv=VZn3PEp9 c=1 sm=1 tr=0 ts=68c296a0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=QdYl_KjyuFFhde6HtdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: vOwfhoXIxRDJ3Fx3yXlu0KsNXoJ2odWX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110074

On 9/11/25 11:22 AM, Bartosz Golaszewski wrote:
> On Thu, Sep 11, 2025 at 10:53 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/10/25 4:42 PM, Bartosz Golaszewski wrote:
>>> On Wed, Sep 10, 2025 at 4:36 PM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Wed, Sep 10, 2025 at 03:43:38PM +0200, Bartosz Golaszewski wrote:
>>>>> On Wed, Sep 10, 2025 at 3:38 PM Rob Herring (Arm) <robh@kernel.org> wrote:
>>>>>>
>>>>>>
>>>>>> On Wed, 10 Sep 2025 10:07:39 +0200, Bartosz Golaszewski wrote:
>>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>>
>>>>>>> Describe the firmware-managed variant of the QCom DesignWare MAC. As the
>>>>>>> properties here differ a lot from the HLOS-managed variant, lets put it
>>>>>>> in a separate file.
>>>>>>>
>>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>> ---
>>
>> [...]
>>
>>>>> These seem to be a false-positives triggered by modifying the
>>>>> high-level snps.dwmac.yaml file?
>>>>
>>>> No. You just made 3 power-domains required for everyone.
>>>>
>>>
>>> With a maxItems: 3?
>>
>> In the common definition:
>>
>> minItems: n
>> maxItems: 3
>>
> 
> Just to make it clear: if I have a maxItems but no minItems, does this
> make maxItems effectively work as a strict-number-of-items?

Yes

Konrad

