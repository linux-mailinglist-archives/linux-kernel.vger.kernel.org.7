Return-Path: <linux-kernel+bounces-880139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F687C24F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E91984E7BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA92E2DD4;
	Fri, 31 Oct 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/PDbpu2"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B54253B42
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913207; cv=none; b=LhIDaKJeKWP4GnByjYtZWUATxzUMP44C0Fkm4BiD+Zl22FTfxtbfqomjDKnuXjPs/gEN+C5F4r91H21VyBGq5nYRNqZcn1Ha8R8EPuWjxnFmKnLSMJTQ5k0rU1XMa7600DW/GBgBdMAoaEHwe/WNawqzHxfcBC3l9BJkNntMpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913207; c=relaxed/simple;
	bh=9JrQbTFVWDHfwPJ9t2AimbJl8IPZ9iJD9tJ9BlVMq1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ox7BNXgK9sWEkGgYWi8SEErJpdOKhVN5rgzSCeB+f6s97gfZNdnMghdr8R/ThhNA98MTGG6dQ5g/UjBcmPD853JONDoo5HdVCVWSbv2wgO6bhAJrl4obwKrSjjcb/wv4ZHKVja1GHiWI1b9MdP5aduEbCJ5jxyQC6SnhCaYuVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/PDbpu2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761913192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QdTeBVN/ilJ1FssJEyKSoAQftpG+92VQsGr2mpeorCA=;
	b=I/PDbpu2Q5lrX28chT3ap81I+PnSUyIVnqUg6cme2gewMbc56R8C4aZxFNI+Sr3DbHCMD4
	MFoHcT1VmnmZ7YZJNdUbHgZgnNbIVgpgkSQNfx+Qdz4XM+cUZewiohfm56r2cBtDEC2JE+
	ucyC2ErFHw8pjSBQ6OiHhsKoHH/QAfc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform: Replace deprecated strcpy in platform_device_alloc
Date: Fri, 31 Oct 2025 13:18:58 +0100
Message-ID: <20251031121858.156686-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

First, use struct_size(), which provides additional compile-time checks
for structures with flexible array members (e.g., __must_be_array()), to
calculate the number of bytes to allocate for a new 'platform_object'.

Then, since we know the length of 'name' and that it is guaranteed to be
NUL-terminated, replace the deprecated strcpy() with a simple memcpy().

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 09450349cf32..55ec4fb023e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/overflow.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -577,10 +578,11 @@ static void platform_device_release(struct device *dev)
 struct platform_device *platform_device_alloc(const char *name, int id)
 {
 	struct platform_object *pa;
+	size_t name_len = strlen(name);
 
-	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);
+	pa = kzalloc(struct_size(pa, name, name_len + 1), GFP_KERNEL);
 	if (pa) {
-		strcpy(pa->name, name);
+		memcpy(pa->name, name, name_len + 1);
 		pa->pdev.name = pa->name;
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
-- 
2.51.1


