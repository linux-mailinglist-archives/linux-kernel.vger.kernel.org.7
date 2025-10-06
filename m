Return-Path: <linux-kernel+bounces-842607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F9BBD24B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0636118938AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545B253939;
	Mon,  6 Oct 2025 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UazIaBcR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBF253B5C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759732484; cv=none; b=ZQG/5Fj5pkfTsQ6NJUaWUCSxdP03b3NQAWQ7SLIPIdmWNa0O4AzcAhzWUQU3QZxTQlI7lqmBydpJJbDddj/TlVrYEY3a7gtSM8hzO4CZA25VKCRJRpZM8YgyEulDDChjKvrkVnpTw/1S3HLtGzDwE4i6O6tj2bsBoGI7tOqQfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759732484; c=relaxed/simple;
	bh=YojLn6i603g2epqsX/N9XT7Ggoavqn8q3Zxz9I4FnX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK0kZip5sA6LXGAInXSOtl7wisOoBd6E/9upvpiwkYXiS4il1SERJgw2tZ4zHcg+HdJMMHBXmtDbSYZh2ry+wRK6xxcpNazlFyE5iBvVELYCFdsmaICuFTAjCsV7jm4dv4OSAPUw/ZppLsnBms12yFB7avqHOLSKPHRz/6+esPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UazIaBcR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759732481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nksCC2zzYk2DM+W1S5KM4R8l8BvMYBZj+rsznw3niOo=;
	b=UazIaBcRF4YMfNoJ69sgTphkUo9ivcYAg+dZ9NcHVdGEHAA7VUA2zw2FIkhXQkLgb6/upa
	2Gs0MDynSn3tPHXQl+17xYTgxRj3VRj/PblClY8QMdIzpr/DX0zAoVK3xdRRQEw8rDLl79
	Q/ANhKeV6yak+hq0G+HISS6Vbmm2lKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-C3wHmrcOOKOV3dSjkPCxwA-1; Mon, 06 Oct 2025 02:34:39 -0400
X-MC-Unique: C3wHmrcOOKOV3dSjkPCxwA-1
X-Mimecast-MFC-AGG-ID: C3wHmrcOOKOV3dSjkPCxwA_1759732479
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so1509665e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759732478; x=1760337278;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nksCC2zzYk2DM+W1S5KM4R8l8BvMYBZj+rsznw3niOo=;
        b=gGF7t3pl+bC2ggE/gWnhs+du0JGsJ6XjixYZx1Kbgp0s9jNsLyxjUexl2AwjegyWbf
         2hXXkOUN7m8Z+pB/Pl7s/qH/biYwJDlq5VfXqoAhCP2k860xLVB3eNyNGwy3QFHcv3KR
         JKYpxTtvir82S15LXAXovuKRWSQLs0whPmtE2pVnfWyb6iYQDuD4cIrR8uwoRWk1DYIw
         hIwjnRnryyEpP+rsKYmyoZfJZtXLeqtf7Yugohsb+rzRrZ6FrR3RZI/PXWb+hiX8AG3T
         xO+CaH4eW3jkJ1RZ6PrKPqoIc0CMtIKdFzmjZUKvXPTXcfzp85k7MPeCDdMjbuF1mbsO
         higg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrHhGQw0xc76Brdcxh+5XE+hOh7fyMmAWmwzk5dbiBrjqcAojEBoqji1PB5JC0LzRZFVQm7N6t7mQg7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzXeuvQkgRDtItJ8Z5AcAgpx+uqJVNv+99m5NEdOpfWhRMVUT
	sAkCLVhCQJ7XbGBGeaJEw6hS8rPA38v8h9dIgeWLiGzYjKcr7Eu062o7u6zyhCaj6qVCxWAG/yi
	GTyu5kU9v5N+LNQpDQWLCeHTEYFIXNOVX9kRaZ0M6MSDhBsUjnRoVTvxLQ4D4S3A/yaQaYiHbQA
	==
X-Gm-Gg: ASbGnctAulihz3CS/N+dlRNCl3sNBT5mPzRIlRKd7eXoU+oOWBa3H5Yo4XlOpUs945a
	VrcyoXYVMY8Yneaqh8K8VY9aruk+ENVtgox/kqD0akNsTm7rg47g2EOtwzQvO54t2GKU5HMLZYG
	RZ8s5ZsQJHQlrE5++rse8G+HJzTBoR2E6xZHcm09dzylE6yqTJOQMonNzox6Uo1eH/kLFqPPytK
	Y/ouZuEeXLXap4kAzsuHRt+IJYRaSGYfz7djmTnc5Za2V+Pk5xvmGE3fXu9RxZYfISPzjJK7VCY
	88YgobqePHLRLQJq9lTiTXzhPsSEuS4IxArgQwHbKwgPhA4u8RxRk0XUjm3W3EGKH8hRHMhQGWC
	/ZU6diJgA
X-Received: by 2002:a05:600c:c176:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-46e70c5a8f1mr77732265e9.5.1759732478664;
        Sun, 05 Oct 2025 23:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyw9ASmRzvvDBMljvs6RWnytS9ZK0D//kmm9mdCgi148a4ifRTj6KbJkrbUXq3XwyRgPJurQ==
X-Received: by 2002:a05:600c:c176:b0:46e:6339:79c5 with SMTP id 5b1f17b1804b1-46e70c5a8f1mr77732115e9.5.1759732478276;
        Sun, 05 Oct 2025 23:34:38 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234e5fdsm144553375e9.6.2025.10.05.23.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:34:37 -0700 (PDT)
Message-ID: <fd1dc222-3d33-4d94-a56e-423255ed0588@redhat.com>
Date: Mon, 6 Oct 2025 08:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251006055214.1845342-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 07:52, Anshuman Khandual wrote:
> Replace READ_ONCE() with a standard page table accessor i.e pudp_get() that
> anyways defaults into READ_ONCE() in cases where platform does not override
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


