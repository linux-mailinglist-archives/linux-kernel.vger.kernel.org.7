Return-Path: <linux-kernel+bounces-618961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD501A9B586
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4AB1BA5DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D24028D829;
	Thu, 24 Apr 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgJ+lrlS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB628B4EB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516309; cv=none; b=pjep+R8YDwHOxEW083FY5AA7uevSToREtu5/ofoea5yGxa28LoehtnLRyq2TQjfA33zGznxuQJRW8fvtqVRZS40tRFpz9T9CutriUpLRVRbeiNN04uMjdxoiwLWoEMHdal6i/dQ+8+0PFcwK/TA+g1ttJlm7r6gBWyItlxjuOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516309; c=relaxed/simple;
	bh=+3qGCQZl/U0MkFm/X6EpDwwucSxPvMb3L7QjZX6gyww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhNHheQ83iXF+XLycwsMy5SdK7N1i6p+ybpvkVRMTPQuXHea6YCiCMk2b674dfo9kGaRdFdi8XKbaxgHFm3ZYIhzZhQ6sV2eErtSe0jlOeRkIlUPq8rYfvmKLhWQk+KBS9V5fdLHdV6KpPYXaFxsE6E+7eug7euzsiRwPdVYqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgJ+lrlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745516306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M6iPlq0+lPq47ekL78NC2y1kZ/SereiKHjDQ5zOpW38=;
	b=UgJ+lrlS2MS4TR8PGGedgYAphPSuP9L/j+pD/PAIjblvpGXowHvNdsG1VEtxt8VCWB+m/h
	IGqTCbKe1B5bgR6HLXmX81Kdc2ftIN46tNl5pMacvXHvvyNJNqQYuIVlucSpqsL5+seppn
	cFEFJsYIqdnVkcHH9OhekAHjv5pIXdw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-WBF-oPjYP6ez6M-vHu7P4g-1; Thu, 24 Apr 2025 13:38:24 -0400
X-MC-Unique: WBF-oPjYP6ez6M-vHu7P4g-1
X-Mimecast-MFC-AGG-ID: WBF-oPjYP6ez6M-vHu7P4g_1745516303
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912e4e2033so496189f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 10:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516303; x=1746121103;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6iPlq0+lPq47ekL78NC2y1kZ/SereiKHjDQ5zOpW38=;
        b=pMe0Aefgge9X13jIxzCiCbxlTK2ncca83SFP08LEgi2QyoOENvi0oqWgiEWwfkmgNK
         2lDOQeJGsNlfudpzFQJfBBkea4FMNYyWhdO7kFQV2MKWqHKFQDLFMq8Fw5IB5E430MyY
         fpWZHHO31iklW2CoEMiotr/wOKP8a3EZIowdHQ6psxHuj8xg2mxkKifM7Al8FQCjgz/4
         JABGWcDsDu7w3WFfgZOXyP39OqcOJ/eVhS2ESBpSnjfhU4YQTAeaJDiRdqe7BL+TMCSB
         ReGzUHZuf1TzINFzpEaWnNPA+eFj2VFFDc4X+rv3ks68UEEBBghKgIDy+WGzjDhzpwQM
         0sWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXlOOf/haDZAp3NjFhb/4hhi69dPrOc/gAfUYsgBA2iSNq4y8vB3AePK7KiRnawWK9wxTbgpG/yrOl0F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVPPf2eQXaMHnpHwowlO8isAnPPja1i7aIQxokF75seXeqsCG
	FAJMoQ5CpG2LdIkbVINLKJFGln9sb6d+2B4DvLvxLCnvvE7HDZP1vWCwKk58EzpPSzllrAaM337
	xQuf9Ai6jz3inJ+J0RoaYpcInuuStVOQImD7t972LE/MJtHJKTZ96cOnoWtIDrcYql2rUPw==
X-Gm-Gg: ASbGncvk0V/ippy2+ZgAYzQhAZPrr3cfHFyW/aU3xhbhiTYH8BnF5ivvwyKaQFTCCZ0
	X8UFHxLIqvQIken+X9f2XQAcspoDru9sgKvHH0kOz52u93uqJSvwNTJfnNR7zN6tIbxiSOJ9fyL
	+W+r6gscaMrAJBwIG7IJC5nOfgutAQBGUfLi7bW/VzFMt3P/70CfUUEff7zccZrteKU0pftNcBw
	qqa1sXrhSGo3r0RFv2n8EirM42bJJXUfQGS9/J01LpOv+th+zHQ/lApoqN5ki6/IjD3O9yIf7Fx
	WM3uXeE0EraF
X-Received: by 2002:a5d:47cd:0:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-3a072a85d1emr194603f8f.14.1745516303017;
        Thu, 24 Apr 2025 10:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5D2IdhVkkhzZ2u4E9jNLM9y6rqvZsJQWcjcm75UgkS2t3YqrF/hXRwT+JfZpueEpjqert+g==
X-Received: by 2002:a5d:47cd:0:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-3a072a85d1emr194592f8f.14.1745516302620;
        Thu, 24 Apr 2025 10:38:22 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.161.39])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4a804fsm2858556f8f.10.2025.04.24.10.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 10:38:22 -0700 (PDT)
Message-ID: <df3b44a7-70b8-4952-a7d7-231e69c8d3eb@redhat.com>
Date: Thu, 24 Apr 2025 19:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kvm-fixes tree
To: Sean Christopherson <seanjc@google.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: KVM <kvm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250422124310.2e9aee0d@canb.auug.org.au>
 <20250422173341.0901ebaf@canb.auug.org.au> <aAeg8A7DMvTAjqVO@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aAeg8A7DMvTAjqVO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 16:00, Sean Christopherson wrote:
> On Tue, Apr 22, 2025, Stephen Rothwell wrote:
>> Hi all,
>>
>> On Tue, 22 Apr 2025 12:43:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> After merging the kvm-fixes tree, today's linux-next build (x86_64
>>> allmodconfig) failed like this:
>>>
>>> ERROR: modpost: "kvm_arch_has_irq_bypass" [arch/x86/kvm/kvm-amd.ko] undefined!
>>>
>>> Caused by commit
>>>
>>>    73e0c567c24a ("KVM: SVM: Don't update IRTEs if APICv/AVIC is disabled")
>>>
>>> I have used the kvm-fixes tree from next-20250417 for today.
>>
>> I also had to use the kvm tree from next-20250417.
> 
> It's a known issue[*], just waiting on Paolo to resurface.  :-/

*bubbles noise*

Done, pushed to kvm/master and will resend the PR to Linus as soon as 
Stephen updates linux-next.

Paolo

> [*] https://lore.kernel.org/all/20250418171609.231588-1-pbonzini@redhat.com
> 


