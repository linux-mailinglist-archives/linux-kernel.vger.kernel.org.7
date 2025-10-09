Return-Path: <linux-kernel+bounces-846537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305EBC847F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B94F86DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6E2D6E58;
	Thu,  9 Oct 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LpXpAC4H"
Received: from mx-relay02-hz2.antispameurope.com (mx-relay02-hz2.antispameurope.com [83.246.65.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9812D5A0C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760001728; cv=pass; b=fYTCE3RDPgXLuOsILlXazciHpoL94pLomBgK5+TgI2vAshnruiEf/nvNYNGrOurnSXTk5pkDqYYzBqPa2o/IASMdmrRFAyKQoVFXy9whN/YwCCfMLZ6uTfRSkpL6doIrysdksspBBtPoh9M41p+b99o64qC3YlyFF4s/S8iHfss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760001728; c=relaxed/simple;
	bh=vfVoUbsJPxjF9vK6+vSGFd9S12aVkH4YrhnG7Hat7Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHy8/6d6wWjud4uAK9brzIAkCy8MQ6h8YfWAOip2jZFxhpoG5pakiyrFTJ8c/dPJAUgvRU4IjQqg66hb4SxKnn/EBuO0aMpUBgXxLwsDg6uwcv0SqPiqEsyd/lHZZAZPud/zNVaYurd3ylt1EC6C6bqvEw+aXpKnthDYuDgeHSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LpXpAC4H; arc=pass smtp.client-ip=83.246.65.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate02-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=j2KTnFVX0/Ht3bAv3F0U0EBuYjoq5BsfMsWeElo5MCQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760001652;
 b=WOcTYoHz92mWEjCBmZsap9AmhoisxcpFXYnVvxZZvJT3BZNLHHQFrZANdVJwiu1bMhqVhNYA
 fdFnrEkt7GKe0ayuj6Z9AZCBmQVIodQavD3flrCHHmxa8O7quoO5Vlz7ma+ImwBIkRgswhCExau
 5Dgc6dHu450CxxouenWfdXLFp0Tep2gdT+gPSohwamyj45UX20utYKn3/bv4c6K2I96CPLeKBug
 ei+YoUOFttoh7Hfu/l95yWfgR1+PTVTKFkutAAoS1y8JdX41yetfAJCD05X+R+KnTJOsN/pfLjv
 lpLvzfDCW4QSt8AefgxZLcz57InR386M5fpR8tdGn0LmA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760001652;
 b=UcuTJuhLTC5x3YsdjKiQ9b3l6N3/42yFg1t0Yq6fbj7zCRB/vuCkcga4gpk5o7lFwhD3UlLp
 wJqoeDz9TSZLLh10DGmAgi8Oe7K4jFB0VHvFLD7Ustc2fPKEyPcx4PIUJapzkuxDSaqSTNSkuKw
 sjmGYwVJKuCzCqQLm+7DVmsdRBzeYZK7oi86ebHe4hFPksMLb55TrFmq8NZIV9/sgMObGadOff6
 FmGIu9XrOUWRpw1sHwTtR84IDLxwX364kiNerXZAUpQRM6jV7FtsWfS56KJYWA2PT6wOqNHEvSh
 O2aL0A1z6HmJRI8GsDJvLIeB0LJD/bL9IOKiadYceVHpw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay02-hz2.antispameurope.com;
 Thu, 09 Oct 2025 11:20:52 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1D4642203F0;
	Thu,  9 Oct 2025 11:20:40 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Peter Korsgaard <peter@korsgaard.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] i2c: ocores: respect adapter timeout in IRQ mode
Date: Thu,  9 Oct 2025 11:19:50 +0200
Message-ID: <96e4ef171bc710abde215c50dd5dd4fffa98a2b2.1760000254.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <51a72ceca0154d7be85c3cc67722e7dd0b364a2e.1760000254.git.matthias.schiffer@ew.tq-group.com>
References: <51a72ceca0154d7be85c3cc67722e7dd0b364a2e.1760000254.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz2.antispameurope.com with 4cj49N4YBhz2gY89
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:54112139bb7784269948007813f8417d
X-cloud-security:scantime:2.393
DKIM-Signature: a=rsa-sha256;
 bh=j2KTnFVX0/Ht3bAv3F0U0EBuYjoq5BsfMsWeElo5MCQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760001652; v=1;
 b=LpXpAC4H+hehqgaUkECDhiOlW77td0QO0gdJqiXmcoHykxvNBx9Gh6f2sKCkvynNgDr5nhvX
 JFOKu7XU4T1ahVw0ymOrClSczuzmzS9fLrj5IibT7SErm6vk4/QiOob8X4LQX+wvp334M3IafkG
 sDVdykRUDl10PlBswabeRWMnDbpeG0nBal3XWY4i3esXkFbbPt00E8d6uP7WrXnsaOX4Z1V07Rq
 wEzoQVpn46a0tOT4Crkwx6CGxHBaQzm3LYQ/I0sJp4ENVxD84102No1uGI9N5QoEEH+7quUi0kS
 WuMheI1RC/RAUvUrNumDv8+lQd5pNCDheb5R7lYrbFhMw==

While the timeout field of the i2c_adapter defaults to 1s, it can be
changed, for example using the I2C_TIMEOUT ioctl. Change the ocores
driver to use this timeout instead of hardcoding 1s, also making it
consistent with polling mode.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
---

v2: collect acked-by

 drivers/i2c/busses/i2c-ocores.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index c4587194d46be..4a8ce167a3d9f 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -383,7 +383,8 @@ static int ocores_xfer_core(struct ocores_i2c *i2c,
 	} else {
 		if (wait_event_timeout(i2c->wait,
 				       (i2c->state == STATE_ERROR) ||
-				       (i2c->state == STATE_DONE), HZ) == 0)
+				       (i2c->state == STATE_DONE),
+				       i2c->adap.timeout) == 0)
 			ret = -ETIMEDOUT;
 	}
 	if (ret) {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


