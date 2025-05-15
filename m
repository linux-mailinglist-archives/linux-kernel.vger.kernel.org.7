Return-Path: <linux-kernel+bounces-650043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECFAB8C91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF23C1BC17D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 16:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B827262B;
	Thu, 15 May 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LiROpoKj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D351A23A0
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326967; cv=none; b=aFRlGXpOk96ZnDavivrr/u3e3E6VMjXzOwcIGr91Ytr8NKSWtMNQ2gez5VhFKGq+Zej3QlPOVBRK7Kq1Y1iLLZaBL8CgRYAMsG+he8LNruurX0iZQAdNZl66fHh38+jyZYdpAe5u/Smq4JvIPQ4jt3uWW9yaYjK4t0+NKV1HPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326967; c=relaxed/simple;
	bh=+8W5Ri/pFFeLcmGKvvOvJvdcCwN2VlT7nuhw+jr1CLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVB+NMj38X7QausJSJLk2UB7gRqmSQOh4/wEG/Px69n7gG47hwoBVmusq87RGl5Y4RSp2JOnhjeDV7FqMZwhKLc4vW4AWmpEcIm55gQ3MBclFUM1sHCzBhO4jH0plpntBDndfmvBQ8CO8ACmIIGxrGwGKG2MxTiwXqmH74kFvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LiROpoKj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFDdM001798
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 16:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mf1yxC4j/0xqckE1bjp6hJEa7TWXoohzaf1QFVhnFec=; b=LiROpoKjmM84CxmY
	UidQ2afnAkgqV+FMbKnoXu4FFizXiPKgDgrqgzJYYhTBDWSa2J9kWEa4K0ua+8PY
	bhA2GIdI3LCaisKR23O/t7EM3ZU/WfKbVYG/zMtQmCis4H84VcWdgW6TSzJuX2d1
	TDOXnTW1dX5oiw/5tZ3ZT4BYPCXHmFsI2a1PADrQLubPMw3zlfwFTTZrNWDWSShx
	wLD8OZd+YYCAoIWapErPYpjRpsZs3jR5ZKYLPG5LCTJFOsdCPSRl2SV4CR+zHek2
	b/t4L4nnwrnRFw5sv+szt03PcJltkkalO9fDQQSwshB0se1tWbBg4HT9qdNnuyhx
	zSbnJA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcresyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 16:36:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f8ac35546eso444526d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 09:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326964; x=1747931764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf1yxC4j/0xqckE1bjp6hJEa7TWXoohzaf1QFVhnFec=;
        b=vElsC2U07z8iH/Qgo6K9diycLoau/F8iwDDl+7417sQ5YPj/QS9T72eDfMHVBEidCH
         WsUltMousb5wDHeN+TIHDvgKH5a1iugeA6ylqTckKB5LQjxzjQqOnFdFHJCuke6q0zrd
         iihMql5sh5DPaZKfFFHQwGEAGK4RBj3yo4m3/IDdpzsKhIUiFJzakVZ1tP3SHEQUibz1
         X8kMRzfsmnLTSAyHNmURqgbQxx9ZLS8EG0QxtmKcWA8FS5QGrmLiflSm8joCKN7xb0FI
         5Q8vsuSF9RfL9vwhHhNhpO49gzDK//tQlAUHrDl0g+f5VfrpwEJpEyFVWO6xOjSYFZuu
         xqhw==
X-Forwarded-Encrypted: i=1; AJvYcCUiiG+vgAqPsV3Sfr/F8YM11HIv+zQ8R3yiu2KfaxUFrwhcrlOBr+PgNqjvRSGV8eGEFTgUSy8uA53xTl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VbyFDpexyu/0hsw1uCldSgPBalUiLmnl1KYp6cCFwvfP98zB
	ksobbIJc/XiLrJb2Ea2j3Mywo48Db0y2mgcntVCFrORpErDipSaUVVDkuP/lRYSA0Y4NfGl+r3a
	Kpa+y2w6l40H3DDGcOpzttGnP5G83dQwyq88XSmXcxNoKY9KsiS3cwTZH87PROMzGUhY=
X-Gm-Gg: ASbGncshbctcxGSQR5WzXkkJNmjZ7VA7a+45QZM2vTuaul1SQZ0bRbXOM1MegEltIuF
	FbYUlbE2UPrVvMIJrVFTHCusVFraS076uyet266OaHTkwCcqqlhn4OFqMFsqiAif0nEuhEB7SYj
	6hQI4vPxRWH03hHGhuVKImUCMkxZn3ZIwTPOMp64gjhQzsXYZzJLs3/o9KXafZ3k42QMTLDzyb/
	dTMc8gsa3NxC3uHaUBwTEllGV3aR6yO5NCkQkWypDJZ30/nNjgVg+dfIBDQR0zuwedEi8+l4Oi2
	2QfGBcwIp26aG7XXmMO7glU1tdNzGRrfIl8TpTPbB/PxdBgtwvUWxIttCDUXC77+wA==
X-Received: by 2002:a05:6214:2602:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6f8b0806253mr2293826d6.2.1747326963634;
        Thu, 15 May 2025 09:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvNUL5j6UfTHgiyVUOwjbW+ErGEGSr6X1GGt17A/3JvM7gfGdKNGvp9n+/7pu4N7fYdG51Lg==
X-Received: by 2002:a05:6214:2602:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6f8b0806253mr2293666d6.2.1747326963035;
        Thu, 15 May 2025 09:36:03 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e63a0sm72049a12.39.2025.05.15.09.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 09:36:01 -0700 (PDT)
Message-ID: <d0a036e7-605b-4475-8ddc-69482e16f0b3@oss.qualcomm.com>
Date: Thu, 15 May 2025 18:35:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v2 13/15] soc: qcom: ubwc: Fix SM6125's ubwc_swizzle
 value
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20250514-topic-ubwc_central-v2-0-09ecbc0a05ce@oss.qualcomm.com>
 <20250514-topic-ubwc_central-v2-13-09ecbc0a05ce@oss.qualcomm.com>
 <lkkwnmnk32igcev3gykmtxsohyskj6ehylaypg2dyxbedvksee@lnuc4lfmzrkm>
 <9a05d545-1bf2-4f66-8838-b6969ba37baa@oss.qualcomm.com>
 <d7417290-a245-422c-ba00-3532661ea02d@oss.qualcomm.com>
 <466148c9-2461-4140-9ba9-5a3427ec6461@oss.qualcomm.com>
 <4ec678b4-9e69-4ba0-a59d-f2e0948a73ce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4ec678b4-9e69-4ba0-a59d-f2e0948a73ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B3CQiDin_PDk9y8mNCMsY-5ypi8C5ncf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfX6b7K+oBv9Uh4
 b4sEmHjXuSSzZeLyHmhnPyjO46K+teYdmA6jYFMYbhS4LdJtRDK/Ig+jerDU8r5jefGByUDxcpG
 qajcWPbQ/Gkz7KL8QHfNE0I+mpMM+Zs+ltU5l0V8OKI7fH+gpc6QEj8pCCN6co39FVx5cPdbzTV
 Tl0EHSgynoWe1ZaQYtehkGqVdyI5yenqX/Ik5MZA0t1sxSGFoCtGpfxyoFh3bRn4/fOIl9MHoBk
 mZVXGz5jgdltylQDpZ653ySFPiGrAWhIGlxL0cq1q5XK08H1z+y13nlDgsYMdqUJSKcwLdcyblD
 WrrDabz0oWM50apwNh4fUkuqvT6aV2HijnKqNt7X2Ou5w2fvG4j7bZWPiiFiW8+Ia0W3LMtF0iU
 amJ8Mja0X6PiQ0/nqPHqkJ7DgztAjvvtxqpEEolc9PzFB00gah9zeEMxveqnEl3kijnU+MeS
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=682617f4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=_jjhv_60NFWZV4FgBwEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: B3CQiDin_PDk9y8mNCMsY-5ypi8C5ncf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150164

On 5/15/25 6:21 PM, Dmitry Baryshkov wrote:
> On 15/05/2025 19:18, Konrad Dybcio wrote:
>> On 5/14/25 10:33 PM, Dmitry Baryshkov wrote:
>>> On 14/05/2025 23:05, Konrad Dybcio wrote:
>>>> On 5/14/25 9:23 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, May 14, 2025 at 05:10:33PM +0200, Konrad Dybcio wrote:
>>>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>
>>>>>> The value of 7 (a.k.a. GENMASK(2, 0), a.k.a. disabling levels 1-3 of
>>>>>> swizzling) is what we want on this platform (and others with a UBWC
>>>>>> 1.0 encoder).
>>>>>>
>>>>>> Fix it to make mesa happy (the hardware doesn't care about the 2 higher
>>>>>> bits, as they weren't consumed on this platform).
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>> ---
>>>>>>    drivers/soc/qcom/ubwc_config.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
>>>>>> index 9caecd071035ccb03f14464e9b7129ba34a7f862..96b94cf01218cce2dacdba22c7573ba6148fcdd1 100644
>>>>>> --- a/drivers/soc/qcom/ubwc_config.c
>>>>>> +++ b/drivers/soc/qcom/ubwc_config.c
>>>>>> @@ -103,7 +103,7 @@ static const struct qcom_ubwc_cfg_data sm6115_data = {
>>>>>>    static const struct qcom_ubwc_cfg_data sm6125_data = {
>>>>>>        .ubwc_enc_version = UBWC_1_0,
>>>>>>        .ubwc_dec_version = UBWC_3_0,
>>>>>> -    .ubwc_swizzle = 1,
>>>>>> +    .ubwc_swizzle = 7,
>>>>>>        .highest_bank_bit = 14,
>>>>>>    };
>>>>>
>>>>> Add a comment and squash into the patch 1.
>>>>
>>>> I don't think that's a good idea, plus this series should be merged
>>>> together anyway
>>>
>>> Well... Granted Rob's comment, I really think the patches should be reordered a bit:
>>>
>>> - MDSS: offset HBB by 13 (patch 2)
>>> - switch drm/msm/mdss and display to common DB (patches 1+3 squashed)
>>> - get a handle (patch 4)
>>> - resolve / simplify (patches 5-10, not squashed)
>>> - fix sm6125 (patch 13)
>>> - WARN_ON (swizzle != swizzle) or (HBB != HBB)
>>> - switch to common R/O config, keeping WARN_ON for the calculated values (with the hope to drop them after testing)
>>
>> Does this bring any functional benefit? This series is unfun to remix
> 
> I know the pain.
> 
> The functional benefit is to have the WARN_ON and side-by-side comparison of common_ubwc_config vs computed ubwc_config for HBB and swizzle.

HBB I agree, since we'll be outsourcing it to yet another driver, swizzle
should be good enough (tm) - I scanned through the values in the driver
and couldn't find anything wrong just by eye

I realize this sounds funny, but all in all I don't think it's worth the
effort just for that one

Konrad

