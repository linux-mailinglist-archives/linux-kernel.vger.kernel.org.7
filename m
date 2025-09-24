Return-Path: <linux-kernel+bounces-830253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA437B99347
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB62E19C6801
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C042D8DD6;
	Wed, 24 Sep 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XbDm9YBW"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091132C235F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706995; cv=none; b=onTJmuyH8P1HxLq6SIUFFOltqJ49CkmLlI1B3u//q2Ea3NC1tqbILhxv3r14EOD42oi6Z13ktxHOIL1DuzjvqzwAYrJD5s2R6fZNnwiLbqVP7BWSDzu7oMELTztxM0Xj66XQXOpYPVjFA2l4HQ94j/TbKmc+7o7Cyg8hnd41fhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706995; c=relaxed/simple;
	bh=TUgLiGxDhUBNujXAz4/8i71qkrAVk31eyCx0NzQUnhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjltnTXmife0Qc5zvPLtFhUpyPhkslzOXnD1L6s78nNRErnn5maQktupARYgdemgumAYoUARbJ0Ry9jRFYSiAbypdUMRtdi5GYNUqVQV+5VW9AWqeVcuyySWS0jD4X4/PB05a1/fV7I70jyJC8VNJIsTkl2Sxxkl7dTLitWK374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XbDm9YBW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FrZhqw2qKNsHXM7f6+h49Tbw3S+CFwKNA3MhdCroe7c=; t=1758706990; x=1759916590; 
	b=XbDm9YBWLpMP9wXlPlTl16QTCykrLILyqCnIdkhnm812CvJuswWL/fJi4+SpBiwQydnnwxKUxVl
	wW8xHRouz2bI9tqUf0RlWn9XJKxC9UqO66f+THat4StKk6f0l18vA1mNs1M9D3Twjd0SIH0hHVUt8
	ilMPJLcZf/OweucRidiMKQC3UMRmJk/Ck48WtQGttT2l41JOvJQHEp/6qSYGyQq7j8DFSu+RfF6XG
	w798i5EtHMhlrorLsU39D1bAUy4bovMwdB0/Cev7wwrmJ2qlXQ911tjg7RzbizndfU+l2AMvO/q0W
	Oa1R0XlOMw+FfPNk+AG4+9zL9J8Xrxo+LLuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v1M1j-00000008YSI-0gVh;
	Wed, 24 Sep 2025 11:43:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] panic: remove CONFIG_PANIC_ON_OOPS_VALUE
Date: Wed, 24 Sep 2025 11:43:04 +0200
Message-ID: <20250924094303.18521-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's really no need for this since it's 0 or 1 when
CONFIG_PANIC_ON_OOPS is disabled/enabled, so just use
IS_ENABLED() instead. The extra symbol goes back to the
original code adding it in commit 2a01bb3885c9 ("panic:
Make panic_on_oops configurable").

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Just caught my eye. No idea who should merge it or if
anyone cares.
---
 kernel/panic.c    | 2 +-
 lib/Kconfig.debug | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 72fcbb5a071b..5b73fdd781e0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -53,7 +53,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 #define sysctl_oops_all_cpu_backtrace 0
 #endif /* CONFIG_SMP */
 
-int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
+int panic_on_oops = IS_ENABLED(CONFIG_PANIC_ON_OOPS);
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
 static int pause_on_oops;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 49a1748b9f24..7f5e2490a3b7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1067,12 +1067,6 @@ config PANIC_ON_OOPS
 
 	  Say N if unsure.
 
-config PANIC_ON_OOPS_VALUE
-	int
-	range 0 1
-	default 0 if !PANIC_ON_OOPS
-	default 1 if PANIC_ON_OOPS
-
 config PANIC_TIMEOUT
 	int "panic timeout"
 	default 0
-- 
2.51.0


