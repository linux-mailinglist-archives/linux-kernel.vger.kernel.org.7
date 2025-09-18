Return-Path: <linux-kernel+bounces-786688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2858B362E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AB646686C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77C342CA3;
	Tue, 26 Aug 2025 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn2ZGpIK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111A268C40
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214096; cv=none; b=VB6+uUwwL4609R4yE0U5Vwx7YvcKtEhod1qsHPSgCqmoH/mHC4Vp/aiHpEuBz9ysFghF7VvgZ29qe82W2IAGB2VhuKVsHW5/i1qo8UwXEkfyP04zOrBCY/XuwZrmGBTJpmul/wzSkiqcp1JE3hUF7sk91mxo+xegqhudzNsqZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214096; c=relaxed/simple;
	bh=L+LzgLb6aTuekSlRz81/Ln32QRo9sAcV0mQS+/UxQ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBs9M3GBbHREnzLbh04NOcUc7FYAp07QRNE0OpCBUPooYuwLnjOSwTN98f0bYqy0kbwZ4l44B/0HZFrivhhyHnu5oukSwJga85VT0uTLvBJwjddDeb5+6EN4tbHGhFQIOWQ0vSwx+rILaIqyP24N1qrQk0Z5QqTZcvTh1MTOu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn2ZGpIK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756214094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h4qLg0Z7RJeXZ+liB2F7ZceD3X4eKwxABDfUe0psFqw=;
	b=Nn2ZGpIK+DaiBP1HFDasRl/CT14T2SMrm5F2HFrC6Hv+zFw06gvWKcMOX57z1g9fAO4QGG
	VOuzQoeZEGjNIvDL6UwaJko0KAZl/PhqBMe2uNLsIDi2cEGKP6nR4DhWuiSKwoqyVfUYMd
	TRUezGqsoXGtdoc4RwBt/p5jov1Ckvw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-L032a70mNlaZXeGiVw2nrA-1; Tue, 26 Aug 2025 09:14:52 -0400
X-MC-Unique: L032a70mNlaZXeGiVw2nrA-1
X-Mimecast-MFC-AGG-ID: L032a70mNlaZXeGiVw2nrA_1756214090
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9dc5c2ba0so2143352f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214090; x=1756818890;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4qLg0Z7RJeXZ+liB2F7ZceD3X4eKwxABDfUe0psFqw=;
        b=t9I0zkWv6FPSkp50RZCBysEyCyzlMbegZzs8UeO9+K44eHfd0pXuIY5F5eEqpL57qf
         AZfwAJCxNAuIPcbsc3R+udZ5kfNYmHYsx+joym/dNzj5bo/pgiadogu3WhRciuN9X4uV
         LQXREzHus+5d431Af5F3cC3GDU3A4M2CLPka6rDFUs6eojFtJ2h+Ph6bPkX8LhgPDvlk
         Fb6oZCDKZuiA4Xx45rxa9kCvCAo+eXmZ4JUGOTgCLYW2f19LowtlPnlTIZVk1Ng8vJdQ
         bH9/gfHkAqOEudpXF8cU5BITTbOo9EkSPVe2AVUF+iB+4mkdwTCyEoaxslfpfcrnKUaf
         Oyyw==
X-Forwarded-Encrypted: i=1; AJvYcCWHfkiQC8aBUTcJSKdWp7ZNYDK5OwMSEhGRdAbyNQq18l5P+/spVi8i2H6+B8ZK/iQ8X6oas0+F/XQv6SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYXWRUIS5yDTY52V/pX41CAcspL8EC9Y2X++/q6xAdjYilbGn
	6JWx+bFVD2DieVEA2M8DqQ7fn5rWveYdpqPF/dHLmKpODSE5avlcyap5I46yuRJyA1TFM3VzoZB
	4DAJgrxTlB8u6QVH7gPKB4cZgiWW2XlAr82KQX2EUSMoopxvFVpVuWO9CjqO1vpd5FQ==
X-Gm-Gg: ASbGnct36VFJX2IU9ZOpy/q8dxdEMt5F8EM1D7A2acrtYAXTUaBJVZ5mWO22kzqnFsY
	xQRJeP6NOZOJfH9G8M+qnG2eeQXlbYI72Y8Hr4V3RoPTSv9rA776ta4G0SHjKsSnq3VOpICPk/c
	o60+cmdh6QAOEQpPJ25pusCUj6vFqBaFWh7hwlGDHPc9G4AL+3cR7lvogD57rh1IY3SVRRXscW2
	zC28dZNbFGz1i9hs9FZskyLFRyJvsIvMDxJCHp5T1aeB1NY5llcsYnvKgu/Qfq70fAV62FdDAa+
	Tt5r3mh00hlmrVSjffa4TMCFerJJ0XQP+CJWuG3fPEwOebi8aw0V2wEaiCPVSPQ2WA0GLFNeaw=
	=
X-Received: by 2002:a05:6000:250a:b0:3ca:3b3f:ecac with SMTP id ffacd0b85a97d-3ca3b3ff253mr4644700f8f.51.1756214090238;
        Tue, 26 Aug 2025 06:14:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBxiix9EiCqvJBpQQjXaUA1N0jkH3xcoDAAfi7RmH608N/z47kGY7AKF95A+U1U8bw2sBezQ==
X-Received: by 2002:a05:6000:250a:b0:3ca:3b3f:ecac with SMTP id ffacd0b85a97d-3ca3b3ff253mr4644587f8f.51.1756214089584;
        Tue, 26 Aug 2025 06:14:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef55aabsm15821870f8f.23.2025.08.26.06.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:14:49 -0700 (PDT)
Message-ID: <c0b20bf5-5224-4aa4-b76e-22c6826c3632@redhat.com>
Date: Tue, 26 Aug 2025 15:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set
 to 64 bits
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 17:44, Lorenzo Stoakes wrote:
> Now we have updated all users of mm->flags to use the bitmap accessors,
> repalce it with the bitmap version entirely.
> 
> We are then able to move to having 64 bits of mm->flags on both 32-bit and
> 64-bit architectures.
> 
> We also update the VMA userland tests to ensure that everything remains
> functional there.
> 
> No functional changes intended, other than there now being 64 bits of
> available mm_struct flags.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   include/linux/mm.h               | 12 ++++++------
>   include/linux/mm_types.h         | 14 +++++---------
>   include/linux/sched/coredump.h   |  2 +-
>   tools/testing/vma/vma_internal.h | 19 +++++++++++++++++--
>   4 files changed, 29 insertions(+), 18 deletions(-)

The vma test code duplication is still making me sad ... but I'll get 
over it I'm sure.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


