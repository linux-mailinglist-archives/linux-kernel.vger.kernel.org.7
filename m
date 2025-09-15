Return-Path: <linux-kernel+bounces-816109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F7B56F97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887593A712F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4A276045;
	Mon, 15 Sep 2025 05:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="exL+AbdH"
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD01FDE19
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757912562; cv=none; b=PmHzrg/KYUBfu/AqbvyCOsTKXzDt/veO+WmW3yF4KLj4OSp+0K7KX//or1cd3F7IX37U10jJ2XsBY79IwukncRalDuGtk/Vo7db4lWLDxlAKY8QI1FYEE9hn7SXSXBVHuCBE0UNAzIx3n9U7DXArC9Cq09AtBpFR+214+5wKTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757912562; c=relaxed/simple;
	bh=Spp3/3eTGCFSeofHT3BiTDH6F7HLA3NPNTzyD9V/zOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRVgVFWy2hCAUixMM0DRDuR68fa4NZmuAXtol4jiMYdAAsFRIuwTkP0JGg95/3XVhlLfjgLqKAnwYhJ/PcaB3j9oIYfhCzxCTAN3oAjnCESJwRgve0PSNhEo5LMXdSLP7aRiQlR/A35aNbaj042G2dAD604dXkIjgyhLX4A75tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=exL+AbdH; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p4504123-ipxg00s01tokaisakaetozai.aichi.ocn.ne.jp [114.172.113.123])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58F3gpZo004256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Sep 2025 12:43:16 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=Egc/gZktqMRQw3A1lmXwPSLk4aYuJupWRWye4Qdc3pY=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1757907797; v=1;
        b=exL+AbdHN16NjauwWSbDqRiPWxPkOdKM7+taj16H7+/SMJsfIoaQJilzpseOULPS
         6Q8J61S2XI4bw8n5qWf1aDCvJQKVbScplupbAQs/ZNReZO6OkinUoX+6/QyCo6ki
         CDffJv+HJzCkV84WOeILZkw45/NZY1zseX5F8cZMaKqgFNWfWEDvdiBgFqt0AQOt
         nplY790Qo/mMTW59rfR2rfbSFPfZUjYDe5lLi7SqMHdd7o4HVW8U/mMEdtylfAP8
         J4fi25/+rKreX5PQF0zrGw+qKTcFxJms4KaY1wfzeHk0XaoUft7vPmP9zfxQS2zu
         +8JGMLZHn27CLaxoRtZ+PA==
From: Kenta Akagi <k@mgml.me>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
        Mariusz Tkaczyk <mtkaczyk@kernel.org>, Shaohua Li <shli@fb.com>,
        Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH v4 7/9] md/raid10: fix failfast read error not rescheduled
Date: Mon, 15 Sep 2025 12:42:08 +0900
Message-ID: <20250915034210.8533-8-k@mgml.me>
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

raid10_end_read_request lacks a path to retry when a FailFast IO fails.
As a result, when Failfast Read IOs fail on all rdevs, the upper layer
receives EIO, without read rescheduled.

Looking at the two commits below, it seems only raid10_end_read_request
lacks the failfast read retry handling, while raid1_end_read_request has
it. In RAID1, the retry works as expected.
* commit 8d3ca83dcf9c ("md/raid10: add failfast handling for reads.")
* commit 2e52d449bcec ("md/raid1: add failfast handling for reads.")

I don't know why raid10_end_read_request lacks this, but it is probably
just a simple oversight.

This commit will make the failfast read bio for the last rdev in raid10
retry if it fails.

Fixes: 8d3ca83dcf9c ("md/raid10: add failfast handling for reads.")
Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/md/raid10.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 92cf3047dce6..86c0eacd37cb 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -399,6 +399,11 @@ static void raid10_end_read_request(struct bio *bio)
 		 * wait for the 'master' bio.
 		 */
 		set_bit(R10BIO_Uptodate, &r10_bio->state);
+	} else if (test_bit(FailFast, &rdev->flags) &&
+		 test_bit(R10BIO_FailFast, &r10_bio->state)) {
+		/* This was a fail-fast read so we definitely
+		 * want to retry */
+		;
 	} else if (!raid1_should_handle_error(bio)) {
 		uptodate = 1;
 	} else {
-- 
2.50.1


