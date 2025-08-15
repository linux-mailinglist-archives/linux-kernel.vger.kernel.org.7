Return-Path: <linux-kernel+bounces-771024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E2B281D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933821CC77ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC7242D9D;
	Fri, 15 Aug 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jwkHJvVZ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F2238C33;
	Fri, 15 Aug 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268220; cv=none; b=c4Dl8UkjzRdfOvO5OkGh4ro6KiDw779w44L8kg1/si45TPh4YZ3fOa+LlQ2UA+hZlL6xph9ByrfHYrQjYuM/MyUbZJBlh8ESwjYzqToxhn6lUZKw9x7U9+vD1NICoTbI5ZBK8nHyDYQoYmh2Fi/sAW6e1EJlO9o3+X+21jFkRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268220; c=relaxed/simple;
	bh=A4YoorR9gNLOM84qZZhNM54EKs1QY2Qg1zbHz4xlTQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPZDMfrMEHmJ9zs7PtEX9xFIpzAbpRNDIR49ifqIoNOyWDTZA2pWpbM+HB7ZSfJI16VwdTvQ9/EXS5Zo35vPRHuZXSnyoBzovO4vW03O6ZaPOiYiZrZdLbow5dUd0DDx6nGrjpPFc3UcjHbSEkDWUEsHgac7f+vEh5zJzhBrlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jwkHJvVZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57FEUEYU2117553;
	Fri, 15 Aug 2025 09:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755268214;
	bh=5FQazpu8UtzG5DyCGxOc96Id5YT6LEKovSAlId61R8E=;
	h=From:To:CC:Subject:Date;
	b=jwkHJvVZB1LVihax83tpmzqDiv3pT5Dmkf9a8v7Eu5DACUjlaZZqyCe3+65z6qGqW
	 x4rOYJ0xcQtpM3LbgzsZdtqh8UVU6P2/9/Ccn43eMU81UK9vVhsD7ETUZ/KL437Gei
	 1BUt6UndPblHqTtXF8h1JrI2EqLjDnYHViGkzWP8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57FEUEON2650504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 15 Aug 2025 09:30:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 15
 Aug 2025 09:30:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 15 Aug 2025 09:30:14 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57FEUDs01416333;
	Fri, 15 Aug 2025 09:30:13 -0500
From: Andrew Davis <afd@ti.com>
To: Jonathan Corbet <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH] docs: driver-api: device-io: Split out relaxed access mention
Date: Fri, 15 Aug 2025 09:30:12 -0500
Message-ID: <20250815143012.788929-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

We list all the normal non-relaxed device io functions first, but also
list just the "read" versions of the relaxed device io functions.
Instead of adding the "write" versions to that list, fix a statement
below which should describe the relaxed versions so it is understood
that both read and write have relaxed versions.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Documentation/driver-api/device-io.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 5c7e8194bef92..09e02dc803024 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -56,7 +56,6 @@ Both read and write accesses are supported; there is no prefetch support
 at this time.
 
 The functions are named readb(), readw(), readl(), readq(),
-readb_relaxed(), readw_relaxed(), readl_relaxed(), readq_relaxed(),
 writeb(), writew(), writel() and writeq().
 
 Some devices (such as framebuffers) would like to use larger transfers than
@@ -67,7 +66,7 @@ guaranteed to copy data in order.
 
 The read and write functions are defined to be ordered. That is the
 compiler is not permitted to reorder the I/O sequence. When the ordering
-can be compiler optimised, you can use __readb() and friends to
+can be compiler optimised, you can use readb_relaxed() and friends to
 indicate the relaxed ordering. Use this with care.
 
 While the basic functions are defined to be synchronous with respect to
-- 
2.39.2


