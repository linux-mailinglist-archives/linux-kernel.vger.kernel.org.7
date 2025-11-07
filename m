Return-Path: <linux-kernel+bounces-889936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCEC3EE0D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A3318882C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BA30F92D;
	Fri,  7 Nov 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLZ5cJkh"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF726F29F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502883; cv=none; b=rvVVQHbs1IGeAnCRXWPxk8GEBFEm593M43JFnuG0z6wfD7NawnXs8FJu9w6lTdsCGHo7mFIzxIkHibGDhyFw+tmi8ZtGMMkWihtN+PibrHfm2SoCQv6nyLazGFb2v/gZb2b+ZePluIRj93EtOoLZj22jN5huDtJGF/B2cFmyy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502883; c=relaxed/simple;
	bh=7pgqQSLNxYY7EJISqsid9AK1bmRm9KX+sTAAQz6Z6Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLXqvH05+xFVUsY3CHwzQPRVysqRQ9fuvIgnFKjBigc4WnB3kImafIJmgqM1/GMgFjgEjPDQZwNe6cMr5JNRNBpxuCeaaNLP77VHtCJlnNB7zzhV7/pZws1y20HLnSWBH6xhDywSPkjLqEBG9K6VFPwQKU5ZBXcugiYkvsh0plE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLZ5cJkh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so789243a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502880; x=1763107680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rajoUmRPnySxOOnX7A1RIrBkqp/yGkZaJwwdcAfDN6U=;
        b=DLZ5cJkhKO3IuJt03dP/smFXzfVt7FNG/F3l1RUY9BG+zzDfIRRfxpTMz69DO0baEl
         JoH3w+4gcz+453DoSdHnYo5M0ZSyR3SUncIQyOVUGDBNHL/8l30nrbrWOAlUrIQmFeoF
         fFfI/2Z1LI/Ho74YM8BiyDLhhWlhBawTc8LydU8aCBZ9hdE1SMekyaDTjIMZG/QV4TAz
         FS3Tv6Pw9IZsPXnpH1rqh/xKkMNnUNwndC8T3e6Z/KltLiYBw6JWamwuIaiViwnyvt5W
         PGjUd/Xqas/zYKPsY+4SqcC2GEcwDGrhB2EeT7xbhKSza4AXN0YpvkJ4ec6BJtCX9pSR
         JwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502880; x=1763107680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rajoUmRPnySxOOnX7A1RIrBkqp/yGkZaJwwdcAfDN6U=;
        b=q37AJdnnwl2/5K4ZNIo72l174X5VJ5nhpFt9gHmFgBSaybbYwzd5+e12HKauJV4k5h
         tv+bmQ2Ze5wfvRyEa7djRTV3nCW09OGdXMFEHZc5UiP77MYcfxDQX2/JCpvIs5UquyMh
         wCONsnY6+Z8V7+ds/Liw7uGTK/U6OdJuyT7s1PhlnBen6xmcOpxVlfrqVPZ4lx57ckZU
         u1oapWKdTEKAraVmqoRkKWvsG9n7N1EtFloNJ9dVbawcSRDpQ2PJrVi8958RSPHq7IvD
         2pD1tWmz4Nhy57LfKXMWYx4BaqOg386xNTzuh72vG2+SJlhB2qsIbWxk3HxLXMSIn0wA
         2e+A==
X-Forwarded-Encrypted: i=1; AJvYcCUH5kfzTaRSGW0hIEocTiBQ2RmzOUhuIbGHa6+w/KdIDUOopnTWuHYuZDEAm8Jss9zjTM8/G/1ZATmgTh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbdwBWHnsBOW8ael/w68qH8X1aV4+NOZ9Sb3E84dd/WdNAleb
	5RslErkjl7ZS+B6Y3lLX1d6kFqH0h2FQczXddAFvajZbX/Mg4ewFK+Sc
X-Gm-Gg: ASbGncvXPgq/l+1L7CO9uFI7hwN9+KqaI6gMoGTb+wsJN486B4BxdAJkoC44RZFxdHN
	1pEZRd39PG6+fy0Ixruj2KPI+8kKg2ewJ0DpwU6QeLxznXqE0u28j6UEb9/f5EG6JsmEtFj5hKj
	G5SI0RYnbZEQKRaJQ+pZKuzU9PBLtV5/V6pnXrSnfZyVQVHODEuE2hXE0GKcrwJqkZvZR2Bweut
	MNvIYADgnRPddbkautrNSKK24Q85c8gN8s49Spa7KWwzB5x/eUPKpbw5g71EcYnMNX9aTq7N9kJ
	AshsRiL+jFDQ+HUoQk715zH9/FcmAQhDrmwL+W7HpSh7r4imwd7OyKhSwThb+63Zd1adY7UQbje
	brEBNo6wc73ubQGUCtZ8xPNQtz2mvfTR0VyQPo2Likdwl/YMVJ3UxDwluOj5pnWfEjjf9E4pBCZ
	RzdADQyPglBkqj6Pr9JbHE/3t8PSvSQC7CrmObqADw4umZv79Fg/DkH4GLvjH+GwUGhp5wFtcM6
	T/vJA==
X-Google-Smtp-Source: AGHT+IHswEuiKJmXiY0EIHAe+BZtSgz7sojXyfyfy+l5UKKqokrRbUAW/iGvN9ZOnAwdkPQbCg7XeA==
X-Received: by 2002:a05:6402:5202:b0:640:96fe:c7c2 with SMTP id 4fb4d7f45d1cf-6413eeb9d78mr2308475a12.5.1762502879314;
        Fri, 07 Nov 2025 00:07:59 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm3545810a12.2.2025.11.07.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:07:58 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] net: dsa: b53: add support for BCM5389/97/98 and BCM63XX ARL formats
Date: Fri,  7 Nov 2025 09:07:41 +0100
Message-ID: <20251107080749.26936-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently b53 assumes that all switches apart from BCM5325/5365 use the
same ARL formats, but there are actually multiple formats in use.

Older switches use a format apparently introduced with BCM5387/BCM5389,
while newer chips use a format apparently introduced with BCM5395.

Note that these numbers are not linear, BCM5397/BCM5398 use the older
format.

In addition to that the switches integrated into BCM63XX SoCs use their
own format. While accessing these normal read/write ARL entries are the
same format as BCM5389 one, the search format is different.

So in order to support all these different format, split all code
accessing these entries into chip-family specific functions, and collect
them in appropriate arl ops structs to keep the code cleaner.

Sent as net-next since the ARL accesses have never worked before, and
the extensive refactoring might be too much to warrant a fix.

Jonas Gorski (8):
  net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
  net: dsa: b53: move reading ARL entries into their own function
  net: dsa: b53: move writing ARL entries into their own functions
  net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
  net: dsa: b53: split reading search entry into their own functions
  net: dsa: b53: move ARL entry functions into ops struct
  net: dsa: b53: add support for 5389/5397/5398 ARL entry format
  net: dsa: b53: add support for bcm63xx ARL entry format

 drivers/net/dsa/b53/b53_common.c | 316 +++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_priv.h   |  71 +++++++
 drivers/net/dsa/b53/b53_regs.h   |  22 +++
 3 files changed, 312 insertions(+), 97 deletions(-)


base-commit: 6fc33710cd6c55397e606eeb544bdf56ee87aae5
-- 
2.43.0


