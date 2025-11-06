Return-Path: <linux-kernel+bounces-889397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E225C3D740
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5072D4E7E29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CA303C91;
	Thu,  6 Nov 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPCZRZZA"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCC29C351
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463149; cv=none; b=re8/7LJfNpZKOYVAYDGils2eZqrTxBFafKGAqr+yOPFaTqX/C9B+vkJEA0UjpqvIvLX/LObPIJ+Go3L8cCl7kgFicBqh9JJZyOAkgagX9MqbeO1axMB7bk1G23eoCl2pJMUgiGJ/KYl3eWojM9rgkqMz/+69hYdBptGLH0PP1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463149; c=relaxed/simple;
	bh=tFs1YSs6vaG6b04Rbtv82NnFm6uU9OnzMGVU1yUjXcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QUP1eih+YLnlg/8Bq+PjwI11yMM80f5vg21HsKj/lQRn9ujXSIulgRpytlnq9qCxklUoNRPuunWC1ISED3FMFzwrZWMlKYFuFZfAtJgaJpTw3qblv86EjF0vwbbMvRDwyvUvWy1F5d+ONLi0AbF7eJeCbasaiEoS/YtiroeskG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPCZRZZA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426f1574a14so36400f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762463146; x=1763067946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q413bhrhJwOAVLfpt+EjMm9+VisP6PJcOIixFAEVSFA=;
        b=YPCZRZZAH4/EHhxzBVoYL8dqlqHrIEdIbXzrf1SMyZA+9TI+EtUx9NGxKuGVa0hHWc
         ve/ArQxmSbVK7rkPtvbunvnhxYpANpiIWBmAkQ8PfzeuigiRBPNO/s/0ESq5y4/jNdDa
         R6kV9LbVPk0PbxwtfC3H2imBoMXCkhkVR1m6IMGC5uV2Fq9Z7VQoiN45Gtp+1k/89P8W
         z/zuKClYt9TOB9WQsh8MgQ1t8CDleS/4gK0khMiLZWwrFRjpv+ktebJPpevhehcOi77z
         Ar8nx1h5+g9jutddQwkeH6wz8Bih7tRp5jYOy+644E3ET1Q14RSSHBICIodjl2SWPM7O
         Y2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762463146; x=1763067946;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q413bhrhJwOAVLfpt+EjMm9+VisP6PJcOIixFAEVSFA=;
        b=WOwJjPuttJ7KcteB8Fv15oCHscwNiAT1BByPrgvux7skU3nxPHirapB8weWICeYKl5
         e8atVPDZcSCDqLy2ZbJU5E2WRfVFDVeNe/Gjitav9ScizR0yBxlVOCIjbE0A+YUHDW1Z
         E9xgtm985IIYqGPCbPmjkr/p3W55Mfl3uYFnXLcbd3sKonQijVjgNcdqy56I8hC+ukTJ
         PlwJ7ZVvSMkuCxQ/DKTZC2Fte7/ODwxVBn89VXxSErDUKwyVX8G6T8ULeIWUjm7S3r4h
         jvTgiDlrOksePwOyap0yzlpYqUov70hN+fqSL6QGexJ8cHU0w/eqTe6WTrjpHtW61oNE
         /cTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXh/40iuK/G7lN5TcJkc0oqpH53B4V6qcvi3Opa9VvzYRjGsvhXcraj2KJI1FgJUjPSur5/lfWpTqOXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4GLLv96YFDqTbWG7KTJND+0btOu7M6AA67+HOiuUtcIs8L+T
	e1VIRSM1FmBPhXeAevBuyoCpH8lHdZcQ1ARuerRXrQizLc+NEQD3QwvJ
X-Gm-Gg: ASbGncu/boMkwTVpw2fXLBpGRzG9JrLHA41x9Vw3OSgKZwDxhmTavannQ6E3CSnTS9J
	9MRS3Jh4i1n9cUhfGvvNMjcw4reAK4fZA5Mamp9BZ4aDNm642gkumsiCCaS951Q3F5tVdngRuiP
	IWoWb+skdd/NFPg3sz+cY/ZScENmfeqh1FMeTMVHln+iMZ67fIHNZH1QWOF1+AWhmT1sZ3b84Hw
	DHXrZxSc7W6WyJGm8Jkr6IYN/jYiPAJ2I/ad72iCs9NRuQOqn+lFejdU6YGRVWLO2FJrX/p60ve
	zyQmc2sSR4altoi9Z0zWNYjVpUxnwKxs/wFTG6sw7psHVD0KcMYAGYPlIdTMtkJMYGLgag99j3D
	Iquz/pO0sInX/nDYlH+sQuuP1mtX5c4WTYjh4t/xxbuO8BDg9dTUFG5WzhLmr1stivcuagfbeWh
	oP5tXafYvK0XV/1lLrNoiX4q4sxPiIAHZqvICHpM8=
X-Google-Smtp-Source: AGHT+IEbAWZGXC2i989InvZLZeR310/TSzIZgHH8Ye/jSaLz4FLCazBpkgnlp2Vx7xAT+bFkyoZqJw==
X-Received: by 2002:a05:6000:430d:b0:429:ca7f:8d73 with SMTP id ffacd0b85a97d-42adce35cbamr566921f8f.26.1762463145942;
        Thu, 06 Nov 2025 13:05:45 -0800 (PST)
Received: from [192.168.3.141] (p4ff1feb5.dip0.t-ipconnect.de. [79.241.254.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b1e3sm1217619f8f.4.2025.11.06.13.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:05:45 -0800 (PST)
Message-ID: <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
Date: Thu, 6 Nov 2025 22:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, "Garg, Shivank" <shivankg@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, zokeefe@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.11.25 18:17, Lorenzo Stoakes wrote:
> On Thu, Nov 06, 2025 at 11:55:05AM -0500, Liam R. Howlett wrote:
>> * Ryan Roberts <ryan.roberts@arm.com> [251106 11:33]:
>>> On 06/11/2025 12:16, Garg, Shivank wrote:
>>>> Hi All,
>>>>
>>>> I've been investigating an issue with madvise(MADV_COLLAPSE) for TEXT pages
>>>> when CONFIG_READ_ONLY_THP_FOR_FS=y is enabled, and would like to discuss the
>>>> current behavior and improvements.
>>>>
>>>> Problem:
>>>> When attempting to collapse read-only file-backed TEXT sections into THPs
>>>> using madvise(MADV_COLLAPSE), the operation fails with EINVAL if the pages
>>>> are marked dirty.
>>>> madvise(aligned_start, aligned_size, MADV_COLLAPSE) -> returns -1 and errno = -22
>>>>
>>>> Subsequent calls to madvise(MADV_COLLAPSE) succeed because the first madvise
>>>> attempt triggers filemap_flush() which initiates async writeback of the dirty folios.
>>>>
>>>> Root Cause:
>>>> The failure occurs in mm/khugepaged.c:collapse_file():
>>>> } else if (folio_test_dirty(folio)) {
>>>>      /*
>>>>       * khugepaged only works on read-only fd,
>>>>       * so this page is dirty because it hasn't
>>>>       * been flushed since first write. There
>>>>       * won't be new dirty pages.
>>>>       *
>>>>       * Trigger async flush here and hope the
>>>>       * writeback is done when khugepaged
>>>>       * revisits this page.
>>>>       */
>>>>      xas_unlock_irq(&xas);
>>>>      filemap_flush(mapping);
>>>>      result = SCAN_FAIL;
>>>>      goto xa_unlocked;
>>>> }
>>>>
>>>> Why the text pages are dirty?
>>>
>>> This is the real question to to answer, I think...
>>
>> Agree with Ryan here, let's stop things from being marked dirty if they
>> are not.
> 
> Hmm I wonder if we have some broken assumptions in khugepaged for MAP_PRIVATE
> mappings.
> 
> collapse_single_pmd()
> -> collapse_scan_file() if not vma_is_anonymous() (it won't be)
> -> collapse_file()
> -> the snippet above.
> 
> But that could be running on an anon folio...
> 
> Yup given it's CONFIG_READY_ONLY_THP_FOR_FS that is strange. We are confounding
> expectations here surely?
> 
> Presumably it's because these are MAP_PRIVATE mappings, so this is an anon folio
> but then collapse_file() goes into the snippet above and gets very confused.
> 
> Do we need to add a folio_test_anon() here?
> 
> Unless I'm missing something... (very possible, am only glancing over the code
> here)

collapse_file() operates exclusively on the pagecache.

I think we only start working on the actual page tables when calling
retract_page_tables().

In there, we have this code, when iterating over page tables belonging
to the mapping:

		/*
		 * The lock of new_folio is still held, we will be blocked in
		 * the page fault path, which prevents the pte entries from
		 * being set again. So even though the old empty PTE page may be
		 * concurrently freed and a new PTE page is filled into the pmd
		 * entry, it is still empty and can be removed.
		 *
		 * So here we only need to recheck if the state of pmd entry
		 * still meets our requirements, rather than checking pmd_same()
		 * like elsewhere.
		 */
		if (check_pmd_state(pmd) != SCAN_SUCCEED)
			goto drop_pml;
		ptl = pte_lockptr(mm, pmd);
		if (ptl != pml)
			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);

		/*
		 * Huge page lock is still held, so normally the page table
		 * must remain empty; and we have already skipped anon_vma
		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
		 * held, it is still possible for a racing userfaultfd_ioctl()
		 * to have inserted ptes or markers.  Now that we hold ptlock,
		 * repeating the anon_vma check protects from one category,
		 * and repeating the userfaultfd_wp() check from another.
		 */
		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
			pmdp_get_lockless_sync();
			success = true;
		}

Given !vma->anon_vma, we cannot have anon folios in there.

Given !userfaultfd_wp(vma), we cannot have uffd-wp markers in there.

Given that all folios in the range we are collapsing where unmapped, we cannot have
them mapped there.

So the conclusion is that the page table must be empty and can be removed.


Could guard markers be in there?

