Return-Path: <linux-kernel+bounces-754366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9CB19373
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7A664E01F6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB12877CB;
	Sun,  3 Aug 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JckCxyZz"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA545259C98
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754216786; cv=none; b=f40v3qe0I3E88fhEG2Z9Old/H09lglx0UGOjHIrW2lSasSwhO8mtAAlEFYBewtt8GGKQ+D4HjVSnVyvzedtd7bwvW0KfAQzfDS3FKoYKItu/bR/EQGL44YotcKcDgXi+5TpvAoQpjYclQryzzxtE99wuV+rnLQzqkLHUf4wy1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754216786; c=relaxed/simple;
	bh=C0e2BoY7+/aYpEOwzXOcMZha84ANRB15T15LoM2sjuQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhWVxuKCwn6n+I89FqrX6o4p6e7v77mnKBlGpGQEoylY7PMJncOF4Yo9vD42rORIe2iAoViLIWXDJSnfXQLG8/NwXljLOti/j0tPKoSwatfivw3/4dp4tZf55NY4vyVfz4CXlTYZEAKo0HUxpZYi9V0jS2KSNnLupxGNKPBlsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JckCxyZz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573A0ndh030720;
	Sun, 3 Aug 2025 03:25:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=t+mJhmkLZgpAPm6mQXB3Ry9
	+462vf9DYEtzPTIfXg6E=; b=JckCxyZzrvt2FHYbhVXbrNhi0IDQzlLkUPSAXfI
	M5zOh2Lri7p9QbVTON42zfV9on9VnlR7sNFHrFNaY1gyFBteFRl0/qiJ0v/+B92q
	sjh4HGQz6xIuIyqUewz8N3QGYD2Rw1SBcdcSZ7ldm/Mf7ye++PuhzCk4vzNFNwob
	rJYhi+GLRMKga+8HIMRxswZXCIYRH+VrO6t01IxWUBDoSkyYKn7H/1TyQIA1n9OR
	zaEXcatRZiNl0i0+rASnlL9I1lzHF1cVFy7qaV7bfezIqPF7xraoJEB0KiXaLcyZ
	UjRo1YoV7KISAwepjbuK/FHiUg0k1qJhG0s9oLx2WLqiZgQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 489g1qhhtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Aug 2025 03:25:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 3 Aug 2025 03:25:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 3 Aug 2025 03:25:54 -0700
Received: from c1illp-saixps-016.eng.marvell.com (c1illp-saixps-016.eng.marvell.com [10.205.40.247])
	by maili.marvell.com (Postfix) with ESMTP id B22BF3F70A5;
	Sun,  3 Aug 2025 03:25:50 -0700 (PDT)
From: <enachman@marvell.com>
To: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 0/1] irqchip/mvebu-gicp: clear pending irqs on init
Date: Sun, 3 Aug 2025 13:25:47 +0300
Message-ID: <20250803102548.669682-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA3MSBTYWx0ZWRfX7ouwtaYd5o4A vNSFKehRf0bbRqtFBksfitYvJ0OisWPXFGhIxVZDWEf5IKlEeg6HNCyQlmyNMvLJUr8eATZSGVY gIxqCBfT9s+egbbf26Fz2Mct+JlIOLej3hKPlIbZdZvLtk/z4nSA1X9Y/H5PLWzZbJmU3ibuuPC
 rPNCaD6L7MwPLsNPeE8qWqyEkM+mR3BHYVok7oLJMSjA5jPyEDWnd1Hu7PTu3qkXM1ct9jqrj+4 RyV30Q/0YGjgtX8/gWr8ttmnJBAwyGJFwbLDUV2Ql5+2bMWYYPl30wD5TLjXQ3H1MHi+PDU0dKy qUBcWligVLkJpJDVoWYNweovewho8QqJatL+7MeYPS1kQHre+ecRXeQR3oV8NcO/PY0OBkzIcqK
 GV32kG9sNAyC4N5smnEPn/eMo32qeeLWFdnU34TYEl5CtGlCe+s/793Hhv81SGraBGUX4vFv
X-Authority-Analysis: v=2.4 cv=PYD/hjhd c=1 sm=1 tr=0 ts=688f3931 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=BM-YHa9G8tpcXFNCLwIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 6tZKmBBJQzgZskEVZlZQXfkh-Hg27CDJ
X-Proofpoint-ORIG-GUID: 6tZKmBBJQzgZskEVZlZQXfkh-Hg27CDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01

From: Elad Nachman <enachman@marvell.com>

When a kexec'ed kernel boots up, there might be stale unhandled interrupts
pending in the interrupt controller. These are delivered as spurious
interrupts once the boot CPU enables interrupts.
Clear all pending interrupts when the driver is initialized to prevent
these spurious interrupts from locking the CPU in an endless loop.

v2:
  1) rewrap commit message

  2) don't keep remap, unmap register space after clearing pending irqs

  3) fix code styling

Elad Nachman (1):
  irqchip/mvebu-gicp: clear pending irqs on init

 drivers/irqchip/irq-mvebu-gicp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1


