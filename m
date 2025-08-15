Return-Path: <linux-kernel+bounces-769878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86712B274B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38529AA0BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF521448E0;
	Fri, 15 Aug 2025 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+rptkb0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40516A95B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221373; cv=none; b=gH84HkIXc4mG5gSk53O/Q2lXNvH32qS0q0cQIJmQIIRlgWkFuj7UnmpZbOIOChj80jOBkd/Ivf9JqMyb6Pe3zEZ94ory0bmzXecLohfEaqi59P0LGUq6hc5qhnnnUpQV/r2ywHUB0lT6x+aTeo1VwdsQQe5Sf3wewn5jM0Dofxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221373; c=relaxed/simple;
	bh=cL4fF5cojIEZfoIUUyktMh691We62NCcFTpHQe1DfMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtcOlSC+X8yLrJyoikIhvGxW31onl0iOajMV78+Il7yfLhD4C//QKToG6dEFh58AYV06AJNn5XKVr+OtkU/R/v/ORJZYsEZ7BRyY/TyiGGhTFp4yX+2an/YQdlC7SE35HKU5SiTaqv5wAK8mOdKiEPy/XWN7AHoimUf1aeqWd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+rptkb0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHgVAb027100
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BUqEIcGg41PDXWHz1z/iY0qtxmEUPZEPL2CuLNi8QnE=; b=C+rptkb0uGTes0QG
	nkqJySsyMhhThA/IhZCQ7aoDYwPH8KIvov7RFNVDU+VWDDuANrPyVxx7YHu7TYN9
	XL44aCtGkefVytiC0PE7QWywNcGZ29E24QEW+aTRuJU8VN2TZctkDutwa/R+Xp7F
	vKXUdYouhF6yhJd7ltlhgwhQW3yiJhWCc3HpIoGuzHgnosN8TyfNALwdzpB+rHy6
	ThZwAfRteRXRO/bTPmdqgMG/a+4TFU/MCxL6x056oGN6rVzJghMZtmf+fY304wsY
	ERJdYD0AmmBfEQH4064y1I+z2p6qdKC0DUfKTNzznu0MhBq1tO8+clKX1vAumBDU
	mfgtAw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjwenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:29:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2ebafe0aso1342836b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755221369; x=1755826169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUqEIcGg41PDXWHz1z/iY0qtxmEUPZEPL2CuLNi8QnE=;
        b=g5i4bNwejroyzd56VhtrIcIcherIpRsU9WYIDYorUD7up8NBEUU17Ohuuexr05HWem
         dMw7qLW+6QHZGn0+yIqh1/udE4kV4LmMfqi6nKhKYcOfbs4Ru9gUYywjZgdV9OASYXHE
         CWIK0QNXu31vyfIVCclXz4xZUTyJSEpnDY2akbYZB3nzkvKnDvgCeefHGA+snppPtoVo
         Rftjof+xrFokEw8V3jYHT3GyLgA4nEbbLJm2kwDFfkI1iY7VdeBaH6g/8IGa2eh4zsIe
         7on13AUHqUzPjxdLrKkcIsEjCPm8RBglFU98QkzcWHgaNHoOdmleZS1IBjab39/4T73S
         mnFg==
X-Forwarded-Encrypted: i=1; AJvYcCVkLoQUtvACmxO5TcWlM4J1B4ewIwCPhhLtlLk367nr7EDvuRp84w+MXlMyzMVwCjRbOKnGKCTQxHJ0o/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaggxKz9TOc8UmrQKPdHFGsCuUYiyRt1a2n8XO+K+E0ASh3HS0
	FxFrNpI1HrMMfucYV/MrwNcgsHZwKqI520EyN1SY22VcOFTWIEoJ+u4IEXtDgffLEZtLn4qiFSs
	c51lb9bVZJ5w4rtt1g102Z+OunoVxNeRYSOCpCihovRyJJTYD9lvc0HjwDZKNl/uz+DEcmbqtWa
	Q=
X-Gm-Gg: ASbGnctl0YELmGA0tg6b+mW1tSBn/52dUONZlloRWFLzymPJvPP9uNhyB/kGeHN0xIk
	xClFzxDJ0IFnRUPnCIqR4lW4t8lpHRMuoWQTsy0sbP2dZwjyjcThts9eThVoaxujUU6BgIw4cLw
	fzmKM8BA0Z0dXzAcWRZp3egjanpRcf3ubPaM3i04DoR+Lu0JR/5JhTlF2bfm7OpUwHEFTlm0p63
	0dGySFbhUkxj5r9DFiCcOUDvRphQq4K1TCTg0WSuCUTDWTWpsSkVpcRhFQHvhz9yxTvuozmb4Nx
	8vlRdu4OdeA7JE3NcvKWiHBWq+fX+xGtGqMJDiDY2T4KEmgos+I3ApcWhpQ+4mOHY11a+UwqRWL
	TcYDp2N7EwSj3BHpOw8/9OlWLB6A=
X-Received: by 2002:a05:6a00:c92:b0:76b:f06f:3bca with SMTP id d2e1a72fcca58-76e447c149cmr255792b3a.11.1755221369325;
        Thu, 14 Aug 2025 18:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE85cmPNcrwW6bUVVpYJSBjvWFffHOJCxDIni8KFhZzvKGJ6oG/cndR/h7QxbdZXamxFvZSdA==
X-Received: by 2002:a05:6a00:c92:b0:76b:f06f:3bca with SMTP id d2e1a72fcca58-76e447c149cmr255754b3a.11.1755221368603;
        Thu, 14 Aug 2025 18:29:28 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4526d1ffsm9468b3a.16.2025.08.14.18.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 18:29:28 -0700 (PDT)
Message-ID: <603fe072-b2f8-4cc2-8a0f-7f51d6672b12@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:29:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Initial support for Qualcomm Hamoa IOT EVK board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com>
 <5reeryefhw7burzf2lymhg5wivaq2n4gq5hszvfp57dergvpyx@qehaf334gdrn>
 <7e5d39e0-115e-40be-b44f-0195a4827a0c@oss.qualcomm.com>
 <63ecde5c-8234-4630-97e8-5806b9ff3eea@kernel.org>
 <a56b3e85-0d42-4945-8b6b-dcff20c7b104@oss.qualcomm.com>
 <bca211d0-8d53-4f49-9cdb-67af7ba69421@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <bca211d0-8d53-4f49-9cdb-67af7ba69421@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX1RtrUszugPA1
 yX9vocD6O0ObWy1+34QtxrxzbXs+Zl4XmSxygNJ50/zoskHO43zjfaAfJCJZ2zic+2hHtRXS+2t
 pNpGw5JYd2vG4/lcX+7SO6ZGv2F1EPioy0HZ08yuqwgeg9o5fYKCHqCh1eRUVxFrPPaHl5PhqtB
 In7AViJnuaMhYQh3jPRE9qXPzx6jwbVnX3x3kZS6hK8PD8yI7Ld+NFTi4nkBY4d3OsTUz9voefN
 29HfIdDPM1ienHX7SbKsvmGvhr6QmZlmuixsOPbsaZsXiQQl6zHvznt+BQ2QiqoMu50iyzwoViI
 irC7lvvAwjr0KutASsAvAmbGqfF3EV0eGvN1l8Ao8r1wPhJvAaBbMhNu4SQVDnL4iCe8zZwFGVO
 NeZwDpHK
X-Proofpoint-GUID: X8b8VfuRNRwrrK4WaRFlBoFFd23HXznF
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689e8d7a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=ocaDlfLBIpot7SGG8IQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: X8b8VfuRNRwrrK4WaRFlBoFFd23HXznF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074



On 2025-08-14 19:15, Krzysztof Kozlowski wrote:
> On 14/08/2025 11:28, Yijie Yang wrote:
>>>>
>>>> Audio support is still under debugging due to unresolved issues, and
>>>> it's unclear when it will be ready. Would it be acceptable to proceed
>>>> without it for now?
>>> Audio was sent to the lists, so this is confusing. What was the point of
>>> that posting? It clearly said:
>>>
>>> "Basic test is good in Hamoa-IOT-EVK board."
>>
>> Additional issues with audio were discovered during further testing, and
>> the current audio series on the list is not suitable to be merged into
>> this series at this time.
> There was no such indication from the author in that thread.

The author of the audio has been clarifying the technical details in his 
thread, and I’ll ask him to mark that series as unsuitable for merging.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


