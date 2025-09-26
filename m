Return-Path: <linux-kernel+bounces-834267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6EBA44D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698241B23D32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C919B1E5205;
	Fri, 26 Sep 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+HWnP4T"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7438DE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898499; cv=none; b=r0as4Gl/VUGfa5u0pqyx7skg1zbmNZooZC0ES7hYP9JW1YFJ5rQEFDgTp2oLxiLL85lVkRYhwFI3cBT1l6a2lZrUB32BTB9DZ0lP84/C/LB2NoIRKOvrIydR15rnJyALScaSgGXWQzJWfxH4g8Uw2GDmgqDerVQ2jD8CNi8egdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898499; c=relaxed/simple;
	bh=rJ4vWF2I9u61rArQ5Dfe472q6LLKDmCPOmpVjXV2tl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r99PyR8N8OwLiJN3D5Exn/1ZfURlK2AY8RDlNDPwDzTTBYElUecYc03qehxdVFiC6A+bEtwW54f5aYde+DLGcDQWF+KitkGSI2UsjxKb0PzeO9HSOnUALPyhdVSBrhcW7dJEXA3bLadA2vEZD+KoYkn2JaOlDqMFyEwqEUDvycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+HWnP4T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so21967495e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898494; x=1759503294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BY05iPvOa2qw1XDOJIPHyncKPIyxi1vtKF/LrunZtR4=;
        b=Q+HWnP4TqimxGrg5UJ9weoSuOJhYG/cB5FuD8kkPvMfr7WKY/Q8QAJ7WNojEGvyMHN
         90zURz7aS+ivth3s5DUi8HCjVFL2xcBi58zxWfYpNzfPwoyi9J4NvPn6HBJARXxC7pT1
         J4wmqH1ZsVAgPLJmqQ6CtQipQyqvjKJpTg3VmiPfHBUgpxSYhvrsC6HlmEAlkWqn8XK+
         uTyvLMb1y7dmreIqYzXOqXny/5JQ47o/IjAVlg4uVEDjRSunxAXR+Lu+5g46Y/VPuc5d
         c09bAMl1aJJ8z/BVl//bVr7z8VuR8FRW6pmApcR8INgAt6GjXfyJknnjGQ1CxI8M2f97
         8XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898494; x=1759503294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY05iPvOa2qw1XDOJIPHyncKPIyxi1vtKF/LrunZtR4=;
        b=Eq2Ozir36sfG9M+Y7KpUsF6WDxMOyATAgSpkeZsJvH+Qr1azWsw9qFtir2Kzmc+8ya
         pQIHQ5OKSZsmo7LkLnlFormCHQNcd90fxocdldeujcJgDtgT749sK0CKcapx5Q4h2SvQ
         9ag7eERyRvaUv2NUui4O64QS+48r2UQcbFVnAoB/TnAIdfrANLgaflfiPutCNMwCzBrE
         xoj4k3jNuW3ejG2hcnuqp79QFXsDwFldMEUUDk/b5N+oHDjF1/he8HieztR/bU/aKxkt
         6DtLmsB1QsKxSYYomEJRZKLpCP8/P6+/1NRdmjSuhK+BwTb5Xrrak7DPRFkY/JN0QNRO
         UsyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNPHZ5+gOw8rUFs8GwIlT86WjkryaxTE+39io9eROr1zl3v/aNbBPNASjMhMIvaeyhiZZHBltIDhwkFWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgWq7OQDX9i//ZSbYU/UhCdh02OWJPfYwM/+5E+6eux/RUYlA
	MruUTWcblUVy7bOWZDl6oKHmNnx265yKQsMCwIEskNquw/w0xit0TR1d
X-Gm-Gg: ASbGnctHQKL10mjb8+AwoNad4fajz6S4tQM2Gm6Hd3TTh2eBduJICRsMqrhL1ZDxI7z
	zAW9whOubc0CoJg29z+3YYWOxuW9SSvu6Mc13DmfQZJQl+ECyyQCk1WeTQW31qJ6HJais7Him03
	LFVfOVzAqy5Q3ipQ74FaCg6fwoeemayOVpVehcqmCRmrw+HRJYK72FLmAVkWtOu3NxDvjhshxYP
	cz5c+lfKKw9Xm7UCKoEJeviJ4U8bivIz4LnHJsQp40ddxUjOI0mb86WgPEEMLMDWn2nQJav3Uac
	p4DWG0whlINbqHoltRkySJfgen+CWFBgufdAutkPQ7BpzhdFTPB8OpdGlrMpYcfO0f+4Yq1yDLb
	IoKWtOtcI6h+NvSeGmEiz7rtRwCmfn6wLxS4+2Y2iRpMkLS19cp7DV6/+m+TQXNj3vlk96kKgYe
	RkCj3TuDxym2PQKqHvoTZEOYbYTVAzBhUjaw==
X-Google-Smtp-Source: AGHT+IH6XAUFoxCMg08arme1K9l+Tyhl3fwi9t5NToKIciERmlCjEeowzXgbzR1NtvHV+IE4Iod1mg==
X-Received: by 2002:a05:600c:3b10:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e3299a5aamr71003245e9.7.1758898494406;
        Fri, 26 Sep 2025 07:54:54 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31f1dsm119224235e9.13.2025.09.26.07.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 07:54:53 -0700 (PDT)
Message-ID: <4b8817a4-5b17-4fa1-bc07-1808b495b8b8@gmail.com>
Date: Fri, 26 Sep 2025 15:54:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 03/12] mm: thp: remove vm_flags parameter from
 thp_vma_allowable_order()
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com,
 shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926093343.1000-1-laoar.shao@gmail.com>
 <20250926093343.1000-4-laoar.shao@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250926093343.1000-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26/09/2025 10:33, Yafang Shao wrote:
> Because all calls to thp_vma_allowable_order() pass vma->vm_flags as the
> vma_flags argument, we can remove the parameter and have the function
> access vma->vm_flags directly.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  fs/proc/task_mmu.c      |  3 +--
>  include/linux/huge_mm.h | 16 ++++++++--------
>  mm/huge_memory.c        |  4 ++--
>  mm/khugepaged.c         | 10 +++++-----
>  mm/memory.c             | 11 +++++------
>  mm/shmem.c              |  2 +-
>  6 files changed, 22 insertions(+), 24 deletions(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>

