Return-Path: <linux-kernel+bounces-773322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF9B29E40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CE83B6BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FA430F535;
	Mon, 18 Aug 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7ScVqih"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96B30F52A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510267; cv=none; b=Zk6fHdS6VpZ4+L6X5gYuNK1c16btUE0A4v6imOMzIWtzvXyr/tZNQHsC2mKFQhPVvO6ydkcbwk1Ag+e549fCtCpmN3Sw49ZU1iLQQu2/3geqH5ANX2jBLbqifg0qJlEkjn6xNEwYNZjkmGwbJXSDzQTTSGvRBshGYxo+tVhC904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510267; c=relaxed/simple;
	bh=T1qnb+YVb+xZXaetJhKFFSmomysR2+OTUJ10wCkWAF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fyO+/nJepGK6kfwyUKXAC1uqouTlr7iZxRkbAeh0FmXhPuHO91Avuw0J9IyC9+Usg9SfWc+fmpBu6TNsQrBk3a2IsBnmdGsrtDMDkSvGMur8SA7Q0BaulVubtW96DyYwFs67CdWD3VtHZ9rbCJQhXlE14v0n640Xvk63FC6IrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7ScVqih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755510264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bO/hi//70PNQS4PRKZk6OCbLR0nHf4/8WHcoc8PRhG0=;
	b=e7ScVqihVChYlcS3KBlWgIt3GtSIvI4+lgTvafy0mnYJDV4v/n1D9qKXLbHN33OnA+dOKC
	04uJBWfJwjWbfMX55YfjQulMlGADccZnR5K9Z7DDxNUXCy8aapV0kvdjFDM5VlpnD9D68f
	nEivh5U1kxWHwwTv8cZFLy1l96JxIx4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-M4JFRWkZPYebjQY7ZHSX2A-1; Mon, 18 Aug 2025 05:44:21 -0400
X-MC-Unique: M4JFRWkZPYebjQY7ZHSX2A-1
X-Mimecast-MFC-AGG-ID: M4JFRWkZPYebjQY7ZHSX2A_1755510259
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso18838275e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510259; x=1756115059;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO/hi//70PNQS4PRKZk6OCbLR0nHf4/8WHcoc8PRhG0=;
        b=WxMNBReXrEhoqtmXBTVIh81JEA1I8shQkM05awlmeIGoTe0CN3ui5GPfAnNSM0dwdz
         I84mnEoEoj0xhgM94lD3uUqaX8Aunq4yCRvB1l+HhwbEyu+JAp4ZFpeQh1m6nx8enup8
         ZDQX+L3tHOcM8lxWx6BaPhnN/6nVDNX5sp7hFkbJCtyeSqsvREP+P5MGoyTd9NNUVXRO
         FVZWD/L1mOCW7oy6j/O5EBtfFCDKJDbhXdTp6bzvnN52xNzdJqL9tlL5MmXUKZCKYAdu
         7IiW5E2B8r8PJ+hEmyHuSxVr4YXQCz6/lFPQnFlfTfd/kyhSUCez6T24HuYEFEVDKB/2
         Dm7A==
X-Forwarded-Encrypted: i=1; AJvYcCX7/twgRvCO7qWl1xzyv6RLOVjBUVJ/qP1mgiTKIvuww9t0mXXkvUkh5BHVsaKF+NmfgaWkhb/y2kPVFOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHY+5j+tmJoaoY4SvC/D4mu1VV+zJTw16Vx8PuH6hmXp3PF++
	0yP4fVZrs1GDCeuvrM6cR6N6HsinlnN6GtXTyvGQ/QlhOdQhIx6juDTFZ3K97EH0dilHzNZH+qM
	KvY74MW6sc92PBiCeBAIPe7reNmPGYWr52TsWvSYj8+PeKH1VQFZMHDEXA6C1jbmq6w==
X-Gm-Gg: ASbGncvOJh6C3IN/+KYyWNMrPRgxelol/oAVxU2Ic1hrwW20PHONcqE+8KkCmkV0IH2
	MGX8OJF+sJs2qyqVLWO5ncf0AkmAGE55P1uRBm1te1iic6NzJYiuN5vl4JBpXZ3bxYAUeS8aMqn
	MEd+z5Hy++nOuvUMFf46Tt8v+O5W0KamkJNEKcYaz4GHdbIfNzmjMfTYG7GRx1EHAM5NTU1fq4u
	nI/mSrU7fLRnwSFiRLh8ElsqNUKk7bsEX/GihhKJHegnx7qf6ld07LLXFct0wKdfkUYntGlg41U
	p6mEYsLiup8lJSn6Jwtq9t9hO4sx8Wz47DD/Uav1YvRIf4svOLmhZsZv8KozHxViT0E2Tmusv97
	Xdkc6CftN8aY2h11Pkb3ygkNKFkMURXPKoHZVjjR0eAQYWQzXR0zlNE39Ii4EgyxJ
X-Received: by 2002:a05:600c:1e0d:b0:459:db80:c29f with SMTP id 5b1f17b1804b1-45a22031cefmr78156955e9.1.1755510259117;
        Mon, 18 Aug 2025 02:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjiMETiwxz6+Sga98bI/im2QTZ4KQOy7MiHPd8ZEIVTObrOWdDHjAMkOKMLStR98OStBvZxA==
X-Received: by 2002:a05:600c:1e0d:b0:459:db80:c29f with SMTP id 5b1f17b1804b1-45a22031cefmr78156675e9.1.1755510258626;
        Mon, 18 Aug 2025 02:44:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a221bbadfsm125147675e9.0.2025.08.18.02.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:44:18 -0700 (PDT)
Message-ID: <3970cd97-2e9e-403f-867a-3addfbe399dc@redhat.com>
Date: Mon, 18 Aug 2025 11:44:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Remove XA_ZERO from error recovery of
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com,
 kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
 chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815191031.3769540-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 21:10, Liam R. Howlett wrote:
> Before you read on, please take a moment to acknowledge that David
> Hildenbrand asked for this, so I'm blaming mostly him :)

:)

> 
> It is possible that the dup_mmap() call fails on allocating or setting
> up a vma after the maple tree of the oldmm is copied.  Today, that
> failure point is marked by inserting an XA_ZERO entry over the failure
> point so that the exact location does not need to be communicated
> through to exit_mmap().
> 
> However, a race exists in the tear down process because the dup_mmap()
> drops the mmap lock before exit_mmap() can remove the partially set up
> vma tree.  This means that other tasks may get to the mm tree and find
> the invalid vma pointer (since it's an XA_ZERO entry), even though the
> mm is marked as MMF_OOM_SKIP and MMF_UNSTABLE.
> 
> To remove the race fully, the tree must be cleaned up before dropping
> the lock.  This is accomplished by extracting the vma cleanup in
> exit_mmap() and changing the required functions to pass through the vma
> search limit.
> 
> This does run the risk of increasing the possibility of finding no vmas
> (which is already possible!) in code this isn't careful.

Right, it would also happen if __mt_dup() fails I guess.

> 
> The passing of so many limits and variables was such a mess when the
> dup_mmap() was introduced that it was avoided in favour of the XA_ZERO
> entry marker, but since the swap case was the second time we've hit
> cases of walking an almost-dead mm, here's the alternative to checking
> MMF_UNSTABLE before wandering into other mm structs.

Changes look fairly small and reasonable, so I really like this.

I agree with Jann that doing a partial teardown might be even better, 
but code-wise I suspect it might end up with a lot more churn and weird 
allocation-corner-cases to handle.

-- 
Cheers

David / dhildenb


