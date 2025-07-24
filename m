Return-Path: <linux-kernel+bounces-745057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8DB1143E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3E1C26EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8F230BC8;
	Thu, 24 Jul 2025 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doRSaed7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819513D8B1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753397275; cv=none; b=VjFFMlUqiRpPKSJvhVVQISjUMouo2fSzqiqbyKoxVRN3qmekWh6IO6CMx72RF69dnVqPnNS4m13HfVb555jVb8YkHG1qe0J786NPo7rBKNRSOVvPbdBF+BedjsVxL6uL7juRbiRjFbnIrTtLOwJ4+Ql+jR0Wu/xBUM8ookyFqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753397275; c=relaxed/simple;
	bh=coST7oP7CCnHDnN1NYvDUPUNXc2AbqN5TL5n1+QjEhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7El6vW0TEcKJlHck2dusJyATxuE4qCD4C9JX0lwszjRdi4v18mKib4YXjPjNMo3kxnLQBVG1U/NBnoQ6NJI9f3Uv9TUPS+mb72AvvEu+nl8AELrJQAuz7gsu+iAddAvBceRCoMzyUXYYpp9Xk0q19Kw6gYNDN1+6IvMBNtrOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doRSaed7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753397272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jmr4Kzq+/XTnys2IA+krHPH44Ad/z5rXdCAAEVWap8U=;
	b=doRSaed7itYuhlZe2XVF6B7RQBc8NMoMVBn7IlIpShALqCsUcAUMSchdv0CPMVXJ07YAEo
	w+g2Z/GSACjqBQn0OyA/1Jjh7pHBx9jafgYm97mpNtkVsx61p/s7TnNwIyoL2QMdSh7xle
	Kgyjqhz3kAKLWnAVdieV7yB8hnG6qDc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-IIOFzcuaOUCP7JDwRRcdmg-1; Thu, 24 Jul 2025 18:47:51 -0400
X-MC-Unique: IIOFzcuaOUCP7JDwRRcdmg-1
X-Mimecast-MFC-AGG-ID: IIOFzcuaOUCP7JDwRRcdmg_1753397270
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so7018705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753397270; x=1754002070;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmr4Kzq+/XTnys2IA+krHPH44Ad/z5rXdCAAEVWap8U=;
        b=a9KCpVAgLUj2/6Aiim+aVupXPQaLsPSuYLFwvA5//oJTWy56UyF5Ns38j7wwSsMZP8
         FbZeu0DCJPlquDjjk4gS/AyIV9lB5Ow63yhkoYNrTbgxyclz2NYwasiVmtgvIqzJuRN8
         0IsJfO9T813aKoZuW2kwC23inn1eEiyswvsJwe7IKfqIufcxZ2KPM1mY6enzSgbU8QzD
         X2QlPTKG6NutV6o42q8f84qN28oJINij3TgwoV1NbW7ZbBkZHuhvlFCTQO29O/mr89Zs
         BJrDcmOAZzYrbYOS0NdGn3iRWSuL5jKf15Qpeedj0xGc3kGHAIyzxZxxN4i+5uplZDsl
         JD2A==
X-Forwarded-Encrypted: i=1; AJvYcCWlCjucCj7KVLSJ2b10g14bjooFXzbyZCvSxdKqAGukJrWB4Aw0h5gApjwNdCjyX2OTEavxl/l+6fyQakw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ovBbgj1YwIIBY139VDEphwF31+m71DdphVdcdXHfMJ6MdTXw
	5ddnTQE/XJWbIWN1MpWyxeavv0/veRRvhQlhXibDUPGVUJwO7s9lObzasZ9cw6nhbMevemC5pVC
	mHBtSw94KDFngokgWYgSFCpDEJ79Jaiv2j5gl4KYIJno0xDwOQtpHggXj1mXwCaXXgw==
X-Gm-Gg: ASbGncvh6NHeu9SX0fH8BpkylwzaHBou+Z5hiGZhh9AsOzfXbdCE8SnWjVJG+Ah2D4b
	ylNTTSohFQGA2JyyYwJlVPMGcpcEjrCzz7ev86nAM8wi23PRONX2qn7kRVF7u7xm9NHrzxyKoFJ
	4coIr1hKyG6Z3jdhlSrobiD55YmP+uWo4Bf4mcrCd6T80XH6XRdCxOeFvl6xcXGTyy+vlaFpuTV
	BiW0A7zxkO/r0y2WaGLzklo9TR2uJ2Wkb8OnJRt82+hu7+xwmnGNNUAibBbrjIyUB/SnDrdTVKf
	Y4BDqweCWz650/eg7nADfDjOPy4YI9NxOYJ2omPgv/wpFeOU2z4A4uLTcMVgR03AgztHwKc=
X-Received: by 2002:a05:600c:1d1f:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-45868b33a97mr83521955e9.0.1753397269742;
        Thu, 24 Jul 2025 15:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWL7IGjqrlox7wHaHE7riRq39AcTrIZ/Xgb8bCcHSYeD3u5LC8WQCJ8+W8XUy/PQJ5HU+/9Q==
X-Received: by 2002:a05:600c:1d1f:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-45868b33a97mr83521815e9.0.1753397269239;
        Thu, 24 Jul 2025 15:47:49 -0700 (PDT)
Received: from [192.168.3.141] (p57a1acc3.dip0.t-ipconnect.de. [87.161.172.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad291sm3266302f8f.50.2025.07.24.15.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:47:48 -0700 (PDT)
Message-ID: <28bf0b31-8b51-4acd-ae09-890a952501f4@redhat.com>
Date: Fri, 25 Jul 2025 00:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
 <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
 <ef111032-e108-4771-9202-b8cdab278422@redhat.com>
 <202507241528.A73E1178@keescook>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <202507241528.A73E1178@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 00:29, Kees Cook wrote:
> On Thu, Jul 24, 2025 at 11:41:04PM +0200, David Hildenbrand wrote:
>> On 24.07.25 23:32, David Hildenbrand wrote:
>>>> As an aside, why should discard work in this case even without step 4?
>>>> Wouldn't setting "read-only" imply you don't want the memory to change
>>>> out from under you? I guess I'm not clear on the semantics: how do memory
>>>> protection bits map to madvise actions like this?
>>>
>>> They generally don't affect MADV_DONTNEED behavior. The only documented
>>> (man page) reason for EPERM in the man page is related to MADV_HWPOISON.
>>>
>>
>> (Exception: MADV_POPULATE_READ/MADV_POPULATE_WRITE requires corresponding
>> permissions)
> 
> Shouldn't an MADV action that changes memory contents require the W bit
> though?

In a MAP_RPIVATE file mapping, to know whether you are actually 
modifying memory ("discarding pages" ...) would require checking the 
actually mapped pages (mixture of anon and !anon folios). Only zapping 
anon folios is the problematic bit, really.

It could be implemented (e.g., fail halfway through while actually 
walking the page tables and zap).

But, yeah ...

> I mean, I assume the ship may have sailed on this, but it feels
> mismatched to me.

... I think that is that case, unfortunately.

I remember that userfaultfd can do some really nasty stuff with 
UFFDIO_COPY and MADV_DONTNEED on memory areas that don't have write 
permissions ... or even read permissions. Not sure if CRIU or other use 
cases depend on that in some weird way.

-- 
Cheers,

David / dhildenb


