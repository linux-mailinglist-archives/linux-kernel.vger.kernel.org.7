Return-Path: <linux-kernel+bounces-594677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1885A81514
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 20:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B7D7ABAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9A4241672;
	Tue,  8 Apr 2025 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KICENr2N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C723FC40
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138335; cv=none; b=LHUQFqmNRnHrSF0R2FruenVuR9VDkwVi0JOTttb8DuNBtYflbooRc9OvSij5MpdJRjhZIyOxMVUziz9sbTbhsVJ82aVqYziH80bECSEFAg0d0yzsFqT8BwAspxmGVNJE45hDg3Qd9O2fgxoSiOWhrt6Om4xhY7zRfhpz/tU+LrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138335; c=relaxed/simple;
	bh=HYSy2sOftqwQaNzUt/b9IHcr6YH6cULAdGjWOLniPyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHG0GQ9RNYbTBFrC6PF8lkQBx4k6fxhWPIh95kJAgSn/3c8mS8IG5sbatqKfL2jlv1EfhLyrIxdKn6NdFuvHdVzmIPxDbvMnSYJa2NFuCQQKj4Fpzt3/T3RzgIzz3wl44GPt+f+04iGjMwSa/Qs2E8VMmd9c/ruRLJZICvfCMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KICENr2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744138332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ee/bs0ku9KaZvAw/oGKbLdjqQXwZcnmqDGoEebH2XrM=;
	b=KICENr2NG9c5esvFya4QSel9jq6L/HlW052Y48aS+6K1GYLb32CwDd1gr6ePGI7yqCQ/uH
	rXyS341oNVQANwWgSmarnD9IsHqWyUp+rsWVoR0Zj8skk/8fB7tml4Pzp3fnUcbKp5ZJPI
	WH0rRyvs9D+XyuJ6y7vy2301FW4dPvo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-RZitewLaNIqVwTuWlzT5AA-1; Tue, 08 Apr 2025 14:52:11 -0400
X-MC-Unique: RZitewLaNIqVwTuWlzT5AA-1
X-Mimecast-MFC-AGG-ID: RZitewLaNIqVwTuWlzT5AA_1744138330
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so38208485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138330; x=1744743130;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ee/bs0ku9KaZvAw/oGKbLdjqQXwZcnmqDGoEebH2XrM=;
        b=lEzTbRFc251oWP37EzUufXMcFQDcnRvLAIRPv9nXoYezcuWa/agsG0+U7xThqRWz/k
         3RzJkCDZfxBc0mmc/r0PsUkjMyWqIuqZY+SMtB7WeS3xmM7CUR9V1Sw0AkF/CampzpUM
         RUoj139D+R/3jpXva6UGr9Fjs7sinNbWL73GFzAABUs0vDrvtZMaoyJok8IYDmDPE/UW
         yk384ZDPZWgPGrrvrpLZfaL0oh6+nlY6N5t+WZu8KQEqXHs/zk6w91nQ0rfsw1zadEiw
         KWNt8ewxE2n5KoZtXpeU8F6SQGOo/F0eyj7INGyylAlk0mJuStU4aSfoMx6kScL3M1c3
         vyJw==
X-Forwarded-Encrypted: i=1; AJvYcCXS2dNh9jZCpesY8xNfDKq27E+DqInQVAqJBRjaV146FC6J+e9GYQ5J338CnHvFmEbNkpXXa/wtRiSFVbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD46EJHQ9LspYiVjieddFIIQJEt0/EL98YxXOQlyXpn3oNoU1w
	ONp05+qXKYoFDoR8d7LHytr/iv4fCgq6k3pyDWjLVEgb1bLH0I9sixkz0QpqD73QC/FvcUU62RO
	N9n1pWAX+Q8ouvj6vClBWw+hGVFV2zNxronIw2ruBrhO2eQcivcjegLUqqrS+NQ==
X-Gm-Gg: ASbGncv6gtCmob2OoMUVRkJaycuC7JCbUufBqonk8HzZX8BHgm50MjWaVlEHciNxMnx
	ttoe4m+OCtfvFjrfE2nnz0j5qYL2oeydo9abwXwZ4crNssmCBitWimfO+8Oe43GBaYAukrXVjE2
	7djPXC3o4rx6BORQX5/NAANGrNngE5X/OrmohB/zRn5a24dQXqpHiqi1F/M7Bx5c0Slz/kElMba
	dO9NpEzen3/Y23ysJRS4EN7I2AJGhPMfE99MHR6vI8UAeI/KZ+iCVSk59sMrPQ/t5Lzcv71tOJ2
	J32CVUKvL6RUCiubqLn3WH81+2oNyPfFsVXwBj8EoHp9duKY/fe6h5E43ySO3yNc9IN6F6wGWM6
	NX6Cz0KQXGbN/tTpLVkULJ0BQiNTxl2J5yowkcWlv
X-Received: by 2002:a05:6000:40d9:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39d87ab73d9mr248321f8f.21.1744138330433;
        Tue, 08 Apr 2025 11:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQu6URvqOmqxm7oexseppX19HTRwqP+yE6xHJa8LtzuQvNdxB/B/3NcY2E5AvoUVsKbbhlJA==
X-Received: by 2002:a05:6000:40d9:b0:39c:2692:4259 with SMTP id ffacd0b85a97d-39d87ab73d9mr248305f8f.21.1744138330078;
        Tue, 08 Apr 2025 11:52:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301acec9sm15544784f8f.40.2025.04.08.11.52.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:52:09 -0700 (PDT)
Message-ID: <71f4bcea-0dcd-4f93-8ced-17b333398460@redhat.com>
Date: Tue, 8 Apr 2025 20:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] MAINTAINERS: add MM subsection for the page
 allocator
To: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, Zi Yan <ziy@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Suren Baghdasaryan <surenb@google.com>, Brendan Jackman
 <jackmanb@google.com>, Michal Hocko <mhocko@kernel.org>
References: <20250407200508.121357-3-vbabka@suse.cz>
 <20250407200508.121357-4-vbabka@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250407200508.121357-4-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 22:05, Vlastimil Babka wrote:
> Add a subsection for the page allocator, including compaction as it's
> crucial for high-order allocations and works together with the
> anti-fragmentation features. Volunteer myself as a reviewer.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Brendan Jackman <jackmanb@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Extra reviewers would be welcome, including/not limited the people I
> Cc'd based on my recollection and get_maintainers --git
> Also if I missed any related file please lmk. Thanks.

Likely we have sufficient R: at this point (good!); as there is a bunch 
of stuff in page_alloc.c, I'll likely do my usual linux-mm scan + 
keyword notification to spot changes in there that I can review with 
confidence.

-- 
Cheers,

David / dhildenb


