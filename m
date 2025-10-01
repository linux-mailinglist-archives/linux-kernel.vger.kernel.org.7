Return-Path: <linux-kernel+bounces-838818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D1BB0369
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652D166B8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78B2D949E;
	Wed,  1 Oct 2025 11:41:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16F2C3761
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318863; cv=none; b=emy/uVutxwBnoP8BQr4cizKucK/1rgmqoUtxeHpT41TEntkjMxVZpwhPsTCxObIDp/oD7HrdvtMSLRtO8TiszXJl4oxbvv/jAIijJYXOUv2hGgFG++r4Ak9htdkWRrsgkN3sXIUbhI3AlW6FE+AkRcXvMdwN5v8gV+AUDC860AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318863; c=relaxed/simple;
	bh=Q5FxtEYvVOpMUeP3v6q8TEC3bcul3a6j2vMZSItNoU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WnthI53+WC4whQgfoBFGI6RN3GP8NXbM50A24aI5T9A95uytzMrrhOheXAVowre8rk9bFwZr7m1FwsHj9bgbYh5LKgs9oLlwHsCFbNyteD9gFUlAsuFDNsOgFtMtqw4V6i0L564Y6dXwDkMNC0GylCZWSsWZGZvS/AwtH/Cy2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCb-0006l8-Tm; Wed, 01 Oct 2025 13:40:57 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-001PBa-2x;
	Wed, 01 Oct 2025 13:40:56 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vCa-000000081FZ-3WS2;
	Wed, 01 Oct 2025 13:40:56 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/3] tools: lib: thermal: compile/install improvements
Date: Wed, 01 Oct 2025 13:40:54 +0200
Message-Id: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYT3WgC/x3MQQqAIBBA0avErBtwDKO6SrSwmmrALFQiiO6et
 HyL/x+IHIQjdMUDgS+JcvgMKguYNutXRpmzQSttSClCJ2PaOOzWofiYrHOo6kYTtZbHykAOz8C
 L3P+0H973A3HYoypkAAAA
X-Change-ID: 20251001-libthermal-install-0682119aeb35
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759318856; l=683;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Q5FxtEYvVOpMUeP3v6q8TEC3bcul3a6j2vMZSItNoU8=;
 b=eTICfwMUVRxdyvxdLlGY2fUhGjpheeTQ0VRqe7lqU+727EuUUSjwGbpTCSkdrXEmrCIu4njzk
 pw2NHCqIkJQAHlja8Tx0AvPxE4kbGzX4kcakr3HXqkzgIHCAwquVHJk
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series contains some installation/compilation improvements for
libthermal.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Emil Dahl Juhl (2):
      tools: lib: thermal: don't preserve owner in install
      tools: lib: thermal: expose thermal_exit symbols

Sascha Hauer (1):
      tools: lib: thermal: use pkg-config to locate libnl3

 tools/lib/thermal/Makefile       | 9 +++++++--
 tools/lib/thermal/libthermal.map | 5 ++++-
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 50c19e20ed2ef359cf155a39c8462b0a6351b9fa
change-id: 20251001-libthermal-install-0682119aeb35

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


