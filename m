Return-Path: <linux-kernel+bounces-747940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982EB13A75
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B81016DB93
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB42264630;
	Mon, 28 Jul 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqNG3IYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269A25178C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705632; cv=none; b=gXVvUZv32AT5t95/T+uND7TBb8xAItiy44ijy/U5LALBPRYBLj8Y48ANpPFbfKPd8NPxmOCwH4g0AuCnCUCAsCq6Z2i96cg5/NlHWLxtm8/LOQuLNcTKJ0vukwF/zY7qKx1MsjVbGVNcCshkJLMEaEa7sjcnqbuIfYk6yV3EB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705632; c=relaxed/simple;
	bh=e5VmTSf9yBtpefrrgOBwugqJ+51j+zLZf0foYFAv4L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aV0Gu9wrvVWYLQxKejjEK3Y4XH8qSnfHbELoAwlwWguiv6WjTK2pMO1moUVW2ceTAb1xjVsuqloBpc7G841KJ8Dk6MvID1oD9I/Nu9UaLcfrC7gA+9etICOTa+SiAtn76tVGIX0DfdjHPdjZ11fXXxUr4yZJMMjYxxW3y1ASee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqNG3IYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753705629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QnQuEJmQQe5QI9lnPew2rtDphQn82+YCCHj3hCzNitw=;
	b=LqNG3IYBCJJc2eneqioPpY8WQFlVqIsnLHrlxe+3CTCUvDOE2fP+02AfVFRLyC4r09JPgF
	SLY87dyOY0ebuKuw3g3gYY7dKFdpVI5KioRp6rklqH4cdHiMlt6R3WbBIc2YgxFfjE3L24
	t/7vwnkxZiVJ5UVehUAGbw02ZJBZi54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-f3xIS5fgNfyOY2lk4P_uNg-1; Mon, 28 Jul 2025 08:27:05 -0400
X-MC-Unique: f3xIS5fgNfyOY2lk4P_uNg-1
X-Mimecast-MFC-AGG-ID: f3xIS5fgNfyOY2lk4P_uNg_1753705624
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4538f375e86so32483835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705624; x=1754310424;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QnQuEJmQQe5QI9lnPew2rtDphQn82+YCCHj3hCzNitw=;
        b=Zp1eormB3lppb+NK4oqQ+OstJvSROyRxB01Trl/nlTaYQsOozvI8kteBmyZtzfvve4
         tnvpMh8k98U/ShwCnsAvCZ4/6iPfMtwDhZ46i4gYyCXUSOFUnfHjEz65C7mTM/CBXM97
         u7BZ62qcoLoseCUBQ54Ls1hr8WCKjW6ckx1EC7VBzs25bqyZy64DeirTikidHffzAfwc
         jmgL4idesmlv9BBc6j4pQXxM9ydaSrduZFSzW+RJV81nKfW19BxXSeLV001cO0XxybhU
         /VgClC4EcXLEGgotfCZhLJv5kAYVJPnaM9q8XYL1+LbbAedcD1N4SGjclXz/EPY3RBLS
         8Vsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjKlDtw/eqcGwaYIshtHZquDk8V4hcjXMFIiekwDOgtIyZDhCepWG0gzmLEcvQirpvrAABJB0iHjoLlhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdgpmG37YVE2cN3fboKyAnM7oeM3/63hatL3Mc5dVeXIGwVBf
	fZfcgavjr5BmCzaCYySYMqONZZBWVj9BuLJ2xNCAZpucinN4kbo7FAVZFL+kZXL/NnX6XljHJQt
	MOKUGN3CVIwM9YFDuOVReYs6mBNDOD0jF+LsoG2ah1mxLYl+ePvRIjBbdDOIEjGySdw==
X-Gm-Gg: ASbGncu5FvFZNpin3+wq82tH2o6MdowLszrIOjtvMgATTX1j5x7D5RSSS+6VOlXGN/g
	LQivgTPDbt0RaKjF10ytvoz30Mzi7DNWZkV5eERRyd6/CM9DKY6g4x58fDA6CoTNqHDQ5FYlC9H
	JzAceHI8JPslHEWul81rbW1+zVcrIzuhn5uBzYcPS0zGPATZ0i9Ky15tIwnZ5a8yfJGS/Fr8Z9U
	AJSXnwmeV54PFs3Dl/H0celKAB+OeJusD8KZWM7LycXL9pRmayZSq8NcDKDCJMYB18hy1vk2Wtf
	0sNhEMjoOYpwokzx+T+PKw0Wm6OPt50O/xj+i2eq9SzLyVF+DMHGPwEiydIZus25OKYj1ZxM4J4
	5iCvP9U9ckP53F7OaR/mmGYnyeP9QZNn5JRWbkTEW4y0KPyjf0hQ9CO3mBSoNV3lnWAI=
X-Received: by 2002:a05:600c:6089:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-4587666c5f8mr77032425e9.33.1753705624334;
        Mon, 28 Jul 2025 05:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6t+wpPuc6znKz8nZXvCG8hSmYbB+9cHwFq6tAmgHTss/ZYl4BlI0qI6FlX6v6tmq3ljU9SA==
X-Received: by 2002:a05:600c:6089:b0:456:1752:2b39 with SMTP id 5b1f17b1804b1-4587666c5f8mr77032195e9.33.1753705623840;
        Mon, 28 Jul 2025 05:27:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586eef77e8sm114032575e9.3.2025.07.28.05.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 05:27:03 -0700 (PDT)
Message-ID: <1f8d924d-3554-43a6-a75e-66a08d1ce7b9@redhat.com>
Date: Mon, 28 Jul 2025 14:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <aIdqVNCY-XMNICng@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIdqVNCY-XMNICng@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 14:17, Michal Hocko wrote:
> On Mon 28-07-25 11:10:44, David Hildenbrand wrote:
>> On 28.07.25 11:04, Michal Hocko wrote:
>>> On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
> [...]
>>>> daxctl wants to online memory itself. We want to keep that memory offline
>>>> from a kernel perspective and let daxctl handle it in this case.
>>>>
>>>> We have that problem in RHEL where we currently require user space to
>>>> disable udev rules so daxctl "can win".
>>>
>>> ... this is the result. Those shouldn't really race. If udev is suppose
>>> to see the device then only in its entirity so regular memory block
>>> based onlining rules shouldn't even see that memory. Or am I completely
>>> missing the picture?
>>
>> We can't break user space, which relies on individual memory blocks.
> 
> We do have userspace which onlines specific memory blocks and we cannot
> break that. But do we have any userspace that wants to online CXL like
> memory (or in general dax like memory) that would need to operate on
> those memory blocks with that kind of granularity?

I'm afraid that ship has sailed.

> 
> In other words what would break if we didn't expose CXL memory through
> memory blocks in sysfs?

I think the whole libdaxctl handling for onlining memory is based on that.

-- 
Cheers,

David / dhildenb


