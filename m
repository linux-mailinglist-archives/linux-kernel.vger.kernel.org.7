Return-Path: <linux-kernel+bounces-766585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7910B248AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35C07B1A38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E722F7454;
	Wed, 13 Aug 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="wy+eNmNH"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7392F6596
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085387; cv=none; b=Uxmh9JRl6W6KPZlGxEeRje4p1uWHbluRtm0oXXSTGemhTQJO+iCA8482pycYbwhTV9kTfZ0jh0Du7owJI6aUZmbo0CwBSHPRSCjcEgS/mpXV+vpWIls2xdIczlDTizXCDo6pX3ZSwamKK8Kar1kwqaXFXNNwUk3Hwu1FGDUYo1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085387; c=relaxed/simple;
	bh=qMWpIT3q6+DH/e2eftD66/YT6lp/ktA3herAdpzEiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EiXrJlp2TMcr1OhN8ZXY7vg7KXjbkb4L9AGBdC9qZwKAOzbrgasGCUfJBTfxm6JHvhR2Y0MFnCZSZNPrYEkFMvALQbwDQNFMsXpQm8YZOjiqv2q5TTTH5RMFJ8k3tMaU1O7thCsPszTXV+Kd8A1TdnPxM0eC2WGgEn67Gmj2mco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=wy+eNmNH; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 615B9101C95C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:12:57 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 615B9101C95C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755085377; bh=qMWpIT3q6+DH/e2eftD66/YT6lp/ktA3herAdpzEiCw=;
	h=Date:From:To:Cc:Subject:From;
	b=wy+eNmNHangXvZY+OXaj35iXyImUDAt4r81M5ORB3z9YAzwGHYXwkvh+4Lyl9QVwl
	 LsN8YM4IzyLCz0h4kHIVKzmRG4xRWYKVd887MWWXHFYfpEkbhh1/R4RRtDOb0aWt8n
	 jhEcSDITv7XtWxPrYPnEM2stwxYVfFNERetGw78Y=
Received: (qmail 2846 invoked by uid 510); 13 Aug 2025 17:12:57 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.134612 secs; 13 Aug 2025 17:12:57 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 13 Aug 2025 17:12:55 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id C8470360035;
	Wed, 13 Aug 2025 17:12:54 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id A29621E812E7;
	Wed, 13 Aug 2025 17:12:54 +0530 (IST)
Date: Wed, 13 Aug 2025 17:12:48 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: [PATCH] staging: most: video: improve arguments to copy_to_user()
Message-ID: <aJx6OF6L2Nza9zQ0@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Define cnt constant as unsigned long as expected by copy_to_user()
to avoid implicit type conversion. Define rem constant as unsigned long
to compare it with the same type size_t of count variable.
Use standard helper min() to carry out careful comparison to achive
same functionality.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
This patch is motivated from coccinelle report which suggested to use
kernel standard helper min(). During build check, I found that
comparison max()  showing error while comparing variables of
different types. Hence this patch also fixes that to make comparison of
save types.

Compile tested only.
---
 drivers/staging/most/video/video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 2b3cdb1ce140..4b15c390c32d 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -172,8 +172,8 @@ static ssize_t comp_vdev_read(struct file *filp, char __user *buf,
 
 	while (count > 0 && data_ready(mdev)) {
 		struct mbo *const mbo = get_top_mbo(mdev);
-		int const rem = mbo->processed_length - fh->offs;
-		int const cnt = rem < count ? rem : count;
+		unsigned long const rem = mbo->processed_length - fh->offs;
+		unsigned long const cnt = min(rem, count);
 
 		if (copy_to_user(buf, mbo->virt_address + fh->offs, cnt)) {
 			v4l2_err(&mdev->v4l2_dev, "read: copy_to_user failed\n");
-- 
2.34.1


