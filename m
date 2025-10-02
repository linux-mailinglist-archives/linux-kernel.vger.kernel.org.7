Return-Path: <linux-kernel+bounces-840583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27BBB4B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3317B4DE7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8C272811;
	Thu,  2 Oct 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7/QUlD5"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC37236A70
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427002; cv=none; b=cP3NZng4Ercgo7BdogdKxXxNfGj6vVWlYXHS3wOZqmCJycWKeGTxYZPb5QHVBbZ7vPr2zv4Ga2aehWWgXESLYgJv869EG5o3A0yoonx2zovnrC3F+vgOuaLu/oEsZZMrU//Ee+QyCuSnAYE6qKCXetPSbJAjgSznh48H92Nlb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427002; c=relaxed/simple;
	bh=3g5RnIt5W4eNBXa5w8Ni3T1iTz9L0NQHfkbzpVupV4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FNii6pK/nT/zKqWoFYBVqijP2SnetQopxcHb8R5xDh3STiAJB9pbVtkoRmbbaIgFMO6OTLggRaVNtjOzi8yhtYWoRbf3pGcQ5PVE7cMmFOyugnlPZ5AYr02mCHuzGYuifVc2uZY0b15/XMHpptD2ARLfS1w3kIL4qhdqC1AjA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7/QUlD5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-336b9473529so2047295a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759427000; x=1760031800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DzzDJ2yDPtgGQPfiYSBYD855yiSdjlPSb0GWkIT9A14=;
        b=G7/QUlD51c2qDpHkB/NBUBR9IgMlfwkiE0NjJlGTUqYqfQR28Yw3TK8ZefZ5dk1IkL
         0xmbrHBKRDDBHTE9TWvMz2MskRHPKpXoXrhlJjm+ETBDnSWiXuQvFQBjshCFDlYsBDw2
         H5+YBztqEP1GNGNflScGrOQBbXbTBD4PSYNxiO6kR+KwKB5sE8C2zKPRo/Q16DcaiQmO
         nfUlQV5dHMqSoQi1BhNQ4u5YiGZveDSJSNXsNvYDPWYenqhg3KnUedZwzmqBCWhmOvZ/
         rUlA4oRHPjRg/efAXCsZeZhpCgv3jVUic/Fm8kqjhT0WKDJfrxyLRyfyEy+jNf51ovKj
         ACGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427000; x=1760031800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzzDJ2yDPtgGQPfiYSBYD855yiSdjlPSb0GWkIT9A14=;
        b=JNvnlVJk5TPaR8CO5EzloHNkICHahpP62Fqy13aT6Ts5EM4KDtCG8gxMvw4D6Gp5lw
         2soD2Uezn/eY07i6smsUOM07mCkVx4rcZ28GmxRRryy0mYswv4xf6uhMcLtuUidDl1xR
         ftOYb82YoFdoQB4izQVDYxpYA8eU62NPXI5Zr+qCcGZJpEBkcbBHVilS7zqxpruhcZCZ
         bRsZec3Ow/9xIdHFJdFQS0+odE/vDmhedXAenE06Y6MSrgQGwY9VgHVFdQ1bU5eP9Znt
         TEgW6d9tNdpdLUBnDkGryo7OONE9vr5H2yoVh5adB+rl0cLoZMoxJTe1Eu95GvCBnDTi
         dnxw==
X-Forwarded-Encrypted: i=1; AJvYcCW/auYN6c/8Ft6LxQ1Ujqg8N9TzwUlr263xb39nja1SbCj1XVD5p+RI4pvi+uDTtDcrVXPk0Jv/h4dDASY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAg5vU8EQkh1BS6+C6qik/M4utn+/bWu3D7WTCT5XDCIGLdolI
	Q8ZVPKluDNkyLUVSUgCnJLroci+6E7mE1U/CsrTO9Ic9AxhzoWmLTtif
X-Gm-Gg: ASbGncth3Mq4/xUZ3Df+U0Px3gSIyjwSQPPjxdKyl8aVanLayl2+o4G2Oa77iSR+cu1
	ykCC2Ay+6s01R+HQLaOEv1fu1/w5l0qhkLP5GpAHBiycc72Y9cnrzScd3J353672+jWHp9j9FLt
	ZBrNnfz9Pnh7tXY07itZNxfRrz+vbeBi/f9fbPeutCPgAAH1h4ybMY5ktXGXZooZIjxpTTVBr/w
	JMFDrBR+dgVkBuW8UhxAnNPLqpcX5rUHgPa5MTQ1WmHmO1GFDr8AqIzxp/h02jT6UE8lSholU0S
	65AI4VQGBjzDdu9+lwMkgqiCtD/Xy1bVnsYbsuGFNIjROA69enDTYYwtBbwgr2wxh8O0K1KNdek
	GY+qsRqkVgvrCAT89jt8mox1sZaEKKQgaByPRS7lheR3AHKm3sEN1asUWjpxGur8=
X-Google-Smtp-Source: AGHT+IFIt4g5ozSJK8ZpqGGH00OsotOlIKbLyZg8UjetvQsF9VjKEqMlw2viq8FiAeogaNuA2C3SeQ==
X-Received: by 2002:a17:90b:3149:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-339c22147a0mr311510a91.10.1759426999797;
        Thu, 02 Oct 2025 10:43:19 -0700 (PDT)
Received: from gmail.com ([157.45.255.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a701c457sm5487828a91.23.2025.10.02.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:43:19 -0700 (PDT)
From: hariconscious@gmail.com
To: perex@perex.cz,
	tiwai@suse.com
Cc: khalid@kernel.org,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH] sound/core/seq: Initialize structure pointer to NULL to prevent undefined behavior
Date: Thu,  2 Oct 2025 23:13:00 +0530
Message-ID: <20251002174301.15512-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

This change ensures the structure pointer is explicitly initialized to
NULL,preventing potential access to uninitialized memory. It improves
code safety and avoids undefined behavior during pointer dereferencing.

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

Note:
Turned on the settings needed for sequencer MIDI and built a kernel
image with those settings. The system booted up fine with no errors.
However, couldn’t get the sequencer emulation to start.

 sound/core/seq/seq_midi_emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index 81d2ef5e5811..f24c5a475c41 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -647,7 +647,7 @@ static void snd_midi_channel_init(struct snd_midi_channel *p, int n)
  */
 static struct snd_midi_channel *snd_midi_channel_init_set(int n)
 {
-	struct snd_midi_channel *chan;
+	struct snd_midi_channel *chan = NULL;
 	int  i;
 
 	chan = kmalloc_array(n, sizeof(struct snd_midi_channel), GFP_KERNEL);
@@ -686,7 +686,7 @@ reset_all_channels(struct snd_midi_channel_set *chset)
  */
 struct snd_midi_channel_set *snd_midi_channel_alloc_set(int n)
 {
-	struct snd_midi_channel_set *chset;
+	struct snd_midi_channel_set *chset = NULL;
 
 	chset = kmalloc(sizeof(*chset), GFP_KERNEL);
 	if (chset) {

base-commit: 50c19e20ed2ef359cf155a39c8462b0a6351b9fa
-- 
2.43.0


