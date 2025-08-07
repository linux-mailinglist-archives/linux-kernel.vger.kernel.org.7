Return-Path: <linux-kernel+bounces-759410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ADFB1DD31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2233721BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7C219A7A;
	Thu,  7 Aug 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YR7JxWEy"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D271D7E26
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754592052; cv=none; b=RmXk/KxTYFrvPLB88SpHO/Kg5GhVgPmjpqew+OiCfr5IAblaj3HG+QimwtlsgfOVZTIwep8hjxLp0sDRxQbDXaRF4zXg7BXYm0pofLClpA8p8QElUvyOYazjc14pMEgLaIsTyJPJvbuBwv0FZgh65553XV6M0l8QsydtDMGP040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754592052; c=relaxed/simple;
	bh=i3aP6A/MxuAB3Zt7C+xzxPLkUUuAStt1/hot+djOP8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX5EhahIshrkK1/mI6SoG17dgLgbpPZh+k+zep/lNTQfbqHGaoc5C5oMYhc3bAw7nJMA6lZ2hqFzL55Pfj8F9td3kVM2VVYNLsHHlFlMJsgclgcH80GyTK4zFVGa1/idX04BJBLsjwzkARHzD6++W01L7ibWNWpL8DJ9Kv7Z0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YR7JxWEy; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e40ac40940so6016635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754592049; x=1755196849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XERiuoNAWPSGK7EG1EKcaSMoPUBK2/kua/o26DD/qk4=;
        b=YR7JxWEy1FbbD2lJIAfRulKLjaT90Lb4ClG3h4D8XA60hhq6jHiPDCceB0ndcFfAuT
         JbF8YiWpbavSbfFzscHQn7tURqjKNrBNzs3i7JwMpLGWHBYBA0bQGlRVOyFsGhpOZXZm
         QNa6A83NJYWS6RjjgJZnUh+yzzcvNeHtVrLXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754592049; x=1755196849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XERiuoNAWPSGK7EG1EKcaSMoPUBK2/kua/o26DD/qk4=;
        b=gzHHcKW2kjhNhttCOSh+YrhwovUXJHjw37lR7U1tT4Kd9NHhzVJBDJfFKujYpWtJch
         HI8Qo2vFYpD/dBW5xcT6YEDbHA8NSKsnqucZDxUpn9FPP6qt0f1QqEWpCUJ7KGC4ZQgw
         2lPBOk2nMo7XYbDFqKiSM0amnQ9jEv9IrRXOjbhGkN6eqBAPweOI0fRkZHGmUeFKf0yc
         eMQs8uuA6QLOO3TC8la4Nt+z20qkbnT21y/R0l+yAnHdgtR/ihvUAAJZEuOJmQ5D/dEs
         yWYcFyxekw5+fhb+6W2SJ6jwxugNHqWYNBm0TzpzaghwWJBeCosUneqVLhvuSc/KjJbx
         gDNg==
X-Forwarded-Encrypted: i=1; AJvYcCXs/k3jw7nRzMWcinYHobe01Ztk+c7AlpITDZqh9XgRZJtcaE6B7hbiRLXS9wUQ63hZtkq+J9cwQV22j0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwowV4BqS7Nmrk0/v/l3uTDqnWoQlJ67bmLlWHjvyBE4rbe6Ah7
	Iu0RM3DeIWd55k39l8gJU9L/A5/X61H/eiFl/aOGj5m6ARg3MgDh9qyJno4tL+9OUFsbZ21PQDJ
	bSMg5
X-Gm-Gg: ASbGncv4wSwijEohux2AC0EHZWr5PdO6vzIuYSaZ2fRgW+1uDQPHZXvPZNIZtVCCpCF
	P6M1BQnVmh/Y0DK9CaPbze+1O6PQX2dqis1Ox3TnQovZdzVyQhA4UzWPkExfChlYZq6QNmcbsNy
	xZhLy/9ZoRu6AP0JCybgDHBa25yUPP20OxisVJfE+FSrv3mHHmRSkQfamLd9jbtuG+18jnjqcmf
	AjfUYrlXHsey9I+HTu17gGZfHx6J7C4DXTBtNp1Oj0Qj9rHy7UsnyyrPeYn/IcazFmi7s8Qny24
	bo/9pP7jMVpkRKS5795IS559jWjr1NWEsFLOC7xqESdolAuZAO2jukCzajNT3K4P5xMNkqzzeRX
	utEjXgXOyzn4/6czIScX2ZZ9jIT9X08y4AQ==
X-Google-Smtp-Source: AGHT+IEoPUIs8QXxDDX65uueSQcuOznUJ1A7kJhXS34684tBvm94g8joM6RL35rGIzOjEg7hyzRFAQ==
X-Received: by 2002:a05:6e02:198e:b0:3e2:c5ff:382 with SMTP id e9e14a558f8ab-3e5249ab86bmr68723065ab.5.1754592049349;
        Thu, 07 Aug 2025 11:40:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402acacf1sm73867425ab.39.2025.08.07.11.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 11:40:48 -0700 (PDT)
Message-ID: <b2430686-3da9-4fb9-8f91-5bb7da1920b0@linuxfoundation.org>
Date: Thu, 7 Aug 2025 12:40:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: uvcvideo: Log driver load in uvc_probe function
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc: Imene Jaziri <imenjazirii18@gmail.com>, linux-media@vger.kernel.org,
 hansg@kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250801145326.28560-1-imenjazirii18@gmail.com>
 <20250801150430.GC4906@pendragon.ideasonboard.com>
 <452a1263-2ec3-4174-9082-078445e67637@foss.st.com>
 <20250807081408.GB11583@pendragon.ideasonboard.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250807081408.GB11583@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 02:14, Laurent Pinchart wrote:
> Hi Benjamin,
> 
> (CC'ing Shuah)
> 
> On Thu, Aug 07, 2025 at 09:53:41AM +0200, Benjamin Mugnier wrote:
>> On 8/1/25 17:04, Laurent Pinchart wrote:
>>> On Fri, Aug 01, 2025 at 03:53:26PM +0100, Imene Jaziri wrote:
>>>> Add a pr_info() in the uvc_probe function to trace when the
>>>> uvcvideo driver is loaded. This is for learning purposes.
>>>
>>> What part of the learning instructions you are following instructed you
>>> to submit this patch to kernel mailing lists ? We are regularly spammed
>>> by similar patches, which indicates the instructions are not clear
>>> enough.
>>>
>>
>> I got curious too. It comes from the Linux Foundation training LFD103
>> [1]. Chapter 8 describes this patch pretty much, and chapter 9 describes
>> how to send the patch, but with a warning not to do so :
>>
>>    [...]
>>    At this time, you can run:
>>
>>    git format-patch -1 <commit ID> --to=maintainer1 --to=maintainer2
>> --cc=maillist1 --cc=maillist2
>>
>>    This will generate a patch.
>>
>>    Important Note:
>>    Please note that this is just an example. Don’t send this patch upstream.
>>
>>    You can revert this commit now.
>>
>>    Please refer to the Select the recipients for your patch section in
>> the Submitting patches: the essential guide to getting your code into
>> the kernel document.
>>
>>    When you have your own patch ready for submittal, you can follow this
>> example process to generate the patch and send it upstream using the
>> following command:
>>
>>    git send-email <patch_file>
>>    [...]
> 
> Imene provided me with that information in private.
> 
>> Looking at it I guess it's pretty easy to miss the note.
> 
> Yes, reading the text, I really can't blame the people training the
> course for missing it. It's a bit like if a mushroom foraging book said
> 
> - go pick those red mushrooms with white dots on the cap in the forest
> - cut them in pieces, pan-fry them with butter
> - add a couple of eggs, salt and pepper to make an omelette
> - the dish is ready ! enjoy your meal !
> - you won't be eating that, it's poisonous. throw it away
> 
> :-)
> 
>> Maybe
>> requesting to add '--dry-run' to the git send-email command could be a
>> simple fix to prevent from copy/pasting ?

No question that the material is confusing. The material is in
a publicly available fee course.

> 
> I've contacted Shuah, who told me she updated the training material.
> Hopefully we'll soon stop getting such patches.

It is fixed now and the spam should stop. This course has been in
use for 6 years, this is the first time we are seeing spam.

Sorry for the oversight that resulted in spam.

thanks,
-- Shuah

