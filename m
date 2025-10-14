Return-Path: <linux-kernel+bounces-852472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B300DBD910E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C12A344C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E930C348;
	Tue, 14 Oct 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feguwORq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EB1D435F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441994; cv=none; b=D7qWRLx7nWxZrcicByuQYDOKBnyUxl1HY3ptTQdGvSdWbzFesvvVgC+A9oi8SilLHzjTpPTuVfvX8JUZ/mi2NUO85r9zBuLi8LL6zFMLYGl/JDQGCj/1KCux01nfTdsXT5TTubOoPFO1HWc7hYB6NWokWB1EzZ+0L8mo1zuntsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441994; c=relaxed/simple;
	bh=9DQ2kkuLjPBjcxmVSADYMFoEAuFS9ZKNiR6uZ1VpQEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsXN2830/15X2Fuwpcq6w1CfN+aIjg51JxgvEuaiZhiC85W5UokqpYAURpqPGHGXlEQt4ej7Dha7XOEglCMR66LzpbMIvtXDzUhs5Jf7VaVSEHKlma21jPTObdEKCRsDh52oBWjZQiOrY+D1SkyBdWnX8k2Ldt/AjkTxRNKuE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feguwORq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760441989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sdXdneu31LbdRvmhwPO/2myoQVJi4Hc4GAsvAWBfZWg=;
	b=feguwORq/B5eyn+D48vEXaoVO00NvxEN7Pxb1YgHwkx1N8d9jqX74ujMqwa32mJ8oHbKhS
	0UeGN954mF7cCl1gebSLrr5HapwrSTL33cPppMnmuX1VzRA2OA5SSjS7A7y5MdE11HRKbO
	1D0az19UHG45xJeRUoJyKLXJvQIFeKw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-3oVW0O21P5u6fv7K9BqrHA-1; Tue, 14 Oct 2025 07:39:48 -0400
X-MC-Unique: 3oVW0O21P5u6fv7K9BqrHA-1
X-Mimecast-MFC-AGG-ID: 3oVW0O21P5u6fv7K9BqrHA_1760441987
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so43807735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441987; x=1761046787;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdXdneu31LbdRvmhwPO/2myoQVJi4Hc4GAsvAWBfZWg=;
        b=RV0ZMPjjpgOrklMTzcwE62ZSjP8BS2c2quIeBpyBkcziUEiniHR9aHml5RUz0HWxLO
         eUFZqE0DleYAw9FBdz1RnWnt6c8XsuUVF7l3FqNBWpdh+LTeLIF2VtPSwt5t2JoR+lwz
         B3UrUL3wHwMh1sQCT/Sp0cLO0ydXbzThvlAbE9TWbc6+9QBMjlP9vnfWUyznJOIQZKDm
         LWA8jJfbTD3alCn6OYx0b3v1ofTfo4KUcChy5ti4t9jEZY/oLw2SUZKHohfyHSUGQaOv
         nd5hMnQBX4OlKleH8sGv9RemlyLCTG+7yV8MUhUNtkfcACgqcI9JYM8SaOD0tiYhxzHM
         J/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU1JhZQ0UjQnLTtB2ydxdRnWkz2YirhLgaIUjVdJEPDK21eXBB5OW/qvfByMmyWab5QWZ01oc8yPjxRXfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6rg7eW1yRA19oPyQjZbh3MxTo/fRe+zAnUlhfxuvYi8KmWwH
	JKMWXv9KqB1MBR+eWRGSIIqvDbYAH4fFmkyFW8hSgt4C6AM3CXl+HzPBhw2JgBjiQd6fmBuopfz
	kifoJXUQodwJ43F8U5h5AJJYPcmAPUi1NmfE9AyjiktrA9/HfcryoqxRe3uMzy/aP/A==
X-Gm-Gg: ASbGncuP2KSs+lKwUQEW2DOzx23UkLwfRguI/+fhs7f3NMZ1GnkowUfrJ63saPwH6GN
	lPDtwrRF+g6z0MlOdtc/Sm/ppZKaool5a5qV8S07garSRZXJfF1zxpmlXIoim5uRZl2W8NIRVND
	13q3pZCCH+T560GZCEuDM2tHBOxssrTdzGd0KaOd/cTUalSBPVOKF606cS8ZuExguEldVr/vaUc
	Un59Hiqi3yBl65yodhZmjDBCiTCS0kSCHR+UsZ51qpgi6zWbEulEmDzZXLTcw0z0vE1I5lfC4oU
	Ruh2cpNXq1ECo4sz6SjYyoyObb2faLnitxA9cZjqI45Ig1FAP1CbkZ3Ee1eYLokNFHyMsXIsJg=
	=
X-Received: by 2002:a05:600c:1548:b0:46f:b42e:ed87 with SMTP id 5b1f17b1804b1-46fb42eee16mr110898335e9.40.1760441987452;
        Tue, 14 Oct 2025 04:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrjjz5kNQo6dpKCFwudJls7rWw/aMO9tywOBXrR9xbX7z+mJurnY9F4BUnivw7ejFkRxg0Eg==
X-Received: by 2002:a05:600c:1548:b0:46f:b42e:ed87 with SMTP id 5b1f17b1804b1-46fb42eee16mr110898145e9.40.1760441986997;
        Tue, 14 Oct 2025 04:39:46 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d92c0sm150913425e9.3.2025.10.14.04.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:39:46 -0700 (PDT)
Message-ID: <8cf7cfd6-6766-41a5-a280-b07de5b20378@redhat.com>
Date: Tue, 14 Oct 2025 13:39:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] hugetlbfs: move lock assertions after early returns in
 huge_pmd_unshare()
To: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
References: <20251014113344.21194-1-kartikey406@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014113344.21194-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 13:33, Deepanshu Kartikey wrote:
> When hugetlb_vmdelete_list() processes VMAs during truncate operations,
> it may encounter VMAs where huge_pmd_unshare() is called without the
> required shareable lock. This triggers an assertion failure in
> hugetlb_vma_assert_locked().
> 
> The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
> shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
> shareable locks to avoid the assertion. However, this prevented pages
> from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
> operations where pages were not freed immediately, as reported by Mark Brown.
> 
> Instead of checking locks in the caller or skipping VMAs, move the lock
> assertions in huge_pmd_unshare() to after the early return checks. The
> assertions are only needed when actual PMD unsharing work will be performed.
> If the function returns early because sz != PMD_SIZE or the PMD is not
> shared, no locks are required and assertions should not fire.
> 
> This approach reverts the VMA skipping logic from commit dd83609b8898
> ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> while moving the assertions to avoid the assertion failure, keeping all the
> logic within huge_pmd_unshare() itself and allowing page unmapping and
> freeing to proceed for all VMAs.
> 
> Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
> Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
> Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
> Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
> Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
> Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
> Link: https://lore.kernel.org/linux-mm/e6bb05f7-8f05-409f-9d87-2d25f66942a9@redhat.com/ [v6]
> Link: https://lore.kernel.org/linux-mm/CADhLXY4WPxzvzuiZPJmhS-9xMqRZ_qf7ZcFf5MXPgXbgB3_Xzg@mail.gmail.com/ [v7]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


