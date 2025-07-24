Return-Path: <linux-kernel+bounces-744818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6F1B1113D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEBF1891F02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAB623F41F;
	Thu, 24 Jul 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPH0mY6Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C222066CE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383387; cv=none; b=r80Z0ghO5ChYLybaLERqK83g/HS7bADHZwtfOJmDDOs6I9ScaopuKyeJHMqQ2QHPon0Q9+LtjzBB7b4VBLt2uVK9Uh0jqKGr1E7bhbE1RTk99sD7IDYZKclt+P5jrjQAqgBkfGHHZQTzIrZBk50hL12VY9MfJqEEEF8ND01OnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383387; c=relaxed/simple;
	bh=9lojJqofrOhZnH+VEQ+1Kl/VSqDCPoyu5awFrbdtJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8aq9eL7tKBQW97T2xqTZf0AuMgxUz85G4NYGLHmsCHw0LTNb4qtHEPhbzmE7Kdn/ykcXOweJEF9xn7vblxQdUUfAMMtpI+M1ZlhszQ33x26k41FRyjG26BNrUEGCS3cRRYjjoXS1Ly8ytFMuajrVukj4Y3anVdb73tgzsyKKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPH0mY6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z5RE8ieixVr1FZvK/cEBWikusS31nqX+pPuAGM1SJ/k=;
	b=PPH0mY6YC/r3sSRHuVz58kJuJXhRbcPa7pBw2K13tOzL7TZhrcHu9yrd7HKUKdquAyRjoq
	hhUx6dVQxWEqyVWGP7KVXT1b/X8q73Cdx4T/YQ8FpESx6FkEmTDhtZ8TE7EQO+qSIG2oBJ
	XeE7zDInFJMFlMvKUA8FbqrBkGrv1pc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-EIM2D-1DNQWgr6KJmXOqEw-1; Thu, 24 Jul 2025 14:56:22 -0400
X-MC-Unique: EIM2D-1DNQWgr6KJmXOqEw-1
X-Mimecast-MFC-AGG-ID: EIM2D-1DNQWgr6KJmXOqEw_1753383381
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so4830645e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383381; x=1753988181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5RE8ieixVr1FZvK/cEBWikusS31nqX+pPuAGM1SJ/k=;
        b=KGJEHAt6JUDrQ868vzhEnlZeSU/BwBjQUo9o2puh4a4PuabDKfOHGKrzt9HXExwYnm
         7fu1Xq/t6KWPaLZ6Ow/X0LJzE9BqOm4aK4pp7FaUrJzH2dr9jKjfuDwuxam7ORAVuBzh
         5ukhzeoL1Er6r6w//457xI4ZBX2Yz0rndPE1LWC75HZoxDUEqjOXBP8K/fDeaGxZ8cLu
         jEGrVJe684WUPdHGkThz6AWxRq+vSSrlFvbp4n1J2wB1OkGeHby9ijQkmYEGiP7L4urF
         fFjp1PURi6SV5EGXXCdbcH0FLN4xhwUB8iq8zMML3cYyKbadcETY3D7xQn8O8fwKbQaG
         hfUg==
X-Forwarded-Encrypted: i=1; AJvYcCUFe6GKfHPqHGK9zn6NM0HpaA/U7e8+SRFhA2mzgNU3CzO8NKBUgqg1+nbrODHAEP7tg/GN/XY+Nc2/YgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYHuC/3PMZtd0I0YDrZ0l1ATw9CyiWdBNKoOAMhaW+W5hb2vt
	xvzyrVM5q5KPxzuCBFHHhQDmdGnYL9fB5zwTA+hhRzIyMLw4WlpyqI5dVvegm8kHfi8Qj8waknn
	ig8OtywD7y9ADpmzizTAiEDCelbZXICC4MJa41VwNKlYMyVBjp4wsQqcE6sm0t4QwLw==
X-Gm-Gg: ASbGncvMd6tSmzKV8nScFrd63eEtVaaNrcN26R+3BInGgntRrDXoMITfzuu5CVQagQv
	X8v8dObkWCmF0S/uwh8ceCUVRXAVukwX16pxmrBJtJjYsepmebIqeuDEoI3zNlo2/+WcirC+8+i
	E/2jOs4+KlvX1gM17tTfvZfO4YTF5OlymlKzlcJ4SsnPovlwDSN5uacproVBndxvZOHOKlRD6YP
	WL2CpzxTGm3pqRmaYg+TsRQFTnteulUCvWBL7zLZ3J12Fvyc8D77TrXAsQzQTWBNDfwK/U7GgkP
	0uqtrWVy0IBAp0HMUg9szEj8W9+w+1eiKR0+o3b51c7NmZb8XsmTt1EyTaSYZNufrArKTE90B4j
	9MenlUlOfDtbRCk540qX0ZNDRjPb5Wk5ul3CriErVVipwC+4Up68m0/g5+6ujz8TnEgc=
X-Received: by 2002:a05:600c:811a:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-45868c9d30emr69908185e9.12.1753383381315;
        Thu, 24 Jul 2025 11:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdAyXbzNe22IPRDjuVXzdwdHtPaDK0O9XtZTaXqXhWLNbVy9ZJqhMpYUuuk34Bnx9LVuwZMw==
X-Received: by 2002:a05:600c:811a:b0:456:2142:7fa6 with SMTP id 5b1f17b1804b1-45868c9d30emr69908035e9.12.1753383380769;
        Thu, 24 Jul 2025 11:56:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc60501sm2970578f8f.2.2025.07.24.11.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:56:20 -0700 (PDT)
Message-ID: <ab45d2f2-a34e-4ec7-8a49-03d166e6215a@redhat.com>
Date: Thu, 24 Jul 2025 20:56:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Jeff Xu <jeffxu@chromium.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> To summarize all the discussion points so far:
> 1. It's questionable behavior for madvise to allow destructive
> behavior for read-only anonymous mappings, regardless of mseal state.
 > 2. We could potentially fix point 1 within madvise itself, without> 
involving mseal, as Linus desires.

IIUC: disallow madvise(MADV_DONTNEED) without PROT_WRITE.

I am 99.99999% sure that that would break user case, unfortunately.

> 3. Android userspace uses destructive madvise to free up RAM, but I
> need to take a closer look at the patterns and usage to understand why
> they do that.

I am shocked that you question why they would use MADV_DONTNEED instead 
of ...

 > 4. We could ask applications to switch to non-destructive madvise,> 
like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
> switch the kernel to use non-destructive madvise implicitly for
> destructive madvise in suitable situations.

... MADV_COLD / MADV_PAGEOUT.

I am also shocked that you think asking apps to switch would not make us 
break user space.

> 5. We could investigate more based on vma->anon_vma

Or we do what sealing is supposed to do.

With the hope that this sealing fix here would not break user space.

-- 
Cheers,

David / dhildenb


