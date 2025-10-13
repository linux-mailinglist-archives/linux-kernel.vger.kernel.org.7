Return-Path: <linux-kernel+bounces-850859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600AEBD4949
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7713E6E15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73B30AD1B;
	Mon, 13 Oct 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XgzZweWk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CEE30AD03
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368681; cv=none; b=TQErcx3AYYUCr+jqEuXZgBB4yqWpQKXB2RB/m0EtsRFgVTiyJTAzB8r52XXLBtJexDhQ1hYtu496NMR+daeAVr7izNF1PWZ8cBMJVumj3DQVQ7u1WiaMVIvOFBzfqsv0WAAsyYpyZANx1+/QtQq5+BXIDHNCj4vB/IHnCSA/hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368681; c=relaxed/simple;
	bh=HC4YPP7F9f5/8XpQpN3pCxcZl4ZWvihPACOD9G2RUOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFVmP/LtDhMqXAny1MZ8k99yfa+ZZXRI59lgN+jjoRPZ3jDZdTTMmr/73hbNz0C1PNLjyOQSZwhVkTdDgo7jvJX9iQkPZWys8qhEeL+KBGk4f3KGoj3f5dGVA/YrsULxJEnPx75pEWjed8QPEN3zmPYRaQ2tb1o49BeVJlPJ7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XgzZweWk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368677;
	bh=HC4YPP7F9f5/8XpQpN3pCxcZl4ZWvihPACOD9G2RUOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XgzZweWkP7HgPeOFK9l4odAyT04nglkkumkMx27cnoVs2pkVXggCIwfpDV0xBk80S
	 GsArnGU2HgnAzLBMeUiO1XQB5ZFlxDOQjnaBohoJHmn7OjNWA52L2eRVfxjB5U5yyz
	 oWVYBOm7gDHzWCyZ2VRkr5uqBT0YKgfit+xG6n0I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:17:55 +0200
Subject: [PATCH v4 2/7] sysfs: transparently handle const pointers in
 ATTRIBUTE_GROUPS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-2-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=1044;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HC4YPP7F9f5/8XpQpN3pCxcZl4ZWvihPACOD9G2RUOs=;
 b=8Dm8CIpShyi3yU/5hFkgvK0gYk3znKEYFfCh/zw22A3BzEpvZXPacg/YduEZSssDfOh9tZOuc
 HK+Ttsp/xEEBuL039wdPDwolgm0cFqO8+ZREtu6ArtM0CZYpAMaUZ7D
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
2.51.0


