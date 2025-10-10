Return-Path: <linux-kernel+bounces-848395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46777BCDA36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34A93B2FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C92F7456;
	Fri, 10 Oct 2025 14:56:44 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E5257848
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108203; cv=none; b=Lva/mU3nFmY390yUOOQQxJlDdEj7g9BwAc3s9BvlPc3olrvw3nRC6EwPmNw7Me75MkPo9kiSwlK6Q4izCnKwCMQotAUUwyTyaWF9kwgfVqQrGIAXVoPPExIqPqs4EnxujalZgzX/bW2kNs0Hh+exHr6je2xKg6kVsKH2okaxWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108203; c=relaxed/simple;
	bh=pxb9zKbKHdW/bAmkeQ4T3IojicrnZ8/PgAXCsc2eDwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xw1MaHnkygtZhPUgFUPuD/YXsTmBENdWyvWDn8M/P0N9WmCerVveP2aVvBODQufypl6nD9QQwOLzckvdL7w+0JS+XfC28HHJQGZFw1Bip0Qzmo0Za6gUQJiDNkJpq43NLii6fukGDlwJcsil+/HYjblqzgk9CPhYBizZxqn0Y5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77615d93276so169300b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108201; x=1760713001;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u14/N400ai00fHVt2vd3J2VDGyko/X+Jvfxoof1W8ko=;
        b=c/lST4ZJzM6E5F+duazxXJ7IKBIyoFXWXs2EhZYy7dzu31T1KOxtLrHNm3fbMA0hUw
         /BRVTum/k2uXeQ3yuM4awlYOZlUZzsMXN/1dsh7SSj2cnUzBPHOfJllEPNLdVX8X/te/
         Axiim85s2riOAAZQDEBdACt3UezM8HvnkfadEOpaUgFK/vnNs0lVZnRDrq1Sk1jZ1rCV
         Vj2coPoQCh9IFamlki7AWwqahlL35ZZyRG9iIyHsB+FODXteLZ1Guh44beiTEeyzXmSQ
         uwTwptVI2eTac+zNLm9q9fNzYitJaQQMi+8krsll81iVmDd7zuxCfwBjpY5n9KQOZerM
         FOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXCSmt3yYYL7bTqLDRvWC2xAkbiOX976kTfFiE7YrhF/Eybb9OQoMbxRYVN1G4wvRAXdas3Qp+D39u5Ve4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlNaHY0BYZomSzHtDvl9gtzlWLnquf9Kzybt8Hpvco5GBhXzPD
	dZttgT6QhjArdVWSdIwXlqbShx2eTc1XbrjXOA9NprInNReWeJX+0Frr
X-Gm-Gg: ASbGncvO+jKUwvCf9TQNdIyjvVyqsv3+/k60HFoVPZ/CpwRFpkIIn2aS17+XKgH/Oew
	Tr1y9o4f5mcuGGbNQHa91mFs6pcS8e4ISpeJVIHUvYTs9RORsiZiVl5YZ1Pvnd1wOqtx27aruHS
	R3UevEIH1/wo3Zh0pVoQcdoan8Em7jlaVf5PO86XeT59nbiNlOVSZXCvyQUTDi42qQUSnuz8HE/
	WLR6zycKt7ydi1M/g3VHws8yZDKWQF++IbfORKFhYf0ky1Pk5tzsun0F0C4QPSAz6Sm/BmoltAo
	7QuZSnM+13BBmIF1WNqHfhpXHRNyuFqWkmJnqdhfHEeNrMdMcognNnGnXmBZ1iVLw+yFb4ef8pd
	WyGhmqy+bwEgb5OhG52SFQXgufB5YjWmTac5w6vsZX6HimA4fVCDrG323KH/mP4XqfzHOhv/EXj
	I4xtXnRo2DmUgsY8FQ+fvszHQUWJMl5mzRdq0S7XtropmUQQ==
X-Google-Smtp-Source: AGHT+IGKWpnWR6YqBmKsSfIMcNBcVWPGcNUFMQXbOJpvBadgaHtn89wm2K6tlg04cMPFDt3oWIIQGA==
X-Received: by 2002:a05:6a00:1250:b0:781:1bf7:8c66 with SMTP id d2e1a72fcca58-79387c1ae19mr7895962b3a.7.1760108201302;
        Fri, 10 Oct 2025 07:56:41 -0700 (PDT)
Received: from [192.168.1.57] ([27.173.241.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b252f23sm3232472b3a.6.2025.10.10.07.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 07:56:40 -0700 (PDT)
Message-ID: <5b5d6f02-3161-4490-9652-e6d23e320a57@kzalloc.com>
Date: Fri, 10 Oct 2025 23:56:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: cpufeature: Don't cpu_enable_mte() when
 KASAN_GENERIC is active
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 James Morse <james.morse@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com
References: <20251008210425.125021-3-ysk@kzalloc.com>
 <CA+fCnZcknrhCOskgLLcTn_-o5jSiQsFni7ihMWuc1Qsd-Pu7gg@mail.gmail.com>
 <d0fc7dd9-d921-4d82-9b70-bedca7056961@kzalloc.com>
 <2b8e3ca5-1645-489c-9d7f-dd13e5fc43ed@kzalloc.com>
 <aOj8KsntbVPRNBKL@willie-the-truck>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <aOj8KsntbVPRNBKL@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Will,

On 10/10/25 9:29 PM, Will Deacon wrote:
> On Thu, Oct 09, 2025 at 08:10:53AM +0900, Yunseong Kim wrote:
>> To summarize my situation, I thought the boot panic issue might be due
>> to incompatibility between MTE and KASAN Generic, so I sent this patch.
>>
>> However, it seems that the problem is related to the call path involving
>> ZERO page. Also, I am curious how it works correctly in other machine.
>>
>> On 10/9/25 7:28 AM, Yunseong Kim wrote:
>>> Hi Andrey,
>>>
>>> On 10/9/25 6:36 AM, Andrey Konovalov wrote:
>>>> On Wed, Oct 8, 2025 at 11:13 PM Yunseong Kim <ysk@kzalloc.com> wrote:
>>>>> [...]
>>>> I do not understand this. Why is Generic KASAN incompatible with MTE?
>>>
>>> My board wouldn't boot on the debian debug kernel, so I enabled
>>> earlycon=pl011,0x40d0000 and checked via the UART console.
>>>
>>>> Running Generic KASAN in the kernel while having MTE enabled (and e.g.
>>>> used in userspace) seems like a valid combination.
>>>
>>> Then it must be caused by something else. Thank you for letting me know.
>>>
>>> It seems to be occurring in the call path as follows:
>>>
>>> cpu_enable_mte()
>>>  -> try_page_mte_tagging(ZERO_PAGE(0))
>>>    -> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
>>>
>>>  https://elixir.bootlin.com/linux/v6.17/source/arch/arm64/include/asm/mte.h#L83
>>
>>  -> page_folio(ZERO_PAGE(0))
>>   -> (struct folio *)_compound_head(ZERO_PAGE(0))
>>
>>  https://elixir.bootlin.com/linux/v6.17/source/include/linux/page-flags.h#L307
> 
> Do you have:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=f620d66af3165838bfa845dcf9f5f9b4089bf508
> 
> ?
> 
> Will

Oh, There was a recent patch! Thanks a lot for letting me know, Will.

The current Debian kernel is based on v6.17, so this patch isn’t applied yet.
I should also let the Debian kernel team people know in advance.

I’ll apply and test it, Thanks again, Will!

Best regards,
Yunseong


