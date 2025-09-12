Return-Path: <linux-kernel+bounces-814478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F897B5548A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C227C0214
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52873128CA;
	Fri, 12 Sep 2025 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="JZMTIQZJ"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2B311C03;
	Fri, 12 Sep 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693790; cv=pass; b=Rv0gd0wuc7AHXOm0QN/KvlQ23ft9pxa/A24dLU8KoWce5N+an6n1WD9TN6+GaRTNQNl/VzEw//FxHwoCwslUofCnbqDpn71zTZtdqD2mmgg1o5B6mf5xXTWCPFEgxwzgWi4OlUfecMAvQJ2WzclQN9Zd5aLIB5WkWL3RoCBfWXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693790; c=relaxed/simple;
	bh=NRicx5aDD8RGc5CnrwE3vZncgiYuHcH40CPQSUOyWHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMHXUqlHvOwZF8rMm8trU03rT2BsH7MhEzgICj+vHFlJ80+Rg3lwkLkTHOr7oS1pEmM66JYIX5zmKyEoJPvlT4qcLMO7MjmS4oDnbZHbEaDfohOd03PupSMnhTZHUMpsMCVm+7VFL1d/D+aEZzzj0WgaqRNWtKS8GpzqcT28QNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=JZMTIQZJ; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58CGGCs0099082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 13 Sep 2025 01:16:13 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 76211109F7118;
	Sat, 13 Sep 2025 01:16:12 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJKnyZmSTD7K; Sat, 13 Sep 2025 01:16:07 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 6677B109EFAC6; Sat, 13 Sep 2025 01:16:07 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1757693767;
	cv=none; b=kFLdblhr0fsqTLCwzoR56mhoDKS1wOZP3Z7GEyOg2ZNeaWM3Ls7134xPP4wQCwI4AViz08nKweDob0C3Dmi8rxx5ZR7qPpVx+98ybl5+1Sq7Os4sG2Z/zDU7AokemfTIVBcEDS1Mcmdlp2chKTMYPHDQBKBbcHo0fj2IvAFIB8Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1757693767; c=relaxed/relaxed;
	bh=NRicx5aDD8RGc5CnrwE3vZncgiYuHcH40CPQSUOyWHY=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=oLDqEg5UsKtgxYIJCNTfXVfDnfSqZDkpUDapV9cRIqEIUWubx7mIylKRtEt5f73abl6Nm8o8FdLQLIYbMRE7L3qPb4gYxKyPULYPjBsbE5o2HbYE2SDJx3VZ+EiYI3nz7j/qkdov59N85mlPXjLHdakMTwXB1OTjbOcgA9I9egI=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 6677B109EFAC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1757693767;
	bh=NRicx5aDD8RGc5CnrwE3vZncgiYuHcH40CPQSUOyWHY=;
	h=From:To:Cc:Subject:Date:From;
	b=JZMTIQZJ9AVpCBA2Gr5x+bHA+wEAXrnlyoDSHjh1mrHhdruCEwrLdKLv4ZSDjWo3L
	 xHlNGijDDI0DTQIz6RJGiVNJ000GYoxMRlGK9KIvU2ZCsJQKmAsdGug6Zqeggh19rD
	 8X3N/DKQdLPOeHxMAchRd6TzdMeADlwHudIL+21g=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] staging: rtl8723bs: rtw_efuse.h: simplify copyright banner
Date: Sat, 13 Sep 2025 01:16:05 +0900
Message-ID: <20250912161605.775637-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace the banner-style copyright comment with a single-line comment.

No functional change.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 drivers/staging/rtl8723bs/include/rtw_efuse.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/stagin=
g/rtl8723bs/include/rtw_efuse.h
index 669565fa1c69..ac7d6ef454c3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
+++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
@@ -1,9 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*************************************************************************=
*****
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- *************************************************************************=
*****/
+/* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved. */
+
 #ifndef __RTW_EFUSE_H__
 #define __RTW_EFUSE_H__
=20
--=20
2.47.3


