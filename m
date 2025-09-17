Return-Path: <linux-kernel+bounces-821463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459DB814F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B8A1C07F92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597063002D9;
	Wed, 17 Sep 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hdH1WFJy"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485212FFDE6;
	Wed, 17 Sep 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132659; cv=none; b=hyQJZRUGi0c9KBh2OSvzAFQIAH8Y0LlwBbfy1EJedza+y5ZFAdNwLwqBFt1c2b2coOUTbLgPei7TGUeD9ACJI2pzcCW9V58dUEBRtpZmUu5QBrKjH1gZ/aNoaxVwE2PCWTR5TUd7TsiptfrsDw+kJxyKBM5nFTLAdUNryC1JRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132659; c=relaxed/simple;
	bh=ukf89Mi5/N4oqhQaxMlLvcNfgpUTQNr3RMAtIiJxJyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7ful7n9EAqzvfQjmdrKTr0jeNZLZEmSY+dXEDeiws/nv4mvx6m6poIifp6pXSf1koZlXIH7ba8gybJWz9YSAhwMfGszE4ZCK6m7mm3oOrXl+SydztrFrtlMSu8xGA1f9SnMe1wlUUTTyUPrtpUZ8WQmD5V130s84lrLP3xnQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hdH1WFJy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758132651; x=1758737451; i=w_armin@gmx.de;
	bh=ZblnzLFdXavPwUeIgLs8kx/36vQLCHDbmWEBd6b3IPU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hdH1WFJyQHYa0U4EumSFpjfvIDm+G5IaTeiCkyVxRmxj4xN5KbC7lIlmPCcmaRlK
	 X9Hh6UHxke4JlSB2FdIbgB0yJqjIvF3vfoverf/7Nv4itYAHA+/UVsgeum53URiqU
	 Z5m9gFsVM/Xbaj8NoUQDW2mS/kGm/woGrDiUtkEWs+NX7Xf6+SHUXjXZpw04nnpGw
	 YH0XdOHytFCpDhLEHTMz9t9lQrOns8MENdkBBF3PvKG8K6/e/EoBKv+GxttPaJZQ7
	 XN2wfGY49Ydyu0lO2HAtGEl6A/ENO/e7uGqbtDbrZBy/qYqRv+DWZCDPWVG/RV5yA
	 OuA1fSFCNLpR5zTEAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MLR1V-1uh0G01Wux-00MhJX; Wed, 17 Sep 2025 20:10:51 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: (dell-smm) Add support for Dell OptiPlex 7040
Date: Wed, 17 Sep 2025 20:10:36 +0200
Message-Id: <20250917181036.10972-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:h6P1rkI8OmOaYFc1CnhvFeFlhhOQpoux1AVNbyGVwTfisgmznjU
 3WI3hNS1H8OrYSH7j9ujhCXlC2n7ovLr5ocx5dS0yptQmDNa4fFjXJdrw/oBj84xB18Hfoa
 T3uxda7RRpimkXe2DHem9r6SsuqCkuOLlQrs5DBU6Q09jCWaje+BtpU4yyIgq7hLJsOCOlU
 I6tDvgfdJ5EXY6Tp/4Btw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:um7+0C7jEA8=;We5A02L3XjuYNt9INvN2MLE00XQ
 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

The Dell OptiPlex 7040 supports the legacy SMM interface for reading
sensors and performing fan control. Whitelist this machine so that
this driver loads automatically.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/15
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 79befa13b699..cbe1a74a3dee 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1330,6 +1330,13 @@ static const struct dmi_system_id i8k_dmi_table[] _=
_initconst =3D {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7050"),
 		},
 	},
+	{
+		.ident =3D "Dell OptiPlex 7040",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7040"),
+		},
+	},
 	{
 		.ident =3D "Dell Precision",
 		.matches =3D {
=2D-=20
2.39.5


