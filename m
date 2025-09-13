Return-Path: <linux-kernel+bounces-815388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99481B5639D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8AA7A8C26
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A669283FFC;
	Sat, 13 Sep 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="ejVdlobP"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFA1A314B;
	Sat, 13 Sep 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757803530; cv=none; b=JWM6ErT5h/99MVQBMjzudfzy1vpXNziv5tTeLITBctXBOZ9RT1fn0cMjs/yqF8tzHRrYvpiiC7z3LnZ7lOZGlbc7NY7gdO+cFY+e8v+dPSH3LogYD1hD762zM25ayFTYUCDNw/hi06Jaus8TK6fxw8KLOMR4UZf6tnkuwfjjooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757803530; c=relaxed/simple;
	bh=KAlbMy49hkms1Al+qR8sVuuf/ndsc9PyiN4dXJi+Mlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e812mHV9IozyPoMABMHG/9OCXeQOXYIrm7HVyJaEKgQD+NKLP+khOxOF6dGeOEqK3OipM1QDRO9MyHRUxEv7MgtWdy3DkP9CwTOSMeoEpzVe+9Wg/B/scQUxigp5URatjZ5IaCvEPNCl7jCbdpAIQzfPsYRLgdF1IYz2gAMhy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=ejVdlobP; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CA9E6166713;
	Sat, 13 Sep 2025 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757802974; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=dg58pqC1a3dSXa+6eFNI1bKCrcYCFjCJ/ft1V528zas=;
	b=ejVdlobPsr+nkO/vflXoIUwqMlGMHaOAn2Z7mDMcIzJE/CimtrmDyckaktJnSekb7XYLy5
	XxbZpbPyYCArOm46ws/vFqLeCr4419Ir1jyhv66IynDFNsR8OivXyv5QhNLnxkR5Q+RiNL
	W4u1T75XQYYo0xRFlLF6nQ+aZxoOcjbbuO9IAjGrg5CODQC3u/gORgtOKO+eJMxzjnmoxU
	hwUKmNOiTYFzckVElZAzNDHVWR3SNLZ1ZP1jpk98zBg6hqsJNN5TrGgB1gAkQJ0HvrnyQ0
	Zxz+1RMMcSSBCCNvbUwX8I8/cDNEJrenZY/6jtWZ2xXq64RLo9ZNmbKYyx/TBw==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH 1/2] ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 5
Date: Sun, 14 Sep 2025 01:35:57 +0300
Message-ID: <20250913223557.9116-1-yungmeat@inboxia.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This laptop does not contain _DSD so needs to be supported using the
configuration table.

Signed-off-by: Bou-Saan Che <yungmeat@inboxia.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index d8249d997c2a..16d5ea77192f 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -135,6 +135,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "17AA38C8", 4, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, 2, -1, 1000, 4500, 24 },
 	{ "17AA38F9", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38FA", 2, EXTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
+	{ "17AA3929", 4, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, 2, -1, 1000, 4500, 24 },
+	{ "17AA392B", 4, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT }, 0, 2, -1, 1000, 4500, 24 },
 	{}
 };
 
@@ -558,6 +560,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "17AA38C8", generic_dsd_config },
 	{ "CSC3551", "17AA38F9", generic_dsd_config },
 	{ "CSC3551", "17AA38FA", generic_dsd_config },
+	{ "CSC3551", "17AA3929", generic_dsd_config },
+	{ "CSC3551", "17AA392B", generic_dsd_config },
 	{}
 };
 
-- 
2.51.0


