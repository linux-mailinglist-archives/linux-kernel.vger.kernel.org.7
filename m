Return-Path: <linux-kernel+bounces-827680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC825B92649
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A963BDBD6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85262EA72C;
	Mon, 22 Sep 2025 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk7Q+h+j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429E2D7806
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561658; cv=none; b=mGwAvkSBD+J4MQJNkP1HLSXtKMh8ymVrvvaVF4PzuPtSca/kRWOLhMTatxnTV2u5xY52vjNfOkhnSxJkqo4c8t5fH2hSeHS4TCa1e3Jo5b7O5URo/ekLjZyGx65mFQAvENtjcn/mPYaabTsVHZjAnOOsYnFj9/txDpmrokOlHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561658; c=relaxed/simple;
	bh=3nTW3KkTEQzf2dmJ9My7k5AL73WQG7nmkon31oUIzYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR7x4N26VUO5Gc83REUPUa/YPF6IfqnwjAB8LKEfrCQqtS4IUnWe8ijwS2ha4SURkvxMaqHtl3OVY2FXmUpGQldHyju8RrwwGy7Mrc7XwmK5y1kS+LzBwx4dHYDI8zj94iPmencTRX4wqxlm8Ab8rClFtrl+7/gabYXLH6g2fks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nk7Q+h+j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758561656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eLkzTTJCYz0S7akYKEm9Ho7z+dvhxeYlXMKoN34tPxw=;
	b=Nk7Q+h+j0y9AWafpAq60nh5zjll8UH4lkeRuw7Ep2Jjx46ETaodGpLtFD+aMEdXwbkmA2j
	C5vVV3d25qkmy4kodiDcrQKYKmqRxZ0mmmrYukkCO6k0BhY7su2DeY8miCh3v1mZd2GcQ1
	L7K/FvJ/sbQx9qsw5dchvL9dFXJvOII=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ZOQ2z7FCPtuZoeC27xDX-Q-1; Mon, 22 Sep 2025 13:20:54 -0400
X-MC-Unique: ZOQ2z7FCPtuZoeC27xDX-Q-1
X-Mimecast-MFC-AGG-ID: ZOQ2z7FCPtuZoeC27xDX-Q_1758561653
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so37659345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561653; x=1759166453;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLkzTTJCYz0S7akYKEm9Ho7z+dvhxeYlXMKoN34tPxw=;
        b=evafneO3402ZeqCXB9MbgGmpW2VCMhB5bwt12q2cjYQoeANiDve9/unBbnaAYrBRHl
         jgb2WJckt3ET2XJ/y5GNipcqkIBK24O9EiJAR5kfz/fYBkGhDciwMXQGz1nTzErwGaYI
         e9djaaf6+JBdl0yIw35CzPZOcrFot204UpbRXXNOU6rlSF5cBpUY7VNmJkD0xX9sHLpO
         nicjoDcujhY0brvEdaVVfnYa+Hl3gyblQEMQkjcVFfltvZQk5BgsRw9xvICOyrbnROtm
         OhD0Im7cpYkXAxK2pRkG08CeNqJBUQGSi6zR8m3XA3O8IASiWpIh+SOd3z3OGxUkL0Uj
         GILQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxHX/ujpcaqM+xzMN1+EI0IXHOmJCuguiXnAj/SiZBDJXyq2ZXgTx8JPjXrLDaVVVvg0+rcrbkapx0pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt2CX0/w4AEwGdpDP3CJPtFaVFfbfOM/u+7u3p7v7ASKYCi9w
	dufGFTur7xtGDaDrIymx9oZ0BfDNU7OjeIn1ECKNwn3KsusBFGf8tVo5YjvYOFgx6M52EQpMn5k
	QTrq4n03konLpCSmke2rJlmpC+NA4gqkKNRYM34Gz1i/4oa5knGYoqOPAYhg/OYbznw==
X-Gm-Gg: ASbGncuXgS5A0BkKGZ1QbsyD0teRP5cRETzbU3fjyCzq4RhBbU8jxpEwTNX1RBk5G38
	lLWIhHUMVOFRk405yUM4PQFjdcd0JQYEG6+/Zauuu9xn9q2ZXMxd29lf0q4fciQELDuNpiy7dfu
	Tsx9ZdCzzkR6v9OzRlVaW1nEOD7iaiOXYhJO97DHK0PSlkI7I/9DdLDHMkcnAkKutTbVJf/d8nf
	FyuVOZxi/sKGX7Bkhl5XH/2Br6uIRomFYReDQ79KZHsgSkqLSHnnbrVEE861W6BsxhtA1WeZ9Ml
	lRUkTHfIIn/Mrj9sZj6mgGLnzgz/pDUiMBaK7fnInbdehcBbf3nxlikqsIM+xl2bzfY7pjAHFXH
	3xLt2X7XRQ904DTrZ/METn1srSUgdKXEbSRiLi9UyRrMHWY06oOkp9/7mFurgBhA=
X-Received: by 2002:a05:600c:4f0e:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-4686ef84790mr131223775e9.7.1758561653325;
        Mon, 22 Sep 2025 10:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz9q9s0IUnjOjMxVJn3jUACO4XmXNV1b0nQZiphPuMzMbWxDcUmCY8o2I+P9YB6nyWPSm2iQ==
X-Received: by 2002:a05:600c:4f0e:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-4686ef84790mr131223545e9.7.1758561652874;
        Mon, 22 Sep 2025 10:20:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm275273325e9.12.2025.09.22.10.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 10:20:52 -0700 (PDT)
Message-ID: <6a6c8b42-ed13-4fe2-9ef4-5641b81ed2d1@redhat.com>
Date: Mon, 22 Sep 2025 19:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nikita Kalyazin <kalyazin@amazon.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Muchun Song <muchun.song@linux.dev>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>
References: <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com> <aMxNgyVRuiFq2Sms@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMxNgyVRuiFq2Sms@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.25 20:20, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 07:53:46PM +0200, David Hildenbrand wrote:
>> Re Nikita: If we could just reuse fault() for userfaultfd purposes, that
>> might actually be pretty nice.
> 
> I commented on that.
> 
> https://lore.kernel.org/all/aEiwHjl4tsUt98sh@x1.local/
> 
> That'll need to leak FAULT_FLAG_USERFAULT_CONTINUE which isn't necessary,
> make it extremely hard to know when to set the flag, and comlicates the
> fault path which isn't necessary.

I agree that FAULT_FLAG_USERFAULT_CONTINUE would be a very weird thing 
to have.

I was wondering whether it could be abstracted in a cleaner way, similar 
to what you described with the "NO_USERFAULT", but possibly taking it 
one step further (if possible ...).

In your reply you also mentioned "whether we can also avoid reusing 
fault() but instead resolve the page faults using the vm_ops hook too".

So it kind-of is a special type of page fault, but the question would be 
how that could be integrated more cleanly. And as you also point out, 
the question would be which other users it might really have.

In GUP we achieve not triggering userfaultfd by not setting 
FAULT_FLAG_ALLOW_RETRY.

But it's rather that not allowing to retry (drop+retake locks) makes it 
impossible to call into userfaultfd.

So not sure if abstracting/reusing that would make sense.

> 
> I think Mike's comment was spot on, that the new API is literally
> do_fault() for shmem, but only used in userfaultfd context so it's even an
> oneliner.

Right, special fault handling for userfaultfd.

> 
> I do not maintain mm, so above is only my two cents, so I don't make
> decisions.  Personally I still prefer the current approach of keep the mm
> main fault path clean.

Well, as clean as things like FAULT_FLAG_ALLOW_RETRY are. :)

In any case, reading Liams reply, it sounded like that there is a path 
forward, so I don't particularly care, just wanted to mention what I had 
in mind regarding FAULT_FLAG_ALLOW_RETRY.

-- 
Cheers

David / dhildenb


