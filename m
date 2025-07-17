Return-Path: <linux-kernel+bounces-734498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD4B0827A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB693AFE46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382891C8611;
	Thu, 17 Jul 2025 01:36:52 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3262F509
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716211; cv=none; b=qoQdCLTq2o82mVRP6sBmqbq4fiR10i+lqTZLFdjW013UHpjhiVVh6oSj3tHtY7VaIstx512uj+VyZtdGTSS2d4kNrAydWN2ma680i08JpjpqqkUjxo3+GG8k+O/aZpbDwPY8T7ZTIefoA4XfXpMn86DvgaKQg+ojxBgu1nVRVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716211; c=relaxed/simple;
	bh=wQhfdpUCcg4y0o5ikW+8zRGv4zw6g3w0eq1WiIZ5FhY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vD/n6evEbLjNJBXOsB8oZOsqphQNE4002twheIdvQg2HaRh2JgQ6yVZVNwSfAkER5fE3lxt7qjYKG7Zi0JksoKZ8hi4NAIOgXCp7ZJcTVWeJBNSDH9jLH+9Z7XzIAXI5hMWut/XtpxOTeTlf67ev825wHykLnsNBBhVVMZUidEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201622.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202507170936400856;
        Thu, 17 Jul 2025 09:36:40 +0800
Received: from localhost.localdomain (10.94.14.188) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 17 Jul 2025 09:36:40 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
Date: Wed, 16 Jul 2025 21:34:31 -0400
Message-ID: <20250717013431.15589-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 202571709364085b46b73e7c417b7275f06097cc29a55
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

Signed-off-by: Bo Liu <liubo03@inspur.com>
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


