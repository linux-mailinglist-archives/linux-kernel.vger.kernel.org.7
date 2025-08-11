Return-Path: <linux-kernel+bounces-762166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0191B202F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250D018C0DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE772DCF70;
	Mon, 11 Aug 2025 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WbkCBPMb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414E23B613
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903627; cv=none; b=KwqaP1YpNel6W9JfqCFuueCWbN/xHhqhziEXdvqB/kJxm+IhiH5cGeZq/qaR+dO4zwH/O72gzSVG0uQUfvEGSi4kKxhMOjqn0c6DcKAVUIVgAj9e3gUfHPVay14KBA//irHoaeRynZZM94d3ca1YaxE8kPBwJr8U5/Qq7RpUS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903627; c=relaxed/simple;
	bh=SWxlsnWE4WHCB2JmPeVvuLTB1w7qyi90CE4hYgvc3RI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4eQftSaGjrVwsk6nn4xj+OGqTULvP2upGu86nFg7ob4BhAglLAqkRXONs7UR+3G8F87RpQKtujxYG2y3pVBSdmzV4MQR2QsFym6WNlP5f68wK9xEQf0nFkFmSBDU7H6D4H/OjjwSJjqsGSNKtZE1o5UCDAcEA6CM5SiMTvMJ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WbkCBPMb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903617;
	bh=SWxlsnWE4WHCB2JmPeVvuLTB1w7qyi90CE4hYgvc3RI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WbkCBPMbD6GFQHB4KN3FPoqTG8jmNPw4YrWdH8LRr8s3pkgPobhVeUHNl6sdz7XNL
	 xcdGwf0BmmdGOH6+cDjtHjAu2/VeVpvxkvR9GNwaGLbTcsiLN9FO5VRgaJJ65Fm0mW
	 b2c0EP2HEtwlLERBDj6REeE2mo69aY8DzJhPYrZk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:13:36 +0200
Subject: [PATCH v4 2/2] sysfs: remove attribute_group::bin_attrs_new
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-bin_attr-final-v4-2-7b6053fd58bb@weissschuh.net>
References: <20250811-sysfs-const-bin_attr-final-v4-0-7b6053fd58bb@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-bin_attr-final-v4-0-7b6053fd58bb@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903617; l=1068;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SWxlsnWE4WHCB2JmPeVvuLTB1w7qyi90CE4hYgvc3RI=;
 b=CbhSSsM2fGg3gVHexkK9T6jeLrvlCInWSyMZTITpW1JkxNb6Znb7FCTo7H3xTtaMPW34SYSTp
 DeTTnsMFinrCMyK/t3cP4o60zxjbzEe0MtEg4HCEl7/V7H5Sk08i+ce
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This transitional field is now unused and unnecessary.
Remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 7544f6d81c05982b5d168624f376cd647127ab51..9a25a29116528fab77d667390dd3ef5957b86554 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -106,10 +106,7 @@ struct attribute_group {
 					    const struct bin_attribute *,
 					    int);
 	struct attribute	**attrs;
-	union {
-		const struct bin_attribute	*const *bin_attrs;
-		const struct bin_attribute	*const *bin_attrs_new;
-	};
+	const struct bin_attribute	*const *bin_attrs;
 };
 
 #define SYSFS_PREALLOC		010000
@@ -293,7 +290,7 @@ __ATTRIBUTE_GROUPS(_name)
 
 #define BIN_ATTRIBUTE_GROUPS(_name)				\
 static const struct attribute_group _name##_group = {		\
-	.bin_attrs_new = _name##_attrs,				\
+	.bin_attrs = _name##_attrs,				\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 

-- 
2.50.1


