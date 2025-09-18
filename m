Return-Path: <linux-kernel+bounces-822884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A232B84E40
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201C45463C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF130C620;
	Thu, 18 Sep 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0G3tWW8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5BA30C11A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202977; cv=none; b=OU7tKSiL3ppmhnjOgfaj+dtkfh1tNp7JPmtUg0/FhO806EmdXJQ/79c2v/G3jQOhpAD6LOS9uU43az3EEjkbIyUUuEkyLGBoVE5B2OJqyeOssYMhdwO7H8N8+yUpJNGfiJqXxtKOoLYUKu+hftmuCmf89FvRKjvtWCjl+dkZeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202977; c=relaxed/simple;
	bh=qd3hXY9XgHiw8cjge13Lf6hOHRKSXKhDH3/3yP9EWrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXiSALfaN6DTxYlecTAEnimXrxCREIpKfXtYOrP0nKTt8JAap+GwLwuFitcPQz21iVlxIzvPr/7TRLyFz2bH69DGxWlZp00l+j8d8dhzhSP3Kg2Jjz5HisU8C1xjS3Y29cssJR1KO3BtKXO5DUq3cYoiT5GQ4uvBw8LudqjUUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0G3tWW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758202975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO/zlqFI4HAQySVPIlojxj20+66UlyKTQ9bnhnA2hwE=;
	b=M0G3tWW8YqxBeRh/7s6A1s7dUu6ZH0ZnTFPXldxXBuLg+dFUlpTP99Q9lGvP0tw8bOUt18
	GDCG7J2lkRcI0nmavVfb54ffmOBEQmBG3W9GOYQolBQliDubfEuVy6UcmTNtPSbKcBweiI
	0qQUv5sDyXLm5f6dLwV8aCMbeSS3q/I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-O7FC1pkoMbGJIt_TjXyPxw-1; Thu,
 18 Sep 2025 09:42:50 -0400
X-MC-Unique: O7FC1pkoMbGJIt_TjXyPxw-1
X-Mimecast-MFC-AGG-ID: O7FC1pkoMbGJIt_TjXyPxw_1758202970
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D55A2180057E;
	Thu, 18 Sep 2025 13:42:49 +0000 (UTC)
Received: from o.redhat.com (unknown [10.45.225.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A95A819560B8;
	Thu, 18 Sep 2025 13:42:47 +0000 (UTC)
From: Heinz Mauelshagen <heinzm@redhat.com>
To: song@kernel.org
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heinz Mauelshagen <heinzm@redhat.com>
Subject: [PATCH] md raid: fix hang when stopping arrays with metadata through dm-raid
Date: Thu, 18 Sep 2025 15:42:42 +0200
Message-ID: <b58dddf537d5aa7519670a4df5838e7056a37c2a.1758201368.git.heinzm@redhat.com>
In-Reply-To: <cover.1758201368.git.heinzm@redhat.com>
References: <cover.1758201368.git.heinzm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When using device-mapper's dm-raid target, stopping a RAID array can cause the
system to hang under specific conditions.

This occurs when:

-  A dm-raid managed device tree is suspended from top to bottom
   (the top-level RAID device is suspended first, followed by its
    underlying metadata and data devices)

-  The top-level RAID device is then removed

The hang happens because removing the top-level device triggers md_stop() from the
dm-raid destructor.  This function attempts to flush the write-intent bitmap, which
requires writing bitmap superblocks to the metadata sub-devices.  However, since
these metadata devices are already suspended, the write operations cannot complete,
causing the system to hang.

Fix:

-  Prevent bitmap flushing when md_stop() is called from dm-raid contexts
   and avoid a quiescing/unquescing cycle which could also cause I/O

-  Avoid any I/O operations that might occur during the quiesce/unquiesce process in md_stop()

This ensures that RAID array teardown can complete successfully even when the
underlying devices are in a suspended state.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
---
 drivers/md/md.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e033c26fdd4..53e15bdd9ab2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6541,12 +6541,14 @@ static void __md_stop_writes(struct mddev *mddev)
 {
 	timer_delete_sync(&mddev->safemode_timer);
 
-	if (mddev->pers && mddev->pers->quiesce) {
-		mddev->pers->quiesce(mddev, 1);
-		mddev->pers->quiesce(mddev, 0);
-	}
+	if (!mddev_is_dm(mddev)) {
+		if (mddev->pers && mddev->pers->quiesce) {
+			mddev->pers->quiesce(mddev, 1);
+			mddev->pers->quiesce(mddev, 0);
+		}
 
-	mddev->bitmap_ops->flush(mddev);
+		mddev->bitmap_ops->flush(mddev);
+	}
 
 	if (md_is_rdwr(mddev) &&
 	    ((!mddev->in_sync && !mddev_is_clustered(mddev)) ||
-- 
2.51.0


