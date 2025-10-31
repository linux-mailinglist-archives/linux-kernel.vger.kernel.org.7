Return-Path: <linux-kernel+bounces-879400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A608DC23060
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADC01A63390
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E032D7804;
	Fri, 31 Oct 2025 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="n9lD1Sja"
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433E2D73A6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877984; cv=none; b=Ce0bqm5ICP3X+S/E4QDi0J8KkCOhkStGUNZ3H3ALx4I7GFGziX+c7xd3XnuIeUaId5U7SPMPb6a7UvoVvK1hJ7XxNIAZvX+xaaTy7PIloVAFjnxpOuqI98aFEf/Evd0pfJhkfykKKxZAFB97f0eSGDI8by/YOuvX0dCCIkhUiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877984; c=relaxed/simple;
	bh=nsDMeO0rPrnwTy57ARzThCpYti0r1NqiTgugU3Adujo=;
	h=To:Mime-Version:Date:Cc:Message-Id:Content-Type:From:Subject; b=TU9I9QWId3chgaN33hLKfHuV+5G7Kd2Tr2DLZpukX0s7xCBId+djbBnEfwTyGPVgguxtSjurPVsfNAnm/rkt8LsO95a12CLPmmRRacG0z8+pH15zu7drR0vPdgTKwB3u9igvjJJ0+BF34CrExsQWNpGVgkRTu1nenpzJqMWiIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=n9lD1Sja; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761877963;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pobT/Ui3SiadYn7R34ZqS3avzSG6o5oI87gV77gbOwM=;
 b=n9lD1SjaAfJOC8rSHymsiEauQFpHJdeuzZPHPMFfnZk+3dpE507jxZ4LYy8fs2cw9fSPEi
 jzxSGzmg/p+avC7ctkIjI128P7qyk1XLCsaSUE7zKMOSAdBsXNLRbRj+eV49mmA06DTlWO
 g2b4e7lP4knkoCa8HF6V7WjBqPwklrB5z89I8WoEDlp2B4WOpK+k2JC8ElNXBKNAoEJoa1
 bnCh0H3pezc6FLnOFgqFl425I48mb3cCAios2m4AAQVANqWY+097qSp3j2e3FaRi+72IgW
 JeNOPyEbyB6KIs/s8pN0WJUsRCKzcQAUH4Lycvvyi72pQ9Qm7Ka4xo/clxEGuw==
To: <miguel.ojeda.sandonis@gmail.com>, <tamird@gmail.com>, 
	<da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Date: Fri, 31 Oct 2025 02:32:39 +0000
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with ESMTPS; Fri, 31 Oct 2025 10:32:40 +0800
Cc: <hust-os-kernel-patches@googlegroups.com>, 
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Message-Id: <71ff222b8731e63e06059c5d8566434e508baf2b.1761876365.git.chenmiao@openatom.club>
X-Lms-Return-Path: <lba+269041fc9+64e4ba+vger.kernel.org+chenmiao@openatom.club>
X-Original-From: chenmiao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
From: "chenmiao" <chenmiao@openatom.club>
Subject: [PATCH v2] Makefile: Remove the product of pin_init cleanly in mrporper
Content-Transfer-Encoding: 7bit

When I enabled Rust compilation, I wanted to clean up its output, so I
used make clean and make mrproper. However, I was still able to find that
libpin_init_internal.so in the rust directory was not deleted, while
all other corresponding outputs were cleared.

Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: chenmiao <chenmiao@openatom.club>
---
Changes in V2:
	- Add the `.dylib` to mrproper files.
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b34a1f4c03967..b38b2895e1e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -1590,7 +1590,8 @@ MRPROPER_FILES += include/config include/generated          \
 		  certs/x509.genkey \
 		  vmlinux-gdb.py \
 		  rpmbuild \
-		  rust/libmacros.so rust/libmacros.dylib
+		  rust/libmacros.so rust/libmacros.dylib \
+		  rust/libpin_init_internal.so rust/libpin_init_internal.dylib
 
 # clean - Delete most, but leave enough to build external modules
 #
-- 
2.43.0

