Return-Path: <linux-kernel+bounces-819959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8435CB7D289
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1093052685E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F42F39B3;
	Wed, 17 Sep 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Img1yX0/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62A29A30D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081772; cv=none; b=npMhDapJOlbfv1K61XJljEh1bwYx4Sk8/e2kF6n7Tngpt+a4aFhUG0TXS79NoI2DYcsgRL5B981LtmFSbdNEDhPbMUJBGp2fUlmzO5CZt0Qxs5iBOrYTZT3n1u4p6eVMpKPKETTuYYAKe4/TpWDn0AbI+9RwOFoYHmz2BCp9jOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081772; c=relaxed/simple;
	bh=oKP9V4oGX8qLUdbDsyjGPkiYubt9sYyUf4aQcCASQE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXF44Pdz6NJ86c5GSj9pWTMvxCdkZDe6e2EUYyMgtf9hm0+WtJC3ABiD/DUXWQkswRwkHLpOhWm97RD/3kczTbMUC/uh48AogCrfyuIVWCkP2KG/qtuK8JJ6ieCo4tLewjnCniPw6iObiB1OqnqJC7mqh+brOUJxYEyGoWHvfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Img1yX0/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaIG7025983
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MlV1DK+uHYp0R5Mlc3FU/czDVM+GIXpuU619xfCwqkI=; b=Img1yX0/EoyR7h1a
	e7Z97lImO098/rK2p9Jr3TzTOhH3hD+nx8p8lwucM/VT3KzPsnCD5tDhX/Dwf4PF
	ZbnRuAO7KKQilFa+8myfHWUbDAIbYKCXQmJ5tueRlK/+7osdGEQEY+KQYFxp30uA
	lZ1dBgxyCsT4HWkx9VB4RVX7Sd+fq6DwLwq9S0wO0VSgA5zgCLdWVWrpTdCx3NzW
	b5HXBpByuBC7J/Id1DENJJ8//Y64zQN+yBQCVw+OVFQzOFNFnzCB06Fulfx0wept
	z3wGNELrYYd62XZ05Nc+1aZJdrg2NdZUUGmaedRT/xB24UBMblyYnzDz6d+yy+XY
	Y6GYow==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwguc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:02:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77614fa6182so877061b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081767; x=1758686567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlV1DK+uHYp0R5Mlc3FU/czDVM+GIXpuU619xfCwqkI=;
        b=ZWoUrir8DmAXjUm1tCQwWH2hwbQsmRqJE64f1T3zIg6FKvnqaBS25OYmgvXHUnBTdt
         G3s3eCsJgP6CNsqlfC1Cn2haOX8XoXCXpxCqkHasUU0HfuuxqQSfZJfXAEKpeSIhlRCl
         THEGhd9ETA9KIsK0EAtZRENhpnZ6mbyL2kTmAbiXv44Sm0nsMMjsmERuunYOpvE0LvEb
         OjJ/d2u1KJL8uZShVcVERs+zezKaAO4BBzWxH/kd7dLXROJKX9KR8oZAhaOg+XYEGWCE
         HH6l/jaLLbkPvX4/DyGizdQ1ExGT88PLXDqJeqleheX+c6dTuLOe7X271e6eHU+U5pXf
         yQCA==
X-Forwarded-Encrypted: i=1; AJvYcCXMNkhcWddpcNBuL/+3q0bLphYYPLROSrd3lHg479oV3n1GatXETWwXpZjCwMh2UDjeO8LGPQA2oLUxVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNW237uXOkXwIMZ1ONThjfu+SQCNf4wrWIkae7qVNbVTdLcbGD
	JuR9c2EsZyuLaukqhF6BcH8lIybLUfP2VXfwS+iC2QxaUV0DsuY3GbQTZ8MAqaoCfa3BCgOZytp
	FKgMbI9oiNv78OH1BjLCWPIij8cwYP9B7Zkc3y/efzcZDwQFNtr54fc7DqXGy+NGbTJM=
X-Gm-Gg: ASbGncvkX8jpXbDGz3A2SmjICmryZj0pSQaKtiLZMyA9fDKzncNFbnBn9HsohJPOUhx
	I2k7bU06aOgy18UElf04SY1TtP9XRQWq0JWWGrI0yJyPwc1royy3k1PRBHV+64luNWAxb6EJMmI
	LqBENV9LQph7Em3dmd8MRaqRDy7AlNS6yYAUCdZ1y7lml6w5D8KqyS5ZeOuVCahvD7blVlPp/Da
	NIsPC3WkovAX9hiJpmW0C7MVIjBWhCCo1oU0ap4qhBGfbGcZCEbRZC+VzoO5VUHk98zcDMKmQ5p
	PHJLfI1bv4/6klpeXrZoZG+FypCBwQsIhCTZX7Qc+Qo45xAywAqSR9yxmt5kbN6tWPCaRjkp
X-Received: by 2002:a05:6a00:180f:b0:771:f071:28fd with SMTP id d2e1a72fcca58-77bf0c341d2mr816632b3a.14.1758081766388;
        Tue, 16 Sep 2025 21:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzfpe87RMEyLdv8EkmoQ59oHcLiO1VcyLw4mI6fnoet4r9G34ZtPRY1fB273ZgiBoZenzfg==
X-Received: by 2002:a05:6a00:180f:b0:771:f071:28fd with SMTP id d2e1a72fcca58-77bf0c341d2mr816585b3a.14.1758081765761;
        Tue, 16 Sep 2025 21:02:45 -0700 (PDT)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776ad32de79sm10748197b3a.63.2025.09.16.21.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:02:45 -0700 (PDT)
Message-ID: <1e401d10-0f23-4d96-b949-52927f08d283@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 09:32:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: qcom-geni: Fix pinctrl deadlock on runtime
 resume
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Praveen Talari <quic_ptalari@quicinc.com>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, psodagud@quicinc.com, djaggi@quicinc.com,
        quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com, quic_shazhuss@quicinc.com
References: <20250908164532.2365969-1-praveen.talari@oss.qualcomm.com>
 <DCNLSFVPCKMV.K1UE3J3K6JQD@linaro.org>
 <DCOJFRU8KNFL.14VPXK9QZC9T4@linaro.org>
 <5b7b8c9f-48c5-45cd-8366-c8c048eaa757@oss.qualcomm.com>
 <DCPUJPHR8NUB.1SRB4D7ONSRBY@linaro.org>
 <2c5fd01a-543b-4108-ac54-80d1d87b65a3@oss.qualcomm.com>
 <DCT9VWQYD4VM.1NV5FJJCJG4PI@linaro.org>
 <cb96f3cd-7427-4644-b7ca-26b763867db4@oss.qualcomm.com>
 <df05da7e-fd9d-48a6-bffc-e84749cd8e96@oss.qualcomm.com>
 <aMl2hOYTjBuCo4AM@trex> <aMl9Fbuyq7hdXvQC@trex>
 <DCUE5AXJ99BG.150SRQMY7EJG6@linaro.org>
 <0d644b94-c674-429b-9ed8-64cb89f168f8@kernel.org>
 <991a3732-dda9-45c8-8eb1-5f5dfa49b289@kernel.org>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <991a3732-dda9-45c8-8eb1-5f5dfa49b289@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=do/bC0g4 c=1 sm=1 tr=0 ts=68ca32e8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=fIlN0zcnSCwGPKwyK0sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -azYkJNoy8wtmam009EH5f1QGuTdtXVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzuFGTP/2AgAE
 htt4xma0QWl3GTrh9gSwN2cyXeGI/iv6Fx50zy1vnH8Ejvq4F+FNl6hSK3XUIJ6iuXhVHiFvz3w
 EXn1K3IJl8k2JcrcF3fSLuaobEelZUhgqWTmDjfbIAxJIQvoKKOhkclJHzXKj+szdy2x7aUNeMN
 E2YmqO4c2LZk4x4YpPzfgqFUR/XXx2QL7bh4cYiZMrd6eQ4/uNh3NEcw2Hso06GIOGe8MaKzHwy
 8j3gRABv1IfTXFchw8rDDEx9Vn78HIDMbBEIUDdtJ9CjodJ5zB4dwZmQngaDW+tDuFzc9X0aVJg
 E8gyMyURNKfRXAhpTriUzzbZyp6sh12VkGPw+UuDa6Bf1pYm87BxVsYbYd6TJ6yurREeo8sBZRl
 xP4Z8O0E
X-Proofpoint-ORIG-GUID: -azYkJNoy8wtmam009EH5f1QGuTdtXVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/17/2025 5:43 AM, Krzysztof Kozlowski wrote:
> On 17/09/2025 02:05, Krzysztof Kozlowski wrote:
>> On 17/09/2025 19:12, Alexey Klimov wrote:
>>> Hi Praveen,
>>>
>>> On Tue Sep 16, 2025 at 4:07 PM BST, Jorge Ramirez wrote:
>>>> On 16/09/25 16:39:00, Jorge Ramirez wrote:
>>>>> On 16/09/25 12:20:25, Praveen Talari wrote:
>>>>>> Hi Alexey
>>>>>>
>>>>>> Thank you for your support.
>>>>>>
>>>>>> On 9/15/2025 7:55 PM, Praveen Talari wrote:
>>>>>>> Hi Alexey,
>>>>>>>
>>>>>>> On 9/15/2025 3:09 PM, Alexey Klimov wrote:
>>>>>>>> (removing <quic_mnaresh@quicinc.com> from c/c -- too many mail not
>>>>>>>> delivered)
>>>>>>>>
>>>>>>>> Hi Praveen,
>>>>>>>>
>>>>>>>> On Mon Sep 15, 2025 at 7:58 AM BST, Praveen Talari wrote:
>>>>>>>>> Hi Alexey,
>>>>>>>>>
>>>>>>>>> Really appreciate you waiting!
>>>>>>>>>
>>>>>>>>> On 9/11/2025 2:30 PM, Alexey Klimov wrote:
>>>>>>>>>> Hi Praveen,
>>>>>>>>>>
>>>>>>>>>> On Thu Sep 11, 2025 at 9:34 AM BST, Praveen Talari wrote:
>>>>>>>>>>> Hi Alexy,
>>>>>>>>>>>
>>>>>>>>>>> Thank you for update.
>>>>>>>>>>>
>>>>>>>>>>> On 9/10/2025 1:35 AM, Alexey Klimov wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> (adding Krzysztof to c/c)
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon Sep 8, 2025 at 6:43 PM BST, Alexey Klimov wrote:
>>>>>>>>>>>>> On Mon Sep 8, 2025 at 5:45 PM BST, Praveen Talari wrote:
>>>>>>>>>>>>>> A deadlock is observed in the
>>>>>>>>>>>>>> qcom_geni_serial driver during runtime
>>>>>>>>>>>>>> resume. This occurs when the pinctrl
>>>>>>>>>>>>>> subsystem reconfigures device pins
>>>>>>>>>>>>>> via msm_pinmux_set_mux() while the serial device's interrupt is an
>>>>>>>>>>>>>> active wakeup source. msm_pinmux_set_mux() calls disable_irq() or
>>>>>>>>>>>>>> __synchronize_irq(), conflicting with the active wakeup state and
>>>>>>>>>>>>>> causing the IRQ thread to enter an uninterruptible (D-state) sleep,
>>>>>>>>>>>>>> leading to system instability.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The critical call trace leading to the deadlock is:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         Call trace:
>>>>>>>>>>>>>>         __switch_to+0xe0/0x120
>>>>>>>>>>>>>>         __schedule+0x39c/0x978
>>>>>>>>>>>>>>         schedule+0x5c/0xf8
>>>>>>>>>>>>>>         __synchronize_irq+0x88/0xb4
>>>>>>>>>>>>>>         disable_irq+0x3c/0x4c
>>>>>>>>>>>>>>         msm_pinmux_set_mux+0x508/0x644
>>>>>>>>>>>>>>         pinmux_enable_setting+0x190/0x2dc
>>>>>>>>>>>>>>         pinctrl_commit_state+0x13c/0x208
>>>>>>>>>>>>>>         pinctrl_pm_select_default_state+0x4c/0xa4
>>>>>>>>>>>>>>         geni_se_resources_on+0xe8/0x154
>>>>>>>>>>>>>>         qcom_geni_serial_runtime_resume+0x4c/0x88
>>>>>>>>>>>>>>         pm_generic_runtime_resume+0x2c/0x44
>>>>>>>>>>>>>>         __genpd_runtime_resume+0x30/0x80
>>>>>>>>>>>>>>         genpd_runtime_resume+0x114/0x29c
>>>>>>>>>>>>>>         __rpm_callback+0x48/0x1d8
>>>>>>>>>>>>>>         rpm_callback+0x6c/0x78
>>>>>>>>>>>>>>         rpm_resume+0x530/0x750
>>>>>>>>>>>>>>         __pm_runtime_resume+0x50/0x94
>>>>>>>>>>>>>>         handle_threaded_wake_irq+0x30/0x94
>>>>>>>>>>>>>>         irq_thread_fn+0x2c/xa8
>>>>>>>>>>>>>>         irq_thread+0x160/x248
>>>>>>>>>>>>>>         kthread+0x110/x114
>>>>>>>>>>>>>>         ret_from_fork+0x10/x20
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> To resolve this, explicitly manage the wakeup IRQ state within the
>>>>>>>>>>>>>> runtime suspend/resume callbacks. In the
>>>>>>>>>>>>>> runtime resume callback, call
>>>>>>>>>>>>>> disable_irq_wake() before enabling resources. This preemptively
>>>>>>>>>>>>>> removes the "wakeup" capability from the IRQ, allowing subsequent
>>>>>>>>>>>>>> interrupt management calls to proceed
>>>>>>>>>>>>>> without conflict. An error path
>>>>>>>>>>>>>> re-enables the wakeup IRQ if resource enablement fails.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Conversely, in runtime suspend, call
>>>>>>>>>>>>>> enable_irq_wake() after resources
>>>>>>>>>>>>>> are disabled. This ensures the interrupt is configured as a wakeup
>>>>>>>>>>>>>> source only once the device has fully
>>>>>>>>>>>>>> entered its low-power state. An
>>>>>>>>>>>>>> error path handles disabling the wakeup IRQ
>>>>>>>>>>>>>> if the suspend operation
>>>>>>>>>>>>>> fails.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Fixes: 1afa70632c39 ("serial: qcom-geni:
>>>>>>>>>>>>>> Enable PM runtime for serial driver")
>>>>>>>>>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> You forgot:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Also, not sure where this change will go, via
>>>>>>>>>>>>> Greg or Jiri, but ideally
>>>>>>>>>>>>> this should be picked for current -rc cycle since regression is
>>>>>>>>>>>>> introduced during latest merge window.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I also would like to test it on qrb2210 rb1 where this regression is
>>>>>>>>>>>>> reproduciable.
>>>>>>
>>>>>> Since I don't have this board, could you kindly validate the new change and
>>>>>> run a quick test on your end?
>>>>>>
>>>>>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
>>>>>> b/drivers/pinctrl/qcom/pinctrl-msm.c
>>>>>> index 83eb075b6bfa..3d6601dc6fcc 100644
>>>>>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>>>>>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>>>>>> @@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev
>>>>>> *pctldev,
>>>>>>           */
>>>>>>          if (d && i != gpio_func &&
>>>>>>              !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
>>>>>> -               disable_irq(irq);
>>>>>> +               disable_irq_nosync(irq);
>>>>>>
>>>>>>          raw_spin_lock_irqsave(&pctrl->lock, flags);
>>>>>
>>>>>
>>>>> sorry Praveen, didnt see this proposal. testing on my end as well.
>>>>>
>>>>
>>>> just tested on my end and all modules load - deadlocked before this
>>>> update so there is progress (now we can load the network driver)
>>>
>>> Is it supposed to be orginal patch here plus disable_irq_nosync()?
>>> Meaning changes for qcom_geni_serial_runtime_{suspend,resume}
>>> + disable_irq_nosync() in msm_pinmux_set_mux()?
>>>
>>> It seems to work here but let me know few more runs.
>>
>>
>> So this bug, after 5 weeks is still not fixed?!?

I understand the concern. We didn’t have access to the same board where 
Alexey is seeing the issue, so we tried to reproduce it on a different 
target by simulating with wake-up IRQ scenarios.

 From our analysis, the issue seems to be triggered by commit 
1afa70632c39 ("serial: qcom-geni: Enable PM runtime for serial driver") 
in the pinctrl subsystem.

A fix has already been submitted, and we’re currently waiting for 
Alexey’s feedback to proceed.

>>
>> This is just and should be reverted long time ago.
> 
> I will send the revert, because this is just mocking the kernel process.
> 
> Best regards,
> Krzysztof

