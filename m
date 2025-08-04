Return-Path: <linux-kernel+bounces-754829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D39DB19D40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4516320A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731223D291;
	Mon,  4 Aug 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="c280J59d"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA85237A3B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294646; cv=none; b=gNePcsrW+JYed3eD2eubwv1ASdG7CD8flVpk/Qk4VEzWtIksEXgLOwsXLuU9nk5w2mlsRcYtKgHzOKG9h1LEX6KqHLQC2KcZ6AYlVjkojvV4O50/YXCDqiUpAyJLoFLpVhqm30DkGj1+Cg+OLamOnfbbcaKYA6v13iriTZXUZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294646; c=relaxed/simple;
	bh=KzsHo+kgUPlsYrEEWaRzzCYLsJoIf4O6K4gsx/pE5J4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ao9OiEOT/yJbmY4vrBckiCjJS1UWPeYgN0uA36ug5O6wIkMxX22kmfb86Dli7KZxGWWy/g7jK/u5F4TgcYeEPzYzE+yaJzkFt7XJbTK6iGgr/KII7DRHQT6g9QBioU8mRnVokq5CQhR96vi/3Cx/RpRiEcMISZYrnO1HPbxTAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=c280J59d; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754294623; x=1754899423;
	i=markus.stockhausen@gmx.de;
	bh=TqB88G7sI205GAB/OWBTEwraPdPpAotdd3nrSs9o+Mk=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c280J59diVslEJA02ad66rvfJ5vOk2ALp6jtX/ifuHoXViuynUs5Ajoh/MLr3wPu
	 5zN1pj3BtjwPmWA0DI9BY1w1NZDnkNh/dkuuHRbepjOdI7db5jNit0X9SpOzM3AM9
	 lXqwJ8Lhcp6Qg9eTlmLHQGU3TAhDdpwAnuSU8cGWl5AAvj079uGnkjqchO6Xa7aRw
	 M2OIxLDNEqcEXVVO403dt/uAbn9OU/SF3fctgxseKDvgZrGRbg3gPZZGYyutHBNES
	 INYRdEFs4+6CMkMGsoVGUZ1DXWQqXT9DsFtFbJnNPsX4ZN3oBHJ9s6fo7tYSoZKXi
	 oZw303r4MnIJ7JP5Kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1uWWFg1Dmd-00qtoE; Mon, 04
 Aug 2025 10:03:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: markus.stockhausen@gmx.de,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	howels@allthatwemight.be,
	bjorn@mork.no
Subject: [PATCH 2/4] clocksource/drivers/timer-rtl-otto: drop set_counter function
Date: Mon,  4 Aug 2025 04:03:26 -0400
Message-ID: <20250804080328.2609287-3-markus.stockhausen@gmx.de>
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
X-Provags-ID: V03:K1:Xb6Z5QBZDqYurJnjHZaFbcyVZZ5Jc9R93Hd/lWpjyJv9g3C5KRz
 V2YDb9qoTnmrslAp+ywy7jJVNkC0s+UpjPCh94Y/RDqAlZwRimdgBI3kFOsBxqjpx3k3wwm
 ZRFpi67CeoXQ45u6ztzAtbpMPY5qsgmIDsMRT41FC/yJXrziCeilC4bQiu5Vmh5RK4xTovl
 6uu4GR/bhyDIWyg0rFmeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k63kHVqWMZI=;wnuyfROQS+065UrskAemgy6WyhH
 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
 eL82IbSD776PVw=

The current counter value is a read only register. It will be
reset when writing a new target timer value with rttm_set_period().
rttm_set_counter() is essentially a noop. Drop it.

While this makes rttm_start_timer() and rttm_enable_timer() the
same functions keep both to make the established abstraction layers
for register and control functions active.

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/578=
75/3788

Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/clocksource/timer-rtl-otto.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/ti=
mer-rtl-otto.c
index 8be45a11fb8b..48ba1164f3fb 100644
=2D-- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -56,11 +56,6 @@ struct rttm_cs {
 };
=20
 /* Simple internal register functions */
-static inline void rttm_set_counter(void __iomem *base, unsigned int coun=
ter)
-{
-	iowrite32(counter, base + RTTM_CNT);
-}
-
 static inline unsigned int rttm_get_counter(void __iomem *base)
 {
 	return ioread32(base + RTTM_CNT);
@@ -137,7 +132,6 @@ static void rttm_stop_timer(void __iomem *base)
=20
 static void rttm_start_timer(struct timer_of *to, u32 mode)
 {
-	rttm_set_counter(to->of_base.base, 0);
 	rttm_enable_timer(to->of_base.base, mode, to->of_clk.rate / RTTM_TICKS_P=
ER_SEC);
 }
=20
=2D-=20
2.47.0


