Return-Path: <linux-kernel+bounces-810158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80D5B516B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850DA1C832B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B033164B3;
	Wed, 10 Sep 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9f8V2Gn"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905E314B91
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506855; cv=none; b=uRrmV4wACQXl7jpkjoiKWIh+gtLOd6Atm+roXU/pmlb7vaWxQnShNFFjSumhRRKtl2iHz3Np42FMjmpkEa9H7aPstPH48gIoIzAWzOfy6mltRjLnolvJIq/SBVqebTw41IWbAev0gF0ygBUyfZ/AnhPECdX/WLXQi/JptCl24xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506855; c=relaxed/simple;
	bh=qHdjBPukcKBf/nO0/XHSuRFIz0++JyR1IknsglQF7Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSBmn/lVdmR2jeTOrBy/cMfKwVsL6fqECjBN+XVhbnBQ7Nn0+t4V5Vb3QgCdzwWdYzRHy6E1v1ymXhUvUmXebI0N1DBwu0jevY3ckdZz8cYjkpsHgxvmL0b9MuOkhnCa1Q/bq4b5AOGui+pdoWLIFAIrdcKwLjUCcJQm3KEj0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9f8V2Gn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757506841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGuMY/GbD4gYyloiK9YujD+XEG3K0ofKYdm5wva+Ww0=;
	b=l9f8V2GntwGZaLXUOJG+i0YILxreQ9cDHpP/V2kOnxJCR++4pr53ZLeWy+frOcDfQouqGo
	8dYfFtADjYd070u07S8EEXBjALAo9Ya1U0FOUDQpso/Omg2ebXJiRX4MF67Ohpb7sDvQLa
	gkt7BI1keci1ijiClJ1w8/qNkn6WR9I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha/boot: Add .gitignore ignoring vmlinux kernel image
Date: Wed, 10 Sep 2025 14:20:02 +0200
Message-ID: <20250910122005.912613-2-thorsten.blum@linux.dev>
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


