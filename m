Return-Path: <linux-kernel+bounces-589798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B2A7CA53
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 18:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07251894A26
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829DA20330;
	Sat,  5 Apr 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ireYZotd"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0986331
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871519; cv=none; b=ASYDv9Oa39AnqZMFDp+yMO/sJhLMNu3p/Ux2COwp/JeW98+wzEbN7yNxFkvNT2NCbQQe3EDkQJFSGmoEyclhpWX5fbAvFkXiGlafTQn8Vg8Gu+JxyHjWkFVt/7LGo5wXHlMddDgixLcp3O/v+J68tTehJd0sufNWjaEYhVZuUKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871519; c=relaxed/simple;
	bh=SVc+VfZ3HKxUeWYTJ/sj4qhJR/2kIXEqny20zOOhIwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIYn68rlrwjGurmKy8HAP+XKikQrqBN6mSqSObIZCOA3e34pu9f1k9coTyv6SBWG+cCBOJcpqsAKu12lDb1GxPsZopibPJnLkQluIRd+yJRoj+7SHRLCRtjG5eoyheqdQ1ciigmdooWr6IWdMA2L/7uraGfmtm5EzXQOYxsRQTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ireYZotd; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Apr 2025 12:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743871513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxOVhbt50OOVubY/VLWR6XpT5Ht5UochwNmtS1/b784=;
	b=ireYZotdp4oU3l9xqUpDWCxE6M2vrNnRqaZX2j5/3Tttaej6jhtYBm7JTP/liTk7wDibI7
	yoLY1zv299VVrjdsFg38AnILDl5rAssriOv8S+r8n/NsRTCnqwdO/vQpq1k8ah159PRFTj
	iJv2myuMS2l9+41YVo5fASxwZqpyASc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+2deb10b8dc9aae6fab67@syzkaller.appspotmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in
 bchfs_read
Message-ID: <ic4vadw4umsgdkx7mopnq2gxf33eoglf3ln6kfs4n7kihr6jz3@zmq2iyakast4>
References: <67f106bd.050a0220.0a13.0235.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67f106bd.050a0220.0a13.0235.GAE@google.com>
X-Migadu-Flow: FLOW_OUT

#syz test

commit 7dbcd51dd047c38515b76a626f6db911b360383b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Apr 5 12:26:43 2025 -0400

    bcachefs: Fix UAF in bchfs_read()
    
    Commit 3ba0240a8789 fixed a bug in the read retry path in __bch2_read(),
    and changed bchfs_read() to match - to avoid a landmine if
    bch2_read_extent() ever starts returning transaction restarts.
    
    But that was incorrect, because bchfs_read() doesn't use a separate
    stack allocated bvec_iter, it uses the one in the rbio being submitted.
    
    Add a comment explaining the issue, and revert the buggy change.
    
    Fixes: 3ba0240a8789 ("bcachefs: Fix silent short reads in data read retry path")
    Reported-by: syzbot+2deb10b8dc9aae6fab67@syzkaller.appspotmail.com
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 19d4599918dc..e3a75dcca60c 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -225,11 +225,26 @@ static void bchfs_read(struct btree_trans *trans,
 
 		bch2_read_extent(trans, rbio, iter.pos,
 				 data_btree, k, offset_into_extent, flags);
-		swap(rbio->bio.bi_iter.bi_size, bytes);
+		/*
+		 * Careful there's a landmine here if bch2_read_extent() ever
+		 * starts returning transaction restarts here.
+		 *
+		 * We've changed rbio->bi_iter.bi_size to be "bytes we can read
+		 * from this extent" with the swap call, and we restore it
+		 * below. That restore needs to come before checking for
+		 * errors.
+		 *
+		 * But unlike __bch2_read(), we use the rbio bvec iter, not one
+		 * on the stack, so we can't do the restore right after the
+		 * bch2_read_extent() call: we don't own that iterator anymore
+		 * if BCH_READ_last_fragment is set, since we may have submitted
+		 * that rbio instead of cloning it.
+		 */
 
 		if (flags & BCH_READ_last_fragment)
 			break;
 
+		swap(rbio->bio.bi_iter.bi_size, bytes);
 		bio_advance(&rbio->bio, bytes);
 err:
 		if (ret &&

