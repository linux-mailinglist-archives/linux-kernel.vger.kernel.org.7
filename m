Return-Path: <linux-kernel+bounces-707220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B889CAEC15E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D191883D62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838E25A2AA;
	Fri, 27 Jun 2025 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ko+fs5wv"
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB71E98F3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057142; cv=none; b=rY+6MYz0oDtaQANW/E8u7QHlBhiBzOjCm/g67+qass82CWKOURNnT96tpKm8dSYX9BX5PsaFaeovzNkQNxhiLcWCnHiVIyjvhoimtL/vuGXIMn9FvqleLw8vQ3DsZNIRDaVDs47j6fWWwLgmcPe4eNEjWtbH2XGuG0fJBrF909w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057142; c=relaxed/simple;
	bh=tdvLWFsh/wI9WWSqIsGVNp6UW8sVmmyQUHoavqrwGBE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=SJLSTCqim/OnxUrExt07U4By7dx3yzTDc6pCKvlyt14Ggc+pLWWLNfs+EMErRG+P0UWY/FzXNCW8fkFx+KVuFUVmqHOcYaeOIfwOnqfkWIn4LR4UIE3tz4KRcJY/zOVYW598XeXitJU6oVpJR/TI9XgDTgC30o7Vo5JupvfaFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ko+fs5wv; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-40b27ae3317so255977b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751057140; x=1751661940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtzxPj829hxx6a8LNGtfeNdfTNyEQAZxil+yeQpRBG4=;
        b=Ko+fs5wv4uMytKM8pW0AJLOBZnoXOsG09Q+tt0pCgXuY627EtTamIQ3WkgNwSZ3dPO
         yxSAsf0dw6WGFu8v1DZEjztVsW2L4lK0S4v0G6m1qrMdyXV3HMw4nA02AF1FZamFKlHv
         oOpz1fiG2vQdXOGrEcGoXxgyjuiMt5Z697uKKtgyE7J6x/M9N7bykXR0FZ7KRcEcXsdx
         bgYEk5AKAYWV3MaDJObI1Yq9U/opK9BqFeMn1iCHm7p0STdvW4AxCepFMhs+u9LnCGX7
         UCsww4YibYqoRs0g/ncy7ypLAzM0phrJQRabBRvO+tiE1+EM6eMvOsBK6RSD5LNbhETp
         kDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751057140; x=1751661940;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtzxPj829hxx6a8LNGtfeNdfTNyEQAZxil+yeQpRBG4=;
        b=NfyCD3SD5wBAKxqZTqhQe93raY/b7BNda18HCgmFBC1R/cl436aJt8xh0Ny6VEYwpy
         snwJb9Tb96vybjgcr6tX9a08LG0uoB/bNKYUSnFgV2hnzpIkr9HZqof1iT9EMMHT+FHr
         nBWDEtmXdkTuXMuXnbVgX9HRjnu2etchju0AHtWISi/1AQa0oSwLm464zQF2t630oOZ+
         7TosqAL3y/vJsdrp6i3Jtli1UaYzcgbcrhKsExwSlaiwUboqqkactvWVLFVGjW97LSk3
         uNeejqDdzcVlN12J12OiI5rPVphsDGKnV2p/Yvj/FxBBV/uzivCwvmHqgzoEmCJKOY6b
         iDag==
X-Forwarded-Encrypted: i=1; AJvYcCXQA+ufiKiMjmyitEvbM/YLCJP7fjn1UX1DDV8aMH7mzpJ66pL7wbDA9E/peN9pXMqSvpay5TMLn86u5fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3Lwx3A7VxI9nveoRxvNfVNWjfPUQMGXHqH/uV4N7JJ7yE5Yb
	C1XRT5s9TK9qWtyq1ranv6ECWAVzVaXA+jLN0htN/aX4V71xOGP8nNEGl5RL0TIVqPh2dTZOhFJ
	AezdYiX50UW+DNQ3aC9AxHRo3LA==
X-Google-Smtp-Source: AGHT+IEVJG2F41QRpFsQcHOZM3LLETHwJl5cQHVqdrJwuBS7mGDCrIIEijxTBzEQVHHKwtJ80l+vFT15a5JN0DRDMA==
X-Received: from oiu5.prod.google.com ([2002:a05:6808:80a5:b0:3f9:9583:af9b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:21a7:b0:406:6e4b:bd91 with SMTP id 5614622812f47-40b33c489d6mr3625383b6e.7.1751057140014;
 Fri, 27 Jun 2025 13:45:40 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:45:38 +0000
In-Reply-To: <603eb4c7-5570-438c-b747-cdcc67b09ea6@arm.com> (message from Ben
 Horgan on Fri, 27 Jun 2025 10:04:21 +0100)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntecv49aml.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 02/22] arm64: Generate sign macro for sysreg Enums
From: Colton Lewis <coltonlewis@google.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, shuah@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Ben. Thanks for the review.

Ben Horgan <ben.horgan@arm.com> writes:

> Hi Colton,

> On 6/26/25 21:04, Colton Lewis wrote:
>> There's no reason Enums shouldn't be equivalent to UnsignedEnums and
>> explicitly specify they are unsigned. This will avoid the annoyance I
>> had with HPMN0.
> An Enum can be annotated with the field's sign by updating it to
> UnsignedEnum or SignedEnum. This is explained in [1].

> With this change ID_AA64PFR1_EL1.MTE_frac would be marked as unsigned
> when it should really be considered signed.

> Enum	43:40	MTE_frac
> 	0b0000	ASYNC
> 	0b1111	NI
> EndEnum

Thanks for the explanation. I made this a separate commit because I
considered people might object and HPMN0 is already an UnsignedEnum in
my previous commit.

Do you think it would be a good idea to make plain Enums signed by
default or should I just remove this commit from the series?


>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>    arch/arm64/tools/gen-sysreg.awk | 1 +
>>    1 file changed, 1 insertion(+)

>> diff --git a/arch/arm64/tools/gen-sysreg.awk  
>> b/arch/arm64/tools/gen-sysreg.awk
>> index f2a1732cb1f6..fa21a632d9b7 100755
>> --- a/arch/arm64/tools/gen-sysreg.awk
>> +++ b/arch/arm64/tools/gen-sysreg.awk
>> @@ -308,6 +308,7 @@ $1 == "Enum" && (block_current() == "Sysreg" ||  
>> block_current() == "SysregFields
>>    	parse_bitdef(reg, field, $2)

>>    	define_field(reg, field, msb, lsb)
>> +	define_field_sign(reg, field, "false")

>>    	next
>>    }

> Thanks,

> Ben

> [1]
> https://lore.kernel.org/all/20221207-arm64-sysreg-helpers-v4-1-25b6b3fb9d18@kernel.org/

