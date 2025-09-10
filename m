Return-Path: <linux-kernel+bounces-809609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AFB50FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5738175174
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0068930C616;
	Wed, 10 Sep 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n7HAcFFx"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417C30BF6C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490188; cv=none; b=mDwvS1IwGO4BzZCO4TXrRcgSRI+HDdYquatO9afJ1W8jqROUAeMUqacSLbLZHc9szadNGjB25i5i5rPzbESrVw47/ZyBezTuRIqWuWei+u5NBq5bxtSgNwpZCSbP2QbW4eDVYsvZMACQ3Va9Uu97k16YkbXZq47WBezsJnuI2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490188; c=relaxed/simple;
	bh=oayui912fSM31Qi5MBcJHwkmFtJhfSJH3nY7FFi9ihY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=RCHPeUjkeQ/UM+Nl+7+yLlGREmuCOdbb5ew2BIq3A5ZmsVv0qJRA/NQRIi9b++YvEnnfXks/m1Su76rjvAld1IVvnfPy2YCurHFzdt1Yd6SPYHlx8+HgvCxj9DJBQRVcCShf/0pTQuTknZMXvdRcgcgDdczYMYDCYkqlRU8CjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n7HAcFFx; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250910074259epoutp04d9a38a1524862c63454ead17d83e29e0~j3AGYENLK3187231872epoutp04G
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250910074259epoutp04d9a38a1524862c63454ead17d83e29e0~j3AGYENLK3187231872epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757490179;
	bh=GC0NR07IOOvyq/3vNAAR6GmLm+Wr/XaQ5qaYtCCnAQM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=n7HAcFFxEIbzK1okZYTvYqPAuJ0iN2wEzPG4J1u340vsTxPVmV0ocu7jMr+ZEXEuL
	 pBAXGnfWbq6EDpbVZgYYW6u14yFpmv+34MyU9TfvLKVmPtsEFoF3ToJz9WY8kCjXjX
	 tw0J/fQTum1Jy9H/L7NMgJqtanO7DCPwq75RFCcA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250910074258epcas2p15b2f8fe7aaa7ca6a6253067ac0c82a62~j3AF3afgJ1876218762epcas2p11;
	Wed, 10 Sep 2025 07:42:58 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cMCN20nTYz6B9mH; Wed, 10 Sep
	2025 07:42:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250910074257epcas2p2557473cfc52840b904ed22bdf1a3f27f~j3AFB07q80745007450epcas2p2L;
	Wed, 10 Sep 2025 07:42:57 +0000 (GMT)
Received: from KORCO190374.samsungds.net (unknown [12.36.160.50]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250910074257epsmtip1060546588af4be6a00dedf5c10ca2491~j3AE_n2vq3012630126epsmtip1B;
	Wed, 10 Sep 2025 07:42:57 +0000 (GMT)
From: Sehee Jeong <sehee1.jeong@samsung.com>
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	sehee1.jeong@samsung.com
Subject: [PATCH v2 0/1] timers/migration: add 'tmigr' kernel parameter to
 optionally disable timer migration
Date: Wed, 10 Sep 2025 16:42:50 +0900
Message-Id: <20250910074251.8148-1-sehee1.jeong@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250910074257epcas2p2557473cfc52840b904ed22bdf1a3f27f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250910074257epcas2p2557473cfc52840b904ed22bdf1a3f27f
References: <CGME20250910074257epcas2p2557473cfc52840b904ed22bdf1a3f27f@epcas2p2.samsung.com>

This patch introduces a kernel boot parameter to optionally disable the
timer migration.

On heterogeneous systems with big.LITTLE architectures, timer migration
may cause timers from little cores to run on big cores, or vice versa,
because core type differences are not considered in the current timer
migration logic.

In our heterogeneous system, we observed timers being migrated to big
CPU frequently, resulting in timer callbacks that could have run on
little CPUs being executed on the big CPU instead. This reduced big
CPU's idle residency and increased overall power consumption due to
higher power draw on the big CPU. Since timer_migration is a relatively
new feature, addressing the structural limitation was difficult.
Therefore, this patch adds a boot parameter to optionally disable timer
migration.

---
Changes in v2:
  - Added more description of potential issue in the commit message
  - Changed the boot parameter format to tmigr=[on|off]

Link: https://lore.kernel.org/r/20250807064849.3988-1-sehee1.jeong@samsung.com

Sehee Jeong (1):
  timers/migration: add 'tmigr' kernel parameter to optionally disable
    timer migration

 .../admin-guide/kernel-parameters.txt         |  4 ++++
 kernel/time/timer_migration.c                 | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.49.0


