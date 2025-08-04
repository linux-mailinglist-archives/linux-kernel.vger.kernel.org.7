Return-Path: <linux-kernel+bounces-754826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DC3B19D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43AE27A3300
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7A23C519;
	Mon,  4 Aug 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="bsx5iDRr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E345123504D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294630; cv=none; b=h002FLKLE8oveuRz0+Lf0RgOZgBnKpRdeixVQncIpF5YIGYx/gbBOt9KdjuT2bpVRLPOXKabdHK6qtbu1r+WWhrYszLSZHap8sw0r9R1+t7Hx45vIdz0jPPxv4GC9p2wNf+rAx/wE9KHKkINBEfVs6RLcaCa1tOTokEq/yDw5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294630; c=relaxed/simple;
	bh=iZg57lekLIIuMZVGS+qCr+Kj0CnUVpi+tSa9ANKmN0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvfELCh8tJ6DmLBPdXGzBUA4C8jVhTSKimqNE271qJBuTP3MaHM3/0w4g3rc+Yiwa4qDKxqWWqpD73uIdKIL9n5ypUgArpch4ix6dGrWgfbR0uxCpwZLVeirv3CELNaBRaMO+4KJQLgddrMzYWZ+a5BuTa06WaYcxh72yQ+OIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=bsx5iDRr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754294623; x=1754899423;
	i=markus.stockhausen@gmx.de;
	bh=LsrujtBMqwcuo5v1ZCZTEic0Ba9nT7qQaJ71gaCsfio=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bsx5iDRreC5ghCDSdNe/w6exIjhLcoV8fOGqPW3HHYxztC6ssRU+7iVkE9pIIO8+
	 ilcnycDu+4t68RG83joFZ4YHyNb4r0s20pt5Iu7cW/t9mCsCBqSlMkQ0GdLDUXRjW
	 O7B4M6boweq2U6q6Zapx4yojPk8KaNy5NNoDFnqZiKk3CGHg5vXtgrUx1Y7N19lTx
	 G8O96mBcSAMO1AKccgJt8ORahojgHNJ0n9fuiemrAEEBaK7IIKIqM/A3xLwH0Y3KP
	 Kn3/W7n45bJ4CHu55OHHs4ZL0hbn7ykji3cvo0Y2IgafNlA+6Sd2nPTbBEr8iMk0J
	 BqTtbSIH9kTyhF1QIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBlxW-1uutvf0TBE-008jHd; Mon, 04
 Aug 2025 10:03:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: markus.stockhausen@gmx.de,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	howels@allthatwemight.be,
	bjorn@mork.no
Subject: [PATCH 1/4] clocksource/drivers/timer-rtl-otto: work around dying timers
Date: Mon,  4 Aug 2025 04:03:25 -0400
Message-ID: <20250804080328.2609287-2-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:kDYr4F+GsYaEoJcIxH/uERckAH94eukVqxeXjSmCgfP0jEeJsQq
 CLiTtxgufyEBjIX6Seq0hAFUlUZYD7tdLTSV4+8f8T5ANYIssGfYsrtDXCeuRy+FPDVohYd
 2om7oq91NtIV33XC1hMsmnmh65kJIaTSFpO12MsHZeE/KZmfNw2G1Vg2XhlcmUDLySafsqN
 vcqYbp7rTDpy9PUsn8p/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rwzkyALo6Lg=;gR/k1e9WmzsCNChU9Pu8Vc2234C
 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
 XXRhYv50uLWBSs=

The OpenWrt distribution has switched from kernel longterm 6.6 to
6.12. Reports show that devices with the Realtek Otto switch platform
die during operation and are rebooted by the watchdog. Sorting out
other possible reasons the Otto timer is to blame. The platform
currently consists of 4 targets with different hardware revisions.
It is not 100% clear which devices and revisions are affected.

Analysis shows:

A more aggressive sched/deadline handling leads to more timer starts
with small intervals. This increases the bug chances. See
https://marc.info/?l=3Dlinux-kernel&m=3D175276556023276&w=3D2

Focusing on the real issue a hardware limitation on some devices was
found. There is a minimal chance that a timer ends without firing an
interrupt if it is reprogrammed within the 5us before its expiration
time. Work around this issue by introducing a bounce() function. It
restarts the timer directly before the normal restart functions as
follows:

- Stop timer
- Restart timer with a slow frequency.
- Target time will be >5us
- The subsequent normal restart is outside the critical window

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/578=
75/3788

Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/clocksource/timer-rtl-otto.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/ti=
mer-rtl-otto.c
index 8a3068b36e75..8be45a11fb8b 100644
=2D-- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -38,6 +38,7 @@
 #define RTTM_BIT_COUNT		28
 #define RTTM_MIN_DELTA		8
 #define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
+#define RTTM_MAX_DIVISOR	GENMASK(15, 0)
=20
 /*
  * Timers are derived from the LXB clock frequency. Usually this is a fix=
ed
@@ -112,6 +113,22 @@ static irqreturn_t rttm_timer_interrupt(int irq, void=
 *dev_id)
 	return IRQ_HANDLED;
 }
=20
+static void rttm_bounce_timer(void __iomem *base, u32 mode)
+{
+	/*
+	 * When a running timer has less than ~5us left, a stop/start sequence
+	 * might fail. While the details are unknown the most evident effect is
+	 * that the subsequent interrupt will not be fired.
+	 *
+	 * As a workaround issue an intermediate restart with a very slow
+	 * frequency of ~3kHz keeping the target counter (>=3D8). So the follow
+	 * up restart will always be issued outside the critical window.
+	 */
+
+	rttm_disable_timer(base);
+	rttm_enable_timer(base, mode, RTTM_MAX_DIVISOR);
+}
+
 static void rttm_stop_timer(void __iomem *base)
 {
 	rttm_disable_timer(base);
@@ -129,6 +146,7 @@ static int rttm_next_event(unsigned long delta, struct=
 clock_event_device *clkev
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, delta);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
@@ -141,6 +159,7 @@ static int rttm_state_oneshot(struct clock_event_devic=
e *clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
@@ -153,6 +172,7 @@ static int rttm_state_periodic(struct clock_event_devi=
ce *clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_TIMER);
=2D-=20
2.47.0


