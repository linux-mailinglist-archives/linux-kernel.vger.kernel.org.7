Return-Path: <linux-kernel+bounces-855152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D5BE0675
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1109C1A22B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D430DED3;
	Wed, 15 Oct 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EdON7tvi"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752D30E0F5;
	Wed, 15 Oct 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556376; cv=none; b=fRKBvoac3x3VhDCCwbxT+64tol7XU2bcOHv2H8R9LwyNrKoM+4O+vSU6rIKxktaorQqhxMJJVn+2yeOMzXA9k4a8QUX+lQ+QXmKhKFJcfYFq1kg+YTasUlpEfUDsFtk79us2PWKG1Nnuz+zVRGCXOMw9dt1UEhUP1Yke/D7blEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556376; c=relaxed/simple;
	bh=0VeY5uZj9Vw0jPZ/wxa6y8pDmM8f/8gA67rr+yivvH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E92QvrDg+ZkdoofYG3PWKfUAcOAq1paklnmU24I2QZ/9KsZYW+8yO2qm3BmtnptQL5tUDzpangO5Nadso+k3uVMH0TZK1nLsOQt07HEuVngZer54CR5NE2VMFAW/l2waInkIeFx6+bkFltIa09/86+UX3pXTdAtfbXP6hgnORIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EdON7tvi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760556369; x=1761161169; i=w_armin@gmx.de;
	bh=gecGssB62iyEw+0UgSTSVIacQx/1Wq4YlXl6Zbf1CtA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EdON7tviNYEfy+K/1zGs+lEdGesmaaZRs2py8rePDRVYtVVAkTVT4py1Z8seSiWy
	 /yxUF4hLSa45ji91HmPUJ8xR0wkPfXHWz1ueN5xkEfk8S3cx5sTfszo3jdhRA2u6n
	 atOZj0esyG9/N3sZ7GFY0h6Iw/qzvnPhfnHI/KN8/ybXG4v1QxEOsJcS3L4O53353
	 2acV0MZFYYt9MLr/4g3UbSv8aWQSN8BjsS9vvIAQ/1Hp4CWOpEfqn2iS45JXF8Jfk
	 cLwvb+0roFAunmHuiU0p2uW6tStXGeyBIantLXb16sR+baTNW1+qB9DorDJmkqOHn
	 baFaifzzQdeAbmWFqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MpUZ4-1uS25l0tBs-00lthz; Wed, 15 Oct 2025 21:26:09 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
Date: Wed, 15 Oct 2025 21:25:50 +0200
Message-Id: <20251015192551.321200-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:E/Va/ZSunPn2Y/BfjHZx6RHbOA04e1Ns6GpcgD8j2rAuyDzZQak
 kxRZGQglBjD+/RpL8rwDGqy30kXOD0+SxRj/l23AedBhzGTcMjw4LXD1XprzKk33/SfIgne
 hk/DhHzibfclqC22mSUAXsd93jS0uAUw91U//qvh1SJzAdssWjTbpi4JilOEREPYha72Cs/
 sFTcCBweUkhG2+v5RLiaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mZ53YjLGxls=;jcsuWhx2nzXFxdlkoPDMh9ukohw
 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
 Rp7vy3PO5W7D3Fv9tZexTT5ANQ=

Both machines support the necessary WMI methods, so enable fan control
for them.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 4a408693379b..4e7d52bc1917 100644
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


