Return-Path: <linux-kernel+bounces-736161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C208B09991
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56583A32C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F671A5B8B;
	Fri, 18 Jul 2025 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baHWlJnk"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99111198A2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804030; cv=none; b=UtOOGxhLYdLQCBWY2D8gDRRY/NqIy6z8PLxmiRX0ehQkoyN47bi7P2HlBTOEa7KWZT68PWzsCODFkuMfRwFp4cOHm9s0WLEgOX28gkx0Qq69idzmr31bhf1WjeOcvKSZnGMyH+yeVBnB7rYS62ykv9ViY+G0K+R056m44ckx4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804030; c=relaxed/simple;
	bh=RtGwBwsoM+YdBqJCMoMBjHu4AUT6wQVKiQgBOmsy2zk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=DoWD0gECVdj1BQGrXK9jkWov6+N8TVJXTz7dMp0F7rvkG/UmNbA+QEHYSkeHdkC3i1c58dtt/XjhJEPp3s2QhrH5meKyROAt8FoIyFUxu4xM6A16zMif3uQX7AHr2BBLq18umBNJ9kXOeYKOIajV0V7NhIj8ddqGAD63ll0pH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baHWlJnk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab3fb340e7so30504511cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752804027; x=1753408827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9COw14ata83P2hN7EoNI52jllfLH9udiIyK4NEOuRdc=;
        b=baHWlJnke7yEqAQ9HmSl1sTr2unkyL+T0tyjf5f3fPj4TccEBeha1qNPzR6o2GAMKq
         sYKUj/drUMfwVPzg91qWgq7VY5tO0DvWOx8+zgtqp9gtQ5rBxNCVwm1dnnoF+aq0xjgh
         tAD3KzEnieoteJPW8LteCpcxKp/ebCR9lxuph+/ojI8BXoqCa8FeS3ANW1enFq2pqJvd
         w9wyWmrY8n6y8Bi8WWV4CeSfiD/5muVwpTtACHiX4RB4laK1MTJ5wjbv/SCELu3HRp3t
         5eFiDkNcmPqqyyhlMmfTY4ZGfX/1J+j3tzNsceDCH11t8Rctwl4umaFgx2h/2/5lahZo
         c61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804027; x=1753408827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9COw14ata83P2hN7EoNI52jllfLH9udiIyK4NEOuRdc=;
        b=cpqtxJGPxNziCOlIJTygsHC6VZyrEYmaCI7qgG2XprEZPXFRM5iLKqFKHnFbMukNGC
         Tpa1Arvl/TTi1QNNcUlx1B5VL35BYpkdhQFi9+b0pWqf/rikjRIqYZex8wvVIei//Q4d
         wq3dFeNpu5rSIAGHcFtZ9JkXw0CiUoySS+ZAWYC6NYbIMlJRyf4ZDpAM0mmNH3fglNrA
         JMsgn/GYDDfCpT4B6VQbWnknBi8ZEq9ZP8/bbywYBXGfuu4mby0INoqnTm9Kjz0nPFPw
         m+TGz5s7+ELnJWD7nvBAdzSA9XFIYwz4h/BMWuZ5CvkBkX95QvRCRbmu6hogC3SjZgw7
         vLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1FTqDrHNu2U5Yk7EAevC07L7w5/7X+uksQ4CVB4wTmdIV12U50apmDbqPezoxmxVvLuJsllyO5bNGsaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwi90syG50gV989wo6SHrJYHJb4Z1RlfCN43SvrozgMQ2H4YW
	8s978CYllMQn4lrrzPEWgRUrrc+ze/W2hju0TpWgSrCFekKUPTFfHi3/
X-Gm-Gg: ASbGncutPPBJe60gStzxvDIwRMPyQHpeHCnqFap/ZgPM7bMIRpOdc1o2RfX4SoWREpL
	2TyvCiwRmFPgrK9utQVev6J/Frt0uIt6l2NKclYz0Vov+D4EWvh/MKnBolD3aV+sSF42XdxiaVC
	dRXKjQzbPvxOZSuigTo/daCy2jsARkOE41xun8GFWgEgC266K7r2dcjUfaC/0zMs9q6Y55pBO8N
	VBHYITb97xeW9EQVw24lauhjUt/KeyLXaYwd/rC88k0Mip7TfpGMGlkOo/ILHpcePH5ofounFOp
	dyvM/0TLjoZVInAjlrtxlVoPZqFZYP/od32gL2wOMSGksxErdA9cXqv72LRLetd535lz5UWHGPK
	RtOhcWQ9IkugJtABIj6Qvo9JTShBFbjZwaB/g0BetuBRskxEO9sM=
X-Google-Smtp-Source: AGHT+IFnuc6J+FrFQP9DOdmL4XTa6mu7FhA0kgysswrAIgU175zByPCXQT3aDqaALDIInWXrUeE/6Q==
X-Received: by 2002:a05:622a:1827:b0:4ab:5337:618e with SMTP id d75a77b69052e-4abb2caf197mr19548721cf.19.1752804027123;
        Thu, 17 Jul 2025 19:00:27 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49c7867sm1992201cf.32.2025.07.17.19.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:00:26 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name
Date: Fri, 18 Jul 2025 01:59:25 +0000
Message-Id: <20250718015925.162713-1-vivek.balachandhar@gmail.com>
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

v4:
- Tested and verified Makefile EXTRAVERSION removal does not break build
- Removed EXTRAVERSION = -vivek to keep version clean

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 Makefile                               |  2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 16 +++++++++-------
 init/main.c                            |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 997b67722..a31bb7e1c 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 1
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = 
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


