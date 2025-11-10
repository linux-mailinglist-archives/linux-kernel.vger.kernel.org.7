Return-Path: <linux-kernel+bounces-893146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E093DC46A18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8488C3A36FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4D30CD8E;
	Mon, 10 Nov 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA0Tu+fI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BFE23EA88
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778191; cv=none; b=Ho3zC5DqeIzNyrETmdp69TpboE7X2lFqPDL8np7AZnDmXrJM5809jaYznGN2j4ev9/yqNty017dQgXa8OY/kNjXMO1gBqfo1TML5hFe4/HR5IMmbpeqOHYLCiOQu7hcooLPcmVkyNgx62oYzbQwBdvvuZoLxNfO1BcafSSR7hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778191; c=relaxed/simple;
	bh=UbMT84qlh+bGRnpLEEVxdC7496rODSCE09cq6dsWS5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2W+V/lcm8GvFWtYGRyOagS0NGPZn2FAI1wdzzX+tZoCSiFUBiE3UuMl9tkLB1ZhOFTVakScgYC/A2xrg3ZRo9Ie29DkxSlsgFvZjk8Oy2Vx7cc97PvCsXktadXqedt35vuhjo4Y9+rbbmdZgXIeJIBCZkTcp6IUri62oMH6JRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aA0Tu+fI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4777b59119dso9195645e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762778188; x=1763382988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbMT84qlh+bGRnpLEEVxdC7496rODSCE09cq6dsWS5Y=;
        b=aA0Tu+fI9RSJVsGqkgCbZZOrqPluyC2PWw1rdbn34Eg2hjQ3Wh5CDcLtXrItcg/qFD
         reqr0/5ykpNghYlC8uZNOfoY46fkDmS/1Y7KViliYavex/jg4xu2hpa9kQOWB9dBJkSX
         Cugi77Ncc2z9Jr7XAt6tVzfnpzPnxmoPi+Wh3HiNDt6VxXR+aJEUZMP0PjcPqJMaJCGO
         gZWU/NOQPrNsE4+TMYHXXLGGBtzp1QIGDlESyqz2tVjBPQ0HuKz9zUWddBTCLF6gAm6i
         KB7RHmRYyaT8iCo/1yqPAohtVjEczpqkJIUQOX4N/TyrzoftnrBap5/UF0z6Mme2vnkk
         WvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778188; x=1763382988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbMT84qlh+bGRnpLEEVxdC7496rODSCE09cq6dsWS5Y=;
        b=EoKXOyFEV8D1212n7b0g1YTeC2zTaKwaU8uEmJmgodFj9G81hO7MpIyD3tU/omK2SI
         yTzMxlvhUffwjS7EXmI59EwPSfMYqY6p28FgSLPUNUvuCfzLaQmeVXNZgD25y0NCbFn4
         O5JBb4dgRg6UZ7dWOWCfZAQjWnfVX6KUyUJvmzhLJaSVSVeB04jToFing6NpauruK/q+
         TJamWKPVp1BcOKpOp/ohshgXM2hBIwxi974yL0ITX2xfDqA5KqSLMI2l1l5X6r5IIYx8
         LHL/rDzXPdOkHhCkk3iVso0NkrivvDzvEM4VIZ4tV5BwhTaaq7XfmfGONZvZQXKKaXgY
         5IbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqSwPTkfQjoHn0qdGIV6Pf6P9xhPd0758gXRTpLg7hhcEqM++a2jiOZ53kktsyT3CTwVJBUOmrGbkv1bM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WKe1JK2bDPNAvguRhWhC5jlpe8gQMjBvfY9un+A+iWucekgc
	pwDMqXw3ZKLM+Z6hH+LPqPKLIOaZix9/55wcqU2beSBVev+sjc/V1/L6H9QRNHbYxxGG1qFIzwY
	EKWzWcyQ6cgft4w==
X-Google-Smtp-Source: AGHT+IFkqQ2JCO92rMhGqtD55gQ/qLw5jqO2mnH6sKx9F7OKDrhIFhpPWQqX+8AONg1NiXXzOHJAZNv39LHjig==
X-Received: from wmpo21.prod.google.com ([2002:a05:600c:3395:b0:477:7efa:f807])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474c:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47773228b80mr56455815e9.1.1762778188545;
 Mon, 10 Nov 2025 04:36:28 -0800 (PST)
Date: Mon, 10 Nov 2025 12:36:27 +0000
In-Reply-To: <20251110113834.GWaRHOuqnXgNa0UiFn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-3-2d861768041f@google.com> <20251025114801.GWaPy48dhlZ_EVoqKi@fat_crate.local>
 <DDSLXKU87HTE.G0XUZ5BG5M8K@google.com> <20251110113834.GWaRHOuqnXgNa0UiFn@fat_crate.local>
X-Mailer: aerc 0.21.0
Message-ID: <DE50PRYPTPD5.3MAJLOSJFMA37@google.com>
Subject: Re: [PATCH 03/21] x86/mm: factor out phys_pgd_init()
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon Nov 10, 2025 at 11:38 AM UTC, Borislav Petkov wrote:
> On Sun, Oct 26, 2025 at 10:29:23PM +0000, Brendan Jackman wrote:
>> Per Dave's feedback I am still slightly hopeful I can find a way to
>> come in and refactor this code so that it's gets cleaner for you guys
>> and then ASI becomes a natural addition. So far I don't come up with
>> anything in init_64.c but I'm still planning to stare at set_memory.c a
>> while longer and see if anything comes to mind. So maybe we'll be able
>> to reduce the yuck factor a bit.
>
> Cleanups like that are always more than welcome!
>
> :-)

In that case, I will advertise this (less ambitious) cleanup which is
awaiting review:

https://lore.kernel.org/all/20251003-x86-init-cleanup-v1-4-f2b7994c2ad6@google.com/

