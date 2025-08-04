Return-Path: <linux-kernel+bounces-754828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E38B19D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71731899920
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45D23BF9C;
	Mon,  4 Aug 2025 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="LhIcN+jo"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA5823A9BE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294645; cv=none; b=uO+xnx/en7W2m3LhLmkhOHNijem5UvX4Y8qykdvaxt9qW4QJyaJ46QCHou4myJYVRr/R71JlLRgPvfqAeSTcwoHgkKB4SeUFF1AfVrc1uRzB0yhuPepsFFWo/WkJmKSoEaqU8PY8oiOvZFxSclztgaajE66q/hQBegch9L44nSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294645; c=relaxed/simple;
	bh=vzFx82vV0vr6mMz1Z6IT0Dd2ubmzk/i7rSdHVE0NwHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBXiau/OA3V7pur+2ERE5QXeI9CZMc0aqqLtKZv+BeUjFchq8JgHBaw2ZYivMivwBEkNFktHpX8/tJ0uQBPe6l4tYGeTuFJdO0usTXh+shHKexOV6ch4NMMOofnMlM+lH9YTkJ/Ii+vFCIpEAJHtC4VR61HA3qJ7Jya7kheEnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=LhIcN+jo; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754294623; x=1754899423;
	i=markus.stockhausen@gmx.de;
	bh=HzVaQGDPIYSbSHCUX8mZ7P1G+XecZ/J/O7wLLc8uSwA=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LhIcN+jo4hmBSS9oHtYZ256k6C9tkQ7MVn7c/HDIPvbeLb/o72i94EfWE5r2u63I
	 CVBpn3BPWEqqXquAdgtghwMUE2Wz+AjmmHsFzHx9V/uvRFg+dEMEpNgeYeaCZHdvN
	 1k5TSp5oEUMqCShtxYa9YKa6sjkyHW3EZERL7i8HIMLGH0x1SvUjIpZzgvr3xz4Bo
	 6K03szUNEAnees7rTIzJLT6EGmzIc96fysOl7uW1YC6ITmUn9czhtpTL1OKM1xCVF
	 CNL3Z8hYsv+3+yj3IibLzqXD+Tbgz7LhB0ajmtFoXydEH8hwfKhVJqtc+c2DvHh9U
	 oPFV0tr82OZOchFAcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1ulJ0Y1vTd-00G78G; Mon, 04
 Aug 2025 10:03:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: markus.stockhausen@gmx.de,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	howels@allthatwemight.be,
	bjorn@mork.no
Subject: [PATCH 3/4] clocksource/drivers/timer-rtl-otto: do not interfere with interrupts
Date: Mon,  4 Aug 2025 04:03:27 -0400
Message-ID: <20250804080328.2609287-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0hXl94sGqeDwUOgo8GUI8UIukLFVGquOsqvgXAWbRnjUUnJxaRC
 bV1OV8DdhoJKertvLtIKs0Zaee4786ewbjzBb2v1CA7yESvw7PE7W3S5QP2NidPMp+pOr41
 2f7G1l6ambU4u5zMudvPJWpyOnDtXgg0aLTILl8/kKYuopcu191FqW5uLqKT0nQtcgFNT2a
 7F37VZfKAtkLOnH7ICcfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9WRsymVBm54=;2bEXltqR3YDJsgulS+pspUa3YFQ
 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
 aA==

During normal operation the timers are reprogrammed including an
interrupt acknowledgement. This has no effect as the whole timer
is setup from scratch afterwards. Especially in an interrupt this
has already been done by rttm_timer_interrupt().

Change the behaviour as follows:

- Use rttm_disable_timer() during reprogramming
- Keep rttm_stop_timer() for all other use cases.

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/578=
75/3788

Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/clocksource/timer-rtl-otto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/ti=
mer-rtl-otto.c
index 48ba1164f3fb..42f702aca689 100644
=2D-- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -141,7 +141,7 @@ static int rttm_next_event(unsigned long delta, struct=
 clock_event_device *clkev
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, delta);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -154,7 +154,7 @@ static int rttm_state_oneshot(struct clock_event_devic=
e *clkevt)
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
=20
@@ -167,7 +167,7 @@ static int rttm_state_periodic(struct clock_event_devi=
ce *clkevt)
=20
 	RTTM_DEBUG(to->of_base.base);
 	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
-	rttm_stop_timer(to->of_base.base);
+	rttm_disable_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_TIMER);
=20
=2D-=20
2.47.0


