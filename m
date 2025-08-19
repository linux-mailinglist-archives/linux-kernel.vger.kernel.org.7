Return-Path: <linux-kernel+bounces-776079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7502AB2C84D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1571C23CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3CD2857C2;
	Tue, 19 Aug 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMvI2GDy"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60093285412
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616731; cv=none; b=jv65o4Frn6ZJuwb8smGL4+bFngm0oSXC7aFL5YCM3wVlYAkOylbw/Ubub5zfQs8nLoYvfdawmKD+K1DUB/qmxkh1eW28SvXn/EfaKyTA+RVC5ZizfcI0qnwYMOt3eTM6Io3KT8iXqpfQGNrPPFDsrRnIYM35Lgj0hKn+31jHc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616731; c=relaxed/simple;
	bh=x0RB2SJPG3/KlKIdY7RY0hyzNHN6WdZY6BM3nHzM8zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9La7s5U/09XxRsiIGn/INcis3wQsIT+9hZ7k4sXjqvgkbQGt6Mpy41+Pe+INXjSuJlO74rzH8vKd3jSnD5Gc8sH60hr4PfGgEm1Qc48BnKXJi6XJBEzP8G4fmCC+m5oXsKfuzIfGNVWp12cQzEZrELKvk50YuGbTDwONsjfAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMvI2GDy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcac45so36314527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616729; x=1756221529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRUc9LqkxwQZjbHD55dqvmWmLwFK/B3FIfNgwPcTxZ0=;
        b=mMvI2GDyCPyVf19VNQRm6vZ3eT4LBOQ0O2WPHpNEQfv8G/o1avo3wJMGZAjoa4WIym
         ecMUwHCf52tN1ivhzJjepJOo+xVX5JNlhrFwrpfLyJumZUF6P/wpjAclzXneSxI8caD5
         baB/Hi62YIGbMLSR/lIOYHmr0MQpv1ER1HDZAektKdzDefdSXuQJE04iNg7RTbKDHwPv
         FZUsc7DdC+oBEiClcbI9aTKvNrLaRfX0gc01vUHA5vOBcML3vOEoomB59a+cfx0GCMUB
         BuilLdSGB2bAA+KO+0wHOL/QXE4WKiKgRSQAiLGrVtUgJDRPutkYVN+DA3yDckecYeRe
         kZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616729; x=1756221529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRUc9LqkxwQZjbHD55dqvmWmLwFK/B3FIfNgwPcTxZ0=;
        b=JYJ82NUhb/PpWJhRL9wWnv833e76w+GYskRKp7PdFvM18s16xATmqWWPMm3zLLnHUg
         CpJRNO//dbtDtpXxe9zb1XEWdYPtFbXOYEE4cAKdA1q2T/pifC6qqumyZsoAUk8RTXwv
         IT+AKIgWn+K9h7W5C2p2d+o1qMIOWD/M8Z4kO3s381L7lRgf+biQ5mXq4qOJRgxEh0Nw
         Tw2mIZpxRCjHSVCP6J5mMMPFvC1f/C167RQGK+loRqd33TwK0G7uWUei+BOIN1ckWkM8
         EPZ5n0hYgeqJcMD0vrNTtxMfmvIvsiDjo2SQRAMVk6y1EW6VfCPYn9sDYXY0X5G5czGS
         t0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCX8J+j0TftAo9+R/YlwzoCWUxI6UopJ0r7xXZ7+HLC7onbtbwf6r0ei0uaUPljShWiOEICmQkUHqN8uKWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvj6SR9CMRMNYMUFrY1HusXgBpCI62225nh3YsSCcAP5M0TU8G
	toVTuM4V1UHTMRT8BE99wOhfVgScop+4tggyg737gL//0flLMkEjBjqk
X-Gm-Gg: ASbGnctjaOjMTPzFWsqiao0RpQZndTE0+TAVvmTCURPVI6p0a4/5KFnCmNeebtDnu0R
	XK213O9P52HZxqwPWUDghGdfbA8+o3vq+T5lVCGt8PFKbW8TW52+WPZX3CPtLX8CZZJ5/EeFmya
	VdCB1Ga1Bx5ptGbC+AGw16cVUr82faaFyjXb+qSYaBubn/YAaVOrHEhBa5RZCCdhe8D9w/xW2rB
	sICbUTx7/7JOUJdSeEGDCTGuiIPDuu/sDIfywEkQeIPcwGwB/f6zMnPPItlXEgZwrbQLKd/hn3H
	V2jQAElK7QS2afyVYhPWAW2H0nsVImwox+d1cXisTLtdMTr0QNUasvoIhpVUXUwpyV0tr+tB0Wi
	5PXF0b/vQX35p6OErwBSULg==
X-Google-Smtp-Source: AGHT+IEAYZG8JniwtwZmiJmxa46+aZaPP8w2nEYVSmlPFm/lWVH6z5++okUzfhixnHaV5qO9RKd7HQ==
X-Received: by 2002:a05:690c:7489:b0:719:fafe:e822 with SMTP id 00721157ae682-71f9d61cc08mr32926187b3.21.1755616728908;
        Tue, 19 Aug 2025 08:18:48 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f96ec62cfsm7947127b3.22.2025.08.19.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:18:48 -0700 (PDT)
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
	kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in batch freeing
Date: Tue, 19 Aug 2025 08:18:45 -0700
Message-ID: <20250819151846.2000539-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250818171340.2f4ce3356f1cda59acecab57@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 17:13:40 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

Hello Andrew,

Thank you for your time & feedback, as always!

> On Mon, 18 Aug 2025 11:58:03 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed.
> > 
> > Instead of holding the lock for the entirety of the freeing, check to see if
> > the zone lock is contended every pcp->batch pages. If there is contention,
> > relinquish the lock so that other processors have a change to grab the lock
> > and perform critical work.
> > 
> > In our fleet,
> 
> who is "our"?

Sorry for the ambiguity -- I work for Meta, so I was referring to their
machines. I'll make this clearer in the next version.

> > @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  
> >  			/* must delete to avoid corrupting pcp list */
> >  			list_del(&page->pcp_list);
> > +			batch -= nr_pages;
> >  			count -= nr_pages;
> >  			pcp->count -= nr_pages;
> >  
> >  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
> >  			trace_mm_page_pcpu_drain(page, order, mt);
> > -		} while (count > 0 && !list_empty(list));
> > +		} while (batch > 0 && !list_empty(list));
> > +
> > +		/*
> > +		 * Prevent starving the lock for other users; every pcp->batch
> > +		 * pages freed, relinquish the zone lock if it is contended.
> > +		 */
> > +		if (count && spin_is_contended(&zone->lock)) {
> > +			spin_unlock_irqrestore(&zone->lock, flags);
> > +			spin_lock_irqsave(&zone->lock, flags);
> > +		}
> >  	}
> 
> Pretty this isn't.
> 
> Sigh, we do so much stuff here and in __free_one_page().
> 
> What sort of guarantee do we have that the contending task will be able
> to get in and grab the spinlock in that tiny time window?

Thank you for pointing this out -- I don't think there is any guarantee.
Kiryl suggested that I put a cond_resched() here, in order to guarantee that
the contending tasks will be able to grab the spinlock. I think that's a great
idea -- I'll make this change in v2.

Thank you for your feedback, have a great day!
Joshua

