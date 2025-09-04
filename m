Return-Path: <linux-kernel+bounces-800027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D72B4329B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2D581DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64A275B19;
	Thu,  4 Sep 2025 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J89SEm81"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F827586E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967936; cv=none; b=So2ryg9xoPX1+qcab6PPen2b94x7sy8kraUYH0nCtMqX0sfVDMi2Z5hgDgSvH06yPD071bOq0HQ+1dwo5TvUfAG6d1x4f0MbXu6hLC9ua4AZ2RQw/v2ZNtNC3qbNmnVigMR27bPzRzbxbR2cdfs9fz+CIqDyXOC6GVeBx50pWuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967936; c=relaxed/simple;
	bh=qeTziZtgFXm3WYZl/0sCagAmSNghhyaCMHQxGHGNtPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tppdFNhGZ35S8pbjivEQveoRpzqm7JMuYjERC+4fIQwnljlqHGL0UhkShaTQaoWxkjWtSckvdj+1l19eDdsgHJ/lWO643+dtdBgDebqH/xfADeuvCDmsT96D+PjnAdppI+SrIaDJHZAowOZyHdLrBdvC+5R9JeTsDOgQ6aZrTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J89SEm81; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756967933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=40Z8U8FYm63hOytZFsIyiHCS34GyMGG+MWJKFpyeOIM=;
	b=J89SEm81VCd8jw7gAjeAUfHokGfemdMea3cH7DD/lsQgJd5/5ArypA5QWfFlXZKsI4Y+Us
	epB/6KpDIUPu4Ii/VyG61LitZzEq0jD2hi3TIfZtxGv/ND6anN0Felm1BJleKxCs85/6oJ
	AJ1Y18skymIrB5qxL1R4OgV6Mb1n1Ak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-TgM9pTm6O1-6uzidu7fUqw-1; Thu, 04 Sep 2025 02:38:52 -0400
X-MC-Unique: TgM9pTm6O1-6uzidu7fUqw-1
X-Mimecast-MFC-AGG-ID: TgM9pTm6O1-6uzidu7fUqw_1756967931
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b467f5173so4905515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967931; x=1757572731;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40Z8U8FYm63hOytZFsIyiHCS34GyMGG+MWJKFpyeOIM=;
        b=W8KdjR9cbKECyuY7bBU0xTf7gMXZWT5RTdmCey+oNw/OCpW9UV5SJz5CAuDuSz9spn
         //2S8qcacqLwWrNs4G+BkacpHz+kYKhr7Izl4Jzk1SDDdri56Ghl6Ytz6d2qI/jVS5Do
         yhu/bN8LYq2T7fRY2fzhz3iJ7wnA0zVgIvG08VGXf+BOINn5w9oU1lUEn0GK9OPTZMS9
         fZbQOZiZI4847m8PQf5tLLk8YUol+uAcan1ZbE3gBs8O0lRxLfzzUKaPCFUUxe1xrBp7
         AT1VFDGLczQrCc/lKYS7u9soDEOI6v8SoSAVAJoc6SlrBUNOJpuERUq1nIP3HGmkv4tq
         8/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXhL13p5ezM3ZajBKbpAvNkVelir2Qpx7dbvTXhqMWjn8JLk+zX/cMQyUG+UjSKxPmYlJWu2OGDuoi8teg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqAybrkuaHoVXNuo5MXzl4M9lDOoaB4BlN3XY9LKFKotqW3GC
	5oFDB+VyPd+veP5x4PCaQIZEsFK3e8uznHzq/coUcwBJcHIiGaQxLu8TpZ/cyiXOPbi5fXop0QF
	ojpBsCgn17vw11R0jIoNni5JxjqTtgaWHptckHzTSHyTCO6T997FQQeaH4XPnOcjruA==
X-Gm-Gg: ASbGncs4SF1LWpJuL+Xmw3UosZOUI8LTiSZfMpBO6U6d3WvQZ8asv2W27s05aLwz/Ou
	FaPLANZ3/vk/gzLquPbfobSbpR32QCb0Zt0UE5UN8x9EVIKFZsw8b9UH3En3sOt+qHFwI6gH8Ft
	8nlKhzCvYMD4zzIvHahlEVFvStYmb4+YVcwbxXexsq6/cscAXGZu3LnKNdUj+Bcwkd/uLnd05dg
	y7Bo1VgWxcrzJhQ35AA7h5qNpAMJ2IZszUVjNHxmemhwNEbEhwZ+ZSih3xz6Y+JH5gil7/fTJoS
	o/1AMUK9n1qqF+kaij3dNxox5MfmSa+HUFi4AAc+0mk0NScwRQ/wW36t/2TeEUaeUJjz1/iiZc8
	Y4fjTYDqyaWo2bEbY2kNcnONRCDfQoRUGxhdYRYJM+eEmXE1Lu5M8yOzxr0FxFJX+
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c4 with SMTP id 5b1f17b1804b1-45b88321ca0mr137720225e9.33.1756967931110;
        Wed, 03 Sep 2025 23:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4fbUuLgTZZ7JLLGMEzoqz2HZIPqkmpwKL8Svwx4GbQWyjvTjQ1L7Otc3gHyD/LyUPfk7JPQ==
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c4 with SMTP id 5b1f17b1804b1-45b88321ca0mr137719985e9.33.1756967930648;
        Wed, 03 Sep 2025 23:38:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm106759595e9.21.2025.09.03.23.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:38:50 -0700 (PDT)
Message-ID: <92bfeeed-41b4-47f1-894d-ad003b4714b6@redhat.com>
Date: Thu, 4 Sep 2025 08:38:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
 <f41383c3-913a-489a-82e6-d2c8d5519eed@redhat.com> <aLdOLQLjt-A1DBGi@fedora>
 <b0ed22cd-ebf9-41f7-b5fb-6fb078db593e@redhat.com> <aLiFK8sIgbfiK-v2@fedora>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLiFK8sIgbfiK-v2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 20:12, Vishal Moola (Oracle) wrote:
> On Wed, Sep 03, 2025 at 09:46:44AM +0200, David Hildenbrand wrote:
>> On 02.09.25 22:06, Vishal Moola (Oracle) wrote:
>>> On Tue, Sep 02, 2025 at 08:23:06PM +0200, David Hildenbrand wrote:
>>>> On 02.09.25 19:59, Vishal Moola (Oracle) wrote:
>>>>> Commit 4ef905bda61f ("mm: tag kernel stack pages") began marking pages
>>>>> that were being used for the kernel stack.
>>>>>
>>>>> There are 3 cases where kernel pages are allocated for kernel stacks:
>>>>> CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
>>>>> These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
>>>>> respectively.
>>>>>
>>>>> In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
>>>>> than 0, and pages are tagged as expected. In the third case,
>>>>> THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
>>>>> This meant that in those configs, the stack tagging was a no-op, and led
>>>>> to smatch build warnings.
>>>>>
>>>>> We definitely have at least 1 page we want tagged at this point, so fix
>>>>> it by using a do {} while loop instead of a for loop.
>>>>>
>>>>> Fixes: 4ef905bda61f ("mm: tag kernel stack pages")
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>>> Closes: https://lore.kernel.org/r/202508300929.TrRovUMu-lkp@intel.com/
>>>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>>>> ---
>>>>
>>>> You sent the patch on August 20 and I replied on August 21.
>>>>
>>>> I did not receive any reply so far.
>>>
>>> Ah sorry, I didn't mean to miss your reply.
>>>
>>> I can't find your reply in my inboxes so I definitely missed it somehow.
>>> I'll go find it and respond.
>>
>> I had a mail server config issue on one day last month (sending @redhat.com
>> through kernel.org :) ), let me check if that was on that problematic day
>> and it might have went straight into your spam folder due to dkim mismatch.
>>
>> So the mailing list did not reject it:
>>
>> https://lore.kernel.org/all/96148baf-f008-449b-988b-ea4f07d18528@redhat.com/
>>
>> And yes, indeed, it was on that problemtic day, and there is:
>>
>> 	Received: from smtp.kernel.org
>>
>> So, problem on my side. Willy already replied, but let me resend that mail.
>>
>>>
>>>> And now I realize that this patch is not upstream yet and the commit id not
>>>> stable. So the Fixes/Closes etc. do not really apply.
>>>
>>> Gotcha.
>>
>> If there are bigger changes it usually makes sense to send a v2, or a simple
>> fixup as reply to the original patch (I prefer as inline reply).
> 
> Ok I'll keep that in mind for the future :). My mail client loves
> attaching the fixup patches as additional files, but I'll find a workflow
> for inlining them.

Oh, I really just format-patch, gedit to then copy and paste.

Just be careful if your mail client wraps at 80 chars as default. I have 
Thunderbird plugin where I can easily toggle that (Toggle Line Wrap).

-- 
Cheers

David / dhildenb


