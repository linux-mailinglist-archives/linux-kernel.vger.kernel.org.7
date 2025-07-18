Return-Path: <linux-kernel+bounces-737160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A751EB0A89F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6985A6821
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB142E6D19;
	Fri, 18 Jul 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HkaTDaC6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461F2E54C3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856742; cv=none; b=g4RqbZwFVtmU8V0BsQXwbIjOodwRs2ORTaqIYha25PCjh+l/eFjCMA5/VopUypAl/0Fi4pjQKYBF+0KxK/zEs3Uh/PhdjXe5dX8bKSkAzjOg7lZcwq4AvYMvb/8hQ8485ZHBSDNILVPesWhfE2IJb73xB9l3dflKXnrVceXvNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856742; c=relaxed/simple;
	bh=PKzM2OX2ycXMBs8dy8jvpWc4ZUaZPB/LY/5aZpqt0jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxeYCP3IoqtKxN0Ddhwi1HNUtDyBBRETTJ2P92yFxOn86M+juxxET6fv3fVISGGZ8kqzDBQDXbahvlp/2Kq3lJSlA6BeuT5OABfKObU7cMtL/Vx9CiH5xlgrVlQsK6J6euyt/wOJgI7aAsdzdqlFpw3JGU5RJrawoR79kpfYnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HkaTDaC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IEpVsl030488
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaUEOpwnu6NxdO/qUIkj5n83QZNRBaNn9dV7MFSL2zs=; b=HkaTDaC6s/J/40P7
	90dDaK0citrZ2sFZ8Dh0gUceH91jRj3u85aOcQW8/9fKKsQaJtJC5LpKt4p+GjwN
	CfNshQ5eVawT7etZrQMv5r4NSqy4I6yR5YJMz7fxppoSXQmgoUoILqeHyLIlLOqC
	wr8plijnScugHjHSisURYR8D3cey3Fb15zgURWipnhdmuQiTG6txC4mJ86E/X72e
	XQXibIQFHJpXhQbg0zzwlydumlKFVg3GGnjrjEX9Bx9Zi+FJtJFOCSAjxZ7qGed2
	ELPeGtIZG0iLMhnunHLkUCUFKomYtlg243qNdheSxo61fs87Q/ywYb9NyXoaLKAK
	h/d30g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s4kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:38:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso1761629a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856738; x=1753461538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaUEOpwnu6NxdO/qUIkj5n83QZNRBaNn9dV7MFSL2zs=;
        b=Qt+KFdZSUkvMUqYWtcWikHBFiZJzwq6ZtuFcsvR3XazvqZdRmr6KWrs6KjZUgWVdev
         DxXXLu+KKi5e85y+J2zBlvt0vwYMjKtvK3k9bSzIX4N1BVn5i4qB/f1F9rG0mXqnYl1i
         23nAzPiukKzD6GnadVOsUnyp7jk2CoBp2Y6lhQw0HfT4OqWTs9wtV9TyuBD5CME6czIm
         wTdruXRYacuhpqvUyD7FUXrHcjaRIwdk4AEagZgKUDsu3pKTlYhenLiSTSVcX1GfBxCi
         ilL8ERmHjPeI9bwihYLwoLM7gPbyj+gBE7Z5COfD+jjRCEbTH7w46GL4+XMzoNzM2SiK
         0vmw==
X-Forwarded-Encrypted: i=1; AJvYcCUbAYdsnhXT7sbsRkasakvgUGAHXY6OpMdXm09vy5xz7O/ZRCcX6Y9rYCmr/IBY6wYMYHs5Ok5/o7uxPNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlN2eGMZ5zukScFGp81pt4SLFZp9oVKTuUYwArlN5GaIH36Em
	wKJMkSIIQhP2JsgFk1/kCWyW3M/XX5wCEYH8Ft3KZAT3bk3DgiLzNKSPWv+E7pC3ozUIJaLWm9u
	YPVTjxcqAuL7fysBYcHaUJ5YxudwBm/Jr2A6VYPSmiVbi1A9fpreie+cmZuIB94YakFc=
X-Gm-Gg: ASbGncugcfOnGUKXNTl3CNwqlHZWcLDv1VbrI9/N9Kzcl+s6gKVA9amlnhiO70gLopz
	k7oIMHoIPciQLQyLjhREoHFtMEoaUEsKjyqvj+9QtuYS5ZN29gPm0Uwj2PZ9rL+LL/oBR3/JNeU
	iyb4HkgFOoIAk8JnrZpidMaY3Gk/ya7wJ0aqyqbr4mxcBn2PzDIrruA/DfsN1rK40lUCZrnVM1C
	eK98KTJ50tzRCLutEMz81gjhuEgLysXQmwKSAOSHo9jVYrHWVSqjr+PRp8CNMF9Jr1WwkYAnjqj
	CCX4ZLc8eS14iFdTcuz0fW1mAHAH4GrVAmFMdjUmvHIJGH0Ts92d4rL25+Ohr1/NOD1zW7ruPeE
	gDh/lEwkjr4GhSCOXoGGa8g==
X-Received: by 2002:a17:90b:3c09:b0:311:ffe8:20ee with SMTP id 98e67ed59e1d1-31c9e6f7349mr16793159a91.11.1752856738067;
        Fri, 18 Jul 2025 09:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/f3rHzk4HPCgwLaXFm4dfM3m4MOQeIgsDbrovnS/sFrTTPhvP8QSgCYuhbvY+4m4y3AewIw==
X-Received: by 2002:a17:90b:3c09:b0:311:ffe8:20ee with SMTP id 98e67ed59e1d1-31c9e6f7349mr16793103a91.11.1752856737571;
        Fri, 18 Jul 2025 09:38:57 -0700 (PDT)
Received: from [10.134.71.99] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46ffdsm1573045a91.40.2025.07.18.09.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:38:57 -0700 (PDT)
Message-ID: <5bc7cf1e-edb6-4bf4-803c-f84d51fb1534@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 09:38:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: Fixup x1e80100 to add DP MST support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov
 <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
 <b8d6edef-6809-4166-b936-fd000513df90@linaro.org>
Content-Language: en-US
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
In-Reply-To: <b8d6edef-6809-4166-b936-fd000513df90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOSBTYWx0ZWRfX57lMm1JtzHdh
 ZzEHJ8i+t8aHc1RPiQzNCBY4JcNnDJqiuPVaS+ZurvUUE4MwNW9M6UUv6x+lmsSvc4nxHVCjcPP
 DEfvfIP1Bu8gJLHkorSUauzUWu2s6MeTpFIvOTSnPpXpmPX/G6XdoPl7qd7xD2tR6ofJMXxIZW1
 GYo0XdSpQU+jaUAUZ1u8jEaT8yo4I/AxyR2NiLe82l8F8m1bm1v/Z7rBaJE7nJCZK2sI0wBBYIn
 j+N0PpVnLF30s9HtAcrviss066r3M9lBnGcSYFxJenGXrvLCT59Bdpo6NiE1ejgMmRolxmCauSG
 Ko9CiPzKS9v2nzU/09MawQHb9MrK3DkPrkriR8L5nXfrGGjHjTgVH9DS8Fsv206FjtCyactp1cm
 mTJDCrjDeYYyNsUcSF2a4ylUGcBc58ItNjLXAvgXNbEJiucQjsLjKs4cDwFqxMs4XnCR2rkh
X-Proofpoint-GUID: rY-DeSZmCU6QR7itlUlwMtHlDKC8Jsjf
X-Proofpoint-ORIG-GUID: rY-DeSZmCU6QR7itlUlwMtHlDKC8Jsjf
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a78a3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=bF9fvQb-GeUcl4pYUR4A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=760 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180129



On 7/17/2025 11:16 PM, Krzysztof Kozlowski wrote:
> On 18/07/2025 01:28, Jessica Zhang wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Add x1e80100 to the dp-controller bindings, fix the
>> displayport-controller reg bindings, and drop
>> assigned-clock-parents/assigned-clocks
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
> 
> 
> That's not a correct tag really - drop the quotes. If this was added by
> b4, I think you might be using an older version.

Hi Krzysztof,

Thanks for the catch -- I'll upgrade b4.

BR,

Jessica Zhang

> 
> 
> Best regards,
> Krzysztof


