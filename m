Return-Path: <linux-kernel+bounces-885991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F6C3475A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2029718C29B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBB292B4B;
	Wed,  5 Nov 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kIxIn2aU"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C01286891
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331263; cv=none; b=HUkf9KGBqfrl2q3hgf/IhDiBSWhLHjicmPsZbuGMWieMnEcHKgljFAHEvDK3zuZ67jb8rbPwqsTGZKK4KpOSwuzyk6cUMgRLV7ZdGAMb5h0CyClfDZKHLMtiTrmGcYC1tYZhk4Iwu/brW8SAmaydRTC9DvBM3JjuNftny8QD9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331263; c=relaxed/simple;
	bh=kd3xUHdiZTLAW3NlNPjb6jb7x4aku8fLGdr7YugF/do=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EPGPDQ/YLlioUBv1ur7Nug5A7P62USUBNq7M1WLPSwd565jKd46Ue//uTXzAHDaf64K+rp+aNzOoZ47+rbXBWqa0E7iHIPcOZ+D4/JjMX8+iSk54sDV8Q5peoT8b77AXBbCDKc1MG5JBIokmGEAe6q++fUw+uoClvfoaBtyKLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kIxIn2aU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762331248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l9OhClLyIu69mGvqa9TXOcbkEsI3fYQr12r8sRD6vLA=;
	b=kIxIn2aUjsBuq/IWkZEGEsHgyh4wBSn+LAcvvGP9x384Z/ElNN+wPay2ntuDuJMWmpjU0n
	x8ITR8LJAoLU2er6XBU7ttZHtUXb6Ea+DJ11Xzz4wOhx0tk8Y3Yp+Ot1JFisYs2Yx7CCmH
	D+gqeKarFG6ADctZHE5Ao/JsWQsoAZU=
From: Enlin Mu <enlin.mu@linux.dev>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	enlin.mu@unisoc.com,
	enlin.mu@linux.dev
Subject: [PATCH] of: print warning when cmdline overflows from bootargs
Date: Wed,  5 Nov 2025 16:27:17 +0800
Message-Id: <20251105082717.4040-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Enlin Mu <enlin.mu@uisoc.com>

add debug info. sometimes cmdline in dts is too long,
developers are not aware of the length limit of the
cmdline, resulting in some misjudgments.

Signed-off-by: Enlin Mu <enlin.mu@uisoc.com>
---
 drivers/of/fdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0edd639898a6..077799b2f565 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1085,6 +1085,8 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
 	if (p != NULL && l > 0)
 		strscpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
+	if (l > COMMAND_LINE_SIZE)
+		pr_warn("cmdline overflows from bootargs\n");
 
 handle_cmdline:
 	/*
-- 
2.39.5


