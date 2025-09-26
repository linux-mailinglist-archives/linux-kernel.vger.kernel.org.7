Return-Path: <linux-kernel+bounces-834005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160DBA3959
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF313862F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7752EB878;
	Fri, 26 Sep 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="iVeD+uyQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34186353
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888820; cv=pass; b=garY5SBUW5tL4sYROhlrOA4k1wYmWpBOpc0JuGvWkCLJDYjqxbLfqP/sIGqHhDJfNB2ZkYIFFF8zB46gX6oGzgLF+SAmz2TKtz/ZmSZCD7Z/abmgz/0l+MEr09b1OPRkVfOCKC6FcfNgS5Z6WkTfAKTYTKtivkb9NaZFMfqKaeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888820; c=relaxed/simple;
	bh=KTOUv4wzRKGnt2yLIWk+zjb309fTMWiq2CqZR0w9sBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kNVRo1/Vw9laq1P+nV+ul2PjiYqNNZLW1/x8du7tFYWZVsmcF4PGYSbsZDDpuhZk6LOZKo0nKSaemglOjZ1ZO8wEHH9t/njBXPMZaY5KNlQTU/4L4w2R7vXiKfK4sL1d2flzp0bk9n/Ct+K71rr5URN7Hf26813iyj1z/fKqhTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=iVeD+uyQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1758888765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nUFPxioapl75WWsWXdApVCD8Rmn6Afrve8p5iQw1fLp0UmJXVlNQgVx8eXItR4gpJ/O5iKK0Vk0uW7wa59Skdx8SYbpqpdTHLUpZaCjWE7F8jg22J+H9teLFx0X+Jf63mH2kXcXMGq2qcniY/qpWJgxEtnmS2MnPNG5gcfECNC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758888765; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=QunEw5UgYlGKRQWuLT5FGNzRhT4CrJ0TS6USfMAiOw8=; 
	b=h01cZLX6SidlQP8IcRfJZpX/cg/7cp+So1PJjrs1qeAoHcwxz434v3p4DY7mbQLPPFQzEbSzYrKAKp2CMUie1B/zb5c5VmYN6B9qh7YHpAdhnH20h1iEDyFNp2CO0cWTkZsqcrIkCOlHyjqavmu3l4B6GyDb8DJYl/C6G3O6iCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758888765;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=QunEw5UgYlGKRQWuLT5FGNzRhT4CrJ0TS6USfMAiOw8=;
	b=iVeD+uyQvk6yGN73ig8AziqQkWCDf1f3HAtpVpENN5KSpMDG1v4a1zudM4EWjKyJ
	FNzHQ2UaZBCA11Xh+lITl7+FEEia0sE7P7Ei9rGzLgkig5VLBb/lVjzNG5e5uUr1+zu
	OU3Htevv957SnC3vlgO4W9FMAfn5eqGY/6xI3P8g=
Received: by mx.zohomail.com with SMTPS id 1758888763331940.6432278180416;
	Fri, 26 Sep 2025 05:12:43 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] loop: fix backing file reference leak on validation error
Date: Fri, 26 Sep 2025 20:12:31 +0800
Message-ID: <20250926121231.32549-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

loop_change_fd() and loop_configure() call loop_check_backing_file()
to validate the new backing file. If validation fails, the reference
acquired by fget() was not dropped, leaking a file reference.

Fix this by calling fput(file) before returning the error.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 drivers/block/loop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..94ec7f747f36 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -551,8 +551,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
@@ -993,8 +995,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		return -EBADF;
 
 	error = loop_check_backing_file(file);
-	if (error)
+	if (error) {
+		fput(file);
 		return error;
+	}
 
 	is_loop = is_loop_device(file);
 
-- 
2.51.0


