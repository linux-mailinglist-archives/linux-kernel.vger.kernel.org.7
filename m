Return-Path: <linux-kernel+bounces-875424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63DC1912F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81DB4010B7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF831A57C;
	Wed, 29 Oct 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AHU5u7Ox"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED446313266
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725544; cv=none; b=Cfi5x+j+D4dQhrbPVvlTPwZO14VSlp0Rlsiz4yIBiGqrmJ7r8yQB5jeDXJLdBi2TOSAZaGD1gJjAIwO7brGcV6r27RkYOoR0QkfNN7m752ymombtO8LHvyntNNKqhIKGaP36bp8SYe2RVzt4X5NAT+DRwu0l+NmFbNioF9cYsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725544; c=relaxed/simple;
	bh=t3/9kWTcTSvqcCpxsztjc8iQ7bvxhMdLfhEtzrfuO+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAv4ilpwYuvKQGQj+3A98qKlaQQ8JB3c3t2+WiPJJiZ5cExhzrwjvNsiIBpT9JUtQQtpxeDSxrKx5/shUfEoAtBltYH01cIu9eKhyEvoAeM7OzQ8ALjUssu4PNs5TazuNu5E67+Ze0PKe1P3YzedmcdUUSrjmv/e/p7TIAKUjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AHU5u7Ox; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761725540;
	bh=t3/9kWTcTSvqcCpxsztjc8iQ7bvxhMdLfhEtzrfuO+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AHU5u7Ox8OUF2xNjD8bXvzrUgHhWFZ2brLDkKruym8jqr3kWW9wye44HNTuYOm7Dl
	 YowXhCehCIWs9mvaUrNAqbfVv6kqZZpmfbMecVVrVQJ98qom/rgYmy974wGTngBqN5
	 m0dr5Rg0zGh8l2MKPOCcjtG8TV1MSpTymEMYphyI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 09:12:10 +0100
Subject: [PATCH v5 1/7] sysfs: attribute_group: allow registration of const
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-sysfs-const-attr-prep-v5-1-ea7d745acff4@weissschuh.net>
References: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
In-Reply-To: <20251029-sysfs-const-attr-prep-v5-0-ea7d745acff4@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761725539; l=1501;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=t3/9kWTcTSvqcCpxsztjc8iQ7bvxhMdLfhEtzrfuO+E=;
 b=xk3e1UShGV2Gtg5Krq6Stll/0hLwqg3EwhuYea6hLStQ++HtTPNVLDZzcj7ZhDnW6rt0uplsp
 Z9r4hoNMkB/ClPijKvr26J1HZfs1dKqe0zf08uwFisOsO1rH1wRQMYi
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
2.51.1.dirty


