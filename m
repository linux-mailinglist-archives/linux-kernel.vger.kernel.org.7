Return-Path: <linux-kernel+bounces-861106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA738BF1CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D45FF4F6ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80325322745;
	Mon, 20 Oct 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2UlWDd3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365F322C99
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969958; cv=none; b=GC1s6jQHVg7KdLnzycMRU+CMFo1LB+E5JWK7++y0ucf5N+KiU9YVESKZNLj5AKKk+22oITg55ifYtYy6+HFc+PokjuH9n0YDr5W/Q8vdrorGvLfEncFpeK4/6L489vDtZn6ZxtIftlkUZSH5VvCOK0O0kHJMvC73znoxdNeZzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969958; c=relaxed/simple;
	bh=S+9U8PTCBE9u96MJ7rHIGGP+OkXXpmWO+rYNaz2InCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qy+7X6ew7oPkA5PAxbN4ZekPg8Ybe1u1f+Xq+S6LJ5xg579EJEsnqIWjuZQ/mAQ2jNcq81KP7pbyNmHGw4tVDR2KsJSFmItLiFZmkDqY7jAI75mlZa20zymhesQWMcRNw+jt8utyX8tE0eNvV1vURGZTg8DxIaK69LgRyfF+Ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2UlWDd3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=65btNgY1S+uFcA06CrNMMM0YWdZBYxuJXH6kRyOL5H4=;
	b=F2UlWDd33yHk3Dq9f92LIjJbSVW3FLaKBgV4Yr0IvAyuRk/rhUCU0ERgBnGyBaJs/0JhnO
	ZEQjHl6PuPtuRyGuJLydhi4rhmrRSET9TLu6ev90fbbqbXIeXnx2SUKC24TUiDvFYgjCDz
	oL/5rHZIivYiTyb5tKZ5HQPyna/4a00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-ddQgKda5OeKDQ0FNIABOoA-1; Mon, 20 Oct 2025 10:19:14 -0400
X-MC-Unique: ddQgKda5OeKDQ0FNIABOoA-1
X-Mimecast-MFC-AGG-ID: ddQgKda5OeKDQ0FNIABOoA_1760969953
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd49f185so36913985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969953; x=1761574753;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65btNgY1S+uFcA06CrNMMM0YWdZBYxuJXH6kRyOL5H4=;
        b=Owg7/MG6Pcd1b85E3nLlTmiZAH7fxbQmLuqVWPVg8VmLE0/1/yYMv982/e9IcuxsPO
         nSAPFCipYAuyyN3r4HsThh6V9r3mwLdaFarmr5v5S44aBDTOSgJb8cjy6NTbxTcqkXeZ
         1+phFmZinq92QNbdo4pk0Y6KHBFdUDOakmE4/d3nxIQWZ474utgBzIKewgWF7E5CfQ2Z
         Gunrg8bZsotie3IxjDF8s/n9Feq3UHRVaydR5rW3f3qTNDk2pEb8vpvsCZcBEjIk0NoG
         O/bbxyCZkif37XfkAmSQ8ZUUDPANwmp0bY08Q4x5YhTKRpdjahS/6DfsjNNyAxcCbULq
         CsLg==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ0vAs1t0ZYFQ1G2eSp5wAvXfT7/U0AwhXAap4TFMY3t19Jl9yJL5ASei31UAqrmjhL43Sn+4cA72mtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmGxz3yvLl7GZuD2Ias4arf+Ucy82n1c2lT5UCv1DbTtGq2u8
	SliMtWrCeMemfwtg7/uVIrurrG4upevwGSlczqqCUXygDoUCJGf0gR7oVBe95pEtLAu3XHu8TY0
	NkXTbF1bx7KCUNDgHtmb2G/Eki2MNKD7x1pFB+BxSiYxrtjYVgfN4T/J+0y+KGfJIEQ==
X-Gm-Gg: ASbGncsG6QIrvuLTSz1mSXvwMelgXb38nS/JMT/XomeP6EAnbVmAzfF+TDR2no28RpA
	3bqzYglvuWS7xyCraIrjHfb3HMW+DIFL3XZm5me4qvdlwUivelgX0dMOORDO8eS8VWOOW2AS3Px
	dAoBv92cjJh/El5QXHKAW+hw26PNmu+DfRQvpaW81moi5tv65LTCtzYpn1uCOHArdKzR15M1rnk
	Zz6EegwFwBzSp94D1yiVjyiwJFRR7+fVRu0hjpePss6Ol8TwB3LPu7r5x+qxac2Wsu5/8qault9
	m8C+y2sJTxbLsGQKnihdKOL84l8yW44ya3eQamSekN1N5n0yjxFlDeCQ1hXVG/jOwjQs8jB29+p
	8wQR0c5x/z7FOH/dDOyUHxXIxJ0m5gpJ+e+cGW1gz7HRuywGId6/ftR6yyH1G1j3PXBh3U8FJkh
	7mIAeEIbZRmVl4SPMsWRm6QSdPCM8=
X-Received: by 2002:a5d:5d02:0:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-42704d9b22amr8367713f8f.43.1760969953320;
        Mon, 20 Oct 2025 07:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIQ86tVQBiVUCtXtty92ZgvqJuklg1r9FrAW/HfWuTtSRsNtewiudoCqYJbGF96Hka/1j4mQ==
X-Received: by 2002:a5d:5d02:0:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-42704d9b22amr8367680f8f.43.1760969952867;
        Mon, 20 Oct 2025 07:19:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm15752758f8f.5.2025.10.20.07.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:19:12 -0700 (PDT)
Message-ID: <dc0587af-5054-4da0-adf2-20aa5a10d40f@redhat.com>
Date: Mon, 20 Oct 2025 16:19:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mm/hugetlb: Support vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Nikita Kalyazin <kalyazin@amazon.com>, Vlastimil Babka <vbabka@suse.cz>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <20251014231501.2301398-4-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014231501.2301398-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 01:15, Peter Xu wrote:
> Add support for the new vm_uffd_ops API for hugetlb.  Note that this only
> introduces the support, the API is not yet used by core mm.
> 
> Due to legacy reasons, it's still not trivial to move hugetlb completely to
> the API.  But it will still use supported_ioctls properly on the API with
> all the implementations still hard coded in mm/.
> 
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Acked-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


