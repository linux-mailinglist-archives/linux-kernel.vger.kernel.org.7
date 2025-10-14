Return-Path: <linux-kernel+bounces-853262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C9CBDB0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E794E77E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726122C032E;
	Tue, 14 Oct 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8dlO95s"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BB292B54
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470136; cv=none; b=qOXBelD/aHiQzqhSoUCX/OJuhUMzfK612Gd4sY9i0++izWJqiteRpjqcwEZkYl6Z7LfGoTYGQrDDTRinolhq+4TYCRjhaCGNtiVzOruZ30BGCOQ0/wLgCOyBbU75b+ggbNpcJshWRvYkhDfHJOKuSVjkYD3inRhiWbw4fI0eDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470136; c=relaxed/simple;
	bh=FUxAoaELBFsWN2kh4wyDAFuUSyZwR8o1KitzNLaWNqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+4V5NMMGTE58fSqKCRTznlB5+u4L2VY5D7PwGw5AJN0KYSqY9LSVYERQEMcngCyrGUF1NaiQ2MYPXO9lEhFvY2ShgstC9o8ZudqrIMe326t8yX522UI9cmLv/vK0orWUSu7k5RTIt3A9Mg4/OZCayOqhNhui+3CVpQwGBwIv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8dlO95s; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7815092cd0aso10618997b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760470134; x=1761074934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BznyztNdIKqiPGunKGQKnMKEgfA7Hg4YA0DdSTYZc+4=;
        b=I8dlO95sRWNDj4jAXIg/LRWs/z2l60g37y2QMp10tgxhZoFteR6+Kyq62yrcvIFFwj
         QwD3NJBPHStnce+xAhwaGb1QeQGhIFIyjleqqLyW+6d3bnS+mCjhGztkdhkRZfRqXYOP
         NGq/9BYkaPwmAF13c8T6jmAB/3RDYtb9umFGa/siXNljIJ11C/fLMHvcNsSr4FNjRs+0
         clN9fCM4KwTzgbmyGTbXzcyt8fI5TaUyMH1aTUt8BQydfpsuY07t9/PSAIrVJxXHLcFy
         OvuZK++U3xDzXubER0Wdpumz5f/gorbut1I2wl6zzZtvUFD8AB8zAIjG5iHVkenG34fI
         bl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760470134; x=1761074934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BznyztNdIKqiPGunKGQKnMKEgfA7Hg4YA0DdSTYZc+4=;
        b=ew4tUxjc9mIsge78IlQIsfT+8h1y5bOHBQ/z/0RHX/Z3zdNY58/spDISBOv+H8gV01
         Ni1M1x+j+6V7q3WNzQ9qisueYnzFSiSFmB9G0Yjbfh6Zcojb2fNVPRn9Xzp3sHovUtaR
         O1edk/x/JiQtfF7l0q3Kc87Ctjz5DJYpxz0NHscUrK3gWyEUS3pXnWHMzf4vS5PZDe9n
         Y5h5EMcJtLu496rYRi7X+lxJhGnF6bWJ4I+wRxaZrx6MHPQG5QokSmtLrAZCJrjalDsS
         BYgqOpGO7ZXCJ4M06dwcVd3lrN4YkwOUKonBHL34ftis5WYv0N4OKDV+cva79OBsIIjv
         I4yg==
X-Forwarded-Encrypted: i=1; AJvYcCWwZSfKuTGUxiNskf1t1YIEJhhRvl6qy6Sb0BKBiCcxKzL4WrMKvx/L2dyguidKTWCjlJfF9h6bNsmWp+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYi5q8w0UR78QIHlkjq/7YRMgaYchyE3x4AhcExP9IgYOBnGrI
	Yo1jYaBHS9E/xjA6RBcXKSLGLRr7YJ0O23VAabRvVJ1N27Y0aqqqHlux
X-Gm-Gg: ASbGncvDTTkJfrZ3uZaBtK+CXn1Hnll2uor1okhHJkcWYl8yFBG9j1+OIQP2cihD7hQ
	N3+Nm8XRNj7FSIfYr7r+l8Zt1W3U0BcRo4Jg969+xkfprtjrIzh7R94nNfcEQdAkKIuRAUGd0lO
	qPdA9ooefRCzX4Y2quwx1N1gStmsi0nPaLwdt4+kMufIO2F9fClcZ6r8bM919vVjh5ZKnnQ2fcc
	IVwGX5SOuo5K5XLxKKxs2FTTjnijtb3dV1EhKPgFeqYovXeVWtnJPpXhAdqML1xqcMPvW4yETn7
	W8LlXE0LWN670UM6c3QOSdczMoYU1FF+Pcv9VJf93ajf6jvVBBsSZ18ox7wlIjEtCEJaGZsS7/Q
	vKbJSmyOmVHgStxDtM5ZMsVu7pgDedxyBCy4ZX2WHT/bgfZDpUQ3Q2CShw1fbxMYvL/5Rd3a0S1
	1zkzTslutn
X-Google-Smtp-Source: AGHT+IHUNZvALbfEmm2kCV99S3+gpLu5CmEocy1YAJb3Ch2vMTwHdbAyyx2AzGcyVwiIQNB9n3ZAmg==
X-Received: by 2002:a05:690c:b9e:b0:781:23f5:17a7 with SMTP id 00721157ae682-78123f522d2mr111503887b3.11.1760470134198;
        Tue, 14 Oct 2025 12:28:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781072bb8easm35715457b3.60.2025.10.14.12.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:28:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Tue, 14 Oct 2025 12:28:22 -0700
Message-ID: <20251014192827.851389-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014145011.3427205-4-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 07:50:10 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Before returning, free_frozen_page_commit calls free_pcppages_bulk using
> nr_pcp_free to determine how many pages can appropritately be freed,
> based on the tunable parameters stored in pcp. While this number is an
> accurate representation of how many pages should be freed in total, it
> is not an appropriate number of pages to free at once using
> free_pcppages_bulk, since we have seen the value consistently go above
> 2000 in the Meta fleet on larger machines.
> 
> As such, perform batched page freeing in free_pcppages_bulk by using
> pcp->batch. In order to ensure that other processes are not starved of the
> zone lock, free both the zone lock and pcp lock to yield to other threads.
> 
> Note that because free_frozen_page_commit now performs a spinlock inside the
> function (and can fail), the function may now return with a freed pcp.
> To handle this, return true if the pcp is locked on exit and false otherwise.
> 
> In addition, since free_frozen_page_commit must now be aware of what UP
> flags were stored at the time of the spin lock, and because we must be
> able to report new UP flags to the callers, add a new unsigned long*
> parameter UP_flags to keep track of this.

[...snip...]

Hello Andrew, I hope you are doing well! I was wondering if you could help
adding this as a fixlet for the patch I am writing this reply to. Vlastimil
kindly pointed out that they should never go negative, so checking for
0-ness should be sufficient and more readable than the <= checks.

I think it is OK to leave the changelog in 0/3 unchanged, since it will not go
into the commit history and Vlastimil has already left a correction. But
please let me know if you would like me to add a correction for that as well.

Thank you as always, for your help! I hope you have a great day!
Joshua

...

Since to_free and pcp->count cannot become negative, make the checks into an
equality check instead.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d544521e49c..fd46a982ce3c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2884,7 +2884,7 @@ static bool free_frozen_page_commit(struct zone *zone,
                free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
                to_free -= to_free_batched;

-               if (to_free <= 0 || pcp->count <= 0)
+               if (to_free == 0 || pcp->count == 0)
                        break;

                pcp_spin_unlock(pcp);

