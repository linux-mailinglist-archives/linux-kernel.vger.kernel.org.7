Return-Path: <linux-kernel+bounces-689586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562BADC3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2823B8550
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0C28ECE3;
	Tue, 17 Jun 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkQX+5ry"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2028CF65
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147150; cv=none; b=b0gzlqK6X123mZd5ofZtGH3fRTiDM0DOgySxIzfsHkW1Oe4ZR34LTQ6REQtO9IlDcZYvpK7Rb67Bd85QKkAPBygIgeyHLpsICIxahpNjUM7Dcr9UZ53PBiUcdm3rGBejmpac527rXsnkc34lSV734ELP7tjgKZMBMolpMUrNKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147150; c=relaxed/simple;
	bh=zjk3Lu99iWLnSGoEQnV13yzZ0ZggfgFJolxyWKbVVQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bu37sBcfM7MegdYiQneLGTw8NtiVr9bJglmWY2/NWpazXqKItAozQefI2q/mgo6IdkWv+6CBuj091gpWYkUeYvXH5MUt4e0bAp6xF1DQUzPVnVd9nC5zdBoeneLTkXiJXAXa8t2ooduz0ei62t7qZjo1/sJGoGv5EFw5BAqiKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkQX+5ry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750147146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Iuh3uJ5HTbfwgFoHlIeRrGD2skEzJ92Kdquc4NMIC1A=;
	b=AkQX+5ryPfF9boZS9a2s9E3Fg4JclceHVA5R8QwOvAvuzyFYMESl9QRM6NpRHG6DLXIlpA
	qL41EWiOnLq8ztIKBlEQE/Bcoz0JUn6lnnpIGHqaMRuAhAKftHni92zk+FJP70i1o3jqal
	aO8+rjKHlXPaFLIltaiUbEaDBQqMjMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-fFs5qevgN3qAVqETi5adRg-1; Tue, 17 Jun 2025 03:59:05 -0400
X-MC-Unique: fFs5qevgN3qAVqETi5adRg-1
X-Mimecast-MFC-AGG-ID: fFs5qevgN3qAVqETi5adRg_1750147144
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so26478115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 00:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750147144; x=1750751944;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iuh3uJ5HTbfwgFoHlIeRrGD2skEzJ92Kdquc4NMIC1A=;
        b=HuQlz6Crl2JKbkciaHDQpRLUKTg0x4oXQMFM5HyJO2F33nPQr+ucIvjHL+o+p8s1DY
         CEsLUpnqptdGTtRG7GSKgamvCpJsDxa2wMzbriLHRD/l0jr04ezFFJwQX1XWFcZwUHGz
         oB1j5lDd+y11mh/+fqeyRtk9wXteYnUg8PEXpJdIKDm7hwhwqBGsmwia8nHdszgXwV6N
         DInArpja80iCMnQqxc/hff71a2sPeJdoB3jeBnjyuJzDKBTqHyFLuDcQnPkQCrUuWLH2
         BiQvnYt0j0LK1gLLH3aZ7nmTOs4a9jKFOi6T8tfC0+jFoMEp7OeLgccSKdFmhrq8B7/K
         ERRg==
X-Forwarded-Encrypted: i=1; AJvYcCUD7Bw3tocilLagLH5OmLsz1FqWIlv5UOjWTfqnwQbAY3vZSLxZYdFwU+TzIr44P1lsY+W6C4NfgcoHXu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrCUkyxVWASfJrOs/p2FRlzaf7quj6jf4PrcIwVVm+UO5wrHv
	tmZFnSttrts2GNvzZ1a5jcY5lqxr+shSflKb7rq85Aw4elL+uZKD7GAKKQ/i7H4BOJ+SUQ01h+2
	9DqTveB9P0zdgIJGO4wlA0TwAOwwugQmsXhyTJhMnCsouE5QRZByoNaDkVBiV5AZdjw==
X-Gm-Gg: ASbGncskvRWaFwLkxWbZu8zct7IIBOk9bYJonFCL9N2is1hYbe2qV+SCUP3Kvv25+PH
	m7WorzKjct25flnyjjJ5Y2jvy1IFeMqPGfhQm0uJ8nmTEdCUeAmnci4MRNjks7jJHhmT0VRHhIE
	1p8CAp+7V1yckg85smF5N8FxirHiWaumHwx7QRFRNVvnY+6bGrqU+CrLMMVwpkfmo1yD1Fqhy+K
	Xqt+Euh7eR1/cs4geGEsa2GYtkFrug0Yi15QDfaCWFC+5GLerizJK1tWm/7L01f+4Atwdi6Jo8M
	OM5aGAdg4tYBsnhuV2ouusQrQFwp6YKDv9uvWdrkUdukEDzOj4OBjpotr2b6rrLYSllcdW5E8jL
	qpLiV0WLbqFrBONIG40RuVr0A90/md30lzkT99atl59tmuGc=
X-Received: by 2002:a05:600c:1d9e:b0:453:7bd:2e30 with SMTP id 5b1f17b1804b1-4533cac455fmr114431715e9.29.1750147143916;
        Tue, 17 Jun 2025 00:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETHzi79K36v23NPAMCQa2de/RDdUyXF0ggT/lPYXw1DZwj4wovdsEUGNLpA2OIEK65+pL5MA==
X-Received: by 2002:a05:600c:1d9e:b0:453:7bd:2e30 with SMTP id 5b1f17b1804b1-4533cac455fmr114431445e9.29.1750147143478;
        Tue, 17 Jun 2025 00:59:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a73a7bsm13392978f8f.36.2025.06.17.00.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 00:59:03 -0700 (PDT)
Message-ID: <4b0036ae-5b92-49b5-8396-412c7026b105@redhat.com>
Date: Tue, 17 Jun 2025 09:59:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] MAINTAINERS: add further core files to mm core
 section
To: Mike Rapoport <rppt@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250616203844.566056-1-lorenzo.stoakes@oracle.com>
 <727b5e89-89d7-4abf-a93c-8d6f2cb2c438@redhat.com>
 <aFDm0YrbSAvXc5Wp@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aFDm0YrbSAvXc5Wp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.25 05:53, Mike Rapoport wrote:
> On Mon, Jun 16, 2025 at 11:10:41PM +0200, David Hildenbrand wrote:
>> On 16.06.25 22:38, Lorenzo Stoakes wrote:
>>> There are a number of files which don't quite belong anywhere else, so
>>> place them in the core section. If we determine in future they belong
>>> elsewhere we can update incrementally but it is preferable that we assign
>>> each file to a section as best we can.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>> REVIEWERS - let me know if these seem appropriate, I'm eyeballing
>>> this. even if they are not quite best placed a 'best effort' is still
>>> worthwhile so we establish a place to put all mm files, we can always
>>> incrementally update these later.
>>>
>>>    MAINTAINERS | 28 ++++++++++++++++++++++++----
>>>    1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 4523a6409186..a61d56bd7aa4 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -15740,10 +15740,6 @@ F:	include/linux/memory_hotplug.h
>>>    F:	include/linux/memory-tiers.h
>>>    F:	include/linux/mempolicy.h
>>>    F:	include/linux/mempool.h
>>> -F:	include/linux/memremap.h
>>> -F:	include/linux/mmzone.h
>>> -F:	include/linux/mmu_notifier.h
>>> -F:	include/linux/pagewalk.h
>>>    F:	include/trace/events/ksm.h
>>>    F:	mm/
>>>    F:	tools/mm/
>>
>> Probably better to have some section than none ... was just briefly
>> wondering if "CORE" is the right section for some of that. Some of that
>> might be better of in a "MM MISC" section, maybe.
> 
> Maybe rather than add files to MM CORE we should move mm/ there and add the
> MM MISC section for files we explicitly want to exclude from MM CORE?

Also an option, yes,

>   
>>> @@ -15764,16 +15760,40 @@ S:	Maintained
>>>    W:	http://www.linux-mm.org
>>>    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>>    F:	include/linux/memory.h
>>> +F:	include/linux/memremap.h
>>>    F:	include/linux/mm.h
>>>    F:	include/linux/mm_*.h
>>>    F:	include/linux/mmdebug.h
>>> +F:	include/linux/mmu_notifier.h
>>> +F:	include/linux/mmzone.h
>>>    F:	include/linux/pagewalk.h
>>>    F:	kernel/fork.c
>>>    F:	mm/Kconfig
>>>    F:	mm/debug.c
>>> +F:	mm/debug_page_ref.c
>>> +F:	mm/debug_vm_pgtable.c
>>
>> Wondering if there should be a MM DEBUG section. But then, no idea who in
>> their right mind would be willing to maintain that ;)
> 
> The same people that maintain MM CORE? ;-)

Heh :P

>   
>>> +F:	mm/folio-compat.c
>>> +F:	mm/highmem.c
>>>    F:	mm/init-mm.c
>>> +F:	mm/internal.h
>>> +F:	mm/interval_tree.c
> 
> Looks like VMA to me.

It's more about anon_vma I guess, so rmap ... maybe.

-- 
Cheers,

David / dhildenb


