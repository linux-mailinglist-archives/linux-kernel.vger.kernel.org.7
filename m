Return-Path: <linux-kernel+bounces-806582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE4B498BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C6E3B7FCA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5C31C59B;
	Mon,  8 Sep 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCqx3VLP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061E31C589
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357409; cv=none; b=qQKihknuDdEOSKRmGIUoLr/FFxIQIvSPYZOZhK1WXr9bvGw9WoL4xFoDhf+IqEBKl1YLcCuQep8Z+W4dZ4XQ/G5axELHeIhs8RuXukJAgobmv1BTREi+oH5TzHRoqeWIQr+tl4sMV3sgtMYHkHfDF4Rk+2FHprtFmXcuQ92FvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357409; c=relaxed/simple;
	bh=E7Vj9/23AE8WzpJfHTcwBG4Ng9PhfJNp1DnthXzdKgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0rUbtvNKxvfVKHXub+YhH2xAGub5BwRIkLsjSrl6S45ovVEg3sLEKX/mYlkSfS1d0XilyPVYMGLpeSwskTwm5i/l+PpNDJv7Su8bDGyIAICNyMBi8DhSjvBHWip5qSMoeKeKGavEphw4ZH1ub2o+0JEueGWRMVZDeABm00uRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCqx3VLP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757357406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UUZtrw9Ce3OTyc4thmlH4DQBN7q3kEq/o1AqpiGl1UQ=;
	b=aCqx3VLPM0i+ERJizvv6zGlhR3L1Xhz4WLqT2w21dSi9vKx4im8zwuG1EeeGfOIs+uzbXe
	ysACZYSESLEKvuhIzS9YRM05CEoCN8i7hdAyZoOvn9eEU7znpy4pIeuvq4ZGFd9JqGfMb7
	DJSScW0JWAV9c/ekWRv8XHd436ic42M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-jz4eWUBMPliIa2sR9NO2nQ-1; Mon, 08 Sep 2025 14:50:05 -0400
X-MC-Unique: jz4eWUBMPliIa2sR9NO2nQ-1
X-Mimecast-MFC-AGG-ID: jz4eWUBMPliIa2sR9NO2nQ_1757357404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb612d362so24888825e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357404; x=1757962204;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUZtrw9Ce3OTyc4thmlH4DQBN7q3kEq/o1AqpiGl1UQ=;
        b=Hrmj22YbFh3OCexWKayJlaEVv6ZWEijzLMzSJxb3zog/OMgfW/vNVjX5s3v68CzZEE
         4odJk8scz9hLdpmcpjmsaSGJIAeAQN6zs+84RIffD4FBXUCrgEAVKGbWi04yE+QtRqQa
         +Ynmp5nq5FzkALy8IHUX0pzDpmCZsK+wuVCI7BGHRQq+O+/aQDeoxfsISQyQh6AEHlU0
         pHI+gQEaMmQ7mDCKUtGolMqiwMT++o2/vbAStRPx5s1rjLDn7zsytE9AdF/ZFfLkFjFU
         VQCWb1daZGpAXIWFCKt4pJIXRJB0itmlAWntUf1Ix4wQtSgohbiIytdKwqCR1ydUw9nM
         EcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0AHUYHETVAoFhPYbBbtTm1yBFjVF12rMmXqVGqqhh+lOy4ZCO0eG8EBqbwns9vQy9263pckmGCrnhyOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJGikwb62EaaF9J99PZIpP7nCkYQ8QCSh2qU3fGM+aeRdbXzD
	x6V2VYk+80Jp42YiB5ctPKm4rm1uMVu7MGgw9Ojz+AS4M3+tD7/OIk4i12oqVeAMzo9YFAgJPv2
	2iT2/5O9bTxg2njfCTuXoyZxCnEii6rca/k4GjlEmqA9j0iSXa8lOkW+VWIOMk15Utw==
X-Gm-Gg: ASbGncsk1imbFYeseJAr7xXBQAxL+zmiAwzzqjmPPoI4oR0xLcwDuq6p5viAvsR3D+F
	n0d8YGIKG8KgLpBcWvHKA3DDL77muKqUETpVFTymtbZxMy644SagQWovL8+4Wxz3MCFMztN0f8D
	DqVbpr4NqAMwb4YgSxNLyUpQFjpdbV7vYuDgly8JO3SfHme3TGrorfEtvdV+m5GqwaWVJz/UzbX
	0AeZ8sBBx2heCnDBLhKRckkCHjmQTYKjG6ApSnXn/dne9qQAZkjoOhemSrdmHTK7EBwHqfR90hs
	ITNeJpeUfIZJbGcywzLaFb39abcx1AbN76yLO4ybqtRxZNuzM0LE61d7BrQMxM9wRdk718M5GC7
	LuJNqG7lhjDfH1biZnUJsblA2NGkSH/2SqQ9cWCDCCP4IKbEIyuiEzFRolqITzi23
X-Received: by 2002:a05:600c:3b8b:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-45dddec3b92mr97992635e9.16.1757357403723;
        Mon, 08 Sep 2025 11:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGm/PFvNVvzQhpYmtJ6sQ83PhVXMHxysLrDdewgd4nQchvdGU1VvxC8ioJR+t94JeN3eCthg==
X-Received: by 2002:a05:600c:3b8b:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-45dddec3b92mr97992345e9.16.1757357403298;
        Mon, 08 Sep 2025 11:50:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d92d51982bsm27196227f8f.21.2025.09.08.11.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 11:50:02 -0700 (PDT)
Message-ID: <a0238ff1-3ca2-4f0b-8452-26584b531724@redhat.com>
Date: Mon, 8 Sep 2025 20:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/22] mm/mshare: charge fault handling allocations to
 the mshare owner
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, arnd@arndb.de,
 bp@alien8.de, brauner@kernel.org, bsegall@google.com, corbet@lwn.net,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 ebiederm@xmission.com, hpa@zytor.com, jakub.wartak@mailbox.org,
 jannh@google.com, juri.lelli@redhat.com, khalid@kernel.org,
 liam.howlett@oracle.com, linyongting@bytedance.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, markhemm@googlemail.com,
 maz@kernel.org, mhiramat@kernel.org, mgorman@suse.de, mhocko@suse.com,
 mingo@redhat.com, muchun.song@linux.dev, neilb@suse.de, osalvador@suse.de,
 pcc@google.com, peterz@infradead.org, pfalcato@suse.de, rostedt@goodmis.org,
 rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
 tglx@linutronix.de, vasily.averin@linux.dev, vbabka@suse.cz,
 vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com,
 willy@infradead.org, x86@kernel.org, xhao@linux.alibaba.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250820010415.699353-1-anthony.yznaga@oracle.com>
 <20250820010415.699353-23-anthony.yznaga@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250820010415.699353-23-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 03:04, Anthony Yznaga wrote:
> When handling a fault in an mshare range, redirect charges for page
> tables and other allocations to the mshare owner rather than the
> current task.
> 

That looks rather weird. I would have thought there would be an easy way 
to query the mshare owner for a given mshare mapping, and if the current 
MM corresponds to that owner you know that you are running in the owner 
context.

Of course, we could have a helper like is_mshare_owner(mapping, current) 
or sth like that.


-- 
Cheers

David / dhildenb


