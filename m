Return-Path: <linux-kernel+bounces-735537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8340B090A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E56217B889
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3E2F9490;
	Thu, 17 Jul 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKyow3X9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6372F85DE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766398; cv=none; b=ifrVbAgm9VYNUevzVt+KMJoo6rdPlcMXoCqCyjYw5AvZUcHNQ00UhGpiEgJW8jUJouZupSY1HOvEtQkN7LzEQzKwqPSv23dzew9znFg1ZbSBkckMpYwIuEBnYR856AKjRwcu1sE9xeum5T+OEvUHd4xD+eHJpySFOqVKoEnov14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766398; c=relaxed/simple;
	bh=HDxfFlOGFn9CFDmRQhVsbQ+v7z0qiqG8JGKHslmmxuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOWzbf4YIfHwSH6QYoPQQnqUREusrilyV4Aiu8OG4LQ5DcYG0ggj2E7FFCVFRGShA/oceV6k15WGh8kkseZSbbmKkb1+SWJaRszBX/vusGEUt3Jr+OeevZtHapaoW61uDE5sTiXfLXYGWQ4DYlU1TLB48CcDfwz3oGuI8l0xTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKyow3X9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752766394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9u3jkQmKaVC8b7M30nAox3a177snAGY8jpNVGHawZuk=;
	b=hKyow3X9FPNrJHqeHKPcHjoTQ8U3aV7Z7ErHShoOxJe52bAfywvqkODA9or3aTRXw6jPhk
	CaXQsnDIUcRP26VmoJLi5DFsH6l1wAufrihuDwAKX84cByGcFfByFSvEu2Hc3xTqZ1YsUf
	UNIaN5Du72Uvx/LgFEHM8KZF4DJefos=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-hKVEkL7dPp65Xn075SqWAA-1; Thu, 17 Jul 2025 11:33:12 -0400
X-MC-Unique: hKVEkL7dPp65Xn075SqWAA-1
X-Mimecast-MFC-AGG-ID: hKVEkL7dPp65Xn075SqWAA_1752766391
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so688850f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766391; x=1753371191;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u3jkQmKaVC8b7M30nAox3a177snAGY8jpNVGHawZuk=;
        b=bjaUgE/PFWh0KTt/OBOtzUzeK6ZJ3BaULjWutlIpXLIPF4IvTlu08mD0BN2rXJTL49
         7EnHaTrYEGEbVCHuq12MDwPFaKMjYOUx9DKd12BfOXFWJeP2hhof/+eL9ERn82Hl9IQ6
         V8EQZGAYrENwBwfP2VZSdK17nyceTfgFAKKhtHPdZBOdiGFsDXZBGrz0fpFrTGNZZAIt
         eRHmplwj/XwA0gD3xKCQoSHSd8J3OuJbmK6Hrdn1zJERBdG9jLCX+OFxOxNa1NXZUAIx
         qLCjk4ptj+0hx/Ivh7AWn8bim2y2Ve6MZZVbeanPxaE0eK4jMwzhCaapp2uQudKPhoGL
         gFNg==
X-Forwarded-Encrypted: i=1; AJvYcCXF7Uo0oQc7UBMRkkrRhCLGAV2u8pfu4M8IrbWSngcHCAFMEv5EgetyT53DBKW7k+9ry+/SVLDhtLUwShw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwB9QmQIsy7yzUDQCPy9mbCkRZB/ow+aHE4PgvU5cpedbkjuJv
	Xf3ELNk6Nd0B+37WBwSUDCk7QtHCLT4hg8B/B30FbRHnhm6xQqc2u8ShfVY31vfokw56MIV1QjO
	y1/DqldTJGneVKoJYCqxXBuvcG/ZJAvQ9XzL0SqfjGAJzbN5DhWx+F/fOWxcTjj0Q6Q==
X-Gm-Gg: ASbGncv5dJaNyQPIqlnaqHhwrTOunb9RFJ9IrFn5n9zltNqxr8I34FbBoCsp7zt5eOY
	ZAgF6eTjaQpzmVcOkSVh6CUwAW7xXCfPXCK4U/C7lUxweCVxJRH9GUH1CzBQEuzxBShK76PrZw0
	tTFrj4qplHvhc/aohc0B/BwIRVICD5piHMG6rRYNhizeaPx9M9c66rVJwYrZahp8sDyl3ByLwsw
	s6YzGZauI9iXGzMhbq1OCu3Cy+IbuK00HPGqVhnIev6yMnGrt18ljaqT0UuDc8SpTDOLyEWAUAY
	AyPVXVTWpV/aBv82zDbhkyd6RazA2fMbz/Q1x941oEI=
X-Received: by 2002:a5d:6f19:0:b0:3a4:fa09:d13b with SMTP id ffacd0b85a97d-3b60e54aa5fmr5473589f8f.59.1752766391238;
        Thu, 17 Jul 2025 08:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv8T6LhzO2ho2iDiU2DAqnJRJ77W3HHDa1h+oPF1DiEVcnbc+uMFWcDWXrY7P76nKz7xa25g==
X-Received: by 2002:a5d:6f19:0:b0:3a4:fa09:d13b with SMTP id ffacd0b85a97d-3b60e54aa5fmr5473562f8f.59.1752766390743;
        Thu, 17 Jul 2025 08:33:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45634f5ea01sm25459335e9.14.2025.07.17.08.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:33:10 -0700 (PDT)
Message-ID: <dc295c30-a695-4dde-b1ab-0871fd576f4e@redhat.com>
Date: Thu, 17 Jul 2025 17:33:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: TDX: Don't report base TDVMCALLs
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "Annapurve, Vishal" <vannapurve@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "seanjc@google.com" <seanjc@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250717022010.677645-1-xiaoyao.li@intel.com>
 <CAGtprH_fNofCjJH1hWKoPwd-wT7QmyXvS7d9xpRNYxBznNUY+w@mail.gmail.com>
 <3d62aeb993d9a81a64985a8354b87ffedd35514e.camel@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <3d62aeb993d9a81a64985a8354b87ffedd35514e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/17/25 17:24, Edgecombe, Rick P wrote:
> On Thu, 2025-07-17 at 05:25 -0700, Vishal Annapurve wrote:
>> On Wed, Jul 16, 2025 at 7:28 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>> index f31ccdeb905b..ea1261ca805f 100644
>>> --- a/arch/x86/kvm/vmx/tdx.c
>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>> @@ -173,7 +173,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
>>>           tdx_clear_unsupported_cpuid(entry);
>>>    }
>>>
>>> -#define TDVMCALLINFO_GET_QUOTE                         BIT(0)
>>>    #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT      BIT(1)
>>
>> I am struggling to find the patch that adds support for
>> TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT. Can you help point out the
>> series that adds this support?
> 
> This was the last version of the series posted:
> https://lore.kernel.org/kvm/20250619180159.187358-1-pbonzini@redhat.com/#t

Yep, I didn't send the patches for SetupEventNotifyInterrupt to the KVM 
mailing list.

I hadn't even noticed until now that I hadn't sent them because, when I 
came back from vacation, I found the matching QEMU patches in my inbox. 
So when git reported them to be in the next pull request I didn't think 
of double checking.  Of course the blame is mine---thanks Xiaoyao for 
writing the QEMU side.

They are:
- commit 28224ef02b56fceee2c161fe2a49a0bb197e44f5
   KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities

- commit 4580dbef5ce0f95a4bd8ac2d007bc4fbf1539332
   KVM: TDX: Exit to userspace for SetupEventNotifyInterrupt

Sorry about that.

Paolo


