Return-Path: <linux-kernel+bounces-775077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C76B2BAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617DD16D47A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52C521B9D2;
	Tue, 19 Aug 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKAXGMW2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B943451DB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589520; cv=none; b=mtlplU2wPBFLdGayZzSezWxh2gCYxIPTzt5HFOdHtQBX3zeHQ21p1sDCeYJ9KRli07ac8DbS6uQXmS1+JYo7JyRXhxbAOeVUCwUpJw5RMya6RXby6W9T/fZgum7SF8p+nZOxgugETg9OoxaFbQW55Nlv409LW0QxFYrX6oM/neQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589520; c=relaxed/simple;
	bh=u1XdziIYi6XRyFp3TBjWcLKp69FAqDTV9qlwZWFUkXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4I5X/f/IQWOKrB2KiobrIySpIQ1GSiUzpMpUPE9hTdo/NycgxOUSADa/espWPnCz93yBI2oab75bv+qv3XiQ429tyHlm6bR/qC/KoHsWo0mpk3kwzP+Ly69rnP68LhdI0n4gNRWks62UGBTMkT0gnPf/nzZAQc9lMoOrTbpv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKAXGMW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755589517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jaSsyvGbvSM38Wd/2ZkaS08nr9HXu1O6vpmRgr2LSpc=;
	b=RKAXGMW2Tf30gos3JGx5s9mXeCLkH5liSK7V8SMyWDSofrvy6VR7BFQlG9Nwi4mWpa0hck
	kHaOiifsB0WssqLzVgZKc8HoAkl6fq4psAoUMPVU9V03GUwhWkDkT32vYjlEr8C7m4bO1+
	f0bBeqGQvU898frya2C7n2MfV2yJ6dU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-kSkkLhMWNemzAzK5mBBWJg-1; Tue, 19 Aug 2025 03:45:15 -0400
X-MC-Unique: kSkkLhMWNemzAzK5mBBWJg-1
X-Mimecast-MFC-AGG-ID: kSkkLhMWNemzAzK5mBBWJg_1755589514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso29703235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589514; x=1756194314;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaSsyvGbvSM38Wd/2ZkaS08nr9HXu1O6vpmRgr2LSpc=;
        b=ZRJur1bm3XV1eHq05OW8k26SovwRAi93ZNAx21DULaWa4R+0gw9uuMElCuQnCHRIPy
         kQTMXaL79/xi9pkKt11wMm0XFBBZB4vyoF9GMSZqzq4TlPGUzVjt3ndhuBuwXyGmSlhm
         DaI3HPae0rofeo1FDEuuO345ds9rQVCMhneOG+qzH6RpnjUDkKA/lxOHuM45WtGpZaZJ
         MF2LrOidJKL7c1BYqCh3bY+xDh8R/VdisQU2WISu0hDr2cfF6Rt6GBOxPcNQsIXxwufY
         qDVbthai3gm1mOM+sPL+ZyUsQfeJssceEHQNtplxIsfCVsYiPBnGSHtzBW0CIpGjwyVI
         AdXA==
X-Forwarded-Encrypted: i=1; AJvYcCUaXDHOBVYOAsoTybl0Jb0dDclZTAybk5lvYSi3AhwC4AYQKVU5TI4FYIzK+anGXpW3PZpIsUadz2YMcDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLGcP8BBNqC7H5d4eeL6oKblb0p9+lKZhTYz16FyjjSCdK8k1
	LCrb9B0FWr+knfvop/Rv69oomQ99xJTHY+eO1pZoIDKxUu29AxKUJ9mWYF45Z8mBGNPp28VRY+s
	3mTUqEXE8ZeVTipXzU7t7m1K6X1sLT6icJBki9NSspiT238GOUQJMqcQ7blQuRnHNyg==
X-Gm-Gg: ASbGncu24BqGkPL/Ex4iUPCStiWupAsLlwChE7x+PQ5sBowNkaiFZBA2uUfzRlkj/dc
	5it7ssmKgkVO+mp1YjeMIf7Icm4h4Mr2gciqk77Q6smTx8Stoa/Nrf5XgR5nm6xbbx5eiQybzdF
	7Ql6qufu9TToXzehuBY6nfvCPgdzs91SSTbaleEUzr1+Suy98mHGcRbqec7XAxMQER5ztPxfoPu
	QMaHyCTw75D9qzDMq+iYVMT81RW04Z87LJ2VBB0zNeA/raNnUxeimqosSPLLD2szqLX9BeI91bk
	KEOZVTtJHU2U0i3/s5UG5EVD1rNjjjQn44E/jjhrnXgimA00C+v/4bvWBsC7gXLX+FnSOw0FS++
	e32MXBctxT5Yk1X4tBMX4F5q62SUo+fr3FkFBOjfvaHhRBmv1tAR8NEs4v01ogEHr3L4=
X-Received: by 2002:a05:600c:a47:b0:458:bfe1:4a91 with SMTP id 5b1f17b1804b1-45b43df3bdfmr9399165e9.20.1755589513686;
        Tue, 19 Aug 2025 00:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GRVXz7Cx6EgfusRet+O1WDwTGD7wA+6B/968k+/fs2jCw0lM6Ro9nUD4E26sceRnKdIeog==
X-Received: by 2002:a05:600c:a47:b0:458:bfe1:4a91 with SMTP id 5b1f17b1804b1-45b43df3bdfmr9398795e9.20.1755589513162;
        Tue, 19 Aug 2025 00:45:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a97c02sm30232865e9.23.2025.08.19.00.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:45:12 -0700 (PDT)
Message-ID: <b6e79117-bc16-41d9-b981-3610ee2919b5@redhat.com>
Date: Tue, 19 Aug 2025 09:45:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm/mm_init: deferred_init_memmap: use a job per zone
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Bill Wendling <morbo@google.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>, Justin Stitt <justinstitt@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-3-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250818064615.505641-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 08:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> deferred_init_memmap() loops over free memory ranges and creates a
> padata_mt_job for every free range that intersects with the zone being
> initialized.
> 
> padata_do_multithreaded() then splits every such range to several chunks
> and runs a thread that initializes struct pages in that chunk using
> deferred_init_memmap_chunk(). The number of threads is limited by amount of
> the CPUs on the node (or 1 for memoryless nodes).
> 
> Looping through free memory ranges is then repeated in
> deferred_init_memmap_chunk() first to find the first range that should be
> initialized and then to traverse the ranges until the end of the chunk is
> reached.
> 
> Remove the loop over free memory regions in deferred_init_memmap() and pass
> the entire zone to padata_do_multithreaded() so that it will be divided to
> several chunks by the parallelization code.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


