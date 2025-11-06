Return-Path: <linux-kernel+bounces-889057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B42C3CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6136206DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25C343D8C;
	Thu,  6 Nov 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="R1yNUuOZ"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63828333448
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447765; cv=none; b=RAegpKVt2GdT7LZzc1OokByvY/iwG8igyeHmBa8DgcPrkO16bc9PR0InaMA+S5fHw6tDIPhiKIIh0XG2+SyrbWNvAeEPCkopNDqnZNgFGyAcclPHU0DwturMTlhDYmnPHTxnbF09URWL59GAlT1p0YC6UA3qo1TTjK48xLfCrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447765; c=relaxed/simple;
	bh=yi0fxMXpQZRWPXrznY8gn/2p2+4llOSnxeMYK6PSvZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GG6IzmV2ep0LChM/1gorFvJ6zPV2LmQDn9h6jhjT6PNgBSISqC1ypcgSCG4uDRNttleYf55UyxPXwmFKGbbgQ0Gi4IISE91aWkwHsQExyGuJrSjL2kOVAf1WDqH+yGOQshT0C+PTxaWv7MY+gavpA2B+HbRj5ZPIvF0Kkt+jZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=R1yNUuOZ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=R1yNUuOZ5a+tjQkh2Z++IdKeDvgsvocMwnqI2nQ2R2RHaetSb3SNcv94UyW3CdU7v2MoC8XDfZyibMlxxLJJYc6SPcgIu/k2DmD9q/CROFLQ3uxnnGgxzA01OK5N7Bi/MM0q3FJZ50t9RMdElsenEt92bZInvpGaUSH/LyKH1uoG5SDDN6A+1mMVmoOrXpQyfZsPtroNcNYwrklTTXyA1ariGKSjEa9o7RUgV31A3VVLjoTvd61wut2uZBTxaGZdx0e3msKebGrd64rLskAbMBw49UYorpPKvflRzFQ38RYje5CtqWwc4fz8myeFI0ZHCcSxkyFUtrrn24Gvcj0BhQ==; s=purelymail2; d=purelymail.com; v=1; bh=yi0fxMXpQZRWPXrznY8gn/2p2+4llOSnxeMYK6PSvZU=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -12591747;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Nov 2025 16:48:59 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peko@dell.be.48ers.dk>)
	id 1vH3AP-0079Cp-2I;
	Thu, 06 Nov 2025 17:48:57 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: javier.carrasco@wolfvision.net,
	heikki.krogerus@linux.intel.com,
	neal@gompa.dev,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Peter Korsgaard <peter@korsgaard.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: tipd: drop double register read in tps6598x_interrupt
Date: Thu,  6 Nov 2025 17:48:49 +0100
Message-Id: <20251106164850.1703648-1-peter@korsgaard.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Commit 409c1cfb5a80 ("usb: typec: tipd: fix event checking for tps6598x")
added (by accident?) a double read of the TPS_REG_INT_EVENT1 register.  Dro=
p
that.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/usb/typec/tipd/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2b1049c9a6f3..2d4fcf62c200 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -994,8 +994,6 @@ static irqreturn_t tps6598x_interrupt(int irq, void *da=
ta)
 =09    TPS_VERSION_HW_VERSION(version) =3D=3D TPS_VERSION_HW_65987_8_DK)
 =09=09intev_len =3D TPS_65987_8_INTEVENT_LEN;
=20
-=09ret =3D tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len)=
;
-
 =09ret =3D tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len)=
;
 =09if (ret) {
 =09=09dev_err(tps->dev, "%s: failed to read event1\n", __func__);
--=20
2.39.5


