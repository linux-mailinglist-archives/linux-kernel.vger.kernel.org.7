Return-Path: <linux-kernel+bounces-827937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC45DB937B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29EB190681E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F22FD7BC;
	Mon, 22 Sep 2025 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX5E30KV"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED46261B71
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580143; cv=none; b=GDmhLSRPD4O4ClM0BUSEVTDlwttvv6FFBqSm6R1Nizj1W09bYQl7JHGZdu160x6+XFQyAQB4cS+bSUOvvwZRgWz5Ur/Vi0xAzFW/xfrXNcFykmX72UZn8z/mw76dOMjf8YisHZ7fZofTjCaLTEWUDh3mrtvzwCkqblcFNrQjNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580143; c=relaxed/simple;
	bh=bnoVvW7A4MZboCUWUp3uJoL/5QHRg63EHvbJEX0C48k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5bTccE44fZRZmox51O+BmlkjsX2+gg458OjzakQtrLE4Rx6eAmajgSIHuVS68CkeJVejXnGTFQp4fL+k5a409VPsowiUMXr3HL7oSmASQeIPjthuduy5OZmG9ZTpsaxI97wwAdDH8C5xzjGN9n4dv6go6iEpSwYfkKUL/UseQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX5E30KV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551b040930so2147893a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580141; x=1759184941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtoT7lETDiyBBBUdd6zpmqK1Q4j9ahP216sTNQ0nsxM=;
        b=IX5E30KVxgFPJ6p2dHUpUxJRlT0Z0s83563QpBj3WbExEofAH4EUzOd3Sa4/OvtHdI
         pz0DWgou/hhLEq0Y+bU/L4UEJ/8CWpNBYtOpE7Zx7MIm+7jScXnD8OqztbfRm3QMA/63
         +oxrnjL7NNyg/wXArhqBEgm61tsTA0dGcRDFCZC9bSB3BFjKISIcx12mhZmrpZkBMCWf
         IW/ZVCumH3zDLWz0kVZG9DjWmrOQSM0A4m5cFKzNF2Z3DzNOx8ydCWeNKfgdOrS76iAB
         YH87T9V1nLB2NVBQ0ORRQNcsAwnWaRPmGshhNrDMtRldhPUF91VQlOh/YYdLRASXc6hP
         O6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580141; x=1759184941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtoT7lETDiyBBBUdd6zpmqK1Q4j9ahP216sTNQ0nsxM=;
        b=J5kal7ilJ1+95unJInHqn2nNmZ90Qk5b75EbUw/D3AZadjfIa2F0Oe/FIwiurkb5Tn
         3HnFXr0yqDzZO3sguhAQpPBcYKHsR/hshPbCkUQW+b0wCFybXkjyYoObBZAoFsFwIcQU
         6SsYgtKdul0aY+lptjzn528NPDGxd/8Wuduq+apm6KMB8WAhEABWztLVByBJxleMr6yi
         vZmbZN7S3Dga07rRrWXQkx2RtoU1sVvFq9lcgV4WAW578KPFJAr5vF3w8MYjL6KyQamz
         bDsOeeTimE1KRvDTLHOE0fd7Ts7fCbcXRY6fTe7dFoWbGitzF9S4mk2WDqDU9X73nMW2
         RU3A==
X-Gm-Message-State: AOJu0YxeNAXUycIWlJK3eoAwdc3edgJ3wufNRV6mbMcIy2j4uekj31im
	1IR8mQ5VGbk+3iyPaNhFtrTdbcMhSvUULRgmNfSdTzfl8CPkiCH5i8Jr
X-Gm-Gg: ASbGncuF6pT5T3xP1k45gP6ez/nAtJ/7g7j8DyrLXGuXXZdumeJapM5lR3IKn2ps4YN
	QpCJNwkXyjZGu6Z9bLEyeEV1FYMNblVV2ht81ABh4GwNIJcNc66uL1t7V983xwwr4pNDyDSWJbE
	cQIGPsa0PMfEkm7ugPVPqfUbrqkMJGHdOijvOxnZw2vUmMBJUYNcPfe+R94/14lv9GYft/1QiQE
	uT+DLa9vys2Gx54dqR5Uhi9Ed/GKASTw67H/a6OVGtbXbkMsTTeqm5YMa4FZM4UswOmbu9s63W0
	D9RtNkoym1uXojhh1prf4ditXcZ1TCNalvfqDWeomAyyiqZg1j7BVzfanzCDdiZ4edoypwGqNSb
	yuD0R/3Zt0Bhg4SIH+3vqU7aYLTAUwQ==
X-Google-Smtp-Source: AGHT+IEr9MnnfuaOnEgl5Ok6lmMqyEMDd1YwFlpFnduveoNyqRB+X6CgKFY+fvDTCnEk46JVsmmqkQ==
X-Received: by 2002:a17:90b:3a8c:b0:32d:f352:f764 with SMTP id 98e67ed59e1d1-332a9542d69mr564005a91.2.1758580141402;
        Mon, 22 Sep 2025 15:29:01 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm10765908a12.28.2025.09.22.15.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:29:00 -0700 (PDT)
Message-ID: <864b1042-9494-44da-b87e-d4cd8aa1ec11@gmail.com>
Date: Tue, 23 Sep 2025 05:28:57 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Fix hypercalls docs section number order
To: Sean Christopherson <seanjc@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux KVM <kvm@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Wanpeng Li <wanpengli@tencent.com>
References: <20250909003952.10314-1-bagasdotme@gmail.com>
 <aNEAtqQXyrXUPPLc@archie.me> <aNFYL2Os3rbfMbh6@google.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <aNFYL2Os3rbfMbh6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 21:07, Sean Christopherson wrote:
> On Mon, Sep 22, 2025, Bagas Sanjaya wrote:
>> On Tue, Sep 09, 2025 at 07:39:52AM +0700, Bagas Sanjaya wrote:
>>> Commit 4180bf1b655a79 ("KVM: X86: Implement "send IPI" hypercall")
>>> documents KVM_HC_SEND_IPI hypercall, yet its section number duplicates
>>> KVM_HC_CLOCK_PAIRING one (which both are 6th). Fix the numbering order
>>> so that the former should be 7th.
>>
>> Paolo, Sean, would you like to apply this patch on KVM tree or let Jon
>> handle it through docs-next?
> 
> I'll take it.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

