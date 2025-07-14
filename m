Return-Path: <linux-kernel+bounces-730076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A64B04008
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB7188A6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F31149C7B;
	Mon, 14 Jul 2025 13:29:24 +0000 (UTC)
Received: from camille.insymetrique.net (camille.insymetrique.net [80.67.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECA246767
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499764; cv=none; b=qT0PpP1npQuhcEqQuAHAZCfvrzoSJniPiyUbkPROZ0oLs5A07FGzK/ZqNggyy57ltusENAhjk+UTIsZS/5e6TaefBBcyoHCX79apsoje3UqQe4ufJQHLAuRgUmBnFEra1pMgSH3mryQr0OisiRh+8+dN7kASADZjjQFsUSKquys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499764; c=relaxed/simple;
	bh=VoE/He8A7pFiu7S2/GPsIasmNwCHjvnNQp8zOIbyzw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6GqHzG62UkDmpXL9VM7aAB5Yuu5xUvqoPQewqypyjQIhChLs3CeoNlbCJ/IB7Iuh5lrz0LVYzcTvQH3A+uwEnNShPYE58kFY9K2JsvaLmFUnWge+o2XmfhESLhK1VtWpUSfB5lCvtjCddKCZPZ6Ye6v00S20T6ZzfB0U9LMsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dupart.org; spf=pass smtp.mailfrom=dupart.org; arc=none smtp.client-ip=80.67.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dupart.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dupart.org
Received: from kern.. (unknown [89.234.162.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jonathan@dupart.org)
	by camille.insymetrique.net (Postfix) with ESMTPSA id 4bgjhV3VCSz75P6;
	Mon, 14 Jul 2025 13:24:10 +0000 (UTC)
From: Jonathan Dupart <jonathan+kernel@dupart.org>
X-Clacks-Overhead: GNU Terry Pratchett
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Jonathan Dupart <jonathan+kernel@dupart.org>
Subject: [PATCH] staging: rtl8723bs: hal: add spaces around ternary operator
Date: Mon, 14 Jul 2025 15:23:41 +0200
Message-ID: <20250714132343.1613229-1-jonathan+kernel@dupart.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style according to checkpatch :

CHECK: spaces required around that ':' (ctx:VxV)

Signed-off-by: Jonathan Dupart <jonathan+kernel@dupart.org>

---
Hey, this is my first patch, I appreciate any feedback, thanks!
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 893cab0532ed..563d66afa547 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3185,7 +3185,7 @@ void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
 		val16 = rtw_read16(padapter, REG_TXPKT_EMPTY);
-		*val = (val16 & BIT(10)) ? true:false;
+		*val = (val16 & BIT(10)) ? true : false;
 		break;
 	default:
 		GetHwReg(padapter, variable, val);
-- 
2.47.2


