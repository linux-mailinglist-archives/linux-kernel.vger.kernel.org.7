Return-Path: <linux-kernel+bounces-736197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD5B099F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8044E1F65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2C1CD1E4;
	Fri, 18 Jul 2025 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT2t/mGZ"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197ED1C7013
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752807163; cv=none; b=j0af/dEIPHVBs8pSiQp00fGiww775TKnbV82dWdsT9VIDzlHEMpb8F1qnA4c4ZyZIQU+lpAOGzl1SoSWOGxPaqAzphMHtrunNOoURLJw6AkuGWY/HUuiYgVpp6JgOOi2FPqBRAlUQGb9Df3hSVLrJN+kKNDMbFXZtjxM+iDUeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752807163; c=relaxed/simple;
	bh=h9GGpNNIpEixTMir1PYqWvBLQrrlkuxtKIziA8p8SMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rh/IWBcGMOj1RECEoa2gi/FZUv4umrCJjGMfh3iDpqUen92UyY6nOYJzn9SKWEDA4APkRqkbt3wrtNoaJxwZ/wbK6qMuNG0wuLH2ILmUXw3/v6oBO23iEdqtu1CP+stVAG8rE0hdHyxlhxLb3Mzhnh2/9V9E/g5ZWamjE0m8x2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT2t/mGZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso22462196d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752807160; x=1753411960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDlXE/KCw2qSqLxnWSLl7l0n5eGJ5huDsYk4m27l4sE=;
        b=VT2t/mGZt85BnV3TY1IN8VPKUmbKWPh9ys/uMpuyQP2Ke1aZlH6+SHNXXi+JLVl4LE
         JXek7JWK2+t16W1IDVF4WznnztQDrN+ZiGAEWd4/DZmNt42zys27IWK/qi/T4h2uytZa
         5o4XpYCB5RNjkfW8Q9pN8odsH3l49EVfMVZAOoyB8tcgqvY9PwS4k4trQJcaANVOOUEo
         TmKC+WJj6YecM6BXFrdpME/gnF4fZ1xmGZaGHTLbcybo1m9J4uc3ElwAnsVRDf+1LxYP
         jTR2qacHOXCETt9tBttFTfl27S1CZGMNAYIXQWxHM6u+c+7jxBWpew+DTTXKU1lLSVK0
         +4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752807160; x=1753411960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDlXE/KCw2qSqLxnWSLl7l0n5eGJ5huDsYk4m27l4sE=;
        b=NZcpvBivzSKf7Zx18BEeEDhxXpl09ZXEpQs19QhVVIREZDrCqaTEWibmuK4jOlcTjh
         6iL+NnQ+3d36B3I4VGUX+QSW+kmxPjmeAsIHYg4OfYxc/tmnsd40/YgRty1xmVn+W0NJ
         3/yfANW6EIyIMqvSBdVMGVeSqtJaYAPatP4V/cPwAvOGHCqI3l5AxscZ/Hsk4AL+ovrP
         3NqA5CAXsC1aMiofAm5N7AnQOfafPuCnsn8mt1AwpPbRk5OgoQvrYWjfrk3ENfG2GVuk
         sBtqwRGLlq/3+qmnt6vn5bUIj3mUl//pUvvvZONy9nDyi2D/TGpwfG7pae41eHXLE6Or
         Hlag==
X-Forwarded-Encrypted: i=1; AJvYcCWz/LiH2109JbHZ1f7mbgPGdI8x1bYFzbR9d/pm3qHSN/s5souLh6SCP/oDVSdTmhdhpaGfjJkRoxOvOGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOd1aN0sK4Mi39jXmVfYZMCTnQoM02bUhMVCdBYNMfOAp8Dm3
	BUz4NHwPQzw/d7bTboB3ZnuYYEUDftwSvmoOzI6bof1A47LX+r1fSO4f
X-Gm-Gg: ASbGncude3WoGQre0PTA2OKfMGq179zOwp+Pqkahj11FZ5g1u2I+G61HhUAYheLIa70
	ykIjpLm5b6/ZLvxJI4ooN7tSdorzlJ93QLlCk0fkI9J4XL1RtxirADgUGdGFSfTMbjPheGj5sOu
	9wLqV4M+iCo4OqP1balFhTa/PMm66b22P3i0NcDbYJEaTn7wHAd2X0oAMh/40FoR57FuJP7tKIf
	14IloAdQ43AAzG8rI34BeKISxZZR0lybzXP5o8kcfNmh2X3NMFn3KlvacrgaYjZnG4s6PgXnasm
	Y2OyczunN6ajB6BJ746jWxSleyUmCyG4OVOUiII+wn3ANWIV5YsI1zRaMpox5uQT/ne5DOp5Zu9
	iNWLHin9V0BGpCcJmnwy4WJGXw3VheN6Lqpr8q8A6jQrO+hLULU0=
X-Google-Smtp-Source: AGHT+IHZtvH+GBGMsUktTpIH4Ks+9vJ3s3yC14qfjb2oKzvv4uW0x2T0ny6TWVGFGCML8OmP7FzqEw==
X-Received: by 2002:a05:6214:1bcc:b0:704:f7d8:7032 with SMTP id 6a1803df08f44-705055a32bemr84490596d6.23.1752807159696;
        Thu, 17 Jul 2025 19:52:39 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba9d63asm2710226d6.89.2025.07.17.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 19:52:39 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v5 1/1] staging: rtl8192u: Rename ChannelPlan to channel_plan and fix index name
Date: Fri, 18 Jul 2025 02:52:06 +0000
Message-Id: <20250718025206.171361-2-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250718025206.171361-1-vivek.balachandhar@gmail.com>
References: <20250718025206.171361-1-vivek.balachandhar@gmail.com>
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

v5:
- Renamed chan_plan_idx to chan per Dan Carpenter's feedback.
- Removed mistaken blank line addition in init/main.c.
- Removed unrelated changes to Makefile and init/main.c.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 0a60ef201..092f36383 100644
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
+static void rtl819x_set_channel_map(u8 chan, struct r8192_priv *priv)
 {
 	int i, max_chan = -1, min_chan = -1;
 	struct ieee80211_device *ieee = priv->ieee80211;
 
-	switch (channel_plan) {
+	switch (chan) {
 	case COUNTRY_CODE_FCC:
 	case COUNTRY_CODE_IC:
 	case COUNTRY_CODE_ETSI:
@@ -172,15 +172,17 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 				 "unknown rf chip, can't set channel map in function:%s()\n",
 				 __func__);
 		}
-		if (ChannelPlan[channel_plan].Len != 0) {
+		if (channel_plan[chan].Len != 0) {
 			/* Clear old channel map */
 			memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 			       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
 			/* Set new channel map */
-			for (i = 0; i < ChannelPlan[channel_plan].Len; i++) {
-				if (ChannelPlan[channel_plan].Channel[i] < min_chan || ChannelPlan[channel_plan].Channel[i] > max_chan)
+			for (i = 0; i < channel_plan[chan].Len; i++) {
+				if (channel_plan[chan].Channel[i] < min_chan ||
+					channel_plan[chan].Channel[i] > max_chan)
 					break;
-				GET_DOT11D_INFO(ieee)->channel_map[ChannelPlan[channel_plan].Channel[i]] = 1;
+				GET_DOT11D_INFO(ieee)->channel_map
+					[channel_plan[chan].Channel[i]] = 1;
 			}
 		}
 		break;
-- 
2.39.5


