Return-Path: <linux-kernel+bounces-856754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9396BE4F78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50A21A68771
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F52231A41;
	Thu, 16 Oct 2025 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tzZDCCjt"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C2224234;
	Thu, 16 Oct 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637626; cv=none; b=d8hu7XpPfXO5tqbecRLmZOepSOHY+9D+7gTTTRI8xAwFSOZP5Zm3kAAZbElfncrK0BxNDjadj6BZs0LOmdcf+pfRL94+QxpwfhXz3PKLiYUFlsQRG07u7kQ0hk4hgP7CPOCv5gGHn4R8upm7BElkNsVKybeZvQhWTOCqjpqH9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637626; c=relaxed/simple;
	bh=nTCnopvomBbbhDEVfDMg8KHM9kp79qFjrT8iyZWqf7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZ/HmgfV+R99LBlbUs+iwdx8XxdiLxgYcuDd6voxhCHFJQeCvdwXHAaPdmaxUkQq2IQnfpsTfxsSdESOK0qGoYsq3cMMOY4JNZ7uWg8fKyD9+2UbHSypn1QwqyQjyh17F1JrlopfnI11fE6nWKUUvNLoAPKW0QMH3mQ5aOwzL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tzZDCCjt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637621; x=1761242421; i=w_armin@gmx.de;
	bh=ainMPm4sucZtlFZCEpg1yT6vzPovKaNnr4gi1e6aoCk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tzZDCCjtfyhqF3KWE4qdnjmALFiAdv4TLYz2mwTxzf5cuCSAe8vi1QAmydvBrBTn
	 zcBNJyGRAOkO3ICIZtOcpdLT+nF/UOTMgjjAyR8HpWqPv5ERq4GH7u9V8gjEXkbEG
	 udnZB1PIFKs9p+mQhJGm94PxwyehHbB/Ipi+GCYiI4wwdS6Cdw6TtfuJ7kjtq6zKu
	 tAEU3yX2eOVpyKifLFgliNg1TwHSO4DTPVMsDJf4TyaDZYD4Ldprl3/HkeUBGN1dc
	 b5CvyYUuhlB5DaVIWNOi8ECddPC1TsXyKEitTfHu1a0LwkTlIcOk5tN4BFdE6pnP3
	 yp9uzZCecHLOiBlGGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMofW-1ut1sn0aBA-00Nrzn; Thu, 16 Oct 2025 20:00:21 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Thu, 16 Oct 2025 20:00:07 +0200
Message-Id: <20251016180008.465593-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:NnjxcTjw2BsFNsy3arWz9wJe1JkyYtYxIDg58WdLvvf6Xf3+pxC
 QGHb0mXOF0jI7jZnD2jWxCcXeMCGNmSVzsyJbrfnzzRn3UihQYlhC6C3Uyq5CnMXpGH1LlZ
 EaePg/dNk79tpK226CyA75yhDtvfHNAQxjER2sHsDa2fqAoSxNUWFhZ7ViOQxHZeLri+o5q
 D+Y3rPkTSMAEF8VUf1uUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qvb5NBcCTLc=;xP8Hfd45dYuDzwWLSddt0qg0PpI
 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

Both machines support the necessary WMI methods, so enable fan control
for them.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 80b6b79157fd..8dca96c6b58c 100644
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


