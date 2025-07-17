Return-Path: <linux-kernel+bounces-735924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBEB0955B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FB33B01A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9192248BA;
	Thu, 17 Jul 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGozUMP2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA721E091
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782624; cv=none; b=IHUsPdVw4oe9DWRPiyZiYs4Tlu39vBTxjRGz/Go/RRRfiZz9kyqFfQXvXtUFS0BswFj/k37V04tB70iqE6RN4CLFQc5CjtwZ/UZaS166NnyW4Xd8p2P/4RztW5nKbqif3cKMrxcpGwyBCL2x7cXdfaryPp+ICCmCkl2oEsy3Z1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782624; c=relaxed/simple;
	bh=kS5Viy5yoM0WRSWZYLbKDmo7k8qq97Vp3CijE+dqMwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0iFloEhhjISjcVhk4w7Xstx5znplVV4aa/ainF16SiFH9E9JPLmXgT3H0KWBSp3RAHnNxirwUWBDc+TnZsKh+OVJ8FfGqIuR9to3cRZTQqYwroIpf2Y13e5Y26BYa640QeBRoIl727stRlSduXvvKct4PWsZQ5r4ZY+256qUW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGozUMP2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752782621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CSZKfN8L/0ERKHQsqlu2FqRBrGk9QCkEfK5tYLA4Xjc=;
	b=dGozUMP2QQtTM/4r9ypRJSMGY5QYE3q8QTMJt6h5aKC8rOrzy+QAeEMgHcor8T3SPw2JI8
	TW/yUjb+cg/HGS75txucISqNrlYtjmzVelXVGiOi74cN+vIMfRtlD8a3ho7rTTX/0GhbSC
	A25DHmc12ulFJmGVabn/c/Onao1oKaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-D6xFP5nWOc-yj-y8FjDa9A-1; Thu, 17 Jul 2025 16:03:35 -0400
X-MC-Unique: D6xFP5nWOc-yj-y8FjDa9A-1
X-Mimecast-MFC-AGG-ID: D6xFP5nWOc-yj-y8FjDa9A_1752782614
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso667452f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782614; x=1753387414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSZKfN8L/0ERKHQsqlu2FqRBrGk9QCkEfK5tYLA4Xjc=;
        b=Z3+oLIVcSyjndvjYb+qf2Nm7svYUzP+ciNAHOZaL33AqllEcTNT4s1tu5SIh/U+bao
         5vASAZsbhwy4hn0fFERAnwgYTFkM3tib9mh5eJySXwOp/nB07wvazg274sAwsXnZfJiF
         tej1NVmEEa7h5ALtjpCYq94uwv4aIc0CmWBiaH1/bkrm0Jno5dH1FzxESHMu81Efrhz/
         h5IFQpSb3CitPRNqVX8TPkWuUtMeuHuqVntuxvNOm2S1I+B0rsgCc0GyaDlahk8LW1eG
         Esz2/oxkNl0afYT57HcSAGOfUIcTZmOymcpLmwOMfa9Ll6dZQtfO0o7jpQaOWZlDoVr1
         QK2Q==
X-Gm-Message-State: AOJu0YwrzN5roJoiifuHbtqZbMzpWPrl6sPEykFYZiTUF9fHfblBT+9N
	B/tKc/mQp8/C5Qgq1lzUtsFjfUc9TsBT1DkfRtuQCbdXzD6vslXsv/igF/2f2wpA6QHh1/fjTEM
	liM3YKDFJQqyHc1yQmKbt1JDUMgzy8OCqrVbaXqNIlSbYp3KcMDulE1KJoDCR9QrItw==
X-Gm-Gg: ASbGncuB57LN1qJYFaulprxrh1SWYvDK9etAG/7IWUmY1egiwq6pN1K04UGgOi/TEC7
	hlh6ASV57F7wYNdhtbOlItfEAnoQj7jkfZ6L1+Dbk969SMs2iTNQIxhktnoCgklkqpclF0FfdZe
	bzw2OFa8ZctWrHgiJ46r6hzrCG27YoduqFKms06uGgMmKktO+Vf8REexK/PUFSHJi+NB4zwvXiU
	BgUsqN5/VpFwAz1Hf+lGIjPMhg8FETrrtKQp32iQklhymxBc8H3H+82SASNvjgeoCVGArG/M9FP
	EBDBJo6M9daOwlZxaArpWisQtOXeXupb9U1cxaXOPy2WaIwgZFcbSp1B47YTYOlte9rCBr0c7ra
	qXYGifKgV/gjs4susT8AbP4r80jZLdaRVYddm42c7GNRma8hsXhPraTHrw/B5bkJ2
X-Received: by 2002:a05:6000:288b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b60e51bb18mr6929218f8f.44.1752782613996;
        Thu, 17 Jul 2025 13:03:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPBT2z+AXDtxv9+eyR8YVSWXNvyRbdv0SycxZQdT+eeCP54O43RdRTeaz+QIV1wQXkE+j6A==
X-Received: by 2002:a05:6000:288b:b0:3a5:8934:493a with SMTP id ffacd0b85a97d-3b60e51bb18mr6929190f8f.44.1752782613438;
        Thu, 17 Jul 2025 13:03:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae? (p200300d82f352b00b1a5704a6a0c09ae.dip0.t-ipconnect.de. [2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm21799598f8f.19.2025.07.17.13.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:03:32 -0700 (PDT)
Message-ID: <c93f873c-813e-42c9-ba01-93c2fa22fb8d@redhat.com>
Date: Thu, 17 Jul 2025 22:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-7-david@redhat.com>
 <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> The report will now look something like (dumping pgd to pmd values):
>>
>> [   77.943408] BUG: Bad page map in process XXX  entry:80000001233f5867
>> [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
>> [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
>>
>> Not using pgdp_get(), because that does not work properly on some arm
>> configs where pgd_t is an array. Note that we are dumping all levels
>> even when levels are folded for simplicity.
> 
> Oh god. I reviewed this below. BUT OH GOD. What. Why???

Exactly.

I wish this patch wouldn't exist, but Hugh convinced me that apparently 
it can be useful in the real world.

> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 94 insertions(+), 26 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 173eb6267e0ac..08d16ed7b4cc7 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -473,22 +473,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>>   			add_mm_counter(mm, i, rss[i]);
>>   }
>>
>> -/*
>> - * This function is called to print an error when a bad pte
>> - * is found. For example, we might have a PFN-mapped pte in
>> - * a region that doesn't allow it.
>> - *
>> - * The calling function must still handle the error.
>> - */
>> -static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>> -			  pte_t pte, struct page *page)
>> +static bool is_bad_page_map_ratelimited(void)
>>   {
>> -	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
>> -	p4d_t *p4d = p4d_offset(pgd, addr);
>> -	pud_t *pud = pud_offset(p4d, addr);
>> -	pmd_t *pmd = pmd_offset(pud, addr);
>> -	struct address_space *mapping;
>> -	pgoff_t index;
>>   	static unsigned long resume;
>>   	static unsigned long nr_shown;
>>   	static unsigned long nr_unshown;
>> @@ -500,7 +486,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>>   	if (nr_shown == 60) {
>>   		if (time_before(jiffies, resume)) {
>>   			nr_unshown++;
>> -			return;
>> +			return true;
>>   		}
>>   		if (nr_unshown) {
>>   			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
>> @@ -511,15 +497,87 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>>   	}
>>   	if (nr_shown++ == 0)
>>   		resume = jiffies + 60 * HZ;
>> +	return false;
>> +}
>> +
>> +static void __dump_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	unsigned long long pgdv, p4dv, pudv, pmdv;
> 
>> +	p4d_t p4d, *p4dp;
>> +	pud_t pud, *pudp;
>> +	pmd_t pmd, *pmdp;
>> +	pgd_t *pgdp;
>> +
>> +	/*
>> +	 * This looks like a fully lockless walk, however, the caller is
>> +	 * expected to hold the leaf page table lock in addition to other
>> +	 * rmap/mm/vma locks. So this is just a re-walk to dump page table
>> +	 * content while any concurrent modifications should be completely
>> +	 * prevented.
>> +	 */
> 
> Hmmm :)
> 
> Why aren't we trying to lock at leaf level?

Ehm, did you read the:

"the caller is expected to hold the leaf page table lock"

:)


> 
> We need to:
> 
> - Keep VMA stable which prevents unmap page table teardown and khugepaged
>    collapse.
> - (not relevant as we don't traverse PTE table but) RCU lock for PTE
>    entries to avoid MADV_DONTNEED page table withdrawal.
> 
> Buuut if we're not locking at leaf level, we leave ourselves open to racing
> faults, zaps, etc. etc.

Yes. I can clarify in the comment of print_bad_page_map(), that it is 
expected to be called with the PTL (unwritten rule, not changing that).

> 
> So perhaps this why you require such strict conditions...
> 
> But can you truly be sure of these existing? And we should then assert them
> here no? For rmap though we'd need the folio/vma.

I hope you realize that this nastiness of a code is called in case our 
system is already running into something extremely unexpected and will 
probably be dead soon.

So I am not to interested in adding anything more here. If you run into 
this code you're in big trouble already.

> 
>> +	pgdp = pgd_offset(mm, addr);
>> +	pgdv = pgd_val(*pgdp);
> 
> Before I went and looked again at the commit msg I said:
> 
> 	"Shoudln't we strictly speaking use pgdp_get()? I see you use this
> 	 helper for other levels."
> 
> But obviously yeah. You explained the insane reason why not.

Had to find out the hard way ... :)

[...]

>> +/*
>> + * This function is called to print an error when a bad page table entry (e.g.,
>> + * corrupted page table entry) is found. For example, we might have a
>> + * PFN-mapped pte in a region that doesn't allow it.
>> + *
>> + * The calling function must still handle the error.
>> + */
> 
> We have extremely strict locking conditions for the page table traversal... but
> no mention of them here?

Yeah, I can add that.

> 
>> +static void print_bad_page_map(struct vm_area_struct *vma,
>> +		unsigned long addr, unsigned long long entry, struct page *page)
>> +{
>> +	struct address_space *mapping;
>> +	pgoff_t index;
>> +
>> +	if (is_bad_page_map_ratelimited())
>> +		return;
>>
>>   	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>>   	index = linear_page_index(vma, addr);
>>
>> -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
>> -		 current->comm,
>> -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
>> +	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);
> 
> Sort of wonder if this is even useful if you don't know what the 'entry'
> is? But I guess the dump below will tell you.

You probably missed in the patch description:

"Whether it is a PTE or something else will usually become obvious from 
the page table dump or from the dumped stack. If ever required in the 
future, we could pass the entry level type similar to "enum rmap_level". 
For now, let's keep it simple."

> 
> Though maybe actually useful to see flags etc. in case some horrid
> corruption happened and maybe dump isn't valid? But then the dump assumes
> strict conditions to work so... can that happen?

Not sure what you mean, can you elaborate?

If you system is falling apart completely, I'm afraid this report here 
will not safe you.

You'll probably get a flood of 60 ... if your system doesn't collapse 
before that.

> 
>> +	__dump_bad_page_map_pgtable(vma->vm_mm, addr);
>>   	if (page)
>> -		dump_page(page, "bad pte");
>> +		dump_page(page, "bad page map");
>>   	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
>>   		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
>>   	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
>> @@ -597,7 +655,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>   		if (is_zero_pfn(pfn))
>>   			return NULL;
>>
>> -		print_bad_pte(vma, addr, pte, NULL);
>> +		print_bad_page_map(vma, addr, pte_val(pte), NULL);
>>   		return NULL;
>>   	}
>>
>> @@ -625,7 +683,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>
>>   check_pfn:
>>   	if (unlikely(pfn > highest_memmap_pfn)) {
>> -		print_bad_pte(vma, addr, pte, NULL);
>> +		print_bad_page_map(vma, addr, pte_val(pte), NULL);
> 
> This is unrelated to your series, but I guess this is for cases where
> you're e.g. iomapping or such? So it's not something in the memmap but it's
> a PFN that might reference io memory or such?

No, it's just an easy check for catching corruptions. In a later patch I 
add a comment.

> 
>>   		return NULL;
>>   	}
>>
>> @@ -654,8 +712,15 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   {
>>   	unsigned long pfn = pmd_pfn(pmd);
>>
>> -	if (unlikely(pmd_special(pmd)))
>> +	if (unlikely(pmd_special(pmd))) {
>> +		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>> +			return NULL;
> 
> I guess we'll bring this altogether in a later patch with vm_normal_page()
> as getting a little duplicative :P

Not that part, but the other part :)

> 
> Makes me think that VM_SPECIAL is kind of badly named (other than fact
> 'special' is nebulous and overloaded in general) in that it contains stuff
> that is -VMA-special but only VM_PFNMAP | VM_MIXEDMAP really indicates
> specialness wrt to underlying folio.

It is.

> 
> Then we have VM_IO, which strictly must not have an associated page right?

VM_IO just means read/write side-effects, I think you could have ones 
with an memmap easily ... e.g., memory section (128MiB) spanning both 
memory and MMIO regions.

Thanks!

-- 
Cheers,

David / dhildenb


