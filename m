Return-Path: <linux-kernel+bounces-733858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40DEB079F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1AD21894991
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14019DFAB;
	Wed, 16 Jul 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDUlDwQC"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853532F3C3E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679768; cv=none; b=UhYA8WhKblQcwV4Wgl7gR/Pio+DvbWUj3l7NxT7BUpQEqGEayotQOzvJjE2+Hj0yF9b/pv06CZAPREOvO9tNolZ6dBR6wnQmXcU9CZfYJbHMmkUSC8EpiZ73Pmf+AkQEHUqmBy1AdDIE4jb4KqvSMz2Kbuw1mJ/XO85/1Jg/Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679768; c=relaxed/simple;
	bh=WGE7sAM3OqMYV7DpWfNGBy5wnLne+qh8A6FOCqFFaUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0bgb1UvcPmuYJZdmEj9HLXCWIz2V5o254dAUPbn7I3cE8QR8MMzAxiH/1DrULd0NB1GwjXmNasHQhvIk9hkMOFRhJeJBkd2p+WhM+La3Nxuj2bTg4ObHDA5TKTw+FatBfJn3YEHSH2pQkNQWfkLom2mMvxoyynNe2gNfzKZ660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDUlDwQC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390136ed88so5055817a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752679767; x=1753284567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXRWy2GORatQ4WDqzRgN/A7GONpktQqNYMaPCTvZVp8=;
        b=yDUlDwQCVnTlg+72UizHFLzaX4aFdCnEZ4BkBg7skFLdyhEJswkj9ezDa9zMV7T8v+
         zP60jDyoj9DHGvfXTEuhcIBsdV2qTqV/SLw5exCT0UL0RutSS7GgzSK5qq35ILKzlUth
         01MWEFMOcie5izzLoDWazjkqvm3p+Oc/53+/q0uFtIEA/1K/3pEuHUEryk4njLSl2G5g
         sfqGO9qDCUbpRg20hDUcn5ZI80QIuEQq0Ug85RgwtnGO4NOZEPyRjz6mE6X9w80EnOoj
         ztPSlWGHC9UoYIRZYgZRT/W3y2Hb84WPC8XTEv1WC/uRFeGx8NwiBmuJwMU2e2tyIkyl
         pNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679767; x=1753284567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXRWy2GORatQ4WDqzRgN/A7GONpktQqNYMaPCTvZVp8=;
        b=I4AB4M8Jh/prIXlrxmfHtsel5ZYCRGAJvnz9+ApJZZdeltfMWdVYMs1REc+L0UKA3O
         Ty6dhzv5LVJDVi2DCP5mDdIjSXnkM6B+sLKQjXb54ZmIOgiGIS3nZAyxVQY1XEebYGLA
         FDDu7mUTZgX6PQ+kz3Er/M5aNrz+6XauU8Z5FAbnXngUbXFWuT/BLKZI7uN0mFK9Q2oB
         lBlpKhQi5NA3+UioLesdEw3Xdj6zSAQiDz6EzSambN5vp4jTxCNtH895Phobzn7hzYdL
         FDBKVrcyJxZHL0AOCzwB/BRMl33gE7JFpev9JpIg1PtYvyAj+j7JUZgX9AR9aKoLA9yv
         i9XA==
X-Forwarded-Encrypted: i=1; AJvYcCUA+M++Q3imtgDE6wJYk6vo/2PRXF6X4Xv408xXX/HLG57FSwgyOSNN+T5xt2G4BwYzO4vhUtHg95yssNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UfcSZAAwYTP+kHdr3E1q4OHml8us4ndN7XO3HSrJ8NAcPs0a
	1VIMh3p1log//ILKEquaZ6vxcSS8eU3dgKgYC+2MLAoKjIIZ8UYP81Zig258ULPH9BI/7eVOBst
	3YGApyzEA8VCEKyvnfoZnVFAv8JipY+qXfnkTM7fD
X-Gm-Gg: ASbGncv99qxQE5ds9JEotmNesDNDCg+ZZT8cfmFhplviQmpGAW7oJASSen9nvSc0VXc
	0GrL7zYSdKtZKq0OD0ktjv2Y0LX4a/CkrGL+qqbsvB307iXVl+4aNFzQ0LwM0jRQvjrTkYvuhhr
	LHW0wOX/Be200YvdvbviY5p9pV/D738powAaFkyKVkE0XhL64Xn2RtDiw1QQkcM0iuA/VlGHhX/
	o1q2pCFxjAD0lQ+7F2fUTo9ul62YS6Pvn2VpQ==
X-Google-Smtp-Source: AGHT+IGhWGvZFIyXMBKollBvN/Zu57HCt2PgqO1m3mJKLcpRl1PPfnsYEt1KyZPLSnAw6C1O1yhlRpn8cRFq8axjCvQ=
X-Received: by 2002:a17:90b:1c83:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-31c9e76b79dmr4902000a91.23.1752679766392; Wed, 16 Jul 2025
 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com> <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com> <20250711021100.GA4320@system.software.com>
 <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20250713232740.GA18327@system.software.com> <aHdsQYvKN-dLQG2O@pc636>
In-Reply-To: <aHdsQYvKN-dLQG2O@pc636>
From: Marco Elver <elver@google.com>
Date: Wed, 16 Jul 2025 17:28:49 +0200
X-Gm-Features: Ac12FXyd4otKpgnEaXRLmajtTI6ex6Uy6iZQJFcEjwrCoLj_OCKFTg4M7FvyGmE
Message-ID: <CANpmjNM96MCD-JY=+OkQ4PZK3jV4027PCPRQ0bMVm9kvhGC=4Q@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, Yeo Reum Yun <YeoReum.Yun@arm.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "glider@google.com" <glider@google.com>, 
	"dvyukov@google.com" <dvyukov@google.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, 
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>, "ysk@kzalloc.com" <ysk@kzalloc.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, 
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 11:09, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Jul 14, 2025 at 08:27:40AM +0900, Byungchul Park wrote:
> > On Sat, Jul 12, 2025 at 03:46:10PM +0000, Yeo Reum Yun wrote:
> > > Hi ByungChul,
> > >
> > > [...]
> > > > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > > > time complextity looks O(log N).  I don't think an irq disabled section
> > > > of O(log N) is harmful.  I still think using
> > > > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > > > of significant irq delay.  Am I missing something?
> > >
> > > I don't agree for this.
> > > since in PREEMPT_RT case, it has the same problem.
> > >
> > > In case of PREEMPT_RT, spin_lock_irqsave() becomes rt_spin_lock() which is sleepable.
> > > But, KASAN calls "rt_spin_lock()" holding raw_spin_lock_irqsave() which is definitely wrong.
> >
> > It's another issue than irq handling latency, but it's about lock usage
> > correctness.  You are right.
> >
> There is vmalloc_dump_obj() function which should be used IMO:
>
> <snip>
> pr_err("The buggy address %px belongs to a vmalloc virtual mapping, dump it...\n", addr);
> vmalloc_dump_obj(addr);
> <snip>
>
> we use trylock there to eliminate an issue if invoked from the IRQ
> context.

Something like that should work:
https://lkml.kernel.org/r/20250716152448.3877201-1-elver@google.com

