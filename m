Return-Path: <linux-kernel+bounces-765918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EAAB23FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C401A725A95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56029BD97;
	Wed, 13 Aug 2025 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XVbe1UW7"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761BB23D7E4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060569; cv=none; b=LrD5TF3vPQcOcqBcaOcF1fBYik4amQs7FC3JKSUbll4b989BuQKDWtpPYxBup4exoeivoR56tkL+99M5/z7g+IBi6V83xEzjjoKFEm+lT6w3zafru2vko9M+8qM1Crkc6R90FdF3er+qqrjlWL5RcM+3W+jBdgKoSmm9rCv4lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060569; c=relaxed/simple;
	bh=bINWFcx+i0l+3T/UEIJHibArgyaXAJG8U1O2POFs8tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFr+tl3titbwo3Z5j6JKAjGzEfsaKy+BfzMaTLl+peNjGi3TL9FUnuLlozAplh6RN8Fc29CZ9M6SvdtXYMpApj7W7yDJJjRFltXZVTSIu++xIb9QtKKqbBzRxW7fnYON2VU4P408C7lDGGMzizxBNylvT8o78/e7rRz2ItdQFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=XVbe1UW7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9D91914C2D3;
	Wed, 13 Aug 2025 06:49:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755060564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gYQPNPMmKQR/y69joJ6grvfQ7sb2M14s/jfpiUm4+w=;
	b=XVbe1UW76zHNmZAYQ87tMsEgOECdFfIgVSw+Fy2jy1ArOng+EKOYVY7d04N44rEwrSxoIO
	dePoHBHkmwcbHlcRskh5EJ8CFL4DeIU9I8dR1ghoO1A65TnrsHwz8csFGMFPmmRMh4K5fB
	Fm2nnTeYxWjgm3XxvQFsGAxCMrBFqrqCPGJtcaCAz8Hw1jmQVrBUFDFWJ0GfuBC0qYjEXj
	Njrq+10uY8Vd2P8LhoiV0aBW2t8yt74TFCEAiTGz8AU4m+Y1QZTDR6A3ywlo4iiDSWlu/g
	ml2GFm7Z2xbb2wkVSJ9sNeWFZpgXWU1d+u7Q+aVoAvmgqfGLJn4EnbwMexDuQA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3e5818ac;
	Wed, 13 Aug 2025 04:49:17 +0000 (UTC)
Date: Wed, 13 Aug 2025 13:49:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: syzbot <syzbot+3f9768ec54c86997ddfb@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	matthew.brost@intel.com, rakie.kim@sk.com,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in alloc_frozen_pages_noprof
Message-ID: <aJwZPq0b2rckG-ap@codewreck.org>
References: <689bb893.050a0220.7f033.013b.GAE@google.com>
 <aJvc5m8Ocm3S_Xkc@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJvc5m8Ocm3S_Xkc@hyeyoo>

Harry Yoo wrote on Wed, Aug 13, 2025 at 09:31:34AM +0900:
> The warning is:
> 
> 	/*
> 	 * There are several places where we assume that the order value is sane
> 	 * so bail out early if the request is out of bound.
> 	 */
> 	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> 		return NULL;
> 
> There's not much the buddy allocator can do when a user requests
> order > MAX_PAGE_ORDER allocations.
> 
> >  alloc_pages_mpol+0x1e4/0x460 mm/mempolicy.c:2416
> >  alloc_frozen_pages_noprof+0xe0/0x210 mm/mempolicy.c:2487
> >  ___kmalloc_large_node+0xac/0x154 mm/slub.c:4306
> >  __kmalloc_large_node_noprof+0x2c/0x8c mm/slub.c:4337
> >  __do_kmalloc_node mm/slub.c:4353 [inline]
> >  __kmalloc_noprof+0x3bc/0x4c8 mm/slub.c:4377
> >  kmalloc_noprof include/linux/slab.h:909 [inline]
> >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> >  v9fs_fid_get_acl+0x64/0x114 fs/9p/acl.c:32
> 
> So... 9p FS shouldn't really request that?
> 
> Cc'ing 9p FS folks.

Thanks for the Cc.

So, this comes up once in a while, everytime we discuss limiting the
xattr size, then someone says we should do something else or I'm using
the wrong define or I don't remember and then when I ask what we should
do never reply again.

See [1] or [2] for the last two time this happened.
[1] https://lore.kernel.org/all/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org/T/#u
[2] https://lore.kernel.org/lkml/20240202121319.21743-1-pchelkin@ispras.ru/

I'll be happy to take any patch you send (or one of the older patches if
you tell me which is "correct"), I don't care anymore.
-- 
Dominique

