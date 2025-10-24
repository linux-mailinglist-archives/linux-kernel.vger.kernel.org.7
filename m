Return-Path: <linux-kernel+bounces-868307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED8C04DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCD33BFBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2621A2F3613;
	Fri, 24 Oct 2025 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHukCD29"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85772FF15E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291892; cv=none; b=f1SJF26rq5x/+RmXMG4nXHw4zBQMh1gHzgLc9ds36ZGbMWAysOnrma8VVmJ53CrMJiuiYJBUjwjp+B6y7g6nydx5mU0d/6xNiUMJZU7EFu6NmLSnVvQEpyddpF43GEWSavVWlRB64ngBYhPhQKmUmaf7RYUvGLuM2eU6NtXFXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291892; c=relaxed/simple;
	bh=gubDDxu6tIN7yoERLoHe6X3vP4BhnJfk7GZ/bCbTY2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDu52nBvIewgdISoC2Wiyp/663wB7/r64kOTDCZQu+pV+A7IvEgoAT+umLmZxcVChO0FHu2FPc9RS6xBr3rRk0FUgR/sKX9XOuHagoNWmHuGm+48TLomWISHqF/TeMGgT+XzKEGK/Wd4yCXDMm9GWyTyI0dJhtoJaAHHRtyLWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHukCD29; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761291889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cLrJNSiKylR34j7iZUW55zszPqmRqUTKJERo78AyDog=;
	b=aHukCD29obo8LSHsVsD6dj/igQkN4zommNybnfyATzZ0ibQ6D7qzelv1SGQrDVwTutyYES
	1JWYIrUH28rujvOqDs4/zz6QT3qesllU8Mv4zJQK4jLe+0z+z/GGIEJgK8s33oc+kKqA7N
	5wbtamp4gmXIrXjcIyn5d6cLvAfH1+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-CKsOt5oKMh668yFYttlsKw-1; Fri, 24 Oct 2025 03:44:48 -0400
X-MC-Unique: CKsOt5oKMh668yFYttlsKw-1
X-Mimecast-MFC-AGG-ID: CKsOt5oKMh668yFYttlsKw_1761291887
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47107fcb257so11375655e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291887; x=1761896687;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLrJNSiKylR34j7iZUW55zszPqmRqUTKJERo78AyDog=;
        b=p4l/U0DZuDHIKLPbdGTADNebMRow20ooxY7wz8Tb4Nx5hdHLWIGAnxtlHeZjFFX4cK
         0N13ywF4rTUmhD4EjVSVRxPwsw00hxbn366rW8qYawy2Kd0SRs1cujpolP9Tuc1WBcRP
         4CUkCG1i7NU+ciw2s2tgPJsAWppawod/m6Pe9xcnuMiUGBNmMkHY2p5Nsf0NX+8RfUPg
         5YdCrXzeZCP1EVb4QNYi/8OXt74kYWE6bX4CBHbKsX++WMoVyMKBlDDBAfCHQCAEvg+n
         5kWJo2G9uFYkjRFIzlz5+JLvt9dK6iVT8I0OCQ0YLXHzBS2EEu0rPB8X+gU0CtAuQHws
         88SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcM5dJ49P5nlW3qAI0mHmi/g+omgGaBKXOAA330E95t24tOQr6S7Df7lu4Uo6brFLxtQ6upyls6cqCdXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E5o+gYRrwuvsIERqAeSc28SjEG2Hc+rbbTiOkXXfC1ClrCWJ
	Q479FlG7Gj6cwgr6JyykIoJx93695hh8wzbR/f/FMgvbMLL1nwrbKPRnqaENBEiVGBLTmQ2OMSI
	TIJkktgYKhb2zYNpdfdR6sYZ2x/uoMwbAP4/Th9vOC7MZ+F1lusHhVqmXx3y/K1fCSQ==
X-Gm-Gg: ASbGncuthhFBotTW1PhdyrGAnQvx7tbc9BTXTDHQyfhB8mq4QL0K9Kw5hZl4avxYWEA
	WHf8Q9/g8cYV8W1cQPt+rU5JXK5HdLIqBqzBKnRL5cpzD0lx9obSPnl1kCsozIVw04sKGQSca/9
	jm5l97+99huENKL5lRPrsCGHJwE3IJfFrM4PewRuHEtVKPak5cGxmnALzjTDlsk7M0tQUIJb0+u
	rm7XeyBc1vZ/izgmoL0l+5fAEQLE9eAZyb+3xoLD4X0pmkOuKMFtK9dBrxpBwodJbwq0RGNP51U
	+5JzSf/HOsc5ISOW0ZycLMvFIwqcqrHZc6FUKsDVSYBM0DL5GsxK3Cnrk7b0KIEdZLWNKcFLB/T
	HkR9mvBb8MAKYHaV6qz0wUMzuV8lt7pq3nq6J/H8JkPdEu1KYVL6CHow4wRWFLV9ImVvHS22XuQ
	p1Og+qkTT2Fv9ypPM+FBC2fE6FuWs=
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr161139585e9.13.1761291887196;
        Fri, 24 Oct 2025 00:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwlvuk9VRwxu76UUh+uMXxcz7U8DQbC7bbY2MIM+6dZR2mZ+SIiDnqoou/qLDOKhlbcxHV9w==
X-Received: by 2002:a05:600c:3512:b0:46e:5b74:4858 with SMTP id 5b1f17b1804b1-47117877122mr161139345e9.13.1761291886817;
        Fri, 24 Oct 2025 00:44:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm78589885e9.0.2025.10.24.00.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:44:46 -0700 (PDT)
Message-ID: <38195001-4d89-4bbc-a505-440b139b9608@redhat.com>
Date: Fri, 24 Oct 2025 09:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20251024013137.136926-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251024013137.136926-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 03:31, Anshuman Khandual wrote:
> Add some [pte|pmd]_mkwrite_novma() relevant tests.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


