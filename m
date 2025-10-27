Return-Path: <linux-kernel+bounces-871994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F86C0F0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3453422065
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291E3101DA;
	Mon, 27 Oct 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="gmDLhGOJ"
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E930FF20
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579862; cv=none; b=nC3V1b+Gd1EnCA3uWyLuyHkiutdkrC624DUFJ2ebF5FtShBrx3v1Ei1feKBOrQknkUMPvlQErW+R7YtQZZmqAIdt2NC3Dy5D1rQ3LLtyA3WQ/n34FjUIE0+m4HtlCH0JSwbmwIKa3/kMrnT+I452M4Mimps/V7pJdX0PK4YPfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579862; c=relaxed/simple;
	bh=fDDLXYRr8DG1J/Sy8d2/00lhjPfpEUt3qTyk2cUc91I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5CxCAXENpVTA/a5rO9fxvkrn7yph/es7GJ09lvIV6AkrjySd1ThL8SfalxqUgn267hXMecM60mKLrqhqdx7P3Gkeqy6CQXy1mP1Iw34yiRL/aXFpxVvl4C+LK4y7opN5WWl+dZwfr77rgx3j9GmuL+XXZH1cCrMxMpaU+W+g/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=gmDLhGOJ; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3796170-ipxg00h01tokaisakaetozai.aichi.ocn.ne.jp [180.53.173.170])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RF4hAf090988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Oct 2025 00:04:45 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=f+Io4aR19zfdAavz436gI+/sCfOgtfjxIdEmYkp7QcM=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1761577486; v=1;
        b=gmDLhGOJsxfZZXfRDZeX7upNwLJXLq3D8b9gzVbA8YWcN0EOmgQAwAZlt0sdQcQS
         kTzn6DPXx/MkkKKYl1NvsZmwdT9B8aZROt3IQ7W2u9Z/UJHgAqgKXGDtqDdBFOhT
         zErFPiEIm8l6LV5lKH1JMNJiYHkPoWp80PzHt8BJeUxb84rUIJ8Egz/gxDvDPcAg
         JcizZCQ3FijjhEiOqsNOO/wAR0FGSHtxZdxem9w7i2LNXBWuGWZQ1WoNV5jDMIch
         5f8cCxU2SwoK+HZCPQ4HzS9LqtKtUHPyQEdgND5g5ZMArs5GHMGmqm0m+3kyc9kU
         2QtaHKhoXThJnAR1kFEuIg==
From: Kenta Akagi <k@mgml.me>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        Shaohua Li <shli@fb.com>, Mariusz Tkaczyk <mtkaczyk@kernel.org>,
        Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH v5 05/16] md/raid1: implement pers->should_error()
Date: Tue, 28 Oct 2025 00:04:22 +0900
Message-ID: <20251027150433.18193-6-k@mgml.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027150433.18193-1-k@mgml.me>
References: <20251027150433.18193-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failfast feature in RAID1 and RAID10 assumes that when md_error() is
called, the array remains functional because the last rdev neither fails
nor sets MD_BROKEN.

However, the current implementation can cause the array to lose
its last in-sync device or be marked as MD_BROKEN, which breaks the
assumption and can lead to array failure.

To address this issue, introduce a new handler, md_cond_error(), to
ensure that failfast I/O does not mark the array as broken.

md_cond_error() checks whether a device should be faulted based on
pers->should_error().  This commit implements should_error() callback
for raid1 personality, which returns true if faulting the specified rdev
would cause the mddev to become non-functional.

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/md/raid1.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 202e510f73a4..69b7730f3875 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1732,6 +1732,40 @@ static void raid1_status(struct seq_file *seq, struct mddev *mddev)
 	seq_printf(seq, "]");
 }
 
+/**
+ * raid1_should_error() - Determine if this rdev should be failed
+ * @mddev: affected md device
+ * @rdev: member device to check
+ * @bio: the bio that caused the failure
+ *
+ * When failfast bios failure, rdev can fail, but the mddev must not fail.
+ * This function tells md_cond_error() not to fail rdev if bio is failfast
+ * and last rdev.
+ *
+ * Returns: %false if bio is failfast and rdev is the last in-sync device.
+ *	     Otherwise %true - should fail this rdev.
+ */
+static bool raid1_should_error(struct mddev *mddev, struct md_rdev *rdev, struct bio *bio)
+{
+	int i;
+	struct r1conf *conf = mddev->private;
+
+	if (!(bio->bi_opf & MD_FAILFAST) ||
+	    !test_bit(FailFast, &rdev->flags) ||
+	    test_bit(Faulty, &rdev->flags))
+		return true;
+
+	for (i = 0; i < conf->raid_disks; i++) {
+		struct md_rdev *rdev2 = conf->mirrors[i].rdev;
+
+		if (rdev2 && rdev2 != rdev &&
+		    test_bit(In_sync, &rdev2->flags) &&
+		    !test_bit(Faulty, &rdev2->flags))
+			return true;
+	}
+	return false;
+}
+
 /**
  * raid1_error() - RAID1 error handler.
  * @mddev: affected md device.
@@ -3486,6 +3520,7 @@ static struct md_personality raid1_personality =
 	.free		= raid1_free,
 	.status		= raid1_status,
 	.error_handler	= raid1_error,
+	.should_error	= raid1_should_error,
 	.hot_add_disk	= raid1_add_disk,
 	.hot_remove_disk= raid1_remove_disk,
 	.spare_active	= raid1_spare_active,
-- 
2.50.1


