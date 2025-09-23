Return-Path: <linux-kernel+bounces-829683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCAB979FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5684A882A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778730FF13;
	Tue, 23 Sep 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ds4JaXvY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDE30F81F;
	Tue, 23 Sep 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664114; cv=none; b=STfAf4ktYCYl/r7ZPORF36mb9nxeNsd+CxhtCmn7p7tLYRjbUjXwLLcpoJWkWD2yeEkvqpD9t1iAHTwI/tqHMrVrY14e2C64bJCgS0rxe7LqlfPixHDnLn54NkqwvtpzEPSfrL+eVLmlsPijjRR/gkj0AS/xuNaZ2ZMwk0+Gyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664114; c=relaxed/simple;
	bh=ECBkcMsFn4KmDTT3VVYAj61+ffjiFMgPLMJThokLtQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1x9G+D2MRqL8QuzLHeIeeMhomsu8QXVDKIu46jZUljMXp4djkOqX9biaNbHCN7Y+7rs12T2gtSxFDfRd4Yc/dMK3B9KsByE5P7XCEKPa3lTShSELCPL+xTxcIccjWuOSMzDB8bhZULfeyvRCx1LRCh8NyY6uKecaQ8liXczIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ds4JaXvY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664110; x=1759268910; i=w_armin@gmx.de;
	bh=tQAbUHmjSuUbmGosyIzTRMUhLFeVVMOHlmCo3iqWk2E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ds4JaXvYa5TtFfkkMtntQdJK33Vc0kQUTKeBFjENRKLTuUC9hhxxb7Ggb2yhD0K3
	 RFYinaQwaTKWbAqUjqZmmg6GjE/KjkVpS8CFq2xSXY9l6EWHvZNzHbHRdS7bgt3/Y
	 tq3JKW++uH1EuUupVUtIBiUsWRhZdHpnQBdDX7iVhQ3jhelyzaEVsOt9s+k5o8mWS
	 MXINlbvrvGro2LlAplh2fMV66PtRQiLcLmvR/ds5ZDmVr4eRe8Zl+TgQGSEjRAmFg
	 SGwxeroyyDq7u3masusDEC28/HqNiizASUzWBuBp1xgwfrn4i2M6gUzfZ2Qe3Pazt
	 K7/w7o8vYwHZMXOeBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MDQeU-1vAYWW1gMo-007shH; Tue, 23 Sep 2025 23:48:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: acer-wmi: Add support for PHN16-72
Date: Tue, 23 Sep 2025 23:48:14 +0200
Message-Id: <20250923214814.325808-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923214814.325808-1-W_Armin@gmx.de>
References: <20250923214814.325808-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EhzcO8XDv9lPr7py9GxAfmdzGITl+BpQcRxmMd8k7u5N1oaSNBc
 oveJ00bt50rEOqG90WWopG4nlH0ixPkf6LnAxCs+IE4p+I01gfcgKQUcAgVMGnt3gMRceSZ
 sf9g7i7+zrL4lDIZrZv2ssTJxOhNvSD6npkCCnBVwLKPDDIQXEyVtS5flfWO7KCC/IGjhBX
 fKG6I4dl4TE93ved5zM0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WvumYyIndp4=;GQXLAQigQg23BTAeZd8I8HQlg4p
 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
 ghcJBMTSDsZhXcBpCTUIGLAug6d2

A user reported that the config of the PH16-72 also works on
the PHN16-72. Add support for this new device as well.

Suggested-by: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index d2cee0bdfd16..5d9b59a9a49a 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -692,6 +692,16 @@ static const struct dmi_system_id acer_quirks[] __ini=
tconst =3D {
 		},
 		.driver_data =3D &quirk_acer_predator_ph16_72,
 	},
+	{
+		.callback =3D dmi_matched,
+		.ident =3D "Acer Predator Helios Neo 16",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PHN16-72"),
+		},
+		.driver_data =3D &quirk_acer_predator_ph16_72,
+	},
+
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "Acer Predator PH18-71",
=2D-=20
2.39.5


