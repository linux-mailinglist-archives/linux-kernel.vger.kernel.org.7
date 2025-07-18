Return-Path: <linux-kernel+bounces-736145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A711B09960
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAFE4A4535
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48751191F89;
	Fri, 18 Jul 2025 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX6pw7b2"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80A52F88
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803429; cv=none; b=m+O6EWZrh7MefIVjTwrLiALt4qTBYvTf+HXz7YQpEm2KeeFCWs42Q4ilgJxv3ah6pBkNH2EmXhWroF4pF4IMNCVuFYN6gO2qWYetoQ0uTgRDJFYpILSHVxiSZjYH4pKy0RXNIJ8HLy5QyUZw8kg2Ioz9/JSDoZ3pZ820a8dF8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803429; c=relaxed/simple;
	bh=sSF6GjXghc1GV1WEXBlQMli6JYp8FQUjuhEGOK+jmV0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=L+ajxNQLk17o2hybyDEArjQie+XO9Zrxo5bFp5Dkwj1KGHcMhSWZY41AOeWIWtvrgDms7B8ma2WH/GHXBOfwbmYZp+caABHmPnyrgkB/rakJDMB0NDK8DMlwtuK4LO1D/yNJOnlgHcZPLwmMU85digAjlvgZsfPhGl36Zaak31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX6pw7b2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-7050bc6bea9so10397986d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752803427; x=1753408227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9E48+RSFL0xRXR+VqTC2UOx+PBaYVhWXemQV/BSEEc=;
        b=FX6pw7b2nTTuHoB2XmuzDGKCTF8iuduF+mLhEjJw5olcwYb1MNqWfGpNY75X+VeIXM
         DnpHq6H0R+rQ9ipmfUDPK89hvmp7lWWtVNlU8JO/JrxHOKmVfDdmYEUeLdtNgFUJhIe8
         pui8kvqf6ZAM9Wzl1BrlXNSfTyU3vJZ9nf+wHOkWajZbIWDZBc4a1IIO+IsJ71PiZOCv
         lnUAZPV8vMPnv/g8JU4Rp8en+XcLOjD1haUCClTAdjimFDp1500iQ4GmyXrA2x1ZC1EF
         l5tQNfxwBN09VTx1EUgXS401Z5ZgxePh0RhSeM+xNCfZIjzZiphd6zGKKdYaLsH6B2nS
         3w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752803427; x=1753408227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9E48+RSFL0xRXR+VqTC2UOx+PBaYVhWXemQV/BSEEc=;
        b=owbFpN9s+q8pw9agH0pf24cT6qY+1UtkH60CU49xjsq2MuxAOG+oqSWlQjLjiyC47r
         zm0nwP3LXDm8AXPeX7YWeAgU47qPa9TNooghE5CUPhkcX8U+TNGxAqvKCIj1hQy0vhKq
         25PT13VW07Lnii82tIoMEHO5V5PduHC2LW2LbNR1OT/vJXu6dTaige2WKRg2U3cJBVky
         gYO4ksBFKwWdmO+yhPjcsGR7RqZzRQybPr6m71C6bDLl3HiverjL4DSHaaGVDEQDaa5z
         JF3HiQbRb7QvnLC4Dau76UMUJW7hdWTcXTqOox4R0djrkw5U3KthfuXRWkeiuVNu/1ad
         h1sg==
X-Forwarded-Encrypted: i=1; AJvYcCU2fET+U65LzjeaIDk1r71FEiyGhseSTAMsReJbb+amUuzOEHUtI5dLevd1PnF7PGjSfM5+mLHNb/ZmhCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0b7zpFtqFPZMxQYhm1SqdJWzS565pz/YvZp9erD+TAuKj6HpJ
	3glSzPIsWAfxqM03INmDSWnolYmz1bjJi2P9mE/jdKfzEsZ9z/uoT2kQ
X-Gm-Gg: ASbGncvpy01qLcsaMc/pKR4CcnhnFZhRroud1kJBz+eIitdWDqLTiLeUtaydvNU32AP
	SUFN22HhoHIOubFIAvtbK0POsXY7xYuWAKFN92bn6WvIY30L7dqC/2tH0TCCuZ0PIllN8v2UvO1
	PmrVaycICd8vv2cTxjq/LnpKpkFoyWe/be1mZapA4kxw4WgbTO2Gd6yd1+koL+bmhEb7tfpuucs
	ZG4rYU1js2jyT7bN1VJPlQaQ+7gqbouigPBs4l+4UWNhUo9+/6GMcn60dKQhaA1yLpFyK0Aao54
	qhNcWXT7qSLvEXHvbH4qhRAZ1/3VGSN2I1D7UQmu+OCYv83oos1FVv7C3Th6r7yk6lxxTHpqbfe
	OTMVhWrutLlFdzsz32BDKXY4Xbd2vBxpi+Iuv6f8qiRXN7tM5pG0=
X-Google-Smtp-Source: AGHT+IH55WzzyvdjqHRW4WZoHyOXVFM7C0T9IzB9E+IGDC1bOrHif/PaQbxEfy9s6FhjkBb17LmKsw==
X-Received: by 2002:ad4:5d4c:0:b0:6fb:43d:65b7 with SMTP id 6a1803df08f44-704f6b46a96mr159069076d6.36.1752803426925;
        Thu, 17 Jul 2025 18:50:26 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b907181sm2372176d6.36.2025.07.17.18.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 18:50:26 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH v2] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name
Date: Fri, 18 Jul 2025 01:49:47 +0000
Message-Id: <20250718014947.162423-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch renames the global array ChannelPlan to channel_plan
to follow Linux kernel coding style. Also renamed the index
variable from channel_plan to chan_plan_idx to avoid
shadowing and improve readability.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 Makefile                               |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 16 +++++++++-------
 init/main.c                            |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 997b67722..93b6fa091 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 1
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -vivek
 NAME = Hurr durr I'ma ninja sloth
 
 # *DOCUMENTATION*
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef201..b449d0d96 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -120,7 +120,7 @@ struct CHANNEL_LIST {
 	u8	Len;
 };
 
-static struct CHANNEL_LIST ChannelPlan[] = {
+static struct CHANNEL_LIST channel_plan[] = {
 	/* FCC */
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 36, 40, 44, 48, 52, 56, 60, 64, 149, 153, 157, 161, 165}, 24},
 	/* IC */
@@ -145,12 +145,12 @@ static struct CHANNEL_LIST ChannelPlan[] = {
 	{{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}, 14}
 };
 
-static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
+static void rtl819x_set_channel_map(u8 chan_plan_idx, struct r8192_priv *priv)
 {
 	int i, max_chan = -1, min_chan = -1;
 	struct ieee80211_device *ieee = priv->ieee80211;
 
-	switch (channel_plan) {
+	switch (chan_plan_idx) {
 	case COUNTRY_CODE_FCC:
 	case COUNTRY_CODE_IC:
 	case COUNTRY_CODE_ETSI:
@@ -172,15 +172,17 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 				 "unknown rf chip, can't set channel map in function:%s()\n",
 				 __func__);
 		}
-		if (ChannelPlan[channel_plan].Len != 0) {
+		if (channel_plan[chan_plan_idx].Len != 0) {
 			/* Clear old channel map */
 			memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 			       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
 			/* Set new channel map */
-			for (i = 0; i < ChannelPlan[channel_plan].Len; i++) {
-				if (ChannelPlan[channel_plan].Channel[i] < min_chan || ChannelPlan[channel_plan].Channel[i] > max_chan)
+			for (i = 0; i < channel_plan[chan_plan_idx].Len; i++) {
+				if (channel_plan[chan_plan_idx].Channel[i] < min_chan ||
+					channel_plan[chan_plan_idx].Channel[i] > max_chan)
 					break;
-				GET_DOT11D_INFO(ieee)->channel_map[ChannelPlan[channel_plan].Channel[i]] = 1;
+				GET_DOT11D_INFO(ieee)->channel_map
+					[channel_plan[chan_plan_idx].Channel[i]] = 1;
 			}
 		}
 		break;
diff --git a/init/main.c b/init/main.c
index aa21add5f..648589720 100644
--- a/init/main.c
+++ b/init/main.c
@@ -680,6 +680,7 @@ static void __init setup_command_line(char *command_line)
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
 
+
 noinline void __ref rest_init(void)
 {
 	struct task_struct *tsk;
-- 
2.39.5


