Return-Path: <linux-kernel+bounces-829697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576DFB97A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B341A4C4917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9630E847;
	Tue, 23 Sep 2025 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D0+JZm3p"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DF3101B7;
	Tue, 23 Sep 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664345; cv=none; b=AbIe08u1pYdZ+nq+S1CGLNkKUwsoKoiZ43H1VG0ul3e1b9mzS7v4vJfwdaRTr9KkXGC0R7R95pbJFil77gne4a9PKHE6IXSWfmV7yilOhQSgicuZ79oOWyiZASkW+6WP1ckkn8jmkX33f/OCQBdMilWnI60W/3WWGsFYBXbxhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664345; c=relaxed/simple;
	bh=vP0rfFfbX2Y5nskO8oeJ+VXjBm+1n+gBclQxeFP0wFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JgWiu4An3nACnDMC/hEV7FBaMqUtvdPD6U3cEB0PYmoQfzeGOS96X/BYbg8wnC25RVWR+q/H945wp31o7tNURBgdK+tm2gEFes6aNMbhKguE4TyX6KNFpb/REUgFjRms5IqcaTT2n86e2wyzT5LRfO8ew5rK/FTPQ4PE1Hp0c4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D0+JZm3p; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664340; x=1759269140; i=w_armin@gmx.de;
	bh=fI7YZhteYMKWBgLic2yEZYfRR7J0OV1zamQFNTo+BTc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D0+JZm3pNRsNEP1zshcRE4JLwDIoCaDsQUAMYWQqjm2YIJBgMhx78LU0codWf1gW
	 O4o+HBIZxQphrADbKnsuI+3+s3lmD9d7VjqoFitWfS2X0o2P437iM7Qj3PjHOxY9E
	 AOio7kWO4NZf/EkG8yDo7mH0bj6VJcpoiiiixQTQNcMbyMIDiEg6fUgJBssV//uy6
	 d2gv/AtM69lh4lol96rnTji+aikhuCD8hbRdta3aBqys2EwLwWB5/7wKhGCDFB6Bw
	 gMY0ExfCNh2YJTvYC5crYWfMS7TKJ2v68nbs41gEUjQfSE/kPRq2CiN8O0e2ERP+k
	 hd4IqaW65UMcp3JWkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1McH9Y-1uVQ1A1yqC-00dCEb; Tue, 23 Sep 2025 23:52:20 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: acer-wmi: Add support for PHN16-72
Date: Tue, 23 Sep 2025 23:52:05 +0200
Message-Id: <20250923215205.326367-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:D2lZe6dbkXlu0oL63/ZLSNZfW0eYkj5yRYbIl5R2KwznYOMl4i8
 GLyUwaWyUQxtyKb3MAfdmJL6F5FN1K7gIQFtCtokUr7nn/zFxCnSC6X+SIxlkEjXrJdiOU+
 iIQoaUvGcS88yzcsI1rAKI1wPOJXOjx/R8oFFZa3sOP3faVM2mvsNdKPdzsywvrGluKlXR0
 IA18JcuTd0n2TiB4kKHFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vovkw9vswPQ=;A5K/KPiNoV4h0bGLMWNeSGrpMDl
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
index d2cee0bdfd16..485ed034651b 100644
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


