Return-Path: <linux-kernel+bounces-815172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB392B56096
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9441B2364A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A526FA54;
	Sat, 13 Sep 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CvVrJbso"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28E1E4AB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757765731; cv=none; b=jt1FfKTZykciC/4GZb+tiPdMYA16/su8PTPpwIJTCrO2MKKxhpSbQjRpCRfwfQFljVSyVhSrkgl10JaueLAa2Prbg+DaFSNkfzRRE5s2jAf5t1kXcDJ7o18kJ0lEL0mBGrO4XTNX2bv1F679nqlr4ZPNZxmJ0W72Qd2wQyE03Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757765731; c=relaxed/simple;
	bh=PfZXNJG/xSPRuRYlfKl/8Y13YarP7AvpsGLxf9wgfjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqKXDmPx6RQg5jwpfWQYIvtRLKREBxY6KJf4T+T7mjPJpvDk7eMgcEB5hITFn+Ewyj76GFsSOWLNeGOg/16iBRkP0nd6qjNtbavHiuYBcPRTdZjcvi3ya8VVUP9/+/Sq+Q+cEaPAokUovzlZMTI8i3vLV71xiKuhS0XzkpYDW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CvVrJbso; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757765727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8uIVmqLTNP2ho9cEgGDB2Pyg3082OKfjVPPx4gDblF8=;
	b=CvVrJbsoLjVNKWOnb7kb8rto5nY6ORGzgjSC0eDTySHLYRssVLVvBWCAU1VZBsHBd9jMkO
	JpmP+m7P01SuWLwQsnYOOrtQZTb7qQ/WNoLpqf90oL6k9XkYSEV2HBGf1cQMFp6WqRU7dd
	muBshufmz+9OQfacgpRIkzBLRA6J7kA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initrd: Remove unnecessary goto label 'successful_load'
Date: Sat, 13 Sep 2025 14:15:14 +0200
Message-ID: <20250913121514.1789204-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The goto label 'successful_load' isn't really necessary. Set 'res = 1'
immediately and let 'goto done' handle the rest.

No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/do_mounts_rd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..97ddcdaba893 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -210,7 +210,7 @@ int __init rd_load_image(char *from)
 
 	if (nblocks == 0) {
 		if (crd_load(decompressor) == 0)
-			goto successful_load;
+			res = 1; /* load successful */
 		goto done;
 	}
 
@@ -264,8 +264,6 @@ int __init rd_load_image(char *from)
 	}
 	pr_cont("done.\n");
 
-successful_load:
-	res = 1;
 done:
 	fput(in_file);
 noclose_input:
-- 
2.51.0


