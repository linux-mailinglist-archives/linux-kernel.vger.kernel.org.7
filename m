Return-Path: <linux-kernel+bounces-755111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF22B1A16A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF83B330A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE052580FB;
	Mon,  4 Aug 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlVoQuAs"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9C258CC4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310564; cv=none; b=s6VXeH8jUbk9Kql6mc7LNs2qzFnzAMPpWYrCxO/NAyYU50X2FKMqCnoKGRdUrXszip7QSJRyM07LomNB9FBVRr97ApNKySE2KLOgs0Z8BZC1e8vCga+3d3DxKagV2lg5HtwhhsW4e1pCNRarBzJFYvcGi2YRUhSnuJyD/Icxmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310564; c=relaxed/simple;
	bh=U9cIk5nNOFMjn3FiFMd3fKsKPPWOiLNS76Io6aFJNBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=davoKJ7iyhD12YKonbFqVw5OMGwHGgOutorLaV+fEo8z6xOFjb/5O1FgsqddQVhE5wkExFqxfn+K574aducPPhgIhfnRePVSx7Us/GVzMY6tOyV3kV/1riF9mJ2EDUVVokWw3rmmJVU22bGeHJ0BxGEQVrtToQk6DDJAambb7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vlVoQuAs; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-af93c3bac8fso408362066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754310561; x=1754915361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bh2VbEr4+GPS+zCP6PyGLcsH4RZmjBkc+JIVLTQNkVU=;
        b=vlVoQuAsD4eWwVR59xX98IhiaftMxzstKUi+ZO5aVLoZkM+qSu28A+UNKGnj7jWK3A
         680Gc/kXxG76MSmYRjvP43pbRcaIsCaJZjTJzj1e8Clu1J8XkFKfsgVN23cv20oVXuCb
         W94XdGoBc8I5x7eIQk4Ik/nREcRRS+E8+sEX9BbP1mZYalfSKs3svWp3qIYaRKR6xaDa
         oKv5oEc5+OEsdU/bmoAw4QoH6gBC9a9t9vuTHRUtCYw69T0+bKYGSVreXwv+ri9+qIbD
         3QdhpEzlNjLG1eFJg72CKMVGly187TGial8+G8OOZcmae12v4443afAEXLl/eoJi3gbD
         XEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310561; x=1754915361;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh2VbEr4+GPS+zCP6PyGLcsH4RZmjBkc+JIVLTQNkVU=;
        b=lvAq5pJ9Y3euFckA9GmORHr6CQsheSxqNL88d4dtsfuF4dqNih7+oE1GH9WEul+Xyy
         iPXz/QddEewkQZg7S+jyV+ijsV1xHTq4lIMjJhDmJHljXKQ5jIYM0YQybZiezz+gXNHx
         3sfOcAl1zOmkdYF7nr8l2kEeSRzJAyPyJHOMS6g0wnNfTEIfjfPX+UUUxlI+X8UTGnD7
         wXo1i92Qur+OO5XuNCIaxXNe6JPHHPHZSR5W1u71UU4cSVZ65vXRSKy/VwLC6EPA0ENM
         N726l1IFYgeEH230gAex1GkIjU6GMGHvt5hr6gu4Z9Tku1SPXwFexu2JJtaOJ5QSEly8
         M8qw==
X-Gm-Message-State: AOJu0YyXEJuYZsK01Vgo9nY5FwBxyY73GLC1MwBA0c8EcPd+LVuyQ8/k
	D1+EvmYKhOg05GqfLp75uDleOdgZ3M37X1+fxK6HrhFzghngCfB3OtTTZogYpDN9JN0=
X-Gm-Gg: ASbGncsS16r/WtouAECMkuapHSOfz/6DuN7z52MVcUIyabVMb/b+tTo6shr30MB5McZ
	sQeXEP2mojTUOyfM8B8iMUD5ipq9pD+YYW2gaKDTOMLnMYGH8U5VrhFXFmDqdCX6JNy7Y4X9lz+
	sRlr/BTVVcCctTNF6nOEo6Hy9XBwJvvZuy92rjzZpHDFAZSa3a7rQnwKhy16k9vEI1JAMRfqkhW
	YZO63fyDXc/Nu2dudZkku+lhvUeO7bMI27RpcgHfZc0RKzJIoT2tf5+NPo87Yjl3msKc5nURFIF
	0EdIiCuI4WQlelpec5kzrhpgu6Udl5z7qEd77E9Md6Ui2VRfEYFsAYl+hq2wu+ZvvoNZXRE6Cm/
	D/ZWuuT2ZhF+DCylbWBBg3WVwBw0e+Q==
X-Google-Smtp-Source: AGHT+IEosZgeKp1ejcWL+SBts1B/aCmksQ8kDwupILaEdVqhNGaIFVMrjj1IxUFnhsLruybLH3boPw==
X-Received: by 2002:a17:906:298c:b0:af9:68d5:118d with SMTP id a640c23a62f3a-af968d534d9mr304131066b.58.1754310560610;
        Mon, 04 Aug 2025 05:29:20 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a38aasm730599066b.37.2025.08.04.05.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:29:20 -0700 (PDT)
Message-ID: <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
Date: Mon, 4 Aug 2025 15:29:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 15:18, David Hildenbrand wrote:
> On 04.08.25 13:06, Eugen Hristev wrote:
>>
>>
>> On 8/4/25 13:54, Michal Hocko wrote:
>>> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>>>> On 30.07.25 15:57, Eugen Hristev wrote:
>>> [...]
>>>>> Yes, registering after is also an option. Initially this is how I
>>>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>>>> here:
>>>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>>>> Do you think we can continue that discussion , or maybe start it here ?
>>>>
>>>> Yeah, I don't like that, but I can see how we ended up here.
>>>>
>>>> I also don't quite like the idea that we must encode here what to include in
>>>> a dump and what not ...
>>>>
>>>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>>>> where we e.g., have
>>>>
>>>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>>>
>>>> Could we similar have some place where we construct what to dump similarly,
>>>> just not using the current values, but the memory ranges?
>>>
>>> All those symbols are part of kallsyms, right? Can we just use kallsyms
>>> infrastructure and a list of symbols to get what we need from there?
>>>
>>> In other words the list of symbols to be completely external to the code
>>> that is defining them?
>>
>> Some static symbols are indeed part of kallsyms. But some symbols are
>> not exported, for example patch 20/29, where printk related symbols are
>> not to be exported. Another example is with static variables, like in
>> patch 17/29 , not exported as symbols, but required for the dump.
>> Dynamic memory regions are not have to also be considered, have a look
>> for example at patch 23/29 , where dynamically allocated memory needs to
>> be registered.
>>
>> Do you think that I should move all kallsyms related symbols annotation
>> into a separate place and keep it for the static/dynamic regions in place ?
> 
> If you want to use a symbol from kmemdump, then make that symbol 
> available to kmemdump.

That's what I am doing, registering symbols with kmemdump.
Maybe I do not understand what you mean, do you have any suggestion for
the static variables case (symbols not exported) ?

> 
> IOW, if we were to rip out kmemdump tomorrow, we wouldn't have to touch 
> any non-kmemdump-specific files.
> 


