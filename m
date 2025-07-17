Return-Path: <linux-kernel+bounces-734517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA213B082A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB83317558C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E72B1CAA79;
	Thu, 17 Jul 2025 02:00:13 +0000 (UTC)
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2213BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717613; cv=none; b=lghff1gLSL6MudK8opSJN8/rqeoHWOt72vipgGL2TNu/EYgyLo4D/V0eyGw6XNNLAagtbubYu7veTEUS3OaC/TbHGYw+oZBubMLDgVfnD0NLzZxXUk6NU87hUOUkJAmsdD3vDI7AW68reje3WKccOXJ95hzyKBc9yxw5BP+//OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717613; c=relaxed/simple;
	bh=bo0OaTgnyapKUp7jo6Q9C/PXK53tTjC1DKb2/QGimfA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nX/COoi6/lbuN83yvb5RzWi8GYU9u04ozEgzembPRxTkgXLG0own03sJJ+s0OJihWjaebkIiRUtQewdjgjAKqM0767010QS6mByo9PMLHPpQABzO1jS58U0DLF3gpUNCImW83pmZBXnsrjTGcurEKc9Zyn1vQhHz4w/CLdlxtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202507170958577543;
        Thu, 17 Jul 2025 09:58:57 +0800
Received: from localhost.localdomain (10.94.15.194) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 09:58:57 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH v2] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Wed, 16 Jul 2025 21:58:48 -0400
Message-ID: <20250717015848.4804-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 20257170958579e39912c5d14bf5a236e6e429856e73f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

fix build err:
 ld.lld: error: undefined symbol: crypto_req_done
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_acomp_decompress
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a

 ld.lld: error: undefined symbol: crypto_alloc_acomp
   referenced by decompressor_crypto.c
       fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
Signed-off-by: Bo Liu <liubo03@inspur.com>

v1: https://lore.kernel.org/linux-erofs/7a1dbee70a604583bae5a29f690f4231@inspur.com/T/#t

change since v1:
- add Fixes commits
---
 fs/erofs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6beeb7063871..60510a041bf1 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
 config EROFS_FS_ZIP_ACCEL
 	bool "EROFS hardware decompression support"
 	depends on EROFS_FS_ZIP
+	select CRYPTO
 	help
 	  Saying Y here includes hardware accelerator support for reading
 	  EROFS file systems containing compressed data.  It gives better
-- 
2.31.1


