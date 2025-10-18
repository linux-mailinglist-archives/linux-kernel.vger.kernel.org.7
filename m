Return-Path: <linux-kernel+bounces-859043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0CBEC8BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4291404D66
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B605286D5C;
	Sat, 18 Oct 2025 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y+wlj0e1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA62857CF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760769909; cv=none; b=CTueLvBR9q4WYvd69TUiRaYLhIs5cZjtfSVuOb2LW1SLfSN7cKD7r/0ibLk3wQAbbsdwCxAYXBncThX5pLL5T/X4skAEa9lDK3JSg1pcOmHn0ZunPDm4Knf4vW2KeNpulzO5H+CjnlS1p+GqVGCQfrFTdFa6WtnjaWeGaST5Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760769909; c=relaxed/simple;
	bh=83l92vGmnsTeooPFsXEiJR9HzVXaE+jXwSQU0y/tF6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEHoW8Jo0V0T/8rjJ7TpUWekymofonDd7W+1gAY3n7BmKpa4IuR2/1EoW4fZMpVWsqMOm00YYHQLVGbe00DhCQY79u79h4FaA2BTVDz1EqSaT8VAVSWi8EuAwoRrRu8QXcLZQpdK6pBQbQKVCh9QA20qOF7mUE6hb/yBUeT5wGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y+wlj0e1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I3QDqO025886
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83l92vGmnsTeooPFsXEiJR9HzVXaE+jXwSQU0y/tF6U=; b=Y+wlj0e174++TBKy
	yiPDXyDSEQf2U01eo7nHIRKk2r3ZqPud+QcgRX1jUgkOnIQ/e32SqTBVSAmtPTU+
	HJCilGA67lkzJmVq/fdrDylSkP961OSS7puYG5/D4g4k+5qMyiltnrzI+/GWwfil
	J5Rqb5Q2vdqTkg3kF7L8j7smmJGSf9XfTUC+qTsZeZWQJYJjC4G0mJLx5IiJu4Uw
	+FZk1gIVB0/HVSmQrNhYSCx7zwYcr63KCzkH57roKOgGwpi8pNCeK0CRBksLZEvj
	3OhRig5ztZOEgO3EdjzYgeT9Swwzyj5snnE3O2+devlxNiIqasQ3Q6VFiANcOvcs
	4WP6xg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv08me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:45:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2909e6471a9so19870425ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760769905; x=1761374705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83l92vGmnsTeooPFsXEiJR9HzVXaE+jXwSQU0y/tF6U=;
        b=JR9EhiFm9ynTAvQ22SXZj3NUOEWqeh3k0gZm9JNrQVI/dLFZpU/Dvh/ICQ34ZeQqt3
         aNrZ8mEky+F+GNDZ1YXZZm2eCaG6ehD3HoHsQh1R7mFS2qVsHo2XGreEE9vzmrqdQZEu
         6ir7+dIssSeKhW8hCU517FH3WsY6lez9UEmP0IMSuUP3f8qvjxpzK0aJmZP3By/qqRRA
         /Te6wqehy+5iLRXYucvGiHCEN5S8wPoDJed6tMEL4ky1mgmpTJ6lLxq3WdZZ5cVN+M8A
         9fK2Z/cGxnksdRbes7rHpYgSJ2T79QVKOba0lFti07DEUFxS2BtjESHzs1/7r3dWqOrN
         synQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMRucjPQUWT2PpsyKHmxfg1zB4Lf4Wv+YGPZAQWexvKoBgtZbZd6IEofqZC7HZJTcy4TgotPgPnhODB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YymmuELj9hL11vKu/K0T7vXudUVCXWFGjUn6ZFhz6xlLNwYiWlC
	GO2DNfXWVXd+szAJUPE7CHfSZ5oOyRMc0jv8xufqLb64kFv3CJn6djm5+zh0xKdlH6b2StiU5xZ
	F/cLI385OUyroGsPFAEX7qRcmGol5fXjUBB/Z1+4U97XIfVdUyA1KELPZiQ0dmq2WoDU=
X-Gm-Gg: ASbGnctXx7l4uHw+2wxJTt1vCOTX3MCPhb+tC37ZmlZkTVG2voL3w7QYUglspOLHzXG
	DVTsctj+u6uXsfP7Flfzap1oAap+S6MtrrD08mORJbhrzONGilySbI3eWI5FN6aY7dvfXBeg+4A
	FX6fhTewF7+iHvDiSV2NV1pIrcxbcGUT0Od3gIDeqzd4iECj0W/DtprL1lqawLfMm84z8+GANWT
	GlzmbAxriefJlAG3bc7Ox00CLxNI7pK/q5nxGQilW5LSl9nhBLfGYOnMqwfGeaiFKExk1SG5DeC
	fohm/Yv1zaysJqRxQiL5bUreqHGGAaSJPWmXxAgGNCv/Fo5cSMBH7KORDKrVveAZ67EI5UICiOn
	Tj7cLwZp9pnbaFPJ7cqym1zDYHaSo
X-Received: by 2002:a17:902:f691:b0:25c:e895:6a75 with SMTP id d9443c01a7336-290ca121a2cmr76756705ad.28.1760769904549;
        Fri, 17 Oct 2025 23:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE46DudyU1Od1eBACT3pMY31QTZQHpLNGdzqT+17P2QerlcjwRKGiUCYVWUl4eUkOU0pL/1g==
X-Received: by 2002:a17:902:f691:b0:25c:e895:6a75 with SMTP id d9443c01a7336-290ca121a2cmr76756345ad.28.1760769904006;
        Fri, 17 Oct 2025 23:45:04 -0700 (PDT)
Received: from [192.168.1.14] ([58.84.62.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2e0sm16037715ad.34.2025.10.17.23.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 23:45:03 -0700 (PDT)
Message-ID: <677b59f4-5732-43ad-83af-c670f6fb999d@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 12:14:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] ufs: ufs-qcom: Disable AHIT before SQ tail update
 to prevent race in MCQ mode
To: Bart Van Assche <bvanassche@acm.org>
Cc: mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        peter.griffin@linaro.org, krzk@kernel.org, peter.wang@mediatek.com,
        beanhuo@micron.com, quic_nguyenb@quicinc.com, adrian.hunter@intel.com,
        ebiggers@kernel.org, neil.armstrong@linaro.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com
References: <20251014060406.1420475-1-palash.kambar@oss.qualcomm.com>
 <20251014060406.1420475-3-palash.kambar@oss.qualcomm.com>
 <f2b56041-b418-4ca9-a84a-ac662a850207@acm.org>
 <CAGbPq5dhUXr59U_J3W4haNHughkaiXpnc4kAZWXB0SjPdFQMhg@mail.gmail.com>
 <bb9c7926-4820-4922-a67d-65a6b1bace9a@acm.org>
Content-Language: en-US
From: Palash Kambar <palash.kambar@oss.qualcomm.com>
In-Reply-To: <bb9c7926-4820-4922-a67d-65a6b1bace9a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yIBCUv5QEftqfl1RYII29rB5y4D3XujV
X-Proofpoint-GUID: yIBCUv5QEftqfl1RYII29rB5y4D3XujV
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f33771 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IrkFCgFlEHDHcOs+Gij41Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P3EupyyZPr0bXwnpvzAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX499GlP1j7Wf1
 fbyjHM8CUMGw8YnRDb4MP0fEBEpPxmY9UhVyPki0JK8gxreRQgk0u7ucJ4KOQZcd0Ok9ehnjBat
 6pgpK1LfKaex6i5wnLfb6Zm/IrbLgmEcqgbrUpvkvZC35BxUJlBaYKyMoBHBWEt2jYeyVsJB/G/
 YbocqroA0KF5RzhY5XbaEhg5k3153V3JDuScx9EMHNQUWC6VzBRaGiNSyDhyOc5lFCKqydvNBBh
 RDVHXt4GAOdsgON6p/toFdSilhUXC0Z8I5YVTiJ4HwK+6WbAwufddkxMO8cB8SlA9AL0fy1jfiw
 /S+w8flWqgXpImElZ1uFVe5SIZl92RhzQ7/3XCMKlGt/D5e1WjCP4sF8zmXjIU15Ic9k7cwTD+o
 wzg4xdhqCiqcQuSeMoDchoAOSI4rnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023


On 10/15/2025 9:15 PM, Bart Van Assche wrote:
> On 10/15/25 7:08 AM, Palash Kambar wrote:
>> Since AHIT is a hardware-based power-saving feature, disabling it entirely
>> could lead to significant power penalties. Therefore, this patch aims to preserve
>> power efficiency while resolving the race condition.
>> We have tested this change and observed no noticeable performance degradation.
>> Also, adding in RPM callbacks will not solve the power penalty as it autosuspend timer is
>> 3 secs in comparision to AHIT timer which is 5ms.
>
> The runtime power management timeout can be modified. Please verify
> whether the power consumption with AHIT disabled and the runtime power
> management timeout set to 5 ms is acceptable.
>
> Thanks,
>
> Bart.

Thanks for the feedback, Bart. However, I believe setting the runtime suspend delay to 5ms
 might be overly aggressive for the system and may have below side effects:

1. Short autosuspend timeouts can cause the UFS device to enter low-power states even 
during brief idle periods. This results in resume latency, introducing delays when the 
device needs to wake up for subsequent operations.
2. Frequent suspend and resume cycles may disrupt data flow, particularly in workloads
with bursty or intermittent I/O, leading to performance degradation.
3. When the autosuspend timer is overly aggressive, the UFS device may repeatedly 
transition between active and low-power states. These transitions themselves consume power, 
and if they occur too often, they can offset or even negate the intended power savings.

Please let me know your thoughts on this.

Regards,


Palash K

>  

