Return-Path: <linux-kernel+bounces-747794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF9B13860
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D628018852C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63360225785;
	Mon, 28 Jul 2025 09:53:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD921581EE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696399; cv=none; b=k3oWwoFjW95B6hJJxpMgW8lk61OyZpzHEB0LROMjB8q9Kvr0agzhlLUUvnxNsfsuCRMc4E3A9TUGKVFH7NC812BqaNHg4czp1Qu6PlLgkIMAFowkOyDA+AbmMraC9KJAjnOdNCfL6H/tMX6ktfyTClAQYwC8wyAuj5EftGliFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696399; c=relaxed/simple;
	bh=uigPCsdbjIF6TuaOhMt5T9eD3ExGEDCx/DWgrItFotk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=klkOQxDXC1l5WfxOLP+f50kO5X/rKaKAc8cdm6S7M7j9eYAaawggvPdHG6XkxFsvFL85Zdj2rMAGI3+X7ib50kcgs4tokg2Ssk8qTX0W9X/8CSRKQ68bAetSKpa/325HxF4x4NH1wXFKBuJ0V6S/ZnmH0NSUsZtfhDkHxfHWcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ugKXZ-00027K-Kr; Mon, 28 Jul 2025 11:53:05 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/2] MAINTAINERS: Use https:// protocol for Reset Controller Framework tree
Date: Mon, 28 Jul 2025 11:52:37 +0200
Message-Id: <20250728095237.494132-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use https:// protocol, the git.pengutronix.de server does not support
git:// anymore.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5a..2eafee3fd025 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21248,7 +21248,7 @@ F:	drivers/iio/potentiometer/x9250.c
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-T:	git git://git.pengutronix.de/git/pza/linux
+T:	git https://git.pengutronix.de/git/pza/linux.git
 F:	Documentation/devicetree/bindings/reset/
 F:	Documentation/driver-api/reset.rst
 F:	drivers/reset/
-- 
2.39.5


