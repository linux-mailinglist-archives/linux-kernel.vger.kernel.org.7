Return-Path: <linux-kernel+bounces-859139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFBBECDBD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A6A19A735B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF92ECE80;
	Sat, 18 Oct 2025 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fb8CmiZ+"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A002F616C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784724; cv=none; b=JtE4o04MXxZqQFUGelnGqgE+INfU1sYBdyfP3QCDqisoeqzce/L4mCzCW1Fo78XmAuyA7mUqnFYBCZUDly10DChpCjvBKEmBzP3GCEUJ2CsWgFSp4rMqEilpnXBu6wG2O1sm3cCY1wbHpwUzRDeHwH0mRT4pxc7w4YgtLuVawZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784724; c=relaxed/simple;
	bh=eVuGej1F7GbwxRs83AcQkLvn0RZ4Chf3qynWyuJBy4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EnCcAeeXk2V4lJb0d8eRaSiYYCt3Of2chOaFtXNylFVrNAVBQiFnmc7Aet7IeMuMrXDHhSbsMgdL5IHvtasiefhbCQs2TwOP/3dIFiXJeqifeSS8LD32QTmuROksuvyk4YCr1ERiGP7gyEcNB0XjhKghlOR+hhUVWwQLAAQZSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fb8CmiZ+; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760784719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwuOdS0qb1orpbwmnxAji5E9pWF7ezIc/lU0GSMg9iY=;
	b=fb8CmiZ+fJx/RpyClOtbMISTdiWqNPElQbtBBkupiyVYYafe5s50N+WDyUQjq7hXERzP8B
	vjqzR49iLk9o6s3qTtI91PzgJTGAtCOf94FaNq3JZE1GDRBNXB2j8SQfPQZmFerWlGWCdd
	h74l8pPFsEH6fc6giQsqAZfSVQ22J7k=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ata: Replace deprecated strcpy with strscpy in it821x_display_disk
Date: Sat, 18 Oct 2025 12:51:45 +0200
Message-ID: <20251018105146.29808-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Replace the hard-coded buffer size 8 with sizeof(mbuf) when using
snprintf() while we're at it.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/ata/pata_it821x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 042f6ad1f7c6..fc762dcc61bf 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -75,6 +75,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
@@ -632,9 +633,9 @@ static void it821x_display_disk(struct ata_port *ap, int n, u8 *buf)
 		cbl = "";
 
 	if (mode)
-		snprintf(mbuf, 8, "%5s%d", mtype, mode - 1);
+		snprintf(mbuf, sizeof(mbuf), "%5s%d", mtype, mode - 1);
 	else
-		strcpy(mbuf, "PIO");
+		strscpy(mbuf, "PIO");
 	if (buf[52] == 4)
 		ata_port_info(ap, "%d: %-6s %-8s          %s %s\n",
 				n, mbuf, types[buf[52]], id, cbl);
-- 
2.51.0


