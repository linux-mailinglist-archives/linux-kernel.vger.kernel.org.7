Return-Path: <linux-kernel+bounces-821462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFBB814E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975C53B1F38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3B2FF65B;
	Wed, 17 Sep 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="S3xTs6Rr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0E1E633C;
	Wed, 17 Sep 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132655; cv=none; b=NLE6SGzz/i6MK5f06mKO3ZNXqO/Y+p7k9/ai+879HHuv8OGB3EdafiVUUS89Y0+tf1WAIQ1bNE5zbkPyT5LybWCGqz1YhOYwAbnXQ3aqn+5e9PbXhtsfSYNgZPqHK6Xxc1nLz7DRY1NKbrwSMFQ7g12bjBUeQtek+nJ0qxyrusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132655; c=relaxed/simple;
	bh=ZSq5dJhfF6EG66vTRbYR3fBGCwLmKyzdqYnqF8nNGJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZmoKCYV8kNEKR6Ta/0LslLc0xVsVqb1VYX9bXgiu47ZfIB4NWE3+XXpZIaIivEsKBASTWcDDHYMWp7eTLgjfy23xDlyaTRCcMG8SWXgHIVs6kntW1T53BWfTzYlTq8Ox7zG2Nto+1Tyq72RRuT2OPdfy1GnVQLjC+koQNCk22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=S3xTs6Rr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758132650; x=1758737450; i=w_armin@gmx.de;
	bh=GdZkJavOAGZ1hj80m4eXs78LWz7Qve+4Q+Mn+pV+to4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S3xTs6Rr48P0EVNtrR6dgdVPpKzQjAeeOMdUYGGq9dh46PQoy3ckROoerohMyy8o
	 YVdoIPhlu8ZnJe6yz5zhtwvNg+dufQ6aqsYRlMfIjCG9lelS1QuIGiQ19hP1iaFo9
	 RszftUpaj3qdnG6ibkqx9qBBWe7C0lbMzH8lqgjkztXrngminiGgvwdpiLwLuYR9Y
	 qw6yOumE7TgB1HjREhRbPIff/7r2cwYRlgsQm/pm+me/yopE53fid6wYzGoexnTD0
	 DMy7jkEENb8tH3wiW+P+ob4EA9O/7FXhGxBYKJ/vVGVD7+aLuwCl6hal/F8/ggmI5
	 oG5RNRQCdawlPELPtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtwZ4-1u6pxW1NAC-00ypRr; Wed, 17 Sep 2025 20:10:50 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwmon: (dell-smm) Move clamping of fan speed out of i8k_set_fan()
Date: Wed, 17 Sep 2025 20:10:34 +0200
Message-Id: <20250917181036.10972-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917181036.10972-1-W_Armin@gmx.de>
References: <20250917181036.10972-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4MsQtjJanRGFTd3OpfJ1iVZNApgTFzb/qXDkZI4EP5f1/4BUFcD
 gtX37rQmhGY42WhwjCaE2GrjmW01kjulhlXqmZ2/rNpiSNWbbOYepWRuXY1ys7ybNNJ4IoL
 73doCLOE2rZwIFKLgrDrxiOVaBHhQ1iKldY8f/6SUKgGPdwTRu1DImrz7UYqeIj+ZoBFqcz
 bxTspL1B7LGU5bi0JUZlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:54yIksuKttw=;Z/PLQefFgHWR3GhNdb9bWK51+EZ
 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
 KLixVL5CYB

Currently i8k_set_fan() clamps the fan speed before performing the
SMM call to ensure that the speed is not negative and not greater than
i8k_fan_max. This however is mostly unnecessary as the hwmon and
thermal interfaces alread ensure this. Only the legacy ioctl interface
does not ensure that the fan speed passed to i8k_set_fan() does meet
the above criteria.

Move the clamping out of i8k_set_fan() and into the legacy ioctl
handler to prepare for future changes.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 3f61b2d7935e..36576db09706 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/kconfig.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -446,7 +447,6 @@ static int i8k_set_fan(const struct dell_smm_data *dat=
a, u8 fan, int speed)
 	if (disallow_fan_support)
 		return -EINVAL;
=20
-	speed =3D (speed < 0) ? 0 : ((speed > data->i8k_fan_max) ? data->i8k_fan=
_max : speed);
 	regs.ebx =3D fan | (speed << 8);
=20
 	return dell_smm_call(data->ops, &regs);
@@ -637,6 +637,8 @@ static long i8k_ioctl(struct file *fp, unsigned int cm=
d, unsigned long arg)
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;
=20
+		speed =3D clamp_val(speed, 0, data->i8k_fan_max);
+
 		mutex_lock(&data->i8k_mutex);
 		err =3D i8k_set_fan(data, val, speed);
 		if (err < 0)
=2D-=20
2.39.5


