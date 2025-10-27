Return-Path: <linux-kernel+bounces-871989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9389C0F0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E3403DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA74A30E825;
	Mon, 27 Oct 2025 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="cj8u3Riv"
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490A30DEA2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579850; cv=none; b=E4kPKfmZPjAZ0ytcdwVlgIZwzCTSH/WjLfIKXGCQor9gsyP/Id8BCV8Qg2sDCZ/FmcQ+owXnpDtVKoL5dPfMYP5fx6bsbiO3bcHqwWFPR9AYRNSyrXvdJwUm/9+tD7xCKmQW2ILH5YT20DboJzaKCgursLTUAb6DnxCI0d1K0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579850; c=relaxed/simple;
	bh=GiJM0j7XIJSrgiGU1nODsCDYyTYNrdzvNSTEM+cNYuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbwrCxxTINEGwz7Tuav+UkpWKsDwb2kzWYnS86MvM7kyoo6usu3/2MJLgn5rzc00Cq2uINZyzIffzsKwq3oggk8oSiVBesc8cF4yD9f6ru7XROpsrc5e3x6rsLneGBlLQO4CcAE/iA9dmwhkbLbEXQ2M+yOIxU2LhDxgOgwaIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=cj8u3Riv; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3796170-ipxg00h01tokaisakaetozai.aichi.ocn.ne.jp [180.53.173.170])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59RF4hAd090988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Oct 2025 00:04:45 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=uy9KH+7/iFBaIvHnHGGLWrehk7S8042ac77AEgzmD8M=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1761577485; v=1;
        b=cj8u3RivypG8IY8lsq8zpbl2E0PkY+x+0CBtfHuILaIVWQ9v7oGhJHpxmfqmXk2E
         w0k0ICQWBw5piRtGWhYj0RJJU+zMNktNurrmbXAQMeVHlXH9E+8eUa/3LgsdJgZP
         0XrOatl7b2nFGJgTvnkeRfsh/XZU8YvoZE742AySo2ouQYoC9ady2hkfSoxLiqrJ
         qMN8Snkhvg3wDm0Hl30F0Dk3yPgrG7zD4HjuMdHfTr52k9KhmbbygKyGrMq7ZQlZ
         atfVa4fo5mmP92M1ch/ioBofZsAJgIjxz3PlxqLEKIkCqykxYb6v/zj60lSBcWG3
         i7HRCMi+xjqd23WZvy8njQ==
From: Kenta Akagi <k@mgml.me>
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        Shaohua Li <shli@fb.com>, Mariusz Tkaczyk <mtkaczyk@kernel.org>,
        Guoqing Jiang <jgq516@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kenta Akagi <k@mgml.me>
Subject: [PATCH v5 03/16] md: add pers->should_error() callback
Date: Tue, 28 Oct 2025 00:04:20 +0900
Message-ID: <20251027150433.18193-4-k@mgml.me>
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

To address this issue, a new handler md_cond_error() will be introduced
to ensure that failfast I/O does not mark the array as broken.

As preparation, this commit adds a helper pers->should_error() to determine
from outside the personality whether an rdev can fail safely, which is
needed by md_cond_error().

Signed-off-by: Kenta Akagi <k@mgml.me>
---
 drivers/md/md.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index c982598cbf97..01c8182431d1 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -763,6 +763,7 @@ struct md_personality
 	 * if appropriate, and should abort recovery if needed
 	 */
 	void (*error_handler)(struct mddev *mddev, struct md_rdev *rdev);
+	bool (*should_error)(struct mddev *mddev, struct md_rdev *rdev, struct bio *bio);
 	int (*hot_add_disk) (struct mddev *mddev, struct md_rdev *rdev);
 	int (*hot_remove_disk) (struct mddev *mddev, struct md_rdev *rdev);
 	int (*spare_active) (struct mddev *mddev);
-- 
2.50.1


