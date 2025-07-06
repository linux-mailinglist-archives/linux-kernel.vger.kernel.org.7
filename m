Return-Path: <linux-kernel+bounces-712813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BABAF0F51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2115443BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2C23C51B;
	Wed,  2 Jul 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyNTHONS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAA242D9D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447518; cv=none; b=gYLnVzH3pY0K6+0L0SDQ9dynwb2ZhfA7nfwoqLMom4QUuTi5zmcwRsm9xVbZkwU6Ns3tt1cMy6QiRhLY4yDjdurXaz0nI7yTEA4SNUEl8emuBEEcEmHJfFCrbuxrCKkM9cmnXVH1p4/pcgBnHwbkXImcy6ECYCDDQjUt/sTNK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447518; c=relaxed/simple;
	bh=ipWTeGzPZ5+sq4Tg4m1KScf7BGU/ry87YIYo/Wyv4y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIOzumxvzJQ5Y3kWuAF3tPJlZAijnTDjFg1rr8Pxw5ZqNnxoIDn0TtF3xx397IJBRbKa0Ac36xrvmlMKKhJLp/QcUAbRHlz+vkkkyDvoXf4jrelYhwG5JiTMnlm1IpR4rSdMUgRV4AtF02fWtpjFCtfpFmgR6qhNfXa9iGGTV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyNTHONS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751447516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=62Zzpb2RUsi5oBTd+24Itzeqz/d4TrBiY7iQswDRQGE=;
	b=hyNTHONSqxJQMp7q6sjIRFw+HmpbU2upivrxACCanE6VOG9w04i426EGpXKWSHJkbBDGXI
	hxAxXndd1xyJn/IZMH4y4Y2jz76sawUug2QuctrMixG1WfHRrFqVG/MLWT0JqoVHkBhadu
	tSrN9POAV+qIYXvF6bdbjK77JdKga1E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-aFTzcChMML2n9-JaKS3HXw-1; Wed, 02 Jul 2025 05:11:54 -0400
X-MC-Unique: aFTzcChMML2n9-JaKS3HXw-1
X-Mimecast-MFC-AGG-ID: aFTzcChMML2n9-JaKS3HXw_1751447514
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450eaae2934so30429745e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447513; x=1752052313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62Zzpb2RUsi5oBTd+24Itzeqz/d4TrBiY7iQswDRQGE=;
        b=H8eqjBaHu1oAywVEqq4l7/CstBx9VjKgnK02lTRWEn+WvGLodCUJISygpqVG8oGg23
         0f9kV6KzpciKQqOkLMpZmTWILFgUvWLQ4kT9ktl+cCc6h5P6PZuMu2/NQ5avs9kC5zBg
         PjZiPcUMdGzV5S1Rf9AMtSJDtqBREqsl5o6PtPl06/fp7WYV1W9cS4dTW4c0SfoJRxOX
         19xnV1EERy0Vom3m8tj38c+YoE1X5GfEXanObiU+/aqY+v0nKN8MYvzbvyfPcRcg2xyb
         uClNYGNCQFjgE2hRY+ZMlCwTeDWbOnIjWIMII4ddJ4/2OFnWT8JHSwtKBCK/Qdl3Zw9V
         Zv5Q==
X-Gm-Message-State: AOJu0Yw91e/Rhhlj37+GucyZ0TLHR639hOF0FukAIafltUWXJV5eYjK0
	Efj3NBDzrzwf5q9G+WPkAt01GhiyetWRbtpKqSjmOMMsTZ88rP9hBK6QZB9XiCO104YrX4+iCeT
	AnKT6u7LbH79aiw+dqIRgXzjJuDIU6o0LMd7iXOVUdESQYcjHAXTsKoivgh1+AQ8+ew==
X-Gm-Gg: ASbGncstJ+fx1xFQzl49jvfUZ4CqLbIQFnA48U+X7R6z/AYFPW/9KlhDZsgCj5u45DL
	WuRhFdQkwo7PBvDTHc9Bzc9b3+exK/mMJUdxm+kFw0edtqUsj8H5/aVUidShncW5qHgGIn0I9eB
	04IKgqCrFxChkeJml7LWGEqFSoJOdM4ZhUgnmu1dKyLe0n3BTWXzg2zoYKXRyp3rlnJqNddXbP/
	MQbKYnTHDk3rB7m6f3bIHH/6z1rRqtwwxVeEakIrMYmYkytPEBAA03D3/evz2rvqMLgFinZnz65
	qfBaaK1pDpW92Br8rVe2zlHWrXhvElYtpQZ91l92QyGHaOgXRicbOqE=
X-Received: by 2002:a05:600c:8412:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454a3725754mr21092025e9.23.1751447513582;
        Wed, 02 Jul 2025 02:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzP2JHnRi6kN5iGc6AiXQdQMlXdPAAul3ZbqMJrF9Yf88smOIZtQVd53BzFQnxqXkkHBfhCQ==
X-Received: by 2002:a05:600c:8412:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-454a3725754mr21091655e9.23.1751447513151;
        Wed, 02 Jul 2025 02:11:53 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c05csm222619535e9.5.2025.07.02.02.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:11:52 -0700 (PDT)
Message-ID: <44ecd672-2a74-4efa-a829-37768b75d401@redhat.com>
Date: Wed, 2 Jul 2025 11:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] mm: split folio_pte_batch() into folio_pte_batch()
 and folio_pte_batch_ext()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>
References: <20250627115510.3273675-1-david@redhat.com>
 <20250627115510.3273675-4-david@redhat.com>
 <aGT1s-32GpVfVZNU@localhost.localdomain>
 <17777b93-41f0-4943-963f-0330489b01bc@redhat.com>
 <aGT23D7BBFNXyykW@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGT23D7BBFNXyykW@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 11:07, Oscar Salvador wrote:
> On Wed, Jul 02, 2025 at 11:05:17AM +0200, David Hildenbrand wrote:
>> Not necessarily inlined into the body (there might still be a function call,
>> depending on what the compiler decides), but inlined into the object file
>> and optimized by propagating constants.
> 
> I see.
> 
>>> With this change, a single function, folio_pte_batch(), identical to folio_pte_batch_ext
>>> but without the runtime checks for those arguments will be created (folio_pte_batch()),
>>> and so the users of it won't have it inlined in their body ?
>>
>> Right. We have a single folio_pte_batch() that is optimized by propagating
>> all constants. Instead of having one per object file, we have a single
>> shared one.
> 
> Alright, clear to me now, thanks for claryfing ;-)!

Will clarify that in the patch description, thanks!

-- 
Cheers,

David / dhildenb


