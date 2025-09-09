Return-Path: <linux-kernel+bounces-808526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE84B500E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAC8188C47B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBD350D79;
	Tue,  9 Sep 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF+fu7sO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B72246788
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431188; cv=none; b=eqo7yhb2LCf8K7LAA3FoEsHmgjH8D2O2IylA5NW65O+x4sm7HB9hne76HpjrHFOwCKGTK93WUxWCArz3cgOBPAKzoBvGVJWRSoVYp4BStPjQlporXsf0pf7PThAEYoz2JU4XKHcvYSptqNcWv2y6zIGwXyOoR/Tni3jqZC3xflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431188; c=relaxed/simple;
	bh=msnfuONaSbITmobErRnPJ7G/LaCBMuhmdEnlZXqA6b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5RBLfm9ykgXQKlgiif+bqpCKx2E7tpF1tyazedyT+omwo0wWo7scCX8n5LosjDcT6t8Vgekd1/83R7Cy7U36H2rijihfwPI+w/G+CqZDBe++zYkLBwiVr2cJ6KhLMNE+SbY4CPsja7y5XgzkYFGN1hjYe2aEkw/7w7pT3ElUu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF+fu7sO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=InYbqwt9glvNL4C3LVQbjDo/hY87wVdMa3rsXOKx3FQ=;
	b=EF+fu7sO+Ez5iWshm4rZDg3t57CCVsbGtVYxBBpxeq/jqiTQt/KlQioAK7nFsHmjm3m6lW
	cmYN2IXvQI4//zHzhla1OqDOyDr+P2d06RcjaP2sHtV988s1/DXXfuLG+nz4BTZTtB7gSV
	a5wmGwn6yNHw697ynV+LDDS6yFML1j4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7OpKRD5wPsmAQiKGWqPY5Q-1; Tue, 09 Sep 2025 11:19:45 -0400
X-MC-Unique: 7OpKRD5wPsmAQiKGWqPY5Q-1
X-Mimecast-MFC-AGG-ID: 7OpKRD5wPsmAQiKGWqPY5Q_1757431184
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45de5fdda1aso11149295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431184; x=1758035984;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InYbqwt9glvNL4C3LVQbjDo/hY87wVdMa3rsXOKx3FQ=;
        b=tz/A2rz1cR54KpWgf23/sOUj/EnNKtU7/WFU633k0nwhzl5JsqR6IprKPqCpLBQc7z
         FesUGeDYsjKgbzEGs0s1l5DNWWiqB4WbHJ7KBFGCRZ0e4/eBo0nl6OIIevho/37qwuWL
         WEeVSjHy71x5B9zoWZ2KqR1i41AnMaFyw/oTmWJWKJgR9kGzjtqCgng9pgPbRLa1/Knx
         dCnc8a6j4Cv5HgVPeSbOvUtNxXn/8qrEbrp5CZfxJt6dUOTr3+mXrC05dft10R1iaRwn
         Q4P/wJ3XgkOevXlKue23UWvvzM9tX8JoLfrhZQee1qkSmlouWAjOPgtEaxJ9CZkF7z4C
         ltAw==
X-Forwarded-Encrypted: i=1; AJvYcCUKkQwbOjWIDGoDyePNw9FZBr/qfi+9cBg9hO7SvvGjaUxGOpa2QLF3NtKX0sMnotwh3TD31Z++QcRrxx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvCh5VSIDSwV1jPIMtYOl7cJzkmfzJd05Ud0ebNGsRHTLJEtb
	tStmkY1r5rPOID6RloRFYVGN9XahDK58zvTUP4LctWggfZZqYO9rOvA5/1vNQaeSVjIyABhMS6w
	QxpTKvg/k0dD7bNkyDUveTCmxPu98Vm/CG5oLRwG9Uj+DuOFT9+Ti0m0JU66G8klkBA==
X-Gm-Gg: ASbGnctba+1F3w8KtvrEl5fKSuVZqrZc0GaHOk2AlfyTKQ2iWVGkHKjOizy54jGoZ22
	pXCgKSgd0JqxO/44zK0nnaTTmSVI+6Qb9ngxNUfaJRQZdOnBO1D3Kore6TOyee8V78xHnyx0huW
	Uls7R2KWeF7e9FaCAepRLFWGbxBDgjyKK1kXlqx7IwIwZSvAkkQz3nEb7RKjrmxt/swwQNCbJbP
	9jDWpte7KGzt6jlYMsZnSfd6kCkbHSfodFwoYUrw/j8oiFurShiV460OxOfdcK/UhCZVYy6xmKH
	mw0FTIA/CSLdUvnRmDEhrEYBMv9AnOYjIeXlZJT2qP8cgm9Za0IOhnnXLdXN3WLzvwnLNSBsumh
	YMaijgG7SBG9EVbt9s1zq7pi0kSmdd7VRQgCtLQSpwJQoLs/M30JmaLUlpJbDeItU7Cg=
X-Received: by 2002:a05:600c:4694:b0:45d:d908:dc02 with SMTP id 5b1f17b1804b1-45ddded9c21mr103636375e9.31.1757431183420;
        Tue, 09 Sep 2025 08:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bljri4jY2JSQWXumU2Cl1Vy0YyVDFF7sGRN7NXMVP/WZtzyUJBsPOarkJX8Q2cJU6IwvCA==
X-Received: by 2002:a05:600c:4694:b0:45d:d908:dc02 with SMTP id 5b1f17b1804b1-45ddded9c21mr103635995e9.31.1757431182935;
        Tue, 09 Sep 2025 08:19:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd8csm3255178f8f.11.2025.09.09.08.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:19:42 -0700 (PDT)
Message-ID: <283fc6d5-caca-4a67-916e-55246a5a4cbb@redhat.com>
Date: Tue, 9 Sep 2025 17:19:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-6-ryncsn@gmail.com>
 <0bbda135-068a-45bd-afd6-3f5cdf4e570d@redhat.com>
 <CAMgjq7CsKYWzAD0Ev7q0cocQO8kOYLmhgLD0wk6AX-HUzWFJZQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7CsKYWzAD0Ev7q0cocQO8kOYLmhgLD0wk6AX-HUzWFJZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.09.25 16:58, Kairui Song wrote:
> On Mon, Sep 8, 2025 at 10:08 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>
>>>
>>>                folio_lock(folio);
>>> +             if (!folio_matches_swap_entry(folio, entry)) {
>>> +                     folio_unlock(folio);
>>> +                     folio_put(folio);
>>> +                     continue;
>>> +             }
>>> +
>>
>> I wonder if we should put that into unuse_pte() instead. It checks for
>> other types of races (like the page table entry getting modified) already.
> 
> Doing this earlier here might help to avoid the folio_wait_writeback
> below? 

Why would we care about optimizing that out in that corner case?

And checking the folio right after locking seems to follow the
> convention more strictly.

I'd just slap it into unuse_pte() where you can return immediately and 
we don't need another duplicated

	folio_unlock(folio);
	folio_put(folio);
	continue;

-- 
Cheers

David / dhildenb


