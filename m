Return-Path: <linux-kernel+bounces-749799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA49DB15304
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A5518C1C78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537E24A04D;
	Tue, 29 Jul 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="B9T+vGO5"
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB529A9F3;
	Tue, 29 Jul 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814466; cv=none; b=P1IPfpPApP1WBN4Od4HdNveIgSl/7hxDgl7W5Gamf58vNmLLJ+AdZVget1SBT5zSIJOyh9vbz3JW0NT3njX64HzcYtIxPBBC2dOSK45ZF9PK877VC7OyuLwPglDgqHj2y36CR28vA+x6Cm+OYZMl33QjhQpojdBWoYb7CJ6E0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814466; c=relaxed/simple;
	bh=v7jqCoK+432+2HYiTXE9nmk/Z2eKIkT7tmMINDJU8K0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AwTIafdvmZAJ+ETXPL1bSmZ34uFsnYuCe3+WrJzG766+uUdgZl0Wy3UBmzbYO6q5UFvNjLZ6Ydx3lL01zTrSv7re4yDtPLZqEGoM13O37EONfSxqbHUPF2mR3S9kSFLV/nCBfzTGzQsR6K6Yq0CWlqCIwiwQ52gAd7JDnjQHMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=B9T+vGO5; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1753814453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bo5RjkK3DnJcqfX6QmozjXaZJJYQK/f8A/lrB6M5jQk=;
	b=B9T+vGO50sim+KPIe3/8KolyM17zVFgHIr032ix5PfgxyZp9rQUZlnWRcWaotPzxZHwvG8
	pQd+fj6HuOnNvqMDwm+MTQnT6S2SZZbZt/pdKGuDwrrEYd+T5DbQ7VCwcGlVavGXLajNpt
	2U7SJ/YTQYUjyIy3Ewb+Zp1lAe/GZ3qzx9tuiUjssg+1wy3IJ44ZyWw9m22LdiTn/4ihh8
	YG9VFoZgxkD8snr+uvATBiEWFFftRkK35fn+IWLYFV06HtBxk9VvC3KU7+ArsAQy/YSLhH
	/XPvXBL6rQnbDuIXgxJulB7mGOL9bJAWWjoBML9bVsksXOa8QAwluUWwtgKAaw==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id 673ec5a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Jul 2025 20:40:53 +0200 (CEST)
From: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@smrk.net>
Date: Tue, 29 Jul 2025 20:40:36 +0200
Subject: [PATCH v2] docs: admin-guide: update to current minimum pipe size
 default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250729-pipedoc-v2-1-18b8e735a9c6@smrk.net>
X-B4-Tracking: v=1; b=H4sIAKMViWgC/2XMQQ7CIBCF4as0sxZDR7HYlfcwXRCY2okRCDRE0
 3B3sVuX/8vLt0GmxJRh7DZIVDhz8C3w0IFdjH+QYNcaUKKSA2oROZILVpA7Dfpq7RmdhfaOiWZ
 +79J9ar1wXkP67HDpf+u/UXrRC3SGpEajLrO65Vd6Hj2tMNVav09jwwOdAAAA
X-Change-ID: 20250728-pipedoc-ed3789cc42dc
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@smrk.net>
X-Mailer: b4 0.14.2

The pipe size limit used when the fs.pipe-user-pages-soft sysctl value
is reached was increased from one to two pages in commit 46c4c9d1beb7;
update the documentation to match the new reality.

Fixes: 46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages")
Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
The relevant man page was updated in
7543e84442d7 ("pipe.7: Document change to default pipe size when soft limit is exceeded")
https://lore.kernel.org/linux-man/20240829204448.2027276-2-kstewart@efficios.com/
---
Changes in v2:
- Better commit message (addressing Jonathan's feedback)
- Link to v1: https://lore.kernel.org/r/20250728-pipedoc-v1-1-2dae082a56f5@smrk.net
---
 Documentation/admin-guide/sysctl/fs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 6c54718c9d04ba0e690d064bc50f97ef883234fa..9b7f65c3efd8020d62df5b00388c48f2435da3e3 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -164,8 +164,8 @@ pipe-user-pages-soft
 --------------------
 
 Maximum total number of pages a non-privileged user may allocate for pipes
-before the pipe size gets limited to a single page. Once this limit is reached,
-new pipes will be limited to a single page in size for this user in order to
+before the pipe size gets limited to two pages. Once this limit is reached,
+new pipes will be limited to two pages in size for this user in order to
 limit total memory usage, and trying to increase them using ``fcntl()`` will be
 denied until usage goes below the limit again. The default value allows to
 allocate up to 1024 pipes at their default size. When set to 0, no limit is

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250728-pipedoc-ed3789cc42dc


