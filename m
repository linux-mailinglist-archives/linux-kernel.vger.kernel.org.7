Return-Path: <linux-kernel+bounces-741980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C09B0EBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F7D1895099
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DB274665;
	Wed, 23 Jul 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HIZvX+iY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07hLz1DV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9287273D90;
	Wed, 23 Jul 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255047; cv=none; b=HIHlQR6e2QquArdpBtQH3qtccADYCeC1Qy110qcyq7Fyigv4vPzakYbmZt1g9XNykRB6V0sRkOXx4ur4tUWTl+tz5uF97S28SqRnHoLko+GR4H6SeqxVmdQgvtwVdz2975escDAEWJhqaBk1axltOhN2pGUTdadjvRK3C9okYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255047; c=relaxed/simple;
	bh=YhPKfpcaco8993MQbBXC3OshmcxP64jy3SBerHCUi/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LUP695bEYkgerBnGLR+75q1uGIEVv9aCQ57kzckeyJ2d8tBypYQVTwqSZTHnwun6KZUJVRIvGmlzjfVH1t20h4uATNZdS2JPDtxOtQeqcboNmU7UqBU+5o1Olkk1g9kuvb1ZRoqxbtEyf7UuRzXThbgQUgq1h/6vUqIwHMwssAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HIZvX+iY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07hLz1DV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbzahddRLDJt/C8/FSzsCTONMemTNEsgRtY6yNzcTG0=;
	b=HIZvX+iYsvwaU4068Cglj+fsaXbaWlbnHJro7D6Je8riGIpCwGzmwE4TAb+yAEJFKjel4P
	rX5SCSQTS2D7A0O7hN1LtigaQtmTk646m9J0866DY6NU8/STzloIkBB8RIHYsLRWzj8H9Z
	JQoN2P0V7MKDlFvd7H7hRwhjIgtZPwFsUiGiwRIpuvT9Dv1j8D2xvfz0vfqnpvykKLSFtX
	v1xXe4eVEL10BIkv1HyZsNbd3QzwgLH9wNEVDlk76jNRTR4dqioE3m1W6/MyPp+PWSOOx6
	DgxpJezK6AKoanU8nN8qVflIvf0kSSndCjYXqvUBc+s87Q9gmutiiGk24oZRsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbzahddRLDJt/C8/FSzsCTONMemTNEsgRtY6yNzcTG0=;
	b=07hLz1DVOKlnTDl5sfGNgA1kfxO3c8eIptUSsn472SNWdTlF+y45Z6/n8UkOEQnqUGsKIe
	tXqYbj+v+aIeJ9AQ==
From: "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-tegra186:
 Simplify calculating timeleft
Cc: Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>,
 Guenter Roeck <linux@roeck-us.net>, Jon Hunter <jonathanh@nvidia.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250614175556.922159-2-linux@roeck-us.net>
References: <20250614175556.922159-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504271.1420.4588644788188854766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     05065b2a86f86603e5c35dad4274e66be25b2d88
Gitweb:        https://git.kernel.org/tip/05065b2a86f86603e5c35dad4274e66be25=
b2d88
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Sat, 14 Jun 2025 10:55:56 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:08:07 +02:00

clocksource/drivers/timer-tegra186: Simplify calculating timeleft

It is not necessary to use 64-bit operations to calculate the
remaining watchdog timeout. Simplify to use 32-bit operations,
and add comments explaining why there will be no overflow.

Cc: Pohsun Su <pohsuns@nvidia.com>
Cc: Robert Lin <robelin@nvidia.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20250614175556.922159-2-linux@roeck-us.net
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra186.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 76a5481..d403a3f 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -231,7 +231,7 @@ static unsigned int tegra186_wdt_get_timeleft(struct watc=
hdog_device *wdd)
 {
 	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
 	u32 expiration, val;
-	u64 timeleft;
+	u32 timeleft;
=20
 	if (!watchdog_active(&wdt->base)) {
 		/* return zero if the watchdog timer is not activated. */
@@ -266,21 +266,26 @@ static unsigned int tegra186_wdt_get_timeleft(struct wa=
tchdog_device *wdd)
 	 * Calculate the time remaining by adding the time for the
 	 * counter value to the time of the counter expirations that
 	 * remain.
+	 * Note: Since wdt->base.timeout is bound to 255, the maximum
+	 * value added to timeleft is
+	 *   255 * (1,000,000 / 5) * 4
+	 * =3D 255 * 200,000 * 4
+	 * =3D 204,000,000
+	 * TMRSR_PCV is a 29-bit field.
+	 * Its maximum value is 0x1fffffff =3D 536,870,911.
+	 * 204,000,000 + 536,870,911 =3D 740,870,911 =3D 0x2C28CAFF.
+	 * timeleft can therefore not overflow, and 64-bit calculations
+	 * are not necessary.
 	 */
-	timeleft +=3D ((u64)wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expirati=
on);
+	timeleft +=3D (wdt->base.timeout * (USEC_PER_SEC / 5)) * (4 - expiration);
=20
 	/*
 	 * Convert the current counter value to seconds,
-	 * rounding up to the nearest second. Cast u64 to
-	 * u32 under the assumption that no overflow happens
-	 * when coverting to seconds.
+	 * rounding to the nearest second.
 	 */
-	timeleft =3D DIV_ROUND_CLOSEST_ULL(timeleft, USEC_PER_SEC);
+	timeleft =3D DIV_ROUND_CLOSEST(timeleft, USEC_PER_SEC);
=20
-	if (WARN_ON_ONCE(timeleft > U32_MAX))
-		return U32_MAX;
-
-	return lower_32_bits(timeleft);
+	return timeleft;
 }
=20
 static const struct watchdog_ops tegra186_wdt_ops =3D {

