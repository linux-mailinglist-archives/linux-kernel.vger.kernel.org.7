Return-Path: <linux-kernel+bounces-861170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E9BF1F96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61093AAB75
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA25227BB5;
	Mon, 20 Oct 2025 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fo9tQI2G"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BBEEBA;
	Mon, 20 Oct 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972552; cv=none; b=ReOXh+p4wgKtOJftrWq0J9+u+J77f3mZmTodiifbGqLd5MPSwh8Waw+xgiFijGVl5Ed5Zqcutjxg6KuoK10Z3ahvJRUXf7E3SKbZjpn2MuAweJOu0IS5GdI0CYSpd3K/yH4Mxz/3ACb00KvJMRbKQzz/6Q+t3+ZST4IUO0jTDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972552; c=relaxed/simple;
	bh=SVXraSLrxsqmpcJ+q3f+nXwD9xtbvdEgXHqmD7HVJVE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dNSQs/dMKKHFcva0Xm60yUiSrioiyi0p108dcul18Am/CCMJ/RNQxQKdERmbgIk6Ef3Vrfn1PrxIVDWghnhHqiOLtLu9MaXoyTaGIQIzwrljfpHp+Lym/AVT/nL5LEIHZgSgCBCxYGBFJxblttRXp9ERnKGRzWK/PJPKHlaU1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fo9tQI2G; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760972547; x=1761577347; i=markus.elfring@web.de;
	bh=AhgSzi121OSzrp5+0xC0gMOVmYB06QiIuOwMIXy8xf0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fo9tQI2GR/x9GDWxqGyaWlh5kcWWDuImXMydiE2e7htTfkaT7M7D31NKqcHKqGFP
	 LTjGiAe0ZPm7799deM7L+ZLRoFf1ESG8MkLYwk6u+VtpOvKTc9KQWRzpnXFs0+kpa
	 X3xhz5O9W+cvP1Kp7qxZ6AcTd2z/7emGr5hBLxTp4bEQLnRrRLmigHEykZCQTNuqq
	 /GeUg8mLk/67tvhfmeT0Ff1w+4hHyCXw2fJzLlJM01dSmdpJLPkMVx+7btJOaPPSf
	 6Z4fhCl3jZtGxg2XbcDyU8YYBxJiSchNcKaauHKdJRvbmNvrEhEUAKN89CeE+Wja/
	 O3855qg/9i8Lb1WCgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB3s-1v2d931Ize-002oIJ; Mon, 20
 Oct 2025 17:02:27 +0200
Message-ID: <90a2385c-9d19-46f2-8d31-618d5c10aa91@web.de>
Date: Mon, 20 Oct 2025 17:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/x86: x86-android-tablets: Omit a variable
 reassignment in lenovo_yoga_tab2_830_1050_init_codec()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hq4sLPmdrjIAT2uCbIoDdWLugvvFOsZY8s1+AHsXtb/BTLtaAfd
 rEDG6FodgeXegV3CB/GzutsbsoILwHcRf/1mlplXN45hwzrD5sHtsOlbKhj2ryXQvtjUDQJ
 v/V/893GgADKrB3MXvNL4qMz0P7i7d3TaNut7u4hFOuxtD9/DjkITmtVkceEu5R29U/9SAt
 nkEVP2ReSXKC/Ch4NBoug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y1RdMXSYtvk=;E4CBZDfGlXbN9CW5+uf4XUlDwNz
 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
 Zvr4pppfIHyoxdYso=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Oct 2025 16:52:35 +0200

An error code was assigned to a variable and checked accordingly.
This value was passed to a dev_err_probe() call in an if branch.
This function is documented in the way that the same value is returned.
Thus delete a redundant variable reassignment.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/x86/x86-android-tablets/lenovo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/p=
latform/x86/x86-android-tablets/lenovo.c
index e3d3a8290949..8d825e0b4661 100644
=2D-- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -543,7 +543,7 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec=
(void)
=20
 	ret =3D device_add_software_node(codec_dev, &lenovo_yoga_tab2_830_1050_w=
m5102);
 	if (ret) {
-		ret =3D dev_err_probe(codec_dev, ret, "adding software node\n");
+		dev_err_probe(codec_dev, ret, "adding software node\n");
 		goto err_put_pinctrl;
 	}
=20
=2D-=20
2.51.1


