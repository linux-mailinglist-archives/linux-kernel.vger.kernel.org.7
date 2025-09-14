Return-Path: <linux-kernel+bounces-815823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DBB56B82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E1F178908
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9021B9CD;
	Sun, 14 Sep 2025 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b="RGlFBood"
Received: from mail.inboxia.org (mail.inboxia.org [95.217.72.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CC2AD2C;
	Sun, 14 Sep 2025 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.72.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757877362; cv=none; b=raYAQBATi3WI8luH0N1XvXIpHjd5RI4UwhbEw5HshPEIq83YDiuMyn60DD3oEj5BHovYn99NPvkD5KbHK7nVViJ+VG6CaK51u7YQJCBATjcXGcLec2HoQhsXGWjfvjshzPJU5VKX5qoIlbIK1S2vQXLI9BYqVMW48ZK9Hw9792g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757877362; c=relaxed/simple;
	bh=i/KttEnwsUbEjZCo2R04L3r8lEZXJAxMDdSimKLqb2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1Iwy96BkjVP3BdyTOBeXW0wU3ch2xs7G4joqlcbG0MDzRUvhVKYSBeCrlQqEJxce73oQDGtbvUL2mk6tozg0RUfHIPgJeuLlnEWjhruPr3KX+nB8WRdc8GdXZjlgUZEOdNyyaGuDJjD5z8I15od888RE/LMBA7g0iuiOiwCvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org; spf=pass smtp.mailfrom=inboxia.org; dkim=pass (2048-bit key) header.d=inboxia.org header.i=@inboxia.org header.b=RGlFBood; arc=none smtp.client-ip=95.217.72.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inboxia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inboxia.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA0446166105;
	Sun, 14 Sep 2025 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inboxia.org; s=dkim;
	t=1757877357; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=vhHw2iVsiR0PKDMu0wi5pqxXE8yhrwQZpORC3xfkSEY=;
	b=RGlFBoodP4rpH5Obft1BZ4xm5lLIa+VAdeOFcpAXXJfRK8FspsgcSN9uSWL8ZcHxoX5QaO
	XdVl5PWejYCh+C9jtdDgFNdM5MaqmovKh8rZkn6Z+Xh4ySSkw3bUBLgqZMF/xkYGNgV/py
	WZ3FIboyH+P00R6UGDTxxt+vQyP/W3md7Dnbb4r5dqcppFcLJKXDqbH2NtrNKOdi6pmjJn
	ZCmG/mjkfLU6ouzNdLRwWTEg93TllKjRNYWdn7dQJCFIGT/4EkiwCY2UMdz21EoQQBoa2X
	Y+2uHBX651cC42zy9gWA1o7XmsSAZvKP1MAwNxfam0Yi+2xZaMoF1lqIj1/Tpw==
From: Bou-Saan Che <yungmeat@inboxia.org>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bou-Saan Che <yungmeat@inboxia.org>
Subject: [PATCH 1/3] ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 5
Date: Sun, 14 Sep 2025 22:15:37 +0300
Message-ID: <20250914191537.2530-1-yungmeat@inboxia.org>
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
 sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
index d8249d997c2a..16d5ea77192f 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
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


