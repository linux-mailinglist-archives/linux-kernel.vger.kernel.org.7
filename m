Return-Path: <linux-kernel+bounces-660581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0537FAC1F93
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 11:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542014E19F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA8226556;
	Fri, 23 May 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="23wcnIM2"
Received: from outbound.pv.icloud.com (p-west1-cluster5-host7-snip4-10.eps.apple.com [57.103.66.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8118DB14
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991726; cv=none; b=e7wsmzK3hc5vWtbO0wLMUrUmM2czhA0EX63Rgc55eYnCgAlQ/R1StcQSnd2KyqaaAkFCFzZCxnpQ3kJX/JOEyxX+RWGzefvvaoqGiMJ0pEh6W2qKi2ZMiFFGSLhO3L84gZz50YlHjigt47eSDJGmQ7VuXlwr0qL/y3wUADuCQHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991726; c=relaxed/simple;
	bh=RnYD+Ni15zMNK1TCEl1muSbfKEbGPsYAXEH5yp9H8kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ItiSop3p8ngmHhYn19BuE3+GDMcKTsvVDz6Ylinj8+i/dalrPQDzu7IHlYT/Q7d1SOhUhnZM8SbAwyFd2ffeiQne369HFy6UmmRQmk9OCf96/shSe6QVwxW/qvpNCEPoRd9WD9Zbd2sIRbueoYxaN0dVDbA/tBHY/neDo1XHFPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=23wcnIM2; arc=none smtp.client-ip=57.103.66.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=YyKS243VV7SsoTdftLin95+GlAHrUt5ZaL5mE+UwCYI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=23wcnIM2CdyIu0okcrwv2i7gqi/u9yY6NWAsNBMyVi53j5Z/EZwYVuN6S8MQ795gJ
	 f48FPfqKNHvO+C8M2Mp08nUvQyqcjcVQFDo+697Hk4slfG5KQ9FPPQ73MM7aRjJ/v2
	 a3HU7khqxTurXRIFqsG+ebZgSOppVsGG/ThzEUBDP0ybWBKwZndkAauf5ZoaOe7ZF7
	 ma/Oycp4Eh1q7ipVKO4qaLkX3gMl8w9KN5VZzUX8DhfFzuChaN+ZOla7EvprcYLHZo
	 lmZqPio8vk2HFbCAPpQW9O2iE7s6LAX1XF63MfkDx8Kinip8A17wp2I5buwiSvoolI
	 Kcb+VKMLbnSCA==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 4694718028F3;
	Fri, 23 May 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 7432318029CA;
	Fri, 23 May 2025 09:15:00 +0000 (UTC)
From: Ye Chey <yechey@ai-sast.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ye Chey <yechey@ai-sast.com>
Subject: [PATCH] iomap: fix potential NULL pointer dereference in iomap_alloc_ioend
Date: Fri, 23 May 2025 17:14:17 +0800
Message-ID: <20250523091417.2825-1-yechey@ai-sast.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N5XNWfC75tO48dMvU92rl6sLZ-EDykol
X-Proofpoint-GUID: N5XNWfC75tO48dMvU92rl6sLZ-EDykol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1030
 mlxlogscore=857 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503310001 definitions=main-2505230081

Under memory pressure, bio_alloc_bioset() may fail and return NULL. Add
a check to prevent NULL pointer dereference in iomap_alloc_ioend().
This could happen when the system is under memory pressure and the
allocation of the bio structure fails.

Signed-off-by: Ye Chey <yechey@ai-sast.com>
---
 fs/iomap/buffered-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5b08bd417..d243b191e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1618,6 +1618,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
+	if (!bio)
+		return NULL;
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
 	bio->bi_write_hint = inode->i_write_hint;
-- 
2.44.0


