Return-Path: <linux-kernel+bounces-829682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED4B979EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C9E2A5D42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6330FC0B;
	Tue, 23 Sep 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mm6vZ/Bp"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EF30E847;
	Tue, 23 Sep 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664112; cv=none; b=b5f9TqLe7Ye3sCRJAgwoI7DX4O+IfNeIkD2Nd1VbAyx95vE7L/Plyx80Ox6l2yiSgs2bBqX87P+xqClRuDBC4fvNh1uatBwlNr0oHAjvAk53HWTaSktst6JDg52o8z3txwMHUbxJcVNn3o2h2l0+hGN47M+Rsv2yOy4qjHuASAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664112; c=relaxed/simple;
	bh=TybySjPSdI0AbM7DD7yiWdNvqREzv38/4l7szF/TwTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUf1A6zfxJ1EwkFYloQVybnXWyy3um6iu4BFoSu8OmfLR3kxx2ue5EJHTlf2G0PEsnOCBgVB6BcYe3YUPRhNyoz54NRlYWAqonFAb8AUZ6k3AKarPG/QAxeLsxxLNxrTjBeHslEsyENALANiW0CjKP8Dw5vqRIjzI1DNO8hJYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mm6vZ/Bp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664108; x=1759268908; i=w_armin@gmx.de;
	bh=bAbCz7UgPT4LDyKJA8LMJdrOGazj+Rx3x+iekx3ff9g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mm6vZ/BpLTT3rO0TPnJ5fQir98xlgAeX/ye88t9/KZoB1Kp+lxaVza7Q8kKkEoDc
	 4aDUcXHaC5ogXzDCFwIlRP0Cn+PL4wCD1zwyAB1soUscxST3GrscGdFV8pGqspZOe
	 A7+lJ1W9n/d4if26gG+1o1fe11TJ0vjvC0/K3rgPW9Q1MgPW5gdY0muHwpKaO1/rd
	 0B65w6pnHqAyWi15UocMvInXVHj790apBAMCFuNgp/0T64CWe7dFgrKXByoAsCRye
	 KTgUDD4hBwfy1IP4/o55rU7zrAJmSV5wsc0lhnWIPViJgRZPUiOiUl6I/nzcp9/4A
	 XHAt8/jFiUg4Uf+0AQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWRVb-1upRhv0d7j-00I8Fb; Tue, 23 Sep 2025 23:48:28 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Tue, 23 Sep 2025 23:48:13 +0200
Message-Id: <20250923214814.325808-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:ck7KzcwGNkSVGGqN2OA3AMWQTEHVy1vSl6MRc24f8UdPu5b9Y3e
 yBfxl6O/tu4ifMalYxxb/XUOg+EAc316ssU+QOFw8yhVMmreiu/lXNX8i4TPtNZeJBDIxv8
 7qgRfSPK5lklphNYZX7PjqAmt2kRmLaAgVk6e7756Hei4cJlKcPlXrDKTrSo003O3HKyY4g
 ZYwft7HghTmHGiIYCcWeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0aWWfpRrP8g=;i8gGhtUcaQhEm2DY46GBm3kpIwl
 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

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


