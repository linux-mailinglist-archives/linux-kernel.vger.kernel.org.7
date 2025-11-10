Return-Path: <linux-kernel+bounces-892600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23CAC456CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C09C188B5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32A2FD690;
	Mon, 10 Nov 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIMGygyt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfnyEdFI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCE2FCBF7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764489; cv=none; b=c5iPV4GsO5gtJkZUueqFDXqYHAIOpZeZk1RskR/FBStFUJPIiEeY7vhk3Vj5sSPQhV9Z+UbEgAMvSJt0xY/hVvx+JUBCfaULVuYdno1KfLK2xzBQN6mhjW8mi7LoFpkhcfsXH2dssrMcPQnIECNheUBtCTWjb5SaawNzqHjCtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764489; c=relaxed/simple;
	bh=/09ubiYSvNP90owkjG7kLk/4oieQ68xZfw/hAWa8hFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONMStCYiiSzRsa2GTlHLC8jZ1m3aHNED2Bdt4zGaRiPR4rg1nSMyy7UzWiYcg6bRgGvPPoaQ4XlFJlNFHdfPPERgGios5ojjMzYnT0c6EWNKe4P9Jm8c0JAnGX+VMZsUD/hbyhewG670LPOoG75UEJbilYwHsCj068AwTQX0e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIMGygyt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfnyEdFI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8C84A1194214
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=; b=IIMGygytKwBRvUW4
	cm3BTV4joWjcSyVupv4d9kQFRR3EVVUJ45SEybdi6dtIC28cCnn4+jszUlJ75LDR
	qt89aafLAXMXV67TIe0V68Nvuc5NULOzfXgaXgU3azJifI6EjwEas8dtzqZNpvQx
	oodL80rpT8N4FFso0SCrTC+tVcuKg7jnRoI4KPh+eO7bcuTcccmA2yGBisaksVT8
	DQNHUtnZGsviCL3wN+z0HT5wHATiEQWolLvG12KypRZJrNYb5lK3cykTP1bpqT4J
	UeCY/j6DEEpp1D+7LLYipGwFGogsmXFvLJP27q2TF9UisysqoI95mvU43JuQQtuO
	SVurYA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xs7c0tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-341d25dd92fso526199a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764484; x=1763369284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=;
        b=XfnyEdFIhM24kL0SJiLbHgLY4GkxXA+NqrXO1YqAmi2T79n2s+zQRFKm9D5n91p6MG
         S7ztCZttB0t1D5WgKSI1pu+K1C1dqMpWTkI+V6Sa3k9Wf3zSfymUfynO40SIFiku4NDa
         oh7yqmQTm1mwiraNoxdBIa9vcSl6ma03EZchWNxsrvQKFSM0NmsBS208F6NxH1o55jQw
         WJYzJKQP7U+4GaFltf4LrlQl5WWs+7hxWDwRWIFXLZNgQhZcKaiLX6HZyYw83c2SzlyM
         mes7KbSRy/snBLuDG1VhPpPSRn0Dd4KirxaYyZbbKxQY7RmLogear5bg7XOmsPBcSRov
         grjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764484; x=1763369284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nGxk6cvPgoYAgcOQslEIVapMqVsIaVsOVTbE/MMoYI=;
        b=hRsGJuDyuIVOOifTlfh3xzMtvggVIEY+oy7ABOuasGnmJi/7Oschc2vjEzv3bPbcPZ
         0NnwlSggXMoDSWBQwB1tUtJPhL52I7BSTKwUXN/SUQ29/5f0RU1qOaJ9qZrJwdYgu7RZ
         qui5nUDXntuJLPcZp8CrXIyLiEvVxoeN3ffTp1JMNHIKmmUpmZMMHVUlI6Uipu5thsVt
         Xvy0aAsUohg02FoKbmyKFtFrV1KqHy7qhTrC0Am3LVklYKeIJOyb9JbjZ4uOxWHmEeXs
         vZ8T3znSToUOZ35VAdCnLvP61oLVdPlMxZK5TFIC5VQH7c90b8JDtUhIr4jASxFQC0kf
         /nUw==
X-Forwarded-Encrypted: i=1; AJvYcCUTUAf3LDIdO8/fdmEd3w4kDewbdsmR9mFgoQH0JwM0cz03ProHdOJn7EOEzxR07tgDqEbe87g8u/wYxi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLHmVIoJp18pTpOgRzHeq2cy7RPGtPk0Yfv72a5ZMLtTBFPTNY
	fWnv6htGmMmwLzvCh20fpkmP2H/uW8MWlcm2GmS1TjrwyLkN+MSoy9P3S7S2kyktQeMVl9Vs32D
	RMGMYgIKa9Q63uqKU9ycckFOuvq2hCPelI+J4tiSqM4BoTPtXlzWOUCN3IVl6C+o7lQ==
X-Gm-Gg: ASbGncubqg0GpU+LBoihcfF3RaRM6Mh8V81GPGSpkCl193FQyQIXgmP5dA0cxXfgvgs
	wK662VxBfIj+1o0Pevy9BxSBQERza9CRc3yQwXShf94/yMeuP3QxJkdWRuxw6DsGG0lkQCRzvbF
	iOxfsMHEVPX8UzFlXuA0zIRmV/UCtamg+bHJNUj/ZqFY5Vy1PFQigSt1u7IJBsxJBNXqq6a2z1P
	raX1DATofAXLKBPDsJvJrMOD3TtIMBzXezr8ABm+GJaS/oM/JqxAEXkUKdQncVqek8EXKyzNGDZ
	53BZk+6+eGjvJZafG0RjcNEazct3X9cRJhFRUqUi8qs1T8CPCxQmZrg0/LyiPL2W4kBhLUkuUYE
	wDXWlZPLcy4+402c88Gkse4LpqvHv
X-Received: by 2002:a17:90b:3b84:b0:341:124f:4745 with SMTP id 98e67ed59e1d1-3436cd09f90mr4674121a91.6.1762764484005;
        Mon, 10 Nov 2025 00:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJwIzD534772Ry6R4QdPTmPOBMOUdlbjY/PmzhZ8/CXG+4tHCfvMhyh5bIkeKoYzMjfqRUww==
X-Received: by 2002:a17:90b:3b84:b0:341:124f:4745 with SMTP id 98e67ed59e1d1-3436cd09f90mr4674108a91.6.1762764483412;
        Mon, 10 Nov 2025 00:48:03 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm12380935a12.21.2025.11.10.00.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:48:02 -0800 (PST)
Message-ID: <74123422-637b-4209-96c1-81167e51df36@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:17:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] arm64: dts: qcom: sm8750-mtp: Add SDC2 node for
 sm8750 mtp board
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Abel Vesa <abel.vesa@linaro.org>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-4-sarthak.garg@oss.qualcomm.com>
 <4394142b-c96c-464e-9e12-80904755026e@kernel.org>
 <ccce6ac2-c744-4b94-abca-f5710c712bc3@kernel.org>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <ccce6ac2-c744-4b94-abca-f5710c712bc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Zbmpq3tfVqe4Mx35HLZgAiqBVlh0Die6
X-Proofpoint-ORIG-GUID: Zbmpq3tfVqe4Mx35HLZgAiqBVlh0Die6
X-Authority-Analysis: v=2.4 cv=LtifC3dc c=1 sm=1 tr=0 ts=6911a6c4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=QHloIlzF21OiCPf7oj4A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfX/xm0DzwPT8Ss
 N56CCZEcyg7mXp9vLlmxX+M09L0IunG/R9Jve9VFGvgbhynAzR9SXK3dXD2CwaL9L8w6fEDV0Wb
 klhWhIg2+5lJmA7NCQaJyKi23J5KfL5RE+74uJyUFM6RlUtJgF1Nu1+26x4siNjFpw8aDk0xwcO
 eA0SK2krwW+g+W4yvMJ3CjZa4T+S2grozooz5UBJKwlc+ocFMrEVDCG1n7lQzVeovGiY3nbTIRQ
 9jgdG3+lUjY7Ls1sNik7jZu3rbT11GNeGtCBmtogYY+gU//mPNGdXND452FMGkp4xNLR/ftrI8h
 O1nGLQH69R0XaEVAAwWHsLdPfOX9AdwhUmM9yfUhANCox8joOTD+3lSG+IrOA9tVCNz39+38Xm7
 o2DOhdm352vxlTWiOyxrJu4ehRdqUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077


On 10/27/2025 8:03 PM, Krzysztof Kozlowski wrote:
> On 27/10/2025 15:31, Krzysztof Kozlowski wrote:
>> On 26/10/2025 12:17, Sarthak Garg wrote:
>>> Enable SD Card host controller for sm8750 mtp board.
>>>
>>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Actually un-reviewed. Here also ordering is broken. Please follow
> Qualcomm style for ordering properties.
>
> Best regards,
> Krzysztof


Sure will update in V4.



