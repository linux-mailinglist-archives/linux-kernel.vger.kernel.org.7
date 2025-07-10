Return-Path: <linux-kernel+bounces-725646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888B9B00209
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F581CA08A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45D2D027F;
	Thu, 10 Jul 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GvAHkV1D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDF2571CF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150628; cv=none; b=uOWhi8kv9zl4sYVqeC3YufyKyOsJqh7mrWJ5lIP6FWrnpBRm8rRWjFlSwaoFvBeYQilT71Mya0XyUJoEH6GG+6CtNQIANjtx2ZSVuQoIs0DNr/JbwRr4R81/vvGzRAtCWZsf9ZT8/GH+jVVQgAoVr606C+QVeJiBF04714j2aIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150628; c=relaxed/simple;
	bh=WUgGtb3FaJy2c6fVmMZ8K9Seh3fLz4hey9Em2827A1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDgVC4gPism1QV4XvZnjZeFBt58Ry6Oic68HEJYDAMsN4osAGE1OimeajEbYW42wP7DF/AlJNpcuL/a3n+Cp+TQpf6FDVDFndUuC33CkGRON48ijJ1W6PyXKIG8rb9NgFAZN2DEw3FYcZ2TeTkeixUmVbaL08P6WDoa6a2HxkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GvAHkV1D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A96PsS014493
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	15LoABqpDtCIfi1It9cCfUAX1KivEg4wXRkHbkRQbuY=; b=GvAHkV1DbISamq3D
	SKvn1J+QmP0su7Bxm4EJlhWwxpZXQUxUz8hd6Whpr1uBSbNjFoEi7KjHbfG544mT
	OYY9q0MrKi+MF7QoSSz8/JlWKufKbJZe9qRWt2UzP51aSsf37eztDP7DtCehT95F
	LXYsE5ENzw6zBK9LK+CEjqkiJUrCNeGtXHgy2VeQL0Q5dIwiKN6BN2WYVU6rxeLu
	7b/TN2LfiFNmCSlbMLaVKxJfS4xJbO2d64tcx6EVujoV1qGT4bCyXmpoysOKLMQJ
	P+nVEvgTbX7elXBzS7nRRizVw6Z/uk4BkcC7jlEZkcO4iDkujZwKBgKXmQKgcdPt
	DiT1KQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b15uk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:30:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7cfb7ee97c5so16092085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752150625; x=1752755425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15LoABqpDtCIfi1It9cCfUAX1KivEg4wXRkHbkRQbuY=;
        b=ggFFUt3YzdaP8+E8ZZT8mJahE1tC2Nb9pSbpT2u6oIqS8HZPYPBrQMW0UPxrnUb15N
         TkwFhfOuoGRU7l5DB2Ciy7ZQeAdKUQWGJeRP80gkV7/yRklF2vl1w+VtUWzotxGW1Vpc
         zmKRIQUeIW2R22lH7r914yTsekjpeWrdylm7GK3nIF0tN9Ed9B21LpyTOk03TN7bboM2
         E8iTLnQnTw3kAWOV4N2am0biexmihxoG+atWMISrjLYDl5AUO5CNilRxYqjMmtmcCbW2
         SC2SszUajOWD+tFLk1vG4wGbCuUt8xTxr2Q8D4Ooo8EuFA/I1imdlPkvaWArtT3n14Ls
         xAdg==
X-Forwarded-Encrypted: i=1; AJvYcCVjaaRvYcMKlsBHJ8m3en3to1Qmi9If2PkEan0BrWkyEagd1anomNGoIKYxWzNJ6GDZf2+V0lvb4fsH/1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByh4M+qaaewi03Kl0HLteq78hwDSTl2k63IOIN938AtJfRVJO
	uiMlW1Se74QKDWVwUPxXjevtmZ0nxq1ziZ4vF0q0fh2p/7Q6LdBtDdScQCbCayi7t48VfNqp7Dg
	KKWyCCVJaU4ZDhNLL9YkNeasP2O/pO7PuhzXW+M5SlZwMeI0h5Bm1UUPXngO5z7+2FeE=
X-Gm-Gg: ASbGncsUYXMT82SiwY9yxXJbeUZ/2IwT4u3CVz4HtCa23e17PdLQJOXjvjuzezpqWhJ
	ueTNjigUsVYqyJldZNc7WmJSfFF3HO2J3xYLGMs+7LhhFOd7vemLAUOSB929d1VwUM1Hw9BCGdO
	wsOti08mr34YxAPhlympIa9kX0++PZgNVVgE7G1kZ5etcPkmrxYsoyVG6Ixw6eFxbKNt0h5TnaM
	b2arDdd+cjEt20jDrx+skjT534/p/myY/MPxZ2BpArbqWgIvshoKyaLw7yrk+rePEMGSkPOQWEO
	aK6z6TtTzGOrlAuMvBTLk6AhRvA21DJsftMr3T74OoSe3mSqvB4rkv9nEh6DM0SxMoNgk4H4g/I
	uGyg=
X-Received: by 2002:a05:620a:2991:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7db7b32643dmr353143585a.3.1752150624646;
        Thu, 10 Jul 2025 05:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsy/uwC8lYDsPl33xS2aWjef2zzPFzxubl0Sd+4pv/iDw2dT0HSHhNS3QAIS3hF+0xe82zKw==
X-Received: by 2002:a05:620a:2991:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7db7b32643dmr353139185a.3.1752150624050;
        Thu, 10 Jul 2025 05:30:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8291bbesm121349866b.126.2025.07.10.05.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:30:23 -0700 (PDT)
Message-ID: <3604f025-d04b-4d40-9d7d-1f9ce147c5db@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] arm64: dts: qcom: x1-hp-x14: Add support for
 X1P42100 HP Omnibook X14
To: jens.glathe@oldschoolsolutions.biz,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250710-hp-x14-x1p-v7-0-19c10c81713a@oldschoolsolutions.biz>
 <20250710-hp-x14-x1p-v7-3-19c10c81713a@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-hp-x14-x1p-v7-3-19c10c81713a@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686fb262 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=cH6R9-kdAAAA:8 a=gxl3bz0cAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=co6Q_9sMOBM-pvAMSzgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kiRiLd-pWN9FGgpmzFdl:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwNyBTYWx0ZWRfX67rEGzw0V6SF
 PpgplmyEoZ/fi9LGSDAcQDiNfkJ4SCutFnqkbBriB8y0U8wQK6AJCXmf9uLZgC5VUlVugzeHw66
 35UCAgH9t3d3FjPFgoDeE5R3zWJePwrTErTUt706Xz6PVo4PKzccBvOW0QCgdbvRmNsEom8+KlA
 QNdqXpkkSlavGxm7noiiNrC0GZaO6IYVN1PyzSlHxtd4K/P5LuMLep3QUJ+KtjAdrqCzRu7gtTs
 e6gyGT6Gv4c32PXMpurCAu38uMk9Kwp+FY6bcYzRobrs1khnOMRz+tzAgt390pRMtWz59AgAfE7
 H3y0khBgMM8Rdtk3IkMxOjMXSGgAElpNi6B/vSJuK8KYMWVr1tX6u4svqQS37cz/S24d6ldMbRM
 7vGB0OOaQ1FbYVvnzEnCNP7Se9wK+5joPQla6IJrWuDuOWTU56oqwulx0jItKOO/AKa8DqUI
X-Proofpoint-GUID: 3trDpRB4NL35IWggv8Z5n4NGjqmQ6401
X-Proofpoint-ORIG-GUID: 3trDpRB4NL35IWggv8Z5n4NGjqmQ6401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=897 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100107

On 7/10/25 12:50 PM, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> These laptops are the same as the already known 14-fe0xxx models, but
> with a Purwa SoC, SKU number 14-fe1xxx. [1]
> 
> The supported features are the same as for the original Omnibook X14:
> 
> - Keyboard (no function keys though)
> - Display
> - PWM brightness control
> - Touchpad
> - Touchscreen
> - PCIe ports (pcie4, pcie6a)
> - USB type-c, type-a
> - WCN6855 Wifi-6E
> - WCN6855 Bluetooth
> - ADSP and CDSP
> - X1 GPU
> - GPIO Keys (Lid switch)
> - Audio definition (works via USB and with internal speakers)
> 
> [1]: https://www.hp.com/us-en/shop/pdp/hp-omnibook-x-laptop-next-gen-ai-pc-14-fe100-14-a4nd1av-1#techSpecs
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

