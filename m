Return-Path: <linux-kernel+bounces-822201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8CB83478
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29543AB8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA5B2E8DF3;
	Thu, 18 Sep 2025 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lp5ARCkt"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EC482F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179654; cv=none; b=dWu8UvqIFrdpukWgPDHKB7ZNn/ADCnaEq/wJuTZs+hl9k9viYhEixm3NxOzMrn2ItG17eXUmZIAFbhZ/pmE7krJ8H8kDk4lXvwZHg3XcPD59n7eiWg302lPN7Ph8HJW5V2QyRG4/1/3yuB4DUpXGI0JWtNOPchuJzdpqomC/oF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179654; c=relaxed/simple;
	bh=uzibiNHbNeixzQYTGnILwQCROnsqPXXQ6T3XoIpa4RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXdfz5zzHuS8qV7XUk8hoGDcQ2V2+Fs1m3EzJzNl0PcD7ye/4AZ355oiKuz463iTwnV9zACHTlKWZOr4J9mrG1KR6UrECYRapFwYsJnjWXRraASjFOZiVQVuWVyLIy3G6mvpdQK0ne26kqjQ+AUH8vXAxsEhed9p5hygGwZu0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lp5ARCkt; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758179646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9+z70dx+Ys+DGH0o+4/KQ0fMwsGc/3SmvCzVQuHEWZI=;
	b=lp5ARCktdLzAZBBUIvf93e3wQh9ep8dfE7eeWIf1IF8ekg/u6Rjs2K2jNQaL1ENmsDcWu2
	cnzZX4jd03Ri6RYIOhyxRmwNr1hqu6Oe0TxSmYAYqrbiWvQ3FVs7b7lfotbeOCWIKxJFOB
	UNOt5mB4Umu8CotN3rkEVFl8RGKkluU=
From: Jackie Liu <liu.yun@linux.dev>
To: kees@kernel.org
Cc: pmladek@suse.com,
	linux-kernel@vger.kernel.org,
	liu.yun@linux.dev
Subject: [PATCH] lib: kunit_iov_iter: fix NULL deref in iov_kunit_create_xarray()
Date: Thu, 18 Sep 2025 15:13:16 +0800
Message-ID: <20250918071316.1035-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

iov_kunit_create_xarray() allocates memory for an xarray using kzalloc()
and then calls xa_init() on the result. However, xa_init() was invoked
before checking the return value of kzalloc(). If kzalloc() fails, this
would lead to a NULL pointer dereference.

Move the KUNIT_ASSERT_NOT_ERR_OR_NULL() check before xa_init() to ensure
the pointer is valid before initialization.

Fixes: 2d71340ff1d4 ("iov_iter: Kunit tests for copying to/from an iterator")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 lib/tests/kunit_iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tests/kunit_iov_iter.c b/lib/tests/kunit_iov_iter.c
index 48342736d016..a9d6db89247d 100644
--- a/lib/tests/kunit_iov_iter.c
+++ b/lib/tests/kunit_iov_iter.c
@@ -566,8 +566,8 @@ static struct xarray *iov_kunit_create_xarray(struct kunit *test)
 	struct xarray *xarray;
 
 	xarray = kzalloc(sizeof(struct xarray), GFP_KERNEL);
-	xa_init(xarray);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xarray);
+	xa_init(xarray);
 	kunit_add_action_or_reset(test, iov_kunit_destroy_xarray, xarray);
 	return xarray;
 }
-- 
2.51.0


