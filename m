Return-Path: <linux-kernel+bounces-871712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C71C0E1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4920B34DB08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3022D73A5;
	Mon, 27 Oct 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMgqTSsl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D82FF654
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572306; cv=none; b=DOC/fOliF32YSyol7k7cBaUD5g8rtZRqiWYz0JGj1RS7lg+GW7YDRDtSiSIIFvvNYJ/KMa13N7E6gdpNm5AGbxB+EipC3VAqX3qmmm5YqM2EgQvZhWWBN2Y3/Y1H9R7o6rtq0nVvXOMNHXTDcb9mvlqo1VgAzuS4nxFEhZbI8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572306; c=relaxed/simple;
	bh=ShR3jkOuRDmD9phsKSqBsiHpNnX7kwC2gnSKmhZFvVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDa4JJhqE8LCP3grBX91N6K+qN/yHu7pa5M33sWBfUz/ZW58tnYsZaSKWy7hNFp62DW29drICFtE3OKx3wFuAh0qK/uRXKlIyBKdhnrBvw/dsUgZMG1YKZkGM7KjBLcRAOH//x0bb9Z5K6iqhhtw5+rlqikBUxou/sCnVAeCD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMgqTSsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R7K1I92059394
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nlqNAIoTMPpjwqW+Bc96s3wX/9oSlIUuj/zs6ZRUaZI=; b=AMgqTSslhd3ndFOt
	dqaVTSoL9I0Zfjiaw8wgPnHdQHVb0/F5h87o/XiWWAoBiDz+LQfBn4koPhk41kVg
	nmXaJIjUB9k1d+TxZn4KW5VaLDHR1BAWdz6AmQbj6O33EFRrOjHwePLeznR/va0Q
	iVL063UKzUq1hnh86qwdKmwsbe33i7CqOp3la95J3+H57hCZkeAUQGINL7l8A9uH
	Sa2/U9m96B0ooVBVl0sbMowjZBT3TD+kJkuqtjWgiKjUv6ZVmHHaT53aeWKo2EZ7
	PJP1OSpcP9nalsnDkDpaTZtIqC1wnaBeheHY/UAWuy7gIBG/Rf0DkVu3yvGm6SAV
	tyP1yg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a248p91x3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:38:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecee4fdb80so1270111cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572300; x=1762177100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlqNAIoTMPpjwqW+Bc96s3wX/9oSlIUuj/zs6ZRUaZI=;
        b=hu+0SBUKXlAiCx6Ca9BgGmbqATGVJKoqGHTKvMHo9KLIFlpruU6F21TFakhkLjOtDy
         wXSWhn0wlMWX5VYXtA5JjGU1wywwjKJo/moJNIqgC0JSiz6DoOgdA1DvsXv/K+/za7yx
         aIXdkVjLKT+WvjNOmmzTBRsqmAaszpuz7wrIxaOYzU0QvFc7cTcMjPqdVJJ7NsSZy8LH
         hBcI/RjiCZU6SlJLV4yxLvqcXRkeWNr3345w1CTNMNHwmPS2r2G9gEA5jzSa4H0r/Vwo
         3nR2+bc1pEisE3kZ3Z7ycI4gywPlyVyq/YYNNa6W83IusBMcY1LfA+VWdLIJlJ6Oowvp
         d1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXfOW+v43KJ8HFZR6g14wzQJC62x/pegOwvrt4eNfF6wL3bYBY8ohMl6Q72Swk6uHNYZu11t2ehews/5ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMUUT2fReKmpOZngptLjKcYxsiU9cMFl4tqbVyDZEIlIFsnOQ
	yvwuznrc4wcDc5uDJgikq25laiS8ZTzc7F/Mg8ymfNKUO8MedFogXN8bmQHTizJ9lnoMzKKVucK
	x2AYgvhyRb7IMFR0UcZaxKyuOnGMv3fNvtbR6P6K+hhX4GX0WqOqlo5YZ2HTQtHVXK/k=
X-Gm-Gg: ASbGncvx5+ClbCuC0MMoiulNKLxfNScFobSMkA/S0DMeOhGwaO5gU4BWAir7NJB98df
	7/GLlv3Z0VA83a6D71hBrZrK4ixBGqy4eDARI7rOarAPSPwXwIWA9Clw/1hJWxfn/9SxhqBEDOq
	cHfTZ/hxz+yB4NmaV0OyFj6L4wZ6R2zR+nix9mjq6EuXUXttENpagnY4Hg0/WZedjGy3BOwA1bO
	//inM3Wjvrf2YgdpZsHmxSoE7mqqlrfJdyvW85D8y01Va10jOMTdOVLWTOcG03+MkCa6M79IwF+
	rImQeB8fPqfv6tVQkWlNWzyLVlJkiO/THGBIJYBlGqpbjerFDw/FpTFuYMpFnVcNniG5l4lmw1t
	5Si7gBweBWsRxQZu55FqUlqjSuYWrkwDu6vbubbn0VXMOfuasM/D2ay91
X-Received: by 2002:ac8:5e10:0:b0:4ec:fc4d:372f with SMTP id d75a77b69052e-4ecfc4d794amr21511061cf.10.1761572299579;
        Mon, 27 Oct 2025 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM17AQ/vx93xjYF+FCEIiTUB1Xqjgbo4dv3HEB6b+9AnxRB7kb74w76dLXL0z+Y2f1ynGSYw==
X-Received: by 2002:ac8:5e10:0:b0:4ec:fc4d:372f with SMTP id d75a77b69052e-4ecfc4d794amr21510891cf.10.1761572299193;
        Mon, 27 Oct 2025 06:38:19 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398463sm747816466b.34.2025.10.27.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:38:18 -0700 (PDT)
Message-ID: <490a7cd8-b093-4f25-9c9b-85a3c2d86a6c@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 14:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: drop dpu_hw_dsc_destroy() prototype
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251027-dpu-drop-dsc-destroy-v1-1-968128de4bf6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251027-dpu-drop-dsc-destroy-v1-1-968128de4bf6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=68ff75cc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=S0UzETgM28_sssm6r9IA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEyNyBTYWx0ZWRfX/VpMhgzJGRWK
 qhimBIOAqvNgkh1GazC0Yf5WGBKTNw8OiL7UPijRJ4l+SJjrIGLbBRwh1Shddsycunfmg1Z72Uo
 vuoC9Tvi5caVuln/IXO2JDItNWRZBswJrrqrBOj/iN9QbiVpLpb57t/sCSJuZJYRzyOGCKDP58G
 X00/80uLQx9gzoATuLIdhHfvBr/2P515VR08Iz/GoXoHnU2PIvmq42BgxJqdKXy/EPBv/2G7P9Y
 cwKZI/xkDof01QPzR6ewCsH0cZyxXWOcARibUPrglh6otSyduIEpChNDkmAnQFVL4VxfGjtMLy4
 /iOZe00Acy2L1wYccc82t15ZSSy7Q9Kg0+Q5ldA2dc659LYcg3csfn4Hz/sX3gwQj10af7LOzGa
 X0Do2aR6DUac+PE3hWKZBwARdLnVNw==
X-Proofpoint-ORIG-GUID: RDgO8eeTZfl9A15yCaU8SwM6fsDp1pIX
X-Proofpoint-GUID: RDgO8eeTZfl9A15yCaU8SwM6fsDp1pIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270127

On 10/27/25 2:35 PM, Dmitry Baryshkov wrote:
> The commit a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for
> HW blocks") dropped all dpu_hw_foo_destroy() functions, but the
> prototype for dpu_hw_dsc_destroy() was omitted. Drop it now to clean up
> the header.
> 
> Fixes: a106ed98af68 ("drm/msm/dpu: use devres-managed allocation for HW blocks")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

