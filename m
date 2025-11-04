Return-Path: <linux-kernel+bounces-884094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8966C2F578
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A647B4E5765
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE152BEFF9;
	Tue,  4 Nov 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N9Nx1EbA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0F2C11F0;
	Tue,  4 Nov 2025 05:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762232975; cv=none; b=Q3eT5wfHCTejbW/tbyyLVk8HTpxLnU6KvaFb8vIrQ+HXGUQjrWZYCkyZdjJgUt7F98wzmBTgAgLM+dBxOa6bNSsBu1t1NA0CnDRm+114PZ8kFaBEF2ZVR05ywiNM2+/6HcCbuGHjasucYx5gJEVIhP85PH1EcTmaHjcBScDpeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762232975; c=relaxed/simple;
	bh=Xm3ZQG9jWlxh0jWu1SKaxldPRarrvkzzyTjgk29sINE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d60jFZtpUztIp1E92sZhjLMaua4pq+CDWh16Vsb7I1XQ18Y6ngCDkLpY+8lH/EznYPg+N5hOqAGubfBnvDjnvG6q70zEvYc+juSn9yASiWBESWnvQFDAQir8npS6no8B6yLw0CnrB9ijc0MvtE39U10sC5B+6raiVh4g6F2862E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N9Nx1EbA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TqnuaB3ZH39FI4qYYrNDm8+OwzfNHaq8zbC+XnwZlAQ=; b=N9Nx1EbAnWrnGEGWUtrkRYMBAZ
	huQOULxvORkb5MY3rK+JyqpULGzpUiLtghQY6c6yZaTpHZ9B94bRByIY3ozvwW5NE1wk36RxQUgcm
	kwLvei0yQq+5jpSjyQBQGu5z1EX3p6nM8+DhruO0G8SSzyWzhg4NCGsK0ZJ4KWBoFI0GMuWthNaOw
	q6+pMz1GSNCjLgqzkqfo+P3A3cCVKKmWHVuRB7T7qRb1wzIqqe+m1U7oTC8o77LzhaKa0V6EVppiF
	Npb6Wl+CavW5FaaSHvWtlhPMx4BKIKaVqQ65dQN9cU5gTA0MfGMOkoSHFMnz8saywa13Q6kuXC25b
	GOH46l1A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG9IR-0000000BAVi-0oLK;
	Tue, 04 Nov 2025 05:09:31 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc-guide: kernel-doc: add %CONST examples
Date: Mon,  3 Nov 2025 21:09:30 -0800
Message-ID: <20251104050930.720711-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add examples of using '%' for formatting constant values to
facilitate more usage of "%CONST" in kernel-doc.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/doc-guide/kernel-doc.rst |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20251103.orig/Documentation/doc-guide/kernel-doc.rst
+++ linux-next-20251103/Documentation/doc-guide/kernel-doc.rst
@@ -405,6 +405,10 @@ Domain`_ references.
 ``%CONST``
   Name of a constant. (No cross-referencing, just formatting.)
 
+  Examples::
+
+    %0    %NULL    %-1    %-EFAULT    %-EINVAL    %-ENOMEM
+
 ````literal````
   A literal block that should be handled as-is. The output will use a
   ``monospaced font``.

