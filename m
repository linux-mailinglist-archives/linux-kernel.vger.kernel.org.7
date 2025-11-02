Return-Path: <linux-kernel+bounces-881747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86BC28D93
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F28EC4E61C3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E423909F;
	Sun,  2 Nov 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="B1MXkcEq"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D013AA2F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080390; cv=none; b=SMVfaLDrqIGs2LEs12i1sBQXXOrm+9UpPsBUXeZVLBKWfzlexyu2KX15YuLzWjuSciULm2FXUPhKpnSOLKXx2kJB/u89pqDv0FFMgulK3hpOUJFIvl1YYItSoh9fgSmm8STargt71dw/dg7D9ikhCp8QtJeG4gbicK22F1494+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080390; c=relaxed/simple;
	bh=eX4Vn9mFeW02xdtCaP4bKsXAOT/5cf4DZrw/nYYN6jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PzgKea4arqXRZE6ENFfnPE+Z9crKxdwxx/4c3D9jgShh2JIXEDee9VPHZdFv39JlfRqVcFY5iMJyPVxjsMMLD23yXCl07ypWakMtJ8UvXwX5cVRdR5hUS3teuDvIc46El054IqbXJ6ELnwKdQNPhYqObBwJMBeylrenHAo0fu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=B1MXkcEq; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762080387; bh=riWRpdOx+q4QSoALbcMfrfoEGkpzcCDRZmG6gniWz5o=;
	h=From:Message-Id:From;
	b=B1MXkcEqFU6na5rxsmJB/lqsJFU3H7VXVuihqbVMztqyPaSPNLO+HjEuJ1F9E40iF
	 ba4+ppFWhZIKVd1hJOiJb8ZkJeKzsdsJDTP2DLnH3ZE7saOIWJPKS7T70BtFgwF3Ns
	 FpjCNwsHqDn6FIsZ2X77IU8ygzPQL0uNztPWbNFk=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id D2DAEC06EE;
	Sun, 02 Nov 2025 11:46:27 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2AkJ68024501;
	Sun, 2 Nov 2025 11:46:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 1/4] tools/nolibc: fix misleading help message regarding installation path
Date: Sun,  2 Nov 2025 11:46:08 +0100
Message-Id: <20251102104611.24454-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20251102104611.24454-1-w@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The help message says the headers are going to be installed into
tools/include/nolibc but this is only the default if $OUTPUT is not set,
so better clarify this (the current value of $OUTPUT is already shown).

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 143c2d2c2ba6..4f617d91a5ff 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -79,7 +79,7 @@ help:
 	@echo "Supported targets under nolibc:"
 	@echo "  all                 call \"headers\""
 	@echo "  clean               clean the sysroot"
-	@echo "  headers             prepare a sysroot in tools/include/nolibc/sysroot"
+	@echo "  headers             prepare a sysroot in \$${OUTPUT}sysroot"
 	@echo "  headers_standalone  like \"headers\", and also install kernel headers"
 	@echo "  help                this help"
 	@echo ""
-- 
2.17.5


