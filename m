Return-Path: <linux-kernel+bounces-855326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC5BE0EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C172D4F81B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E857305E2C;
	Wed, 15 Oct 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iMl5GZ+/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B121CC5A;
	Wed, 15 Oct 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566595; cv=none; b=iIwlQR7hTe/UgKzoVvsmVn95H4Ub/A5H2Nlk+YAR/jZQ+6hkyFm0i0R24quvZXQnVMHL7lYjDDGrBxro/KcbyZpIfFx6Y8QhGUC5A8lpkxt7DeBoDPWEOk/U2vA5GMAQGzvpI1Za+x3OQ0rir9fPivaiUHInCpMc9SmjVy/u++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566595; c=relaxed/simple;
	bh=4gNyEzA3FdSDTCsOBZf1sUFnJB64w4jlNHOvXf5+aik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sE/SmkiTP/HQ1JSr+aQJNea6X1/ETvtGhoZuO4kt4qhGJ2mV3UAREZvwb8avf8sERxnwjRvvgzRtIwxr4RPfWy+gY3XTtNqDPWJMap9sti38vkjHo94z8CSZQdCux5l4v2pheZBMqc7J5oTqj96vbXU/XmDapSVFPmcOyzFGgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iMl5GZ+/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=vlOy9twU0YWU7C0lqkL3UADuASRw5amgKmYNLe4gCP4=; b=iMl5GZ+/ddc1yhMVjkoxuQim8T
	KO4gpA3le2sd3F9P2hGWyOC5LhYXxHkkDLxu80N7cvIGTr2EpWx8LQQnp9I/C/CWcBFh5PJRdKZ1H
	3KNKg6NjjrKfvkX/ClmbJ3V2H4aCdAMPvHzb8q3mzgq8RvWm3fwlS9mi3kl4GXT2c01NaXahUREAz
	2SuH8yIwtk4raaI/T0OoIteGbpsCGXSyeY8cdxeLdpw6JI+eRCxXv9ycuQIgvrkIHGejr86wsi/ym
	h77zwNZRJVTxCuP2iP9T9rvHYNr/idXzlQDc+BNSWAzH9lrzsYjNwJLQ422t+dz0n6WItBh56IIEt
	hmRcLn0A==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v99nI-00000007lgC-3kO8;
	Wed, 15 Oct 2025 22:16:30 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <davidgow@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] taint: add reminder about updating docs and scripts
Date: Wed, 15 Oct 2025 15:16:26 -0700
Message-ID: <20251015221626.1126156-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes people update taint-related pieces of the kernel without
updating the supporting documentation or scripts. Add a reminder
to do this.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Gow <davidgow@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 kernel/panic.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20251014.orig/kernel/panic.c
+++ linux-next-20251014/kernel/panic.c
@@ -638,6 +638,12 @@ EXPORT_SYMBOL(panic);
 /*
  * TAINT_FORCED_RMMOD could be a per-module flag but the module
  * is being removed anyway.
+ *
+ * NOTE: if you modify the taint_flags or TAINT_FLAGS_COUNT,
+ * please also modify tools/debugging/kernel-chktaint and
+ * Documentation/admin-guide/tainted-kernels.rst, including its
+ * small shell script that prints the TAINT_FLAGS_COUNT bits of
+ * /proc/sys/kernel/tainted.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),

