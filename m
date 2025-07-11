Return-Path: <linux-kernel+bounces-728014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5AB02278
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C735DA45748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC52EF293;
	Fri, 11 Jul 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cAI4pVPX"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF6D1AF0AF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254437; cv=none; b=LEj5wjzj/dEgitXTrEGjbLol3D60wEToLEap+yLl3E614uZFYRh1ZovzJdkdU2CIAp0PYrCLmye68Vku8tb7gBIUsA8/1ApXbxGftItJisFst2rF0pzl0D2KV5gqVPGNNd5rLg8SUtu2Y0wU01jRlVmmaO+osuovNBNQ3EHHUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254437; c=relaxed/simple;
	bh=6Xa4wVD1yAVbi7UUL1MUFQ4cRd5Esg+lFNpko/jm44U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAOgWOPWjRk2eN33VAXtad/k7Ligbr8LVAj8xar6XK07TJ7bTdy57fDgj25UlXpNokDzDww3BcsbALb+bdvyEZDYA8KOhTbfg2lQnaMfd9io1vxC/8GTymspIrS6BiILTo3tHO6UONO4NF8MX1dcDllWaLlFAY9iH3/7++Ka2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cAI4pVPX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a7a8c2b7b9so31777721cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1752254434; x=1752859234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=al399wbnt8pSRezGjRpPW7y1b0c1HdMARHLUQW6DYpM=;
        b=cAI4pVPXxKTKcUYjHmfz8ZA+BuOCvrBmyUiY3ZFGXNGf2nlZKL3CAcuq48XWbN7udJ
         9n3RRSP6F/sx5Fn9a2pWzh0F9jQ1ein1G0n0S9hfkyb7BEqripg+yK5gpd/H1yOpuNPG
         83ahIerAUJSqk+iIi+aT3Mj0906gOuibdB/uiKkHTf+4DcSN2gOSNh4VPYRcfo1Jwnew
         oKibDZUaDbGaBsIRw35bo0VpfBUG3RXWTnaVQfrvEptyfL7faJINZ+5HKvefkvfyLm+S
         4pY9O6MZGtQn26F80lABSizZo4pYwpt7fXtyLCFyHAKuxf//lKCmiO7dzTsvhSIgoc4e
         tvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254434; x=1752859234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al399wbnt8pSRezGjRpPW7y1b0c1HdMARHLUQW6DYpM=;
        b=Z2EjFGMW7zeobuC+A6qCzVHYZKSqdhWsC7zp4bMhnLmZZJJjPdHwjDq4oHc8Qd7WOw
         17i0aaDWc10cnlf0sC2GsdhXsfyZJik2YhwQ020cmo1hvNg43Pom7SnWy6KAMaq/K+lt
         TFaN6RE7xljrfsPKa/AyeGEBnqVcLNAQC0eesl0mPqbwAE8t2O9oA9/OquWZu9TCwhbH
         cevgD4XiMdUfT/wDsFvxqp1nfNg0F6ZOiXp9YHbl/riplRE/Jm3d9PdmBqmEzMVz17/4
         zB2M9yjnTjDjgHhNvYxsoim0dNbLBG9m11qzOTqEmgto9xdEaqPZYygCb4uy0lMzaKA5
         w6jg==
X-Forwarded-Encrypted: i=1; AJvYcCX/c/H/jA61LH/5nhP8RQCI4xxFwI5rUGMrZvChF3t6dzSVahMKK41tLez3w+51rstgBM8fpwoAfxXMGM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgXWevlUN8AuEXrpdVrim/G3PtH/PZcjsz0qi8KefO6jxN6G8
	wxkDyuLoDPqTqBlQHYTMViaFtYuYXRlvlAFG9UO0N8eGKyGT5wAtINPYppxdvucWyNU=
X-Gm-Gg: ASbGncsJjSgunwEfAXzBwsixAzGNEs8lVBmFJy9v7OKz8SXUurzQX7sjiN5rJMxxZ3m
	I0+iukZr1eHBzfKLvGmoN+n1R0ZmzDSPwxbqjofZHGwWpCC3Q8+PTe7fXxgkEppzoceOaQBP2/k
	YflwMERp+IxNCkWm0pT6v/dkbBkb3qsh/Od80MGzwt87xYZTj8GQSulzqtj8Wju0bbgqBOOGxGU
	D3B2ZswcbDzAkjZ4D8YKioFMk+UMGwobtb+ogCRXXmy2PbAIUnoJBNniaAeD1GfPPsF+9UE+bqq
	4kor1UvCwZXbN0la++w/8gB+jGwDSbjClEIPZj9ORTkYOoX1FepZPlCnisDIydCGwJ84pmhgfrJ
	Cww3cdBaO6+qLqrZxJ+9PBQ==
X-Google-Smtp-Source: AGHT+IET6OIRRs4zSSDeQf4/2ObcvV/kaNXKSCKy47s89cQfeakGKCZrUmNNGPFtv4q3Vww40VmuDw==
X-Received: by 2002:a05:622a:250:b0:4a9:b1ca:9fe1 with SMTP id d75a77b69052e-4aa35dc7a45mr49969421cf.12.1752254433464;
        Fri, 11 Jul 2025 10:20:33 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a9ededcd5fsm23014531cf.68.2025.07.11.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:20:32 -0700 (PDT)
Date: Fri, 11 Jul 2025 13:20:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
Message-ID: <20250711172028.GA991@cmpxchg.org>
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711155044.137652-1-roman.gushchin@linux.dev>

On Fri, Jul 11, 2025 at 08:50:44AM -0700, Roman Gushchin wrote:
> lru_note_cost() records relative cost of incurring io and cpu spent
> on lru rotations, which is used to balance the pressure on file and
> anon memory. The applied pressure is inversely proportional to the
> recorded cost of reclaiming, but only within 2/3 of the range
> (swappiness aside).
> 
> This is useful when both anon and file memory is reclaimable, however
> in many cases it's not the case: e.g. there might be no swap,
> proactive reclaim can target anon memory specifically,
> the memory pressure can come from cgroup v1's memsw limit, etc.
> In all these cases recording the cost will only bias all following
> reclaim, also potentially outside of the scope of the original memcg.
> 
> So it's better to not record the cost if it comes from the initially
> biased reclaim.
> 
> lru_note_cost() is a relatively expensive function, which traverses
> the memcg tree up to the root and takes the lruvec lock on each level.
> Overall it's responsible for about 50% of cycles spent on lruvec lock,
> which might be a non-trivial number overall under heavy memory
> pressure. So optimizing out a large number of lru_note_cost() calls
> is also beneficial from the performance perspective.

Does it actually help? It's under elevated pressure, when lru locks
are the most contended, that we also usually scan both lists.

The caveat with this patch is that, aside from the static noswap
scenario, modes can switch back and forth abruptly or even overlap.

So if you leave a pressure scenario and go back to cache trimming, you
will no longer age the cost information anymore. The next spike could
be starting out with potentially quite stale information.

Or say proactive reclaim recently already targeted anon, and there
were rotations and pageouts; that would be useful data for a reactive
reclaimer doing work at around the same time, or shortly thereafter.

So for everything but the static noswap case, the patch makes me
nervous. And I'm not sure it actually helps in the cases where it
would matter the most.

It might make more sense to look into the cost (ha) of the cost
recording itself. Can we turn it into a vmstat item? That would make
it lockless, would get rstat batching up the cgroup tree etc. This
doesn't need to be 100% precise and race free after all.

