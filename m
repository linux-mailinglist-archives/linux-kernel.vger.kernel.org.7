Return-Path: <linux-kernel+bounces-743733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE126B1029B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0384D5A01AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7822153F1;
	Thu, 24 Jul 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz8KnVFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DF21D5BC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344115; cv=none; b=uKLBmNR5QXO1Q5SFNOVXqLZSOxEVjBjYqKD3ILK3SVhGt0gD7DpjqhUmA95pwEQ6DssdTTRgT9ATWHIXHIAL8FDpOVZ8R8BheU5HQoWXh2vfp0mDUwCiortBaTND8UzqpsfpHblhPEtZegwKfZC+AB804lSymUE/E2gRAjRu0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344115; c=relaxed/simple;
	bh=duxK4sSteoH+27SnghsS+Y78BsSKvV3qvjRvfw2ymeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWNHxd8f1nLQtsictvOGqHzZlzBFRN72VBpHLShs7OyfE5OCuPKadyGJCwfeUP9QtFUDJgqJ3BTvKpmg2p2it0UdweT6eFQW8KJcfWbTUs1eXuc0GCpbXM5EgOajShinA+GwIJo5zdn1CG1upt9uC+Jv8ayEh7hDijND/U+mBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz8KnVFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B4C4CEED;
	Thu, 24 Jul 2025 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344115;
	bh=duxK4sSteoH+27SnghsS+Y78BsSKvV3qvjRvfw2ymeI=;
	h=From:To:Cc:Subject:Date:From;
	b=Mz8KnVFgiX1z/ywV/YlLjavASRHQitNmwRFub0rw+esDivit0+UnBhtbzTFkRcj2f
	 70Uq7Dg8wS9W8cfcjdeu58CU4wQIQjYDO7HPtw69e4Mij9dVJetueEP1CMQWcVDffh
	 cvy4oh9Kb8b1cdZuotCnoQ/kO4lFEr8mKW+M62EBpFoiKXDjHtklUz/mUzuLYZFjNv
	 1Smc5AKBDlwsR525Hr7Mp55dLUfWyVS2xgriSyTvwVj1iu+O2nrUeo1i/Vv+Bbub60
	 7SicCnYNWtssr8X/mmjRjhDB/iO8F4T2kIrxGd4/0fv7/pQj5tHbawfFkH3KIj6QNY
	 YHUF0iv7SyLBw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/3] f2fs: fix to update upper_p in __get_secs_required() correctly
Date: Thu, 24 Jul 2025 16:01:42 +0800
Message-ID: <20250724080144.3689181-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
missed to calculate upper_p w/ data_secs, fix it.

Fixes: 1acd73edbbfe ("f2fs: fix to account dirty data in __get_secs_required()")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d2c73f641134..2123645cf175 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -678,7 +678,7 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 	if (lower_p)
 		*lower_p = node_secs + dent_secs + data_secs;
 	if (upper_p)
-		*upper_p = node_secs + dent_secs +
+		*upper_p = node_secs + dent_secs + data_secs +
 			(node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0) +
 			(data_blocks ? 1 : 0);
 	if (curseg_p)
-- 
2.49.0


