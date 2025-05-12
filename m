Return-Path: <linux-kernel+bounces-643588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A12AB2F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 07:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E80E3B261B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 05:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F42550C5;
	Mon, 12 May 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIE5pvGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F33C38;
	Mon, 12 May 2025 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028239; cv=none; b=iWZhiCZcD9r28yI+LQxFNRxo7FvWOACUZ/oO7+0Lv9gXLwlCut8WWMXLeg3gEuenGsFNxFH+gaaI2dxeaAeR2OS2Qmjk053SapUSkDGq+nqSMi+oX56pVqDJY5E+ygmRrk6+4kOWnsZznQh4phGbaI1XJVbqZd7Cr26RefgXlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028239; c=relaxed/simple;
	bh=0bz9gdtKjxMru22UEc0NKkOoP2WoFIJQeKzcI/36fso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJV3hKBAzKlsugLk9sWZGzBSScnn/EX9DzzYy9gPxldb/OsLPqhHjcO0NpBU/GK9BGf224MbCv1VNuZWyVEmW+KjULEZ80e4/9JbFOcnkzdBZ1pA52X7nNcqIIQFRa1Xgy7Y3MofKLj9wGGb47JXtAZlj9OiV6U2Nq/cMfElOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIE5pvGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C8AC4CEE7;
	Mon, 12 May 2025 05:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747028239;
	bh=0bz9gdtKjxMru22UEc0NKkOoP2WoFIJQeKzcI/36fso=;
	h=From:To:Cc:Subject:Date:From;
	b=GIE5pvGoQ1SnqlHt/nO93YvuIHAvKkLaMZk0AsVLmXPp+N9gx6y51sUI+RUY4th+X
	 JRRGvJ5kAXKtEngzs6YtFFE4lFNe3cmf6WCwFucGYmLb+UlYl0fDJJJLnO61nEy2H+
	 QNU2VIiIyk0LOjpReNcuTWxa644DDoFk7+VgOzAarmCSrSj93ab354ydASj2Dj8C+5
	 fbpuzvefyygcsyhyGWcw6O0XAJT0GjwZ2L1bdC0Ds4dGw+nhqhR9/EEuqTHqlcLErD
	 pCpacInL26gX63grr1k/xs2qGEghBWwfEYwCwlnhm6Pgu3sVHwN2knvHhw2MUnQDh2
	 Te5QnHEVN2v9g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>
Subject: [PATCH] kbuild: fix typos "module.builtin" to "modules.builtin"
Date: Mon, 12 May 2025 14:36:58 +0900
Message-ID: <20250512053711.9576-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The filenames in the comments do not match the actual generated files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.vmlinux   | 2 +-
 scripts/Makefile.vmlinux_o | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index d14ab3409da6..6227301cdd6e 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -97,7 +97,7 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
 $(vmlinux-final): scripts/sorttable
 endif
 
-# module.builtin.ranges
+# modules.builtin.ranges
 # ---------------------------------------------------------------------------
 ifdef CONFIG_BUILTIN_MODULE_RANGES
 __default: modules.builtin.ranges
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 938c7457717e..b024ffb3e201 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -73,7 +73,7 @@ vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
 
 targets += vmlinux.o
 
-# module.builtin.modinfo
+# modules.builtin.modinfo
 # ---------------------------------------------------------------------------
 
 OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
@@ -82,7 +82,7 @@ targets += modules.builtin.modinfo
 modules.builtin.modinfo: vmlinux.o FORCE
 	$(call if_changed,objcopy)
 
-# module.builtin
+# modules.builtin
 # ---------------------------------------------------------------------------
 
 # The second line aids cases where multiple modules share the same object.
-- 
2.43.0


