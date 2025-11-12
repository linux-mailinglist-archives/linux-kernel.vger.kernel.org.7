Return-Path: <linux-kernel+bounces-898036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5510C542D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B303AA693
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2D34DCC5;
	Wed, 12 Nov 2025 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBjwEVbM"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D49337B9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975580; cv=none; b=RHtFdiSOejWZ5qipKzX/O1G2IkutgY78tdCCJNb/xPIAwYc9U/cPYxWoXN+NhgFJ0epvWBxhN4oDhfW0LsqSs0IItsdJiYAsrxjPhorIhPLDKoShoKgnGsdVLN5nPEOVXgKbrnH9NkynZOlZh+Wiu3hm9mM6MLXwddwAtNn3xYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975580; c=relaxed/simple;
	bh=7+aqrc7gxrvbg0zoPLO/qVZC3fC6KwrV7sIZ7rdS2Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgveEDyudGcTus4SL1rbr8d4v1bieleR/Ac4nx2f9nxHEaEGUbSkYdvDPtrYFYjBg0ZRBNNWVuej6MFpVPAXbgkVAtz54xb4Ptwv8ZyTItfbhf9zAjY++dknKCoy3+twkd/66p/6LM+YdkcI8ricPBkgHUbLmn+yqud19p9MUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBjwEVbM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471191ac79dso513295e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762975577; x=1763580377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOvdwmjF3vj/wtjElLtlYhjlH8fqcUEkQXd8Ow1Ngqc=;
        b=fBjwEVbMHSRk7tDYsximaakAae2OZYK12OZHFgssbGIRbzEZOqB4Nu+i5fG/JqNfIk
         SBRAMgXycWrX+0zClzuGBnhFtK3YvqbvbO2PLJJ6G9Syp5ZTsjK7aBEL1SiFlQky/n0e
         7DG72PYNmec9H119fnE/VS9J+EGTzrT0xQYAsYoh6H0JUasGWV8Y56xPPYDpVXYE1MNc
         vD03TF6zI2Gk0suTbfbWujEPkSK4XTP50YJDozbmKmZ1VC1o+0WibDsxobglXNFykjCK
         gMR4YmRMWHpTRrg/vcBQUPdD85onGcScniTUAuOn7WDg1uFOtu0lmTfxdueDuICSXqyU
         Ul4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975577; x=1763580377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOvdwmjF3vj/wtjElLtlYhjlH8fqcUEkQXd8Ow1Ngqc=;
        b=Q6CygDJ3zY7RKl+fHHs6nuJDvQWNwBzY+Sbafvb/3pAIT3KKPFvcMR2Kf3HmcNPFim
         qXeqm43F7uIeohCZu54DpMxXDbMfLq6oJFQIExuLOSnk9YUSh1v6RJxvzf1KTbCyq8e/
         IGTKQF7obTCm3SvQeWGkUkpqZ4KRwgwK78ceeeVqfB0cWs0nzyJ6lM+BszgKO9x1aYMb
         053Vnv3ujO6wPwPP5rJ6PcDcxgSWseTc1beqP29/+VB/H4CNDWtpBr7L179D99nCHhYF
         zaKW6J0E45wf9+mk/K/7p/zpgyKBSGOB+MqSVwFS1oOuelFRWjL6VuOl1wFQujXq62y3
         BNLw==
X-Gm-Message-State: AOJu0YxZEtG7D8CNtMImpQwHaZPWpTGLl38+lLnSwtGIiVwMH6krusRP
	5Q+00YWrKuOlJ7cJsgqztGmIinb8tPEa0PAqs5I/hJ705r/tX6zz62hB
X-Gm-Gg: ASbGnct4Jr+pQLMt7kWTJ8gf9Mh5XFZqKbF4Wfz/1T56970yFvVvI4DHGnfYWdsKDDy
	wRj/NgCp6MLPPjSiQjWix+eMw9Qcd7P5rPTZmP5TDXXLW/PcfoWiL7Ygt/s8fZb0IjqNWm/WiFH
	5AjjTtlTuqRndpO3mWtKIaAumstMBcx2DQG+LJK6jrjU6XH758LlVu9Azi2ZkhOa7GNkQ99MBY8
	DPahiUdVn89e7D01jBwHYx3FZM659clHIbRVwPi8muK09DqcZFjab88yvdHU9f+0cKPz3pK9Ccf
	Q+UPLWkXdVHqNQ5wckFCCqRjdFBp7fcsuO+/41ggfiNd2hh0mXWnmZyHvwd1tzvCr1ER4W5Vme8
	hH7b93EgUuCWzSwCqmwB0/6G1mkQPAwqeTug4X1BK9FWFr7JFOOwik4EwN1lkR1k08ta+SD3KOK
	4OQpEw+GjWjBUj
X-Google-Smtp-Source: AGHT+IGI0yaeZ/Z25ZuhwdvsHgYCdSxi9R5gy1iKkdGjcDReF/a2PryusG5lOqIA755v9T/eszRQLw==
X-Received: by 2002:a05:600c:1553:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4778703e886mr43755065e9.1.1762975577353;
        Wed, 12 Nov 2025 11:26:17 -0800 (PST)
Received: from [192.168.1.121] ([176.206.83.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b314dae4bsm26087760f8f.34.2025.11.12.11.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 11:26:17 -0800 (PST)
Message-ID: <83e65d27-73c7-465c-a5c8-861608ea93e7@gmail.com>
Date: Wed, 12 Nov 2025 20:26:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/9] platform/x86: Add asus-armoury driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251102215319.3126879-1-denis.benato@linux.dev>
 <aRSdHcO1WCPmG63W@black.igk.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aRSdHcO1WCPmG63W@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/12/25 15:43, Andy Shevchenko wrote:
> On Sun, Nov 02, 2025 at 10:53:10PM +0100, Denis Benato wrote:
>> Hi all,
>>
>> the TL;DR:
>> 1. Introduce new module to contain bios attributes, using fw_attributes_class
>> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
>> 3. Remove those in the next LTS cycle
>>
>> The idea for this originates from a conversation with Mario Limonciello
>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>
>> It is without a doubt much cleaner to use, easier to discover, and the
>> API is well defined as opposed to the random clutter of attributes I had
>> been placing in the platform sysfs. Given that Derek is also working on a
>> similar approach to Lenovo in part based on my initial work I'd like to think
>> that the overall approach is good and may become standardised for these types
>> of things.
>>
>> Regarding PPT: it is intended to add support for "custom" platform profile
>> soon. If it's a blocker for this patch series being accepted I will drop the 
>> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
>> separately to avoid holding the bulk of the series up. Ideally I would like
>> to get the safe limits in so users don't fully lose functionality or continue
>> to be exposed to potential instability from setting too low, or be mislead
>> in to thinking they can set limits higher than actual limit.
>>
>> The bulk of the PPT patch is data, the actual functional part is relatively
>> small and similar to the last version.
>>
>> Unfortunately I've been rather busy over the months and may not cover
>> everything in the v7 changelog but I've tried to be as comprehensive as I can.
> This is more files starter with asus in PDx86.
> Perhaps it's a time to have drivers/platform/x86/asus/ ?
>
I will leave the decision to you PDx86 maintainers: I'm fine either way.
Just drop me a note and I'll move asus drivers if you decide it's the best
course of action :)

