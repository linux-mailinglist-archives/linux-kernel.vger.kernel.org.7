Return-Path: <linux-kernel+bounces-705691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA7AEAC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 03:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A14189F034
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 01:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C6145348;
	Fri, 27 Jun 2025 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZeNCeW35"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A210F1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750987295; cv=none; b=FckBbMsUS9Aui/x0nH7O3LjZv/4cGLXtlAqeqRO/vOE9gaP1b/OTcbSNnwFtQneqWwbRa//sRtm8UyYqFvujwoqEJjWOSCh24J+nWYsJfcxlgYB3MyqwyOZ9VGEfnPUbdBE+9qYYDTCPzpfLxVMPOYUFvROmcFZLSIFQN8wEEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750987295; c=relaxed/simple;
	bh=tRBEWWDSpswFz6OdbmJC8DxaO0ElnlwwezA1904IvzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sRhMZfGsM+8OWYgScvUfTBGOKNFTxiMAWc9hn4fumhV8d9LXLMd4LPHI3YqcSbvOX/7ZqWWdStYpqPRjCPVY190TkhFTmLdVEUd/rv1E4BJmyrg1HIqP4rF+yj87xf9CVy8aUlgfWVGp4ViOPjMynDfXfFv6R9fdZW9FpyWZiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZeNCeW35; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750987282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eFLrizrm7Gptxh7hNHxwVX2g3KSt3HdrF2K1MScmkcE=;
	b=ZeNCeW35ktdPs2AsRcHL7bb/1nLCBzBKOal5x9clTHY1FP6aqQw7XGZ/WRyZT7xIhlipJZ
	pFaETAlsiHgSdUw7+gAZT5i/QxoCvhFmAIn2+1VbD95NHdoAmkDqGNbL7ew4yZNlDnppac
	quqcxgd6ZZxInJiuhd7vANxC2RKYlG8=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/3] bcachefs: Removes NULL pointer checks for filemap_lock_folio() return values
Date: Fri, 27 Jun 2025 09:21:02 +0800
Message-Id: <20250627012104.222703-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

__filemap_get_folio the return value cannot be NULL, so unnecessary checks
are removed.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index dc5f713e209c..74841b1dc8ca 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -289,7 +289,7 @@ static int __bch2_truncate_folio(struct bch_inode_info *inode,
 	u64 end_pos;
 
 	folio = filemap_lock_folio(mapping, index);
-	if (IS_ERR_OR_NULL(folio)) {
+	if (IS_ERR(folio)) {
 		/*
 		 * XXX: we're doing two index lookups when we end up reading the
 		 * folio
-- 
2.34.1


