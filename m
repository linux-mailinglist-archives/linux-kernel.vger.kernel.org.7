Return-Path: <linux-kernel+bounces-632116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD267AA92BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E943A856E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C72288F7;
	Mon,  5 May 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF9jR8XU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A414B96E
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447061; cv=none; b=pZ/M3XJtDBHJX0Jl99Z5WAMVxdwQz5s91macSkQJ8fyue6aCStxJDgLObQLBlOdqjUO3YJlvWu9lstOZy0SOdcHVoPCW15dyABcJeiLMFBe8jKeCrTk/dCMMmPFUTCfuDj0jzIquPT7EmH6+rv+Y8DJov3CMHZiWvKF7RVyRf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447061; c=relaxed/simple;
	bh=guvqDk0+ML1yRydRc4PwIYXA9gbbPH4lTNyllJ8lsk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io63/v8ss+JdxC0Gh49qWo9WvgKUyad+0MHrX0GlE6zuWGTh0EU/FMwQtsFlGhLHdF1NocF7nxDsMCp8LenP6HlAeLu5fVkxBr38hfoxjduF95x1X5iluO6VWEc5WmEDd5wTxFQd4ZJRtSPPLmKdoQgIOVYf29Ir/6WclI6B8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF9jR8XU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746447058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AtQm0nKCXqWUQctCIsxIFw0cZn36nlmWf/6lJLm+ytU=;
	b=FF9jR8XUcmoo8s0hIJr81xHR9GxCPBDGSUFtX2x+Xa0szsKHDWnYMj5iBjn4DLw0tDuJ1I
	6i2mM7DOeE/NdR2dgWfAX4f3aLmL61hUdMsMEV2HGHuKO1VIBpNp1wvzuIY2K1kAg3brKP
	BflwQzTeFhUGTP7WAi776jXHN7PmYVw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-8FQ6hJdHPyiZASOVPJiWcw-1; Mon, 05 May 2025 08:10:57 -0400
X-MC-Unique: 8FQ6hJdHPyiZASOVPJiWcw-1
X-Mimecast-MFC-AGG-ID: 8FQ6hJdHPyiZASOVPJiWcw_1746447056
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso18260455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 05:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447056; x=1747051856;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AtQm0nKCXqWUQctCIsxIFw0cZn36nlmWf/6lJLm+ytU=;
        b=ZahoRGwMxp0NxVZCMdLeqB4mc8CbcWfPsriGuy79OJjKPeH+5lv6FTFUDTDkZO2Gro
         n65hEohvNTsOo4tnMe3P+IZuvoo9jJiOD0saumq64IndttI8aj4FbjVm7zZCC8OuZJ/5
         DGXI20YUAcWM4CgxrX8Xwn22RmpGpQu9RAUjGBBs8Qql4dHGRAbxRCq+uLDC8419wJDa
         EVUqoWOC6U7VgPEPdecm6fWvXg6lbKl+FrZ5NW9IqoeqNmiar6SEt7ZZslT4CwRn4dby
         +SghygmOyHVyDfPiqFxVedq1dMhwlsb943I8XnKb1FePLwJoIV3y5eB3rtHMqBvsnHIE
         V3YA==
X-Gm-Message-State: AOJu0Yw/MBp9CnwElKsr0sv7p8y1CL2ILPlp/B5QL8E6FeFrDSRWSpt7
	blxR08/y8L3eQcErVhZxNRMy00j00gcQHmISf4wvqUQ7H/oFfugdaTzAz23wwsl41fgLiUlx6p/
	vziKIopaW9FvQCEZdVoyiDRzsLRo8RViJMULMVmEJxYY0Sz4YLh3Ul+5YBMaTQA==
X-Gm-Gg: ASbGncvpsCiVmFW3HVGDDlMVp2iv6hf5GdmycPQzl4f3IUcL6xjte2JuPX1kuBhMny1
	Q4z6CRhMvJ2fkWKug4caYGdzV+UISycqCzgTDOMjjhCrF0qi5o+1PP4OVCc3QtBYtBAmUs5wpHW
	oizlchiGMlu9D+96nejFXzzKQqizivWLYMA2h/pwEXs6H+J/pHtm70GswAboXgXZwJQ2/UIGgVF
	N4EqzxY3v6mBuG2ASZvIXSflxaiLty+Mg8KNkMRlbGY0qGPKK89gYlBIhUOlwJuINfEY/FVmDgE
	34cnC3M6xyoGZGOy8CM0TOvRt+RxBAAl3IN2Jq06Wccfjg7ReqZITd/DfNV0Vm6oC9+CnXDr5Ij
	b7kE7s/aRaholxmUVF5eBHzl6Nw8AM/sojUteS+w=
X-Received: by 2002:a05:600c:1987:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-441bb88d49fmr106652255e9.11.1746447056157;
        Mon, 05 May 2025 05:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwOVCj9ArZhf/ZRWlo2Ca5VMFb8MLtytsIIBztQOJ8g1W3ZlOSIFXQi8rsgDe+/5Pluuj8pw==
X-Received: by 2002:a05:600c:1987:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-441bb88d49fmr106651995e9.11.1746447055805;
        Mon, 05 May 2025 05:10:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc387sm134622585e9.4.2025.05.05.05.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 05:10:55 -0700 (PDT)
Message-ID: <4dfabfce-8fe4-4b54-860c-e873fac12b8d@redhat.com>
Date: Mon, 5 May 2025 14:10:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] x86/mm/pat: remove MEMTYPE_*_MATCH
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-10-david@redhat.com>
 <fe80481f-6fa9-4148-90b2-65734ef259ed@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <fe80481f-6fa9-4148-90b2-65734ef259ed@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.04.25 22:23, Lorenzo Stoakes wrote:
> On Fri, Apr 25, 2025 at 10:17:13AM +0200, David Hildenbrand wrote:
>> The "memramp() shrinking" scenario no longer applies, so let's remove
>> that now-unnecessary handling.
> 
> I wonder if we could remove even more of the code here given the
> simplifications here? But not a big deal.

It might make sense to inline memtype_match().

diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
index 9d03f0dbc4715..e5844ed1311ed 100644
--- a/arch/x86/mm/pat/memtype_interval.c
+++ b/arch/x86/mm/pat/memtype_interval.c
@@ -49,21 +49,6 @@ INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
  
  static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
  
-static struct memtype *memtype_match(u64 start, u64 end)
-{
-       struct memtype *entry_match;
-
-       entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
-
-       while (entry_match != NULL && entry_match->start < end) {
-               if (entry_match->start == start && entry_match->end == end)
-                       return entry_match;
-               entry_match = interval_iter_next(entry_match, start, end-1);
-       }
-
-       return NULL; /* Returns NULL if there is no match */
-}
-
  static int memtype_check_conflict(u64 start, u64 end,
                                   enum page_cache_mode reqtype,
                                   enum page_cache_mode *newtype)
@@ -119,14 +104,16 @@ int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_ty
  
  struct memtype *memtype_erase(u64 start, u64 end)
  {
-       struct memtype *entry_old;
-
-       entry_old = memtype_match(start, end);
-       if (!entry_old)
-               return ERR_PTR(-EINVAL);
-
-       interval_remove(entry_old, &memtype_rbroot);
-       return entry_old;
+       struct memtype *entry = interval_iter_first(&memtype_rbroot, start, end - 1);
+
+       while (entry && entry->start < end) {
+               if (entry->start == start && entry->end == end) {
+                       interval_remove(entry, &memtype_rbroot);
+                       return entry;
+               }
+               entry = interval_iter_next(entry, start, end - 1);
+       }
+       return ERR_PTR(-EINVAL);
  }
  
  struct memtype *memtype_lookup(u64 addr)


Thanks for all the review!

-- 
Cheers,

David / dhildenb


