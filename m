Return-Path: <linux-kernel+bounces-855153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC695BE067B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7838C3583BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA631282E;
	Wed, 15 Oct 2025 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lQ2U3HIw"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D3312806;
	Wed, 15 Oct 2025 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556380; cv=none; b=GXoadhGNZnK1QkBmVl2cAhfnmv1lmu46UTq/gXZ6eO4wTeSflfTCzqoGwMnzUZe6ra5nA3QnNhXk3RVuZ281+/1nmGLEB67K1Zzff51GQBwp6WGvnF76NCBkaBgK8wssLP14D8yTwo9RBHXzeQhZegTOnf/R+4dOBMtl+U5lSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556380; c=relaxed/simple;
	bh=xhfDdaq1Unc9cMN6QLpxDObmPMdU8+NHNrOG5vZMpdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcQJP4MpnCOL+KbLlpmuNlqsnMNfU0LQY5dWqASfAhMpY23NesF41Iwb4UD/UBu+SpoBs1q1QEwaI1+v8yk3LlyGlebhpFD2wRB014WaMLH0cSIqAVqV/BL2Qm/4uLwGiB3lS3LezzbA73qD80++lWtIQ01f8R2mkfhdZMMy0u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lQ2U3HIw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760556371; x=1761161171; i=w_armin@gmx.de;
	bh=ScWlLT1GiFErwwquhnT9AoBOwr4/DPgnWqg0xKL77io=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lQ2U3HIw4BnenCAIL2dxs2JehWWf9ZCCoBUz6/TMZC/GLSTGQconYhthustLA1SI
	 sJ/1woW4uPCyTlAFmSZHCa0yUIvXWEz0mULLBPiRcBkyN6YUrGZ5ucac/QGyUimpE
	 7E+i4UmkGndJjkoX9t4UAA8ZPszTO9ZhSDH2gwqmecTtc59MMHKL982EpdblSX1rw
	 6O6eR1cQYYFfkRD3kJPak0Ci88HOfcIE/+CvQyYNWOn/yrN2KSRhJfxgsb8KgibAd
	 Ex5y9n4yVDm8hfwwjcs/JDP8QrweZFuCFwBEOeoFrTrZ6TBrWNhRI7U3Efw25CEEe
	 VPIhygTc3Y3DbIV9SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiU3-1uf2be1xMr-00YnHm; Wed, 15 Oct 2025 21:26:11 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] platform/x86: acer-wmi: Add support for PHN16-72
Date: Wed, 15 Oct 2025 21:25:51 +0200
Message-Id: <20251015192551.321200-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015192551.321200-1-W_Armin@gmx.de>
References: <20251015192551.321200-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:usPbr6ILaDvi1VkfyVjWQCvpZeu9vk27qmzwaaybndSdKEHMr5Q
 rntiGOJ1IO5oZL3//WcK7GtY6V1uWX/k7aMrmDqQakTeCdkhZDmIyB0TF1sMvfW/AcY7OoX
 19jqSLNuouXaF4kssmUil1Mg4gT7w9MhUIDb4FM0MbMbjDrtZvqZiW2gEVTYPNVuoBtD6Gj
 q6lRpJjGn9lvfDfZQ382A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kV7mfXvo1Ig=;GHKpGFsqbwAuB9msFvhaA3GKX2G
 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
 ufr6Q==

A user reported that the config of the PH16-72 also works on
the PHN16-72. Add support for this new device as well.

Suggested-by: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 4e7d52bc1917..2acb854eb00a 100644
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


