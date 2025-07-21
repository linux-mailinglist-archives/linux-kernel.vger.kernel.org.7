Return-Path: <linux-kernel+bounces-739942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB4B0CD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B73E188F53F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B2A24290B;
	Mon, 21 Jul 2025 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b="RnFZEonK"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BF242D63
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137828; cv=none; b=P3+w1Clx9DWlaoZDWk3LkUZob/IRbQuSj/XM3kiHcXFy1xK8fNZXQSkZ1CsNHWB7CQ0ZhTmGxfpi9c4r8FH+wgQFSXX9dGeMh/VkQXwWZuOrAS802veUSf+nPNS+zB1ihiIaOhJ4oO9dYprChkuayVREyyeOkVUuBBRHMPB0Gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137828; c=relaxed/simple;
	bh=7vCPTSGyCLREhkwADBBcRHlYWjmofVT+oCRCxeLlj8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp1It3hiBM5L3oZgEzEv8SJvWwr/uA+QwRDOj8k+Qwu6L42qQprJgm1cGAAdDtRMWQFiqUvQnbbtTr1Y0QTXjRME8XSrLnyPB7WZCm/4mz4HAEKapAi+uOoVysUZ75CprblHF8lg5iyFXjO4y6cSu9GyW2V0c7Zc+exvfEbIBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com; spf=none smtp.mailfrom=immunant.com; dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b=RnFZEonK; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=immunant.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso3960521276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immunant-com.20230601.gappssmtp.com; s=20230601; t=1753137825; x=1753742625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDLiz8FMfzrfsb7Xo3AVv+D+VOndCOPqvNkFpYC+ujA=;
        b=RnFZEonKeUtaRMiB4BtNxiHZYfGl9sU1AdHGGbKnwu4hEfwMJnwkvwm2Oy+J6Jo5jh
         G7qlQOb1FQ3bpWOH8ALDJTGImLGripj2ZLiOh4oXGlLf/lKww+OMPo95F67V1XrwQKxU
         9/T3jOqe0A2jcBzYiIcKBa2CZbbA7puWJfqPJ5N0GbzFkvpvtUFP83847h+2pLfBnDrU
         MiJn37QVWL95BTaAWS9VK2C1UhItRUpGi8l1LxeR/YLDGq8zqE+hWIBJ1HJDL3n4PRYK
         6GNo0X5npRoEA9Py7292yMfJ81JsRBHXN0rfv82z0unhykFXN9Sv8rKPqmaXOtS1RtS7
         XIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753137825; x=1753742625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDLiz8FMfzrfsb7Xo3AVv+D+VOndCOPqvNkFpYC+ujA=;
        b=RinyFJzOB/VUyHrVGg+N3wonmOL3kKfOSMItnjixaTJJhw/k7ZGbA2kp9xaj0eyGin
         aTVJslSSZQv4ahPFsz/pVpNvOeYrd5cEfKQRkjJ4ix9RfMCnty/TP3bdMDmCEmGGdgcd
         stGehtLwUeKYvzJsv33GFXXB4e1Rqfo+Ue8/nI2UswTO/wDaXoEowDAm3YUgRhmw+BXa
         GUmbqVLyk5rT+UidCsU4SnhBMIMaO3RZZTrjnWj/ZPdmoSFEgu10qiAMIVMBv3Pbc8ip
         QKYyaI8AoILj7MqD40QdCm2rjPortWgQNyy5RzyoTYbpmPumRPPf32drAjtfAhVTE9Pj
         qiHA==
X-Forwarded-Encrypted: i=1; AJvYcCXyegV3Dh2a9vL+/cln26fa6QLnntEWZsyzBLeD/NzHN1IJdt2Kt5Goy+fF4swEr96Ez8/bHUnP14wuU44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMnW3L1iJVZ79sck8S/A2vkWUOVv1ynpG/uNAgRunSipCJ0Pe
	ZDr3N1wjvzpv8Ac7wc+bNG50UoF/5Dg0H7Yl/e9tXd9eIxqRNlguZmHS1frXQK6KLm8=
X-Gm-Gg: ASbGncuzfyD7VdW18v5GGw3/rBLXA3LLe63ukVOrWn+K77MF/sAtnywnDrnVIjNBjDs
	LvpaRnAa99B7Zdm4mnagbvewolwB0lYD6lcMhl2ECTN/8HLgcwpGmNnhpVIrZ0RVfGa/JjqsXoI
	VMwJmsiwTFX2qEZaLMkQ9jvcv2XWG29SU7FMjTqP2woueQYV27AK/j+2tGcEU12WnEN2cwgFvyX
	q1DaIaGnQqmpaddklz3KcvUajcNH34kCq3qywA90NW5UfKeJ3TR6QSjn9Hjw6omQpQdQICF2vr4
	D2L2VcPYXkEhmsNxjK/PeFRA9aH7AjUcxAowm4iIOBnIHzsUYmLHjvep2azd2Xm5CJujAqIFihG
	ZDFfzrLb643r714g23dGl44BNSw==
X-Google-Smtp-Source: AGHT+IEpyRag75hc7wIz2NAkH4ib5Oe2/59jHMeOSeAr7Vhqgp5XGFfjMhc7CtftjhemnWwEjA2myQ==
X-Received: by 2002:a05:6902:2190:b0:e87:bdbe:103b with SMTP id 3f1490d57ef6-e8bc2433f8dmr26729859276.5.1753137824850;
        Mon, 21 Jul 2025 15:43:44 -0700 (PDT)
Received: from [10.10.1.14] ([12.9.190.3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7ce0e246sm2864343276.28.2025.07.21.15.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 15:43:44 -0700 (PDT)
Message-ID: <25ba5929-79c0-40b8-b529-79a37914605d@immunant.com>
Date: Mon, 21 Jul 2025 15:43:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ2 in
 host handler
To: Will Deacon <will@kernel.org>, perlarsen@google.com
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, ahomescu@google.com, armellel@google.com,
 arve@android.com, ayrton@google.com, qperret@google.com,
 sebastianene@google.com, qwandor@google.com
References: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
 <20250701-virtio-msg-ffa-v7-5-995afc3d385e@google.com>
 <aHpRvBO864x1vvqP@willie-the-truck>
Content-Language: en-US
From: Per Larsen <perl@immunant.com>
In-Reply-To: <aHpRvBO864x1vvqP@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 6:53 AM, Will Deacon wrote:
> On Tue, Jul 01, 2025 at 10:06:38PM +0000, Per Larsen via B4 Relay wrote:
>> From: Per Larsen <perlarsen@google.com>
>>
>> FF-A 1.2 adds the DIRECT_REQ2 messaging interface which is similar to
>> the existing FFA_MSG_SEND_DIRECT_{REQ,RESP} functions except that it
>> uses the SMC calling convention v1.2 which allows calls to use x4-x17 as
>> argument and return registers. Add support for FFA_MSG_SEND_DIRECT_REQ2
>> in the host ffa handler.
>>
>> Signed-off-by: Per Larsen <perlarsen@google.com>
>> ---
>>   arch/arm64/kvm/hyp/nvhe/ffa.c | 24 +++++++++++++++++++++++-
>>   include/linux/arm_ffa.h       |  2 ++
>>   2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> index 79d834120a3f3d26e17e9170c60012b60c6f5a5e..21225988a9365219ccfd69e8e599d7403b5cdf05 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> @@ -679,7 +679,6 @@ static bool ffa_call_supported(u64 func_id)
>>   	case FFA_NOTIFICATION_GET:
>>   	case FFA_NOTIFICATION_INFO_GET:
>>   	/* Optional interfaces added in FF-A 1.2 */
>> -	case FFA_MSG_SEND_DIRECT_REQ2:		/* Optional per 7.5.1 */
> 
> I think that's the only change needed. In fact, maybe just don't add it
> in the earlier patch?
> 
>>   	case FFA_MSG_SEND_DIRECT_RESP2:		/* Optional per 7.5.1 */
>>   	case FFA_CONSOLE_LOG:			/* Optional per 13.1: not in Table 13.1 */
>>   	case FFA_PARTITION_INFO_GET_REGS:	/* Optional for virtual instances per 13.1 */
>> @@ -862,6 +861,22 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
>>   	hyp_spin_unlock(&host_buffers.lock);
>>   }
>>   
>> +static void do_ffa_direct_msg2(struct arm_smccc_1_2_regs *regs,
>> +			       struct kvm_cpu_context *ctxt,
>> +			       u64 vm_handle)
>> +{
>> +	DECLARE_REG(u32, endp, ctxt, 1);
>> +
>> +	struct arm_smccc_1_2_regs *args = (void *)&ctxt->regs.regs[0];
>> +
>> +	if (FIELD_GET(FFA_SRC_ENDPOINT_MASK, endp) != vm_handle) {
>> +		ffa_to_smccc_error(regs, FFA_RET_INVALID_PARAMETERS);
>> +		return;
>> +	}
> 
> Why do we care about checking the src id? We don't check that for
> FFA_MSG_SEND_DIRECT_REQ and I don't think we need to care about it here
> either.
FFA_MSG_SEND_DIRECT_REQ is handled by do_ffa_direct_msg [0] (in the 
android common kernels, I'm not aware of efforts to upstream this).

I patterned the check in do_ffa_direct_msg2 off the checking done in 
do_ffa_direct_msg. I pressume your reasoning is that this check can
never fail since we pass in HOST_FFA_ID in kvm_host_ffa_handler. My
thinking was that we do need to validate the source ID once we start
using this function for requests that come from a guest VM. I could
of course add the check in an android-specific patch, WDYT is best?

Also note that since do_ffa_direct_msg was switched to use SMCCC 1.2, I 
think it can handle both FFA_MSG_SEND_DIRECT_REQ and 
FFA_MSG_SEND_DIRECT_REQ2. If you agree, should we upstream 
do_ffa_direct_msg and use it to handle both of these direct requests?

[0] 
https://cs.android.com/android/kernel/superproject/+/common-android16-6.12:common/arch/arm64/kvm/hyp/nvhe/ffa.c;l=1446

Thanks,
Per




