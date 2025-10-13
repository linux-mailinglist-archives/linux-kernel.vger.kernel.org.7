Return-Path: <linux-kernel+bounces-850862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0AEBD4456
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF3C1888195
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16330B51D;
	Mon, 13 Oct 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o9ZLZVWe"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F130AD06
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368681; cv=none; b=IjkG3b3W0ux/50iPYTqi73s45+8Currz0dvHVUc2n9VQyzihZP195+ApSRYGgGub++LUIPGQe7vnL5gq8ZdeFce8pBJqveAm+NyU92GI75u+GiEmxMO2P6YMxqTcljUbib0fA5cAlR7SHSBL8sEb7MBGv4WZJZ35EBhChPrXxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368681; c=relaxed/simple;
	bh=e2JSNt1oXoBuC8lD+VFhcIHgvuTQyriVtTtr7YhY1Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4niVaTpGtNmlZ2vEVPFJ3xwTeD1Fe/yHubCGGaXFPepcuMUTnK46stbIJj2b6i4SSHVwRsby8/3tmzMO7nl6bkLjs7g5jmRytvStkM3eN1NCv/7oUvVlDhjftDXCRfYsbIRlqS2Jk8rQGN0zyPobOrAe5NFB2j2gH5YYMRqmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o9ZLZVWe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760368677;
	bh=e2JSNt1oXoBuC8lD+VFhcIHgvuTQyriVtTtr7YhY1Vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o9ZLZVWexMfJhNKk55vlXeiB66nToOeYajBMQlJ6aB73IkdaTOQov8gLm+kJ8q4/5
	 6km4m4iKNU7V0+KK454i77ttK6iMjOyQrRBRFqMfT3HWU22j7gZ0AdzXpa5CkkrahS
	 4fUG6vN2w/KBMExQLhpE/lnY9q3KfV9L4aFNVWZA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 13 Oct 2025 17:17:54 +0200
Subject: [PATCH v4 1/7] sysfs: attribute_group: allow registration of const
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251013-sysfs-const-attr-prep-v4-1-e0d36e828334@weissschuh.net>
References: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
In-Reply-To: <20251013-sysfs-const-attr-prep-v4-0-e0d36e828334@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368676; l=1495;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=e2JSNt1oXoBuC8lD+VFhcIHgvuTQyriVtTtr7YhY1Vc=;
 b=VSkGZc21lexL4OfqHzIiLkqrvhA6zPcck9sfBEX5qLK/U6SZYmwqiT+JDhETQLtKzUqaRLtRm
 mwAO5VYsJY5AaEifBLkCRqMB945SGTeezd1iOtwlm5fpbMpV+IYgI4I
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To be able to constify instances of struct attribute it has to be
possible to add them to struct attribute_group. The current type of the
attrs member however is not compatible with that. Introduce a union that
allows registration of both const and non-const attributes to enable a
piecewise transition. As both union member types are compatible no
logic needs to be adapted.

Technically it is now possible register a const struct attribute and
receive it as mutable pointer in the callbacks. This is a soundness
issue.  But this same soundness issue already exists today in
sysfs_create_file(). Also the struct definition and callback
implementation are always closely linked and are meant to be moved to
const in lockstep.

Similar to commit 906c508afdca ("sysfs: attribute_group: allow
registration of const bin_attribute")

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9a25a2911652..e34d6af96abb 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -105,7 +105,10 @@ struct attribute_group {
 	size_t			(*bin_size)(struct kobject *,
 					    const struct bin_attribute *,
 					    int);
-	struct attribute	**attrs;
+	union {
+		struct attribute	**attrs;
+		const struct attribute	*const *attrs_const;
+	};
 	const struct bin_attribute	*const *bin_attrs;
 };
 

-- 
2.51.0


