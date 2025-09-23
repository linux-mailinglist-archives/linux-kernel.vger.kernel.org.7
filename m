Return-Path: <linux-kernel+bounces-829696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED3B97A55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF811AE0BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2955430F7FD;
	Tue, 23 Sep 2025 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="V6Yx/ld7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B930F932;
	Tue, 23 Sep 2025 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664343; cv=none; b=BDdAwl6IkuGGXiKheMVRysX972K0CCPWJgJUQ/8n/jiGZ1UHia6UT12yf0EmX0d/+DeHtax3mam5VI5+FePDVQTEFATgeYZfDOIEIMo4ZXM0/+x0E1Ts4rxfobjIE4XFP7CK0lWYeo7OVdijsRNBDOPWBRyNKYxXOeGnjphpiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664343; c=relaxed/simple;
	bh=TybySjPSdI0AbM7DD7yiWdNvqREzv38/4l7szF/TwTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5zyuzbtJPlDHmt2UpJwv/ucBa4A2dc0xz1FqVL4ZDDr2b7hdpiuvlUrxOk/xH6+aLWOX53z90RfeaOtimZcM8I8OAdHdfrKU845bMF5IJ1DGHbvZJjdzZNWH1jzU8JSVqhfMtqaXD4zYyRhg0OzaAePrfPF3kLc/tSo0MUk1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=V6Yx/ld7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664338; x=1759269138; i=w_armin@gmx.de;
	bh=bAbCz7UgPT4LDyKJA8LMJdrOGazj+Rx3x+iekx3ff9g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V6Yx/ld70t61mYl2JnYB+MnN4SvBJqc6D/P1NaOoAIwrd4CH7BfT6zOd8lLlj3q/
	 HUb7oncSz4XtYgeqHWo8C5e4B49zvFe0vAdLDXhHcsF6xwS4VvMu8ZQdNMlm2tV5T
	 uUBB6FL/elPLVJ9jzW1lEZwDMKLsZ+M1iPcufwanJuwuVVxWHr8BkoVt3+dhrSC8B
	 8Xu4FzaI5sO2O2kbKnkt9G87dimN7qTyrZdcDZzA5A9ZwUhvRarACPiZBudQvMKuO
	 7DQ7HoShxGDDdG4dkdr6ZU5AbLSC2INk/ORwuJjdnSpv8GRHMD/GM09TpRyDHZoNF
	 jL1WhM8YfhjKLKUQ4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N0X8u-1u7GOE11ee-013Xf1; Tue, 23 Sep 2025 23:52:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Tue, 23 Sep 2025 23:52:04 +0200
Message-Id: <20250923215205.326367-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923215205.326367-1-W_Armin@gmx.de>
References: <20250923215205.326367-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uDkShLKuJpFHENf99luwWWI+WoeUDUn7N1oA+BwnVuF9AOSC4tM
 yVChseM+mKlfTSvC0ZIdmx+8k81yHG7jtie2U3C+zoAnRMCZv2d3U5LoUFqW/GrSjfMgaBK
 b6JBFBvnIM/w/7bUYc+s899Qv0GY+OSBIQ3718qvq6q0WmpPBRn7Fta9sVTyouZ5p9oXx7t
 0yEo6vJD6pSPaycg85VYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DS9sC7d8F2A=;NUvMfCKz91t1adpTrMC5flxQKJW
 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
 Q32BUj2IJQhGEflMK/n

Both machines support the necessary WMI methods, so enable fan control
for them.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 345b6e24ae31..d2cee0bdfd16 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -465,6 +465,7 @@ static struct quirk_entry quirk_acer_predator_ph16_72 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };
=20
 static struct quirk_entry quirk_acer_predator_pt14_51 =3D {
@@ -472,6 +473,7 @@ static struct quirk_entry quirk_acer_predator_pt14_51 =
=3D {
 	.cpu_fans =3D 1,
 	.gpu_fans =3D 1,
 	.predator_v4 =3D 1,
+	.pwm =3D 1,
 };
=20
 static struct quirk_entry quirk_acer_predator_v4 =3D {
=2D-=20
2.39.5


