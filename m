Return-Path: <linux-kernel+bounces-783885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC96B333D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D66F17CEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6322576C;
	Mon, 25 Aug 2025 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b="qn60oGs5"
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57521131E49
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087591; cv=none; b=PgVuFmmg+x6nx5dLnTt2a6hYigIeKt9q7TJY3RnqO6qQSagMUW9jsMOOxOfbBhVCySTHmFjWuCGsSHrYIqR35ERBCWcz+y8WrigsqZrtuYhoH6hZAc2FCMzt1hP0xaOKcyGanNdUH6FRfjyfb2N6jC4CIZLWAeMwOCW6/g9HL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087591; c=relaxed/simple;
	bh=z6qlv8kuwCIMObmOi1417vC0z1UI8429u9UiX5kj+UA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bZgpMuEjuW+Z/9iVmOt+8Cpw+wvRCKeFN80y2HsR6VWs1On3eFQvE8rrk5q9Os+3fRF0haFDUTuqW/RujYytCAnxW//ArRsE10sNzrvaikp1Apz9R2E9lv9VSD7O44OPEKe1j63koMSymAr3inPtKipaXJjsAijUKlK3cjMpB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba; spf=pass smtp.mailfrom=mail.toshiba; dkim=pass (2048-bit key) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.b=qn60oGs5; arc=none smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=
	1756087567;x=1757297167;bh=z6qlv8kuwCIMObmOi1417vC0z1UI8429u9UiX5kj+UA=;b=qn6
	0oGs5StkPt3jP4IG4J0i9xXxNK0G8NjxDaRDZe4B/TZRU1QmGcITpMGw86RuP4i9SxsExkSAR8X0s
	pXy7OhhDncdib9ppguXrqmViW1nqS/6m2wgun52kOs8Ycq6OnyCQZSytCm600/qTp17jX62vMgqn2
	ir6WryviG7HPePW9CJM+M+dC7bQeTRX98gyDtDLaxcfUXnDNBuU8fcDwW4cJBHkTofUpsAK+18Pj+
	2/shKd1bxUEA74vseJTZyUac8zHeVhEw4DN2aoUvan9uqEwe4dCmiqpcJAMnnoAduZ1bxa5A7mCZp
	KHUd1EoikBSaTW2EQ6t/+2gZEHDFl5w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57P266eh109129; Mon, 25 Aug 2025 11:06:06 +0900
X-Iguazu-Qid: 2yAb5t3M3txZn3UtiZ
X-Iguazu-QSIG: v=2; s=0; t=1756087566; q=2yAb5t3M3txZn3UtiZ; m=9m84xjz33U/vViEszGDPSDB4VoIwlPs7yd4w8uiZTKE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4c9Dfh5l6nzyPc; Mon, 25 Aug 2025 11:06:04 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v2] MAINTAINERS: Update Nobuhiro Iwamatsu's email address
Date: Mon, 25 Aug 2025 11:05:56 +0900
X-TSB-HOP2: ON
Message-Id: <1756087556-25424-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The company's email address has been changed, so update my email
address in MAINTAINERS and .mailmap files.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---

v2:
  Remove extra space.

 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 4bb3a7f253b9b..328b04f82dac7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -585,6 +585,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
+Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro1.iwamatsu@toshiba.co.jp>
 Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>
 Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5ad..47d059d5878a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3431,7 +3431,7 @@ F:	Documentation/devicetree/bindings/arm/ti/nspire.yaml
 F:	arch/arm/boot/dts/nspire/
 
 ARM/TOSHIBA VISCONTI ARCHITECTURE
-M:	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+M:	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwamatsu/linux-visconti.git
-- 
2.50.0



