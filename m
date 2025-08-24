Return-Path: <linux-kernel+bounces-783560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F79B32EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE317B37F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741726058D;
	Sun, 24 Aug 2025 10:27:58 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78743217F33
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031278; cv=none; b=OIqVs6FKOknX6V3QceW9Jm+kpC1N798TH63RphFeVTppAGG39C4zzdAVvOrPDOxJ9YAfGRA8Ge00jFsdlcsRCPODUnANgS7AJx/nVTqKM7zH2bhK5vCyuElK6h1SbXoYfbZIqlttDQcuzRuB1KEINE1wpjCraAbRAkz7vy42a90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031278; c=relaxed/simple;
	bh=JlyeosXCC3Y21yXM1bpFbp5fchYWPw4Y/KvaR0hRdRk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=uYMXqt5BcwO/W2l/az51arzxd3OeItS7VmMOQXVTkmlQoWKvZMb2IMLC4WNtrVPmCBXrMK4uS8+rQDMpzc/fzwBapxMw/US0VBL/xQRnIF+ybgozCKdosOYuCMy7oPp0F5ZcCv/eNWJLE5PZPQr2DFh6XKMqjiqmfDptRAt3PiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57OARmJA051219;
	Sun, 24 Aug 2025 19:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57OARg0q051211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 24 Aug 2025 19:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
Date: Sun, 24 Aug 2025 19:27:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Elenita Hinds <ecathinds@gmail.com>,
        Bastian Stender <bst@pengutronix.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] can: j1939: undo increment when j1939_local_ecu_get() fails
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp
X-Virus-Status: clean

Since j1939_sk_bind() and j1939_sk_release() call j1939_local_ecu_put()
when J1939_SOCK_BOUND was already set, but the error handling path for
j1939_sk_bind() will not set J1939_SOCK_BOUND when j1939_local_ecu_get()
fails, j1939_local_ecu_get() needs to undo priv->ents[sa].nusers++ when
j1939_local_ecu_get() returns an error.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 39844f14eed8..797719cb227e 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -290,8 +290,11 @@ int j1939_local_ecu_get(struct j1939_priv *priv, name_t name, u8 sa)
 	if (!ecu)
 		ecu = j1939_ecu_create_locked(priv, name);
 	err = PTR_ERR_OR_ZERO(ecu);
-	if (err)
+	if (err) {
+		if (j1939_address_is_unicast(sa))
+			priv->ents[sa].nusers--;
 		goto done;
+	}
 
 	ecu->nusers++;
 	/* TODO: do we care if ecu->addr != sa? */
-- 
2.51.0

