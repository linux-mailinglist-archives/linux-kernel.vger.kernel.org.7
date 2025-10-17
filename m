Return-Path: <linux-kernel+bounces-857522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CBABE7034
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1210F5E77F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CA25CC74;
	Fri, 17 Oct 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hg+PuDHp"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B81DC9B1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687627; cv=none; b=l4t0An5iX4S3RKxqMOr9v83deQpMOeQJfXQBArqj3U/U5f9iPdFhPsZ96U5hkrlgxfHL6Dsx+a2oMYdLkhr4WkAzy7f+uOLy3t0VyTaqJuP6hzfFL8u34Acef4X8L6omvj3zGU58mUPBg+0CZ2Y30jtrf7fiwiq9Z3CufwQwuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687627; c=relaxed/simple;
	bh=4ahqgDxIys8XLQOy98EriuenP4pI6rogZedFloREwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2Trwwy0SHM3uUxCTXhn8XMtg7Q+VENIYACOBEoUg9GhFyVEmD1B6iM2S1iK1UuLpuwvH5kW3EXK9NsqmrZ+vY1kmWqCXM5cycwMQxf6Y/Axo1BmweR/1E64YvmnKPlDU3Rj++iPIDxpsnqgAq8y/3FrSqT7XPABPiblgP6gQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hg+PuDHp; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760687622; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CcbInidATEQDx0TmsZjwQ7ET4Bs8aihoSMbGsPd8THA=;
	b=hg+PuDHpTiHlri80s3xUGDC843CjMOgI/WwcWHtlcAdkiuYXMphhLPQrCXCO6/FQeeQwC3g33kBGWFPYIa6j+tdTCIymh/EQVZj6m/5i8wGhslqyjPIlb7QHpPwCvyNfe/TC9v/8lIPd/hpgjYbAuuTroPhNZM5ITNIYKPB83ZQ=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqP7nGd_1760687620 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 15:53:40 +0800
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
Subject: [PATCH v2 0/2] optimize the logic for handling dirty file folios during reclaim
Date: Fri, 17 Oct 2025 15:53:05 +0800
Message-ID: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we no longer attempt to write back filesystem folios during reclaim,
some logic for handling dirty file folios in the reclaim process also needs
to be updated. Please check the details in each patch.

Changes from v1:
- Fix the folio_test_reclaim() check.
- Rebase on the mm-new branch.

Baolin Wang (2):
  mm: vmscan: filter out the dirty file folios for node_reclaim()
  mm: vmscan: simplify the logic for activating dirty file folios

 include/linux/mmzone.h |  4 ----
 mm/vmscan.c            | 33 ++++++++-------------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

-- 
2.43.7


