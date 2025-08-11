Return-Path: <linux-kernel+bounces-762672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0AB2098B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212471899C74
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52B52D3EDF;
	Mon, 11 Aug 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0S+5SxM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB32D29B7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917426; cv=none; b=Z81NmDgq1qMy5ekLyIDY7cu8RCA0ASlwflgx/cbkMijShhI7pxhbP6uCBplLxsOV4zjjbzzKa2nHykR2ZkubCUhlDpCQXlVdI7hwRI90cuUVYxXF/ueChePU7+d+rWn/aEtTwvNM4EK80mgHQ3qmwYUFwy6uQinkt73KjE1QFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917426; c=relaxed/simple;
	bh=j7ajyDM5jC+EXlGQXmk0TKqKeHt8Ll4K0aEYjYj2IIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LETAl2nLZ/4uxUEo95/6NVVEszVhw7wcWQMJScm719JEyrfX6rCimafgfLN6d4pwBcbLhiULV2cnt4dl0+KEsPKHuN4iUGkLX8QSLPj+S3tPh9crLk0l0WQJDofxtvEMWvhyJ0WmqnhxNXxUS+ddykY/lzqaEfwHm5+K6PlUhlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0S+5SxM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754917422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l0BtLxYidZI73LQEwOGP96I9gxCnmhJ4MxHYnaXFggA=;
	b=h0S+5SxMcKloA6D87PY0YC8cKjxKQNnDkGqWMCmi4LLWwij7JTHLqrAT/xKwmHlGx0VeFh
	sBlN0kG/A29DiOg7CiLm2J08wg0u3Mhf5qGNv7QLQG16qWJQzd6DG/foSF0jnDb0Kr77fe
	q0Be5imIFaDFehWZ5lkVkngf9KBD+no=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-WXci4hLwMwKg2UOhbzKiwA-1; Mon, 11 Aug 2025 09:03:41 -0400
X-MC-Unique: WXci4hLwMwKg2UOhbzKiwA-1
X-Mimecast-MFC-AGG-ID: WXci4hLwMwKg2UOhbzKiwA_1754917419
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d8020b7bso22037695e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917419; x=1755522219;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0BtLxYidZI73LQEwOGP96I9gxCnmhJ4MxHYnaXFggA=;
        b=kb18mcp18z4x+OlEjd8HLulQ4P4/3xLl+w6fX0m4inGY8FCK0fevvbgSn7VM1k8XA9
         K7s4I55NgjlhZwCN7hKj/E0oCHQEqdI28H3hVKTqkDvgQPUM16YVd3yASyx2RCDRHh9D
         N/2ZD2tOV06IrHW3VTDbZRL9DUc/4siexZfIKQWpib8toRFh2fGfEI8C5rEd56Wz/l+s
         B9G29RG1o/gEaPg10tl5PJwMl3iMJqJOD4M1Eppd7V0TO/HqbK9xOWtSuooNG3+8xInt
         Ky4JlNhv13ihRtPHj2fXFDa22NnBprI0/UvYyVV0GkJA9RLormAdN2ujHfwowdrmPsz5
         0NMg==
X-Forwarded-Encrypted: i=1; AJvYcCV3tn06CD8fQlzKn85jAS+DRgtBrJMURaNjuq6a07futPv/I1Q2U8rMELTk7t9QjT9dQodXvqNqlzmLCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtIN2tKD7eUAbdKj7SRl3uhVpvZYtf8CU+pXAZFUSu1sr9/GY
	O/l93trA6Ex1gC/mVnQ7hu/ErwBbQXOScr2gq7B2eIgoNQETXkp9MjYejAAHjuazogbbyFlz5MX
	K41ZX8Fg0FyNyDfUxqHSzMqDisGdXPnlmeRNgSCJQ45OOzEgUWf2O1S4mMoSeeikeOw==
X-Gm-Gg: ASbGncvINUMyH0E4HGWDDyc/+EARFEh4/YNbvhFm9Myz3tR8HdmxheZAborPsv1P/kl
	XBm1T1ZeoG9onHMf1QwrW5pHprjjVk1iTCcIeBBBPItz9qwOf1Rul+qgLFSkHgbAhOVV5ZiR4lf
	NfGoPeu6ozix/Q0WOIpCWcblKpgrhgZ6sNMUjYwseABCGv0pirf4+v13vQAV7RK2K+UkMoarXVs
	rRnswZ37CVUPSJyyTqhbSokuDpXn7Z5QLDuKW1T/MR3+GSgno5kIWJ/zuNQqwCLCC/g2Z0bUOGA
	sub3uYtZAHuD+q4+t1dSHUL1ssiz5zlhsbFvhnWfi5kfyBlCjDf2TyV820eTQzyNmJvhiLxZYOP
	CZVxb0/Muk35hFhg8pbB5FYD1E8K6sCTvwjCX1Ja/6wIcoxsw9e9k+3aXeKa/kKFU++c=
X-Received: by 2002:a05:600c:310e:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-459f4f0f5c2mr117242545e9.19.1754917419074;
        Mon, 11 Aug 2025 06:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1mfWN2Xjl9R7zfCFKVnCaGu1ndRRL4tr/HVjclyc3vwPmExqtNC2qIKBRYzk0XdbpTd8QiQ==
X-Received: by 2002:a05:600c:310e:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-459f4f0f5c2mr117242125e9.19.1754917418610;
        Mon, 11 Aug 2025 06:03:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0cd2c90sm302174235e9.17.2025.08.11.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:03:38 -0700 (PDT)
Message-ID: <9178bf98-2ea7-4ad8-ad43-cdcc02ab863d@redhat.com>
Date: Mon, 11 Aug 2025 15:03:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff
 path
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>
Cc: akpm@linux-foundation.org, shikemeng@huaweicloud.com, kasong@tencent.com,
 nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20250808092156.1918973-1-quic_charante@quicinc.com>
 <dedf7436-9afa-47f6-b676-88f2dd8b638b@redhat.com>
 <f008107a-2741-476d-9e32-ae9fc0f81838@redhat.com>
 <29e080fd-5f9a-4760-876a-a6ccef33129f@quicinc.com>
 <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <fec5ad61-7caf-4076-ba81-7b454ec7018d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.08.25 14:14, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 03:13:14PM +0530, Charan Teja Kalla wrote:
>> Thanks David, for the reply!!
>> On 8/8/2025 5:34 PM, David Hildenbrand wrote:
>>>>          if (mpnt) {
>>>>              mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>>>>              mas_store(&vmi.mas, XA_ZERO_ENTRY);
>>>>              /* Avoid OOM iterating a broken tree */
>>>>              set_bit(MMF_OOM_SKIP, &mm->flags);
>>>>          }
>>>>          /*
>>>>           * The mm_struct is going to exit, but the locks will be dropped
>>>>           * first.  Set the mm_struct as unstable is advisable as it is
>>>>           * not fully initialised.
>>>>           */
>>>>          set_bit(MMF_UNSTABLE, &mm->flags);
>>>>      }
>>>>
>>>> Shouldn't we just remove anything from the tree here that was not copied
>>>> immediately?
>>>
>>> Another fix would be to just check MMF_UNSTABLE in unuse_mm(). But
>>> having these MMF_UNSTABLE checks all over the place feels a bit like
>>> whack-a-mole.
>>>
>> Seems MMF_UNSTABLE is the expectation per the commit,
>> 64c37e134b12("kernel: be more careful about dup_mmap() failures and
>> uprobe registering"). Excerpt(s) from the commit message:
> 
> This really is whack-a-mole yeah.
> 
>>
>> This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on
>> the oom side (even though this is extremely unlikely to be selected as
>> an oom victim in the race window), and __sets MMF_UNSTABLE to avoid
>> other potential users from using a partially initialised mm_struct.
>>
> 
> But... maybe this is better for the _hotfix_ version as a nicer way of
> doing this.

I would prefer using MMF_UNSTABLE as a hotfix.

> 
>> When registering vmas for uprobe, skip the vmas in an mm that is marked
>> unstable.  Modifying a vma in an unstable mm may cause issues if the mm
>> isn't fully initialised.__
>>
>>> Is there anything preventing us from just leaving a proper tree that
>>> reflects reality in place before we drop the write lock?
>>
>> When you mean proper tree, is this about the your previous question? --
>> Shouldn't we just remove anything from the tree here that was not copied
>> immediately?
> 
> Commit d24062914837 (" fork: use __mt_dup() to duplicate maple tree in
> dup_mmap()") did this for efficiency, so it'd be a regression to do this.

We're talking about the case where fork *fails*. That cannot possibly be 
relevant for performance, can it? :)

-- 
Cheers,

David / dhildenb


