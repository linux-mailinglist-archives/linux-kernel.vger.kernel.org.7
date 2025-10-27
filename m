Return-Path: <linux-kernel+bounces-871993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B887C0F078
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99B119C3CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B130FC17;
	Mon, 27 Oct 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="hW9CUXux"
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DE30F927
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579859; cv=none; b=Cf4Wl+ljQ2OBrgHpaW/RVx7IeFXUFJqeinTU+qj1wuPFNaexnITUcJzOQia9UH3MdJ1fIK/gKeHqolyH0uKeVUBQ9ShRewHEv41TbCgTOoreaiJYL+XsSOdnRL1obdFUCEtpjjtOeYsq0CA+Tz7YnaclT/VEc746Gx3OOZ6eKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579859; c=relaxed/simple;
	bh=qtnaKSZX0v25wsW820bs4QBKufRkNlYzDoC89qHYejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbeQQA0K/izgF08p5BoBBsKcPgAGzY1VrY3Eb1YuhjS0ga3BWzj7dyAnNDhDLkeGpjAcahwZDEkqIg/o4oKNp07lWeUIQQXbAL5B8/dO7McHBWpl+XhDEURkyPAOD++VrKUZh+C+wYzcqyZDzUKPN9oXwCDX5qtPAwc/iXAV/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=hW9CUXux; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3796170-ipxg00h01tokaisakaetozai.aichi.ocn.ne.jp [180.53.173.170])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RF4hAp090988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Oct 2025 00:04:46 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=HSAThXQjSym+JhHRTUbpIfpjmtQ7EdedUUveP1bgezI=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1761577487; v=1;
        b=hW9CUXux59T07ebIL4gJ3lBcuOhdVBzyluDLqNy+fQ6Qx7TijJHH3byWnTcLuwKd
         E6xSJIyQKE9j4CHTTrMe6kBGMT+Pkwwsmx6wMjUErxZejbWCXLyCmQGFtmIVFuYh
         BBcVu05TEuFsa0emXFh1zhhWGjA+K4v2mnI/2ooTN41Zii4JXXFUfjCGKc75HaDr
         QrAShJVl9a6JqUKWDOvuyMZqSlorFedjAVT5qQJ+xrOT3smkzat/MS3LZOmZxtcg
         yHa0D2UigDYZc7EurY62ArFe/SB3slAZVYlCLftxcOlvG2bUvt8E07HHusqqPZUe
         VGY7h49RvNmfTkJsezj12A==
From: Kenta Akagi <k@mgml.me>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        Shaohua Li <shli@fb.com>, Mariusz Tkaczyk <mtkaczyk@kernel.org>,
        Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH v5 15/16] md: rename 'LastDev' rdev flag to 'RetryingSBWrite'
Date: Tue, 28 Oct 2025 00:04:32 +0900
Message-ID: <20251027150433.18193-16-k@mgml.me>
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

The rdev LastDev flag is assigned to devices
that have had metadata written with MD_FAILFAST in a Failfast rdev,
but whose bio failed but did not become faulty after an md_error.
After that, the metadata write is retried by sb_flags
MD_SB_NEED_REWRITE, but if rdev LastDev is set at this time, FailFast is
not used and LastDev is cleared if the write is successful.

Although it's called LastDev, this rdev flag actually means "metadata
write with FailFast failed and a retry is required. Do not use FailFast
when retrying for this rdev."

This is different from what we might expect from the name LastDev,
and can be confusing when reading the code.

This commit renames the LastDev flag to better reflect its actual
behavior for improving readability. The implementation remains
unchanged.

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/md/md.c | 6 +++---
 drivers/md/md.h | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3c3f5703531b..1cbb4fd8bbc0 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1063,10 +1063,10 @@ static void super_written(struct bio *bio)
 		if (!md_cond_error(mddev, rdev, bio)
 		    && (bio->bi_opf & MD_FAILFAST)) {
 			set_bit(MD_SB_NEED_REWRITE, &mddev->sb_flags);
-			set_bit(LastDev, &rdev->flags);
+			set_bit(RetryingSBWrite, &rdev->flags);
 		}
 	} else
-		clear_bit(LastDev, &rdev->flags);
+		clear_bit(RetryingSBWrite, &rdev->flags);
 
 	bio_put(bio);
 
@@ -1119,7 +1119,7 @@ void md_write_metadata(struct mddev *mddev, struct md_rdev *rdev,
 
 	if (test_bit(MD_FAILFAST_SUPPORTED, &mddev->flags) &&
 	    test_bit(FailFast, &rdev->flags) &&
-	    !test_bit(LastDev, &rdev->flags))
+	    !test_bit(RetryingSBWrite, &rdev->flags))
 		bio->bi_opf |= MD_FAILFAST;
 
 	atomic_inc(&mddev->pending_writes);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 38f9874538a6..0943cc5a86aa 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -282,9 +282,10 @@ enum flag_bits {
 				 * It is expects that no bad block log
 				 * is present.
 				 */
-	LastDev,		/* Seems to be the last working dev as
-				 * it didn't fail, so don't use FailFast
-				 * any more for metadata
+	RetryingSBWrite,	/*
+				 * metadata write with MD_FAILFAST failed,
+				 * so it is being retried. Failfast
+				 * will not be used during the retry.
 				 */
 	CollisionCheck,		/*
 				 * check if there is collision between raid1
-- 
2.50.1


