Return-Path: <linux-kernel+bounces-865935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D1BFE5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA35419C6A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701B1DF75C;
	Wed, 22 Oct 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMel8KMd"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4B3043DE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170614; cv=none; b=UJrwbY2pS8+5yKYF81DPdJkHuuIDENzdpKpb9JQ+sPqE3hpMbGxR//ShslzXPV6nNV02W58TsjIHvjl+xXtePKIrfmUV3C5FVMeDwV9nlbUGO6a1aUXvaY44DB/rX3rndjHf8t69mmF6w3kcHFFWN7J+QkXO//CMUHn2fFTCWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170614; c=relaxed/simple;
	bh=Ad2cCbxg4Z1sO77CXRzr3tWjUJufZzDngeFPn5U+ARc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT+vDNkteQSP3ELmEW90TlW9W7/uOKiYbFubbTrHA6mnxdOo2WyljVGM30W6mfkg3BEDCabuyI2LItscK4lB14S0flSWNfA82G6N/4dgZ/dkhtLbNT1Iz3n3a4j6+7uSSw0xpdElqv5rBIWnQQfFdtFf1IGZeCci/o1SyAqfy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMel8KMd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-793021f348fso118179b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170612; x=1761775412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ux/kk3E8TaoNJw/zffvlizfWUNSIBjq0m1/nXej3Ft0=;
        b=nMel8KMdYGwIbBAJofXabzax/ux/lB8+1znKGoJ9BdborAbDd/hmzpJE4tWeNceTv5
         RXng3U2kml5gYYrSeIJLkCfCr+ns0VS/zKh08wLMuD9P6m682pXwUSLk87DaGrlR1OhK
         +f4Ykv3gIeCFuM0rUfulYJqN/Hllry96bwLzwGo66zN4J56vrEnh4q3Xi79KvbtO2g6a
         F1IJ5L1mfc6T60d6ICvXI/0kzZCwoEbD3iEkvL90OessR61A/E2J9Q6rKqvWEFxlSs8j
         fC3oCLWSfaqYwEvQ0tVj76S79qO8WSwqm3JKo7o20MkYQSN3eO+sOoLRYbygAmEbwJsS
         ZeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170612; x=1761775412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux/kk3E8TaoNJw/zffvlizfWUNSIBjq0m1/nXej3Ft0=;
        b=pJDAuRZTgs6CkpIClS7Fm1bGSnR8qZFPPs8N6XcLN7Nvu5c7ytSSrKx3lviOG7Gd3n
         fd1cQdmRswNZuIcioTSXajbGyHQ6ssL3kKBwFH5br0WcILVYTBPQ0FjqvZQ38QMOd8kL
         Dy7ycCHwQfKHoT9RlTOzdtXZByaMJ6nyedpvyVqkjuL/prj/xu292118HwTSlibE3VVm
         VNIEPPGzq8VVaGCx72gs5We1cZMSsnbzu1bQcczcE03+Ms8FQy5j+aCfDtGXIXBtry3T
         BrvEhXxWhraMGZ12oNXQ3cDiOOpk9MsmLt8uCaryCVnhC0nki57PnxkeQSfR7YUCzSNK
         aLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXavtXhQ5+MOsKK/+Nvba+j+7kraNrVdTuUYtdQZ2XZeDaY1543xrqL2uajG8fmkcsi5fV9BJquivL73q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGZEWJC3ltBcfj07Xg4amt2vYCvsS9Dzl/7ZUP3IxBvxrUPft
	HneOkxh1QLCVLVcP5C8LYWomyBd2ahOIKcwfrUHU+AUOlEuK2u7UKs4H
X-Gm-Gg: ASbGncsGWw2Vlkjasj/Nw0EXTtSmAlwATQgkznS9ot4wf+NWyOyNd5/niVIkPNB39+r
	OnF4srS9Y6fEuw3ioC3FMVOEnax9X0E3cELuF/DdEr5ulDT1WDgEcvcUqFC6KUjVix06koYKkX3
	lKXkVpuAR1/SjIrE5MNQCNm3Pp7JFTzbNrKw8+rmFOY3MiKXLmRLP/JTcTj4MbVaTYo6ZbAHtjY
	N2wLeiFgbVH+GPZZpBC0+4G/q/dP+4SnZYT+6ExoTJyNV720bMYNZAVD0YDB0acxh9QYPZqm5JU
	jiMdTahQUQ8AgD3ibn/sDEtZZRxNM2t3eTLM0YUJXSH6toMVq4lSrAn30nuCzzVRgdby5hzMGwS
	Nzr183kPSLHAuFB6O+xiEQLXCYdf1IV51Dvk/kMweSxLjMZphARqNGrGXP4WIVbLzW4zu2qIY8B
	YGl5UocNr+b17Kg0k+Q99VM0o=
X-Google-Smtp-Source: AGHT+IHOKCy2DH7KAv9trRUhXlwgWDwBolG+BUKI0eV1iSdxSWzMfxG2dEL1k7vkjKTfjuYp1ROHGw==
X-Received: by 2002:a05:6a00:22cf:b0:781:1481:897d with SMTP id d2e1a72fcca58-7a220b16cd0mr31471379b3a.17.1761170612295;
        Wed, 22 Oct 2025 15:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:a014:6e9f:df59:b010])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b350sm261181b3a.37.2025.10.22.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:03:31 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: remove todo/note and duplicated EFUSE_CTRL macro
Date: Wed, 22 Oct 2025 19:00:51 -0300
Message-ID: <20251022220324.14260-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of EFUSE_xxx and MSR macros are already in place, so the note
and todo about that can be removed. Also, there was a duplication of the
definition of EFUSE_CTRL macro in two places, keep the one at the .h file.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
At drivers/staging/rtl8723bs/include/hal_com_reg.h file, there is the following note/TODO:

/*  TODO: use these definition when using REG_xxx naming rule. */
/*  NOTE: DO NOT Remove these definition. Use later. */

#define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
#define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
#define MSR						(REG_CR + 2)		/*  Media Status register */

I guess the idea was to standardize those macros rather using the REG_xxx_yyy ones.
In fact, when searching for a missusage of that, there is none, only a duplicated redefinition
of EFUSE_CTRL at drivers/staging/rtl8723bs/core/rtw_efuse.c.

I`m suggesting to remove the note/TODO as well as remove the duplicated define, since the
hal_com_reg.h is already included at rtw_efuse (included indirectly).

Tks and regards.

Changelog:
v2: rebase
v1: https://lore.kernel.org/all/20251010185456.26754-1-rodrigo.gobbi.7@gmail.com/#t
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c      | 3 ---
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index d5c53b614f61..98b15ca10074 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -26,9 +26,6 @@ u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
 u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 
-#define REG_EFUSE_CTRL		0x0030
-#define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
-
 /*  11/16/2008 MH Add description. Get current efuse area enabled word!!. */
 u8
 Efuse_CalculateWordCnts(u8 word_en)
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 9a02ae69d7a4..cf5c15dc2bfd 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -189,10 +189,6 @@
 /* 	Redifine 8192C register definition for compatibility */
 /*  */
 /*  */
-
-/*  TODO: use these definition when using REG_xxx naming rule. */
-/*  NOTE: DO NOT Remove these definition. Use later. */
-
 #define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
 #define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
 #define MSR						(REG_CR + 2)		/*  Media Status register */
-- 
2.48.1


