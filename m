Return-Path: <linux-kernel+bounces-864509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF8BFAEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B133E562EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F45309F1C;
	Wed, 22 Oct 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h47fVIiS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB3350A2F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122282; cv=none; b=DKbZV4GJT2Y4VfS+0gau82LEy/GJVl1IQtietp3G5PBKUlh0GaQVb5yzeeazXgnARb/36fc+QxzmorpTmBSekpj/944jlVJlecz0/XIlqUhGit1GgiW4EDuJXMVvlgqaF6Di33nR9pAlJCBkns+zxk2ufrTawfRUiOEstTeRd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122282; c=relaxed/simple;
	bh=6fqZnvdBCBsePVwAsDuE2G7gXV28Iy/+ugq1JzsiDCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYqeAU/XlyH3XeXBtw1nXe4XUZ/mXUJsq+KuHZaa+PjwL7EYbk9SwBzvdTglzo+HV0l/O1w/VgeIfH1XFOMJWBsNojn52taB8lVEFBpU+ooYG1nG8AKxLUhzkda4JfNdvCYcKgU6J4Ti+bpFrH2SSNd1zQPYEGmPkBr3dzuD8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h47fVIiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HORYs91dLQQexQDsveH7tAbNx9ev00vg3VpMbAGTK3I=;
	b=h47fVIiSyRZCL1N1LihqoedpEKOCahv4hpRd4KgYvHUO12Nu99gdK3gYiqR772ZJEgo1+5
	PpVe9OmkemGTRdK4PigR+Vg5GbLvDQVHloCwixb4jwkX2lRG4Yj1AvRwTCDwdfTmobLzF4
	onrhNFIYiSZ6MJlQl+Dy40ZgzHQJXXE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-7MHXY8AVM8yldnc43UoA-g-1; Wed, 22 Oct 2025 04:37:57 -0400
X-MC-Unique: 7MHXY8AVM8yldnc43UoA-g-1
X-Mimecast-MFC-AGG-ID: 7MHXY8AVM8yldnc43UoA-g_1761122276
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso5385505e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122276; x=1761727076;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HORYs91dLQQexQDsveH7tAbNx9ev00vg3VpMbAGTK3I=;
        b=sIU5F8NDjoqDqfOSU5fZqN/BPNboPKe59KIeNr7Adx5cRtl4+XL41ULNOr2UNcgcxV
         agIVJzBZaM1xmO3HiaDaMcykwTyp9wKzNMJ0aKriXpoCaBVqNjoyf4EoEso4zPf4OKUM
         7J8FY53qSpwSZgqposwkrLVCDvBu8coX8f8LaACX/9DUIKpNA/jS5eZZtAiPdZaBdaQq
         bcRz275yaUOlehQcD91SlheGkD0Y9Ogt2E8X1ZCZT5dLjjH5SktANOHYSJ3XWx4Y7B7n
         SIyH8weJ/oXUUDAGhoc0gFiEX9eC0TC2Bm5JxKHtPH+nsEemPKhm8oIMy87IBU7Oo/3e
         Ogqg==
X-Gm-Message-State: AOJu0YzE4MKJEwLXk4UajlC19/TV4USKdr20rNEmMJfFUErth+5+aP0e
	WBzRwX8FVYTbJAf3L335kXAShBxfUfEqJiQCoQURDb2H6PIzUvyfKFu9k8HCi97K07DLyWyxQdg
	r76iOwF+HTj5/ZxKS+Hxlu3v/0mzWuWv4S0r7SC1O+d2vojqVcURy4herAVwWgV5r7A==
X-Gm-Gg: ASbGncszlajHBzaCtz6XOjUct7bUo0DU7vKW7i1blw182RCWcAsDHTnipxp1boBZoSk
	cEPq5cR6D2MbvubwuUgV/9V9XV6BpsbgEcfnP3woiohPxS/f6KGEzc7efC0ivo3MzgJVVjU71vY
	lsSMZfT1MN4U9qU95eYfmseCYE2XHVIjegu4zzZ4llpeK/sn9HzEqa6IRGq+p6/ZEXIOkC7pGWT
	2KhffZaQRr8GsVCRqJk/rg+IQsdPfEJTII++owsKQubrZuV68ysBkgusOX2RS4RKsKktREc1OFB
	WCKXGm5xtfCXxZiflv9cZtDvSUL10f7zq3ity0iUn5akdFhnTKB+U4zJfOzwmQwF8+IQEPwJnqb
	iIh2fw5oxOu05OkQXKlhZgXZWyqtJnVeJroeXD/9X0rU6N3oQXvZpJOYDo8jBjpNIRVkjk/yzrV
	tE7Q8gra8RMy7bwQ+UjuMY5FhQja8=
X-Received: by 2002:a05:600c:8b17:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-475c3fe35f4mr18215405e9.16.1761122276479;
        Wed, 22 Oct 2025 01:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZox5bLuD2Cm8JqdEWshafSicQuJ3K5TI0WpKQPM9/qTM/uKldxHeAV/RdhcTW+7Drr2Molg==
X-Received: by 2002:a05:600c:8b17:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-475c3fe35f4mr18214965e9.16.1761122276037;
        Wed, 22 Oct 2025 01:37:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a534sm37256955e9.6.2025.10.22.01.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:37:55 -0700 (PDT)
Message-ID: <2fa9f196-12e4-4c1a-a1f7-cfdded93cc94@redhat.com>
Date: Wed, 22 Oct 2025 10:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/23] mm/balloon_compaction: centralize basic page
 migration handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-5-david@redhat.com>
 <20251021164916-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021164916-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:50, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:09PM +0200, David Hildenbrand wrote:
>> Let's update the balloon page references, the balloon page list, the
>> BALLOON_MIGRATE counter and the isolated-pages counter in
>> balloon_page_migrate(), after letting the balloon->migratepage()
>> callback deal with the actual inflation+deflation.
>>
>> Note that we now perform the balloon list modifications outside of any
>> implementation-specific locks: which is fine, there is nothing special
>> about these page actions that the lock would be protecting.
>>
>> The old page is already no longer in the list (isolated) and the new page
>> is not yet in the list.
>>
>> Let's use -ENOENT to communicate the special "inflation of new page
>> failed after already deflating the old page" to balloon_page_migrate() so
>> it can handle it accordingly.
>>
>> While at it, rename balloon->b_dev_info to make it mach the other
> 
> match

Thanks!

-- 
Cheers

David / dhildenb


