Return-Path: <linux-kernel+bounces-736142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CAB0995B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC11C4875E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE718CC1C;
	Fri, 18 Jul 2025 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhGv5knX"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA411712
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803018; cv=none; b=fug5DALO/hnc3GMOer4pr4ArG+xXze6VJLws/or4ig5hG/Cq/ucB6zeur3+X0ct1sr31k8lzgMvtwwnKZlRY2/d5mnc1S/xU59i/g37YND/QT7FFZDqdNSgEKJHRhHSODgS8Nnv0oS+O6bWDjh68s7rneU+B4uS7Vhm6JsWVA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803018; c=relaxed/simple;
	bh=sSF6GjXghc1GV1WEXBlQMli6JYp8FQUjuhEGOK+jmV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJ2uxbHbVppzlqBQlBRVo1zoeqLw5Ah2yH+8CE+pQ8EsR22yV6NxKNN4z7o4rgJN2r5riMMC5JD6W2+NLp9yqYLBq4+pXTzw32eyh5uenwMrGmjSERBNcH/dwNn19kccL8AuWV2qxHt+jYFLJO8oh5WKwQkdgQUgboUiCD1nPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhGv5knX; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d3f192a64eso160737385a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752803015; x=1753407815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9E48+RSFL0xRXR+VqTC2UOx+PBaYVhWXemQV/BSEEc=;
        b=RhGv5knXUhvBSrAka1mMb9pB/bQuU/KvZtkCw+/yuc+01CvSc9nDJ7bTOCukIZo/Gr
         NUa1TTs97zG8O/SIXm7mAYJfh42U9ypSyd9btqclFzvehXKFIHzw7WoLHWIDejx4WMlT
         IH/j3UPt506UZINICZBupiktyyO5iN70kHC1mMPnulnRErMZxFOsGDCncQMPncYCK+tO
         xrJ61US5MMobMFQZr8VA2RvleGC7tmbn/8ep913X5TqJGCx6pq3hug6v6lEjVERWe3c/
         WV7irolUIJH8PGkqGAowENJQtWf+IY8HNjJr+O+Q3qxYvbYQW+6BdaOo/69YRnOQlSCm
         rJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752803015; x=1753407815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9E48+RSFL0xRXR+VqTC2UOx+PBaYVhWXemQV/BSEEc=;
        b=cYcNV+DanmTye/9ZlMKDXSgx2/HDLqsJU1au0SUme68Mc1OPSOODyd7NThay/qy7f3
         cg0FIHZ58QM/A09dTFDFZoGTzm4B2Lcw7QMKBz6j2tjpA707Z1BwYZjARUIUJwCrPTvz
         QlK1ZIt+g1z2cfCmxFMxg1PIMFduxiCRp8yy1dq51VLXPC9ZfxLaivml42y4IoRaUROc
         G+WnNeOT2R5QqCwXYanUrjyp1ytFB3drVp+HoPHpuYNjv00tRr2NisU0wQmueP1RMkTn
         E3Nsw9htWxs6H0cbsMiBJJV22i1XgXYMRfdjpawlTbqCQZkRDAakK4VfZVidtJu4D42W
         PvfQ==
X-Gm-Message-State: AOJu0YyZ+TPon3Kmgp+V4j+o7pV4a7ESTyXlW6pASU0pyTJ/g8Du6mj3
	BFhfFfeyXQ9MiSFwlny4qWad7WyKHKOzPEhplleYCHnvmO9O/+869wYTOc6U7GZH
X-Gm-Gg: ASbGnct9vlXrWJnpMQWsa9PxjcYRVG/HjPK9XcxlVJc4ipCO47A7SF9UuboRPpUwpOf
	mGM8DnMzT5kfgLvDF3KokU7JZp0HsjsAAfHjrvJ8LnakUILkb1aVzl0jVeXAsOivuDhbl5Mjx4I
	t2seLzDCZ+kVRsU6meXRGxhIcy89hKDTOCLbGy6ODnuZkqnEcE7Swaqjcj/Qfyhz1d6TgNyunbf
	LBBQfPmyoWLaTyf9K4xqF+fSehimD1FufxrL8nRsWvee54CGBjk27MK1TvGyKm3KobuaJcc/vLx
	GvR4xdwcb/S+O0sTIoJainRHP5Ve7J07parldaia9w139bYP96/uClyZJcDSxjOyvUp1FVRpB3I
	pDX95/mxjeMUVmmInFQByoYERIpN2D+IgYZCLDo2+oBIIrNJPwpzHBNvQ5Ww86w==
X-Google-Smtp-Source: AGHT+IHvq2Jn74ZmTRcmHxloJ7o3ORCbDMig4qzYyh80VGhjs3oZzWsO2bJqlaYbqgKj1aOCYDEcOw==
X-Received: by 2002:a05:620a:5ac9:b0:7e0:f0bb:b1a4 with SMTP id af79cd13be357-7e34d91e4bdmr568679885a.27.1752803014554;
        Thu, 17 Jul 2025 18:43:34 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b6042esm33129485a.43.2025.07.17.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 18:43:34 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name
Date: Fri, 18 Jul 2025 01:43:08 +0000
Message-Id: <20250718014308.162275-1-vivek.balachandhar@gmail.com>
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


