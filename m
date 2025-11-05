Return-Path: <linux-kernel+bounces-885846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBCDC34089
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0175E18C0B44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4C2BEFE6;
	Wed,  5 Nov 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1iVQUek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496F21CC58
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323176; cv=none; b=humZjppJQI4kkS7MWHAMTs7xF4EYywxGunrrX4NWrxelz1GTV2iZe0JfLOj0CwL5WXyBe5UlmvTxGBu0uIi5n8BVRiFLFxiZrvhfcUEh3/J1+EHf2WswMsbRLgNUeDD3ePKRHedxBJqBAhdkzbkC8m9aU23yNZJ0bUiUNhIt5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323176; c=relaxed/simple;
	bh=w4YHq5WTec9merR0W713V+DJTQPpFMb3uLG5U/Me7gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHz3AGmkVaL286CD3XpyVd/+Nv/acrNKXlB0K9bWfmbaaEN2vomesa1VlXBayADxI2nWjVjssM7dreKNS9z94BuGviUP3vaFI93u++cjJUx+bxfgsW9YOEZeKYxX6oB4HiEPOeJmVZK8orVSBc/3tGyubp81nSpa1W/db2jbjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1iVQUek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25CAC4CEFB;
	Wed,  5 Nov 2025 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762323176;
	bh=w4YHq5WTec9merR0W713V+DJTQPpFMb3uLG5U/Me7gw=;
	h=From:To:Cc:Subject:Date:From;
	b=I1iVQUek5188DXWaLqn3BrgDZIWA5BLPJVQapEAelTVoB+IeA0ii+b76Zc2HjjwwA
	 KE0fpqBK3o1/BrthXVkCJkges324HtHuMOAbgYsvvA8VJJvwGZHxILpnshZkd/FpvS
	 piC+JvYhnMfO/ll72RtyojdLA+aVkWgtOD5XkRAXHglusEFVlV3tYu0d/3MkrcQVqi
	 Po8Ki1QyfBQ92EBWtPboVCeWDz4ak9Xyc6lAecxUP/qr9Au7m/PuVL3HFQTRudpkDh
	 0TL00u26kSI8E3CJ+nioXaFah3jEbPNWEPy+HgrIKLG/VKBmA4HuR2UBQ8Bt8XlSr3
	 fjC7tMp7Xfwlw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] vmlinux.lds: Fix TEXT_MAIN to include .text.start and friends
Date: Tue,  4 Nov 2025 22:11:42 -0800
Message-ID: <5c4ca80e52958da289f92157430d2a31d29109d3.1762322973.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and
.text.exit from TEXT_MAIN"), the TEXT_MAIN macro uses a series of
patterns to prevent the .text.startup[.*] and .text.exit[.*] sections
from getting linked into vmlinux runtime .text.

That commit is a tad too aggressive: it also inadvertently filters out
valid runtime text sections like .text.start and
.text.start.constprop.0, which can be generated for a function named
start() when -ffunction-sections is enabled.

As a result, those sections become orphans when building with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION for arm:

  arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/usb/host/sl811-hcd.o' being placed in section `.text.start.constprop.0'
  arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/dvb-frontends/drxk_hard.o' being placed in section `.text.start.constprop.0'
  arm-linux-gnueabi-ld: warning: orphan section `.text.start' from `drivers/media/dvb-frontends/stv0910.o' being placed in section `.text.start'
  arm-linux-gnueabi-ld: warning: orphan section `.text.start.constprop.0' from `drivers/media/pci/ddbridge/ddbridge-sx8.o' being placed in section `.text.start.constprop.0'

Fix that by explicitly adding the partial "substring" sections (.text.s,
.text.st, .text.sta, etc) and their cloned derivatives.

While this unfortunately means that TEXT_MAIN continues to grow, these
changes are ultimately necessary for proper support of
-ffunction-sections.

Fixes: 6568f14cb5ae ("vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511040812.DFGedJiy-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
For tip/objtool/core.

 include/asm-generic/vmlinux.lds.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9de1d900fa15..e93460cd1066 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -100,16 +100,16 @@
 #define TEXT_MAIN							\
 	.text								\
 	.text.[_0-9A-Za-df-rt-z]*					\
-	.text.s[_0-9A-Za-su-z]*						\
-	.text.st[_0-9A-Zb-z]*						\
-	.text.sta[_0-9A-Za-qs-z]*					\
-	.text.star[_0-9A-Za-su-z]*					\
-	.text.start[_0-9A-Za-tv-z]*					\
-	.text.startu[_0-9A-Za-oq-z]*					\
+	.text.s[_0-9A-Za-su-z]*		.text.s		.text.s.*	\
+	.text.st[_0-9A-Zb-z]*		.text.st	.text.st.*	\
+	.text.sta[_0-9A-Za-qs-z]*	.text.sta	.text.sta.*	\
+	.text.star[_0-9A-Za-su-z]*	.text.star	.text.star.*	\
+	.text.start[_0-9A-Za-tv-z]*	.text.start	.text.start.*	\
+	.text.startu[_0-9A-Za-oq-z]*	.text.startu	.text.startu.*	\
 	.text.startup[_0-9A-Za-z]*					\
-	.text.e[_0-9A-Za-wy-z]*						\
-	.text.ex[_0-9A-Za-hj-z]*					\
-	.text.exi[_0-9A-Za-su-z]*					\
+	.text.e[_0-9A-Za-wy-z]*		.text.e		.text.e.*	\
+	.text.ex[_0-9A-Za-hj-z]*	.text.ex	.text.ex.*	\
+	.text.exi[_0-9A-Za-su-z]*	.text.exi	.text.exi.*	\
 	.text.exit[_0-9A-Za-z]*
 
 /*
-- 
2.51.0


