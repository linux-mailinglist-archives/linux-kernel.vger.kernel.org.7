Return-Path: <linux-kernel+bounces-729012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE793B03089
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C01A6018F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC022701A4;
	Sun, 13 Jul 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZvMakQwP"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68323E324
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400343; cv=none; b=E3YkbUpKw9tct/YeuXfH2q/thmgCKmawlh6X3g3KYUPGV05MPEyn40ViWjtu6arnWoy3Hk4yIyAPo/p8ZuVdLL2QQZd0dfkrakkjzVHlEFzzsAptYkczFkCqcJkiXwIixR0nE1YdkUbT98SLGH075zQ331iN8WZ+85kuy19U3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400343; c=relaxed/simple;
	bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EkTlnLR6H9qfNWcHVqk1Br+Ig2rb1UibIdsbkAallDQYQCthy815D2jht6hGCQX2Ujf4aZtB2n9FdR1B955ozXlTStnHQFdZyRGbwaALs0JLZ3bFIxMMrbZr0BYjBOMSg6+n9z7yqCrsGu37ZyPKWht/TH0129WyYYUsul2ordM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZvMakQwP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZvMakQwPzbhylbboKeA8vCbB0AiKM6EesD8A0csE7diiUF/7a+KoB8F/JTTqbgNOn
	 5fcfO7QOdXU0rudXekX6WilPs3LNeDRLicjSUy3TcrkDHcqO7JzonVn83w8JaIVcvG
	 HcK5MvKdVd+sy0VVbS/DuMOigDtiQCrrK5H9wCFU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:13 +0200
Subject: [PATCH RESEND v2 1/7] sysfs: attribute_group: allow registration
 of const attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-1-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=1606;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
 b=1+s7+MHUMZ+qo33k3FuoOJ+UiM+DmswRzX8m8IE+4cWv0/Vx8dE4Dwp8bJZpd+uZSdNyhXnDs
 r5aZ52Ve9l3BmN5T3EMadyTJLex/VSsA+KbS5cHBwNJ6XVzMSNBMr3L
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To be able to constify instances of struct attribute it has to be
possible to add them to struct attribute_group.
The current type of the attrs member however is not compatible with that.
Introduce a union that allows registration of both const and non-const
attributes to enable a piecewise transition.
As both union member types are compatible no logic needs to be adapted.

Technically it is now possible register a const struct
attribute and receive it as mutable pointer in the callbacks.
This is a soundness issue.
But this same soundness issue already exists today in
sysfs_create_file().
Also the struct definition and callback implementation are always
closely linked and are meant to be moved to const in lockstep.

Similar to commit 906c508afdca ("sysfs: attribute_group: allow registration of const bin_attribute")

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index f418aae4f1134f8126783d9e8eb575ba4278e927..a47092e837d9eb014894d1f7e49f0fd0f9a2e350 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -105,7 +105,10 @@ struct attribute_group {
 	size_t			(*bin_size)(struct kobject *,
 					    const struct bin_attribute *,
 					    int);
-	struct attribute	**attrs;
+	union {
+		struct attribute	**attrs;
+		const struct attribute	*const *attrs_new;
+	};
 	union {
 		const struct bin_attribute	*const *bin_attrs;
 		const struct bin_attribute	*const *bin_attrs_new;

-- 
2.50.1


