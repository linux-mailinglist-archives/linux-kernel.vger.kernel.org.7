Return-Path: <linux-kernel+bounces-843433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 356B4BBF2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C8784E990A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384B2D7DF3;
	Mon,  6 Oct 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aplaUWnk"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6C2D5436
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781943; cv=none; b=Q6vbS21PxDdXN2nqkP31pk3T1A5Hg4LkgKDsnfJjZ1eFO6r8WimL3lVNuPuMsLAmJHe0xfjSXxH2olzYVRc66sV0BBwgFadMyIrWpEpqe36k0a4eipF4cw8kaTQCv5DBUm2qUJVl+L2GyDam8WzGylbnImnN9OCm7blKcEhY07k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781943; c=relaxed/simple;
	bh=1lolhe2GlbOVyjEMDHyRQEBf0AOekqw7TGvry2kixcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ga+3qbQMRfOr9et77LOnt9gBacsdjjCuBK4WPF0iyp2mSA78ilbm+n7kH+guK2UPXg6VeNpkpq6mmol/nSOdgDtI3xdZOVcIrNbxWlLnVvwgVV3amTgiHGeEvpGKZfPh/0VRj5T2eFWkt5h19EsQ+GrDmt2uaw1cBQtE7GgVetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aplaUWnk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1f29a551so6810797b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759781941; x=1760386741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=s7c6FuDc/WooqLby8dYSXXZ/60kGmD2CeerU/6YhiHQ=;
        b=aplaUWnkdMTfrn7RN6II1XU8RQbhR0mmpzWGyRSxT/sX5Jgq0LuHQ5yLl9woNWcWNt
         skcCmGqExwMsxmRJ70skJjuzQ3PxCrfkRNjKTtrsP0iUTntd/ccu38ZyY3U1QZ64WSdk
         Qb4vpRCJgR+t2tMkAG35zvNcaoKqE24ySBSuN14b/ORbc+TMMBFS4dDZ5TQAME4D+AD3
         T+hPSM2t/0R+EzM2Y9UO1Rg55mtGVLp8ZZrxfjWlF9+A/xjASMGj1HqaEW22WKQJ+vZU
         aFoPQF+B4izxF6j6yl9gwFqrHWFT+mdXpvEAp1IIE6aQL87+yWtHA7bzJD6ojK0NA+Os
         b20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781941; x=1760386741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7c6FuDc/WooqLby8dYSXXZ/60kGmD2CeerU/6YhiHQ=;
        b=WhCe4CdtdMmqnp5Qh4V4QDGKZ7g7JffeCj7nVuCcEfyfSFt1sw9LdBKUIFHAP5js54
         UET/eSlg2MeWpevxbUF4o20TX5pgL+H/IU0clFTvt/Igj1zXum4IbDJelh8PayZKjYpK
         KboTISAeKGDA0Ng2IzJBjFkitE1YhnHR049GQyKzW1KAcuRj8/gf8qDyBN+rDQOPnKKV
         k7KH2g/DgCxZ/EcFWR5dFUtqRiAQydTuZgexjW3+CDAJQzn8Gcg1Ep6vyVsUVVf6iQyV
         4gvTtJi8q/C05ttuE/E2E8uRWwhtedL3nTgxwEPNvguiSM/xMLV/QSXCqE+X3EvxQOqK
         eZYw==
X-Forwarded-Encrypted: i=1; AJvYcCUsXmXnw67IpQ98aBaWLGEa8DnSfovLuD5T+xnjFzJ6WcgeQnhbPWqIFXydcShoGsVpFe078bjvX2/fYMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUwLxznW1zA3Fvchns7uBIIV6fAstNO+E625D0mVFf3toUYqM
	quTE66AC/Rozz6A9evpg9rvuwP3s6zqFSYTwUDPrIPNyKkR+YHiQs6Q8
X-Gm-Gg: ASbGncs/OmK0xB4iShfii4ypCYPrqo2zUw8mRHp+lSZL6Cy4wiodSNgTM348nB4VgMw
	DpbWZns0yKKuWUdHlXbyzuUr9VaPKJXA5eg+hkLJYKM74QgHlYSrl5FZ1lgnXn71rsoJGwrAXXH
	vaNvIampXWSH6NREtFfLI3I6EOnnUfbTbFNXHqa3oQ5PSmLVOgOhwNigwErDhYzve2q5npUXNiU
	a08ewC7ngeQi4gE0Gt/09AdqbznP9VL9X7pZsHslS8ynCry7vG+clIw/oAfPPCzIoObCUBbtlbX
	oRCtasRteeqrm4kJ0wH0aMiVr/Zkl2GuTkD/j8e+tn7eGEBYrfDeMcDphpTyORleHefGnyxPUnv
	nXsaa23pmPsMV++TEdGAWvMzgLsamPSsbOe48w8Px9OLr0agusgx89Zs71Kw=
X-Google-Smtp-Source: AGHT+IFFMC0XNc9aOxuuCWzW1QQR1mD2fC24W1q6bD/FpKoR+B7obAfk4abxLPewsoUXOgZOsL2/aA==
X-Received: by 2002:a05:6a21:e083:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-32b62107fcdmr18496026637.56.1759781940891;
        Mon, 06 Oct 2025 13:19:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e121e0afsm9801971a12.25.2025.10.06.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:19:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Thelen <gthelen@google.com>
Subject: [PATCH] ipmi: Fix handling of messages with provided receive message pointer
Date: Mon,  6 Oct 2025 13:18:57 -0700
Message-ID: <20251006201857.3433837-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to commit b52da4054ee0 ("ipmi: Rework user message limit handling"),
i_ipmi_request() used to increase the user reference counter if the receive
message is provided by the caller of IPMI API functions. This is no longer
the case. However, ipmi_free_recv_msg() is still called and decreases the
reference counter. This results in the reference counter reaching zero,
the user data pointer is released, and all kinds of interesting crashes are
seen.

Fix the problem by increasing user reference counter if the receive message
has been provided by the caller.

Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Reported-by: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Greg Thelen <gthelen@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/ipmi/ipmi_msghandler.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index a0b67a35a5f0..3700ab4eba3e 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2301,8 +2301,11 @@ static int i_ipmi_request(struct ipmi_user     *user,
 	if (supplied_recv) {
 		recv_msg = supplied_recv;
 		recv_msg->user = user;
-		if (user)
+		if (user) {
 			atomic_inc(&user->nr_msgs);
+			/* The put happens when the message is freed. */
+			kref_get(&user->refcount);
+		}
 	} else {
 		recv_msg = ipmi_alloc_recv_msg(user);
 		if (IS_ERR(recv_msg))
-- 
2.45.2


