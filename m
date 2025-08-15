Return-Path: <linux-kernel+bounces-770922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D7B28076
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39931BC86E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF92FE565;
	Fri, 15 Aug 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HlWIwWEB"
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB61A76B1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263896; cv=none; b=NJAEnXvXbWcM47A3CPspIQeg4q9qXjiwHEnG3qJf2+v1o1Tsuai8UPb9eJwVyHrKl8wcomYVhcgrnC76KW2AsVKDKBHM1QI4WZKKYhw9ON/KxBu5G/nveYba9NbINRvXteK1Ov1cLrGL6oz6TQymMQdsxS+OubBUZaCirfX/32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263896; c=relaxed/simple;
	bh=n4iS5aLB5+JkPBgj69f5R+uOKA4ezjD0k0ZowyIu7d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FznxmTXIZWFJtPOurQvK51NNVdpc0Q/zrABRqEHtlKxJE5Y46SMeQC2mIsz5ydeFkX7Dott/eHG69XP73Ew92i1TSwtB1nP5+7ldIkxbk+SXd2cfOyWOM0j7XacMhMY4ZAwzOnLdhB/1orcJxLKPNSBQ8+O9lNsnmhVbeP4JQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=HlWIwWEB; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=Bb0W3QreuMWhX9jUJbsxnZFTBv+9eZ2r5LVq6jjWm9M=; b=HlWIwWEBqPR/Zm0MJM4XZkTkcn
	nDFvNRBpr4AVclJ1HxMDZaB7lsHvPZ8SoSY6VcBFQJOaT/31N47M4wsp0DPwIOPun6/tN39n0qBBo
	pFkCEd2sUjq0EK8RWYLRZ7E37LKSb6m/5qGZmUs9SQ+LbdT86p5x87ps3DCn7OgJaKnDeen8fd137
	CcSm4grFuU1Uodx8rRhIeR//qeUeONx6M7p9SdWEyM7kNcODf4mK4JnVzKzkHRtICC71j0zI+97fF
	DnidqvSSuXHANejecsAWI/P78cNhci7FaeUAH29idc/mA+fxUd+cmkXdFuwakzEdZOhiha2NBjt6r
	YIFbh+OwiMvnp+Rz6di+bhtPusP8DQTUI19c76/uuQ8Xooycg83dOHlxluXvcE5D0Iek9QJduKP0d
	GMADli2B0dCcFOf4MRPQsbRS4mMl1+0+Xy83dEmrZkGy4k/57EVRetHYIFPUhbF61rko/0BvOao9V
	WZDQycmLblFJDpNhws04kiB/WA2uoXPpdT7vxz1DVzjcHUt6HRbsj8ImIJZGpA2CQgP2CPE1uZYv1
	DIUQ9PF+s5pXMe3LOkrGhcHkKA6dKniR1XQlv+Q1IthguKq1tnp8dlt4JzFtI5rdYXiw4ZxGBO91q
	Jg7hQvvdr7x+cVuGf7f9Ynjabc+0MY4qETQc5jXjQ=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Harry Yoo <harry.yoo@oracle.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: syzbot <syzbot+3f9768ec54c86997ddfb@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
 david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
 rakie.kim@sk.com, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, syzkaller-bugs@googlegroups.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] WARNING in alloc_frozen_pages_noprof
Date: Fri, 15 Aug 2025 15:17:45 +0200
Message-ID: <5288409.JjrPIszM2I@silver>
In-Reply-To: <aJwZPq0b2rckG-ap@codewreck.org>
References:
 <689bb893.050a0220.7f033.013b.GAE@google.com> <aJvc5m8Ocm3S_Xkc@hyeyoo>
 <aJwZPq0b2rckG-ap@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, August 13, 2025 6:49:02 AM CEST Dominique Martinet wrote:
> Harry Yoo wrote on Wed, Aug 13, 2025 at 09:31:34AM +0900:
> > The warning is:
> > 
> > 	/*
> > 	 * There are several places where we assume that the order value is sane
> > 	 * so bail out early if the request is out of bound.
> > 	 */
> > 	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
> > 		return NULL;
> > 
> > There's not much the buddy allocator can do when a user requests
> > order > MAX_PAGE_ORDER allocations.
> > 
> > >  alloc_pages_mpol+0x1e4/0x460 mm/mempolicy.c:2416
> > >  alloc_frozen_pages_noprof+0xe0/0x210 mm/mempolicy.c:2487
> > >  ___kmalloc_large_node+0xac/0x154 mm/slub.c:4306
> > >  __kmalloc_large_node_noprof+0x2c/0x8c mm/slub.c:4337
> > >  __do_kmalloc_node mm/slub.c:4353 [inline]
> > >  __kmalloc_noprof+0x3bc/0x4c8 mm/slub.c:4377
> > >  kmalloc_noprof include/linux/slab.h:909 [inline]
> > >  kzalloc_noprof include/linux/slab.h:1039 [inline]
> > >  v9fs_fid_get_acl+0x64/0x114 fs/9p/acl.c:32
> > 
> > So... 9p FS shouldn't really request that?
> > 
> > Cc'ing 9p FS folks.
> 
> Thanks for the Cc.
> 
> So, this comes up once in a while, everytime we discuss limiting the
> xattr size, then someone says we should do something else or I'm using
> the wrong define or I don't remember and then when I ask what we should
> do never reply again.
> 
> See [1] or [2] for the last two time this happened.
> [1] https://lore.kernel.org/all/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org/T/#u
> [2] https://lore.kernel.org/lkml/20240202121319.21743-1-pchelkin@ispras.ru/
> 
> I'll be happy to take any patch you send (or one of the older patches if
> you tell me which is "correct"), I don't care anymore.
> 

Not that I would care much either, but as nobody else responded, I still think
the following is the way to go:

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 8604e3377ee7..97f60b73bf16 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -37,8 +37,8 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	if (attr_size > buffer_size) {
 		if (buffer_size)
 			retval = -ERANGE;
-		else if (attr_size > SSIZE_MAX)
-			retval = -EOVERFLOW;
+		else if (attr_size > KMALLOC_MAX_SIZE)
+			retval = -E2BIG;
 		else /* request to get the attr_size */
 			retval = attr_size;
 	} else {

---

Values > KMALLOC_MAX_SIZE are triggering the reported warning.

XATTR_SIZE_MAX (64k) would be much smaller than KMALLOC_MAX_SIZE (4M).

The call stack in question comes from ACL handling. In this case there is no 
XATTR_SIZE_MAX limit involved on 9p client side. If 9p server side does,
then server responds with an error anyway. If however server does not have
this limit then why limiting it to XATTR_SIZE_MAX on client side for all?

And if OTOH the call stack comes from the general purpose xattr API (i.e. not
ACL stuff), then there is already a XATTR_SIZE_MAX check on xattr VFS layer.
So no need to check for XATTR_SIZE_MAX on 9p layer for a 2nd time:

https://github.com/torvalds/linux/blob/d7ee5bdce7892643409dea7266c34977e651b479/fs/xattr.c#L616

In the end it is merely a theoretical issue. POSIX ACLs are quite compact
encoded into xattrs. To fill 64k you need a ridiculous large set of ACLs.

/Christian



