Return-Path: <linux-kernel+bounces-625300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B96AA0FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 16:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EB83A4C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6521A459;
	Tue, 29 Apr 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wczpRYnM"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4621A443
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938227; cv=none; b=QdNvnSlkTxaO2+HvyrKrKCCipims4FydhFmJjbyPcEeAkmcVi3s3gmSZKZWUoiFIjtAr0cF0qukd5tNtQEeZr1LP1x5phjpVWFoxPkywANVWEiVnHKGba11G/nzbahCnrMb9dIjWn7aZDYOtMuJ+4zGp7RHQNhNMGf/PYyhetr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938227; c=relaxed/simple;
	bh=YPSGgkh2TVolXHWVk33rF3hFvn3iDnfwqVva4PVFS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyPgNxhfAz4wD2IvFQ655FlKEBSDAvpZzQbHoTH9FhcWPWPeoaeiWvIgCNKk0vPgehHpe2XIMYGYjofyMjOS7WIZBRu0Hh8z6aN/f2MpiQpnFinKLFetDnbAm2sirYqj9CbOGd6DQd/Y6etrOimClC1amzwOsxri22x6O1dsXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wczpRYnM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVjUFTRUIzPb0J19lPaGWg8e2gTYSn33Ufgj92oYj6IPsteMU+MT/pnrJUZf0ObATxYx7I3QrzpWh6wnXoq@vger.kernel.org, AJvYcCWin20KlXnL2ejMrvUV9P8VKAZAsiwNdwhnJsgOX172mTKddcV37E/EEKa0haf8PFBhpMd7JAVn@vger.kernel.org, AJvYcCXeocXyJTaofwMbXmJND01dLUhcMi/X79vjMdigfg7WtjEb/jsXTRLAzjysyzCj6A08HCGxez29@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745938223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sG/t2zXSuC4284IbLbTWykBNuA1OkgkeykHvhILihlA=;
	b=wczpRYnMdLsuSqcKn48qq1wORHnsxDW6JsUewxk6PeAKZke6iq7RzJRtPpSrGpNVMlkHcs
	oDlGQlzykdzUg7rjp8HwD+2qY8y0VGX45iv4ntwJEwycOnZ6pRTJxrTnAT/0EZVxrerAvH
	Ut3jyUsod3NsZaQTg8c1BmBHwSs9d1U=
X-Gm-Message-State: AOJu0YzEDMgmB9pPFBpIRBMXIm6tQY8fcNP0u7Ea8smtxlKwas33st8n
	XbOaT1DdytxSaAvU6jzOHex/48mU1tpTUlmMO2P7pzE4OmdK2yucJ28I8f2xxQvLXFI3Wrlgyol
	uxnP6bT3ywYid3T1GQrJPOHiw6OM=
X-Google-Smtp-Source: AGHT+IGNOvGy3kBxT/7U0dYFYLFlS3jS3+6ZPtjfckwWaQFxqtwhzH0vx78mbKcV1/Az431zoUcIbk2mXjaIZvhAeyg=
X-Received: by 2002:a05:6102:5707:b0:4bd:22d5:fbd7 with SMTP id
 ada2fe7eead31-4daa9332342mr2397273137.11.1745938221113; Tue, 29 Apr 2025
 07:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <as5cdsm4lraxupg3t6onep2ixql72za25hvd4x334dsoyo4apr@zyzl4vkuevuv> <d542d18f-1caa-6fea-e2c3-3555c87bcf64@google.com>
In-Reply-To: <d542d18f-1caa-6fea-e2c3-3555c87bcf64@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Tue, 29 Apr 2025 07:50:09 -0700
X-Gmail-Original-Message-ID: <CAGj-7pWpPkJQj6f975FKYBVY=aLQtoYp_Qn-nmRY1x=+KLr5Yw@mail.gmail.com>
X-Gm-Features: ATxdqUHdcNwx1MHWsVfsCWAIdhFCYRv7C1N8Tk9pEbSWytPPXoXSMfUfvwyV-gs
Message-ID: <CAGj-7pWpPkJQj6f975FKYBVY=aLQtoYp_Qn-nmRY1x=+KLr5Yw@mail.gmail.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 2:40=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> [PATCH mm-unstable] memcg: multi-memcg percpu charge cache - fix 3
>
> Fix 2 has been giving me lots of memcg OOM kills not seen before:
> it's better to stock nr_pages than the uninitialized stock_pages.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks a lot Hugh for catching this.

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 178d79e68107..02c6f553dc53 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1952,7 +1952,7 @@ static void refill_stock(struct mem_cgroup *memcg, =
unsigned int nr_pages)
>                 }
>                 css_get(&memcg->css);
>                 WRITE_ONCE(stock->cached[i], memcg);
> -               WRITE_ONCE(stock->nr_pages[i], stock_pages);
> +               WRITE_ONCE(stock->nr_pages[i], nr_pages);
>         }
>
>         local_unlock_irqrestore(&memcg_stock.stock_lock, flags);

