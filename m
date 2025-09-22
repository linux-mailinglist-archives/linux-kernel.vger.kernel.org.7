Return-Path: <linux-kernel+bounces-826834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12044B8F752
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A153D175A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8614D2B7;
	Mon, 22 Sep 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKUr806L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55950274B51
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529042; cv=none; b=hrmD/f5vWy/ewR6PL5XYoTJBD96qLYfbhXZed1cjvR40TF90yhJQEEkru4bpD8tM2DmeW3YdglrWFSzUcCcOUHMkiemQUYguP6ykdy8St4lr+Z06DaI29ShMuSXjdKihWmjrp3bVr5kpN/0n7B5k7VC66hJNWVLPV/CnmEqrw2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529042; c=relaxed/simple;
	bh=hrS1Mkd6QFtNS9i1TzFb5gXkeSmKAzcbUfriBV5IaW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTBT4hr2axhDVZDTouaxvHT3m+6eiSRVzjrQTkVCj/oS/cLoILXANmqLk+bJIKppZ7I1B3GuFKXuSK9yCwEqPRES20ooFMsAN3EDVR4uEnls4eIr209kyB3ZRwGPgqw9lxuZy1NEgVN0ZogiCSg4KxQQ6q+0UfxYOYrqxuPwdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKUr806L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758529039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xl+oAizSjcdN2DSW8OsX7gKnJcWLeuJ4HjmHVAHxhI4=;
	b=HKUr806LI/47ogBc4Ru0xQOswNxcE54uv8P5/whnaz0mgUNd4GCzVreLstL2hKc5bqK2n4
	owTzRSKCeze1ZT+wVN2BJB0beqmJiGQLuyRA2N1CLlrCjZ5ARYYOS8v6BLE0X8Aw0zXnZo
	ELn8m2ji9LP/HGsmsDdEbfBO+uqZa0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-SRI2jdT8PA2TSmRH6s004Q-1; Mon, 22 Sep 2025 04:17:17 -0400
X-MC-Unique: SRI2jdT8PA2TSmRH6s004Q-1
X-Mimecast-MFC-AGG-ID: SRI2jdT8PA2TSmRH6s004Q_1758529036
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46d8ef3526dso2621825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529036; x=1759133836;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl+oAizSjcdN2DSW8OsX7gKnJcWLeuJ4HjmHVAHxhI4=;
        b=a2g6SrxmmzfpIe67CazZD96WlBkuxe5YzIqUD0FaUYKOUVDdYIBOrF+ZgsePCsBCcQ
         VE3FYqv2+zDqpor2YG3LP8PnL+LF2HccVv3V6jyp1JNgyHrVsPJDKvbNl7FymZ3aKXR3
         Hh81PQ8WalQlQGjNIaJK9CZOumVmxU/Z+OeH+dKBefA10vcBt4O7sCpZEAzrnIgNqscZ
         ZoW/hJ+IXcKCZ/SlAtCQQNGouf2exSyGWZ9LIMVaoOyEbSH74Vg+wAIMEKxTytGDFmZQ
         V7t4ezc0K+MqO15XbVMtOh2ZjmcDsnDH2d9V+riyOrBOpIy4QBjtzslZGUZGSQfNE3zw
         ORvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVShA8TI9JG+hVGr1WLeFKZ83zaAAFQux706iTr1tjCj9qOnORPfAO7QaZcwkNrkXtcFozMgGPtsyOvfts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6JKKMxbJwz7A672ATXdYUM0jdcv9SxT3PI1J2CLFVwZCJqEo
	/qWaZj9kqiRmJ1n609H8a9c6vmHvEXimhBktz+h3LtiFgxqiBuYaptnp8K3bO8Srp9FTgz1s/9K
	D0/4Q3UE73fxmInqPPTMajLYfwymNNjAhd/9rVHGBYf2yZKCPax40XCfsZiFm9WGyFg==
X-Gm-Gg: ASbGncu4+27QZVlOuPG6SARAzGFhpFiTOBz67/wnaxoOXJr6a+QJ8ryYC8zIKWO31NK
	SJgwOKhwRCG7CmyskOrBzugPAHDI1KLhdFKrchKKz/60aRUGPkrRFg2eaaLJG3GPAYeE3RUW73Y
	kdBaWe5BSaiftpsD69AlUEmYqYY2kVVjWEmUqw6M4iuFRpC3KLAIjrZx4GtzZtNEfFq2W491aB8
	hJ90U1BBtd2Lhs3DuxHuRCFixli6j3QX8Ukc8SPKDFYkzu35WdLNQKx1bzqS+qbiMxO1ANIk/Rq
	RU+VZEPU83WTkC+drJ2cs7zuE/pNeMR6OppX9PYk/lByUskqNfE0s06sweYw1JUX24l+ioglkeE
	dxqO1iY2JFVoIywAjX05uaGfRsKOTCVvLlOE9AsDG/d05gcSdDnC5WZ0Bp6JypSE=
X-Received: by 2002:a05:600c:c8d:b0:468:4350:c84d with SMTP id 5b1f17b1804b1-4684350c98cmr94305525e9.7.1758529036140;
        Mon, 22 Sep 2025 01:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH20k4kJt62SfinRtlqPZ+1RxOz7CShF583y1p3NV6Zfw2UT9IzSp6E71WCtZFAHxn58tJ9Ag==
X-Received: by 2002:a05:600c:c8d:b0:468:4350:c84d with SMTP id 5b1f17b1804b1-4684350c98cmr94305285e9.7.1758529035750;
        Mon, 22 Sep 2025 01:17:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2a:e200:f98f:8d71:83f:f88? (p200300d82f2ae200f98f8d71083f0f88.dip0.t-ipconnect.de. [2003:d8:2f2a:e200:f98f:8d71:83f:f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e15d1610fsm8286165e9.7.2025.09.22.01.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 01:17:15 -0700 (PDT)
Message-ID: <a4f7c004-b96a-4902-b003-111c83b0ddc1@redhat.com>
Date: Mon, 22 Sep 2025 10:17:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: thp: replace folio_memcg() with
 folio_memcg_charged()
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
 <35038de39456f827c88766b90a1cec93cf151ef2.1758253018.git.zhengqi.arch@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <35038de39456f827c88766b90a1cec93cf151ef2.1758253018.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.09.25 05:46, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> folio_memcg_charged() is intended for use when the user is unconcerned
> about the returned memcg pointer. It is more efficient than folio_memcg().
> Therefore, replace folio_memcg() with folio_memcg_charged().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


