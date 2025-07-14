Return-Path: <linux-kernel+bounces-730112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36492B0405F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267FA3ACAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29124EF7F;
	Mon, 14 Jul 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bearstech.com header.i=@bearstech.com header.b="A2pD3GQ/"
Received: from frida.bearstech.com (frida.bearstech.com [78.40.125.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDC24BD02
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.125.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500461; cv=none; b=M8ZGvOwv3VCiaWaWx03mJZ0cNcZTIBj7lbhCMSOj49u/WDsKEGGLuisLn4+YAvuMWEb4SO+8QodZBhLDyxRlV8m1dGb87kbxW5AZanJsUEngqIH4MtajUP62CyOXlzplUX5KvJBOGCl1U9DXjqVesRY8hW7FBkY514vbT8skD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500461; c=relaxed/simple;
	bh=swd+UnGSJSjZhyKlzU+gp04gAHFAY+mZIm/+2HU0xzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLjovhZ97f2U2ytRCv/91wg1PZS+C5UYrPXDgnMQmwJEbwcIXIQXtrZ9LQKgh9xSTe8wHh41Ci9VGua/eP+HeRcOwFVt1H5DxH6oDCMJgHYDI0gsKYMnCx/lVs4/Elo5P3ltnXMqG3VcU8eTVlr8/0PVA45gzWyYOh5UpLow3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bearstech.com; spf=pass smtp.mailfrom=bearstech.com; dkim=pass (2048-bit key) header.d=bearstech.com header.i=@bearstech.com header.b=A2pD3GQ/; arc=none smtp.client-ip=78.40.125.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bearstech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bearstech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bearstech.com;
	s=bearstech2024; t=1752499919;
	bh=swd+UnGSJSjZhyKlzU+gp04gAHFAY+mZIm/+2HU0xzs=;
	h=From:To:Cc:Subject:Date:From;
	b=A2pD3GQ/061vWvha8LIIqU1CcmEJufBiS6vXXUK3dbCmkDQlWHgDVeMwnapWsfbRQ
	 CGBc4AkX8KQrf8TNepfa9jdv/fz4Wr6H67R+lHfSi5AraUG7RadS/4jMjk2YTS6QNs
	 fvulg2N1abbJLKUq/8+gR4ostEL35aWY4Qp9dAvTsxDPUwwAch4lcax3dUb7N+KmdR
	 L0AlG5pDoam7tIhwIpZJl3Tyxko5+XzZTqMI2vyYEbUUp19PnrqGs9ChJ9nvnx13vT
	 sQ4kiHLYBIzfyNW9w9kfMaPX6bG4j6nnRoBVm/lbum1EJrNjGBP2axldFwTVd5bv1V
	 nuC5ktzByInOA==
Received: from zeroco.bearstech.lan (unknown [89.234.162.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vcaron@bearstech.com)
	by frida.bearstech.com (Postfix) with ESMTPSA id 02E48AA;
	Mon, 14 Jul 2025 15:31:58 +0200 (CEST)
From: Vincent Caron <vcaron@bearstech.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Vincent Caron <vcaron@bearstech.com>
Subject: [PATCH] staging: rtl8723bs: remove spurious if-block braces
Date: Mon, 14 Jul 2025 15:17:43 +0200
Message-Id: <20250714131743.343482-1-vcaron@bearstech.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.0.7 at frida
X-Virus-Status: Clean

Fix checkpatch "WARNING: braces {} are not necessary for single statement
blocks" in rtl8723bs/os_dep/os_intfs.c:1207.

Signed-off-by: Vincent Caron <vcaron@bearstech.com>

---
Dear maintainer,

this is my first (very modest) kernel patch, training with the workflow
under the guidance of Helen at DebConf25 hacklab.
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index d4dc169e19d7..8b957468e174 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1204,9 +1204,9 @@ int rtw_resume_common(struct adapter *padapter)
 
 	hal_btcoex_SuspendNotify(padapter, 0);
 
-	if (pwrpriv) {
+	if (pwrpriv)
 		pwrpriv->bInSuspend = false;
-	}
+
 	netdev_dbg(padapter->pnetdev, "%s:%d in %d ms\n", __func__, ret,
 		   jiffies_to_msecs(jiffies - start_time));
 
-- 
2.39.5


