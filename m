Return-Path: <linux-kernel+bounces-813955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78EB54D82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8027D585DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EE3054C2;
	Fri, 12 Sep 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZcevTKq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpofT1VE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A126561D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679537; cv=none; b=KqrH9KAK1+z/h3PckBAjr5ySyHA+fzI52QWjTxIHbDKqedowFbIrKSTvdnc1hd5ItiKNheek5oNoJh0prTf1BNdKlduwurBopCTQ2ypW5DDuROO3PTGpfxjcLuihjwK6QC38f08NpPMWoEU5EyfKiKllQyDBX2SgiqmsbcEJURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679537; c=relaxed/simple;
	bh=ABvzICjdVXxp1cGfuIbuz4Kx5orQtOyp59YG57wCXoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pm1WkjTGkepp19fJoQceyxZxzSNfKHRu10LG4bnqqK7ys8FGY2QRw36PKcGQeZCQuoeRaNoTIbl4l6dSfUGZPHq2tl3M8kT5sXwDmd6G6iY+h46fH/TEUZlDui3Jarr8aUyO5zpPxOirhkq6GNpfUqsgqC9qUvZDOYNU++NgulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZcevTKq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpofT1VE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757679533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LNzfHrwTpEeA2/Z1OEP18uTx1hVAYg2JP4zWV0gN5CU=;
	b=yZcevTKqSda8eogZqh2tpqdQ3PsWZFVveKjA6VHz2jPGcMbxXzV+plYWzjgYcI6mySZu9a
	HgD/Db1GjusgM86UZeJg2uYhs0xUCheTsbv9Tikx9OerrUo/X32S2pENxvlXOXYgXKZGzM
	6zD7To+89Mlt8CRTXkNyTu4VAK3x4YusNJjlryh8SEaueYaZiWwe5z2dxgObgP3/t0NGXi
	8Er3oFc13dgsqD+hK+AE41CSevc2r00+CNxSNSc8ogafdjUhw58Lfj2qI821mmdIPEXXpv
	DX7vq+r8tUwOVrXgQmPoIMZVfjdHCPEIrqFov+m69pJxl6LazemYWkdTzn2xZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757679533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LNzfHrwTpEeA2/Z1OEP18uTx1hVAYg2JP4zWV0gN5CU=;
	b=ZpofT1VEduEClpLag2REwZigsNTRVUZYhAYq9I0YvGzisA9aNRASwmJK3xbRLVEfr2vUJS
	nW8jBuPilPY5t1DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Breno Leitao <leitao@debian.org>,
	Mike Galbraith <efault@gmx.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 0/1] Allow unsafe ->write_atomic() for panic
Date: Fri, 12 Sep 2025 14:24:51 +0206
Message-Id: <20250912121852.2666874-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

An effort is underway to update netconsole to support nbcon [0].
Currently it is not known exactly how a safe ->write_atomic()
callback for netconsole could be implemented. However, without
->write_atomic() implemented, there is guaranteed to be _no_
panic output.

We decided to allow unsafe ->write_atomic() implementations to
be used only as a last resort at the end of panic. This should
allow netconsole to be updated to support nbcon and still
provide panic output in "typical panic" situations.

I considered extending the feature to also allow such consoles
to print using their ->write_thread() callback whenever it is
known to be a sleepable context. However, this started to get
quite complex. We can revisit this extended feature if it is
determined that it is necessary.

John Ogness

[0] https://lore.kernel.org/lkml/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt

John Ogness (1):
  printk: nbcon: Allow unsafe write_atomic() for panic

 include/linux/console.h |  3 +++
 kernel/printk/nbcon.c   | 17 ++++++++++++++---
 kernel/printk/printk.c  | 23 ++++++++++++++++-------
 3 files changed, 33 insertions(+), 10 deletions(-)


base-commit: 37dbd4203b42c10b76d55471bb866900f99d6bc1
-- 
2.39.5


