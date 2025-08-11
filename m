Return-Path: <linux-kernel+bounces-763192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE59B211D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769875065EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318841A9FA8;
	Mon, 11 Aug 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM3vujkw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F11A9F89
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928382; cv=none; b=VWRIpzDA5pOaXcdI++MUmohzWtJPLvKBUX+8ewa2gfyi0XD8XrrYXasEaYz1ept8mTCGyQGxAB6bd2iG2ZDEow8V8SPikX0etlQC3ciClyDLETux8M8o3bZ8euWdANgOHMOcBkRnQGZ0sJ/hGjDKTLi0vLiLoHDierbjNSZq+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928382; c=relaxed/simple;
	bh=cjjSPubqADsR+Z507kmUtGbe1mle1SWRQ986s5Ka0Ss=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FgpVJJKRNdiX00Cij/83ue+Zs6iToxq9ULZPi5tCBw0yONQtIhdWir20dD5Bok2+k8mxebs6Mhq6XZ3xUJMBl2xM14EOZX2/GAzqSVO5Ry7BSZVp+GOEQM15/hSmZpoBA8uxruFa9hGtdBeVekSizcFyl9EgV8tYF9u+OrXj7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM3vujkw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-242d1e947feso347475ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754928379; x=1755533179; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4XB7rbDMRDvsKK6fD02IRXzMhRU39sjlSTEErIcNrs=;
        b=rM3vujkwwch/fOckHaSSwk0iBSRHizMmQ6SNtL90ecw4wqnKkpN1K6GzZMkV0K3kqz
         OsM3noD45sglL9HRZ5pbFDlUnu927KGQ9l1CSTHZRl8xS5M7WeBzTf8C31XYLIUX6Ypx
         JPdVBR6aYK3zOnWM5Db7xtHx1+bqGIKQ9zM3eQDfbD3og7AaRlUvnPblAcTbaPLT61r2
         bjqEOSK6pfRSzyS6MGyOkZNPYGjR4jnCLih5FFOXq9YL1tEDxK/uvdLocSqYirnIbzqm
         HeeJGcZHq4qLFg/ZgLGk9GLJlc68X3Va3/hICc8l04dBSKBdgDbObKVtVTGFb0AxigEw
         YKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928379; x=1755533179;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4XB7rbDMRDvsKK6fD02IRXzMhRU39sjlSTEErIcNrs=;
        b=uNA5yqUnbnuJ7yrwFqCP/MspvKjVjNJ5TchC2StISAUWfKGDHGAowuez70dgYnOrVr
         Eeu3peAv8YO7LIYIl5ngPTCNmNKhOMRlcCfMUf13RCMaCfxJa5puWB1B6TWBEPCCypX3
         YPAWKRUsWiVU9PiPEOAdiLLyuB7GGv4e7tOSxkUClxTB9UhemnLB9GqUYYSFs4TI+EXp
         buwFbWqdY5Bx70NhYIKwxWcXT2C+4syvisD81o6kmpnRNwqlJMiNL6MTmWp1BRLCpJq4
         O4lfTOLH16LJcdBbIEzKW0+99ts5um4qW7ccveeBmSnjU3ND7yv8yTEtbkQUuB6XwSvR
         Z8lg==
X-Gm-Message-State: AOJu0YyYMpNYJDAhLHFHopx+9po9R0BBMc17Z/il534YDrE9TEncXcmt
	4xofACPt/8sWYza1YS2qBGmVMFO/vK5SQW/geQyAS5vU3dGAuNdwIHTe+M8Uupk/Yg==
X-Gm-Gg: ASbGncsFBUSWv+/UqeDsE795WDOe7UXBJD5UZKJk8/dFlpRWBZkxf2VqhxWFPDMrxCb
	Zp/G1idb09giIkMOKkk9+L+zXkr+dSxvQi84irh37e4SD2IK0LYy1ufC/jy/z/xkD/ig8J24RBf
	kmDViv8++VMXVc8y6OtIhpZMo4NwOBetSGWOVvBa01+5a5JyibNrQmmt391MRJ8HGLlvM/965yU
	7i23+gSlqJU3vnxTeSI9gv5NL6V3EBUIhOzNiFgsdET0zJtQR7cZXW1jpMhS2TaWUBjk6ELy8jT
	YE45xPXLAjLnXvi71/PV6ZifHXMmcefYdPiU3TGsx1PZOflpEpoO1LOY31DwEv2BtwgDptgFRnk
	tvooQfYyD+VVyyUmqLAxfKEfjGZYzOwlMCBKZKSxcz+upK9VDPN/BHgd15nAilur4H4DEfJ8vS2
	ByL5zD52ByJnCeiv/2
X-Google-Smtp-Source: AGHT+IHfX3J5jPQcjeR7PGp0tVsL7ZVLWcGPT//n+uMiE8TlGUsCOcJGCeSa/IqlMj8LeXBSgpTeEA==
X-Received: by 2002:a17:903:246:b0:23d:eb0f:f49 with SMTP id d9443c01a7336-242d2bc6116mr5965795ad.14.1754928378887;
        Mon, 11 Aug 2025 09:06:18 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58] ([2a00:79e0:2eb0:8:bf4b:17b7:3044:fe58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm27194145b3a.63.2025.08.11.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:06:18 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:06:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
    Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
    John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Qi Zheng <zhengqi.arch@bytedance.com>, Michal Hocko <mhocko@kernel.org>, 
    David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming
 inactive file pages
In-Reply-To: <5905724.LvFx2qVVIh@natalenko.name>
Message-ID: <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
References: <5905724.LvFx2qVVIh@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Aug 2025, Oleksandr Natalenko wrote:

> Hello Damien.
> 
> I'm fairly confident that the following commit
> 
> 459779d04ae8d block: Improve read ahead size for rotational devices
> 
> caused a regression in my test bench.
> 
> I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It has got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanism to kick in.
> 
> If MGLRU is enabled:
> 
> $ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> 
> then, once page cache builds up, an OOM happens without reclaiming inactive file pages: [1]. Note that inactive_file:506952kB, I'd expect these to be reclaimed instead, like how it happens with v6.16.
> 
> If MGLRU is disabled:
> 
> $ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> 
> then OOM doesn't occur, and things seem to work as usual.
> 
> If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc1, the OOM doesn't happen either.
> 
> Could you please check this?
> 

This looks to be an MGLRU policy decision rather than a readahead 
regression, correct?

Mem-Info:
active_anon:388 inactive_anon:5382 isolated_anon:0
 active_file:9638 inactive_file:126738 isolated_file:0

Setting min_ttl_ms to 1000 is preserving the working set and triggering 
the oom kill is the only alternative to free memory in that configuration.  
The oom kill is being triggered by kswapd for this purpose.

So additional readahead would certainly increase that working set.  This 
looks working as intended.

