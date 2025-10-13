Return-Path: <linux-kernel+bounces-850116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7EBBD1EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C8A3AC0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F12EB85B;
	Mon, 13 Oct 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYVgt786"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7542DF6F4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342695; cv=none; b=nO+q4cRvut1MiMh/7+6X+BCHLRXmtPAC6Qox8H9dXvFVE0VC7cldh+CzGUu6rVsGdR3uA1p3jFmQGlRg40RB/Wg7MahgKHQPbApwzYnxX7xM2Erz++rsIgbm+ZMfbE64jsbpxwNYHYwQjEyS7XJzX+/W0zt7exG/NVTFPbEqUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342695; c=relaxed/simple;
	bh=7NU7rWh0rGWbbhxmDoF2Uv6OOhgblytuC4n01b1nQhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUKqUM9fXIuh98HeZAJP3pq/MoQrxVO2d6gQ3wf45BG3kNLo5qqqcRyXg8+K0t8b9x9CchTFa7LpYxKMsIy4QLvJZJI7989SXGYUQnnsP+VRwC9m6fybDM0guQj5XedxnL4uH/reDZYWnngB3ecoIwQQIUX2zbc23RdgSGY8jsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYVgt786; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KPU/lVFbgGeX7/1p5cP3aKk/YeGq7lbFJeEGyMzuGJE=;
	b=RYVgt7862KwBXdDJPcaSvDf1Pnzh0HnoO6ihO2d2o/1qa0nzlfPd5wb52QgeqLu2UvHQzo
	ul8zu03M85ujgv5Fv+j4JmGiz8m5tKeQrwZcBESWjV2FHsSXK74Pq2JCV2tzw4jbFzgcto
	7yeSf+ddCDLG7q1kOv5HsfYa6Tjp04E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-3-TL74sUO6GOyehCTxlo5g-1; Mon, 13 Oct 2025 04:04:51 -0400
X-MC-Unique: 3-TL74sUO6GOyehCTxlo5g-1
X-Mimecast-MFC-AGG-ID: 3-TL74sUO6GOyehCTxlo5g_1760342690
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso2196581f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342690; x=1760947490;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPU/lVFbgGeX7/1p5cP3aKk/YeGq7lbFJeEGyMzuGJE=;
        b=kyHA/6as/l6rWTVeJ3Jf3IJbdAgxm9g6yTghh4U5i3aST2g5u9VYKzLjCaJWUhshH3
         H4ihWH13p0YrDf6q5+pSk+Hw0hOVU3LTzyWoktx8zNRTEnbr5lKiDMzDgQaPhMYaDzzn
         S7ET386FdAlDJyExQ+NiPuAa4zpUyAtlccVk9rchxCSA1QvLmCyv6d8imOPqg0pdzzRa
         Hk3I1ubMzlNdexrR8uK1TgiTyZEVJo47cMyZDwtyzTxFJsh7xVPHwkk3dF7nza8p8qOE
         pP6YwuS/fc7Fg9gJs0p+WGyU9jPYuf7aJGmewMGRQjmWmyr1H1OhvJxmZp8W8cesRKj1
         5lQA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Hq4ViErLsvBQG5dCdef/kYXLTnhnf2BDJ7GiKG/Pl4JRPffda6sG79Ye34TKlGtQSRYs7XO4o9cuEk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6OGHgnS+xfFrq3sfSkmxg1uzOZXoU6Rizevj58sftuXAVgYU
	/Z7/21omRVpcc/cdEVtMPZv4OZSJEWWkgfG8qcL9rcmxbPKcemRfb/TCWAbyDEtBykqXkDRKNVs
	l9fHSpP5wn2Z2EVOkrM+1w7VQxiCC8XS587AG+k3BPu3YaYoA6rQzcybcqHZO56n2uw==
X-Gm-Gg: ASbGncvZ2W14B7oXc+b/s+0DwQc1QQaXtOZ44+A5Z47+0Ok6/0kOwfGhgVY0fOAs5Ku
	AsS7stcMbLrSSRzUQ3LulSbTdXsv5V13csl5FKKcfPkKPg0dLCS4rotDA9uUXV+nGnVA/bBxPjm
	82M47HXh6Z9QeZxcD1/19aQdVgVP489o93IRhlPIO4JdKYX8GqdF/YXkfdCEwUoe3WzCQRK+y+A
	xgx2movWb1FrLhawItJMpBcbf5fRVjFm1hQqO8gaUcz7RnTbIUhpi2z6lto0IMhIJlJk7vnu/Ly
	7dwdVocTJkU8rFW04vTtTIp7LgictDOjLaZG+ovD+dAsXImmKcjW3SSWbSjDABlAcz3EjetjnD7
	7Tu0=
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr117303435e9.8.1760342690276;
        Mon, 13 Oct 2025 01:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoP8u8SLxmZzCaUWAaNGn2tFhBdnNdRnHKUPJIoKhC3JsfIivu/FjKUfKsW1+RWg4tjbYaxw==
X-Received: by 2002:a7b:cc06:0:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-46fa296e763mr117303205e9.8.1760342689900;
        Mon, 13 Oct 2025 01:04:49 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce50d70esm17163687f8f.0.2025.10.13.01.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:04:49 -0700 (PDT)
Message-ID: <d1094948-a646-46a1-b11f-2cc4ec53d180@redhat.com>
Date: Mon, 13 Oct 2025 10:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime
 helper
To: Usama Arif <usamaarif642@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, Andrew Morton <akpm@linux-foundation.org>
Cc: shakeel.butt@linux.dev, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 19:24, Usama Arif wrote:
> This is a common condition used to skip operations that cannot
> be performed on gigantic pages when runtime support is disabled.
> This helper is introduced as the condition will exist even more
> when allowing "overcommit" of gigantic hugepages.
> No functional change intended with this patch.
> 

Wondering, would "static" describe that we don't have the dynamic 
runtime behavior?

hstate_is_static_gigantic()

hstate_is_gigantic_static()


Whatever you prefer

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


