Return-Path: <linux-kernel+bounces-758749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4AB1D370
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF72D1736D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD123BD13;
	Thu,  7 Aug 2025 07:36:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393023AE93;
	Thu,  7 Aug 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552166; cv=none; b=ks/yfT5NDLHBklB8NnrJmSO+5P/TQSM0YNED2cqCR9+X7VwEJxp50GM2rapiEtvq2r9xy0n/gkOGITc+IuOihJdp0upOh6h/6z9xo5msFaQUtGnOcnUM2I3h0DYRG3HuwTFZP9OI9aO6/6UMTePK81I4GdNCOUM8YlMYGx8fB9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552166; c=relaxed/simple;
	bh=PG8Yk4HyrfQwkWkqUTAXxSJJeGZUQPTyxugjKqBtjRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCQmy+67nQuQ+gjADXl9CeNjK6ToYqvg+dMCHksSYem7K+rXWXx21vVrKgOAe5FnMFgHNiKFw7Qn2TA1AwFhC7jVASy01WZz6cWQ4g5MSqB1Z8t5nI1VKgUJD6fl1GYT4g5CHLhah/COGurb3rNLujy1esqTdXeaWTwWSs2rYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A854C4CEEB;
	Thu,  7 Aug 2025 07:36:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Documentation/printf: Use literal fwnode_handle
Date: Thu,  7 Aug 2025 09:36:01 +0200
Message-ID: <07262c55e82fc4a3e3dbe7c45713b14955271e7f.1754552156.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When looking for fwnode_handle in the printk format documentation, it is
only found in the Chinese translation:

    $ git grep fwnode_handle -- Documentation/*printk-formats.rst
    Documentation/translations/zh_CN/core-api/printk-formats.rst:用于打印fwnode_handles的消息。默认情况下是打印完整的节点名称，包括路径。

This happens because the original documentation talks about "fwnode
handles", without mentioning the actual type name.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/core-api/printk-formats.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 4b7f3646ec6ce028..7f2f11b482865175 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -521,7 +521,7 @@ Fwnode handles
 
 	%pfw[fP]
 
-For printing information on fwnode handles. The default is to print the full
+For printing information on an fwnode_handle. The default is to print the full
 node name, including the path. The modifiers are functionally equivalent to
 %pOF above.
 
-- 
2.43.0


