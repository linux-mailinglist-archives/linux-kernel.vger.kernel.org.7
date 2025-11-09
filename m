Return-Path: <linux-kernel+bounces-891949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E386C43E37
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9E2B4E5A4F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67192F3601;
	Sun,  9 Nov 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMgoG7sp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D32EBDDC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692785; cv=none; b=XtqxxgRg0n88H1QPHc3hXfXBhd3Bi3WWH9Z4CVoydc01lv+85do8FAF7zs+fZet5rcRayH5pA13PMB1yTThx5aR+y4VBY/lJYgw6IhMEoh9i89Z7/tL8B22nfQog2lZYvYm8mDzshjwWDsStANxhEkoAAYulzG/mSOwMkOGNc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692785; c=relaxed/simple;
	bh=Wd53Qgttz8/HlKQBRCBgJT+eS7yPLn9ZSZ4MOrmxLtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pT6PIdEkq+TGC0YFQVtZj3b1dAKrQtXrweDRwRjteyieYinj4qG22ibIiAznCs+kdWRs6Xh3ARnJmwHzPT+A2BZAmWmMSRJox+mapCJ+m3knOa10+wfkPMYxbbI0G298Q/0a7aPUC8I66naOf7w0z7OIz1DVFZPZ24jQ+YQM5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMgoG7sp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b728a43e410so468745866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762692781; x=1763297581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6A/B+9h+I98s/YXTKbkuHwVutCPQptulwBnbhPRTRk=;
        b=QMgoG7sp7ZCgC1uoTQbOTDfQXJW3FoJY7fIqH3Ow0bZFopTbmsTkmxYCYbhbWElZSp
         Y+TqozfYDBGmo/Ob/johX266OJbtDLJndN+PFmGylivH8t48lsJbh09DmGpNZObMv6Yt
         k4P+jv7R3FxTNYdiMmWpwArzcrfYsYyZUpFzM8DDOK6XsEUZCrLRmd4LSgBijtfe33sG
         6P0QBUgDXweJBQJN8PhT4W4oPUC5Gs8MRQVLzZDaut0BedjwPtiqinwoQ/y58zSr/T+3
         tbMPn+ml83xGMwUbRqOH+Ur5mCwlTZUwwpYiozgL9XPrejql7e7Zw1Xy+w7owxtel4nf
         zDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692781; x=1763297581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6A/B+9h+I98s/YXTKbkuHwVutCPQptulwBnbhPRTRk=;
        b=Ww7tJ72+b4T1Rx6rRC9gwuNic5oc4xyOqwnO0omRV5KMLvuy82MgPfW2xp7oqYk2XJ
         G1l/wEhFozbQY+IP3yog2Hj96mNPX79kBpVbOPQNTivyEObIy3+4mMT4Csm+mUSwpN3l
         LGB4YI2TTwi1R7v6aobOGoplRG20nvPSE8tS0Za4cK4CrRZBODumoo7CO+Srmm77nKaH
         fHOptjg13NXJnADUPHyAGJxtGSYh+t5zfGc8AE4vGKzXHB3jtn/PqLxweNH0cfMv0N/W
         AJHx1dsCoKk4WOcKxjnn4+kEYfQsEyMaFOfStlA4Q6GRVkXhNP5QH0yikzcj+1Zt/h30
         vZTA==
X-Forwarded-Encrypted: i=1; AJvYcCWi/mS+tJbApXsmJYmbWMldJ+eFt73VQaVMcR47hJR8i0xW09300Is6LYJE/3hPtqlC4S458Mr4ECE33Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNC86Os6sYaS5rocgZRRKom5IqvIkSvFyXpQVhnu6hIHQhVXc
	Q57ZiE4GjxNfWblJozy07nLmMDYmkA91jGXv6f/F3/ijVH56YNuoOV70
X-Gm-Gg: ASbGncsqC0sA+ulJfBHKrn64Z0nAH7+wPoAB8O/2Kf8jHGmEJtW5XKhvhHm9qmHO1Nx
	B8XlgD/8FRAGF1ydbMaVVh8g4LqelIbYIwnmP97YpDXqK959ib8GSaSS7vp5MCz0VwfzD7/7psH
	UQksFD1hKI5M7wamchDmcQ8dm/8kcbIz8WGSa45eQuFBdQ8iFnCyx1jIslxhXtR2/9FCFLOu8P1
	d1g6OcPT7xbnR7J08YmJ7v6xrI4B9VASygHAESk7li8Rsx/IsXy1MBKyto4MiUKs40mG1S5yIto
	khdGKXOyH56wapEAuzrf7YVzgkC/Z64YX8E5g4cgOG0FRjWlpywPhrggURPiCgqYDHJNDNRGCSh
	7gyr3z/eGA4ArVJpMxq2khkyemNVzJQS5TWWOnukpWGsrOmUhjhVrK0WDbIJBF+x9NoMr4gWp78
	21ymyhJFsIE7O/J0cQ5tM+iMKNPdZkiQblsyUNwAb8JakuRSlMBq/neCr05uo=
X-Google-Smtp-Source: AGHT+IET1KPf2B7oL/QwV+UKZAET/LutOZL+3WDxwucKxa22W1E/RosCqKFp+QL/ZmCkc+0H1lrDlA==
X-Received: by 2002:a17:907:944a:b0:b6d:4f1d:8c9b with SMTP id a640c23a62f3a-b72e047b413mr384785566b.28.1762692780735;
        Sun, 09 Nov 2025 04:53:00 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d3c0sm822225766b.36.2025.11.09.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:52:59 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: touch predicts in do_dentry_open()
Date: Sun,  9 Nov 2025 13:52:54 +0100
Message-ID: <20251109125254.1288882-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helps out some of the asm, the routine is still a mess.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 1d73a17192da..2a2cf9007900 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -937,7 +937,7 @@ static int do_dentry_open(struct file *f,
 	}
 
 	error = security_file_open(f);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	/*
@@ -947,11 +947,11 @@ static int do_dentry_open(struct file *f,
 	 * pseudo file, this call will not change the mode.
 	 */
 	error = fsnotify_open_perm_and_set_mode(f);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	error = break_lease(file_inode(f), f->f_flags);
-	if (error)
+	if (unlikely(error))
 		goto cleanup_all;
 
 	/* normally all 3 are set; ->open() can clear them if needed */
-- 
2.48.1


