Return-Path: <linux-kernel+bounces-833424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B230EBA1ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E0594E2BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024D2EC55D;
	Thu, 25 Sep 2025 23:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhckLpwH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0338DDB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841509; cv=none; b=STJmV1q6TWXNb9j8l+LRgN6UyKOHekJjXxC1GuIFNYwFIlOaWgEkrfNWUhMC96o6VDRfFt/27F4B5iM3HtBPXXUVZnPjv9AsNoTbSalTO3oXfgmOtIEo4r8Tpi7OJatnMWDNgve21QXwk+Nj4Lj5McaG9A9Ohwd7mmDAh8esFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841509; c=relaxed/simple;
	bh=j6jhy+pSvSiVMP6PMLO2mkV6Zrv4fDsdzb1XEggaRhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dzJsAJm5NOwr0G6OTEdiDY1nki51axKZDewzxLK8Ckh0QOOgVJxzuLhVw8qOJQHBMKFSW2rWF4lCM2t4yFeoi0gYfBTWSxZIiHZY+AnkmMK3/eDp3S9rEXibsh6ksw2M4dvQy9/UDi1uhUtv064umdpXp6jKsPn3hfnU62ffmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhckLpwH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso7769395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841506; x=1759446306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z46+8/zwZ+LooDiBhNmzCrWk49GLQcEUg/KtsaJStu8=;
        b=HhckLpwHrJ7/p9wScRaNqPGwZ3VscYB+h2yW1XNLXdU7SeG0yjNXE5R/g0nK9DkiIT
         acTEwTv60d4+GD+FdwVGn0+HnR0dRdPsnWKdIjbyF0MH2vtO2HHkYz/zQq8XAjMdRQTO
         qqAuQ9sB8SYiNTvkavfNtWSUXIp3yYZaavTm7TJY4la3FSJPBbemU24cLfhragc9U87P
         +LEb4xExlZvDTw2kIAziQ4KHdAxrqGQJdwhVhoavebWwh9lp8M16FjU66REQKUMvPVPn
         tPgJmW37rkTRJFbno9UsBIGlcycjRvJVqSN9k8rVqpzMQw2D52z/Cv2lkMhudfdRSPmG
         vFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841506; x=1759446306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z46+8/zwZ+LooDiBhNmzCrWk49GLQcEUg/KtsaJStu8=;
        b=kko/eUHVTvOgO9YYpOTmAD8cJoGwhPerjCbRkdtfMOG1SjdS9dkh8oqsZKclU4f231
         +CN9xgJJvJWLLF5iwHE60IXJ2X7Pbsv7FyIZnYc6FGDnl3/0dCdREkUva3FoKjEYpign
         QaZdb32s1Wv8S9lP/Mu+ozNAAwDfkLklsDbnHhmrd108SCLCzsZFpNeYAZKon4CKMoY+
         /YDHDAMM+yu4mfWdXRhTVMKCURRgNq6Ic2uUH4I0GBM12xaTX+jvBZggQ4Sui5Cz64aq
         aUydvhL7LFUdqsazvMfNOL4eJe+vl88cPGgvv+QgOOoavqoiuMKckanRi2ltxqsVOTDc
         jAUA==
X-Forwarded-Encrypted: i=1; AJvYcCX1IvYypFQ1pLRvuAp83b82EyN45/aJmmQlu0AwFAl9+7VnVZu4VSyqoWk32ej2WX1NsTrTiaqc7d2tNOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBWDukGr1yXM1t+QjG4PMn3fWunyuAeck0VAC/CH9o/NPf9OY
	9RNXwTGKUPGopcXzGv6lbwXgzHOlH3BcFYSKX43XXydzHujX8qE6z9sy
X-Gm-Gg: ASbGnctIj4E59p2dt7FbfSRg3ebuIk6fA3wMZ4b8nKySsr6uLo2E9gbrhCfM222pdrp
	HRau2XOpF5L+7WLcq25Ad4YuJZCAguwWQoCJU4tmRnjxOlORI34t/fOnebxqWzJ42U2rw3Vs0jH
	Qa2xXG/ll0pRYzkihs5imckN9T8sa0VvWfHsAhlOS1V8p14njnHAbtIimHxW2GG4+tj6KseS6Fw
	deNjJ5PCprewwdGov+HwDBHohX58eXrT/1eRq1UA2PqYbcFv5WK3vJ9KnYR/b9/CUpzo+RMEvZv
	LoPFTR+rreepYDFH4wlrynmeDdsq5FGu/cE9yLaih07aTdJZ8V4Eiy8m9uKmyErIWEQIaAA6O9e
	QR0UVg93LpimcfH+PkUiP3A==
X-Google-Smtp-Source: AGHT+IEfs2O+uSSSt28daQgTESik6U7sDlGPE7r22pcaxUbJK/l9uw3lS/hPmbfKlx8X1URUsDPCuw==
X-Received: by 2002:a05:6000:1886:b0:3ee:13ba:e140 with SMTP id ffacd0b85a97d-40e4a8f9a93mr4305590f8f.21.1758841505844;
        Thu, 25 Sep 2025 16:05:05 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d19:8d:4f34:a86e:322c:6aa5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm4494806f8f.63.2025.09.25.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:05:05 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com
Subject: [PATCH] =?UTF-8?q?mac80211:=20tdls:=20don=E2=80=99t=20WARN=20on?= =?UTF-8?q?=20invalid/missing=20peer?=
Date: Fri, 26 Sep 2025 02:04:03 +0300
Message-Id: <20250925230402.138761-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace WARN_ON_ONCE with a regular check; log via sdata_err() and return -EINVAL. Avoids panic_on_warn.

Reported-by: syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=665dd2d6eb222ac6a6ab
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 net/mac80211/tdls.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index ba5fbacbeeda..85d627e609f3 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1457,8 +1457,11 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		set_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH);
 
-		WARN_ON_ONCE(is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
-			     !ether_addr_equal(sdata->u.mgd.tdls_peer, peer));
+		if (is_zero_ether_addr(sdata->u.mgd.tdls_peer) || !ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
+			sdata_err(sdata, "Invalid/missing peer (%pM vs %pM)\n",
+				sdata->u.mgd.tdls_peer, peer);
+			return -EINVAL;
+		}
 		break;
 	case NL80211_TDLS_DISABLE_LINK:
 		/*
-- 
2.34.1


