Return-Path: <linux-kernel+bounces-859334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E731BED520
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E477E4091E2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17932257831;
	Sat, 18 Oct 2025 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThgRpO1Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7787252904
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808169; cv=none; b=OMiG658AV7GaoDzzk/UKoQg+gNUjLml9/psZRcmNOIfnYvWB2Yi9iWM1vGfeY4fZ4V4czWY/tiodqSmnhrM4mP70y19Oi/HcWMBL0gUu2Lh9mx74iYFhVhhrOgHjuLoloU9CpuqAQI8SyoYqfCXt0OMLRapeymOqL2peHz2gZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808169; c=relaxed/simple;
	bh=T4o30Ly7z1dL/+pRib9wWuuBLScbU86dya7bhkumaY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5UJRsBYzbQVclbq4OQQsghoFYDJM2QIGeuHTSYu+h/U3sJK7mFryW+5sTzPeXC52sEa9YfHo0Pv0OuyFf3dHfElapePk8WC3BrrvxRL93jWhHADB0QsPlwzuvrV7XLDCq0oK/NLr+NBnGGbaqbRP2ZUWMgjXgntkAa6tUiTDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThgRpO1Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IERWqI022238
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xHAw0y/tTpyR9i7DoqWICZlgljM/FqM4gBUVCdIMhKc=; b=ThgRpO1ZBV/in+9W
	1z1HtaYBhg0MKpcUEzdeTR/uDv2YpJmOiclx6ahfD4yBEZgebmXLSuHs501o5Rb2
	drR7/jmn+fQhosrJWqkIANUJS1YGl8cXono2El0nU4cP/MywxFOovNIuNMs6puSR
	FohfSN6ClxvAIU9Hf3QE2d7Lj3KLdMxvYdRJd3fa1wxeO7hwINgTblJQTgABui4H
	KSoCilNF+FWif/Es82GEz89xFXAqmTlK/GDYWFoosKED0sK5k8tl5jVRP+M71ebe
	shik8ogT9nANcZvByk+zqNe9Yf1urlOzOuVP72RU8492+3AbCez1u5ojwjYVnpYH
	Q5yBMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v398140m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:22:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290d860acbcso40176125ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760808165; x=1761412965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHAw0y/tTpyR9i7DoqWICZlgljM/FqM4gBUVCdIMhKc=;
        b=CVwKfMEID2JXnoU6oNEl9prKgaq0hIgzwcfrnd0nxa5/ioQ8GpeoL1/FyhSuzS4V+8
         UOe1e2Qv4YNEutldvfRxH9xPEi0Uqu8m5oG2He9oDHGVB1MeVohkob0ixfkA8IFyGO1m
         wTnDglu3nnZ/004++/rJknzxfEauWsQUgS9fLSVxw8mlL3k1er2msjLyLSYv7x+bAPUi
         Vn+38SNIxAZOD/hDh4aLcWR2h/5NHVxCcgPaGw8quB0Aw0/12Xkt9hHsDY3USqPxftu7
         u6g8mVHNLzvT8OYNPWzECSjHZj8KR/m5ezkc50Hdxb1ppeOv7FWI4hBETEpELDK6MqBV
         BmnA==
X-Gm-Message-State: AOJu0Yxsb0QVjskM9J+n3/z35R7VHtJOu/PDWchArLgMl+eHisFWQU4C
	HayqzJVHeB4OSDF+1LmsKaQUrd4OCI7buYoEYzM9Jmo+UbOMCUZWLU1T03XfVti2LXzpqd4uZ5e
	PXf6xWhnYBJzW1y83oFMypK5/LlpLtsRx9Xs4jXKaqLokWVbfoiG/g+JI7b/VkkysJTc=
X-Gm-Gg: ASbGncsYmazvFnFhEty1eTp5K2yMgZFPqCH4ocbUaPaG9+B0JwzayL/BEM0aZH+0nEy
	byXdW542Cvw0zuptNdASybVz5SGLszr1toF5Nmjmq0A5V4v6grp/9U7k8n4CgLTP4ZkYlHk5XHi
	TI7/t4mIidHlsnlT39UiLYzXu2agkihbnpZgkLRdEU+XUTCMWaZUstjXZAu512KCcR6rMpgV01Q
	JNlRAilmAZNgzVv3auGjnsrlzeVLpueC4jyQAQd2UvVlZLuumN3L5pu0iQJK2UXqCocmhytQm1P
	KVpmQEvGmAKCDtmJM8qV9jSpqjHSBzJw7aQUCbQpqii1wAVOaP0pUyoXaRVgpNx+SetAZav57fs
	v6MOxL0Ceaol9wVbx9uHbN8W8cLN7zr0UNag=
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr91901385ad.53.1760808165028;
        Sat, 18 Oct 2025 10:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpctDVKVzG2FSIoWcltU326qSWOqkcHTw2yTearayEesHzEDLwBn1epfEpPRc6hsNirHE57Q==
X-Received: by 2002:a17:902:ebc6:b0:290:9a74:a8ad with SMTP id d9443c01a7336-290cba41dc7mr91901125ad.53.1760808164581;
        Sat, 18 Oct 2025 10:22:44 -0700 (PDT)
Received: from [192.168.1.3] ([122.181.214.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197desm31031835ad.115.2025.10.18.10.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 10:22:44 -0700 (PDT)
Message-ID: <f3b23a7f-6bce-440e-ab89-baaac4320065@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 22:52:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SAR2130P providers
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Heiko Stuebner <heiko@sntech.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20251018105125.1504302-1-krishna.kurapati@oss.qualcomm.com>
 <83874b0d-30cf-49e3-9049-569a416bef0c@kernel.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <83874b0d-30cf-49e3-9049-569a416bef0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KcvfcAYD c=1 sm=1 tr=0 ts=68f3cce6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=COzVrc3/y9xyZPF/JXNSAQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4xX8KCCoGA5Q8DX3_e8A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX+wDcQCarjbSd
 Kq1r3pRyty809m1pzmWI6K1Tyf/fY1lGDUKZg3xIq89w69VSsYm1df30mo6Mnr2FxfA4qZM0k58
 kVI+runw27Hxfzm7SOCYLwYEMpk75TEB5tJsR1AIv5IHqUrCtyYZlSfdaKbjjE2LyzChanEn01f
 gZP6XOB3oiGbJHlLt+l7P+n+XtA2/C4ZNI/paaAk+HpG1f77uGgL4TtIziyhrkcfrQIA+kJFzpn
 6pbH56C9tsDoT2yvWwcH5v/YNvBVTErXPX4GuAWKExUcOABwDsB4XyKWNlNRy/QMmbVbfqlKyDw
 cbtr+opnHPZiCCGjgDOQFms+1tTtWS2dQb2Z/TZVs1h4LwedpDamufZx2s6khraJuJQ3ajS7FJ7
 mLWV8nISy+oeiZS4YlwGNAc2W1XONA==
X-Proofpoint-GUID: GX6AYk9pqWzXP9qzKjTbP4Qa8yK7jAFX
X-Proofpoint-ORIG-GUID: GX6AYk9pqWzXP9qzKjTbP4Qa8yK7jAFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180025



On 10/18/2025 8:15 PM, Krzysztof Kozlowski wrote:
> On 18/10/2025 12:51, Krishna Kurapati wrote:
>> The Qualcomm SAR2130P need the global clock controller, interconnect
> 
> and which boards uses this? We do not enable things for SoC. We enable
> for actual users.
> 
>> provider and TLMM pinctrl in order to boot. Enable these as builtin, as
>> they are needed in order to provide e.g. UART.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> 

Hi Krzysztof,

  This is for SAR2130P QAR Board. Will update commit text in v2.

Regards,
Krishna,

