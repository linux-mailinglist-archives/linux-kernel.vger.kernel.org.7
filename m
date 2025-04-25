Return-Path: <linux-kernel+bounces-619919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1328A9C369
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBD87B0D17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85C23644D;
	Fri, 25 Apr 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixa1bzlD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECD23643F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573228; cv=none; b=J3aIDRa8fJq/xPv3TKdaaNOeLb1pcwPVEwIadm9IyePFhD88aUbmzHNbvWuq7FHiIcTH4yRhu7B58VgTgNRZAzdXvRg//rBZgprRwcL9/sVwqOTaBfJKAQ48TKI2nXedr55ojfmB/kpFwJbZ1zyFmr/xs+IYvh00PN98E5KdVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573228; c=relaxed/simple;
	bh=wIdBjLUz4OSq7cgx0l4vpv2XD2JXu/WXR3GCO08HM4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qur1vRVz5OfzikvWLBEP/Sa5OSu5caCfaf1zaDdpoWpt4ySTsROcfmEszb1zeE+yviqzIoDv24U026nWedFxoNaWtAPNsKL811EMj6/FB/xkMwzlaWm04xz+f5WTqrpjnJUUYqGSOg87Gqw7t6h0sJQ1AIFEzDOSGlREVKKvXss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixa1bzlD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745573226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8eqLytJIQY/pnCK/wv0GRjy/uV2gVRfHwFR8LZ6llRk=;
	b=ixa1bzlDd1fTdTou7/BwY/ENrO2AC8uCnCBHmceNbMR/ot7QPNXLu3w/FwxwktUGMAz0Hl
	OHVlfyzutKg0/GdY+KNQPHO/UGRbx2UT4z1FM1f4jRGRk2eIO14Ub+U5BYX+4kSFYIuKZ7
	BrPoS+ZcYGLeqxygpjzFaM+cPop8fLs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-iih2VyAAMhahPynSIGO5fQ-1; Fri, 25 Apr 2025 05:27:04 -0400
X-MC-Unique: iih2VyAAMhahPynSIGO5fQ-1
X-Mimecast-MFC-AGG-ID: iih2VyAAMhahPynSIGO5fQ_1745573223
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so12016295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745573223; x=1746178023;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8eqLytJIQY/pnCK/wv0GRjy/uV2gVRfHwFR8LZ6llRk=;
        b=qlcdiCgHxVQSf6Xv/6pAOGEAZg+6AJJ0enAY8ta/gez0xhsyQOtmAH6j8cPi9FYe+4
         g353adcT2rYu+Be8Js/MmvQY7XkaKiFTE2GlESrY9YrMCE56EVYzYpMsnnuD+mIzx2JV
         n/zsc/VwKACmlKoUNnhycb1XBC6fE8VMgNfqO4KhTLnX1CKJM+JIqTiPivizjXWapTSJ
         xtJ4DCB9bONuUJF7463DhS7umqdX/Hj5v8EIqUOgUQIRsci5GjZwL6tnWgMiGljF1tZU
         kY4EY8RmfbeUg/r0lvVWYHZKseCPSsWkbjH+sH6epb4u18FJ70nDnW2seWgl0YRMlahx
         E7fg==
X-Gm-Message-State: AOJu0YwAwkhlmvP5KkDih5KhamA9dowpFXO+KtEPXWCZ2M5eBW9lahPd
	O11sReabTv2XSrccZvvy47vjHPGSKmgl5t9u/vbojon3jqj2y4tAHlQ5wCxUctGzlDB9EZtMcco
	BxwwbmTgwO4DZJZ236sx9Dd6eM8B+yVUVU4zlXvbLqoch7gp/CE5MtERuQHqjrQ==
X-Gm-Gg: ASbGncssJynEgOxbzi91mfEAuhZW+IcwjZp0U764WHTKbMSy9I1L+UwWXoj9727gt32
	945axcHLjExFiqkrqM/gTHFWx62Isjg+umNKfl3gX/eT1u3ERLt507WT9F5HUjb1WMRzyrPZheM
	X47ZkAEZOid0pm+flRzs+X6/5qibQ3g2xl6n+EyWMgCs5t89/tOG6vX1j+gaW0QOfnh0tEYRe5o
	ATmw1UMlqQ492Mfbh7/BLRTJaEDC5E2as9do01EgdHyDJLf+sKNb1L3V5zJIEEMtZzxq1zNrlIr
	OUcl7yXrgn8LFFpleUgf08NPw9ZGQaaBT4lAR+pdAA==
X-Received: by 2002:a05:600c:1f82:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-440a6347ff9mr13026505e9.0.1745573222956;
        Fri, 25 Apr 2025 02:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7LbS9YRQ5wCXB84Jy7eT6u2rOjZc7kKIwIhV5LjW+hBQBfoI1k6U1ecprzUpbxRl2y0xrg==
X-Received: by 2002:a05:600c:1f82:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-440a6347ff9mr13026355e9.0.1745573222548;
        Fri, 25 Apr 2025 02:27:02 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23df8.dip0.t-ipconnect.de. [79.242.61.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a52f8915sm18804175e9.7.2025.04.25.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 02:27:02 -0700 (PDT)
Message-ID: <c69f782b-798d-459d-b7fb-c2d7c7e30372@redhat.com>
Date: Fri, 25 Apr 2025 11:27:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] mm: rewrite pfnmap tracking and remove VM_PAT
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
 <aAtNy6VjUvOrOC7r@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aAtNy6VjUvOrOC7r@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> There will be some clash with [1], but nothing that cannot be sorted out
>> easily by moving the functions added to kernel/fork.c to wherever the vma
>> bits will live.
>>
>> Briefly tested with some basic /dev/mem test I crafted. I want to convert
>> them to selftests, but that might or might not require a bit of
>> more work (e.g., /dev/mem accessibility).
> 
> So for the x86 bits, once it passes review by the fine MM folks:
> 
>    Acked-by: Ingo Molnar <mingo@kernel.org>
> 

Thanks!

> And I suppose this rewrite will be carried in -mm?

Yes, will make conflicts with Lorenzo's work easier to resolve (in 
whatever order this ends up going in). I suspect there are not many PAT 
related things on the horizon.

-- 
Cheers,

David / dhildenb


