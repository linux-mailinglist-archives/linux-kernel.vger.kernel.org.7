Return-Path: <linux-kernel+bounces-871716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8675C0E248
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CCBB4FA78F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EC2FFFB1;
	Mon, 27 Oct 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LBzTFsqx"
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDE28853A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572410; cv=none; b=UvB9P8TjHwwiAkb3TOe8y/BZELESVRj5zhw1ps/qldiek/Ju71WynYbLjryG7Q54t5Te7Zz8hnJ/JNxRV+7D5/4DvWPkKgDMHnGnIBosgH1SzsfQgjSlZn/47GKTdu6K4dFOX/W0RFIO21T66do7VUb/rPyI6ivgAGMsWVZiCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572410; c=relaxed/simple;
	bh=SB2FDnfbtovS0okN3D8Phob/I7gqy2eIwcfr7V3NBIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8Of85EK//JuvbhMn292x5xksFCTKTiHEpKy0Ss6Z6JVDdMwmFMSpXoBjHQ+5AKxpM/erFx+41fAxOZMVLrvCq4si3RvXWxQs2LTKpnlfQrmjRM1oOIppTePkF/1fqT8ijVcyS1fmCXveOMTJr9uwX2OehY+LoucJZDdsFKuS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LBzTFsqx; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 229FD806A2;
	Mon, 27 Oct 2025 16:39:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ldcRbH3LwOs0-v9Zc6SPf;
	Mon, 27 Oct 2025 16:39:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1761572394; bh=wYsIfMMq5RfuE0e0wT9zIIj7BzR16D/8JKR1dbNwbBg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=LBzTFsqxTj4+VLMT+Dd4fRdFwLuP2wTCHOPlC4kxCEc/8Pi2i6k2YkBXSWtj02YoB
	 Ge/A4RnlWokP20QGZD0VwGSGbIeXlIT57B1YJ1yCbeNJpF7eRVJMkgWxD4hrh4i1r+
	 G7+prEBsHECpRyHlPso7wHDQXlDwwfBCbAX9hkcU=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: James Morse <james.morse@arm.com>
Cc: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] fs/resctrl: avoid redundant call to strlen() in schemata_list_add()
Date: Mon, 27 Oct 2025 16:39:26 +0300
Message-ID: <20251027133926.218500-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'snprintf()' returns the number of characters emitted and an
overflow case is handled explicitly, an extra call to 'strlen()' in
'schemata_list_add()' may be dropped. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0320360cd7a6..6f6ef6c4cac3 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2646,7 +2646,7 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
 		return -EINVAL;
 	}
 
-	cl = strlen(s->name);
+	cl = ret;
 
 	/*
 	 * If CDP is supported by this resource, but not enabled,
-- 
2.51.0


