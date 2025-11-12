Return-Path: <linux-kernel+bounces-897821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF0AC53AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A7DF342D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6633446AA;
	Wed, 12 Nov 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYwrDJ/g"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8EE56A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968177; cv=none; b=UivRxxpomcOXUDa/C8672bgKW6iekOXFyCXrcuAA9z1wN179uuiWQxUolO/bc9F7CGu/9OMumqP+EjI1ZGdRpD/oFWadRR6056rTdiWV5A4jg6E2o39WVL0pj9wvuRnOZEdPGvPsK9fIfqGFfhQNgxbyycPKCn2UXMxC5FI3Wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968177; c=relaxed/simple;
	bh=bEoWiv5FdmGTT2ZzLe91YGRu8E3ImEYoMiGx0htvVBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKnHUWfTxxfs4wPajar6iHdrYoVUe3UkrqUIL2aMIiH5fNQbqI3nZQugnJyvgqOFEOxGKZb+PoLRPRwiGM3aOEQjBsVKFJjOwW6Nura+L3IoEbUEIW7wUMbS18aSPLwdZW96+K+NiBPzADLj4pO1CDBnL2xyI9p9Az0GX5bOe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYwrDJ/g; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762968174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M/t0VDENjopEu/QVWEvIWb+/nBZVQYPjVs1jeNf6/W4=;
	b=SYwrDJ/gOrcIwEwsyQd25DFLsIPaHgte6Wc8AeSmH3nQKuGRwCItOkQl16DNRQQoBWj4tt
	8yuILtATKnoRXGebPgayTxs3vnvh97RRK9p8jeGsRkJwVu36QQ4b5MeuNiHcZAQWops6lV
	5gcCaX8twQ+0D1xp52FKuDhd6e2uGOc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] alpha/boot: Add .gitignore ignoring vmlinux kernel image
Date: Wed, 12 Nov 2025 18:22:42 +0100
Message-ID: <20251112172248.3927-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Building the kernel creates the untracked kernel image file 'vmlinux' in
'arch/alpha/boot/' - ignore it by adding a new local .gitignore file.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/alpha/boot/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/alpha/boot/.gitignore

diff --git a/arch/alpha/boot/.gitignore b/arch/alpha/boot/.gitignore
new file mode 100644
index 000000000000..4abc9c8ab7d3
--- /dev/null
+++ b/arch/alpha/boot/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+vmlinux
-- 
2.51.1


