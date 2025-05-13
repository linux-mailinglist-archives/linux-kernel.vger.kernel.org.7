Return-Path: <linux-kernel+bounces-646319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DEAB5AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70775468B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDB72C0846;
	Tue, 13 May 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX7PzzOJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5166B2C0331
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156639; cv=none; b=WyumbBta77lYHf1w9qHWU+dkHMvGGcDXlt2D7m8vUDfw2NPgNZi2kb5Mhmcy7Rf8AP8a0GfElQLYgpUhliy1q7T7IZpcpCbPPjWNslxhP0YkeHG1LxA53pD9Aw1QggQTG6+JGCvF7R4VDll94h4SVNQaPzjTBxPFqmMJ7Lu0FOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156639; c=relaxed/simple;
	bh=NS7MBRDbpbyLyKC88KH1LtlGgnaFG68/kH8kJH+no5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OJ8MCqwKxgcHH7p5mVN17Y1Uk27NYU9isULym1FgmsDKx3+FXPnDJ/m8Qj6fU/WiN+7H/d4lsf5kHB2YYNWARMpKbMtrCDX1hAnUoKSkP1JYvwoLtvAo9ccBNW8X1xUAcOF1JEg5mYxf6MMFSPF6uwOORgXz8OEP+0gVqz89jEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX7PzzOJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747156635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WXi47cxjBm3jaOjYLGIffilivDQE+iYxrxe28Eqtjt0=;
	b=BX7PzzOJVVkDc+QxKVg0zFjdo8AqNfLml48KdhBYqhpELvJg9ZRVJiYWtKzx/4qsRM8X4j
	PHBqpKuxXcCxw0nOHVEnprrqMqy7ixGbx7Y1IZYGHFOzm55HgpOpFGsFCHhG4R0lqr5WQL
	k2/UChGgcoijNGii6rmEy3O52iXpvLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-_PvYOdzAPI6aSF4kvAFdXQ-1; Tue, 13 May 2025 13:17:14 -0400
X-MC-Unique: _PvYOdzAPI6aSF4kvAFdXQ-1
X-Mimecast-MFC-AGG-ID: _PvYOdzAPI6aSF4kvAFdXQ_1747156633
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a1c86b62e8so2141407f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 10:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747156633; x=1747761433;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXi47cxjBm3jaOjYLGIffilivDQE+iYxrxe28Eqtjt0=;
        b=PnYvG7yFc94xu1m9brhYCjCY6kmdmFBpTdgeCw+8PBPWXgQ8dSs3sGYbfDyqa+2Z4w
         PEmUQ8tGpkFhumeFLWiNdBweK5cbFCue5GQGQIho+WE3Qgar3xBDcm1Cs/IxOeDETLFj
         92Rg5hkdsKovrXBfu4e45BwPEdDIqoBscTjwcNczWzxc5Ve51XW1gEDyLjjmOxpX5hwv
         GOc9/l819synsyxa0ftimnqQmb11PVwLJ7FXFtptEQ3YkkIEDw1VvAxQV0odL5muewOe
         V15YDVjAXraWk5azQ22tyE7iWkD8KOD8jbalQgCktCD6/3QCBs9sqSclAfwMqcVNlUI4
         nxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCv9af91Ekj+Lxa6a6VtcwTdb2g7ShqdgEe4Sv8Lgojm85aE5jSFSXGRXbi9uiqCSwTuz7HYpsQyy7e0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvZNh8bluvcRlsiDmyVfvqB7gNlDLYXYT6gUs0wW6WNeKzyQK
	lLAwo+TA7gGaIQSsze3xx9Yk6Im849BAt+05FGhkI+mMOCgrdM/r7njmRl/P2U7mJp3QpdB9gLZ
	LY0TW7HgHNSVAMs6PyNTxEgt7V4ozI3giW1oglH2faGzPeBfRSi+IQxut08P6Lg==
X-Gm-Gg: ASbGncsi/3VNxNv21S3ajaYmhpXdH3NSaCzs4MRfN7ArpEYaqMrowiT8GUpayRmu7qd
	DDtpGHhPYzyL/ZSfxPYhycwOUdFKLrQnaohbRRCCMTgccOBkiErIxFrOHc9/h/tO2UN3hlxmV5R
	le48oqNMzwrhTWno/tmOhSS9yTS8yqluLMlJOux7foykSJEBRh7IYtXtXhf0PVZMgK6h/zg5m4l
	dCvOR3yE2YKA91Z6Df906kynTPsq2DbkRr58hnIK2leDebsJfqHCxPrBNZ9EuqJ62S8nLK/TJRg
	Yhf2AURfLaIZxb/mts1HtqKff546J3/UGL1D2zgmyQSYto6bEEXzHYpyMJrFoiBwYg2Za3TlFKi
	ZBfD7dKdkF4kFHEPYO1m5HWnS3GDYe53/dOE5c0k=
X-Received: by 2002:a05:6000:144a:b0:39e:dce8:1c07 with SMTP id ffacd0b85a97d-3a34991ec80mr97247f8f.46.1747156633332;
        Tue, 13 May 2025 10:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJN/UuWvwBOcJPPgylHq9a4wFup+Ir8QlMu/xka/zvttM91CDX0AX55PtG4IoIttGAK89yrQ==
X-Received: by 2002:a05:6000:144a:b0:39e:dce8:1c07 with SMTP id ffacd0b85a97d-3a34991ec80mr97207f8f.46.1747156632895;
        Tue, 13 May 2025 10:17:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34? (p200300d82f4d1a004fdf53e21a36ba34.dip0.t-ipconnect.de. [2003:d8:2f4d:1a00:4fdf:53e2:1a36:ba34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2af7sm17091148f8f.52.2025.05.13.10.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:17:12 -0700 (PDT)
Message-ID: <9fc4ad12-869c-492d-898c-9368505199d0@redhat.com>
Date: Tue, 13 May 2025 19:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] mm: rewrite pfnmap tracking and remove VM_PAT
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250512123424.637989-1-david@redhat.com>
 <2smxfvgmkrac4uzjwti5sgv2ubzsfgt24e6yinwtl7iuchxjt3@c2ejownpooio>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2smxfvgmkrac4uzjwti5sgv2ubzsfgt24e6yinwtl7iuchxjt3@c2ejownpooio>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.05.25 17:53, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250512 08:34]:
>> On top of mm-unstable.
>>
>> VM_PAT annoyed me too much and wasted too much of my time, let's clean
>> PAT handling up and remove VM_PAT.
>>
>> This should sort out various issues with VM_PAT we discovered recently,
>> and will hopefully make the whole code more stable and easier to maintain.
>>
>> In essence: we stop letting PAT mode mess with VMAs and instead lift
>> what to track/untrack to the MM core. We remember per VMA which pfn range
>> we tracked in a new struct we attach to a VMA (we have space without
>> exceeding 192 bytes), use a kref to share it among VMAs during
>> split/mremap/fork, and automatically untrack once the kref drops to 0.
> 
> What you do here seems to be decouple the vma start/end addresses by
> abstracting them into another allocated ref counted struct.  This is
> close to what we do with the anon vma name..

Yes, inspired by that.

> 
> It took a while to understand the underlying interval tree tracking of
> this change, but I think it's as good as it was.  IIRC, there was a
> shrinking and matching to the end address in the interval tree, but I
> failed to find that commit and code - maybe it never made it upstream.
> I was able to find a thread about splitting [1], so maybe I'm mistaken.

There was hidden code that kept a memremap() shrinking working 
(adjusting the tracked range).

The leftovers are removed in patch #8.

See below.

> 
>>
>> This implies that we'll keep tracking a full pfn range even after partially
>> unmapping it, until fully unmapping it; but as that case was mostly broken
>> before, this at least makes it work in a way that is least intrusive to
>> VMA handling.
>>
>> Shrinking with mremap() used to work in a hacky way, now we'll similarly
>> keep the original pfn range tacked even after this form of partial unmap.
>> Does anybody care about that? Unlikely. If we run into issues, we could
>> likely handled that (adjust the tracking) when our kref drops to 1 while
>> freeing a VMA. But it adds more complexity, so avoid that for now.
> 
> The decoupling of the vma and ref counted range means that we could beef
> up the backend to support actually tracking the correct range, which
> would be nice.. 

Right, in patch #4 I have

"
This change implies that we'll keep tracking the original PFN range even 
after splitting + partially unmapping it: not too bad, because it was 
not working reliably before. The only thing that kind-of worked before 
was shrinking such a mapping using mremap(): we managed to adjust the 
reservation in a hacky way, now we won't adjust the reservation but
leave it around until all involved VMAs are gone.

If that ever turns out to be an issue, we could hook into VM splitting
code and split the tracking; however, that adds complexity that might
not be required, so we'll keep it simple for now.
"

Duplicating/moving/forking VMAs is now definitely better than before.

Splitting is also arguably better than before -- even a simple partial 
munmap() [1] is currently problematic, unless we're munmapping the last 
part of a VMA (-> shrinking).

Implementing splitting properly is a bit complicated if the pnfmap ctx 
has more than one ref, but it could be added if ever really required.

[1] https://lkml.kernel.org/r/20250509153033.952746-1-david@redhat.com

 > but I have very little desire to work on that.

Jap :)

> 
> 
> [1] https://lore.kernel.org/all/5jrd43vusvcchpk2x6mouighkfhamjpaya5fu2cvikzaieg5pq@wqccwmjs4ian/
> 
>>
>> Briefly tested with the new pfnmap selftests [1].
>>
>> [1] https://lkml.kernel.org/r/20250509153033.952746-1-david@redhat.com
> 
> oh yes, that's still a pr_info() log.  I think that should be a pr_err()
> at least?

I was wondering if that is actually a WARN_ON_ONCE(). Now, it should be 
much harder to actually trigger.

Thanks!

-- 
Cheers,

David / dhildenb


