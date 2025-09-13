Return-Path: <linux-kernel+bounces-815295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F5B5624D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9051B26890
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10D1EFF9A;
	Sat, 13 Sep 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc7kbV1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957B7260D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757784190; cv=none; b=R6p0tMijjl2yURwzjL7bX8n/MKZ3q7Izxdl+9DB9aRtVz3tYEPEJII92SsxdSs/+OLBNOGo+FfeqvGPp+gU3sTNYPjduopHa+mr11Hb9M4kKy+yzq7ha8n3oZwwOfM72r28RfJiUQBeGaa5oMJVVMFWj99ZGP7JefUeWBjYO2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757784190; c=relaxed/simple;
	bh=uYJxU5KCUZ5eXqj/aGyYCYeLYOgevx00fW2OwO9yuro=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UEro4raDf5XvCL7+7SqRVKYQUs8XdLEN81MmNxT0p6Vhb8usPt6d08JodkQJvE9QO1Digfr4gdUgMKf0jHmsk3bFE2euV5vxrL+puhlTufXx6dhBq808svU97G1Yu+KqlIgweJYWEdl9bLEsmUFHkaBVvTrhNUf9yQ7/+30HxE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc7kbV1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757784187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4YlQXKpH+D4qdOkt+p9oYx5rPR3S2A16NbP/v9A0Os=;
	b=Zc7kbV1kjLyFg/PMEDwop+mK86C2q4H34t5CSjzfmqPzJrvH2lFAzDqLi7zawGXTGkuKXf
	uHczbm5az0Vt4KQpboWn/T5qm4wb378qbNKA5Ua2lhXtllAegs16QSGS1FUMQ1V/tfHFzb
	wekvyAV1U67w1rWwm9kSHQa4vXp/2TM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-4Q9-dXSVOAi0QqgYe6c9Lg-1; Sat, 13 Sep 2025 13:23:05 -0400
X-MC-Unique: 4Q9-dXSVOAi0QqgYe6c9Lg-1
X-Mimecast-MFC-AGG-ID: 4Q9-dXSVOAi0QqgYe6c9Lg_1757784185
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-804512c4373so746293485a.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757784185; x=1758388985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4YlQXKpH+D4qdOkt+p9oYx5rPR3S2A16NbP/v9A0Os=;
        b=OpVR/6943+iGzYbQCiFQkaIx77LsNls0JCz7hvlAZIFwsuq8Uwjj8D0WxeV2jxO9g8
         MAkjPcHfJ3h1Tz1CobmVp/ZnhL1GpOOxK+QUaSnLPwhHw3hYFFFgAHMTOH6wDFDmGrFh
         zIx6OxJtOuELrsPTkHMaw4TmLrJaJPYgGtr7URYQT/Vu1Rp3BY+gk2TGREt5elAXvipn
         gvF0DXR3uvIl0v2Tf1ygIhj9pW26RQiN0trYQddaG1MGfKpGJ86bkmxR4M8S8LDOSQVw
         V/ykQ8hvEyygynYjQvGOwEnIe0P5RmpATONWnWdGhOd5UCdZuo+tJmvTo7O/x7bfBF7H
         MuXA==
X-Forwarded-Encrypted: i=1; AJvYcCU9cfG57mE8FNqR3G51G3XS9VuPUwDKZvKqO1XsWlks5ln1GviqBPsBqQ7XmeZ3QAYgQCSJs97aVb0h0bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeNpFpEQpJ+fISRGsxIoAvEeo5Oi/FiTC7DPGkWGqnvwTsb8U
	f0+rvQ4Y/2ZsvRSLV+tjOIKcJNUQLqUvShRsZxHrjZLNCVXjD5xHdTaY2BxpEsJbu2zKlv6VZeg
	0uPuc7l4zmKQse459lfbgJbdRlU+GHgTBvxVj7kwN9bC292HD4qyLzkv8F1ekNqHFxA==
X-Gm-Gg: ASbGncuV1FTV32Ssfwuzc26F65E74VTon6byARXHOYouFP1QHNMmeK06Sd6mI/ZfBOj
	MVF5B0R+aWm4W97hkSd3mpzIb2lBD/NaooS0AxpZJExFRjCZKojz2EAXevMknrKVIf4bleg0jUl
	ABwQ123E6rqnboNdao55F3VSxyzF1GxvWGfPZLyTMMDE18ny4PQjP1jotDSnbklCzq/i0zHOhR1
	gIy5Xg5LWdPTQR+OkxiaPPpQLzYSvHcRORV0ZGQSyKRT0Yzq0q1tdzegg4mNi0iNroT7+u7yfXg
	TR/fCE7jlGJDpIW3uMfznUqSLGvotnVlyXQPA8J64fGoOHTVQHXmJzCvyEcTdtw0cyKwlSBwA40
	WxfJmQwoANA==
X-Received: by 2002:a05:620a:1a26:b0:827:e9b0:2752 with SMTP id af79cd13be357-827e9b0a59emr204293685a.80.1757784185294;
        Sat, 13 Sep 2025 10:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWnXMQDadZBZIlmdUC/NCNWtr/64a6WXDfp8/eqdfqUQNqD7uWPjY6byxTl9nNLc/OUpzclw==
X-Received: by 2002:a05:620a:1a26:b0:827:e9b0:2752 with SMTP id af79cd13be357-827e9b0a59emr204290985a.80.1757784184787;
        Sat, 13 Sep 2025 10:23:04 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8240be68ee9sm332130085a.39.2025.09.13.10.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 10:23:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <10adb9b7-ea19-407b-818e-79061a067e13@redhat.com>
Date: Sat, 13 Sep 2025 13:23:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Hillf Danton <hdanton@sina.com>, Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 pengdonglin <dolinux.peng@gmail.com>, linux-kernel@vger.kernel.org,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
 <20250913080018.7032-1-hdanton@sina.com>
Content-Language: en-US
In-Reply-To: <20250913080018.7032-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/13/25 4:00 AM, Hillf Danton wrote:
> On Fri, 12 Sep 2025 20:33:31 -0400 Waiman Long wrote:
>> On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
>>> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>>>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>>>
>>>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations 
>>>>> implicitly
>>>>> disable preemption, which provides RCU read-side protection. When
>>>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>>>> manage RCU read-side critical sections.
>>>> I have some doubt about your claim that disabling preemption 
>>>> provides RCU
>>>> read-side protection. It is true for some flavors but probably not 
>>>> all. I do
>>>> know that disabling interrupt will provide RCU read-side 
>>>> protection. So for
>>>> spin_lock_irq*() calls, that is valid. I am not sure about 
>>>> spin_lock_bh(),
>>>> maybe it applies there too. we need some RCU people to confirm.
>>> The claim is valid since Paul merged the three flavours we had. Before
>>> that preempt_disable() (and disabling irqs) would match
>>> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
>>> different in terms of grace period and clean up.
>>> So _now_ we could remove it if it makes things easier.
>>
>> Thanks for the clarification.
>>
>> In this case, I think the patch description should mention the commit 
>> that unify the 3 RCU flavors to make sure that this patch won't be 
>> accidentally backport'ed to an older kernel without the necessary 
>> prerequisite commit(s).
>
> This change also affects the dereference helpers.
>
> #define rcu_dereference_check(p, c) \
>     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>                 (c) || rcu_read_lock_held(), __rcu)
>
Right, this macro will need to be updated as well to avoid false 
positive if we decide that preempt_disabled region is a valid 
rcu_read_lock critical section.

Cheers,
Longman


