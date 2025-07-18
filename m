Return-Path: <linux-kernel+bounces-736152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69075B09972
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30197A4049F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548F191F89;
	Fri, 18 Jul 2025 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJD4Iw9j"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A74145A1F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803754; cv=none; b=n4XumF6s10E8ZM2l5rUjzEJ8GXGFQgppzz7IUCv8d/2MLQx0+PZ32zwT2TD3KejDo7aWYsYBH6qy1LumOJR778wd/YUZSAXSwOHMFR6DrYhYncetVtPbs+MeJhoDmMI/QBTiRz8DL1SzO8jhQ5mD1FS5cMjToK6S6hK4COS6ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803754; c=relaxed/simple;
	bh=20DCxdKAsTeDjS+r8T+9Ikr6q/ALKVAVb135jUfAnEA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kZiMM7OHQte1Q/1I2nwv4xCLrJvydSWpzb40jZ2RQd07bZPdC+HqVYRHb/6oyHIrPvIp8CeFcSqzvZmKXa/nYo4KKHyglkf7XuSws2gIKB/6T83O1bsDk9tkv5/Qe1ag9Zcdss20sH8eOp07giYHU7jxJEx8nrtdFV7AlW39lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJD4Iw9j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e278d8345aso157681985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752803752; x=1753408552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtFfofjayrjeKW0qhDCX7H6D6mu8v6iNbOK27WV8o6I=;
        b=VJD4Iw9jhgswt+8iM+9+e0naeuXwXOWuVwAu31abJFUlg6Z6zSzDtvjsE1Xsyp/UnS
         pif3A1PCCKWgIP817XP+/nrA8qHF+hWLZ842WNJhfPZ+JS0WU64uJ6zrqyC6ZqeL9AFF
         LZDq6rvRIrrN8Xl98R0QdOnezThB09xl8fOfwhV2TA3601Yo8ithn0F1zB0waqcKoPiA
         2Rh+dZuKQbnGgyajUj7ZQaDQRLxpGtm1HK3N2AAE1lxn3rM4AR9TkdYB5Hi9XFSuC5bP
         C6JmrhBAPZwM8VRsnB9fGOKbxl87yvfKhHrEpmE6zBMV0fHVkLirSwq+a7KFKFEXjU4f
         XsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752803752; x=1753408552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtFfofjayrjeKW0qhDCX7H6D6mu8v6iNbOK27WV8o6I=;
        b=DMmE2ArRbfcfDqjJ+fTUrdHe/Oewqd5IKjXzaBnffHUBQolxxWkjTgjYN8edKMY133
         2rsrOomox/ZU+ZKRoP+0xF/Cd02YRwl66ZvAMUInNwH91t0WFxwq5x3beB6dBYEzlMQb
         0+NC/iUnmOQAfWsI1q5yDxbCmynKfYEGjgVhcCEt7GRKZ2nSuvC4sryjyBKwiB16Piu4
         wCqzH109aTgmDt1YtB2prntS+HzxMXf3ypJg5wLRy2uaSCRlNzoVoLA+c902KRMbnFlM
         zuk9NzBaLaotsD/0A/+jA8t+yuUCbeYryzTrGW5zz+AVXdn1R0jzBAC1y0PD5CFoeTj0
         1ekw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSpqKOclKq0M1aKXrKVzrUusALtKOtsKcODTlhUsbn5Nvipnk4SqjvjC86dWv7q9b7/fjeKEKuIo9yCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQT15GACzZkhsBhbmQsKkODTt8XiNn/gRHWeEPIwTgspsjgPr9
	3gH269h0+ErTJgtZCdFEd0895AA/54jsK4vpbPSjKuPPuq6l/u6FDia+J4M8J6zb
X-Gm-Gg: ASbGnctGQn4m9YwzSctdjytxEcw5j4TuGG5OZL5yE3usA9nPnqvfGbQFX7Tmg2UEBC4
	fA3TEX9FM4Ol3HnXr6iU/63A45a0c7lTr4HbcO5jZnRM82tnc0M0dgodG+h6fg30T6Oa4NpAHAZ
	WUeR3fBQ76gEg3b+BDOP4ENVQsLAdGBQj8fxY5o/93keyOaRwowE7Po4zU9MirUrxq8eqzD3CDW
	CaUHY21PwhZxY95lzRlzzs0vRgEHjbtBmcvN+X+l7nhttIeKcPlM8vD8ur1PTmGLdje9m+Xq/c8
	+UZm8C0PiSbW9L8mXbvqDcQ1q2yKmQHZehqi9L2l8wc3ZB6BmbPIjOT0hb9mYs9RiA44KERmaA3
	Tp9qrpAhe1kKfVt4xX4UcnJ2j0mKevEGobszzBiJDIu4Bwkn42wE=
X-Google-Smtp-Source: AGHT+IGlnfcl2f5QuL0UPlHYoxnPncK/CJRs0DM1FsmO46euhoYOdzFtKOhBp++MjORv8Dvtbxekcg==
X-Received: by 2002:a05:620a:2915:b0:7e3:3699:f3fa with SMTP id af79cd13be357-7e343658639mr1369121885a.58.1752803751815;
        Thu, 17 Jul 2025 18:55:51 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3e32fsm32479985a.52.2025.07.17.18.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 18:55:51 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name
Date: Fri, 18 Jul 2025 01:55:25 +0000
Message-Id: <20250718015525.162561-1-vivek.balachandhar@gmail.com>
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

v2:
- Fixed Cc list to include Greg and staging list

v3:
- Removed EXTRAVERSION = -vivek from Makefile.
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


