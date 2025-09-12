Return-Path: <linux-kernel+bounces-813288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2EB54328
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660D05651FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984F2882B4;
	Fri, 12 Sep 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DS9HC4ho"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDE74BE1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659676; cv=none; b=SFD5qbl/Rf2ZNxL01N/A1FMDjVH9RNX/JQt+CLtnKH3xBr3KcdmYMAKa/+FdTLp9P8yJUbOd5kPoGywIY1jgP5p6l1APYEKLPaeKufmSljORmbGJrTw7e+BOzUZXq6xR2KaFxOJRrvdwjyJM52bISpJuX8pCfn1+PrUlMzKTCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659676; c=relaxed/simple;
	bh=e6pzmWDlP4fU72dJlIuTmmzjA79fe/WpNQ3H4ae09Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrlPFtwWhxZT3bmszjCy3SAO7BoEsfHgNm3OrEGgzFOj8eL6pRuoUspxoYPYyqfxDkkQUkGnbl3AAdDDJDpA6/5yipxn3UMu0E/mlVkZPf4At0PvhW9g9A9todZ5NPGbKwee/Wdc4Y1AV3XNBuU3CPBkicMR+r0PFhEjFOl+hcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DS9HC4ho; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757659671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIoPd+cIAn5sRGQFNoWJdiuW0D5pltztXhc4gaFdz7Y=;
	b=DS9HC4homLiJRn3AT+Y0dC/pf2MsD5OfZxlcggOpwaFPipbRSYJ07nVbyuYrgTp51tUHTv
	GO0pAlviJyb+ZenLdmdNBmidrpjQ2JyqcksLf0HXtlndnrOscZTz7CaqxD3bJ3bmOJtEWc
	iO01UAjT0En811VM2fgI6FEqnGrnaBY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Date: Fri, 12 Sep 2025 08:47:24 +0200
Message-ID: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 097673b97784..6745e3fbc7ab 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -108,7 +108,7 @@ static char __init *find_link(int major, int minor, int ino,
 	q->minor = minor;
 	q->ino = ino;
 	q->mode = mode;
-	strcpy(q->name, name);
+	strscpy(q->name, name);
 	q->next = NULL;
 	*p = q;
 	hardlink_seen = true;
-- 
2.51.0


