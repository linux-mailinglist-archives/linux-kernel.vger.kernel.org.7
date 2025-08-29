Return-Path: <linux-kernel+bounces-792106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED8B3C037
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F557BEEA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5720010A;
	Fri, 29 Aug 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zqwjffVW"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3035961
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483484; cv=none; b=IKmu/xWodsebGpgBrOLtmO1tSVsfojh/2cocZxW/zmDbVUIRjVSLhjgVyhF6KMkMKDJeAlkYMUacC4/4BGv2FJXpTVGHkR3mKigLKJq0qYhUDMJBBZDHh/znSprxOOaF9vzDWyyFtblecix4Gz0Hs4Tnxseu+8I1mu45I/mSTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483484; c=relaxed/simple;
	bh=5fE+3+RCGOHH9xRdak5/4NvUlKdb26TZAQ1SktSnO8k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M5i4zJ9gS7qLzhMJ5KqhEBK3KfpyTGHnJxjvSuhpeHVoTg5wn3gBIl9mB/8jWdy6iP/MsTyih44/gX6EOciVb/jq0K+9F34+8TCELGgPHnep63h+3v/hsfq41FzAVxnCQtrD6hSXRFSQkphXtNVQ3j9C65KX9mKcYbfxJLLOdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zqwjffVW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so1856119276.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756483481; x=1757088281; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3ieh9vXd2rGxldog2/NrBq8T9491db7QVgaiuI0n0k=;
        b=zqwjffVWH7iAAFQCX/WZAJSYc7R/LNNrxlwjZFOXfOJMrfZVu5HFHqQBzOlCpuPDSo
         vJx/mDR0KnaMRYke5bep/Y1G2RvjSpkm2DJ15YlHK0KZw0A51QxUw/HVfzzj6Ra4OlkU
         joLymV5PUEAQr8YyOt1RR0LVy+08wrXnHseO6B/t4D8SpZgug2I2COllaTfJhLZrndLX
         2r4kdk3PpDtHWZNVNchWa2MqWSpdNXIOXSqp6snH4WqBVNdDJ+AKoUbv/+THb0JJoEzT
         CtH2q1DZd5JNSZsUSRABIqWctNBIOol6DkgtkMw0sg+xbuoRuBAW0+bC7QOtxCc20o1q
         LWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483481; x=1757088281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3ieh9vXd2rGxldog2/NrBq8T9491db7QVgaiuI0n0k=;
        b=ckXd7ZNnYm7WRhEuc4BZKKcdPr7fSEy2wl4mW2W0VxSTHtyXoYFEQTAcyE0hI7uT+a
         RvPR4oo1iBXPyhLLHKBNRcOcOsXUWBaPx1QF2ZO8ZcBC6ASEhylTUquD6oAMDfq3hxNS
         6169Yj1VG2tW3pCqaG9JGZTFqBZjgLp7XSjYomoIFoGnDmcpo5eQzT/9zr52LggoTB8F
         P/5kP1mSL+QzDOGk05jZ8PqfzG8JhAD1MqzPMrwAMN9mntOTc49ndBTG71AAEFGw9B2y
         ADsmc3PM5NinPM1cnC2V0UAC22hqDWbjTD/zzWO1YxS/kBG6id2/3eNNKpbpZhJdl39B
         uUqw==
X-Forwarded-Encrypted: i=1; AJvYcCUIC59efhb0wsqEcJHO7Qnz8E4Jyt06OYcnz1Ez7PzJOjFs3em/83vLIWIzWLmf+lvM/iRw/6XXXwT9+VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dXNrGMJX7a9BCO0F+pRbA7oa2DFe89GzIG7I08Zek2IDWveG
	hpAbdflJgASrQBbd80EOZATLf5+o/d9+SEZ7rltr5CDU+gDbWkwonCMAoYmniEVzVA==
X-Gm-Gg: ASbGncsEMAvDa/eISTd5umDVTue1rqz6Na/EKla/urR12X1+taDE/2dTA3fr8/lCoSE
	8KhX/sLD4CtTPA5Vw3+kBClLkvdF+KOOkjdn9z9wxI1rUQu/3gyL5TnmuCjbjQ/z5IZgSBZO8B4
	h5p1XuNo0WGDbD0kg7aQ6JQVfjS5X3JnbELJvSJ+UDAACL5i4zoxEnurWXYL6o4B/0nOoqvz3wT
	WQr/zM3fdtuLK99GdUW0EO9T2fmuHfqfJG56gBr+K8Fp9scADujRV5PmRQwoQlASneKWOSGAfMp
	F3uda6ikVFEKQmkKciRQy2+AMlhtY8IYjtF/MJ5T9i7XZ9J+/598L1p85Dcfe2Sn2w5Qj6UDLhl
	GeWiDOUmjZwbjCukKJLOe0skouNbkStaZM3pweFMcK8urlEgt/5NCkd/NdJn3noNnt0Z1sjHOVh
	knrCCAHWwNv1R7CA==
X-Google-Smtp-Source: AGHT+IEkokJ2crbrTEMsTpOoqwCtDYr7v1QWZ6l7POfXkmk+aYp5QMOEWlSlYjumwDq798JtyHHbGQ==
X-Received: by 2002:a05:6902:210f:b0:e98:10e8:a8de with SMTP id 3f1490d57ef6-e9810e8bac9mr4221714276.34.1756483481001;
        Fri, 29 Aug 2025 09:04:41 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9847dd4494sm836125276.30.2025.08.29.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 09:04:40 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:04:37 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Will Deacon <will@kernel.org>
cc: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <aLGpcOSTGiJIRQda@willie-the-truck>
Message-ID: <24905f30-4a7c-e627-a272-80977204ed68@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck> <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com> <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <aLGVsXpyUx9-ZRIl@willie-the-truck> <aLGpcOSTGiJIRQda@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 Aug 2025, Will Deacon wrote:
> On Fri, Aug 29, 2025 at 12:57:43PM +0100, Will Deacon wrote:
> > On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
> > > Patch is against 6.17-rc3; but if you'd prefer the patch against 6.12
> > > (or an intervening release), I already did the backport so please just
> > > ask.
> > 
> > We've got 6.15 working well at the moment, so I'll backport your diff
> > to that.
> 
> Notwithstanding my question about the synchronisation, I cherry-picked
> 86ebd50224c0 ("mm: add folio_expected_ref_count() for reference count
> calculation") to my 6.15-based Android tree and applied your diff on top.

Yes, I cherry-picked exactly that into my 6.12.  Not a big deal,
but a word of advance warning: the first patch in my series will
(I believe) be a fix to that folio_expected_ref_count(), to allow
for PG_private_2, which implies +1 on refcount (I've not yet
researched whether it's +1 or +2 if PG_private and PG_private_2
are both set - comments I've seen imply +1 but I need to check).

I thought of that when doing the cherry-pick because I thought that
PG_private_2 had already been killed off by now in the latest tree:
but was surprised to find that it is still there in 6.17-rc.

> 
> With that, I've not managed to reproduce the original failure and
> haven't observed any migration failures on the GUP path.

Great, many thanks to you, Will.

Hugh

