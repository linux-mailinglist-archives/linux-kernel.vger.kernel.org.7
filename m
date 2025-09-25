Return-Path: <linux-kernel+bounces-832632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41578B9FF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445644C4D15
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111A286426;
	Thu, 25 Sep 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lrQ10Yui"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177228C5DE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809683; cv=none; b=h5veUVf8wTVpgxPC6pwYfq8n/w6hkoWTPw20kCDOsD50WlPuXBt0852BzNSIam25Up86HCSF+gNqb1U9h8yqBVqiqncYqnzaahUomhaOkJR53J50GylnOyiMT2hRn26V1CZOkr0Wd59dGzlHOKNekDMcfkj8rxTD081qRyUmgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809683; c=relaxed/simple;
	bh=TlkIosSLgWDlIO75qJpmeNoEw6wbL3is8O/n2hhG7oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/FPCrKDCCIfntFPjAQ3k5ABJgiG2LrTsUTWzTEfvUoR6P6RMCT+//t/LL7/TvRJhNWYbFHwYTDkbTSYDZimkbDxeKnfgBVOBrviL/ZNzrM9xsmGNl3FHtJyfN9OU9WyQBUk2UQAGkoxIoeu+E/D1DNFqZYKXuqvvTQqBmbquPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lrQ10Yui; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=17d0M0zM5wiJ1Hjfr9EtgKKpY1kwiNbg+jYWI0OHzRc=; b=lrQ10YuihF8MN3YbthIp6VicVV
	oNsM4V/Rwxd5UtxpLVG04eYFs0AU5o55WBYg56N7R+Fr9YRBFzqoZ9JylZlEl4o3Jcj+pR8wycu/n
	rPISm+YascSH1xX+aMWBZDs7XaA0hU0xZzRcCLE0WcExdZpdsUDBQizvolF1HwPqNW5wQ/e2op9Pg
	6ctVAlErWh6wbUvBuJvbVNQsFvTQKFrAF/cmyHxnpCLno6RoAA0tT8645VzUH/+y2yG8Wx5AsGrE+
	FbprfYANDvzN7HO48SjAckP+YgcRSiD4w9HJHHo/zG0ANi0CpkBhoRZcu/95SwiKMqZrMLOH0r8VZ
	yPoQgcEg==;
Received: from 201-69-111-249.dial-up.telesp.net.br ([201.69.111.249] helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1mjv-00HPSe-Pz; Thu, 25 Sep 2025 16:14:32 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	=?UTF-8?q?=27Thomas=20Wei=C3=9Fschuh=27?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Shuah Khan <shuah@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-dev@igalia.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Date: Thu, 25 Sep 2025 11:14:23 -0300
Message-ID: <20250925141423.504427-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add stdbool.h to the list of nolibc.h includes, otherwise tests compiled
with -nostdlib will fail with "error: unknown type name 'bool'", even if
a nolibc stdbool implementation is available at tools/include/nolibc/.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk/
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/include/nolibc/nolibc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index c199ade200c2..d2f5aa085f8e 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -116,6 +116,7 @@
 #include "sched.h"
 #include "signal.h"
 #include "unistd.h"
+#include "stdbool.h"
 #include "stdio.h"
 #include "stdlib.h"
 #include "string.h"
-- 
2.51.0


