Return-Path: <linux-kernel+bounces-788881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAE4B38BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F340946309B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBB30DEDD;
	Wed, 27 Aug 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INiLio9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360A2F2913
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331545; cv=none; b=GNiTrGUNrTwQM7UQSI3kgtQXiYDvStjWFdH4rl89XJXGOrTYDmjIyJ9IHBj4Njo6gpk0ULmDBbFR3vW/x32blaQveiqlbeMWJEirehPBZhxKr1EW6x4FqgKFkDs4FqIl01s1AF/SnX/v/39GfEUKOGxz8HnXQIpUkuq/U6/yYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331545; c=relaxed/simple;
	bh=820xGs1O8S9T2vSvVTVEfothysBjQAsbUNdDwQu4QtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXHqpyCbMZJ1wR3LCk0bwnLDBdyo8bk/697oT/tTXBOlaXLDDnAe23sFrNVX1eXegSNm4O51V8vj5JsjJrfbU0KuxmpVuZcDWJNLqnXVVK2JOzTtQH39Ujf4Fr6ztLKF2IoSMpm1eBOvJxQX/HgDxqU8lvqfpmS6Iz35YfN7S9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INiLio9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA201C4CEEB;
	Wed, 27 Aug 2025 21:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756331544;
	bh=820xGs1O8S9T2vSvVTVEfothysBjQAsbUNdDwQu4QtY=;
	h=From:To:Cc:Subject:Date:From;
	b=INiLio9r+a1WpOG/Y0Swmwu0Qp5e9Iy5rMWkP8bt8z4pgLp91IKSOylv0p9ST9tns
	 mk8dRGMuyh7Yzq+A8yMS6IHzX3VRKVYmpTEv+xBtaXjx9FATSuBAh44wfiwlE8AjPt
	 +gIRLyfEo4tyYoixKv0M0YSr+k/mJQmcPhAKq1YFTy0rq7InHsBV73b1W0nUFPR1QM
	 Pu1Sq5Teb0XzwXD58N8UgRxDE2+vdCbvcekDS74lo3lpXb3ketetaJ4MWii7DaQO+f
	 zNhuNSoX1KIkbjNB2+TZeSdul3XWEsSW2UhzglGYhl7Vx5o41BM0nbX/lp2ZtCZHBm
	 y8b/HyycaiiTA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allocate HOT_DATA for IPU writes
Date: Wed, 27 Aug 2025 21:52:22 +0000
Message-ID: <20250827215222.1615844-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's split IPU writes in hot data area to improve the GC efficiency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e0f6589c6a1c..bb79dad55ac9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
-				f2fs_is_cow_file(inode))
+				f2fs_is_cow_file(inode) ||
+				is_inode_flag_set(inode, FI_NEED_IPU))
 			return CURSEG_HOT_DATA;
 		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
-- 
2.51.0.318.gd7df087d1a-goog


