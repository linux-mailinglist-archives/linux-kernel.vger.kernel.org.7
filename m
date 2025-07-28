Return-Path: <linux-kernel+bounces-748508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC43B14210
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1723BA2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442E274670;
	Mon, 28 Jul 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b="Rfd3+xPc"
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E64A11;
	Mon, 28 Jul 2025 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.76.87.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753727866; cv=none; b=XYUPmflfgv0t07lUmw0q1YEmPTHVYbywm8mDG5o8P7GsPvFH5srGI+t5XRvFN+OsBiQJWCTT8U7jkja1bzqwEl/1/UbZpmtqAiEm0YZ5Wh5FaC0pHfPAulAMLq2s9tDhckn8Dv61pkzI80RtTU/6fLNbkLR+GPTFkYu23PkiOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753727866; c=relaxed/simple;
	bh=P5DDh7c6UJ4D4+NjwCwZk2I6DNLm/C2wn8jkMDxS96M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=inK/FuYw7wIIMifqFPmSRVTKSSxCnlrEwkuiE8sifsjoQEvfkPv54Xl1kg9ixl9JzRAjG0K0xEnBuSU3hIK8+y2OIwelM9xwz+s+7c+pFmYiShuiCGU6WhiMW2MsyV/1xdJVs8iEs0OeYsUDJbMCCFbJ6Aquml6CUF6rb5uQC/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net; spf=pass smtp.mailfrom=smrk.net; dkim=pass (2048-bit key) header.d=smrk.net header.i=@smrk.net header.b=Rfd3+xPc; arc=none smtp.client-ip=45.76.87.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smrk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smrk.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
	t=1753727460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/P+lLMMRUQ1gMBLqbN9Ho2BJrRqcrV6Qq51DcGJe+Jo=;
	b=Rfd3+xPc3vnT7KINOIVel9EhP+F+aQs+/mqNWhlTCtEPSRyIDU9jJh7nIMX8JsqVIBYfOX
	MseULV9M2khcRmZtFSPiHmi+u+aAQHnH4coWGmJ6WEN9ySciScwvn35D056Ro0IGbmTkj5
	bCPpr32S2DC4nEZRg6kK8UMRnTtKouT/OM9jp+KkieM0kUhvcCehl5Z5cpN1GHCpsKPA/4
	zfEpvp86KSe8eHwnSp8zTn8v+Z2amhmUFJjY6gDMWPJi0raOHu+36z07y3rRBiG1wTw5eT
	P6GougDX80beTWlaiPeZuN0YLBXaaNOKQcSzxmW2y1sk2NTt5fYceFL9gJyGKw==
Received: from localhost (<unknown> [192.168.5.2])
	by smrk (OpenSMTPD) with ESMTPSA id a0d628f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Jul 2025 20:30:59 +0200 (CEST)
From: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@smrk.net>
Date: Mon, 28 Jul 2025 20:30:33 +0200
Subject: [PATCH] docs: admin-guide: update to current minimum pipe size
 default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250728-pipedoc-v1-1-2dae082a56f5@smrk.net>
X-B4-Tracking: v=1; b=H4sIAMjBh2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3YLMgtSU/GTd1BRjcwvL5GQTo5RkJaDqgqLUtMwKsEnRsbW1AEx
 KxyxZAAAA
X-Change-ID: 20250728-pipedoc-ed3789cc42dc
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@smrk.net>
X-Mailer: b4 0.14.2

Fixes: 46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages")
Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
The relevant man page was updated in
7543e84442d7 ("pipe.7: Document change to default pipe size when soft limit is exceeded")
https://lore.kernel.org/linux-man/20240829204448.2027276-2-kstewart@efficios.com/
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


