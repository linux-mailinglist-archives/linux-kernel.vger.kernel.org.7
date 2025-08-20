Return-Path: <linux-kernel+bounces-777774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E65B2DD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F71C41526
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455731DD8B;
	Wed, 20 Aug 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOcugQLf"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EE31CA78
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696038; cv=none; b=GZKiVHIq5dJWxHJ7j3pV2lHLfT0F7T9lRPogHelYx+1vSL28F5mbnxz3PcZD9mXNxB2hvJf/UIilvUNcClFPowcL6+2L35Vloo81DxM98jYUnsLiNDaSbk+HjD9RH8V5mpuPq1JvPgUK3MTFu90vGURCJhliooZUnBYbdfNCt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696038; c=relaxed/simple;
	bh=UMm1Le0ni68YA+xB0lYsI2xePdU4OXnc0gc74P2MyqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju/KuZdGGt/LfNxhKpPbjcVUG/A3GPiPMbQh40tkFQ0ofxF0NWHHxCLtr6fg32SWnfJk7an92GJdvQEvovpsbfPQfY/Lij9jroTr9iKQecXGAKYg7tIu5sJo3HndXuGGCUKCddo51OIiA+VVDY6IY4GgzvXllM/B/UpKiaG1qU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOcugQLf; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e94f5dbf726so875001276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755696035; x=1756300835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huBJkkuAghaPrkL3HWrTjs62vW58FasajnWT6m2aMfQ=;
        b=UOcugQLfKVAw8L8PCGyaDJR2KvsU0PXgM8RchYRq3hBuaTs/grhOta3XoKnTyY8dmS
         /dqEfgeSbM+IJtaXCTaCGBoc/RDykQ4acyhiv6k4ID8279g75SllTovxR2hcdivhY+aZ
         ovac9n65tephEqhDkPBK1ziQvO/XoKUrgXYAgVde4KIuyugma8TIWoPQvkR2idWriUTV
         M0oCDI5yPpxrkZ6e3u1vyR98y6uv7pd+B9qu78i+OiX3B96W/Oowz/pOkmX3ju83PREi
         SUuI1vyz46tdGrfmO6VvD4sTy23FULaMELPmVZNsLSAD+EJQWZmHtcyyIki5/UsEkJM3
         UJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696035; x=1756300835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huBJkkuAghaPrkL3HWrTjs62vW58FasajnWT6m2aMfQ=;
        b=YyBnlpzsPfgGl8hCJXTlYntai3MLW6St5jvq6V3Tr7jv+29IZ2ouV1TFSuHp64O/JI
         mApd7MWz3Yfqgwzqx7FCvQBShJ/QNQeKuz1P882QZVUNrz9eXO4WoEvwTi7VvloQ+ZKb
         5BH6pYhuYh2y3X572pQLbQzes1hzxn6KgV/B6XiUdlp8z1KDE2pyU4mehHjjaWK5rp+5
         Uk5LSrb86Mut5OfC3BFIheFfuGIV+sByg3rSAR6Hc5g8ZzHJcfxcU2Jk9L3dAcmkJdDy
         QVnSLtxQSSLtY0EeiMD05nxwA9jHigWtjRiI+3JRtV7Xpsu0d1MwX525UpAXgP3fmC0Q
         9qHw==
X-Forwarded-Encrypted: i=1; AJvYcCX/kfI2FQbULIzk5RqcvVNkZQJFdh4rzhehS4VomwDIZL4M5HenKh6brtZe5hW4QCCf0q5aE+XXDjjE3FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4mRMnwyXIKCPRF+3dcnc2+FZCYQm0L7X+o2rbVM72g3aWG8D
	oy1H1oZxXBH6mtKVw+ZQM3DJencvDQKk3eujN/c+foqBlRq48cymb38E
X-Gm-Gg: ASbGncu3VjwzQ16b+5lN8DVrg5fy4U0lgmQ1Bdc2D5JLl8YYvjdBjLqkqVDBI4jwDOQ
	+GcpdZMX5f+on4fYxy+3FIAj/yqmubGZanKoWXOtQB7fwX+Cx0Zns4IjBsIG8OAGnNI/Vzxsb8X
	YydgK5Lc14pGp2S1fxUGBN3FSfBBStFjbH+rF07jl55jF/04d9czGeDUx+rXxkjVHZJfy3wXqDG
	i+a51NOgUXxFk6unjjhDvVWkkFH+IFD+EPVtap4+Z6oN5nqFArxYabXVsK9su/fqynqdMGmwhz8
	iHcfZotS0Ou2qyVn7mX9Ak4SZQPwCEGmwEtWyXC06LHrhYpdIazyHeNWUevYIQlt6lyRkzqlV1I
	tK81+hQYEwy4cLDhxy91x5Q==
X-Google-Smtp-Source: AGHT+IFe3l5NW+k7VU45XzYFiqnjIqKJUrlUrgIYjymvF/QLwecLD1IxZTW6nifz4i+UybYBiKZuHw==
X-Received: by 2002:a05:6902:1549:b0:e94:e1e5:377c with SMTP id 3f1490d57ef6-e94f66b1ed7mr2856141276.50.1755696035015;
        Wed, 20 Aug 2025 06:20:35 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:52::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm1219738276.17.2025.08.20.06.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:20:34 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@gogle.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Wed, 20 Aug 2025 06:20:32 -0700
Message-ID: <20250820132033.1267317-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819144421.7a52f8df3f0fe5c315f90aa2@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 14:44:21 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 19 Aug 2025 08:18:45 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > > Pretty this isn't.
> > > 
> > > Sigh, we do so much stuff here and in __free_one_page().
> > > 
> > > What sort of guarantee do we have that the contending task will be able
> > > to get in and grab the spinlock in that tiny time window?
> > 
> > Thank you for pointing this out -- I don't think there is any guarantee.
> > Kiryl suggested that I put a cond_resched() here, in order to guarantee that
> > the contending tasks will be able to grab the spinlock. I think that's a great
> > idea -- I'll make this change in v2.

Hello Andrew, thank you for your review!

> cond_resched() might help because it takes more CPU cycles and expands
> the window. A udelay() would of course do this more nicely.

I was wondering if we could rely on the spinlock implementation here in order
to allow some fairness in who grabs the lock. From what I have gathered, on
a lot of architectures, the default implementation for spin locks use a
queued spin lock (on x86 and arm64, among others, just by doing a quick
grep for "select ARCH_USE_QUEUED_SPINLOCKS"). This means that whoever was
waiting the longest for the spin lock will be able to grab it, guaranteeing
that this function doesn't immediately lock again.

With that said, I understand that the solution should be generic and work for
all architectures. I wonder if it would make sense to change the zone lock
into an explicit queued spin lock?

> But the contending task is already in state TASK_RUNNING so a
> cond_resched() won't have any effect on it?
> 
> Also, callers hold pcp->lock, so cond_resched() cannot be called.

Ah yes, that makes sense.

> Sigh, I dunno, it's all very nasty.  I have vague memories of there
> being a way of relinquishing a lock to some other task which is
> spinning on that lock.  Or at least, a proposal.  Or I dreamed it. 
> peterz would be a good person to ask.

Cc-ing Peter, please let us know if you have any thoughts about all of this!

Thank you Andrew, I hope you have a great day!
Joshua

