Return-Path: <linux-kernel+bounces-762172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE8B20302
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED603AE046
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBC2DE1E3;
	Mon, 11 Aug 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BWllO9h/"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD12DCF5A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903674; cv=none; b=A5tzq96s0TFbi24wesIDjSRsVJ710IFuNDoAfbpyd1HJ6wavQZ15wKbaXWLiirGe4snh717K3oDCv8AG9rWtvfpyrdLTbpIGGteHBuF3HUyBGH+LIOC7H+H5ftkbbBdh1KjxQ0jF7aVtmou39320aJTJVarQA61+k3CWUZgFFXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903674; c=relaxed/simple;
	bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ObJVv2DPHj8nF81XDrqaHNdg2v9mCOYSgRvFw2aODRJrAxt0KXBlZh6qV+2YhWTc8wtL/ucs5CQp46LgYpB6Ds65n4h/okVgExNZBTCUnYF2g/vQ3qennCCHh5Mkw++y0TJsQqmrbqUZ5TijTeTLLnyCCVAdcqsxxCrmG0pg+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BWllO9h/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754903670;
	bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BWllO9h/1iVmKCAyPpFe/dzFSgCMIiyQU1KDs1LVI/Z8RbXbu6oQa5XwLDy7P5T93
	 6wh0WwmCgEsgGhUNgXM/drhKqIzWI1IZ3MDJfleFWNztWwljodhooLVMXgKt3HLEwM
	 HfIOSEy5MSE+xu40HVmUvgWqsThqv+AYkYlKzoD4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 11 Aug 2025 11:14:28 +0200
Subject: [PATCH v3 2/7] sysfs: transparently handle const pointers in
 ATTRIBUTE_GROUPS()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-sysfs-const-attr-prep-v3-2-0d973ff46afc@weissschuh.net>
References: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
In-Reply-To: <20250811-sysfs-const-attr-prep-v3-0-0d973ff46afc@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754903670; l=1101;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kGwqGdBW3jjbIWNaJKunX6K1VPeiWAsjwBkGA4VS9Ms=;
 b=YoFO/BTW8Ds2teuPPG2QBfkTDZV0GcQmt5U44DxRDTqvcHbngmh3NID0wSDVDD9Jvl8xHaWjU
 gJ8PbVwKKNYDy4OXXUqckImzeS2yFOg2Ub+7KuX3ED7gWSDHgCBYIHI
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


