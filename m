Return-Path: <linux-kernel+bounces-840114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A6BB391D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0766C16EDD3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC0307AF5;
	Thu,  2 Oct 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8KGN9bL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B32FE56C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399895; cv=none; b=qK8XXZbx3t3Z5W4wVdEmJHBurRx/f+ZeT0LOHlBsyAMJbltMMFrFpW2/0HNvjuV66tR5Ctc9hEWkMvozDKgeSSMdJ1ZmzGIKYkjpSZWjZo/wG1Rm2fGxHYezUvunKBtC56XdxSJjUc1wcOrAM/zIsXBxARQ/if6aPvhsOcAYOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399895; c=relaxed/simple;
	bh=/MX8csmL+71ntCQVHdGF5lwfPuWf6oJ7Sa5sB3VI1Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUXerg7OCoyq+QOAQ2B9nStST7dxTIbsW0FZD3uIHZe80SGFr0+VNGcbcC9PzopBj3ukJ3Sc6pEnGlulkqF4osWkm9Zn57Pd0DlIfxKcDi7XA06JFqUc5GCrmaZID5E20WrM6Y5avFvkVJe1lSapI7yK6jBIJLBv+Mlq1dsX964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C8KGN9bL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so7048515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759399892; x=1760004692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8Bq2UEqpTUxftlSBdX7OuC2XFs3G/N0v0vwH32gU+A=;
        b=C8KGN9bLzhcYapv2qj0j1XZF7x21mthJQYXYvVjhCWm3ODvvjVaDxqcjQ00LViFwJ8
         8yw7Z3Ay2/vNY1Bh1rYCNfHnit264pm91NoPDOqH+XdQ0jE5lu6MwH9w4G8UcuL01hHS
         Q91u+Al7zdyknMl/oazwF/tSvQzqINVFb9rWujMBAzK4lxqiRUEFw5dcXNiT75pO6vfx
         Eft9Guf3Gf631vJR/ITPbrbgjeibumyYv3b5a423ZgQZLP8Br27VQCk3cNRhPcLaeADd
         ORRrrs88mVE8Y3yBcjMPYwp50vbuEtDl9c5bwiLiNZICqD4dgoqWSlrCp8OFQ0W2vU0L
         bCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399892; x=1760004692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8Bq2UEqpTUxftlSBdX7OuC2XFs3G/N0v0vwH32gU+A=;
        b=C3Wt+4tbnaqlWwc6N+NpNMqRS2ghDSbu3RiXnC+azwz5P0dBYxN+wrUiGbVLWEswk5
         vufodpii4ZyJ8qVo8B6RCL4K0fuA0PdFJkZEsNHmJeiR7k5xktxW+w1QLTRNQVWElbeg
         LS2oDmj0qbzJDpihefmrouo9CPsYkEPQz32wLht6OJdq2nU01JbsWRTfGFycfl/+JDt9
         t+lNyuFF3syG2dH8LzdSX+uTYg0ymysm5JisWEukHldIVUN3aEXz5WGG8Mo+6zpJWwl7
         yXXZ8CaxFPiqWlQ5bD9ajMfX485KJ0MYeIMaX5RgQH+p5s2KAFyuneOtZJ2k5hRfC4DJ
         TS/A==
X-Forwarded-Encrypted: i=1; AJvYcCUSNhqVW8Cvc/jFyhv+D64BOFqINafoznYKtyjOkn4l5IqTB1Et1K6/6ikuqvbpX16YE11kvY0fwCzKOmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUrSyQMn2aA558S1N1Y0EnpnpG8k2K34si+BbqYg072uGMCOhW
	vim8cEE3oWaJJu68wbo8j8buigt0k2HKTP10D7s62SqCSVn5osAWZAlxmu4i+Lo4lTA=
X-Gm-Gg: ASbGncvSmdrvWTO262MT1hudp4SRpQkk+RN8aTmx9ZFXyHlRznheN42QcKt4ZeiAA3d
	x0y0PqZ/van4JIIK6Z3WeoS1+H504M5Ocj1Dfj29WH7dG62Kt8PA/DTsIlYtU/cs9YtHpL8aeWM
	rJZOKSRUgdkP3COKANbktxqWi9fPwnBHPeU+kf9X3gG151LKN+597udpOZ9dHHmI3Eu7Y2xfFI/
	amuwEyflSBOr1lJFzG/A18UhUNWFjRk2yRPle/L7+WTtglvQeCKBjA/HJwADn626Vk8Det6cjmd
	8algCuSKW5mUSvv1b7ikIs6JZzvXSdKPXEIitvAmblV0jUXavcrXmRLsqPwDdEbnxdjeMQKrXUQ
	PEEZvaGiAkf0aGu4ne2I/VfA3PMNsB5bkyCQ7VR82YWe57eEuG+mgDInA
X-Google-Smtp-Source: AGHT+IFWh975vJvc4Ml/pCcEIsLQ9eEzaaf4VQkBY01lMYMfPFIlL3XanMh6oloBoFROEXbxSrta5g==
X-Received: by 2002:a05:600c:4586:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-46e6f7ff73cmr2978875e9.27.1759399892241;
        Thu, 02 Oct 2025 03:11:32 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d869d50sm3094531f8f.0.2025.10.02.03.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 03:11:31 -0700 (PDT)
Message-ID: <4d742477-f16a-4bc0-bb86-717bc0b560b0@linaro.org>
Date: Thu, 2 Oct 2025 11:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] coresight: Fix holes in struct etmv4_config
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
 <20250811-james-cs-syncfreq-v1-2-b001cd6e3404@linaro.org>
 <CAJ9a7Vh44rYWN3mjHPBq8pkBcPuhS2pTBZNaMpWgJECmPZtupg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAJ9a7Vh44rYWN3mjHPBq8pkBcPuhS2pTBZNaMpWgJECmPZtupg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 1:37 pm, Mike Leach wrote:
> Hi James
> 
> On Mon, 11 Aug 2025 at 10:32, James Clark <james.clark@linaro.org> wrote:
>>
>> Lots of u8s are mixed with u64s and u32s so repack it to save a bit
>> of space because there's one of these for each ETM.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 746627476bd3..a355a1e9606d 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -832,28 +832,33 @@ struct etmv4_config {
>>          u32                             vipcssctlr;
>>          u8                              seq_idx;
>>          u8                              syncfreq;
>> +       u8                              cntr_idx;
>> +       u8                              res_idx;
>> +       u8                              ss_idx;
>> +       u8                              addr_idx;
>> +       u8                              addr_type[ETM_MAX_SINGLE_ADDR_CMP];
>> +       u8                              ctxid_idx;
>> +       u8                              vmid_idx;
>>          u32                             seq_ctrl[ETM_MAX_SEQ_STATES];
>>          u32                             seq_rst;
>>          u32                             seq_state;
>> -       u8                              cntr_idx;
>> +
>>          u32                             cntrldvr[ETMv4_MAX_CNTR];
>>          u32                             cntr_ctrl[ETMv4_MAX_CNTR];
>>          u32                             cntr_val[ETMv4_MAX_CNTR];
>> -       u8                              res_idx;
>> +
>>          u32                             res_ctrl[ETM_MAX_RES_SEL];
>> -       u8                              ss_idx;
>> +
>>          u32                             ss_ctrl[ETM_MAX_SS_CMP];
>>          u32                             ss_status[ETM_MAX_SS_CMP];
>>          u32                             ss_pe_cmp[ETM_MAX_SS_CMP];
>> -       u8                              addr_idx;
>> +
>>          u64                             addr_val[ETM_MAX_SINGLE_ADDR_CMP];
>>          u64                             addr_acc[ETM_MAX_SINGLE_ADDR_CMP];
>> -       u8                              addr_type[ETM_MAX_SINGLE_ADDR_CMP];
> 
> this is 16 x u8 - could this not just stay here?
> 
>> -       u8                              ctxid_idx;
>> +
>>          u64                             ctxid_pid[ETMv4_MAX_CTXID_CMP];
>>          u32                             ctxid_mask0;
>>          u32                             ctxid_mask1;
>> -       u8                              vmid_idx;
>>          u64                             vmid_val[ETM_MAX_VMID_CMP];
>>          u32                             vmid_mask0;
>>          u32                             vmid_mask1;
>>
>> --
>> 2.34.1
>>
> 
> These attributes have been functionally grouped for ease of
> understanding. If we move the _idx values away from what they are
> indexing, we probably need comments cross  referencing from where they
> where and where they have gone to.
> 
> Mike

I missed that because although there are newline separators there were 
no comments for headers. Dropped this commit in v3.

> 
> 


