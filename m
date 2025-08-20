Return-Path: <linux-kernel+bounces-778205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EB3B2E292
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6203B472C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7632C33D;
	Wed, 20 Aug 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTOcRBUu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55C221269
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708078; cv=none; b=UYgLw7myqTc8pTCYum8hn7meQKkPY0j5PoL6OSgNRKrTc9GCtcob5U/oUY+991jOFiYJVzTH9cfpw24SKzqLLiSaBWsBwcTFtzXtDi3oZSUdICG8ySqs+dWmhOqIwGnrylLLNqUprJzSHPcgQVdDOhgDIy6VRH9O5Nlv2kavrnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708078; c=relaxed/simple;
	bh=vKql35OATtk8MbG3vFukwVxdKhHputtvBpkYeZ8ibFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t9Hmu81s5qE+gmfH/8ED/vEc9YezXiIk1ze5AQvrXr3zTGRD1ONGSm04yfPd1GXjmqw2K5XAaGSI0KLvmOv2tDgbkz3cZ0N2c5HHeFE0P5g5ce37EAa/WcnnaebUAuM0icELZK7TvK2yQ39UPiRhwpB+DNLQ0hrWX7BGObE0xI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTOcRBUu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755708073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=v0g2AW/d1eHPKArJ+UolZeDF1nJGsBfr4pi8OMdYORM=;
	b=MTOcRBUua6qlLOvFLGVdE7zFKhHhIZ12lh/S+zYRe9wUTrSZoY+6pe4erscjB9oYVW0nL1
	3fbxNU8TC6SxNWEOQQ9UQ9CbGwuU6GURdxOW/PKjmr8Suqpj8iy/VhpPUxIMlK8K/PltpD
	fCa1iqyls/a5VY4TyKVKl5zaKI4UsdI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-MfGAqoiEMkyvwlVbsoW0YQ-1; Wed,
 20 Aug 2025 12:41:09 -0400
X-MC-Unique: MfGAqoiEMkyvwlVbsoW0YQ-1
X-Mimecast-MFC-AGG-ID: MfGAqoiEMkyvwlVbsoW0YQ_1755708068
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49CCB1956079;
	Wed, 20 Aug 2025 16:41:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2A7723000198;
	Wed, 20 Aug 2025 16:41:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 20 Aug 2025 18:39:49 +0200 (CEST)
Date: Wed, 20 Aug 2025 18:39:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fork: kill the pointless lower_32_bits() in
 create_io_thread(), kernel_thread(), and user_mode_thread()
Message-ID: <20250820163946.GA18549@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Unlike sys_clone(), these helpers have only in kernel users which should
pass the correct "flags" argument. lower_32_bits(flags) just adds the
unnecessary confusion and doesn't allow to use the CLONE_ flags which
don't fit into 32 bits.

create_io_thread() looks especially confusing because:

	- "flags" is a compile-time constant, so lower_32_bits() simply
	  has no effect

	- .exit_signal = (lower_32_bits(flags) & CSIGNAL) is harmless but
	  doesn't look right, copy_process(CLONE_THREAD) will ignore this
	  argument anyway.

None of these helpers actually need CLONE_UNTRACED or "& ~CSIGNAL", but
their presence does not add any confusion and improves code clarity.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499d..0e8805d88ca6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2539,11 +2539,9 @@ struct task_struct * __init fork_idle(int cpu)
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 {
 	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
-				CLONE_IO;
+			      CLONE_IO|CLONE_VM|CLONE_UNTRACED;
 	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
+		.flags		= flags,
 		.fn		= fn,
 		.fn_arg		= arg,
 		.io_thread	= 1,
@@ -2655,9 +2653,8 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
 		    unsigned long flags)
 {
 	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
+		.flags		= ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (flags & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
 		.name		= name,
@@ -2673,9 +2670,8 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
 pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
 	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
+		.flags		= ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (flags & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
 	};
-- 
2.25.1.362.g51ebf55



