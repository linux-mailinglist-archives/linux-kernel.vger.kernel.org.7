Return-Path: <linux-kernel+bounces-816086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93879B56F48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10877A2997
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF994224AF9;
	Mon, 15 Sep 2025 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="gYNs4EVW"
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3E17BEBF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910491; cv=none; b=STDAP9sGBmQmtDaWoNjwHBLFvhl+SsQp0Dolz9kmt22k3O5WRQHdOW1CzCCAAvoz5JxGxnzeQmdLttfAq+ZlhyP9Ie0BouMYfwp8cYUvcmGFOA7CGuY9o7dXaz5h1kAVq6uS7Ge+TuWM4r2m2Cl/Xmci8HCyN8v3KIpM6Hycf78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910491; c=relaxed/simple;
	bh=thSEO4XZbXdXEtOD8K6LIxHa5CcneJ4OsmAcM9CEBvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQbX68YPAuIxJnzm6Sd0yAslPklQrU9RX/m64FBxay9XUfLPDNNf0jMvr5jUhUTPEffKIKC+aRtulGYElMs3HAjd8HJ1knuMXm7FBJ8KuU7Ntw32jTdGS7bFywuxe/ytrOeMOnLO+yoJM+Sa9kqTbPa07AFabGRG8lqpppXH044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=gYNs4EVW; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p4504123-ipxg00s01tokaisakaetozai.aichi.ocn.ne.jp [114.172.113.123])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58F3gpZp004256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Sep 2025 12:43:17 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=R0HOnqHMxuP96xu16dWewxfrRPsTQLoG49PuVlo3OSI=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1757907797; v=1;
        b=gYNs4EVWhtbf5rniTjP3beAPOvDoy/GmNv2TdZlwiDlGHvaAOKZ4r9MF2loPlWV7
         AKqkI2CY68d6uuuR7Ilm7gJ7CqUmRY93eswH5cayJiLcvAKOkXEJRqAOJMLbRsl5
         WMeIA7U+/cs82yQvROapfEhj44jII6P6gRe4Y/kRp+sjLmLwE2BEEyU6syahklqc
         0FwuZaYfZykv5xpmIm0hq1deddReOTMeF+sSLm/DGVMrfzYLaZ92HuoSfdoslIun
         dqEHuYwQA6fxYn4MWXjxDA9NtFUM+scL0q64sXn5MSRduqKfw3amoILpXARD0CBt
         W7FYJ0dFMOJOO6szOcRywg==
From: Kenta Akagi <k@mgml.me>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
        Mariusz Tkaczyk <mtkaczyk@kernel.org>, Shaohua Li <shli@fb.com>,
        Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH v4 8/9] md/raid1,raid10: Add error message when setting MD_BROKEN
Date: Mon, 15 Sep 2025 12:42:09 +0900
Message-ID: <20250915034210.8533-9-k@mgml.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915034210.8533-1-k@mgml.me>
References: <20250915034210.8533-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once MD_BROKEN is set on an array, no further writes can be
performed to it.
The user must be informed that the array cannot continue operation.

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/md/raid1.c  | 4 ++++
 drivers/md/raid10.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 55213bcd82f4..febe2849a71a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1786,6 +1786,10 @@ static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 	if (test_bit(In_sync, &rdev->flags) &&
 	    (conf->raid_disks - mddev->degraded) == 1) {
 		set_bit(MD_BROKEN, &mddev->flags);
+		pr_crit("md/raid1:%s: Disk failure on %pg, this is the last device.\n"
+			"md/raid1:%s: Cannot continue operation (%d/%d failed).\n",
+			mdname(mddev), rdev->bdev,
+			mdname(mddev), mddev->degraded + 1, conf->raid_disks);
 
 		if (!mddev->fail_last_dev) {
 			conf->recovery_disabled = mddev->recovery_disabled;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 86c0eacd37cb..be5fd77da3e1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2039,6 +2039,10 @@ static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (test_bit(In_sync, &rdev->flags) && !enough(conf, rdev->raid_disk)) {
 		set_bit(MD_BROKEN, &mddev->flags);
+		pr_crit("md/raid10:%s: Disk failure on %pg, this is the last device.\n"
+			"md/raid10:%s: Cannot continue operation (%d/%d failed).\n",
+			mdname(mddev), rdev->bdev,
+			mdname(mddev), mddev->degraded + 1, conf->geo.raid_disks);
 
 		if (!mddev->fail_last_dev) {
 			spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.50.1


