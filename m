Return-Path: <linux-kernel+bounces-892936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E4C462A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588113A7999
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B83074A7;
	Mon, 10 Nov 2025 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ofBiiofl"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488ED23B60A;
	Mon, 10 Nov 2025 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773193; cv=none; b=HvoGGRo7pHFVP/3h0KogxJUwxjHEKzxsZSI7G5H6/qxV/vFotrrqK31c4E9D3lQ5iYMHYc8KEZVY4hiKTk6wq0kQlz8ZgyebOBc8XvjwSypIIZURNOe4eUTjggnckxhpcYR7Z3BGHHwEf0pjv/X4RWASr2jHzRdAiSLCkihEJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773193; c=relaxed/simple;
	bh=Q2S88A4Jcsy0+y1kYo1dQwKrFofXXl/LKLWGirlunEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoMWMoQHAK6xR19h+uDoU413M96Wi06z2vAw0bqSGsEJjziXXeIMJ33bBxpvSGj/X9rivaiI3XqdyO8oxg5hjNGQhz8KtoS9ucuz3jJ8k3RvoEilo5lzYhkxuSxbCkZTGWgnxtgYqAzRwldaldPZ+ER9YePqoCxnkwCtORR7qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ofBiiofl; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762773181; x=1763377981; i=w_armin@gmx.de;
	bh=z99MHNpjyCH9xWD/zrcSXlg7siEXZV6Ji3jZqMqxDjI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ofBiioflkIPxgquIHNmOaXKPUq+/7c+M0K6gzQXgFz3pDWieW+jwbFfMFjrfYVBy
	 GdTLW/0SyPMHocs8UfArfCFrspVgifsWqsE2tPisX7BTjFt/kEYmjQr2FcaRXM9kl
	 pB2M4aXNIaxUu4Fm6KyON/JdeU3RDOsNCjW1V1c2pkZkkGC4Fe2HkwLGjMU6sRCVb
	 kADEscrAERzGBEPNDRwN6MqZGpBW2zoITDl50sKJmtUxu5oHEUj27RhscNBZpE7mC
	 HzAGGkjU+Zp3sQ1WUIZRgGgjDzZ21Zv/L4x6c/xLqn4TjVc/3wKHMDe7kxsrwp32G
	 6ZFt/RpU5bTEdTKAQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.8.184]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2E1M-1wLgeY46nO-00wtAs; Mon, 10 Nov 2025 12:13:01 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev
Subject: [PATCH 2/2] platform/x86: msi-wmi-platform: Fix typo in WMI GUID
Date: Mon, 10 Nov 2025 12:12:53 +0100
Message-Id: <20251110111253.16204-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251110111253.16204-1-W_Armin@gmx.de>
References: <20251110111253.16204-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EP4Ah0BwRLGdwXSciHi6tfimnC5EN8E0w/sa8BTAkVoQsOwiYCc
 EKbeSlSkB0PG9L+WrwkfKUap7+9viEc/F0otAESMvJuoAOldLQkNz2cg9R0qyHw2XeyI1Jl
 jRF7ZyTsFG0nFivqV41fs2UZw07BgnHIk1kfYK2vEhr0Llpj7PA7pOcl2xK61uEx+l6l8a+
 gxzM+KDAp5HyoAwNav4qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MMRJoslT2b8=;lTP0S7fHlOIy2nwVEs5lsIxgfKa
 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
 5Nh2+WvOSvsfO9YmNn3oI8tetBcuN+VkpdmiEj

The WMI driver core only supports GUID strings containing only
uppercase characters, however the GUID string used by the
msi-wmi-platform driver contains a single lowercase character.
This prevents the WMI driver core from matching said driver to
its WMI device.

Fix this by turning the lowercase character into a uppercase
character. Also update the WMI driver development guide to warn
about this.

Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/driver-development-guide.rst | 1 +
 drivers/platform/x86/msi-wmi-platform.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentatio=
n/wmi/driver-development-guide.rst
index 99ef21fc1c1e..5680303ae314 100644
=2D-- a/Documentation/wmi/driver-development-guide.rst
+++ b/Documentation/wmi/driver-development-guide.rst
@@ -54,6 +54,7 @@ to matching WMI devices using a struct wmi_device_id tab=
le:
 ::
=20
   static const struct wmi_device_id foo_id_table[] =3D {
+         /* Only use uppercase letters! */
          { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
          { }
   };
diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x8=
6/msi-wmi-platform.c
index bd2687828a2e..e912fcc12d12 100644
=2D-- a/drivers/platform/x86/msi-wmi-platform.c
+++ b/drivers/platform/x86/msi-wmi-platform.c
@@ -29,7 +29,7 @@
=20
 #define DRIVER_NAME	"msi-wmi-platform"
=20
-#define MSI_PLATFORM_GUID	"ABBC0F6E-8EA1-11d1-00A0-C90629100000"
+#define MSI_PLATFORM_GUID	"ABBC0F6E-8EA1-11D1-00A0-C90629100000"
=20
 #define MSI_WMI_PLATFORM_INTERFACE_VERSION	2
=20
=2D-=20
2.39.5


