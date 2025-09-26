Return-Path: <linux-kernel+bounces-834304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CBABA4624
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361A07B088B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862A2192E4;
	Fri, 26 Sep 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDD3xchw"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEE217716
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899987; cv=none; b=Uq7Tefh4AWIW+xsR6AFbGXP7hTTiCt3nAY/iPBUnwsEQicd0Yc9xe/lOSefsr+sW1BLAeOL/9AnFAh9B3kPzRTs83gYwFrB6+ZkwAeL8W6CQJaYoIPCVApXP3s/uMgoSzwvWbm6Q++nOLkBGE5YF5Wex08eC9ezULcL9k3KFSd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899987; c=relaxed/simple;
	bh=2XTLs4doltlPuCdYFOVv4qEsvroIMNWoNu+9BpzlsAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p51stze7Z8nlilrt0GiQxerX3cGnUzQ1FSXISkLyoXU0bR8u6zk+Z3PNYC5lFvr6KQu0S95+aR6AHiJjBdrxQeJ7DNUtMgPQTFxw78CU4aAuzXXDZ+bJRJfB2njWjyGA9ZzIhuf53He+fO/cf4KBH3V4GSvGVASRdR6mtB/7f08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDD3xchw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1686868f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758899984; x=1759504784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWlR0y/Sux61rdpKVNHDRpox6sYOOn7qAYyRTBv/JhA=;
        b=WDD3xchwUJXWqIVv0OYJtLca4TTpdEF98mfveF1/kGNklukMa3WR+wJrd8Z2v2Kr9s
         8qLa0J1OWNimYBLg/iAPwHoKRCzacxdE8bKGf3ZiIz6fzOuu+aFF05OH0ANYzNnevtDZ
         7Rnq+4j3BCCnHx5U+5Uu0qVQV60BcQvMA54iFpzDq6NvcQ3zrHRsiYuvKhkq1WEIK18M
         v5y5vNxpXhjchwFfgSfGW5SITLRAxjkzRLDOcjDlnYf+BYi2ItdZ2+6co7Z9uBEo0drV
         lOX75b0TxB2+CCvyboL4T/vPoIiw81pKWDy5+DjNruoobJq858MM/aY5gdnRBo2qSw4w
         owAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899984; x=1759504784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWlR0y/Sux61rdpKVNHDRpox6sYOOn7qAYyRTBv/JhA=;
        b=RzT6iNTzSleY+rClHceExVwxtwClJr4NbHbaq4qryXIBj0rayDgGZx869ggZj2eKdW
         1hxG94UNVaLstfx2DhxhP7D+TBj1smqpzUd9LhhkEuUG4Ryb1MYWEIOTw68ul7/KGAE6
         n3pHsKkcwvsPWR+wubtDRPZ29uEN0LpCoP+waHWHBDFjc/2laYl0fWulr7W9qIUiMF4K
         5BMuQY50MXL8gHD/mmIkhGyjB3qOza8TwyLc6fXIAi0Aixq7iaG3OqaKtrmZgTMX1eB9
         VAsQfYNWnrY5G+nEC0l1f6B4WdznazKSmLj4K9nN08Tfp6wRlcL4lS6CqWJteo9r3CTW
         pN/A==
X-Forwarded-Encrypted: i=1; AJvYcCVEMtq3xibqFzOczw20juuRaQWfL/0at2tWZGC6Pjb+DWP60sYR1h9+nfuVtQ1GfR+45ATKJbGo1y1KSl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW8ZgFZ3WpxK1kWg9uXU5Qt7zlN5dDe3luDuvpYVOZLeqCic+
	e3xEmslRL8jX6g8k6Jc5xy7Mw38CAuhToEactf9S/e4LYmF7A+3mqA88
X-Gm-Gg: ASbGnctNpMVALT7r8cr2s7R8RjbbKGJVaUscnnLuX33PeVGmQhs/YP7IkDGL4tX6/oz
	ZMrDiLwyKj73x0qDOGlEqT2YkZ+ErX05BTgSbqOVnVzjRRFfj0oOD1r+jowlEnmHTW5mJLc3naS
	7MMs71SW4YD6frP394i3AJRzxbYWJLbk5+0PU+OUBsstdDH/Y2OpQadrLUMIFz6bFvPqIyVzTQP
	9EPfvj5ib2KUH2rSqZur+zzqri02DqHZSn8vTzAQttwjmGLh+jzc+E1Vc/Q8/bLaFf8kkGuC2L+
	J8ejgPAvhS0Q8k1pDXs7vRAk6jqCslQMPSj5GUV9Qfc56u6NeqiuKbI8W2wbHnCgehLlskPJCCv
	4/kD0yNIVGJTG+fmh/GDI3aEGQ/Dle7Rp4WQBhiNDKi6eU85xViE5nrEsmRK2ZntVxPy/IjdSsw
	sbl1gBTm7Cn7DkdXv0PHeEACa+2kgiwcyaUpYaLxA=
X-Google-Smtp-Source: AGHT+IEa1G8Cv8YRgqFXmAP3TAlQSquRLXr05PhtZGwjiNd0B//b+MGhp44cDbdJLfkDnbto9V3Cwg==
X-Received: by 2002:a05:6000:1889:b0:3f8:8aa7:465d with SMTP id ffacd0b85a97d-40e4adce7e4mr6096265f8f.30.1758899983520;
        Fri, 26 Sep 2025 08:19:43 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab6a514sm120108055e9.22.2025.09.26.08.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 08:19:42 -0700 (PDT)
Message-ID: <37ec3e8b-e46d-40d4-826d-b4b2378015cb@gmail.com>
Date: Fri, 26 Sep 2025 16:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 mm-new 05/12] mm: thp: decouple THP allocation between
 swap and page fault paths
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
 <20250926093343.1000-6-laoar.shao@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250926093343.1000-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/09/2025 10:33, Yafang Shao wrote:
> The new BPF capability enables finer-grained THP policy decisions by
> introducing separate handling for swap faults versus normal page faults.
> 
> As highlighted by Barry:
> 
>   We’ve observed that swapping in large folios can lead to more
>   swap thrashing for some workloads- e.g. kernel build. Consequently,
>   some workloads might prefer swapping in smaller folios than those
>   allocated by alloc_anon_folio().
> 
> While prtcl() could potentially be extended to leverage this new policy,
> doing so would require modifications to the uAPI.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Barry Song <21cnbao@gmail.com>
> ---
>  include/linux/huge_mm.h | 3 ++-
>  mm/huge_memory.c        | 2 +-
>  mm/memory.c             | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 

Acked-by: Usama Arif <usamaarif642@gmail.com>

