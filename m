Return-Path: <linux-kernel+bounces-840577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A993BB4B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A88542336B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C81271451;
	Thu,  2 Oct 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Nzrdo/xZ"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5E26F291
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426559; cv=none; b=LoWg7TQ6eVA/B6C6QbJjijwzl7qGsrl2J27Hpekg0MMA0MDZLztWB4dcodNKAOETH3ECYOLp0VkeCSCbo0PSgZsP/LzElDqrqLYNXn0fxfv79DFVEBGxTja2IDD47Kf9wO8XGooVqrOJyo/NLLZ0/6TA5mjqBsUfdB6TIjiQvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426559; c=relaxed/simple;
	bh=q+2gycPPhS/NXmq+pccIU874tD4r8YzK6KhJaMPgm7g=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TGirrH7EU52DVV+Gex4ZTyXt0eHlSJNl9vxdKhhjVsZcE8m+RFISbCkdG7eohwlUOMO8sldXpkbW051q9U0DW79gosjghTQkQQc7Dpi/86QJ6tWjpJwubQbAXQeL6pay+bFvbahgdUnUMKJ+voaSQ2bPW0jp0Zq+7hYZ1pbGESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Nzrdo/xZ; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1759426550; x=1759685750;
	bh=z15ojxfpDIwcTHJzOQG6KVgjylqu21VWFYD9yzHQoB8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Nzrdo/xZvCpjOGV0TZ6TPbS0WOU4RjiZV0DGIUwj6G5taCsNwKvvjN1niSDXiR7gu
	 4gdFEJaESsFeynl1a47pukEaPfy7SYf3M9O6jJt4tFrkGtIibOuBvyfz659W6Dz0YE
	 QcZDm2qyLX1y0Z0cJwJm8CTLkpxWwWDPe6pWyp1qiS6/FxgC9SwAVOVfOAfHta682B
	 ZTTS2RbIPoBfPJQxzwTm/rGT7b8gBgC2jLclPXZ5iBDmXFUJjyrmDMA7OnzpZq+E7y
	 smtD5IwrDOXP7Wl3JeJSJnbi8OIHgdf6q9WfPwf5FM2It2plXxYPOMrYBIYS2vVCQv
	 WolJY3+oXyZjQ==
Date: Thu, 02 Oct 2025 17:35:33 +0000
To: Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] thunderbolt: Fix typo in tb_eeprom_ctl_read documentation
Message-ID: <20251002173459.68542-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 05a15cb56fb37a86cf43e784834e6e7bf4c7b2a0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix presumed copy-paste typo of tb_eeprom_ctl_read documentation
referring to tb_eeprom_ctl_write.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/thunderbolt/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 1af65fece495..5477b9437048 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -21,7 +21,7 @@ static int tb_eeprom_ctl_write(struct tb_switch *sw, stru=
ct tb_eeprom_ctl *ctl)
 }
=20
 /*
- * tb_eeprom_ctl_write() - read control word
+ * tb_eeprom_ctl_read() - read control word
  */
 static int tb_eeprom_ctl_read(struct tb_switch *sw, struct tb_eeprom_ctl *=
ctl)
 {
--=20
2.43.0



