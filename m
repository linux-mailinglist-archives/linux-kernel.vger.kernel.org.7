Return-Path: <linux-kernel+bounces-821992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92593B82CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266B53B3E28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FF23ABA9;
	Thu, 18 Sep 2025 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xnm2J5Ti"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745223E33D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167233; cv=none; b=d2DK0b3+X99mDQFeT3kvWnVGMjyT+Fz8bTATTSfhAcNmZren8vCisjNtOX1ZuwFRnsY5iPBCwiNA762MF3ae4qZBzQttPdrVZ9nFUcc9Iq7ftRjIEXv7dyz9jfhjnYKrm79D4v3RT0CeCF2f46qTB5BUcZ57IMR/pv+IPVB2vOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167233; c=relaxed/simple;
	bh=bexprKtSHWxh27J9H7zWNVAJbIOzt+ZuIFMFawL4GUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3xBPuGIxMNFVQbr9sl79gxq2YN6U0KwZilXto8wIY3or0vA1VChs891tcpRBXVOL+9bBHqq5ZPHE7G/jTCwKB+X3dMlFNssMwQID9/PKa4kS8+F2rjYE5vFfq+eHGyMCTgMsa65wYy4OTXI8jm1xD3ZCre8iMP3taJf1mJdkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xnm2J5Ti; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758167222; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N8Di7nDWsF0cDcwinPGup3Ryve0dphjG1epFEprr/8c=;
	b=xnm2J5Tid80CiZdAAPZ21p23Br7WwzInt6EwRW+V9V2krFFMtpbl5Pn9XFe+qD+MxqmmzacndLaGLu+8GuOAltgyCEpQaCOj9IyMkDU4S97B6Z0l6TcGOxiOFntcf65m7X5QhiIRzhItKKBS5iGiaDA0pjPJC+jJPMIISgdSIM4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoEQhD5_1758167219 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 11:47:00 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: david@redhat.com,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	hughd@google.com,
	willy@infradead.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] some cleanups for pageout()
Date: Thu, 18 Sep 2025 11:46:52 +0800
Message-ID: <cover.1758166683.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios in pageout(),
and only tmpfs/shmem folios and anonymous swapcache folios can be written
back, we can remove the redundant folio_test_private() related logic to
simplify the logic of pageout(), as tmpfs/shmem and swapcache folios do
not use the PG_private flag.

Changes from v1:
 - Re-write the commit message for patch 1 after discussing with Hugh. Thanks.
 - Add a warning to catch this unlikely case.
 - Add acked tags. Thanks.

Baolin Wang (2):
  mm: vmscan: remove folio_test_private() check in pageout()
  mm: vmscan: simplify the folio refcount check in pageout()

 mm/vmscan.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

-- 
2.43.7


