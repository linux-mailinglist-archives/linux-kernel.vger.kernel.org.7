Return-Path: <linux-kernel+bounces-744523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85427B10DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D232C7BEFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BA1B041A;
	Thu, 24 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CqiAFGb"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F71A5B84
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368360; cv=none; b=ONpqvgGt0Z1m4Mv7ADYasdF1Fejhb7q819spbozud7VJNp6CEeBjVVwRTq14gEm536Hv74EXJLXuAnfK+nZf87y1PITtiCTYRHhyYoRaJX3kzkAPWry5YYtx/WUAvVy5OTD06jXqbOzB/NP/igvYJ17UlIyxY6Q7rNXaneJJ2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368360; c=relaxed/simple;
	bh=t9HVJHe+iSRcfFZNFsoaQkuhmI2iPruXvW/Fad+gwuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNcpuIjPK/clIELcu7IV3z2Mp3wq8big0gmKEJGksn5UWgC9dwVIhX85EI+GIbOgchSwaujecm0i8eR6boKO+kVvMAAo/QL+ka9JpKCTmrrqbutsY5Tdr3YJ7Srtq6L648EoReoVxYeviVcGsFWqFV13ZXeo9xaFTVJQ99FOlVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CqiAFGb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so9274a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753368358; x=1753973158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9HVJHe+iSRcfFZNFsoaQkuhmI2iPruXvW/Fad+gwuo=;
        b=0CqiAFGbVy58gl/vW5hSixw1eUSrj9uelBmQQOOBdBRi2WUFupx3QzF3rt4GG+D87G
         0n7aU2CFdKIuOANJeXl/XlvYmO1pOt8lYvtGixCOxAtMpsJPG73Urq4HvKREScf+v/6+
         EcASFeRMD8+7foGiqB0vtlArjn03uGQCvkBSHlKdh5UozKmV00ULltPOsqHTYg9pqj1U
         XobtcsSRcuo4hWdW78WrxZgOJmQN3Inu3tF3ccOF8R8P7QqOrQ/VYzVDE4PmQ0jUgm6m
         29pSnWzfEqtUcQ7Jnh9wvcsYsAg5zTpcfxzamzlmqqlPbPNVixhIGaPPcOHTUAdWifM2
         PeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368358; x=1753973158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9HVJHe+iSRcfFZNFsoaQkuhmI2iPruXvW/Fad+gwuo=;
        b=mMIb57CBimP5j+DVCgiU0wNu5d9WSm49gXpf9rKNC7zXKgsSvKk6/sggxzg5uVp8tY
         qjpMr54eKc+afOrW5/A2fGebX4O18A7jHnc6N4dUFI0I5dqdmBinl09QKJW8CEzygNqm
         FHWetwLY8kCmw8bZKPorMXYpb0fZRFjj3IlFSHYMwzGHrI6PxzyNnJ8A10PDAItU0mPT
         rrd9xBEKxFjQ87dWUi+itewwpYuiK3lLs8g1iVQB332vJVYaB2WKNARmIgUKdacksV0n
         MFFBPxm+cgysE9yO1+3ELMznsVkIe6d/vEAo91HfbSBbBgOM7jU3Kkbq0AK673Kfgbmz
         FZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIpl5tpmbtT8b+RIv2PKgOq7TSJ2HZybKoZkoDv9/zCjoCI1fVNpl5H+n0lAPQTZnml1jhPrdfJFFr2e8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BF2sop+GAz82EWuPPySksIxW/eExO1M8Hr3s0FwS+XCG7IVx
	PMolJp4o1/F45CXieUAU8p+57VXpajCAmwp0Yhfn43B2Jh5eHEVJKhG3qVDb5oWeHFlvgGK7dcZ
	fW2W28aF/Px6nDu6CMNRYiz6llGCDW+cvt02/IVsJ
X-Gm-Gg: ASbGncsvMZOrmpdyTjod2z0PWa7qzh+HwNn5vlwQEjW+q2YTyU+l8oUak4S0rLXMapy
	AmRqccefQzBOELNmGxth5X2u1vEk3H36XtQr/0ng8oZH1teylTZ0nLA1RpKHUhcmwFLwvfT1tUf
	QILk7eB6BX2YGPfoUxyONXm5oCip21ar5KRY2Cj2m8lsKSp839dKO6Ph1jcEdv5LeBG/v1dtxei
	iL/x905Cq/ptULCZ85RRDDMg5eX0P0I3A==
X-Google-Smtp-Source: AGHT+IGSZpicBm0kzdR09OWL7oNmNSbG5umAWNPq12zXspoqnQ5qSZeuAo6ECOy6+JRbcvDpkNP8nSSArqw3TzmkxV0=
X-Received: by 2002:a05:6402:c91:b0:612:ce4f:39c with SMTP id
 4fb4d7f45d1cf-614c452f4f5mr103269a12.0.1753368357273; Thu, 24 Jul 2025
 07:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz> <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz> <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com> <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz>
In-Reply-To: <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Thu, 24 Jul 2025 16:45:21 +0200
X-Gm-Features: Ac12FXycbft8xJk_FMasxwKQonXWoLp0FEIYfH4fnR5HmpGPO9P0XjxatL7Ltgw
Message-ID: <CAG48ez0RrGX-UDhUF+1x5-euJN9z448dsrXMgv4+7-_s=zan_A@mail.gmail.com>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:38=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> On 7/24/25 04:30, Suren Baghdasaryan wrote:
> > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> > after it calls rcuwait_wake_up(). What do you think about this
> > approach, folks?
>
> Yeah except it would be wasteful to do for all vma_refcount_put(). Should=
 be
> enough to have this version (as Jann suggested) for inval_end_read: part =
of
> lock_vma_under_rcu. I think we need it also for the vma_refcount_put() do=
ne
> in vma_start_read() when we fail the seqcount check? I think in that case
> the same thing can be happening too, just with different race windows?
>
> Also as Jann suggested, maybe it's not great (or even safe) to perform
> __mmdrop() under rcu? And maybe some vma_start_read() users are even more
> restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-only, =
and
> use that.

FWIW, I think I have been mixing things up in my head - mmdrop_async()
exists, but this comment in free_signal_struct() explains that it's
because __mmdrop() is not softirq-safe because x86's pgd_lock spinlock
does not disable IRQs.

/*
* __mmdrop is not safe to call from softirq context on x86 due to
* pgd_dtor so postpone it to the async context
*/

So I guess using mmdrop() here might actually be fine, since we're
just in atomic context, not in softirq.

