Return-Path: <linux-kernel+bounces-884780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C93C311D5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B5BE4E0291
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64882F0C46;
	Tue,  4 Nov 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgcPEZrE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF91F1513
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261691; cv=none; b=FoCZgnc/fz5cwfZj/UbdGd6LriUp9inuBERM3lYtndEGHerLHPju8RhRC/vtkAylH0hVo0Wsn199PPIAj73l4cKTbdxdGFmknv9cX6feKyOxtPLCKXWwqGicUEpZeEwzdxpOPEkXe5qTP78GecdabzPFA1uiskGZR2pJhVqjTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261691; c=relaxed/simple;
	bh=8+5gxCh668F3mF0KyhBhYmNThSSlsRvOAW4fyOGH/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbrOYFFYjF0zJ5UvhG71pFR4q5KHO2jHlH62HgooRCDkd2nxT2XVNdv7ve/Foe/v7GdOPon/jevvacfZIo1in3WDg2Q2DDqqb7A4ERgyPAzz56bm7eSTjEBz37AvmPnQBtOHdwz/RJi24PgQPoDvSJSyUMqgkhfe/0TApX/wlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgcPEZrE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so69671025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762261688; x=1762866488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa5CJj00Z6mNBnBUafBSEAE70PDhD8H7mdKui4WwIlQ=;
        b=BgcPEZrE+abRoWkcX4q9K29g7ILbKC6qVVxuQZU8j55PDpkhKfFu7blWwVFzA/fDuz
         McK+f+ZyM0jubBJuAG2NhdRQl/i4SYbfjMzkplqroxv3zRmHzGZUWsL+6uyWZSYcpJg2
         S5cjvJYVUIs0d+f08XmVi5y4ECXshOxCODtjZBn7Kokazpqbw0pyvBaK/M13mA7bcXI9
         fWvLH43KKx7EdG1rOKH6NcMpmERNGA49cd8stE7QX1+1U7vtaJZGNOqwEVEnJBOX6FZ2
         hhtfgKiVBJrEm14gr51pl3lrO0sxL2x1MiimqAvKGIbkCV7tLhzmMW8XuB80vA+FtxSC
         vtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261688; x=1762866488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa5CJj00Z6mNBnBUafBSEAE70PDhD8H7mdKui4WwIlQ=;
        b=uHhIdqwTPxXAJjaqqJbivXvYNUxrTeSoEe7PS3Rc5ooRRogmyejeTb/n2BCiy768f2
         eQsW3UOaX5Badjmokk37D9z326+aXglxxBY3+jF4G8b2yNT7gaZSAv+/56nxG0ZjFeGN
         EwnIFmk3uRRZ0SGSnxWhYLn6A+XCwz+dB6KZXAUK0Yh1mFVzBvIIwaVUr0BNSDE2A2ez
         yHQ2xiTj53mVs1qU5t3znwRpyiQwgXT1stVvHwW3aDYK6ycg6F0VMXhMg9Fz4fJ4+Pkj
         R8FpYVOqaUy0iVcGLZ4JpX/LOrD3z9+4IgEFUmnc8fhqup7nx2FTYjYbXJTpLGicZ1pO
         CofQ==
X-Gm-Message-State: AOJu0YzXzCqg2ck0Z6vdJvHr+kzBQh8GdJvnr3YsZ1KzLXYmHufoiYdq
	v3ZwQQklEc8pArirvKMyyr039MQXybs4mcPAG1jFT2W39fUNriOd5S92EI7E0AiahCk=
X-Gm-Gg: ASbGncsyXlONBlC2PPOkcwyp0KeNC2beWyPMeyw2N4c5hXrCoYNXWV55hD634WO3D1G
	28hwpahvLCmKfhXILTQ2tqSZVW/j5dgtFfZQdEXSlV1dydqY9VhRT6wbXORokggTkKVHyeFJQZl
	/lyddf0TbRDC8SVgIRZt0TB+nY7w+hxVhm5sh9i29qhafz+6lVVfQ04uq151m5x2t2jtN+Gg7QH
	yNLhwHTHgZ4APOdNZWF/15HmmGH750h3ZznpTuV17+JKT3DRpKrqveHRLrNHmiW9flmBG08CcFC
	KdAgABsDup12hydIx5ZT83yGYwGqIwT7KYDdv/1Mh1LmwADp7kCQGJ+uXHBIvgzTNruL2e8WSWz
	TQSp/Wsw3r/OGBAYwfILnOnONEW9wEsICDYldB0rW24tiqCcsFlxzL87V0dr0CEfteUUpZIA/Xo
	NK
X-Google-Smtp-Source: AGHT+IGz6V0F1bsEXB8aPRmEqMqtcqMbmrPgPF7sIkH71vU9791usOLQxoir1Yyrp2/7BuMeNg88QA==
X-Received: by 2002:a17:902:ea10:b0:295:6122:5c42 with SMTP id d9443c01a7336-29561225ee2mr139342945ad.24.1762261687638;
        Tue, 04 Nov 2025 05:08:07 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586fc86sm3013202b3a.44.2025.11.04.05.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:08:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5ACD1420A6A8; Tue, 04 Nov 2025 20:07:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Balbir Singh <bsingharora@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: taskstats: Reindent payload kinds list
Date: Tue,  4 Nov 2025 20:07:50 +0700
Message-ID: <20251104130751.22755-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=bagasdotme@gmail.com; h=from:subject; bh=8+5gxCh668F3mF0KyhBhYmNThSSlsRvOAW4fyOGH/Tg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmcvxzlTBl07Ga5Mk5OnTlr2Tnppbzb+fRkbRmbLnHV/ fj/f799RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSnsfwV+ptxYGmor2/xeaG 9e8KFy4qVZn0ZneklFJzMWdPJlcrE8M/q4dhCyr7JV3ORWT9WJr2etXqln8m3z5G8OtxqvkwMU/ lAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Payload kinds list text is indented at the first text column, rather
than aligned to the list number. As an effect, the third item becomes
sublist of second item's third sublist item (TASKTYPE_TYPE_STATS).

Reindent the list text.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/accounting/taskstats.rst | 52 +++++++++++++-------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/Documentation/accounting/taskstats.rst b/Documentation/accounting/taskstats.rst
index 2a28b7f55c103e..173c1e7bf5efa4 100644
--- a/Documentation/accounting/taskstats.rst
+++ b/Documentation/accounting/taskstats.rst
@@ -76,41 +76,43 @@ The messages are in the format::
 The taskstats payload is one of the following three kinds:
 
 1. Commands: Sent from user to kernel. Commands to get data on
-a pid/tgid consist of one attribute, of type TASKSTATS_CMD_ATTR_PID/TGID,
-containing a u32 pid or tgid in the attribute payload. The pid/tgid denotes
-the task/process for which userspace wants statistics.
+   a pid/tgid consist of one attribute, of type TASKSTATS_CMD_ATTR_PID/TGID,
+   containing a u32 pid or tgid in the attribute payload. The pid/tgid denotes
+   the task/process for which userspace wants statistics.
 
-Commands to register/deregister interest in exit data from a set of cpus
-consist of one attribute, of type
-TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK and contain a cpumask in the
-attribute payload. The cpumask is specified as an ascii string of
-comma-separated cpu ranges e.g. to listen to exit data from cpus 1,2,3,5,7,8
-the cpumask would be "1-3,5,7-8". If userspace forgets to deregister interest
-in cpus before closing the listening socket, the kernel cleans up its interest
-set over time. However, for the sake of efficiency, an explicit deregistration
-is advisable.
+   Commands to register/deregister interest in exit data from a set of cpus
+   consist of one attribute, of type
+   TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK and contain a cpumask in the
+   attribute payload. The cpumask is specified as an ascii string of
+   comma-separated cpu ranges e.g. to listen to exit data from cpus 1,2,3,5,7,8
+   the cpumask would be "1-3,5,7-8". If userspace forgets to deregister
+   interest in cpus before closing the listening socket, the kernel cleans up
+   its interest set over time. However, for the sake of efficiency, an explicit
+   deregistration is advisable.
 
 2. Response for a command: sent from the kernel in response to a userspace
-command. The payload is a series of three attributes of type:
+   command. The payload is a series of three attributes of type:
 
-a) TASKSTATS_TYPE_AGGR_PID/TGID : attribute containing no payload but indicates
-a pid/tgid will be followed by some stats.
+   a) TASKSTATS_TYPE_AGGR_PID/TGID: attribute containing no payload but
+      indicates a pid/tgid will be followed by some stats.
 
-b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose stats
-are being returned.
+   b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose
+      stats are being returned.
 
-c) TASKSTATS_TYPE_STATS: attribute with a struct taskstats as payload. The
-same structure is used for both per-pid and per-tgid stats.
+   c) TASKSTATS_TYPE_STATS: attribute with a struct taskstats as payload. The
+      same structure is used for both per-pid and per-tgid stats.
 
 3. New message sent by kernel whenever a task exits. The payload consists of a
    series of attributes of the following type:
 
-a) TASKSTATS_TYPE_AGGR_PID: indicates next two attributes will be pid+stats
-b) TASKSTATS_TYPE_PID: contains exiting task's pid
-c) TASKSTATS_TYPE_STATS: contains the exiting task's per-pid stats
-d) TASKSTATS_TYPE_AGGR_TGID: indicates next two attributes will be tgid+stats
-e) TASKSTATS_TYPE_TGID: contains tgid of process to which task belongs
-f) TASKSTATS_TYPE_STATS: contains the per-tgid stats for exiting task's process
+   a) TASKSTATS_TYPE_AGGR_PID: indicates next two attributes will be pid+stats
+   b) TASKSTATS_TYPE_PID: contains exiting task's pid
+   c) TASKSTATS_TYPE_STATS: contains the exiting task's per-pid stats
+   d) TASKSTATS_TYPE_AGGR_TGID: indicates next two attributes will be
+      tgid+stats
+   e) TASKSTATS_TYPE_TGID: contains tgid of process to which task belongs
+   f) TASKSTATS_TYPE_STATS: contains the per-tgid stats for exiting task's
+      process
 
 
 per-tgid stats

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


