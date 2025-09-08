Return-Path: <linux-kernel+bounces-805893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406EEB48EF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98853AFB60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53883054ED;
	Mon,  8 Sep 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAjjTxDt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1F2E8B83
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337054; cv=none; b=JWlG7CcPV3Bya/FOxn33WhYR4uv3gxj3Z9c5K+qJ8NtQUM90Ve4ok0uBCiADqMMdQ8Z8tQZAeJadp+cBmc4vj97GOUvQCRQGPwad76gZgElG53I4EkPIDqA0XbjfpUCwLYdAr4aUMTqTkTCwIVXq489N2SpR2DT+S0eAnTCXwoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337054; c=relaxed/simple;
	bh=9D0pHjWncT0LpwyzoGFnq6PC7GQwZxZRmxQgIM8xPxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioVuUnzP39knC3/GVgAPOA7v6GZIWeagMK49R9E+1diwMIZgDugCeYe4CsjoZ71EcbFhZBULNGfgYHhnv8WGKKmhEqGJMp3tsznr4hDyRSKRnhklZCG52d6pqvASZ3Je6nbUL6/ee4EaAFzyR2zYFSV7HS7gjge7VqzI158Iywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAjjTxDt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757337051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=loJMYNcnC3UXNhu0/YTM881QqRZegT4h0IooruNXOxI=;
	b=SAjjTxDtOZMArKMzC7Q4lP9cNe2j92TfFok/qcLu+zOyII9Fj8wzbjKnKbnWzFBbpCUmQf
	O93Lwc38wjF6TZd8KKwIVUxqB2xqCsyTRbz4d5ofWpYAFwWHu2/Clmz/RnMR4HwnmXHWjt
	MrpddwDaQGQaop3jEGSCG7lk8RmND/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-z-phlaCGN3u_ufFfGvoyUA-1; Mon, 08 Sep 2025 09:10:50 -0400
X-MC-Unique: z-phlaCGN3u_ufFfGvoyUA-1
X-Mimecast-MFC-AGG-ID: z-phlaCGN3u_ufFfGvoyUA_1757337049
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de59f92aaso6935625e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337049; x=1757941849;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loJMYNcnC3UXNhu0/YTM881QqRZegT4h0IooruNXOxI=;
        b=tblZl7thbpi6wbWmiB5yWVp8M9K/VBI8/puZqBDQxYcqXudP0HiIcXayam3YNo4Im1
         u8Q2x9fA3xYM5wslGd9KPQitOHmSsr9ye0w6mc+FkfhkXTRtfU+4c3XqXQ1eSwuwhzqk
         5jOfNw4HnQn7QoCH8bbXvuF8vV8pXOVopLstzJEZibvucGRYcTobKiKdJqNIi+HOLUBg
         05JR1rTaleikknN5DPkP4XrimY3sggwSP4Pv9rTeEnVXRg4T9iQNkDHyXd6UVdSvdb/N
         VnA/nUlFjxSsVk9dYQnrm8fCa66QkHltKrkqcx9ngM7rtiWEII7eS9LmvTVEBEA+INHc
         e1og==
X-Forwarded-Encrypted: i=1; AJvYcCWZkCnIjxYwmjt5ZBseGbr0nd+bJpqDZbZEuwsRF9M7lW/a4EZYRP6IzcHok0nsppqTRYeP018iFwgm16Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxIaPI92p+5PfrxXzh7cE5SRPfI+NDOMN+KiBu3ETAL2VkpjZ
	R4fcEzEnfDvbuRFEDQL3PpTK3jjb/7uMoCFtKPy1dtEbs3DnOmshOOaTtyye4p1e1pQILpFDLZV
	JwTR54bsLMMIEZCmv0Ku0Ag/qCLLiukdMBr8qPlkCgYzHn/XUyNdIRKWOGoTz3PJKDw==
X-Gm-Gg: ASbGncspKNIc9BNAyp9YnvRZKrjJX+MjsgmZi05r52N4g3FovgM+6o7iVbI60DkU3bt
	bMkJFfkUe4kkLXi0lINqAoPPqmv+Sr4pcxicqEeZqjmLX8jyAmLfrIWOWCRiOq5nnQJaAt/MW5O
	PsYwSgcLdUsbKAPHTy+vKE23T49RcVfMEEyYraGVwkWZjAoib+FMab3MBs/m86zR+BQ4gz4YzjF
	7ntkcACFEpYaIVUED0TgNt8A8fB2miV9mqN+VEpQUAMj2ssaeyq6AMtClAO8XhxBsdRTZ3hxJnm
	YT3MQ+z+zWUKec0z8dhdxOwCANXcmnUJpwlobYct96cL6y/V4/dgasWKH77O/XMbYXsYum+9z/t
	e+2TStYLIS3kWGBCKS1b2etruErDawBPRLlA0CdXBjWhqljscIEwe7CQG++k8QWp2
X-Received: by 2002:a05:600c:3510:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45dddee37d0mr61268605e9.34.1757337048808;
        Mon, 08 Sep 2025 06:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnvX+mXw/WhUtUVKCZ8AgS4ltIqbm4k/KPBzWsR+F/Kc2Tkki3XHXvg2DRwx3L5bWSTsPPIw==
X-Received: by 2002:a05:600c:3510:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-45dddee37d0mr61268315e9.34.1757337048374;
        Mon, 08 Sep 2025 06:10:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda4f2a0dsm138726295e9.2.2025.09.08.06.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:10:47 -0700 (PDT)
Message-ID: <55d54fd4-5360-457d-9da3-f5b14916c65b@redhat.com>
Date: Mon, 8 Sep 2025 15:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] mm, swap: mark swap address space ro and add
 context debug check
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
 <20250905191357.78298-13-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-13-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 21:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Swap cache is now backed by swap table, and the address space is not
> holding any mutable data anymore. And swap cache is now protected by
> the swap cluster lock, instead of the XArray lock. All access to swap
> cache are wrapped by swap cache helpers. Locking is mostly handled
> internally by swap cache helpers, only a few __swap_cache_* helpers
> require the caller to lock the cluster by themselves.
> 
> Worth noting that, unlike XArray, the cluster lock is not IRQ safe.
> The swap cache was very different compared to filemap, and now it's
> completely separated from filemap. Nothing wants to mark or change
> anything or do a writeback callback in IRQ.
> 
> So explicitly document this and add a debug check to avoid further
> potential misuse. And mark the swap cache space as read-only to avoid
> any user wrongly mixing unexpected filemap helpers with swap cache.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


