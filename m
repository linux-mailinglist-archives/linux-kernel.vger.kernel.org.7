Return-Path: <linux-kernel+bounces-856755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A96BE4F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AD51883DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E12236EE;
	Thu, 16 Oct 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iEa27yoH"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57860233711;
	Thu, 16 Oct 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637630; cv=none; b=iXmdTzL5Ysw4d3E1VAkgvnK96CHURcnArwQbuWXTXDAyK5E9QLtbiWH8shW1KuYl+Dcz6Yld1ezm6fPdQLw+JJ4m/sLKkaRhMB3fIPocX6yvCnYJI0eZ4YLz9jkb7MZCym4lleDqpBBZjZz/wfJlVju/5qogRxIPh/EmlHOAXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637630; c=relaxed/simple;
	bh=l+173Njiv368aUOc8LDgAyvBO+GAVC5je8MVmPW2+VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4R0Yl+usbT04rYuXtC7rrjndIPZ4wjwdyT+T49Mnyrh8HcRHOxe0IHS5jQbg1VCC3fYGe/WYPdZ8rkiXbuRkCvjFSxl6WS3n50LDF8lOcuWAWs+BilBSJVOGaijF2HZWbflUSR79mxCnDxdc+DWvAl7cpBMpESqHaTMtsPQKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iEa27yoH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637623; x=1761242423; i=w_armin@gmx.de;
	bh=EduiAjdaZomhgAgO/2nAJCRgCfn9uKoy8lTO51vRKGs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iEa27yoHtnXJ9XBlL5Vea7MYTgAcX4x7qT/QuarqqNdvhvbeVUiFcveVyLuwnFmV
	 Ao53pze5S2cpva6bGeYBSaW8MeHGB2C1n5x/rnbMxRTztixFtR2/VQDCeWA0KL2L0
	 YmtevBzyK+3xGM1qT08Hr+V1Si+WvF2cT3guSkNCTcjGz+YbklNybY1PAi0Pe80mI
	 fC6Cpz+DgUG+H6Gm6ViG3APwvi/SnPu54lfszBzmleHmBwEEmUnsd0wh9DrHKSSE4
	 khR0rCcnVGgar9QA9Yr+YHIZFeOOrImPdM2ABMS4m18Ic4Kfwf/+LrfJ3jxxxrBn4
	 IeUeS2zfHh0qTBMALA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N49h5-1u9kxy0cDZ-014wHs; Thu, 16 Oct 2025 20:00:23 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] platform/x86: acer-wmi: Add support for PHN16-72
Date: Thu, 16 Oct 2025 20:00:08 +0200
Message-Id: <20251016180008.465593-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016180008.465593-1-W_Armin@gmx.de>
References: <20251016180008.465593-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X1Y6Dv2d+ud2gzQ5SZctXiEYyP5phaLzMVYt04jTumOBdjhszeg
 nZy3bVjs2PwnWFPbL7i7BCs2xyw7Hn09stuwgGdHMW/HxCseX9ZwbFoqEtf6rrsWlNsDnua
 1WOgsuqnpDWW7I/NJ7Z/ALgbDR0plH+2bqK4PUakCvHyjboI9xIjkiqD1fKawnJmcli9RuK
 gzvnPaoPTHcQNsCrQ4qlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HeMPZHTrm2Y=;Ni8TVqv61wFbc6Mt2aDiv5mjLsO
 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

A user reported that the config of the PH16-72 also works on
the PHN16-72. Add support for this new device as well.

Suggested-by: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 8dca96c6b58c..4ac39929a8ca 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -692,6 +692,15 @@ static const struct dmi_system_id acer_quirks[] __ini=
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
 	{
 		.callback =3D dmi_matched,
 		.ident =3D "Acer Predator PH18-71",
=2D-=20
2.39.5


