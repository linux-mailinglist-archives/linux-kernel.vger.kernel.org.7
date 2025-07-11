Return-Path: <linux-kernel+bounces-727545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D86B01BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103597AA4BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20211295DB5;
	Fri, 11 Jul 2025 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/6xW1ba"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A324676F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236374; cv=none; b=ciVquh774hLa64062NmX11SWs3lyr62UGH/3k/lKRO/aJH8NJCkBjoaJtS28SE1ACoUeacympY5L5IobG90GoEZG54y6z/1SlLkLXBZpd8Kku9S1F7PnsSSqOYSjNps5azhz1Q64ttGenAz7TqNMpLuWQfFHP8Q5cEnQr9INNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236374; c=relaxed/simple;
	bh=LLrYXoDSk+Z1qUZOicihZi7zP80fK++DmxBSWtA8aw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHHNrX7tt2s4q9N8OedcqQ22eYC+8gD4vJ1fLk7Xti4Po3nbK+V3zS/KGCtbCDpE5wrdg/QL2f04aGi+tC5CLkiGeiBUZTM8t/5moPGj8+zUC2Sa8HmGcXpIkAv2q0PLUTujtzLqwqZHChEb2NeKaN8XysGYkLK1kMaRjcNkSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/6xW1ba; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB7Zoe001770
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PgRbANHn+bv7tnW2+OxW/Wh9yvUY2jb9oebM1Hb2GEc=; b=V/6xW1bar7YxpMdz
	jGzXZNSYsgNxdHU8lGqAXSpNawExd/RGkVrqkOD6mtiqWKNQpTilbpx0dNg7SO6l
	b9nQMyOYUC7gVGE0mLzat8eFRnjfLmtjeM+gtdMh394CzMC8P4d9qe0YTEcJ02B6
	v/uY1Vi6z8Qrt8M4SOwcX0n6pgsc4RJQpZmnJauGSFkhqknpoCnUnemdR9Yu5Lmb
	wL2F/UYVdNDaW1+F4MMpprOjkHCy8xxMNtrwPpEYmgT9NYv0drQ0ddQBQ+YzvaS8
	69imad4Z4wJ9MDC86nnIf3ghbFoHog7HnxWd4mZYdREUAvXClnF5q9q6oXEv7rkF
	oSWndg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucnbynr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:19:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7de3c682919so20573085a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236370; x=1752841170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgRbANHn+bv7tnW2+OxW/Wh9yvUY2jb9oebM1Hb2GEc=;
        b=WskEw0nSad7m7wgtI21GUwt9F/jPwFco+HQPDzgudnNlHAeastePlPgdQo//nwf5cK
         uv3kyIWd7DEzzCYnKctMsulmTgwzrzGjjbvMJZOBDe5DGj1WwPWFj49bJPq9pZIGymME
         EUE1rUysqwmN3SRVH95hv3aeRcMCu5AtW6/ru8QL9mk2tRJaQL+S8IEQSr28OufJwtDJ
         0FPhpxazROtzH3bQZsWMh2HVEqc50jk4pwJWzJBMkdHAvQiwuyxcXPRAIQMRJUSeR/ND
         C4YnHZg1m9rMm8yoIKWjo2vX38PeiLmHsTtZ/NFrosl9cnGtjUhl44DIJASs8Ks7iIYi
         DRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmAw2CmbTUDWcM0YG74dFabWt1+rfUcgW9kOWQ32OBkK2X1H8hmRxM8nAhA8D9mHAgY/Nc1gg5CzWJgrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4vTWjGVzOdklN/Dy4/M3t16z8XErADIwCxmMXlht9/8aHSKh
	XPcg75/4/Ozn70BVSMYDr98muxelcFQs0mTvr9HrssYigxehBbj3V4PlESzjMNswTtIOGQW9adf
	rjW9ZQ4uto5yLcTgY1xKWwNrNRCQZgs/NS4IFpXyO0WquKp3HJQLUrpfwRJX3eN2jl5Y=
X-Gm-Gg: ASbGncv721ulk3iRyJ8bauDdwpiYgQVRWFQCL0tR8ki7gyOeh9FCGPU2pJG0F5n5TqX
	DMbxlhUPKQUj5Pkb4cy6dDk4biPj5ZWHcVCmg90LybNUzkHzc8ArHhIIj+rj8/I/K4MztfZhxKO
	sxrznOpgO8WC69xd4l419R7QbA+YXaHmIKaRD7DfDFXF15MJLFeNzQ9rvYsshz8pfZoYa7bOXhp
	BecX6qLSkzIUv6GCTZEkR6q6008nP67SvMTwHfT8vUMM3FpPjR2nk3TEOT3YikzHXMwPYUfElL2
	CS7uYBQb5t7nMmYwXMBD00gLPIjDXDQKWDg+DhpUUHSJBIPVRrmgbMZiHIvf1KTxCw/eEgPJH59
	Z6dBb/qkmJBhrpFH6zgs0
X-Received: by 2002:a05:620a:261e:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7dde704afd4mr193294785a.0.1752236369496;
        Fri, 11 Jul 2025 05:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWdOt+nw01pFgLOuyNAAOJCd4H7cvcLSPFzBJPJCQX8U74WAVdoJLitJFP6NOrfYfrnxfZkw==
X-Received: by 2002:a05:620a:261e:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7dde704afd4mr193291385a.0.1752236368710;
        Fri, 11 Jul 2025 05:19:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910e8sm292167866b.36.2025.07.11.05.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:19:28 -0700 (PDT)
Message-ID: <b9f6f827-78bf-4fee-8be2-74a9c94d9722@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:19:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org>
 <46a506ee-0472-4c7a-8fd8-b3a1f39105b5@oss.qualcomm.com>
 <CAMRc=Mc7KSSTF=Jsu-_1C6eWrTXNKB=_Q9fnZor8K_4nnQ5m4g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mc7KSSTF=Jsu-_1C6eWrTXNKB=_Q9fnZor8K_4nnQ5m4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=68710152 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=RgMTYWP1_r0sjz9xMRoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D5PnAjjP77UzrFQaLaCvU6WyqvdZ_Ma_
X-Proofpoint-ORIG-GUID: D5PnAjjP77UzrFQaLaCvU6WyqvdZ_Ma_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NyBTYWx0ZWRfX0uTBNVQONTBb
 vC5qCX6xQaTxmc/2YZVC62+S9I52sz6F6ZS+dUMomf59mM8f1yNdOAQ0oaffmcUOhwqBLnmo5SO
 NExMpOjMgHshdX4K/dFudF1PVUAZCwH5QW27i78iFV+2CHkYD974uNnD6j5R/FpJHoT+Fd/tNw3
 IjGCAEQQYbrqD2cxjsElTSzx4xMD9HLnXQwcb41qj5PVoU9CFBTt7hCOMSFfFnX9oiB2OyFma9w
 2PzUeI7SfLdvw0heoas3OUfe75tx8Bt60/PRnExslnHm72vnwpJR7DJ4VwRiFNF84Yk3E3oxNZb
 N1ymUHjXa8haHh0rZ3jGcfs6ddUHC7lZTJLRWpIs8B5BgxXTn6IgZ9m3UrkLxJGcYyU8ZaXRXMn
 havEza+aVzZXxXXA7eCWH1TUAuGLJ/arm7h1sKDZZGuFskbzVSKKEaFrT54QM5g1ldij5WNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=885 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110087

On 7/10/25 3:38 PM, Bartosz Golaszewski wrote:
> On Thu, Jul 10, 2025 at 2:25 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Use the existing infrastructure for storing and looking up pin functions
>>> in pinctrl core. Remove hand-crafted callbacks.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>
>> [...]
>>
>>>  int msm_pinctrl_probe(struct platform_device *pdev,
>>>                     const struct msm_pinctrl_soc_data *soc_data)
>>>  {
>>> +     const struct pinfunction *func;
>>>       struct msm_pinctrl *pctrl;
>>>       struct resource *res;
>>>       int ret;
>>> @@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>>>               return PTR_ERR(pctrl->pctrl);
>>>       }
>>>
>>> +     for (i = 0; i < soc_data->nfunctions; i++) {
>>> +             func = &soc_data->functions[i];
>>> +
>>> +             ret = pinmux_generic_add_pinfunction(pctrl->pctrl, func, NULL);
>>> +             if (ret < 0)
>>> +                     return ret;
>>> +     }
>>
>> It's good in principle, but we're now going to house two copies of
>> the function data in memory... Can we trust __initconst nowadays?
>>
> 
> Well, if I annotate the functions struct with __initconst, then it
> does indeed end up in the .init.rodata section if that's your
> question. Then the kernel seems to be freeing this in
> ./kernel/module/main.c so I sure hope we can trust it.
> 
> Do I understand correctly that you're implicitly asking to also
> annotate all affected _functions structures across all tlmm drivers?
> 
> Alternatively: we can provide another interface:
> pinmux_generic_add_const_pinfunction() which - instead of a deep-copy
> - would simply store addresses of existing pinfunction structures in
> the underlying radix tree.

This option seems like less of a churn

Konrad

