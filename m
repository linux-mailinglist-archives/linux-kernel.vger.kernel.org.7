Return-Path: <linux-kernel+bounces-745970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D35B1210D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2F73BAC80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC22BF3E2;
	Fri, 25 Jul 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG7K90+6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514661E86E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458018; cv=none; b=XFuAhsPLduLbBOh1FXO3ftWC4GKJ2jPR/O70b9qicyD5uzp2AKT18TQXBVbGNbIapO2dOlru4OuD6F72FizJFx6KPbyZc4rCMbL+3K2TvBSjfUdlRjlETqLb4FC68VecJt9EzkA7bl2LuqG50WLmzuB3TKHUTmuQDw5MMIO2c7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458018; c=relaxed/simple;
	bh=1OePdh7GX4SVHfOr5lBs5rVXimJFUmcztixrGlCAc1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9JYIg0/Fc68/yn7GttRUt8k5Idm6KTBQJN7rj9WZp5j5xctldBDyjbeS63G3wYXdHmBvdF0GPcpyVKIlkF9V9E/Rok8loo+UIuHaZK20mq1b3h84WSVuD4lUjkIn3ntMcEb2ZQY6VCvPPGdwI2OCi/tXSOzz5Ekajh6MLwgvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG7K90+6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753458014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sC45sZmC6S0ZueACRW7H6v1qytH0Lj12og8gIKqUatE=;
	b=OG7K90+6K2Rq/2uNGFtYXgqOZAIMRpx11uXD539G0SeEh2NE9LrF68ZsJDIk4JZyVzaLJM
	ONSmKGPNuBOlhmEeNLFpZgbu8oV7+4aw0FaT7BmPSzh8AH2kuy4ny59j8hpzBKS4fGHKWl
	rVLXu7zu0BAERpSmvNXHcSfOL8RDKoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-L_wQtVpONxGd7w1eBEWK0w-1; Fri, 25 Jul 2025 11:40:12 -0400
X-MC-Unique: L_wQtVpONxGd7w1eBEWK0w-1
X-Mimecast-MFC-AGG-ID: L_wQtVpONxGd7w1eBEWK0w_1753458011
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b604541741so1615698f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458011; x=1754062811;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sC45sZmC6S0ZueACRW7H6v1qytH0Lj12og8gIKqUatE=;
        b=N7cYyoLPQH6k3PtFRQjQPivtUIPAg1fvQhuN4kejXavbDIiDjxXoC446rzVLWQbYXU
         wYMvRO50zeL7exVZ+W6PnGyiMR6FZF8RDQwiGA6fmoMrilTfa6RKJCWR4cp0yXaWILX9
         hASBZZEJ8zMjKG5lTvtQerNcoVZsL2UBQfvhDCt5I9NVCkeRBOGV4fgN3czU4XeqbD5z
         Fd/mZYjHkogvfky/XuwMyrR6oHvzRrlP2uzt2bWKLbgYw+e+kYo/HfYzroqk/tNWkGfS
         0DlLjuNfv0XlxcGNjx7QYtRQCxVlo5884TdDpq/mZseFfagGWHPCXCERRrlouf7S1pjk
         t+xA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTIs9Y8pa4vl83Y6/TM4wFUnItaoxLgdDZa2mILvl1MJq3MlHe/wcNEENRAVkJMwfFDH8tVdtP6n3FsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0M3I/tkz/GodqHlDjFaNNn2oslTOzBNGAzgZYhjhGZaaPHajF
	Rf21RrcNhd/Zq5xizy4i3QgDQpA1JbNHJS1o9DmAtixhXBfrVtZd5X177/j8dYY1VU8+USbuWsD
	20wa91AOwFDpgH94+xHwZjzbgBNQP4RNgXcSdUwm+eghOedkkuejJD73WQ2YXtohptA==
X-Gm-Gg: ASbGnctq5yeTY3lmAVaR2My1pnv0x/aTtSos+XGCil9JCZQ3pPagZc79VMIVJrOBwjn
	kEenBQL4Tb0YFHZ6iIYLbCFRDmvgredZIZsHsif3DojpwxqqU0xHvePFntO3DabG02n2lY9xUyd
	cIxRvqv1SMQtNzr24rgTFEDPLKyKARTzX5V+lbEAG5J/LOJ6uNDddXu/EKuCLYjhVlURxv+qhgw
	9fmMhsASsMj1twImbmawRrH7pt+CKVZxFr0zKgMPiilMVC+5j023jL22JjDUYCZJa1Dxyjiul+f
	7mvUr2qA1JUBn+afHYMYF9dQD5wpeU7GQiUVOPm6UgZ7Qovw54WhlCML+l1H4k0nJG6bgfm/ky2
	M283EIoOXXzrj996ku+XM6wIrBvgwWjZbB/qcSfnXwEseyGxWo5sZNXK4jyuWQmdt
X-Received: by 2002:a05:6000:230e:b0:3b7:5cd3:fc44 with SMTP id ffacd0b85a97d-3b7765ebbb7mr2029228f8f.4.1753458011473;
        Fri, 25 Jul 2025 08:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcFgs6H/wTKa9G+TeRTa7JgaCydFZvZ7XTEctddgKIUnysUc4LLUc3CS4Kto0KmSHn0+paOw==
X-Received: by 2002:a05:6000:230e:b0:3b7:5cd3:fc44 with SMTP id ffacd0b85a97d-3b7765ebbb7mr2029206f8f.4.1753458010930;
        Fri, 25 Jul 2025 08:40:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:ae00:cf93:b0dc:6bed:abc? (p200300d82f34ae00cf93b0dc6bed0abc.dip0.t-ipconnect.de. [2003:d8:2f34:ae00:cf93:b0dc:6bed:abc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4f40sm57086215e9.27.2025.07.25.08.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 08:40:10 -0700 (PDT)
Message-ID: <c5a52f8c-5819-4eca-be4d-9c534c6ad6bd@redhat.com>
Date: Fri, 25 Jul 2025 17:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
To: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rik van Riel
 <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
 <1d849190-214e-413e-a082-d7f862b653cc@suse.cz>
 <CAG48ez23CPO-m6kPaEs8kLUfRVCN+QMbsEn7BocfaJuq=gRwaA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAG48ez23CPO-m6kPaEs8kLUfRVCN+QMbsEn7BocfaJuq=gRwaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> +      */
>>> +     if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
>>
>> So you verified this compiles out completely without DEBUG_VM?
> 
> No, after David's suggestion to remove the explicit CONFIG_DEBUG_VM
> check, I looked at the definitions of these things to check that it's
> all just plain reads and arithmetic, and removed the CONFIG_DEBUG_VM
> check, but haven't actually compile-tested it.

The compiler seems to know its judo well.

-- 
Cheers,

David / dhildenb


