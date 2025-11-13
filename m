Return-Path: <linux-kernel+bounces-898655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E21C55AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E99E34CC74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D772FF668;
	Thu, 13 Nov 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPu7h28w"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636A2FF147
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008836; cv=none; b=KC1yDK7yfAwbq2qZ15g4X9hKi9S+1AeNPPocaU1x3KjsZdNzeeQjUa6o7TmNG+a2eYI/gB5cMJfeS8JFSsYz/sEATDL8m22aEDCGOqWicXrFoiNkl/cotZqI/+tYPfkJMTZFKvvOlMPT5YUmeyJQ+5ZRMxxMWyUqIv/HJeRL8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008836; c=relaxed/simple;
	bh=juu52SAGCZwSkv94b8hvBh3dmTjc+fF26d4odP+mFag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0Hb8y4LcsXNmp/b+JQW+Sfut6OoStHDlMLlWXeoQ+MdUkFxMxR6x35lJRscnO8DoJoXuOrXjmP5OyN3yhZnzyMxMpPXqSPq+TvsIMEFA7PP7tuUsdKzZZXTEmN/Fi+Il9P4yVWHkM3Pg4JaLeYHr3Wj4WOcRRoE306ej4P969I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPu7h28w; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29853ec5b8cso3938745ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763008834; x=1763613634; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDmPn0Nf9DwhMNzLqfPhzr9P36pEvch2Q8c/oMsgpUY=;
        b=FPu7h28w5Bd7nPim9PcqKY2VEjzhmMTF01nGfSGnJv4fgOw8lmKEzMPEEWaACULMzd
         vto5rZQWjyzOPC+geQDWJO6vbIsdF5mQjiEDJScJe5WmvyDlz+uRrHXiEloSRnoHYnxk
         S7nW7O7dK8FN7LlSPkuYvZx9BO7mg6u4zKupS9ynUjxj2emMKcej1CZIcvv0XSwBBPYT
         5TUDnY+5mO3fzQCm7rNHzZkBF5dHDOxbp7MZQcKR2GZxIDAq3Z684GKbVrordU9velSl
         Ri1WcvlQqy1gSxln84sbitZ4XCAo6CwnwyHaidumbeJqYnjuCR1Er35JkFtow9j8Rw2B
         4rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763008834; x=1763613634;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDmPn0Nf9DwhMNzLqfPhzr9P36pEvch2Q8c/oMsgpUY=;
        b=SkPu0AACy/b/I1WZ1osCq8AhG6vZD8aPJVS4Ve5SaJIxFvvFOiUhWaBL7j16tcxHnT
         miO9orX6e6+J5y8TviPzJ2HlundzkFIhwZ6L9WhxbzEvLz6rMQ3SZ7C0HJ5w93CSTvl5
         FpaUtMrP0k1R/k14A1sAv5M90D0vxmh9kS46P3/9XikWNo3TdJisWhwOxmBYRnLMi188
         30bn8h2WddJpokCvubFqk8sBE2JVhaUDI4b1dmWM19u0GTKTKeA7xaUb2OumNFvZknxW
         IqoYjdqoGYnAPkHY6vJK6PjA7u5PDND571Dw01l1YX9Z57EOz7hYMo3WclAF8zwe8fIh
         Jq1w==
X-Forwarded-Encrypted: i=1; AJvYcCUg9m9v9rHITGqr1vxnNkqKSmogSy4OncQ6GT1tRZAx5visdY1CKOwjPQmAhM8/VlGbTZQs/ev/FMb372o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlWFEym8zwL9aiPlHuBUi8TeF2kkYxk3rJvrXOT0rsjK/m/SD
	WFChraVmxkWZtRrz10CffnmT0bdwAeibpoioGwSyMg/JC8u49R2yMZqo
X-Gm-Gg: ASbGncvnDq0O3RfUuzSTnihUsR+ad5fTuxelIi3EvVaBPtIXZsOGRPWl2vNm4OKKwKR
	C63cmFDkdd3QqcjbOf72v3vtS1wlG6AHtbakL9JayeSeciaxcALJ9F5q58MbsPHhL0N7jQb7keU
	S/wd73yM43c/7sA0SkJD/HCWpsjqZo9tlzHcsv0N2AmRRwVLueaa7LZ/3SKDDnGhL/o70vtxMpM
	yVxVFMAaSWYlXgFHm0xFqFqEYSxewIYKUmAh4drd2PHJHe3acmWxNjRj0a2iwifeRmtlb3Pr4cx
	TAW86VdITvee08noxaJ40S7yCw2Cx7gUh2ui1EXnTM2pWIy0z2S3WH8616EA3N/6j2er4qisaJJ
	UkSkg1eIs2o13uAd+tnYXtLtASbD/AHcd+nSz3XPK1x2nw+2EwzjdlD4IrFg56RMrhgEw2p0IDX
	A2YpfJcf0AadNl/kk/e8mF0A==
X-Google-Smtp-Source: AGHT+IF0ZSMjJ2Lc8kz3EXKwlmPjL5NLaFbg0SkOYJJftW8mAPB0mC+cHp/6QWluZgrL5V9rxEgvaA==
X-Received: by 2002:a17:902:e788:b0:297:e69d:86ac with SMTP id d9443c01a7336-2984edc8d1bmr74152995ad.39.1763008834480;
        Wed, 12 Nov 2025 20:40:34 -0800 (PST)
Received: from localhost ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d68sm8683655ad.61.2025.11.12.20.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 20:40:33 -0800 (PST)
Date: Thu, 13 Nov 2025 12:40:30 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	workflows@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 00/27] mm/ksw: Introduce KStackWatch debugging tool
Message-ID: <aRVhL91rSZXyZ83D@ndev>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
 <aRIh4pBs7KCDhQOp@casper.infradead.org>
 <aRLmGxKVvfl5N792@ndev>
 <aRTv0eHfX0j8vJOW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRTv0eHfX0j8vJOW@casper.infradead.org>

On Wed, Nov 12, 2025 at 08:36:33PM +0000, Matthew Wilcox wrote:
> [dropping all the individual email addresses; leaving only the
> mailing lists]
> 
> On Wed, Nov 12, 2025 at 10:14:29AM +0800, Jinchao Wang wrote:
> > On Mon, Nov 10, 2025 at 05:33:22PM +0000, Matthew Wilcox wrote:
> > > On Tue, Nov 11, 2025 at 12:35:55AM +0800, Jinchao Wang wrote:
> > > > Earlier this year, I debugged a stack corruption panic that revealed the
> > > > limitations of existing debugging tools. The bug persisted for 739 days
> > > > before being fixed (CVE-2025-22036), and my reproduction scenario
> > > > differed from the CVE report—highlighting how unpredictably these bugs
> > > > manifest.
> > > 
> > > Well, this demonstrates the dangers of keeping this problem siloed
> > > within your own exfat group.  The fix made in 1bb7ff4204b6 is wrong!
> > > It was fixed properly in 7375f22495e7 which lists its Fixes: as
> > > Linux-2.6.12-rc2, but that's simply the beginning of git history.
> > > It's actually been there since v2.4.6.4 where it's documented as simply:
> > > 
> > >       - some subtle fs/buffer.c race conditions (Andrew Morton, me)
> > > 
> > > As far as I can tell the changes made in 1bb7ff4204b6 should be
> > > reverted.
> > 
> > Thank you for the correction and the detailed history. I wasn't aware this
> > dated back to v2.4.6.4. I'm not part of the exfat group; I simply
> > encountered a bug that 1bb7ff4204b6 happened to resolve in my scenario.
> > The timeline actually illustrates the exact problem KStackWatch addresses:
> > a bug introduced in 2001, partially addressed in 2025, then properly fixed
> > months later. The 24-year gap suggests these silent stack corruptions are
> > extremely difficult to locate.
> 
> I think that's a misdiagnosis caused by not understanding the limited
> circumstances in which the problem occurs.  To hit this problem, you
> have to have a buffer_head allocated on the stack.  That doesn't happen
> in many places:
> 
> fs/buffer.c:    struct buffer_head tmp = {
> fs/direct-io.c: struct buffer_head map_bh = { 0, };
> fs/ext2/super.c:        struct buffer_head tmp_bh;
> fs/ext2/super.c:        struct buffer_head tmp_bh;
> fs/ext4/mballoc-test.c: struct buffer_head bitmap_bh;
> fs/ext4/mballoc-test.c: struct buffer_head gd_bh;
> fs/gfs2/bmap.c: struct buffer_head bh;
> fs/gfs2/bmap.c: struct buffer_head bh;
> fs/isofs/inode.c:       struct buffer_head dummy;
> fs/jfs/super.c: struct buffer_head tmp_bh;
> fs/jfs/super.c: struct buffer_head tmp_bh;
> fs/mpage.c:     struct buffer_head map_bh;
> fs/mpage.c:     struct buffer_head map_bh;
> 
> It's far more common for buffer_heads to be allocated from slab and
> attached to folios.  The other necessary condition to hit this problem
> is that get_block() has to actually read the data from disk.  That's
> not normal either!  Most filesystems just fill in the metadata about
> the block and defer the actual read to when the data is wanted.  That's
> the high-performance way to do it.
> 
> So our opportunity to catch this bug was highly limited by the fact that
> we just don't run the codepaths that would allow it to trigger.
> 
> > > > Initially, I enabled KASAN, but the bug did not reproduce. Reviewing the
> > > > code in __blk_flush_plug(), I found it difficult to trace all logic
> > > > paths due to indirect function calls through function pointers.
> > > 
> > > So why is the solution here not simply to fix KASAN instead of this
> > > giant patch series?
> > 
> > KASAN caught 7375f22495e7 because put_bh() accessed bh->b_count after
> > wait_on_buffer() of another thread returned—the stack was invalid.
> > In 1bb7ff4204b6 and my case, corruption occurred before the victim
> > function of another thread returned. The stack remained valid to KASAN,
> > so no warning triggered. This is timing-dependent, not a KASAN deficiency.
> 
> I agree that it's a narrow race window, but nevertheless KASAN did catch
> it with ntfs and not with exfat.  The KASAN documentation states that
> it can catch this kind of bug:
> 
> Generic KASAN supports finding bugs in all of slab, page_alloc, vmap, vmalloc,
> stack, and global memory.
> 
> Software Tag-Based KASAN supports slab, page_alloc, vmalloc, and stack memory.
> 
> Hardware Tag-Based KASAN supports slab, page_alloc, and non-executable vmalloc
> memory.
> 
> (hm, were you using hwkasan instead of swkasan, and that's why you
> couldn't see it?)
> 
You're right that these conditions are narrow. However, when these bugs
hit, they're severe and extremely difficult to debug. This year alone,
this specific buffer_head bug was hit at least twice: 1bb7ff4204b6 and my
case. Over 24 years, others likely encountered it but lacked tools to
pinpoint the root cause.

I used software KASAN for the exfat case, but the bug didn't reproduce,
likely due to timing changes from the overhead. More fundamentally, the
corruption was in-bounds within active stack frames, which KASAN cannot
detect by design.

Beyond buffer_head, I encountered another stack corruption bug in network
drivers this year. Without KStackWatch, I had to manually instrument the
code to locate where corruption occurred.

These issues may be more common than they appear. Given Linux's massive
user base combined with the kernel's huge codebase and the large volume of
driver code, both in-tree and out-of-tree, even narrow conditions will be
hit.

Since posting earlier versions, several developers have contacted me about
using KStackWatch for their own issues. KStackWatch fills a gap: it can
pinpoint in-bounds stack corruption with much lower overhead than KASAN.

