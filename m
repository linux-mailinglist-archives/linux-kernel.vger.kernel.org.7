Return-Path: <linux-kernel+bounces-876072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC59BC1A7F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62E4D359233
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34A33B6C6;
	Wed, 29 Oct 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKofYOB7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+5Q77YL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1F33B6FD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742511; cv=none; b=o0+YZ0BEKzrnOFin1roJaFkPTRFR281NIkGF+Q18tAvyHG1yLbb2lFWso97RYYQiUVAisGe5cB0tg0kaSRoegO7GHk2wlWVPcZsHtwItGePfXkU1gWZFoJVbxOE0EdPBPxHOcTq9PEj0e5+jf1SatMpAk/TgcE9ZdbxPjYi8jCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742511; c=relaxed/simple;
	bh=HyoARy+zaEu6g8ygPPdG3fCeS5+0hsuR3Ettdx7LNno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1NB+y6YkF14mkf0f/lr0sP5z5ObJq9IvLEBKb1LaKL/ic3VsrwHYOaM6p18ycJ/S8aCzYoz8rIjt8IWuy+s75yupMivW/YJMzUVY+RebhxF8kAdbjeabrOc6CPJOUEh8Hio3lJgr8YWs4ot0xctqwIBlUQ0TrfnqbepGTvjjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKofYOB7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+5Q77YL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TCrolg3755096
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J4w3ZbI2OAPqEJy2jBs+oscQ5kTp/np7X7EtBXJimWg=; b=HKofYOB79DDRPjmC
	MrQhyy8bKVJqkfgNHuWJIvDJCzMlndFgdRM7RVQv3FqpCvrUdkHiHdjqDonTOR+B
	KJS6ZcJDRbL1m4ko1PWJ0mBvQw4ftfzVSxPHa53CAZB645G1X+qdb27tMIaMMW6u
	VgY2/Mfr9oCpdcV8QVr+w7qqBv2cL8sj23hOsstUEbuZTb4Jn1rdcNDFa67craFr
	FcMSZYmc8rM+a9r3PAGKWLoG3yv+hB2yFVoHcbQocYjM0iCaBZSyQpANuLkgHaHc
	fDX4arQ/uVNraavIt2//9SEn9QNqjjBEoKuuuS55ZD5VXqK1XO7zSXVF0N7fQC2N
	YUq8Wg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a02j6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:55:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88c912928so200661461cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761742505; x=1762347305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4w3ZbI2OAPqEJy2jBs+oscQ5kTp/np7X7EtBXJimWg=;
        b=V+5Q77YLuW0K+MTkXw/auYI4M/hcj0+/+pYYH/pD+/icu36BnDvnripAaRpkul1jJD
         nJhBdOmqmcWwZf1UZoudLiONi3I/f6REXhS64SI8LzRSCvfrREnpgzWHSJORX4udlCdn
         e9u0gBjDaqBB2DHQyQSv+Z4FGIXP9U+MB8Niuf6N6e83m/JGwLEkonBB4oQhvmHqJWMM
         J3NsrleKPxzbYIFsxxBPc8HmBCWDx6ZKvz3KWqfaR7EOckeKIZwwJTOubB8WQtxkbzVn
         NeChR5fvsvxXbgR+5D2SnMsw6mfo4EByQy95agdBHMD99grAyMuK49hHjNB9s7E6wpo8
         hKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742505; x=1762347305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4w3ZbI2OAPqEJy2jBs+oscQ5kTp/np7X7EtBXJimWg=;
        b=pCvxccON19OR5np3Hmcvw+xf9AACecSC5QzwdKUNaf2QHSrMC/qmQ0qmaoaqqR2vgT
         0yuhD+md6xPabuxchlMvmr4DtwWZezcwd4Xks33HHa7+Q7MVv3ygisdf7EcB6UBP4qGK
         EFX+NIK1Pns2+80BkYJNoP+gE+UdTD0KdisGI1lM4fuJHEcgaTHbtKZAj5dmoixiWE3w
         85ixpSRqNJ+ttN5iaygPlkzxglOVDYa7h2+6M6yqBNvWTEQyWQ0FglXAf2fl/JY/MnWn
         gcc3KFmSom2Swjc5fcqJxta0zYQFSYCmZFH1rsxjGB3ROpoYOGpCEOhAU9UITiZGAzia
         NQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVNR/5eu2gaZWgz4P4EHEkZD7V5gvxcX4fjwHj0yJH7j68HZMB7UWRpoPKs6433CYFrQQBhbj0Ku4Vdlcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1UC+t4PCImAkJVWB/5sod2bcGO1mUAc3fb+H1lN2DEInyGEpi
	tYoW9nEeJjKg+aiImyCc/wCBpfwW3btCwnBlfNhaSvJksZIX/3p+LLzazOxUbse4LyB5jiAPlmD
	5pcxnVmSLhSi97dS8VO/5WNs3N8gGJsiit3vHcyuHWW05yyPCLb0No4dny3P8zsKpN7Q=
X-Gm-Gg: ASbGncvJy+ESQ52WpnyzlzwR/XAUhqhnUkVUoSFQlrqQyVeIwjAo1hld016jcK2/6kq
	PKe7L1WV4jytbxwHUrFdG4iKEorB5KQ6QpAA9Bf7toqAktIgyJs4Af4FwMYyB+em2KvGfYpJzti
	XE3URBoh4iloo/tik7+9uy9hbqJR3zENYB9JjrZ3sVxEXO0o7Vh1luAwNkfX93ydtlli/IwndqS
	2SK5upu/uW7g2qzWsBgyjHeZy2Mytlds3G2OdiDyjCTON3vu4Sj0+jGLdMhsOQZvCNFwgDqKxd2
	1kCmi8PQOVGrhzAtWxjj6R9tWJIoZt4/UdeM7q0XF0SroSET1AxZVA1iFTnad8x/N4r7I1jIjXI
	ZCrG1QS1Tet9WHnbPJLo1TW3GdPRWPmMoP0bJL6rR1qX265Kl8UK2/+t2zf2dPyhhW8jKOKrSxT
	VVPg==
X-Received: by 2002:ac8:5a06:0:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed15cbebacmr29370031cf.80.1761742504521;
        Wed, 29 Oct 2025 05:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxslv20fwVgpGvpGJEMS8kwxnz2RASBMAJ2XDPGmssEtxmx4kx5GR2gBhhKrvYn5P5AhoSQw==
X-Received: by 2002:ac8:5a06:0:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed15cbebacmr29369591cf.80.1761742503843;
        Wed, 29 Oct 2025 05:55:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::4c9? (2001-14ba-a0c3-3a00--4c9.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::4c9])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6974esm3921720e87.73.2025.10.29.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:55:02 -0700 (PDT)
Message-ID: <58b5fc9e-890c-4b89-97fa-5d1638cffd3d@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 14:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
 <da56lghirjcwesz4usdlfpttwcmvoql2h6bvjommoyfskjdkgk@hrlgx4ukt4aa>
 <09cbf40d-6536-4bda-94d6-5b45a5746962@linaro.org>
 <w4lwl34mtd7xv7it72nvomv6te2bcybisvirfdwzdazzqisd73@fvyusj6m5cb2>
 <ed323916-f0e4-4669-935c-6fc8ae6a9490@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <ed323916-f0e4-4669-935c-6fc8ae6a9490@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA5OCBTYWx0ZWRfX+IHaKBg/8FGk
 HCHRVYGeCVAe3rgpbcM4ChLo1w2puimP3xvJqEReppznIoJniYcWwh/bjES7m7YdOzhnTqtlSR6
 es/aAj2SeqXaX+CwMi+Zcf5x7cb1kxv1XQbGox9R+HBm+LMvYIHWQ1RDU8VI2IT22VQf7fFFdvg
 pM4siuhLPhar5m6P8PXWRTfonH422mP+MHD94TdJ6ITUpM1NNDx/Wc0CfTqb4LIfWaePuYxiYAn
 Dsefz234+rqCsaDSRm5LYqyaH8ayiZ5r9TSR1Zu0d6r8sS8t3Pvp2iyp/c8Xk2IBVfR1crx1MI+
 L4MUzWEQWIJ5OzZvaPP7p6VWxT4YTycP0qXFKvK92LZdZgUKarw6fdXg5AmRBjFjtzZImKGUF5V
 Ic6jVep0X+SCkz2KYZCQGHO5ffgWWg==
X-Proofpoint-GUID: wx-gpMPCu33Ab6KmjVjQcmNO5oXpm5Aj
X-Proofpoint-ORIG-GUID: wx-gpMPCu33Ab6KmjVjQcmNO5oXpm5Aj
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69020ea9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=GO5XCE9Gkcx8_P09yrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290098

On 29/10/2025 14:49, Neil Armstrong wrote:
> On 10/29/25 13:30, Dmitry Baryshkov wrote:
>> On Wed, Oct 29, 2025 at 10:40:25AM +0100, Neil Armstrong wrote:
>>> On 10/28/25 20:52, Dmitry Baryshkov wrote:
>>>> On Tue, Oct 28, 2025 at 09:42:57AM +0100, neil.armstrong@linaro.org 
>>>> wrote:
>>>>> On 5/7/25 03:38, Jessica Zhang wrote:
>>>>>> Filter out modes that have a clock rate greater than the max core 
>>>>>> clock
>>>>>> rate when adjusted for the perf clock factor
>>>>>>
>>>>>> This is especially important for chipsets such as QCS615 that have 
>>>>>> lower
>>>>>> limits for the MDP max core clock.
>>>>>>
>>>>>> Since the core CRTC clock is at least the mode clock (adjusted for 
>>>>>> the
>>>>>> perf clock factor) [1], the modes supported by the driver should 
>>>>>> be less
>>>>>> than the max core clock rate.
>>>>>>
>>>>>> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/ 
>>>>>> drm/msm/disp/dpu1/dpu_core_perf.c#L83
>>>>>>
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> - *crtc_clock -> *mode_clock (Dmitry)
>>>>>> - Changed adjusted_mode_clk check to use multiplication (Dmitry)
>>>>>> - Switch from quic_* email to OSS email
>>>>>> - Link to v1: https://lore.kernel.org/lkml/20241212-filter-mode- 
>>>>>> clock-v1-1-f4441988d6aa@quicinc.com/
>>>>>> ---
>>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 35 +++++++++++ 
>>>>>> +++++++---------
>>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +++
>>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 +++++++++
>>>>>>     3 files changed, 39 insertions(+), 11 deletions(-)
>>>>>>
>>>>>
>>>>> This test doesn't take in account if the mode is for a bonded DSI 
>>>>> mode, which
>>>>> is the same mode on 2 interfaces doubled, but it's valid since we 
>>>>> could literally
>>>>> set both modes separately. In bonded DSI this mode_clk must be 
>>>>> again divided bv 2
>>>>> in addition to the fix:
>>>>> https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix- 
>>>>> v2-1-01fcd0b2465a@oss.qualcomm.com/
>>>>
>>>>   From the docs:
>>>>
>>>>            * Since this function is both called from the check phase 
>>>> of an atomic
>>>>            * commit, and the mode validation in the probe paths it 
>>>> is not allowed
>>>>            * to look at anything else but the passed-in mode, and 
>>>> validate it
>>>>            * against configuration-invariant hardware constraints. 
>>>> Any further
>>>>            * limits which depend upon the configuration can only be 
>>>> checked in
>>>>            * @mode_fixup or @atomic_check.
>>>>
>>>> Additionally, I don't think it is correct to divide mode_clk by two. In
>>>> the end, the DPU processes the mode in a single pass, so the perf
>>>> constrains applies as is, without additional dividers.
>>>
>>> Sorry but this is not correct, the current check means nothing. If you
>>> enable 2 separate DSI outputs or enable then in bonded mode, the DPU
>>> processes it the same so the bonded doubled mode should be valid.
>>>
>>> The difference between separate or bonded DSI DPU-wise is only the
>>> synchronisation of vsyncs between interfaces.
>>
>> I think there is some sort of confusion. It might be on my side. Please
>> correct me if I'm wrong.
>>
>> Each CRTC requires certain MDP clock rate to function: to process pixel
>> data, for scanout, etc. This is captured in dpu_core_perf.c. The patch
>> in question verifies that the mode can actually be set, that MDP can
>> function at the required clock rate. Otherwise we end up in a situation
>> when the driver lists a particular mode, but then the atomic_check
>> rejects that mode.
> 
> A CRTC will be associated to 1 or multiple LMs, the LM is the actual block
> you want to check for frequency. Speaking of CRTC means nothing for the 
> DPU.
> 
> We should basically run a lightweight version of dpu_rm_reserve() in 
> mode_valid,
> and check against all the assigned blocks to see if we can handle the mode.
> 
> But is it worth it ? What did the original patch solve exactly ?
> 
> Do we have formal proof about which max clock frequency a complete HW 
> setup is able to support ?
> 
>>
>> With that in mind, there is a difference between independent and bonded
>> DSI panels: bonded panels use single CRTC, while independent panels use
>> two different CRTCs. As such (again, please correct me if I'm wrong),
>> we need 2x MDP clock for a single CRTC.
> 
> Any mode can use 1 or multiple LMs, in independent or bonded DSI. As I
> said the bonded DSI with a 2x mode will lead to __exactly__ the same setup
> as 2 independed DSI displays. And in bonded mode, you'll always have 2 LMs.
> 
>>
>>> So this check against the max frequency means nothing and should be
>>> removed, but we should solely rely on the bandwidth calculation instead.
>>
>> We need both. If you have a particular usecase which fails, lets discuss
>> it:
>>
>> - 2 DSI panels, resolution WxH, N Hz, the mode uses l LMs, m DSC units
>>    and foo bar baz to output.
>>
>> - The dpu_crtc_mode_valid() calculates the clock ABC, which is more than
>>    the max value of DEF
>>
>> - The actual modesetting results in a clock GHI, which is less than DEF
> 
> I don't understand what you need,

I have been asking for exact W, H, N, l, m, etc. numbers.

> in the current form the mode_valid will
> accept the 2 DSI displays as independent, while using them as bonded will
> use the exact same HW setup (resolution WxH, N Hz, the mode uses l LMs, 
> m DSC units)
> but the mode_valid with rejects it.

Which clock rate is being returned by _dpu_core_perf_calc_clk() while 
setting up two independent outputs and when setting up a single bonded 
output?
Which clock rate is being used by dpu_crtc_mode_valid() to reject the mode?

> 
> Neil
> 
>>
>>>
>>> Neil
>>>
>>>>
>>>>
>>>>> I'm trying to find a correct way to handle that, I have tried that:
>>>>> ===========================><========================================
>>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/ 
>>>>> gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>>> index 48c3aef1cfc2..6aa5db1996e3 100644
>>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>>
>>>
>>
> 


-- 
With best wishes
Dmitry

