Return-Path: <linux-kernel+bounces-875428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD26C1904C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186F84201D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD031AF2A;
	Wed, 29 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gNUrkF03"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C62D46B1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725545; cv=none; b=vCmbhj0OhaYItnUnnOpPLANbvm+ZIEDK3DbwEvRUtsPXs9irnv1+/DPX2CgDptACVaQy5pG+vuIZTNel8Es0Wr1LE4mp9kcqrdMbl5Y5rTF2L+A+/HqRHeUpv6GG5aNJ5wqsgt/GVILRreNZ0QZzPsZMDswZnh4pIo9ptwDfVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725545; c=relaxed/simple;
	bh=4HQ+oUujCPeT8uI7nX/NsoBt7w0I2vvre4qc0JB8GYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knGCWOzVWKR31TAJjCwWGxpDuuZPUcdRFZcLVD1NO7iIj7nsFJrxEo/jpVEfyxLF2lszpzv7fLjK6CObW9npbxtwjWxVX9EFbeKiJ6feVA7NNDHIoTF32AwAEnoTaQmqtK4+bieiL7yubUEk/0Iminb5z1AgAIqBgZSoAUTNeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gNUrkF03; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725540;
	bh=4HQ+oUujCPeT8uI7nX/NsoBt7w0I2vvre4qc0JB8GYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gNUrkF03iHqp9nzsuJ9prig5meibKL898LlFCH3Xnm8gE0A5ySXEC+3/MUjhFbsVL
	 y1ze0EPWbYfyLcgqKur5MaAjKNjTHgXDFmFXqTrstS6OQhJUWGalMGk3DX6ShAQpMq
	 D1HzoIXk008EyRTo7KNGCIn94ejh1GYLH1Sj0L4o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:11 +0100
Subject: [PATCH v5 2/7] sysfs: transparently handle const pointers in
 ATTRIBUTE_GROUPS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-2-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=1050;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4HQ+oUujCPeT8uI7nX/NsoBt7w0I2vvre4qc0JB8GYk=;
 b=eSQrKMY1d0c+XRWXYiVrT1bZkLGuX2Snxb8zFwWvkHqlkpNRAB3tsO+GumJOhXlFxEsn1pOWV
 OL3nKv7VPR7CdPpWnvdT1r7tK44MkRp4DN5ooNAjvqF1yAbcsKlDza9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To ease the constification process of 'struct attribute', transparently
handle the const pointers in ATTRIBUTE_GROUPS(). A cast is used instead
of assigning to .attrs_new as it keeps the macro smaller. As both
members are aliased to each other the result is identical.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e34d6af96abb..92f82cee5f11 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -287,7 +287,12 @@ static const struct attribute_group *_name##_groups[] = {	\
 
 #define ATTRIBUTE_GROUPS(_name)					\
 static const struct attribute_group _name##_group = {		\
-	.attrs = _name##_attrs,					\
+	.attrs = _Generic(_name##_attrs,			\
+			  struct attribute **:			\
+				_name##_attrs,			\
+			  const struct attribute *const *:	\
+				(void *)_name##_attrs		\
+	),							\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 

-- 
2.51.1.dirty


