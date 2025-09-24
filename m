Return-Path: <linux-kernel+bounces-830097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45478B98BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04412A2BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CA2836B4;
	Wed, 24 Sep 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BE8VXE70"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BED4265292
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701018; cv=none; b=G4m22DjTP+AoU7Ei+HTiaB6NAwFg6ekqQ8J+TO9hShf8myZxHHyuVc9yGgw8FjNogCbKUiFatpbZ68wnGSCorcH6vdwE3dT2ws1P5llVgCtjXWwKnGt/PcYh5EdHJj7qBpazHSxVjhnzcsf8gOc5OwTLOE+ON2i1tpKbE8Iz1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701018; c=relaxed/simple;
	bh=PSFacuoLsrD33DwWCB9zYIlIH1F9vW6/njf3D6cjvqw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oxQ0FNiu3r1BWmllCb7sc5J0PqPWy4L5TtkRbenEqrMvP3fIOD++ZSsgjFRUkJdEPPW1mjwhCIZ8ME6isXd1THNPfMDwWYPPj/qrKDRwwW5vaPEXL8FNIEwF4ptl+vRB8ncnNpqNGvA42wkTo5POTj3rnqyCyLZh0W9XDOPa/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BE8VXE70; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Us3qc8q+lr4gCCXXPB9CTmjAy8+l/zrT5sp8S8hKBNk=; b=BE8VXE708sf3OPt7/JCXzlBfzy
	OqmtjER85QCOFmWXEPJHiZ6OTADVmq/fVEc7IaBEXHT4r/R+56J0S5MHUj4ZbdgwSlDuyMdlIJFUo
	/YCBecunwZoMdvH84Kxp5GDMoPSj5lxsrzdWqA8iEA85jaBB4fMVH51C7lzgd3KU8/Jmj9HTPOrc1
	4OgTbuUBVH0YbpQRh8OHA7fJACUQcORxdcTIiVCmN2FGMsG/0FVIsElRU1HAag92G/GA8xKdhCCAr
	dL+IqjHtwwQUwFXsB9dno2bCYJr7YzEz4MD/GekjB8mD1ZmHznV0s+1b4GmQrxP7mRR0foEWm7Yjd
	9qxwjKlQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KTO-00000008iB8-2bFI;
	Wed, 24 Sep 2025 08:03:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2DF8230300E; Wed, 24 Sep 2025 10:03:33 +0200 (CEST)
Message-ID: <20250924080119.613695709@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 24 Sep 2025 09:59:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org,
 rostedt@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 11/12] unwind: Implement compat fp unwind
References: <20250924075948.579302904@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/unwind_user_types.h |    1 +
 kernel/unwind/user.c              |   24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -36,6 +36,7 @@ struct unwind_user_state {
 	unsigned long				ip;
 	unsigned long				sp;
 	unsigned long				fp;
+	unsigned int				ws;
 	enum unwind_user_type			current_type;
 	unsigned int				available_types;
 	bool					done;
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -15,6 +15,21 @@ static const struct unwind_user_frame fp
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
+static inline int
+get_user_word(unsigned long *word, unsigned long base, int off, int size)
+{
+	unsigned long __user *addr = (void __user *)base + (off * size);
+#ifdef CONFIG_COMPAT
+	if (size == sizeof(int)) {
+		unsigned int data;
+		int ret = get_user(data, (unsigned int __user *)addr);
+		*word = data;
+		return ret;
+	}
+#endif
+	return get_user(*word, addr);
+}
+
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
 	const struct unwind_user_frame *frame = &fp_frame;
@@ -29,21 +44,21 @@ static int unwind_user_next_fp(struct un
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	cfa += frame->cfa_off;
+	cfa += state->ws * frame->cfa_off;
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	if (cfa & (sizeof(long) - 1))
+	if (cfa & (state->ws - 1))
 		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
 
 	state->ip = ra;
@@ -100,6 +115,7 @@ static int unwind_user_start(struct unwi
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
+	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
 
 	return 0;
 }



