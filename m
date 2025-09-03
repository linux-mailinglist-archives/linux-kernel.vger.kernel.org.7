Return-Path: <linux-kernel+bounces-798265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08183B41B72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D708566A34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0EC2DAFB0;
	Wed,  3 Sep 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOtsSoT3"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0632E8B85
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894360; cv=none; b=sgpWGIlxA0lsRK/w8jlZGttGl3fqTXYLmlBZ/ThD+F9jIIozZiWGRTONJu6wX74N9sUatOTSZp+bcTJf2KR6dBDyBAmB8g0bX5kFx8TjZLRFZyqxGsNgeSpb21zg4mKKOrmdKP1dmMefEt+2jHMF8iDi2lCyk+6E7oGWsnXGmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894360; c=relaxed/simple;
	bh=jXadvS4uDRJN8uPmLG8ZGG0hPQV4DbiIZZFQYQB3f98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pey1/ST5Ba+Mv+W0wU1SKGnvkRf3iSoXOTpbZfbNfwxDZu+lAcNTXp+gXwntbhkQyysUZZ9oO8fE/NaULAmktVoJ8lQXgMPVT09xnVbKvLrxrr0sNw7X3Q2XqtisMp2w/PFxi39li+yt1QDbMCnSqkhE1xEw4jse/zg7Qlzd/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOtsSoT3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3dad6252eacso680206f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756894357; x=1757499157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8uhAjylvoVrHqyo5ZUv42JCVbxiwoWLZQPmGOY7qt0=;
        b=NOtsSoT3DTjEURGSE8mdXYL4gJRqt+aEiZsFlaXeifgmxaJmYMFrLf2oi5GkODO2FI
         eAW/4EHVngDXu/Qm9cSBUWCH1RlNPdQyr3dzbtWHGYilQPEr2CPtXeCa+Kc4m3SGTzq+
         L3ZEtnCCfjP/e43f1eByHD8Ei+Mq7gQJGpq32hGLGFVL+ydizO1u/Ehrfb+UXqZ9xVkh
         qYdeiYeYwx71K2xwjRBwTbi63HCa0zlqwhuYTmlX8GD/O3SY3VvE2iJZh1VTEfxxBYwj
         Jz6puUcHu6jRCXJC+p9AEHUUPCDVPzI6IA2A9XbynzQ5+US3DPolXk6Nhgd2f3NeeD9i
         1vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894357; x=1757499157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8uhAjylvoVrHqyo5ZUv42JCVbxiwoWLZQPmGOY7qt0=;
        b=xJ5infHS/4NV3L7hykMEfrCT58GSYHVrdPwskX9BVlmw8zH2VY0C1vYSvnteiFf64U
         QUVmOjHvsZ7/MRyqbWOtmCgXHFt1QpGZ8fs862AXh3fdicG037k9ukdDQgwEmVxU/QUj
         J5nEy5W59HU8SYaf6U8IwsWlCeLB6RQARXGvgHzzmAJKFjlF1n6EbaUu4u6sS7xMNeQm
         e5LphWSngILmhaQzVAqjOkr3DdpNwnr/a/njPTFpatzKY96htxilCUaYIZT2TT+CohKx
         veVAfqRwYHXedrBOt87vDbC0XPMnOyfYnhdwmq/FxOn1X925XgmcVWpP25uDOvk09rQ1
         mzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+FdtAmCJlrJA6+pWLUug+Uw6Ho85RRoXM7pNUybHPQymhZOAyiVX2BswoMG6OlW4cfswuVeMk+foOWv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hUJxBMLmZlxiZ8lkIW5pi1dzkP5irIHzkBIZ0frC91aLRDOY
	R8V0CnzsIwY45MzyAYFspOZPDSU3PGYpVJ/E9oCGSJjOhLqSIU2627Ik9SZ76Q==
X-Gm-Gg: ASbGncsQvXuyah7oXWrG1jghKw3kSzZbUUyMi419COqJaJm8dNOPqP1+ugPtaM+3+ud
	U5ugJ8Y3IYFyEGYCRTV8Vf85oGqoMEH9Y1+8OaT4lGZlLFkiSceO9WYEw6Nt57EQitlIlaY8GRV
	Jupr/4P1CJWjmYMQQdO2SG+3zmaUa9vMBCgIUG/uJNXOJnZ1fKQjG7YAuHxt6KA0fUlQR7z1QYH
	kaRHNsTPX7o+pjHBTUeeTa4oaqahYrOhoiUd3ADiHWQQVMSk05jgWmhOU7qg07bZFlzeSsZ+/m/
	uLcrBVo4ciLwWgtmaRG8GJZ+ccClPP8MtckZaOj1XmhB0a2sva4sj9FLYEXEau3lo9uAj4dTCBQ
	WggXYiXSaWZ/h4FKMxrI5uFXXZuxMVZZ5VAu2+zBSOmj1hZQ3Nszx1EX0XmpNX2EpX+Ru/5hfRr
	v3yifYBL/dkFRTB0u/dhZKJQHqX8m5
X-Google-Smtp-Source: AGHT+IE3yDc0JkXnbZqFC6e0eSS+b5+7EfRLakK4b6SwX/VLFPhD7NsTncGY5tJmDk2PfOW4gerV8A==
X-Received: by 2002:a05:6000:24c4:b0:3d6:3af4:7cd9 with SMTP id ffacd0b85a97d-3d63af4818emr10067725f8f.12.1756894356454;
        Wed, 03 Sep 2025 03:12:36 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23? ([2a02:6b6f:e759:7e00:1047:5c2a:74d8:1f23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9db4sm23054884f8f.47.2025.09.03.03.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:12:35 -0700 (PDT)
Message-ID: <b0d0ac81-0901-4ef7-a40c-bc3f5022c6d5@gmail.com>
Date: Wed, 3 Sep 2025 11:12:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling before printing
Content-Language: en-GB
To: Yueyang Pan <pyyjason@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, Vishal Moola <vishal.moola@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 kernel-team@meta.com, linux-kernel@vger.kernel.org
References: <cover.1756827906.git.pyyjason@gmail.com>
 <8dc71d31de53afa4c0bb25234807b1e6ead5ba55.1756827906.git.pyyjason@gmail.com>
 <ef1b79ab-15cb-4720-ab05-d77617143a26@suse.cz>
 <aLgLoal9q7Zx7Yto@devbig569.cln6.facebook.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aLgLoal9q7Zx7Yto@devbig569.cln6.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/09/2025 10:34, Yueyang Pan wrote:
> On Wed, Sep 03, 2025 at 11:26:01AM +0200, Vlastimil Babka wrote:
>> On 9/2/25 17:57, Yueyang Pan wrote:
>>> This patch prints the status of the memory allocation profiling
>>> before __show_mem actually prints the detailed allocation info.
>>> This way will let us know the `0B` we saw in allocation info is
>>> because the profiling is disabled or the allocation is actually
>>> 0B.
>>>
>>> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
>>> ---
>>>  mm/show_mem.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/show_mem.c b/mm/show_mem.c
>>> index ecf20a93ea54..51892ce2efc4 100644
>>> --- a/mm/show_mem.c
>>> +++ b/mm/show_mem.c
>>> @@ -427,6 +427,8 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>>>  
>>>  		nr = alloc_tag_top_users(tags, ARRAY_SIZE(tags), false);
>>>  		if (nr) {
>>> +			pr_notice("Memory alloction profiling is turned %s\n",
>>
>> There's a typo "alloction".
> 
> Nice catch. Thanks!
> 
>>
>>> +				mem_alloc_profiling_enabled() ? "on" : "off");
>>>  			pr_notice("Memory allocations:\n");
>>
>> But I think the message would be more obvious if it said e.g.:
>>
>> "Memory allocations (profiling is currently [on/off]):"
> 
> I can change it in the next version. I saw Andrew gave approval. In this case, shall 
> I send v3 or create a new patch?
> 

Send a v3 as a change is needed in both patches.

>>
>>>  			for (i = 0; i < nr; i++) {
>>>  				struct codetag *ct = tags[i].ct;
>>
> 
> Thanks
> Pan


