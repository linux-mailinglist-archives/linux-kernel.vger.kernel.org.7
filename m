Return-Path: <linux-kernel+bounces-732743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673D3B06BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CFE1AA13DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA61A5B8C;
	Wed, 16 Jul 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bfQL6ZFT"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D618EAF9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632126; cv=none; b=q374vqyP/34GnP4zO114a8s5FQNFQTq2SlN3dcDHwBgK+yVqJVXV0/kRFbvZq+0zPTYOjgUCvVXfRQC40X56Ej1qYKTlAyIhLIOymTrLYCcDnPuYA5qlkshDoFj6X5+RGluWtMsMWi2zjsiB83BKNdIwp3DHq0noUZURKPmL5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632126; c=relaxed/simple;
	bh=CQEdVrv8vSfvNK/gFHNWNWjYiz84KmfXJqGXWRzIXdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WeudgRIjut3ZtMzzZsCWPMgNLb59gysJFk/aW3U58Armzo+KnecS9xcScqyM6SD5FUyxRheJ4pmwP9Etf7SVuiG3uAbYCFu5Bow8vLFNntZ2ZJEihbKbm7lZOR697c5QWnW9/sqwqJeBC+cK9Im8mxfNq6A1cJyu1Pt6nrM87Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bfQL6ZFT; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752632118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fzjdty8Fv4V6UOnqZa5n5eMB6fdI8v1AEOYwne7ZjRQ=;
	b=bfQL6ZFTn0oFtaHgyieSs26m8HigNK7lcPAXDCKfXn6vvqJ/2wNqVMg7tPlDLl2qh1XAii
	c966+A3N9N3hV59wvT9o4I94oHjvGN2R07Ajo4CQFqIeQdhhYepRJwxeWqxVfLyLPzi/Kr
	4KvYdFMt3bh7xDMCkXA6fnbV2f3FVtU=
From: Cixi Geng <cixi.geng@linux.dev>
To: linux-kernel@vger.kernel.org,
	orsonzhai@gmail.com,
	baolin.wang7@gmail.com,
	zhang.lyra@gmail.com
Subject: [PATCH] MAINTAINERS: add Cixi as reviewer for Spreadtrum platform
Date: Wed, 16 Jul 2025 10:14:48 +0800
Message-ID: <20250716021449.9797-1-cixi.geng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add myself as a reviewer and community liaison for the Spreadtrum
platform. I work at Unisoc (formerly Spreadtrum), and I will help
coordinate contributions, review patches, and ensure timely feedback
from the community side.

Signed-off-by: Cixi Geng <cixi.geng@linux.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..b24f4fa6432b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3281,6 +3281,7 @@ ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang7@gmail.com>
 R:	Chunyan Zhang <zhang.lyra@gmail.com>
+R:	Cixi Geng <cixi.geng@linux.dev>
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
 N:	sprd
-- 
2.43.0


