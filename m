Return-Path: <linux-kernel+bounces-735988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83825B09650
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F285860CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16C22A4EB;
	Thu, 17 Jul 2025 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ieOIcZ1b"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B351DE4E1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787216; cv=none; b=OhdZV4xplFG2twnHyMZBkIAc6hYxJmBzu+kYQmoFO1G3VXvZimAXesOXxi8f9R1bJHvA+IE82C+g7FKjPPPO1Ob0aanM5aHxeYSnNQH4Uvf9bVnQ4ZlfH3uHuaJFJpS7jQkWYUDinOioy6yehcMgp22eQRp7v6ZZV0Us8yjNeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787216; c=relaxed/simple;
	bh=t086Y0WBypJt11np6ZFZrPY5bSxS2lWjpbU0LwWMfu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5Wzxa6u86suzowRnnAVl7QwxXtoq0N2DApF2mT23d0wjTMh3OiAPofLYGJDCrAc77bGqezIjWoB82AyeenVbR1N08Xx4TdqyvRoPsnvT+LbuimyBcLBB5584numNcey1H0PGbp+9oWSdEnokGGFeY+D6sHV0u58CPIuHbm+O+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ieOIcZ1b; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 17:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752787198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHiglHGetQCJWdqUKUh+y/NkPsr2EhXh1aeaxNqtTOg=;
	b=ieOIcZ1bs6fSgWYXYgGuodQSP+U0kHkKjywTm6u1RE7YlLQrzKJGnr3/UzXkOVJhaqLdMk
	l0vTiV0APBNY6FdBXMorE9bnq2iIHSOsjs4ctZzKAGOiB4nmdTmgDO8qYd1EALas8d+m8g
	sYc/sFbew13k+ztCHNTU+1yypVeO/ng=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+1faf405b707c6475482f@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_printbuf_exit
Message-ID: <chw42cnofp6t3swazunegsdf3q44kacv3og4dttvcbddmyuer3@k7ehkcsuvf7m>
References: <68794b5c.a70a0220.693ce.004f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68794b5c.a70a0220.693ce.004f.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 17, 2025 at 12:13:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=100e158c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2594af20939db736
> dashboard link: https://syzkaller.appspot.com/bug?extid=1faf405b707c6475482f
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b1e382580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e8e7d4580000

regression from the CLASS() conversion, fixed by:

commit e9b9bdc34894fb1cd5d0798507b4cca4f6435ad3
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Jul 17 15:20:06 2025 -0400

    fixup! bcachefs: convert str_hash.c to CLASS

diff --git a/fs/bcachefs/str_hash.c b/fs/bcachefs/str_hash.c
index dfe4b6ae0733..3e08e55d2dc1 100644
--- a/fs/bcachefs/str_hash.c
+++ b/fs/bcachefs/str_hash.c
@@ -329,7 +329,6 @@ int bch2_str_hash_repair_key(struct btree_trans *trans,
 out:
 fsck_err:
 	bch2_trans_iter_exit(trans, dup_iter);
-	printbuf_exit(&buf);
 	if (free_snapshots_seen)
 		darray_exit(&s->ids);
 	return ret;

