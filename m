Return-Path: <linux-kernel+bounces-878629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A99C21214
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707AA3AA4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38C33C530;
	Thu, 30 Oct 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b="nzH37uCH"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57671E260C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841138; cv=none; b=tlXu+aGgj0lQXNRBAd0WYbLx9yr2mgh2PUFLfVh77dnHliXrWffHEK8+GIYd/PIBT+I2nWDuRaVoZ4bwsf122lrKjmprKxt+n6WM29CWdyrkNdl3bjql9Vi7xTGNowAeocZu2a2ZBmgG6EsomGTf+MQETuxI2bsPS/FR8BYiiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841138; c=relaxed/simple;
	bh=kauf8BeeZKXNoc5KIySCo8bhaQstpzy8PANGBYI/d0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLwHfJ6is/x1Xz+fj4RfA8mXartMd27qaFWmetzq4vQObWwnn3ub3EYZLU6Zi4seFPlmog6H9ec4sHvgJIBBtE4KqcnmjwBxX0QprwqEmuLoIr5WIIuN5ae7v9nvZwXXBjrSFclT77gTTe6cf80FlBEXKZTA8SpQV6LjmkqV6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com; spf=none smtp.mailfrom=immunant.com; dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b=nzH37uCH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=immunant.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so1542593e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immunant-com.20230601.gappssmtp.com; s=20230601; t=1761841134; x=1762445934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqNtoyinBX8qcU7mGg+XDQHvMcc/k1G1RSgPd+RXN58=;
        b=nzH37uCHqkIR4+V1z14dzMk7xs2iaBu+qxGkvweJaPBv3hs+j1MQWobTP5lpM17tTB
         JJqRpMmz1ysWQU4QxzgLFVIRsjK8o8/zj+iw9FUeIjHbJao0rYms6VMvCmTmf/v5vogH
         e902V4b6lXaSvqiiWgfEB3B8Q/A+2UJ1ipv89ghXPdJKwDs0zoawEALgjjNHRZti0MBK
         jS0k33vS98XSqrwYCK+/dpxSAkWZ2ZlJDMSiWDFRunR+T3LM8awzvPcETUtmTSg1XVB/
         kdtzldKLmsEjauBXtM7ax8VYcVvrU3l1sHwWvI9P62/DBSNL5cVeoH/P3jfO2A4Xofe2
         ELxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841134; x=1762445934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqNtoyinBX8qcU7mGg+XDQHvMcc/k1G1RSgPd+RXN58=;
        b=ufn7SG2tz0dU1cpHtbo5kahbtWrU964YCPz4HdU6uLUePmGCbtsA9BPCJKDsxZS92B
         guu0HVQ9ESs943nc+EL7o4K9A902LvWocvT32bcAvQNY3WyKmT2HxxLfFI2+gQ6lw6LQ
         yTX29JV/aqCNyI81xAcXG/KvA/1cN5f19VCbBp68TtkrmljbVrouhpFmj0NEPS73u1i+
         aoZIKSW4hHV8nHT8X4YE0JpZ2Pm4yMyYpyOaOEPAqVcRQmctaUegQsOzCfX4OxSv/ZW7
         Tr4/UUSC7+88qS2LD9bzVv+YSvczO+InmBvg6/JYV6UxwQwdef2M5s4HyEylbNsr3TEw
         eHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmIZ4pL+z9Ze9KluUeXYSb1YB+PP/HUL1QtlTK15w4DBiM77WyJBKxxFMgbtOkFR0J1ijEDEyYTEOnjxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkB/IEvWbOdqv/B5OXowUUBM+tavwXIxEeOm7XH+MAI33HeptZ
	AYUYcoXBms319aZ4kA/2R2icCBOG8FP6pT3+2YPzJ57Mo6YjWHOaUD4sg8yPzJVSr3U=
X-Gm-Gg: ASbGncua2MG047a31fdsAkxGSo3nNiz5PmkQil0weNZCWZ/AetuWrSV8ICJDBCfeFnX
	Ql9UlXLtBczEsT8e8YRQyBo5AqdVOmwpZE/Fdw3mVXI8J9lLShgEuSzHSuKtYMMTwhZEC2bsDgU
	WX13RTODCZxmGaj0NP6k5KvxUW9nHwym+vW5KO93MPaiJ2RYT7WpMEkomx4Lwf6Kj891/lUiAN+
	vrEtCRXg3riCp9OQibsnqtC4L79ECvNE2Kv4DL4WCSHMEe2Et2QdVMjFvYQeCgjlQ1IHgivOHHj
	5KycmYkvRPX4ZUGpYuJfbdu678yF3tomzsvVQLk2tGkCdI877z9DmZxp+nGRspvn3mTr7/B35m4
	4Ak3+q9dwNg2qXKycaf0bgmkjaYg5kJ6vIZrL2p3Nd7DtkQBWfHJ5juXL65jPvU8Q7fgbZKzXS8
	Z6CDpCPF+uU5kQEhdZBCQ2Ze6lBv/1j6CmgxojZ/51zd/iJu3zHbYDEN/lpQkjZz0Ndg==
X-Google-Smtp-Source: AGHT+IEr5Z9g4wWlPda3oSInszfMw3AYzjKy3w2kVd2XI9iVXSOcL/bI6ZR5gKAx0+1+VUI13DCoYw==
X-Received: by 2002:a05:6512:3b89:b0:594:1b24:b419 with SMTP id 2adb3069b0e04-5941d4febfbmr110344e87.3.1761841133288;
        Thu, 30 Oct 2025 09:18:53 -0700 (PDT)
Received: from [192.168.1.11] (0x5da5f0d7.static.cust.fastspeed.dk. [93.165.240.215])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0c6269sm40611501fa.30.2025.10.30.09.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:18:52 -0700 (PDT)
Message-ID: <fb69e006-8460-4a5d-a19e-28bdec10434d@immunant.com>
Date: Thu, 30 Oct 2025 17:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: arm64: Support FFA_MSG_SEND_DIRECT_REQ in host
 handler
To: Yeoreum Yun <yeoreum.yun@arm.com>, perlarsen@google.com
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ben Horgan <ben.horgan@arm.com>, Armelle Laine <armellel@google.com>,
 Sebastien Ene <sebastianene@google.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251030-host-direct-messages-v1-0-463e57871c8f@google.com>
 <20251030-host-direct-messages-v1-1-463e57871c8f@google.com>
 <aQNsrjceYM3RvY0e@e129823.arm.com>
Content-Language: en-US
From: Per Larsen <perl@immunant.com>
In-Reply-To: <aQNsrjceYM3RvY0e@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yeoreum,

On 10/30/25 2:48 PM, Yeoreum Yun wrote:
> Hi Per and Sebasian,
> 
>>
>> Allow direct messages to be forwarded from the host.
>>
>> Signed-off-by: Sebastian Ene <sebastianene@google.com>
>> Signed-off-by: Per Larsen <perlarsen@google.com>
>> ---
>>   arch/arm64/kvm/hyp/nvhe/ffa.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> index 4e16f9b96f637599873b16148c6e40cf1210aa3e..191dcb301cca3986758fb6a49f15f1799de9f1d1 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
>> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
>> @@ -857,6 +857,15 @@ static void do_ffa_part_get(struct arm_smccc_1_2_regs *res,
>>   	hyp_spin_unlock(&host_buffers.lock);
>>   }
>>
>> +static void do_ffa_direct_msg(struct arm_smccc_1_2_regs *res,
>> +			      struct kvm_cpu_context *ctxt,
>> +			      u64 vm_handle)
>> +{
>> +	struct arm_smccc_1_2_regs *args = (void *)&ctxt->regs.regs[0];
>> +
>> +	arm_smccc_1_2_smc(args, res);
>> +}
>> +
> 
> TBH, I don't have a strong comment for this but, I'm not sure why
> it is necessary.
> Since it calls just "smc" with the passed argments,
> I think it can be handled by default_smc_handler() without adding this
> function but return the ture for DIRECT MSG2 in ffa_call_support().
> 
> Am I missing something?
Calling `do_ffa_direct_msg` from the host ffa proxy ensures that the 
caller has negotiated a FF-A version with the hypervisor first. In turn,
this means that `ffa_call_support` can use the negotiated version to 
decide whether to proxy this interface or not.

Moreover, `kvm_host_ffa_handler` currently proxies host FF-A calls. 
Android also proxies FF-A calls from guest VMs via a similar function: 
`kvm_guest_ffa_handler` so this function avoids duplication if/when 
adding a guest proxy. This function is also where one would check FFA 
IDs before forwarding messages (to prevent spoofing). You can see the 
downstream implementation here 
https://android-review.googlesource.com/c/kernel/common/+/3422040.

> 
>>   bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>>   {
>>   	struct arm_smccc_1_2_regs res;
>> @@ -915,6 +924,13 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>>   	case FFA_PARTITION_INFO_GET:
>>   		do_ffa_part_get(&res, host_ctxt);
>>   		goto out_handled;
>> +	case FFA_ID_GET:
>> +		ffa_to_smccc_res_prop(&res, FFA_RET_SUCCESS, HOST_FFA_ID);
>> +		goto out_handled;
> 
> I think FFA_ID_GET should be a seperated patch?
Agreed. I've dropped it from this patch set as I don't think we need it.>
>> +	case FFA_MSG_SEND_DIRECT_REQ:
>> +	case FFA_FN64_MSG_SEND_DIRECT_REQ:
>> +		do_ffa_direct_msg(&res, host_ctxt, HOST_FFA_ID);
>> +		goto out_handled;
>>   	}
>>
>>   	if (ffa_call_supported(func_id))

Thanks,Per

