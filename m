Return-Path: <linux-kernel+bounces-888311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC200C3A7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 808B34FF6E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780CD30CD85;
	Thu,  6 Nov 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFsaGLaa"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD32E7F27
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427285; cv=none; b=uksLh+fOVYt44008A6LF99mA5TQOuRpkfI0yR+KFb6Yd3NhjLyh1JvsPb32HCgRgzDvHtIQ/LMlmn/p2WL9G3ABC9ltmceN44Sy/Hvt1dz/E/t1n3PTtv5rw9AKY1zNm6tqxpNMcIcEbQYo+blCAX5NGJy4EAi7y6tYDwhOpLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427285; c=relaxed/simple;
	bh=iflFF8uGA+JQqg5PeOnkh0xBZA/LPV6uIzaa7UsyVRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG+NHAqxsRMSrM5/L/YbSMqeQopZzKEjUL2teiwaLYnkhEyY91/uRC1atzTTKKryA7JbMlcHIKB+ZTX5srMH4VnxPXmFSmzT+MtSzsf7kYAQ2Ga78ZLl0WbphKtO618S7PWvAkRz+vMEbfMaIywyX1jUSXK0EV7Ii4/22M0gQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFsaGLaa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47117f92e32so6523945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427281; x=1763032081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=lFsaGLaav2Wzq+kdJsJU1Wb4wW+hsZE5/nqsyi2eb0dBlUw0xGSjTlzzn4Sa1cJnLz
         qOyyIeD4YWjmrVzmwvu8aLSvJiCrNWiWtPu3V2gOXZd2hOq/2CFDkuqVKsyHc8xWaV+2
         UnIEinVpCzCm1HQ4R8dAMK+BQyH5QFyCxuMW0Wu90+6fKHiCDqa85zysgdJoHRrOgGTY
         4TuJETudPaQ70g6dro3pDcNu6mNd5AGjgpMzdSEf+ANdVpng/0xQwNfcTBWXI4fgmKma
         Gx1wfD/x+CU3EW9C3Q90NaljRbG7J9kS+1tSE2oTZqfxywlZzb1JbKbJFTSXG8MyWUxe
         SNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427281; x=1763032081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KemrrCvE16IUsPvIdPc7ZklZCJchRhA/4dXIse7pcqc=;
        b=bLDvshp7HJmvGTiWMpAC91+3XPlRVW0Eq0WsYoRqxk/LiR7Om4l9T1+iaYsOzT0jcD
         MjemR9Q7m+FCtYcO0JIZ9nMrKt9pi5UAO+dYC4MVcG6iFOGiYkUh9Lm9voXd9eyFboXF
         nqRMXkC4GzAgeCSRnmTfbXm6fyI9AT0o2RnDD6O15KBffGQwJ1rDwccejr3pAerrCpXs
         X743k3Zohu5hJAeuKd1J1jx8I82DtBeNmyssI2lmViQi7j8LRq02W9RWwYLQus4Z7loK
         APehEs7E8ueGBVNpI/b66A3hxWhquSD52opC1p6kzUMpW7kistodVZFdBusbODr+0K37
         JWUg==
X-Gm-Message-State: AOJu0Yx+dUoErRyx0+32JoPqWPl4c0iZH2QDN0iOQjUzx4epE7G0bGgt
	kKUBbVGNdMICsBsXn5kGtlrmSbtPORXnnjPSny0ADC/OC/3XLKdZZYfI
X-Gm-Gg: ASbGncuYaukjjFqg+IMFRkbJS1iZLzitnrAdnYi/venq2ZFlsn3CyVxGs3dnH6KRIIs
	oJJkFVgxkXrAGbfytUh57fbPpLrlo7/6Hb9YQTWO9zXZjsRbyqKbsbT2JxQm9bKGMC+vucPfYxb
	6BXnOXDzoWXw0bw+u0ZQLV4PWYpMU1/8y8xvoN6kzGmzzJlRMM67k6mKKnbfMJZdh6U4/2xPkH2
	Q8J0qCLQD5aQqqvPkQUVNkQZdn2JjJYJNbekXZp4klUXhWZr08JY7JstF72PIBDnNWxTkZccy04
	nitvDVvLbeC18RzMz3kds71tagSc+1ZGBy8yobZzCwLpApZPv6G50/4FECHjiXJTtZax0NFCrCl
	ofjTDQJBQZOFljCRxQynBdU/6e0RcVg7Jr+u5JhDlpH5mK04Mm5ZvcxWR0K8WabLB8bz2XyuqoD
	KvVzAIWWUfus1SPK3C7sgQs1FhoU89vHAXansITxK8FfjhZ5FLES4=
X-Google-Smtp-Source: AGHT+IG/WPvgkkz5ima282cKyz2di1ByWQE6/QNBfZEdI+atynO653MZ5MMOXdVnpoH97C2BXp1trA==
X-Received: by 2002:a05:6000:250a:b0:426:ee44:6d9 with SMTP id ffacd0b85a97d-429e32e3595mr5318368f8f.21.1762427280858;
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb403849sm4648357f8f.1.2025.11.06.03.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:00 -0800 (PST)
Message-ID: <785c9d27-23e7-4ecf-ad2e-202ba506f2e0@gmail.com>
Date: Thu, 6 Nov 2025 11:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we will instead leverage the page_type in struct
> page, such as PGTY_netpp, for this purpose.
> 
> That works for page-backed network memory.  However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.
> 
> For net_iov not page-backed, initialize it using nmdesc->pp = NULL in
> net_devmem_bind_dmabuf() and using kvmalloc_array(__GFP_ZERO) in
> io_zcrx_create_area() so that netmem_is_pp() can check if nmdesc->pp is
> !NULL to confirm its usage as page pool.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


