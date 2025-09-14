Return-Path: <linux-kernel+bounces-815439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EDB5647B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 05:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91574E071B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EE2580F9;
	Sun, 14 Sep 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXNev6lY"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF61EEBD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819923; cv=none; b=MWf7H1seu4bWWZ0deKCFhYt2bEumI1ZtNNFY9Qd9ThTae0ptKu88GnMCfhNh6Wl6m3vOFkkVP0FL7pvfOFJBE4bMZ9idP5EKvTYgWM3y5vq0El7Qq1P3WESjtrtJH3DQNJrKBIf7ipyPdblTseA7DBCtGfW+3gqFLIKVbfNBCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819923; c=relaxed/simple;
	bh=fX1ndpBU4fvAGj/TiKrzNZpJkrSsqxx3jRXmpXIcYAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZoAZVuwjjCEFsF6soedBVywOfNlLlPu+b/kOzedVk/czHoACtxzcd6N++kviPMmPrcyzMooHbWOx+pMQnhm+vsMK7+Rfoudq2WwxD4vozCBvKmMRJSAcRHjGyhkA/7LXkgEXT8fMUOI/iQrr7TcpRZW46xDnteh1pswB1kh9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXNev6lY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b522fd4d855so2387786a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757819921; x=1758424721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FArxBasW3WnGtC8Io4ujTCS0qc12lP7qP5YZiH908s=;
        b=eXNev6lYyexAIkuxgDgFEaq//780eHlZah5VX6umx5/zH9keWfSU/T4+6cVWyE6Jbb
         jcNtFU0ZsifU2cLVFyABYJX0cB7wdlyGU+d5wAa3UCPvJ9LecIqEp97X8/sVho4+lU3M
         ef8GOAlnXuGVBflYXtmM+NgYudg/ELegNaVHqOoEZRc8ukr0Xk1WYahB2bmHbcAhjOQW
         sVagirVy94GwgspwdLwZMA2FSSpDSogiHptVwUW0apn0dYOaYpWWoe1mHfvqktdaRiw6
         FQIWet+GjAF1nt+feV+cXo9xhlrqkhGsqZieuuvYxCPRw9DMS24Mvf1b76YeIOGVAldx
         y0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757819921; x=1758424721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FArxBasW3WnGtC8Io4ujTCS0qc12lP7qP5YZiH908s=;
        b=fr5IWy38N5LSd2UcPwJxe/I1mVf7i4G7mk7GMwV6IAbteXkWLSY58mGkSa0INaBxyt
         6lojriUM1eyJwb/XFBaQXoEw2leIEN7MbxIknPJOJxkbqElaezqX4KiU6KD8w3HZhPRO
         bB3/Pf0OL3/BB3Cx4iHRN+WssRVS5mBTLAPOg6Vu/J9uOeyPh719YYjMnveMsxGI4q4J
         /HpYd9RHgD6e/johVlF6ZYLtq38xJhxrInPRnTkXl0OP+RYjpCG8Xj0dvt30lioYBext
         Bh6GvVhhIXHF55pn6DHdAI/ucpaRsnERdFpdSUPZgynqD+2a1OtLbMWt2fXKn6plmxGX
         Lkqw==
X-Forwarded-Encrypted: i=1; AJvYcCXn4XwBHx8A00J+GOGw+sSMdmsr6i2sqn7hyrMoAbvg05M8DbIGmVzSCaov1Qjeon4sUV6o03EOrrKTeuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4P2EFupYr5Zhgm6KAZk0OQWmZyVoywjejFV+yZmKiY35r0jW1
	vWMlTUeg6bNbGsc8MPFLJMiXO0A/GHtGXXLWbWYs0yPqJNwWdi5rJjZA
X-Gm-Gg: ASbGnctpSYmjqH5duriDHxKs7gM7tLEJktSP3NthNXircDBdqvlph+QND4oZftFBDj0
	BmCjJO6CarxSToX1Cw3+TEpUaeizxldkxTm6J6pDtNnC9eU4cJR4xexpM01X1sc0j/lIecnCrJ+
	VuzydnJO8yNrPaNmZuMXdUzkn25X9CFU3Dzrfr5BhhRucIOlceK7PHJImamDXJg2Rz+eLAxpYnn
	Dccz/BCk2eoP3wjlwD0G4CgFJ1ACjLO4KpSHntji5eWINCDb61x43754MKdu1odEZpGj8W55YqF
	CopDxIikLIkFqpV+hkymGVoWa7ophgxePDinF6Vi5UgVl39W+Vf/46j0dYot3RHw31/n9wrfvlW
	7e+1eY2RcCFbjuZnnjJWZsewIYHbwYf86hLkzOz3R3NG+
X-Google-Smtp-Source: AGHT+IESgBAIB0Mj8/I1QLh4binzo0OXdjp/gLkwS6VlQjNmb/O7+eP5lJKfTEntVqlmFJ9XKoiplw==
X-Received: by 2002:a17:903:1590:b0:24e:af92:70c2 with SMTP id d9443c01a7336-25d24ea0302mr101648445ad.24.1757819920769;
        Sat, 13 Sep 2025 20:18:40 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-264885eda79sm6926775ad.6.2025.09.13.20.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:18:39 -0700 (PDT)
Message-ID: <aaf3dffd-cc88-46e2-a65b-a1ff4fcc6eec@gmail.com>
Date: Sun, 14 Sep 2025 10:18:34 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
To: Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Dante Strock <dantestrock@hotmail.com>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
 <61249b3d-3996-4d9f-814b-3794aa42c40b@infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <61249b3d-3996-4d9f-814b-3794aa42c40b@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/25 04:40, Randy Dunlap wrote:
> On 9/12/25 6:51 PM, Bagas Sanjaya wrote:   
>> -The kernel developers use a loosely time-based release process, with a new
>> -major kernel release happening every two or three months.  The recent
>> -release history looks like this:
>> +Linux kernel uses a loosely time-based, rolling release development model.
> 
>     The Linux kernel
> 
>> +A new major kernel release (a.x) [1]_ happens every two or three monts, which
> 
> I'm much more used to x.y                                           months,
> 

The reason I use a.x is because a is indeed supermajor (only incremented 
on occasional cases i.e. in Linux kernel when x gets large enough), and
x is already used as second placeholder component.

>> +comes with new features, internal API changes, and more. A typical release
>> +can contain about 13,000 changesets with changes to several hundred thousand
>> +lines of code. Recent releases, along with their dates, can be found at
>> +`Wikipedia <https://en.wikipedia.org/wiki/Linux_kernel_version_history>`_.
>>   
>> -	======  =================
>> -	5.0	March 3, 2019
>> -	5.1	May 5, 2019
>> -	5.2	July 7, 2019
>> -	5.3	September 15, 2019
>> -	5.4	November 24, 2019
>> -	5.5	January 6, 2020
>> -	======  =================
>> -
>> -Every 5.x release is a major kernel release with new features, internal
>> -API changes, and more.  A typical release can contain about 13,000
>> -changesets with changes to several hundred thousand lines of code.  5.x is
>> -the leading edge of Linux kernel development; the kernel uses a
>> -rolling development model which is continually integrating major changes.
>> +.. [1] Strictly speaking, Linux kernel do not use semantic versioning
> 
>                               the Linux kernel does not
> 
>> +       number scheme, but rather a.x pair identifies major release
> 
> x.y ?
> m.n ?
>                               rather the a.x
> 

See my above reply.

>> +       version as a whole number. For each release, x is incremented,
>> +       but a is incremented only if x is deemed large enough (e.g.
>> +       Linux 5.0 is released following Linux 4.20).
>>   
>>   A relatively straightforward discipline is followed with regard to the
>>   merging of patches for each release.  At the beginning of each development
>> @@ -48,9 +42,9 @@ detail later on).
>>   
>>   The merge window lasts for approximately two weeks.  At the end of this
>>   time, Linus Torvalds will declare that the window is closed and release the
>> -first of the "rc" kernels.  For the kernel which is destined to be 5.6,
>> +first of the "rc" kernels.  For the kernel which is destined to be a.x,
>>   for example, the release which happens at the end of the merge window will
>> -be called 5.6-rc1.  The -rc1 release is the signal that the time to
>> +be called a.x-rc1.  The -rc1 release is the signal that the time to
>>   merge new features has passed, and that the time to stabilize the next
>>   kernel has begun.
>>   
>> @@ -99,13 +93,13 @@ release is made.  In the real world, this kind of perfection is hard to
>>   achieve; there are just too many variables in a project of this size.
>>   There comes a point where delaying the final release just makes the problem
>>   worse; the pile of changes waiting for the next merge window will grow
>> -larger, creating even more regressions the next time around.  So most 5.x
>> -kernels go out with a handful of known regressions though, hopefully, none
>> -of them are serious.
>> +larger, creating even more regressions the next time around.  So most kernels
>> +go out with a handful of known regressions though, hopefully, none of them
> 
> I would add another comma:        regressions,
> 
>> +are serious.
>>   
>>   Once a stable release is made, its ongoing maintenance is passed off to the
>>   "stable team," currently Greg Kroah-Hartman. The stable team will release
> 
> and Sasha Levin:
> STABLE BRANCH
> M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> M:	Sasha Levin <sashal@kernel.org>
> 

This can go on separate patch, I think.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

