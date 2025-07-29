Return-Path: <linux-kernel+bounces-749192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C763B14B48
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8A17C5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317328688E;
	Tue, 29 Jul 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyllYDNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EE25CC63
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781377; cv=none; b=ZUCzyfp0TuRuUzOqW7jFTEt66pBAxsb6pAAMRwOLsQsZCfUk2xSvYMqVWLmF2CgvU4AI67HxAs+j3LUWv9C1heLgTSdNPrb2PGPQL5PQH1aEsgIhHyc1Zvyb3kzvwE8szdRjheHlNu03nMCYC+dzf4srMxB2+62VQKRJkIRzejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781377; c=relaxed/simple;
	bh=qVir5qiN1LkJjvtQolq1TdEEOnh29gjk84mQeTJCXWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzJUiPXc8QzhPZFYYnROzaXiGyde8ixg+2wDl5aWqEkOyRQz5TnocCfeU8sgC4SIlbVNm9t7Vp6GrBDpqwdrzyV5x0D6jQ7WBDEb4kJpYmBT+XFg3NgSzowly+dV5ljApKe5NcGnet5NsIYZbgX/hvTpOjT4KC06d7GnRcCUJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyllYDNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753781374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0DMXTaLjXB64t1BDlPj4yYTKhGmLr0woM0Vff2Ca5QQ=;
	b=FyllYDNwDOLX/kadEG1yVWbTNknkk6YnXa2iXUvnVAmAscGtYqR4cY5EHi2TVwVvgfX2RN
	42l6b4/GZ75nSCZiCp8hFU/9znMUR7ap+ke5vCgsAs4lmirWCDHGNzof3rMFqMtLwWCQhX
	M7FWgS2wy1XcmEPeIQ44l8LWWCcoYjA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-E7XuXrAbMHGhuJNb8xL-TQ-1; Tue, 29 Jul 2025 05:29:32 -0400
X-MC-Unique: E7XuXrAbMHGhuJNb8xL-TQ-1
X-Mimecast-MFC-AGG-ID: E7XuXrAbMHGhuJNb8xL-TQ_1753781371
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4588fb6854cso1416165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753781371; x=1754386171;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0DMXTaLjXB64t1BDlPj4yYTKhGmLr0woM0Vff2Ca5QQ=;
        b=LKR/qvn42hwLDmw8JG32EtnGuY8auP/3EDi3ZzVDkxcQlbYBiDVgsnIs/NQXKx0TFM
         Fiec7qMNK69uT5Z+6vt1u2/f0XQk/+0BDb+JN8qlPQ8N9flIO5I6lplWLGr6btW0y762
         hTM0G+lQ1OtpXDSjGuyKQqi6y80Ux/+cpQhnKFPK2HJyXRlgnlJiVoKKpxjwzoLds/I8
         1XfnkKmByLNrQK5V4+7gR58Cf+X0AffSvkhsIe+ZxXMx3iwQKH/Sl5K/UMM3a9nflTJl
         xab5NVckMRlTeV+8QC/4vKZN9j/eEJiGhXhA8/Fss/1y8a5AGtvUXrD1RcRcMZSP+PoR
         2NyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoFMYpRxa+H2LJNBUGJi1NlITYOweQ5dfRsldny/2XOZBXqNsl+DMFAWDANM6IWzbLtfOXJzUMp0yFXRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBM+uiGLwNpdPBPbl7g+NOm+3tA2Gshrt96knTQWfEJlvy/wvs
	EGsItV05D7bTxma7MBYZTm++ziSH/ZnhaIqaGvV87DhQYDp/HzI2f46eMN/OdgjzZ0NlC7Oajdm
	RQdhEQBaM8Uq+SzpUr5MsETV4uWCOKnptofCDQ4+z+ercFhyLDymKU7nOqFstWLfSRw==
X-Gm-Gg: ASbGncvfFiuTL+vnVDqEVDjtQ9KCetWGc1TnjS+flzM9nk50m7ukcK6drqaTclnfdXe
	SE9P9zBSVTU274hZyf+JuCU3Hezf2Yg6EySI0PaKqTILpxzmteC6B0bW2UoXaT1izD6nNmOfM8p
	28/mqY+/bu9cGcn7dKt7x1YyqQSEhKoS2TET0rnVBRzJH8XjWnVsFsJjYPT0P0+lr3CpHPRFF+e
	fEZ0wQRzEwvoSJ4O383WEmgMTE79wzR8G1xMO5AZrlyG0Vdmzi0kbNkGHeP9LMQ8T+cNvHhPl1i
	aM/W5klHI+4Aln9Em4GUVFAwpT3SZ0Oz/mM00m/z57DfGeBAAzV6M9VUVGFr8sR2+Wyf/wqN
X-Received: by 2002:a05:600c:8b17:b0:453:7713:546a with SMTP id 5b1f17b1804b1-4587631f3aamr135778765e9.14.1753781371168;
        Tue, 29 Jul 2025 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HbldFeZTmHrvF5OMPxooJGH3Eh4A8z0/BnqRdzXbm2pabTWwUjKXw6MBR+oUzq7pcH/m0A==
X-Received: by 2002:a05:600c:8b17:b0:453:7713:546a with SMTP id 5b1f17b1804b1-4587631f3aamr135778545e9.14.1753781370716;
        Tue, 29 Jul 2025 02:29:30 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5e6232sm16822615e9.32.2025.07.29.02.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:29:29 -0700 (PDT)
Message-ID: <a9e524af-baf4-4da9-938f-5da71cfbd769@redhat.com>
Date: Tue, 29 Jul 2025 11:29:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de> <aId16W4EaqjANtKR@tiehlicka>
 <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
 <ac7add36-808d-4883-a09e-ef1bf6fd6834@suse.de> <aIiSEpQhWqPsvaST@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIiSEpQhWqPsvaST@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.25 11:19, Michal Hocko wrote:
> On Tue 29-07-25 09:24:37, Hannes Reinecke wrote:
>> On 7/28/25 15:08, David Hildenbrand wrote:
>>> On 28.07.25 15:06, Michal Hocko wrote:
>>>> On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
>>>>> On 7/28/25 11:10, David Hildenbrand wrote:
>>>>> And to make matters worse, we have two competing user-space programs:
>>>>> - udev
>>>>> - daxctl
>>>>> neither of which is (or can be made) aware of each other.
>>>>> This leads to races and/or inconsistencies.
>>>>
>>>> Would it help if generic udev memory hotplug rule exclude anything that
>>>> is dax backed? Is there a way to check for that? Sorry if this is a
>>>> stupid question.
>>> Parsing /proc/iomem, it's indicated as "System RAM (kmem)".
>>>
>> I would rather do it the other way round, and make daxctl aware of
>> udev. In the end, even 'daxctl' uses the sysfs interface to online
>> memory, which really is the territory of udev and can easily be
>> done via udev rules (for static configuration).
> 
> udev doesn't really have any context what user space wants to do with
> the memory and therefore how to online it. Therefore we have (arguably)
> ugly hacks like auto onlining and movable_ration etc. daxctl can take
> information from the admin directly and therfore it can do what is
> needed without further hacks.

Really the only difference between daxctl and everything else is the way 
the memory is added.

daxctl triggers hotplug of memory synchronously, everything else is 
asynchronous.

On most systems, the admin (the same one that triggers onlining) could 
just set the auto-onlining policy accordingly instead of manually 
onlining memory blocks from user space.

> 
>> Note, we do a similar thing on s/390; the configuration tool there
>> just spits out udev rules.
> 
> Those were easy times when you just need to online memory without any
> more requirements where it should land.

Again, I don't think udev is the future for that.

What I think we (Red Hat) want is a better and easier way to configure 
the kernel policy.

If you want to control onlining manually, then disable the auto-online 
policy.

-- 
Cheers,

David / dhildenb


