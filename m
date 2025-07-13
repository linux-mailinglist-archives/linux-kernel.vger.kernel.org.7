Return-Path: <linux-kernel+bounces-729011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A52B03088
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA01A60140
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED20267729;
	Sun, 13 Jul 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="L1o3wpR4"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B091367
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752400343; cv=none; b=g8UpiYNwSO6RuM3U+yFp2LUQXXqxY83jnLH2XukOKD5Jl31FMV7ZxdgYRydI90qiB4MPe8H6kGjOvDDjX+3VAjnEEOZ7oR0ZcEepFxdmUI9yWSFhnHWIVTtGwVCBaINOSEBkgrRKFzUeuoOHmE06pWyMTQbfD3ps/ttB81aEHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752400343; c=relaxed/simple;
	bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rt6cQhpgo2N+0n+CuUwjtnLsZaX8HWro+IA5szR1JZuWtaSwMZaRwtyEsR5lS7ytrOiLnfUVsVO5RIjFGPK+O2CeY+PigLlpeLjvD8cAgzCEAaQAveK8CYyvsEENfKFCvKpGP6qKyBnKmjLBFoyb1bn3hc7PFQHEvNcu5ZNdKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=L1o3wpR4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752400334;
	bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L1o3wpR4/uaD1XuysbyqMYfRy0saVeMlYnF/9muRM7/jagiPBaGwi0z7iO6HsCqaT
	 THgG0PFEu2ZTnh4G2f/mSRHgNAEYrRDIeSC8FQkRHiH9Ir0IP4gy0BjV6lOTd9ixPd
	 XqZTW6lUX9WWPdYYwZgih9rxHskA5lWG7RfCs73E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 11:52:14 +0200
Subject: [PATCH RESEND v2 2/7] sysfs: transparently handle const pointers
 in ATTRIBUTE_GROUPS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-sysfs-const-attr-prep-v2-2-2f42510318a5@weissschuh.net>
References: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
In-Reply-To: <20250713-sysfs-const-attr-prep-v2-0-2f42510318a5@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752400333; l=1101;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
 b=4hPYEUEalkAwXTCOYkjuc2iWeoth6zBCsA6YbaujMbJGBu5rYbVWZtApHgfPni7VwlhE/F25p
 BzEuKCREBUMAH+sQeXoqfEzq24kj/n35UOWMp5QKkaNkR2Hyp4+2LM1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To ease the constification process of 'struct attribute', transparently
handle the const pointers in ATTRIBUTE_GROUPS().
A cast is used instead of assigning to .attrs_new as it keeps the macro
smaller. As both members are aliased to each other the result is
identical.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysfs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index a47092e837d9eb014894d1f7e49f0fd0f9a2e350..118a9b1d3b3e7528fb213d83f85d31bbac0dc309 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -290,7 +290,12 @@ static const struct attribute_group *_name##_groups[] = {	\
 
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
2.50.1


