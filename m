Return-Path: <linux-kernel+bounces-839257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A0BB12FE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D15019471C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5328153A;
	Wed,  1 Oct 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMPNeTf9"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5525C1459FA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334128; cv=none; b=lVtJ+XQ/ajPzpxWOvdzaE5CnjagZ9XGewEqO7O+hOsN9vAo94ytKyhuJx5gIFR6tn6o2WOjDzyM8REyz37n7dlVXAXPixY8ToOuHWGA5M80tI4BWxZWGvbmTXtx/a8qwHjqkzLC1+pQ27UeRkyj7/6dSCVnV+gbIQpyT7vghCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334128; c=relaxed/simple;
	bh=S9Jlzyfu+mgUXf2aDOVdgDI3fL8QyOpV/+Sk8Tmbbqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvtUzBeS5ERwMfOuEMLR09JvUEGg5Y3MkXrwu+kDPkGf1bkmVW0ND1t3/KrKqR4lLEKTNI//GqVqGtZgqoGkgQ/58xw73N72l8g7OU9WDbn0+6P+adi9HiJchzHQ/mb1QQK5B2pxNqFxbFbp5KPbnajbFL+lC5iUBId8FbemdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMPNeTf9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-73b4e3d0756so291227b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759334126; x=1759938926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU3Gy/BQ6qxCUFWfpwnTAmYAtNG3wW0MiedBiSGq4AU=;
        b=PMPNeTf91XpB/MFG6MqWBr1TVC21IDHA6A09C+93Ed9b1FEwyb1KkkdhCc5PgVCoYT
         qe68L/LlZhXlAB1ZZz6PufMUxY2lFvdAQ2j5s87KcbXer4Q2bQ2B6xjuNSB0ZofGPZEg
         I5fA3qsFgNMYxSUP9a0dVmpJMIETt9B2FnjibhVH1PKlA8EL3aohY3/qs3W5gDU3jVLZ
         TBUiuOxgWvUrgu7SwfqEWbx+hS8UisEEhm08Kq5lzmTiyphWMATwKMGTiWRwYFXIntvA
         p0uQIo7i/H/wy07j/gkM7TRcHILGBjbA2cBua7jeExwlyn+gguXlko8R9zHEMwrF5zhG
         rk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334126; x=1759938926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU3Gy/BQ6qxCUFWfpwnTAmYAtNG3wW0MiedBiSGq4AU=;
        b=HUeBzTvRqBiITdOimWylmykPfkTXfhS4sqgrFx9Giu3xUx+43zVbQyUxChJdg6iPmT
         HeiWnKX5GSegbh72OkDYmtqB6N4LH9diX0i9qmTFDDny6OQ8fYm1EwMzazr9OlSCHHwq
         5id90B+fgGkZL38PccgUTuIT7g5r60m3C5Nf0WCJPxpXETvqLfxz0INWVJlGtdNya9QJ
         53/fnYlnq7roZnQCv5iURC/qX/zMFH0qcBx4dc/mnf5zxu3Zi/T3eIOb0eEvyOC7WNIv
         +iI0xnbeJF+8Ogn24wcsFNOpOHfZQmojUthnLwPsepYP5Z8UkFGTIlaf914PO7uWZjc6
         P9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0hQKAhjKzRdAf3BOn0QaY9ShzH9yzWXnrbIunKq9e3tenakoBMRt5hJ5S/V4X0S7RlU0ClrQG2xYKkrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKW6Xx464lY/r1jm+YQXqopIV9UkaRzIBCANhRpcQ/b8bjctas
	897M1dtSdO/koug+6SU7Ea3if042PeJoBY3i8OuA7kgKqUyAjWBaTFsz
X-Gm-Gg: ASbGncuvumK5SMpZD4EYQqRWH1ywzo0n5rBqhDfz9fDIPwEVIjkU9N1625h3PLtz1xo
	Y/pUnWrNloZQCtHI+vJv0NRHthOFSS/MQsefOOGGD3z+L79vLBH+FpF2fH9bxXUbBrth27g0EpN
	qOh6p92CHN6vAANKBHVsouqk35Ebtjzp03wN47CznO0bAiG+yg4yHkHWTdVtDeMMH+qLF0hmbwF
	W/xIL1aELUcO/MIWsz5NBIJ+Cc8bsI6F7eB4jDNFpSeGfBg0nU3aeowLXYatKDjLyB4ktdgMf8g
	ucbXTqutEoZtBlADIfbgv9zQ3JBq7SCtH3O0zqpkRxJV6evjnJ+vZXQ5Y6goBAkor9lExv4/E4n
	Ba7zAUzt1tO8j5aiie5+QJAlUFLoGI6os5bykGpdukYATRJsxegbGuqDBAgVuKmDjvRuI3mCsSa
	jr
X-Google-Smtp-Source: AGHT+IGcvMSSDnIn1p0y9m8Zo+GqEbnRb8m2pFQ6BPHXmax+C4usDzFi2whoNJCFfyq5n7RDBATVKQ==
X-Received: by 2002:a05:690e:587:b0:629:e2b6:1302 with SMTP id 956f58d0204a3-63b6fea76bdmr4202238d50.17.1759334126258;
        Wed, 01 Oct 2025 08:55:26 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b717fc8e3sm926585d50.4.2025.10.01.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 08:55:25 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Wed,  1 Oct 2025 08:55:23 -0700
Message-ID: <20251001155523.2470826-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <689e36d4-d828-42c5-9e57-ba663adc9ea9@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vlastimil,

Thank you for your feedback!

On Wed, 1 Oct 2025 12:04:50 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 9/29/25 5:17 PM, Joshua Hahn wrote:
> > On Sun, 28 Sep 2025 13:17:37 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > 
> > Hello Kernel Test Robot,
> > 
> >> Hello,
> >>
> >> kernel test robot noticed "WARNING:bad_unlock_balance_detected" on:

[...snip...]

> >> [  414.880298][ T7549] WARNING: bad unlock balance detected!
> >> [  414.881071][ T7549] 6.17.0-rc6-00147-g7e86100bfb0d #1 Not tainted
> >> [  414.881924][ T7549] -------------------------------------
> >> [  414.882695][ T7549] date/7549 is trying to release lock (&pcp->lock) at:
> >> [ 414.883649][ T7549] free_frozen_page_commit+0x425/0x9d0 
> >> [  414.884764][ T7549] but there are no more locks to release!
> >> [  414.885539][ T7549]
> >> [  414.885539][ T7549] other info that might help us debug this:
> >> [  414.886704][ T7549] 2 locks held by date/7549:
> >> [ 414.887353][ T7549] #0: ffff888104f29940 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap (include/linux/seqlock.h:431 include/linux/mmap_lock.h:88 include/linux/mmap_lock.h:398 mm/mmap.c:1288) 
> >> [ 414.888591][ T7549] #1: ffff8883ae40e858 (&pcp->lock){+.+.}-{3:3}, at: free_frozen_page_commit+0x46a/0x9d0 
> > 
> > So based on this, it seems like I must have overlooked a pretty important
> > consideration here. When I unlock the pcp, it allows both the zone and pcp
> > lock to be picked up by another task (pcp lock less likely), but it also
> > means that this process can be migrated to a different CPU, where it will
> > be trying to unlock & acquire a completely different pcp.
> 
> Yes.
> 
> > For me the most simple solution looks to be migrate_disable() and
> > migrate_enable() in the function to ensure that this task is bound to the
> > CPU it originally started runing on.
> > 
> > I'm not sure how this will affect performance, but I think in terms of
> 
> It is somewhat expensive, I'd rather avoid if possible.
> 
> > desired behavior it does seem like this is the correct way to do it.
> 
> I'd rather detect this happened (new pcp doesn't match old pcp after a
> relock) and either give up (should be rare enough hopefully so won't
> cause much imbalance) or recalculate how much to free on the other cpu
> and continue there (probably subtract how much we already did so we
> don't end up unlucky flushing all kinds of cpus "forever").

I think this idea makes sense. Since I am dropping patch 2/4, the remaining
call sites here will be in decay_pcp_high and free_frozen_page_commit.
Here, I think it makes sense to just give up when it realizes it's on a
different CPU. If the new CPU should have pages flushed, then it will be
flushed by either the next call to free_frozen_page_commit (like in
free_unref_folios) or in the case of __free_frozen_pages, it doesn't really
make sense to flush a pcp that isn't related to the current caller.

One concern that I do have is that now it is possible to flush less pages
than the current behavior, since before it was guaranteed that the
specified number of pages will have been flushed. But like you suggested,
hopefully this is rare enough that we don't see it happen. FWIW, I have
not seen this happen before during my testing, the first time I saw it
was in the kernel test robot report, so hopefully it's not very likely.

Thank you for the idea Vlastimil. I'll make these changes in v3!
I hope you have a great day!
Joshua

