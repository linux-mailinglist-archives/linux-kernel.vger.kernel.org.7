Return-Path: <linux-kernel+bounces-826419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E19B8E7D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294601777A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740A2DC780;
	Sun, 21 Sep 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nphpGejE"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66426E708
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491788; cv=none; b=VdebA1bStgRDLPzwBPT+wxmFVoW5ojc8UIWyXy0gG46qNGacOpse1USVgO+8nZxDu9d94SI5wxFqVkMevZtyj/YClsenMPTJ7nkbLuaUqsaXpFEBUsz8oafgAK1hNzkhN+5i9Q5DJZH29Z5m7/HeJN7VhJmkl74SIZOQOZ6lvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491788; c=relaxed/simple;
	bh=eG/wddCuyCwaUxobhxivrMgFJ0iPulanstbx9NkmFWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXUXMPILZ4da/Q+0VMPPckVo3fLaxOzmVtIuv6rMmiAnD5iPXaE2snPNbGSi5rWzuHUpPiLDswEeIjb7I9tqA+OiMgqCxknK+mj9WjW0brOvVoXhmRBJufI2gb8wnHA5rJOr93Qtx1EMGFt1amzebvBKqz/ih7mgGKbcFytGPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nphpGejE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2cf99bbbso17165945e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491784; x=1759096584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ourFaYJ9tj+096hrV6X7BfBF4z5jW4POqWI8u8yvTF4=;
        b=nphpGejE0Ag7o4AcWV1T7WXnM/q4SqavvEtxoOgh1x2J+AWB7bSj+d2QEqDbzliPcU
         1muJr/T5OzGlCO1M1teG0BJd6Vstpcpaza8J08hipvuo4wXNHfnKgYijnREs3WBtgLs6
         VgRG7cn90vuYn13Ko9yQUWeqoMALFdPwirV7hqa/vbW5/XkhKFC025qSwOdRiNptsiyU
         RpPCXmpCyec/OmkurdNdK8mMAPH+/RwbiFc3ZTQTYnRV/VnzC5Xs8DUJrLfHxjqZm9dY
         YdaLbF3vHm7XD0FwBcMyHaXuqQw4PE38/Tb8Hlm8yuHRf8/IwmqwXaRILpjgOoMaXeoe
         cB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491784; x=1759096584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ourFaYJ9tj+096hrV6X7BfBF4z5jW4POqWI8u8yvTF4=;
        b=Y+KH6uIJyjY58eCRVmJ24ddyzZvdqCYxsAMykNhn6bZDj1Mzm+tEjG9Qq7s4EtTbq2
         lpW/qAHTJJyxiXFUg+P52YVqtY1T0kdtMYVbloRyxSZlbeyQj+R0CscD/d7pGxdo5lXN
         c6b7Tw1fzHb11Ct/71MGycGbcOiIj1jVTZxYqy3vhaIEBuVSUbqthxFlCCze5fpvN95w
         nYrTvlBraxyTLBPUzagYGJe0VA/4Nr+XUkjyGXz3rLfzUdwUxIEE9PWvgJiYg8o6tID6
         /o73r2fg48QYPDBilQmnsv1hrpnl0BIW6QIOfh1dBzBcS3DBVH/aEhG/98xKBiecLmcw
         Ij1g==
X-Forwarded-Encrypted: i=1; AJvYcCV2s4Np/MVLpaHEjJuEywvQ3brb6G+7CobVA21E8xApP6pbNE3n4ed4JwYqcJwV7WAxLingfJ4isRSsnV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkcfNCIROoiqt3R1vyy+epfI4gZDUaDFlNg76n99MYeg0jtwZl
	2OwtZL7oZC2UcUlsMJOmdcQp6JxoBFeO+uNuLwbwNykX1xfH8PHL87tw9aanFsvb
X-Gm-Gg: ASbGnct5tcbTGi1SYCx22pei51lytbpLxxglUjWxYIxr552Gs3nOcdYOuUBzZSm8pSb
	WLT2eT1CGQY8XIvYh0/jHTbz2W9cpJABIX63471r+DYgpfALfdNq0WgbRTu657Z09iB25NgqWgX
	iX/P1I1IGXnpeTrXPuYn6cA5RMgcAAYumSJuk99UxZBjyoHTs4/pdGV0GrUjLf/zzl4DMW3gvhq
	fzU5bH1LlBhcBnCtPxjf/nWWz8SrWgjvNTCiQSCqRHiD//bC9mzx9BoGclVzmbEg/Zwphys/5xo
	HoPHotHOOmv/U7T6Gr4+rVTtJEw/DP/Tqo87dXuubuVBdZ28ZFz7koqCVAbFuXfzZ8WWGeN1bUY
	DzDN7bTeyo5mfd2Eb4K7AsZtAX81IG9P/97C6Aw==
X-Google-Smtp-Source: AGHT+IHyTHbqNtDqL/vdm0/JYC8pK90GjY4pzK8dB+l68eu9HRCPn+1F81ZrAgi/3sUNOSy2r6FxFA==
X-Received: by 2002:a05:600c:1988:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-46db6651ffdmr413745e9.32.1758491783929;
        Sun, 21 Sep 2025 14:56:23 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm5873427f8f.57.2025.09.21.14.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:56:22 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 21 Sep 2025 22:55:45 +0100
Subject: [PATCH net-next v2 5/6] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
In-Reply-To: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758491774; l=3810;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=eG/wddCuyCwaUxobhxivrMgFJ0iPulanstbx9NkmFWA=;
 b=RLs4+p+hnsheILQOg6DjKkDeiQvO/HvmIEGdPyYrCKeNMOOzLRQUaZeWhSGk3I3KuFg17svwn
 ZUn2iUP+Um+Ch0EtR2XtQZQ6w+I21fGeR8EdZxIZV4JbujigbL53tq4
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_UP event is received) by calling
__netpoll_setup_hold on the device.

For targets that were initally setup by mac address, their address is
also compared with the interface address (while still verifying that the
interface name matches).

__netpoll_setup_hold assumes RTNL is held (which is guaranteed to be the
case when handling the event) and holds a reference to the device in
case of success. This reference will be removed upon target (or
netconsole) removal by netpoll_cleanup.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 59d770bb4baa5f9616b10c0dfb39ed45a4eb7710..96485e979e61e0ed6c850ae3b29f46d529923f2d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,10 +135,12 @@ enum target_state {
  * @stats:	Packet send stats for the target. Used for debugging.
  * @state:	State of the target.
  *		Visible from userspace (read-write).
- *		We maintain a strict 1:1 correspondence between this and
- *		whether the corresponding netpoll is active or inactive.
+ *		From a userspace perspective, the target is either enabled or
+ *		disabled. Internally, although both STATE_DISABLED and
+ *		STATE_DEACTIVATED correspond to inactive netpoll the latter is
+ *		due to interface state changes and may recover automatically.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (state == STATE_DISABLED).
+ *		runtime only when it is disabled (state != STATE_ENABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -1430,6 +1432,31 @@ static int prepare_extradata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void maybe_resume_target(struct netconsole_target *nt,
+				struct net_device *ndev)
+{
+	int ret;
+
+	if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ))
+		return;
+
+	/* for targets specified by mac, also verify it matches the addr */
+	if (!is_broadcast_ether_addr(nt->np.dev_mac) &&
+	    memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN))
+		return;
+
+	ret = __netpoll_setup_hold(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+	} else {
+		nt->state = STATE_ENABLED;
+		pr_info("network logging resumed on interface %s\n",
+			nt->np.dev_name);
+	}
+}
+
 /* Handle network interface device notifications */
 static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
@@ -1440,7 +1467,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	bool stopped = false;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_UP))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1460,6 +1488,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (nt->state == STATE_DEACTIVATED && event == NETDEV_UP)
+			maybe_resume_target(nt, dev);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.51.0


