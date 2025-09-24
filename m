Return-Path: <linux-kernel+bounces-830647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB173B9A368
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F2A4C3292
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D5306B3C;
	Wed, 24 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ttlpp2+r"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8435957;
	Wed, 24 Sep 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723715; cv=none; b=gqs4f/MrjxsuhXins44zx/Dy/NrU24ispF8nQ3I08nPgRtZUqTNdMUTOb+IJxISAF3KmhetCX5minEDzdswDmuK+QOE7yvnb5LphYAqu82DvkRceU4EtsWkNR+1NQjilIK7iDQwgii/Tmm6Lb+qUKQ4gDHxUN+C79adoswtd04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723715; c=relaxed/simple;
	bh=OnThKVkAxTbvu2cs4FLMAMZ+dEhCwYFgliP6EBhRpLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBy8o1l3TglhfeCzY7kFopky296+vupGLQCK3giYnJprfnIuWWfQMJlEDKRaMzWjnI/DNKaSbXJnv7lNeTKvuLwBNp+4s6E2+bpQV1j7/h2pnPjoG/10f9SJnMrqmspQg/MFCVLpXOw9gzucjwlKi39SqmvUkZeA0ELMMP2ri34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ttlpp2+r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w0zvkyHycNf62ji7JboPNe59KMTBMZPeiYVTw++Mcio=;
	t=1758723713; x=1759933313; b=Ttlpp2+rDDtU1UIjZZ4aTRH9guCEs5a09nfPhM+5G1A7CHP
	tYdxOpg/rfr8jzd6IgT9YNBMLdxjomqTvqHi/xZCNSUwCqaGGK3IGTE9Mfs/7njPk7VPW0wmnhrk0
	IjzCiMGNlYdTIrEHcel05kwMbvQnwetfmumidHLeXc6NTdbpwJd5U7XoHiKVu3tSTqJMTRher9DfT
	HDSYZcymn8ShIyH4qGZkA95aEGc1LWN30VklWrm4qfx+XlsRkX7i3rJnZMWQWQmVIR8US1XeF7q19
	sCggR8yJurxVyZkvBBE6mhZw2UwZqIwJ0DZUC0IKHa4RYKCjDi6cQCek8Evn3XOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNQ-000000090Bz-3BPc;
	Wed, 24 Sep 2025 16:21:49 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 01/12] tools compiler.h: fix __used definition
Date: Wed, 24 Sep 2025 16:20:48 +0200
Message-ID: <20250924142059.527768-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

From: Benjamin Berg <benjamin.berg@intel.com>

The define mapped to __attribute__((__unused__)) instead of using
__used__. Having the wrong definition here may result in the linker
incorrectly removing the symbol. Also, this now matches the definition
in include/linux/compiler_attributes.h.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


