Return-Path: <linux-kernel+bounces-754827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 681EBB19D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DA7164ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F126B23A58B;
	Mon,  4 Aug 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="IGhs0aG2"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E4235045
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294645; cv=none; b=PYst5mFAks41avi9wwxCmtXfNItGCHwkR7jyYC154WupnJHUA69dxYdKFafajIEpl4PtUIoFXp0LJ99RfRDePDme2mTmL/2dYXzP8j42fmTqMylURtH8jIpRsRDNBtO4Mf2AIFxS7SGVfOMsQOvWBnzSDn+yfwqBzVHupSCmAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294645; c=relaxed/simple;
	bh=vM/64Xm9BoHSIklScFHYPjkxIx0tlfo7hzjJbLJM3CA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z44ga9/KXnala1/ywRIOB3fbz2re5t/uR07EJ00wOJsjQwhlhoMe5KvIFw0JlGQ3fLY5Oxvfup9X3pV0+0KQOsz7WYtt5KnMG9Yql3m/NjhnlmiXqVLNaGnsbDvxrCS1P86KBvNNuSK9CDEeiIqU7Nnp+ZW1fuzp0EU84f19ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=IGhs0aG2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754294624; x=1754899424;
	i=markus.stockhausen@gmx.de;
	bh=g1rzoG9f0oHQcMo7RkUNLvEibz7XkPzWojlZocSeReI=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IGhs0aG2JRTSgPoI3iGeDdm5ddcdcMyWF7eoXFgn5GU4OmdNPS+oFmdbFQBP4TzS
	 BUTMaoznHQou3pujlXslhSHlXcACScN/yhZGkXmT8CNHBC2sjGOylXjoFI4SCHGX7
	 YYeMpIpgJdVS1I0hJW37Glcp0UqBeW6aSFYRZmgEgv1tWNByjOqLfwEqORiH+nnfP
	 Kb6jM/C2i5fraMbhOmT23Rd3A4vS8mzujErYVvS+4TLOrb9Oi59uduYMSQ+8MjMYH
	 sqMowSVtpxWDG3A9/qXPd65xnWx3dH2AFadR7/EGmmW2sPS9+xwqLyClurNIBAalI
	 Gma2e5sgnDOZx+5oBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1upxyf2cJO-002ejv; Mon, 04
 Aug 2025 10:03:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: markus.stockhausen@gmx.de,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	howels@allthatwemight.be,
	bjorn@mork.no
Subject: [PATCH 4/4] clocksource/drivers/timer-rtl-otto: simplify documentation
Date: Mon,  4 Aug 2025 04:03:28 -0400
Message-ID: <20250804080328.2609287-5-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mcAzbTgXMmIRzGD6D4AVBX5ajz08F82s1hYcUTqdf+7ffLgpMxP
 g1wYZ1Mo9PtaaygkXfRJaHlCilM9tELAwRhgKXZhyIrhn78vax4zO/Y/CmDr3AbFh/o1CZi
 1UqbSwrvcPCKVmoehQJZhl5RILLDZ//LWI3t1YTKqzoBf5haG47iqxTS19xWRuPQ2dAphtC
 M/ib9mRoHbjai7APdgJMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y2cf+GR8dAQ=;jAJ/UduJdY6DTrU/sBLQl+jktAH
 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

While the main SoC PLL is responsible for the lexra bus frequency
it has no implications on the the timer divisior. Update the
comments accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/clocksource/timer-rtl-otto.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/ti=
mer-rtl-otto.c
index 42f702aca689..6113d2fdd4de 100644
=2D-- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -41,12 +41,10 @@
 #define RTTM_MAX_DIVISOR	GENMASK(15, 0)
=20
 /*
- * Timers are derived from the LXB clock frequency. Usually this is a fix=
ed
- * multiple of the 25 MHz oscillator. The 930X SOC is an exception from t=
hat.
- * Its LXB clock has only dividers and uses the switch PLL of 2.45 GHz as=
 its
- * base. The only meaningful frequencies we can achieve from that are 175=
.000
- * MHz and 153.125 MHz. The greatest common divisor of all explained poss=
ible
- * speeds is 3125000. Pin the timers to this 3.125 MHz reference frequenc=
y.
+ * Timers are derived from the lexra bus (LXB) clock frequency. This is 1=
75 MHz
+ * on RTL930x and 200 MHz on the other platforms. With 3.125 MHz choose a=
 common
+ * divisor to have enough range and detail. This provides comparability b=
etween
+ * the different platforms.
  */
 #define RTTM_TICKS_PER_SEC	3125000
=20
=2D-=20
2.47.0


