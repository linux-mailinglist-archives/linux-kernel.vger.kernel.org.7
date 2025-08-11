Return-Path: <linux-kernel+bounces-762174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B954B20304
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FB27ACE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA6C2DEA62;
	Mon, 11 Aug 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hbShq/hb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE62DCC11
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903675; cv=none; b=Y7fYuhagQ27IxJ0pOUXpgdWGVxggC7rRIsKTL57GQN9lE75K6WFsoGRx53oQb3u570WL5G6gRuit+3+d6NjnjEgOW3FR9YppAY1e3rudnqQuYs0xx+8+5iKldr8i/EbXn1p1O+lJnXavDU6CHIg44GBR6TR03kkzBLBXQPJCymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903675; c=relaxed/simple;
	bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3BBxlt8xSqPmcTKQnF6ziqCARTn8uTAEvFQse2uRVHmpulnla4o0usOxZR+tvU4K1wKChuM633gr6bPyRw/178iXonN9N3ouzF/73Jfc63iupZTiIG7PhZ0HpHCq/Ja2MSzFC4pxHmKhHl4qjL/25FslUY5YA/o0sx+f8lfSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hbShq/hb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903670;
	bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbShq/hbT9SaJ5IoYzGUUjJARmQwRNfVufjfd4G9aTvY0KzetVyToRaPBJZ5W80JP
	 Xa/+A/81fV0QM6MJ518gJTYswB2GZ0osPB3LkIv7tkttW44+K6MKdSHk5WFuVM3E9t
	 Ee+FhgVASdu4FKecqV9uE9R3D4PabotVlHCKYzKU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:14:27 +0200
Subject: [PATCH v3 1/7] sysfs: attribute_group: allow registration of const
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-attr-prep-v3-1-0d973ff46afc@weissschuh.net>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=1606;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GRXkHr87sMAwGXVCFiOsZuTbb8axjZTo4vNoebQJmjg=;
 b=BqLrH4TbeVI5edSMiKvXCLPRUbwZKdFjlY6fb/Jbql32J2K8aVx/Ng49CQjQUcvbrpFP/jF/e
 J/ySe+J+i7xCZ88RGo5YYRMR8pgB68cyleTMgnK84V0H+GvjVF1IRTu
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


