Return-Path: <linux-kernel+bounces-829387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE4B96F18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB0F2E2757
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2727A919;
	Tue, 23 Sep 2025 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J7swDqH6"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FF25EFBC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647332; cv=none; b=AdgYvGn861n+0jKZ/z+X3c+wLfPjUy6CUiraifg5EFObx/GjRv0dHz4R+tWN7TERGX/h1/yJV5PRYAsXhVp91wMwnBrVtUzrZPTjihSOs1+z9xCQM1I4IQL4XebrUsuvkf+2WDqLFjiklEH95sl4j3KPChTbIJCOdU46I8mXm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647332; c=relaxed/simple;
	bh=qHdjBPukcKBf/nO0/XHSuRFIz0++JyR1IknsglQF7Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xp8pmZGe9qecdRxP7nEPEaYTXWHtxAAojMRYGgiVp1EahVythBXt2jRfIC4kfNHVDdeI4j2eJp9+PVu21gbgqQxaICDEgo+lpJWnlzve5dknhK8B8mX0QgVZDCXEzIo2oNd7rLsLdMSmxhLMjqmH8jGiLa6S3tZ5kccUuMC9kDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J7swDqH6; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758647328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGuMY/GbD4gYyloiK9YujD+XEG3K0ofKYdm5wva+Ww0=;
	b=J7swDqH6sZYcIlCwdfCRvhLKwjvzkrZV52cbzbxEpzTjXnhc4ZiN19ThNOZgYlEExmi0xp
	U6pXnsTJ2UVbSTYbBr/62NowseAA0WjnDY8FEebcRq2Rzbew49gfvLJ5v5M35NwLi/jWkQ
	q8hocsNQuyzVYer7hc/9GAmGWVxM7Pg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha/boot: Add .gitignore ignoring vmlinux kernel image
Date: Tue, 23 Sep 2025 19:08:34 +0200
Message-ID: <20250923170837.1846683-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Building the kernel creates the untracked kernel image file 'vmlinux' in
'arch/alpha/boot/' - ignore it by adding a new local .gitignore file.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/boot/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/alpha/boot/.gitignore

diff --git a/arch/alpha/boot/.gitignore b/arch/alpha/boot/.gitignore
new file mode 100644
index 000000000000..4abc9c8ab7d3
--- /dev/null
+++ b/arch/alpha/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vmlinux
-- 
2.51.0


