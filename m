Return-Path: <linux-kernel+bounces-860284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE0BEFBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E660B189C2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7722E1F04;
	Mon, 20 Oct 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iyjpDBVc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2E354AEA
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946842; cv=none; b=aO4oRl8TrMyG3MTpxsnpZ4SsjkyHoq9Ov4tU7uTnHJdiTp1vRecoTlVWWVQe6mNbuuH3o5CRV34/y4ibtwqniYbNXb/mb+UdR6Ahd3FvYuZBjopbJcoYEQynMQ7HW3qtEkjC4T4oXVzAnad2JWtg6JVe9Nb+liVPE9HFiPF6E5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946842; c=relaxed/simple;
	bh=J9f+oiQDwLpd1KItLRGcX2lkXCnsuxnjjRF05bHlNh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqk+fZ8cK03tiU2XV78kQPYYwQect0hHkRpyTD3GYv6atDdOBju9mMWkQhsvkregsEbB7A23E98dwMDra194KomBnQPK86xFiGN7acJTJnXRUvjqvN4oYBi9V2BpckSJlSriUFvLx1UcJNc6Fk4dUipCotKBFy74BnOv6pSD/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iyjpDBVc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JJHPbw010027
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LM8Wb4xKnXMWYUb3EVKiXBuMBJRUWQkyl4ilJog4k/4=; b=iyjpDBVcH7Je4rLp
	cYkGTjynusYe4ujH/nbc88urUNJGZqocwL+V5VkVIkzwOMAqDlx676bhMLz3I2Zp
	GUZgzqTEwU583drosSwQZfmc1Tt0LgXwc5g/z+dow2CZjpsWkHmphGmBLcp8cOp+
	KgkmRGQYAyUbAD2ujideYQyyh7x3w4zJrub6jzBgg633MLNmda25muXmeEAO4mXE
	ndid3/A6UzjNBr8QWigJxPjn8wKaWXJVPSTt3oAOKvG+E+W0uy2kBqG1W4YZEqf8
	P0A/1XaL9UzABAkikKu4NqazPWiAtNxQz2deqkaearQUUy9gz5uPg5BqfAOhpac+
	XKovmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfc96g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:54:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e965f2bbfso184000285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946839; x=1761551639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LM8Wb4xKnXMWYUb3EVKiXBuMBJRUWQkyl4ilJog4k/4=;
        b=hR3V6f5uTvNVEh7QvQrbwHT2bHNDaw+MuZI4OyZKL4GVJnY57wnCxN+alfEQbOh4Dh
         pnQ7aRTY61u2LL8JxQnf7/+8+X+XNNMq5KFy73PNzriYyyn9VroQI8T3W8pLLrOKkMmB
         dPDXdPUBZBEnZeLYTWdgYq47pXrW/1FvNGN92u2Nf3dUQF1he80J1DbZJB1MPg37y3ri
         3RX104Iesjv+Kc7bQxwkEdYwtWqLYm5M2FsjajkYB0Ce2GGPvwQhJvG2HCqHXBzPSPLe
         PCqWjqZGQ50anwa6W1AuXZxIoI1guPjaYGm/P0zxuXd+rVeow94KF9Ss48h8JW4uq9ss
         vVPw==
X-Forwarded-Encrypted: i=1; AJvYcCUXsVPeVvg/h820nwFLsMJe82ASJwjdczOZAQWyxtht2/DA9GghVFFAVrfnXG95WHuj314pceRjvTtNoUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/W/JR+02EMSAEmqv8TDmXffCL9ABdwMV2KXTChAdu17FSoys
	A/8HbKVVlnLARVOJ2Dj0ay7YD5t6Pak9xQsvTkoRPxY0nCUdJqwLFLqxaWebnldD5KV12OHrvHL
	0UdI40t486TcEaHuXCZpVsUz49WvZIysJp8pxZEB/wgxHcIAsvcqi4zVYNfXo8JD8QWE=
X-Gm-Gg: ASbGncvAi7uJRF29XqJFBbjsxAMs2+Za1RnQDUH+/fYocvM7qabhxGd7VO067k0HcDg
	2DxzU/V+EeERSlJ8EJjO3el3CUJVejpRgeY4rKEkUc6CV+Ygvbp9LnoPCVfE0wvs22riIza3sJ1
	8h/hCr7OwQEuS+5Inay3tMDeaY2Q87R2rPcbhS8VfjgmoyJCfu03MNcwOIpP6w0XRQn96eLAsP9
	XzgLx8xOMQ4z3Vdn8nhQXKR2y4Cwlna1d9salPmCjtTT7uHZ5B5G+BiGur2c2FoJLy01Xt12IPi
	To+b5zk3/mMcIHXov/eYwznWgbKuwgeYCdFPz2JXa4k0+AMjx+T3YmkdTJf9tp4OQ3Gqd976u4Z
	rAHRT//H3BgLtGOvzLAZV+27+/m4LPwMdyNS5cuu5m9Q4w2etYm/7spBI
X-Received: by 2002:a05:620a:199d:b0:864:a09a:e860 with SMTP id af79cd13be357-890707f70e0mr918100185a.10.1760946839350;
        Mon, 20 Oct 2025 00:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZp+OC5Adsa0c1sBHHpTL1fc8+Qf9FzzDHNItwHbY6gNDY4TIc/2bJJHggDLAKLYsjXguHw==
X-Received: by 2002:a05:620a:199d:b0:864:a09a:e860 with SMTP id af79cd13be357-890707f70e0mr918098685a.10.1760946838910;
        Mon, 20 Oct 2025 00:53:58 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8393778sm708060266b.24.2025.10.20.00.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 00:53:58 -0700 (PDT)
Message-ID: <e51e8665-0245-4ea6-8c09-c73004a34a3d@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 09:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: qmp-combo: Add polarity inversion support for
 SAR2130P
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20251017203438.744197-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251017203438.744197-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f5ea98 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=BrIiScFafQzKgqpYfbkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: c8LnyrNRVWd-MMGWsLwLpWvXFE_EquDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX/q60nsL7A2AZ
 XLmAs6s3q6rrAQjeU5pY6ANKjzO+6ShdP/IqQpV1nK3JYk5zjyvwdeeeIoZbPTJ7LkhbzQY+2d3
 fuKMcyfBWDWPop45r5YDhwp1nXYhfHmmJSLtFYX7NbM9aQiqUVc0bEz79mox3NLmyMggAAS4ELK
 kKGvrTZI3t/G4Ju1U388ip1o25ywjpSOpJvEc7ExPRjBbVQGVoZb92gsMfwsIY9kSZqao/ioxdB
 +T3UDwsL990NH+r6VSb9QaOE59wKvChDcFh73/VMpGB+95FHfgis6SQmUryDEDKkvCGgwqz1t60
 y4gg0BRdmjR4V0uGs7rRYkwOQi45J2l9A0LDWIRzwvGnqq8jgPqM4uVH5FcexSTA2eF2PAJJqtm
 woT6VIzlpQipLg7UfYB9g8eTtGyzHQ==
X-Proofpoint-GUID: c8LnyrNRVWd-MMGWsLwLpWvXFE_EquDg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On 10/17/25 10:34 PM, Krishna Kurapati wrote:
> On SAR2130P QXR Platform, the CC Lines are inverted and the lane
> programming is to be done reverse compared to other targets.
> 
> As per the HW specifics, Bit-2 of TYPEC_CTRL register indicates
> port select polarity. This bit is to be set for SAR2130P.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

The downstream kernel for this platform corrobates this

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

