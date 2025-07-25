Return-Path: <linux-kernel+bounces-745365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80731B118F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258CA7BAEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D568291C2F;
	Fri, 25 Jul 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ezjtHPgi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CDqNMw2w"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D47291C21
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427535; cv=none; b=GUw2KqMx9gt2KTlKbn5h0IizU9G5CChBNYooT+jSnqwwkdei0ifLTuY+l3F+N+CJtHqytJZNVSLochVmxp1F3Nvwo5CZKRFcxdsnqNYpTtXYe5Rx7vls6OB/llbTqu04cWV4QmnA/GozvjiJbZ3T4oz5Dzsbp8bKVaNAZN7Lg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427535; c=relaxed/simple;
	bh=E6q8rQh9eH4P6ICwDL3USE2DheciEGYNcJR7URqkC0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOHwltSTINHUjTyzxsHZdYLMBga5EqdWk9Af2J0/otK4dA8MZx/hrSBX8OpAFKE5z6tl4I8bbk/97fRED/WzEkJSuaZuxEGLAUM3vtPJdUeWhD5MJu+gSy8Xurfl6L2cbtF9eS1ZRlrxbrG4V1X4mq/GD95VqSu7XTYFBDdcaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ezjtHPgi; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CDqNMw2w reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753427534; x=1784963534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ot79FB6Rm05Ivf76UgZFDK3nri1VvL/P6ylysfzZ5W4=;
  b=ezjtHPgiDLeoRdrOEW20qL+O0mk/ZfnDBQQb7KnKKn9D7VULmwRI1/GC
   BPzfevUxWOHvq6XQLJGk3UiIcq0vAHXxHGOZPUqrkN8BJ4gbCKKC5lWHy
   JQidR9x2GQzz5CW1g87TguqPbZHVW/bJMNPOO/CdlNlauvE7k0XLTEwxr
   iTgOsQzdWA842hMllTrclloxRKL8F3JylSy1eBXxQJnahiACwYplDh9e1
   13N52xE3K7CSUu+mRb/cSUlydUIav4qyOkezkflToLg5M464P4pCSt72a
   +k7i/O2ad4t3kbmnyGvAWtgaNzFGuqNVjqrLGMGrb2FyGrLzavcduUjE+
   A==;
X-CSE-ConnectionGUID: UQgwQ7H2Q5OqZClASaX5fQ==
X-CSE-MsgGUID: PPfXhhUZQLSXodAMzkknMA==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45414809"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 09:12:10 +0200
X-CheckPoint: {68832E4A-15-9BFD12F6-F51D5FD4}
X-MAIL-CPID: B89379C4CC39DD7BE940DE706BEDB41B_3
X-Control-Analysis: str=0001.0A002107.68832E05.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A4091736D8;
	Fri, 25 Jul 2025 09:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753427526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot79FB6Rm05Ivf76UgZFDK3nri1VvL/P6ylysfzZ5W4=;
	b=CDqNMw2wSEOHuEBFOE/lt41HATMfB0u8IJVw5kJwXQGig4wLnRDKmsXIGCgrsBKsgNJPgw
	Av666r0Lz63sAtAwglhN1ZyghP57DRbbTG3ifpAERuZoCRfONkAIh/t5jNga37tdDtp2dH
	j8+XUHRxlyn0MZuPNaqK7dzWwUMEJKGQojBrlM9EXK41qnzHzSxrs5hZSVI/4rDwx75kCY
	hLH5IuvCW6pp6GLy7s+6Gbjg4HAQsa0RHNGg+ny89xR6V8O274EdfwlXSChK/aHgAbYQML
	4S7v4S9JbvcEx5EAWkgn7WI05MTXPQibg2wBBeaRn7xrhG5wyT/WZ9A/pgjgow==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] mfd: stmpe-i2c: Add missing MODULE_LICENSE
Date: Fri, 25 Jul 2025 09:11:50 +0200
Message-ID: <20250725071153.338912-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
References: <20250725071153.338912-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This driver is licensed GPL-2.0-only, so add the corresponding module flag.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mfd/stmpe-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 145836320c170..943fa363efc35 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -126,3 +126,4 @@ module_i2c_driver(stmpe_i2c_driver);
 
 MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
 MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


