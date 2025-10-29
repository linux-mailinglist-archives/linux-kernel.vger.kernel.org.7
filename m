Return-Path: <linux-kernel+bounces-876612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01986C1BDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A94434B21E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047F33A01E;
	Wed, 29 Oct 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqmZ+aMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A9325737
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753525; cv=none; b=iBD7JyFmoIs2PZOhAX6WLgBsuB4vL1e7tocWlpziO5vkwSiogc7yA0XGWAs39ot573SRjNrIpKzqhs4qmu36fLQey/PKY87V/1LbfvPlLgomM0HAz42ruqF84k4Xfbt4YIcWDjZ/LuOziXchzLgUsmF82uvUaLnW2qP2F5rUEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753525; c=relaxed/simple;
	bh=NaCyzM+HLSFiiHYiUXG9X/gGn5OsbOBRqHIFVU3rtKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMzh2kSAThC+SRivKdBuluHX2IjTyjHiAFW+1w9en0CBq9U4QZzzZ1oviu4e7hb+Gz/HDL0nTLmdMH5NjVIwifGJ3FEj4uzuk4yZ6SU0ASYSvTxb3u3FIydJ5wdMC/XSTiZnqcbis0bTPWs8+8/RW77RKCoyCPXLEcOPLuG13FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqmZ+aMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761753522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7MTuw2M4w+7icp1v9w2NHA+FuLFUpMlcJ3+bxm+0QA8=;
	b=dqmZ+aMUiElh3jGjxsgftFWEY6lmFngKFFqSwNtFy3VYxh8R8oV8lZDhiu+uiX9H6NTdgN
	qpkP3gqEsH//dQCevz0NDdUYosL+lyp5tpxfaBRVHYbZSPuen41y3AGyT+NxLmNoLHfoBL
	TgvwMZ3bZILEUdjLrCD3v3cZ6lASTg4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-UTfvWt4uNUqA3AC1vFC8gg-1; Wed, 29 Oct 2025 11:58:40 -0400
X-MC-Unique: UTfvWt4uNUqA3AC1vFC8gg-1
X-Mimecast-MFC-AGG-ID: UTfvWt4uNUqA3AC1vFC8gg_1761753519
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475e032d81bso35717785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753519; x=1762358319;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MTuw2M4w+7icp1v9w2NHA+FuLFUpMlcJ3+bxm+0QA8=;
        b=lq+aznbYEgLuhJh82lKLIPZSgP77mX9vw6nVgXOs5VwuXbEBiJzvomT+eCOTv2jHQt
         ZQu1w9bvJ/X+XDT8YBYaEggbJ9D2FkgRNNxMglnpatOwVsfYyMOtdrEmxkB3w6y9IFk8
         E04pbpjDNA6/FHLsWSOFFzNs1dcmh8yXrNgbnU3YEYsePAwXf+ZpwZdu8217j5txwey1
         aQufhJQh5ibHTxzj2bx490z/WhZOSdq+saKpd0IuKrN6TIBfLHkRTGxReZFhcFJNPDRN
         xfpzeGh0vm5PDhaSyoD34HibHcYI3WOLFI+3AtQ2Z76BowPxG6Ln86s4m5h9GHSeDfsZ
         x28g==
X-Forwarded-Encrypted: i=1; AJvYcCWdCSV8suI/S2nffPshLfIkAKCi0Xo7zDbOvqgi0L8G/9BqzdaSC95laGnsKJRcXLonssdib3cl9SEmm70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL626IGFXu8yiqEUGzRTQ/wPBJjGWouMiGZDAPZk60Wm8tgt6g
	TCUO9tYg/ZMRC30A92BSvHeI9/qBeZozERhSwRT63KXPp2fDEcuPRonRm1p2p/Vte4xEprK4jia
	qPwIgcOf4jlre21sVZmbKDQt682ApxOU8aDZOHNVaaCYu4kz+C1sQTG0tvtgPqSckpQ==
X-Gm-Gg: ASbGncua7MlMnHAHzh9/+37y12eFGYDQ+AinSkCm3OLPVvFePgy0sAhiVdMeVV+505O
	jsldLb6c44hmzue3LwYKVNc8r3TyMkqcfeqbBpI8AmXT+Mrr2S0zo2oSxXGKx8u7+adZgS7aby/
	jpwH3p9AAgvnXodesCEmogNOPPEX1Nqql/T2OrfeOqBHd4JUy7WweFoiNbC7iJ3p/HV7jaxXgd7
	Ia4xippCZfkY/dxFR21NyMHPnSOa9oFjELfhz+TzvzP/Tp5okppHuKrucNm2+/Hc+IL6cQuqd1R
	2gWstAKF4eeW10LCziHJhPJhldLaQrmPK7XCLr33GtEHQ5s8O9RQpOwXqf0ejSGA94CZ3kBNRYh
	foOAMhRMqEH4llS9xe3xLJw==
X-Received: by 2002:a05:600c:a087:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-4771e16e3a3mr32441735e9.4.1761753519397;
        Wed, 29 Oct 2025 08:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBUfbQXjSUBfZ5yGMdw13PwBGP5RPGg4Gjem7sfzzIH+QoMvfQEwhbQ98KDi2IbIS3+g/TEQ==
X-Received: by 2002:a05:600c:a087:b0:477:58:7cf4 with SMTP id 5b1f17b1804b1-4771e16e3a3mr32441575e9.4.1761753518936;
        Wed, 29 Oct 2025 08:58:38 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm26817699f8f.43.2025.10.29.08.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:58:38 -0700 (PDT)
Message-ID: <b13bf4ce-a6fb-491e-a8c7-ecce0d4d87d2@redhat.com>
Date: Wed, 29 Oct 2025 16:58:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org,
 kernel-team@android.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251028191020.413002-1-isaacmanjarres@google.com>
 <dcceca48-bbdc-4318-8c07-94bb7c2f75ff@redhat.com>
 <aQI3z0x0gZ3T1fij@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aQI3z0x0gZ3T1fij@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.10.25 16:50, Isaac Manjarres wrote:
> On Wed, Oct 29, 2025 at 11:03:18AM +0100, David Hildenbrand wrote:
>> On 28.10.25 20:10, Isaac J. Manjarres wrote:
>>> When emitting the order of the allocation for a hash table,
>>> alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
>>> log base 2 of the allocation size. This is not correct if the
>>> allocation size is smaller than a page, and yields a negative value
>>> for the order as seen below:
>>>
>>> TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
>>> TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
>>>
>>> Use get_order() to compute the order when emitting the hash table
>>> information to correctly handle cases where the allocation size is
>>> smaller than a page:
>>>
>>> TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
>>> TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Cc: stable@vger.kernel.org # v5.4+
>>
>> This is a pr_info(), why do you think this is stable material? Just curious,
>> intuitively I'd have said that it's not that critical.
>>
> 
> Hi David,
> 
> Thank you for taking the time to review this patch! I was just under the
> impression that any bug--even those for informational logging--should be
> sent to stable as well.

See https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

In particular:

"
It fixes a problem like an oops, a hang, data corruption, a real 
security issue, a hardware quirk, a build error (but not for things 
marked CONFIG_BROKEN), or some “oh, that’s not good” issue.

Serious issues as reported by a user of a distribution kernel may also 
be considered if they fix a notable performance or interactivity issue. ...
"

-- 
Cheers

David / dhildenb


