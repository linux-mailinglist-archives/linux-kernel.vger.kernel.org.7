Return-Path: <linux-kernel+bounces-899098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B5C56C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63C594E9BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266122E0B5C;
	Thu, 13 Nov 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b="KGef3YPh"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C200429BDB0;
	Thu, 13 Nov 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028446; cv=none; b=N5JRwKx+deL78it2m5lflFxZ1hhUo/RmGU3S/twUciP11ynF/K+pLXWNWfx0i5P2Arn2hcozWO9t7cZ8cfQNm8moPnKOu3c89+PGDOWFsGsjZI3AqpwYviK2Qy/Qu6NOLjfxIucWQXDE8EL7M5C2waLftuHanOuren3atHqf608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028446; c=relaxed/simple;
	bh=hwOO8lce2sNESlltEsz9UBCVjNvi3fzRZbc3isrv7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0ufwJvkqIcQeSTI8Mahc0QcziaytbJUX46lcHNLhxBMScKsyyNUh0mcQH05KXBGhhKWh0UNHYSDhwMtG9KMphqDE7ha80kzRtam39kZHf0x5qf8Mm3GGvChFKoGG/HCoehb9WYDBhCY8CBnm6iwGk4fBhWh1BKAUPy0l/lRo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de; spf=pass smtp.mailfrom=mariuszachmann.de; dkim=pass (2048-bit key) header.d=mariuszachmann.de header.i=@mariuszachmann.de header.b=KGef3YPh; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mariuszachmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariuszachmann.de
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4d6bPb2yc2z8gKn;
	Thu, 13 Nov 2025 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mariuszachmann.de;
	s=key2; t=1763028051;
	bh=hwOO8lce2sNESlltEsz9UBCVjNvi3fzRZbc3isrv7Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGef3YPh77PeSFNBKrTpyW47lbXSRVKsu4daCDPes56vmua5W67/rrMWAl53IuNhi
	 Ky1sGi1hZKQntpwTlvpyyBmG5Iq4Xs2ROu5JyzplwT5ULYVnvd1kkiUUxV/07u7mjK
	 LLXNjn1z+CKVcDGErP03UORJSd+z/lsoHkQh8cqoqrvzXlt2BEXjOsFnOyCnCXCrBY
	 qrLtJVF2Dv7g57EwFwCKA4TuVbl7m/eK/1eayROyKpkt/qlX7zvbrHYNBGGSbTS4p2
	 R+wLUsS3ovxvTPPjnEW0ngBhdyf6o0GYiq0QmNUcitQQtmzrjo3Y51QKonqAEmpsP2
	 lfyto4x/0UVNw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4d6bPb2FlCz8gKj;
	Thu, 13 Nov 2025 10:00:51 +0000 (UTC)
Received: from mxe9aa.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4d6bPb0RB9z8sbC;
	Thu, 13 Nov 2025 11:00:51 +0100 (CET)
Received: from marius (dynamic-2a02-3102-8004-0800-b21c-0b06-5865-dcdb.310.pool.telefonica.de [IPv6:2a02:3102:8004:800:b21c:b06:5865:dcdb])
	by mxe9aa.netcup.net (Postfix) with ESMTPSA id 149C08009E;
	Thu, 13 Nov 2025 11:00:50 +0100 (CET)
Authentication-Results: mxe9aa;
	spf=pass (sender IP is 2a02:3102:8004:800:b21c:b06:5865:dcdb) smtp.mailfrom=mail@mariuszachmann.de smtp.helo=marius
Received-SPF: pass (mxe9aa: connection is authenticated)
From: Marius Zachmann <mail@mariuszachmann.de>
To: linux@roeck-us.net
Cc: mail@mariuszachmann.de,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Read temperature as a signed value.
Date: Thu, 13 Nov 2025 11:00:23 +0100
Message-ID: <20251113100024.11103-2-mail@mariuszachmann.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113100024.11103-1-mail@mariuszachmann.de>
References: <20251113100024.11103-1-mail@mariuszachmann.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176302805038.2250114.13495403452605665157@mxe9aa.netcup.net>
X-NC-CID: Tf9+vAFxafhT32NVSJoChcpQ2OXf9fmixHfx6Jftn5GxkM2EZ6c=
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 149C08009E

Convert temperature to s16 to correctly read negative temperatures.

Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
---
 drivers/hwmon/corsair-cpro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index b7b911f8359c..6e1c415f3e26 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -40,7 +40,7 @@
 #define CTL_GET_TMP		0x11	/*
 					 * send: byte 1 is channel, rest zero
 					 * rcv:  returns temp for channel in centi-degree celsius
-					 * in bytes 1 and 2
+					 * in bytes 1 and 2 as a two's complement value
 					 * returns 0x11 in byte 0 if no sensor is connected
 					 */
 #define CTL_GET_VOLT		0x12	/*
@@ -258,7 +258,7 @@ static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = get_data(ccp, CTL_GET_TMP, channel, true);
 			if (ret < 0)
 				return ret;
-			*val = ret * 10;
+			*val = (s16) ret * 10;
 			return 0;
 		default:
 			break;
-- 
2.51.2


