Return-Path: <linux-kernel+bounces-735989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F317B09652
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1371B1C46934
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B922CBF1;
	Thu, 17 Jul 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eI/a1hIU"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7951DE4E1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752787300; cv=none; b=R4T9czLp2TnBEjeBjYPditRqTRyDsbfRmEkeHgyjd7MiEkY8qs6yRIfqFGZxO4+kdchKYXkFGRhPy+tSaFZ0htraQwgh7nKS+YHuJMIk//X6JDj1KM9mrtxQfbxMsfEJGb5sp3B4sJaIWKxWKmRTfvtG2d+2PBVb0p5UNQjyz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752787300; c=relaxed/simple;
	bh=1IIyIhq+JnDSNrAjV862FNh1WgIRqXKR+CXI+ZGxi2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIZyM5hOGhMpXB57LEMMJgxudNXSVNwpR0liiBWWrfxmkvG35bWCwVIoR+987r+CzyA0ccy/XGz1wE0uAPX/WS2CiRTGyL0AZaAZI/fqWcV1d70ygU2laHsCejUpqxNWQJrWInv80K8CZhajwBCsKQ8mtfbbyU76VUFmsyP87YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eI/a1hIU; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 17:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752787296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNJ6auU201E2vgLrfyIXhmnR4RN1loMFCz4uhK02i8c=;
	b=eI/a1hIUF+vdhUm0tj0WcrkjcHyPGRUfVgouEL6VFhLAE/+j6BgsYFo2KDSQHWEP9fbZV3
	WD+SeDo/+Vw8LU+sq1vxE3VslsJd/hNUAGuR+GhUwiQBje3TA8LR5LhQK5qlVbUYWxn9qh
	dsiA6Wha1tKXWQ7Px2X5c4I5JhtWK28=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+6d52ee9afea131b36348@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_dev_free (2)
Message-ID: <njvsgnfvwy3jwoy3zu23jp4365sp7aedqyllnf2efvqk44wr53@nuzknq3f7cem>
References: <68794b5d.a70a0220.693ce.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68794b5d.a70a0220.693ce.0051.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 17, 2025 at 12:13:33PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8352908bdcd Add linux-next specific files for 20250716
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=156f67d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2594af20939db736
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d52ee9afea131b36348
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a2158c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138bc58c580000

regression from

bcachefs: Fix __bch2_fs_read_write() error path

fixed by

(mark dirty before we start the write refcounts)

commit 212c9b90f9915058b4d98210660daa10860b124b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Jul 17 16:11:38 2025 -0400

    fixup! bcachefs: Fix __bch2_fs_read_write() error path

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 4e038f655f83..0fc0b2221036 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -514,6 +514,10 @@ static int __bch2_fs_read_write(struct bch_fs *c, bool early)
 	if (ret)
 		return ret;
 
+	ret = bch2_fs_mark_dirty(c);
+	if (ret)
+		return ret;
+
 	clear_bit(BCH_FS_clean_shutdown, &c->flags);
 
 	scoped_guard(rcu)
@@ -537,10 +541,6 @@ static int __bch2_fs_read_write(struct bch_fs *c, bool early)
 		bch2_journal_space_available(&c->journal);
 	}
 
-	ret = bch2_fs_mark_dirty(c);
-	if (ret)
-		return ret;
-
 	/*
 	 * Don't jump to our error path, and call bch2_fs_read_only(), unless we
 	 * successfully marked the filesystem dirty

