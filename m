Return-Path: <linux-kernel+bounces-630894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468DAA80DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FC7AE5BA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960C279793;
	Sat,  3 May 2025 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q3RMNEZj"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD962690CC
	for <linux-kernel@vger.kernel.org>; Sat,  3 May 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746278797; cv=none; b=IcXd1kYnS5XIiu/7aC1HgHne0wllkLwjMNp4rBPStT3IojE8/LqbiLKdsagNGaERzHBDx5O1InYS5XkdL3VPC+TsDmcL2bshwSLV26wA7XYLS7dCgYq4Kxv8/eZk4gznn/vzR+DxeZSgaI7E1GlXCq1IUWSG26Zjt6MexftbY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746278797; c=relaxed/simple;
	bh=zFz7W87tRbM4TJFTmR0zPkVWfwg7WoDQnmpho5Kw6a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dUpRru8bjpPjIq7nTpneb0M8vAZ3ksCC4zloKxK2PMJHAGwGC9DtKG5v9V3g2Q3z8YfTvIspLvDPSxBA1GNqaZs2NncPqXsXI4BaPO6xDKkDSvuvLUM6nM+4Yzft/majafbtE5aibntf+apmud9hkfrOXHOWZlez6nF8IWAJRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3RMNEZj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746278783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MpqJ2xhiGc3MNQIlCoyC543UAV+C7aQQFpSzMtqzOHM=;
	b=q3RMNEZjE/g+HJjD1MiV97P9MqziDWA9xA0U9NNA0yMM9hlgmf9n7SVg6LvP4FbwfwNuZq
	tDh+BdxWE5a4k255MOJ02UB7kb3rqEP3ORSPRosCV/Ur4VrIgWfQQ4KTP0Ikiofs+0nRoi
	aT2UGHa4g3Fsmi0EnzSa01NcM4oKbNQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ovl: Annotate struct ovl_entry with __counted_by()
Date: Sat,  3 May 2025 15:25:36 +0200
Message-ID: <20250503132537.343082-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'__lowerstack' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS
and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/overlayfs/ovl_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index cb449ab310a7..afb7762f873f 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -51,7 +51,7 @@ struct ovl_path {
 
 struct ovl_entry {
 	unsigned int __numlower;
-	struct ovl_path __lowerstack[];
+	struct ovl_path __lowerstack[] __counted_by(__numlower);
 };
 
 /* private information held for overlayfs's superblock */
-- 
2.49.0


