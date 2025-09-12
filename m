Return-Path: <linux-kernel+bounces-813425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253AB54535
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04BA3A7DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0762DC780;
	Fri, 12 Sep 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CV+Z0P5J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3EF2D5432
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665496; cv=none; b=IeyekqX4Lbz8lM2V/dIfamHJ/SEeFT3QEMH6um1derNTe5vVRpY+SR1tjtnFeSRSHw9XAGIbac4u+/fq1NiS1UNewkS8Ax0njEEUrKv8IeuUthoCBTWrmAVVZzU+LCvaeALHS1INmV4hKhI9vrj5dCWTjDIwN31xvcdfXV0TNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665496; c=relaxed/simple;
	bh=q+mXn7T8K4F/7maHsxERyYTSwOA/eEMEOLGAFYXi/TU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V+RnR5fcErMdhJNYJ8d5SF3fc+c/zCr1CU7hlyTPJAWCgoeyZ8YG6OWu2BbwzxpmY66YbLcQL0eOxggde8WOB9vKKxgCmjTPL0JYcbAohwegqrTqmqUtcVc9KSKqKXx18MgrZ2l6hDbcleeI8lVCYPgAwHdRGip47GKpZQuTIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV+Z0P5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757665493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FRWJpxjvGPL3exfTRCSbM3blFXxwMwMcQ1Yjb8ikjDg=;
	b=CV+Z0P5JBmJdUpyaa8b6lma5n2ohacZ/c+t12nrx1eFEHjJKE8iUF7x14jwF3c/yPIpyJ4
	Mj3GHgL200pyg2pAYDULL46hCRFDfYThrpF5YzAjWIDch9WTnoi8y1cLRVNvGmexaOviNz
	NAMN5wdDjsyueakac0vDDxTfKk2hU3o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-D3m4jXZCMWmAZ6Tt3pBK2w-1; Fri, 12 Sep 2025 04:24:50 -0400
X-MC-Unique: D3m4jXZCMWmAZ6Tt3pBK2w-1
X-Mimecast-MFC-AGG-ID: D3m4jXZCMWmAZ6Tt3pBK2w_1757665490
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45d6c770066so8497265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665489; x=1758270289;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRWJpxjvGPL3exfTRCSbM3blFXxwMwMcQ1Yjb8ikjDg=;
        b=s90qUc1YKN5LZ5XFskdCm4CtFXOSY4T+JJHUf5CY5qd8thb8GA7Cs1aiij72TL/cMM
         nolh0LswNj16OHUaUrZ5fQA2VJ6Vb4dQaEQx/rdiWz430SilaKAgPyqkk3g26Swqsgcw
         YT94Oy+4vkd/NH7+XgqMtgPwfvYhJ1P6ulWz6MjONsS3I5k2iiJtzqM9uKue9Lrm1099
         hTUaYEU5q/f48trIVJ1LnbXQFfRarnrdo0PVs8OUzKvfPiXnlRoVnFgGXPhrwixeaFh4
         AwjuvxJ7cW/CD+LbtZKGWHD4s/1Xo2eeAh6vA/uokE6i6OsmwFI61g1CduOSDxo1QQ+1
         mHxw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yAzzJk5jDbE3EaFSpzrZYGfol4ck+43Q16ILGb/lPoI5rxWkOVtCCzaXp8wpnjBSXkMtD1QLdVrBDhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFJW+jctW96O70Lp+PtsKxlKZJE5cakceWd4qMDreguaftMsA
	dGdnQPLzvMWiLsTdZ2ws36MG71cLhqjAbwyLTMlG5nOc7pLpq49G7oVDKboxf49YYRnpuP9LiKV
	TBpWyTe5lZZ6uJSFJm6C7y1MWkzvx75zLygnPqukSgyxhgCVdlw1apIJ3T7/YrvLFmFisSPiY6A
	==
X-Gm-Gg: ASbGncv2Vjbyk8Y6oYXZuHa8GbBrdJWz6xTJrBOfaQhVjCEIFkGZjhtQ/+lmA3CxcLG
	lTHP/T79fKiKNRsefBOE3B2u3HNXg2C4vhcgaeRZ8bgoKWokdg45awO+OKxqrjCE+Qqw+JXzKUZ
	dQOGHw+VsjClggboUb4Y/9PTgNrIeobljCe7nwY2FtzXx6NtYczObwdsTC43MnZ0qxtfH3CU2Ph
	NKJ88448nwGa+HrW30hHzyDCHcXAaPafxnU2s/tE4lvR3bqjjwvt1jBcJydQfn4pnF2L37+Tgom
	aqKyYxv378JSIcOpDYHm5caFVL1kmSYQVpYYVsW1vVKxW3yz3SCW80B9lGRT6GZ9jxhbY5R4u3J
	CReNZxZpZ5mFRbrOF1VElGSw4b2ub2+14lr0vn4RE/k3sNSHQ2zMskvhug2UXU+XGpIw=
X-Received: by 2002:a05:600c:5793:b0:45d:e211:da8f with SMTP id 5b1f17b1804b1-45f21202791mr14565545e9.36.1757665489576;
        Fri, 12 Sep 2025 01:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiYqeRzPlyHLpt5eEQYJOufy0h05+64TX3jz0Z08DG2bpaL+p8+xBHK7jj+4aVOVK+tXQdnw==
X-Received: by 2002:a05:600c:5793:b0:45d:e211:da8f with SMTP id 5b1f17b1804b1-45f21202791mr14565325e9.36.1757665489178;
        Fri, 12 Sep 2025 01:24:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0159f2d5sm28850115e9.9.2025.09.12.01.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:24:48 -0700 (PDT)
Message-ID: <94cfb423-1dc5-43e1-bd1f-75b8d43fdc1a@redhat.com>
Date: Fri, 12 Sep 2025 10:24:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
From: David Hildenbrand <david@redhat.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 10:24, David Hildenbrand wrote:
> On 12.09.25 05:45, Baolin Wang wrote:
>> Currently, we no longer attempt to write back filesystem folios in pageout(),
>> and only tmpfs/shmem folios and anonymous swapcache folios can be written back.
> 
> Can you point me at the code where that is fenced off?
> 
> I can spot a folio_is_file_lru() check before we call it, but the
> description tells me that there are indeed ways we could still pass that
> check for file-lru folios if we are kswapd.
> 
>> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
>> which means no fs-private private data is used. Therefore, we can remove the
>> redundant folio_test_private() checks and related buffer_head release logic.
> 
> If that's indeed the case, do we still need the folio_test_private()
> check in is_page_cache_freeable()?

Ah, that's patch #2 :)

-- 
Cheers

David / dhildenb


