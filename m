Return-Path: <linux-kernel+bounces-875491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10BC1919B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BCF1CC3F45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276B32ED4B;
	Wed, 29 Oct 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuycjSt7"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285A3218A6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726391; cv=none; b=jAlY/ozncrOXFUPLGwIc7Epe3Q0k3DqDj9mnoF3XJ7tBbLjRLKfRXOjSEDq4+jyRJdMcNELR1OgStvLhcuaZaZiVLp1HLzxvskcxMZwmM9M6lTdbwflFEDVPMBz0GtFDPIKRqqW5tG/H173TauTwXahFtVvR97VRxJHKBu9HxF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726391; c=relaxed/simple;
	bh=4MPxuhmy5nJtQg44BOr1viQz0zlGXaFe6yyLuJ1q6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3QWUIuyxcqit9yQtK8ezIxA3S0s+XPWIRru7tiZGlnXZ9E1oVMD1jP3FpE1PwRZapa+iCfB4uYvxn7ZN/cqhRBS7gz1rH0QNoiWa0bF4yQ1LgMfv7VL9EIKdLMdDVwgZ+6y1y8bv1ZkOVvXUrhpocZ/+fq+B9xL2rRs/YAIIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuycjSt7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a26ea3bf76so9191749b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726389; x=1762331189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmJgtaD3VOE42H71f0f9vmdpsFlxWZJ2RsN6RcT0X7I=;
        b=kuycjSt7V9+qt7ZB34ktqd57aCR05Ues8/gXb5ClE0Zt0Y9/B9thp3u8Aie15UZkm1
         UfctvafGf4Am2jdlEpd32g0xSDcHSmqVtvkRc5xjisru63shIAUzF8lYJToYCDhnBBRc
         z9DjZLCtrE0YiDQVovL0JbnDM+fNWGIaMHxfquwBrtkI3G8ozdvo7P1xh56fpaax39zY
         5FuXT9uFrK9PEzYjMVKlEBOZ1zS3ZR1sn3wDzsTnzpvovlVxP5gNiNkJZsjAffY6ovjM
         7LZ0oY+s65eNWFCuZEAWCbPsti1QtaS6GfOfydLiY4Cc/olBebvmQNmwmt9wgxRTNiF3
         kNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726389; x=1762331189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmJgtaD3VOE42H71f0f9vmdpsFlxWZJ2RsN6RcT0X7I=;
        b=Q42QhiB2AlbyWfl48ADDw3/m0KPjsRxAp4GYX15TKCsxhxqr+ZwRUecYGLp+jtcu3S
         1elejjaOJSIqWWMGJPUnMSTRJ318UvYX7U1YsCLjgs2Ze76WnnKMngOb/HXgAHYBEMZf
         V3oddkvhY3F28RGwypKVD1huXH7CZCAqidrpjkqEAJD5gmT2XARqh34L52fneSkgv20c
         NAAc8qdx7jQT19LaWIVUSS7A3f9s/2IbvpQ7VBGStbiABnS81le7+xLC4Nkj+toE01hR
         sN8HSYJI4Zj50pz3xIkEHpxwrcBc1KEqeRLqaJNCZOtmzZeU/VUItwC5X12o1XyxF2+f
         7Y/w==
X-Gm-Message-State: AOJu0YyqsFuG2PRdM2PktJuSg85OJNe2KmJBrRjP34itooqRlAhZZ+DZ
	u6KPgQ8aSdfq+PhYHEo+DYSaViIQrtMwfVyTLrG332MecEA+jnMJeDn3
X-Gm-Gg: ASbGncu1O84uenL0iEhyVe9Ax9DA1ngxV/vvRQ+hArdN0KewjvMvGd7Gb+C2qMfxwrg
	8sja6O+iOzlXVwkLbbY6XlMrYVFgUgFDLcI5U8GGbY80/5m0RHHZVpadFWIkGN8Smy2dT+SkJFU
	qN82zFV76BmeVPnIFoQT0R9gX3LNKkd/+Jp1/cuR3kcESYSvO3tGk3WynWkcqR5IGOe0cxdb9DE
	qlT9W3jIQWhVLaqvAP5Ob7nS0XYMYHn+h5DiRl/s0Bj5B6a5o9FMV9Xm5vd8gHtbtXQnqR8utJX
	rnWbEZot1ZCXVBFirS72GaQI2bDfQq+J7y85dJiI/RGRFN4KWiqTvVi/Ps+XPI4fOka2XC/f6WP
	pz6AKleSC0PVckJ9vuYFTQEULIC4a7UuazNgLD51J8tjzTKzA3YQtezuuXFdIBOnN2+9Gc0S1HD
	9oB9Bj0JObrDc=
X-Google-Smtp-Source: AGHT+IEaWHg5ICq6Q4nvgM2fkEUKMxN3d+EvOaH9Z/76/nQrMU6XkXCcuh45+9ekQqeyE37MxMHcrA==
X-Received: by 2002:a05:6a21:6da1:b0:341:77c4:bf0b with SMTP id adf61e73a8af0-34659c310afmr2602056637.42.1761726388965;
        Wed, 29 Oct 2025 01:26:28 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm14342488b3a.28.2025.10.29.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A426941FA3A3; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 4/6] Documentation: xfrm_sync: Properly reindent list text
Date: Wed, 29 Oct 2025 15:26:12 +0700
Message-ID: <20251029082615.39518-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5839; i=bagasdotme@gmail.com; h=from:subject; bh=4MPxuhmy5nJtQg44BOr1viQz0zlGXaFe6yyLuJ1q6mM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM5zXiHXZevr6TNeZM9pGJ5wOEN2id92Sc1ZCY+NZPX fjPVN6qjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExk93GG/6XBxeI/2ibH3t+5 vKTtU7Eym1CrzszYxdNfXlfOtJ6+RpbhN+vE0y7q55p+HDXNOnQwV0GE2TBAUWJHdkOIStHc7j/ buQE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

List texts are currently aligned at the start of column, rather than
after the list marker. Reindent them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 77 +++++++++++++-------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index 6246503ceab2d2..c811c3edfa571a 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -88,23 +88,23 @@ to get notified of these events.
 
 a) byte value (XFRMA_LTIME_VAL)
 
-This TLV carries the running/current counter for byte lifetime since
-last event.
+   This TLV carries the running/current counter for byte lifetime since
+   last event.
 
-b)replay value (XFRMA_REPLAY_VAL)
+b) replay value (XFRMA_REPLAY_VAL)
 
-This TLV carries the running/current counter for replay sequence since
-last event.
+   This TLV carries the running/current counter for replay sequence since
+   last event.
 
-c)replay threshold (XFRMA_REPLAY_THRESH)
+c) replay threshold (XFRMA_REPLAY_THRESH)
 
-This TLV carries the threshold being used by the kernel to trigger events
-when the replay sequence is exceeded.
+   This TLV carries the threshold being used by the kernel to trigger events
+   when the replay sequence is exceeded.
 
 d) expiry timer (XFRMA_ETIMER_THRESH)
 
-This is a timer value in milliseconds which is used as the nagle
-value to rate limit the events.
+   This is a timer value in milliseconds which is used as the nagle
+   value to rate limit the events.
 
 3) Default configurations for the parameters:
 ---------------------------------------------
@@ -121,12 +121,14 @@ in case they are not specified.
 the two sysctls/proc entries are:
 
 a) /proc/sys/net/core/sysctl_xfrm_aevent_etime
-used to provide default values for the XFRMA_ETIMER_THRESH in incremental
-units of time of 100ms. The default is 10 (1 second)
+
+   Used to provide default values for the XFRMA_ETIMER_THRESH in incremental
+   units of time of 100ms. The default is 10 (1 second)
 
 b) /proc/sys/net/core/sysctl_xfrm_aevent_rseqth
-used to provide default values for XFRMA_REPLAY_THRESH parameter
-in incremental packet count. The default is two packets.
+
+   Used to provide default values for XFRMA_REPLAY_THRESH parameter
+   in incremental packet count. The default is two packets.
 
 4) Message types
 ----------------
@@ -134,42 +136,43 @@ in incremental packet count. The default is two packets.
 a) XFRM_MSG_GETAE issued by user-->kernel.
    XFRM_MSG_GETAE does not carry any TLVs.
 
-The response is a XFRM_MSG_NEWAE which is formatted based on what
-XFRM_MSG_GETAE queried for.
+   The response is a XFRM_MSG_NEWAE which is formatted based on what
+   XFRM_MSG_GETAE queried for.
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
-* if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
-* if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
+   The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+
+     * if XFRM_AE_RTHR flag is set, then XFRMA_REPLAY_THRESH is also retrieved
+     * if XFRM_AE_ETHR flag is set, then XFRMA_ETIMER_THRESH is also retrieved
 
 b) XFRM_MSG_NEWAE is issued by either user space to configure
    or kernel to announce events or respond to a XFRM_MSG_GETAE.
 
-i) user --> kernel to configure a specific SA.
+   i) user --> kernel to configure a specific SA.
 
-any of the values or threshold parameters can be updated by passing the
-appropriate TLV.
+      any of the values or threshold parameters can be updated by passing the
+      appropriate TLV.
 
-A response is issued back to the sender in user space to indicate success
-or failure.
+      A response is issued back to the sender in user space to indicate success
+      or failure.
 
-In the case of success, additionally an event with
-XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
+      In the case of success, additionally an event with
+      XFRM_MSG_NEWAE is also issued to any listeners as described in iii).
 
-ii) kernel->user direction as a response to XFRM_MSG_GETAE
+   ii) kernel->user direction as a response to XFRM_MSG_GETAE
 
-The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+       The response will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-The threshold TLVs will be included if explicitly requested in
-the XFRM_MSG_GETAE message.
+       The threshold TLVs will be included if explicitly requested in
+       the XFRM_MSG_GETAE message.
 
-iii) kernel->user to report as event if someone sets any values or
-     thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
-     In such a case XFRM_AE_CU flag is set to inform the user that
-     the change happened as a result of an update.
-     The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
+   iii) kernel->user to report as event if someone sets any values or
+        thresholds for an SA using XFRM_MSG_NEWAE (as described in #i above).
+        In such a case XFRM_AE_CU flag is set to inform the user that
+        the change happened as a result of an update.
+        The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-iv) kernel->user to report event when replay threshold or a timeout
-    is exceeded.
+   iv) kernel->user to report event when replay threshold or a timeout
+       is exceeded.
 
 In such a case either XFRM_AE_CR (replay exceeded) or XFRM_AE_CE (timeout
 happened) is set to inform the user what happened.
-- 
An old man doll... just what I always wanted! - Clara


