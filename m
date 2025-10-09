Return-Path: <linux-kernel+bounces-847105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4CBC9DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6B623518BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD721C17D;
	Thu,  9 Oct 2025 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afuDnMMP"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2915B971
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025183; cv=none; b=Cf7gQBQ8LGMKhxAqZARQP/84Yp3WSvk7GuS8GabbfPQldAoQrjG5nt52bA1LpZ0ACSFflWT8ixX9eRBVm+RkvHT4y1R/76T4b4ZQk0Pc8EG1nGRN2clcZfQEuS4O5dc8GUNJzXHviWBP0jWRwQLS6t/tONb2ISxUqbODBYCYJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025183; c=relaxed/simple;
	bh=v9Ip7LNP2VEiwnHZrZ8eVNmTBgLbYlpDgpYqVaxsXCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szSML6WHlgjd6/HHJwoUjN6HhQWCAMVIszl6ODEINQ1uo92lu9ALLZoGnZtNKh7KA3a0+iluN1poAD1jR5SBUNhsDNAWPYZkgHPLSmovpeMdGoTwVwDPfDvbFgqn4wVrwMfsqtcBrQogHF64TMXmATNwTjaKET5N8sUa9tM/Oew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afuDnMMP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2680cf68265so8599395ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025181; x=1760629981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjelIz1jAb9hQtmfEuYUisyoqOeEVtNaaf0UqITCHw=;
        b=afuDnMMPd4LULkh9nJ5IgXG0ZxtaNMtF+hE3Z09mah3UpPNVfjlE4J98urDV22mn9F
         wBIq8AvIhvP1ZEeLuZAOmAHc/mFrAkKCRl0IoTXevXuaGbgee2Z7PLOF5T6YC87nhPHU
         k/Oz7GAiQqkI0g+87KdXwPJdludaBP6UB4oLKg7700QGl7EFYdmy6hujvMDFe4lrzrMo
         V8OJZDAPnR1sZZJVQDmeeBvUwyXjs3TinoxFzqav77G1nk9IzzVnTJBw9EuTsFQvZEwC
         +AdbFZWzOjcN1GaKl1eAwPoyfHVWwQYY7PgEZeN64GjcZDI1IqKZ750x7ri50QDV+K+r
         p3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025181; x=1760629981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBjelIz1jAb9hQtmfEuYUisyoqOeEVtNaaf0UqITCHw=;
        b=tCdoESfjkpLJ+GHbHVxr8GWNM2vbYybB8Kc1DS6AL0Ln8WxgLRiVnwWVtoz7B7FUPZ
         +Duj2z1RpLeTxTbp3MztkBxOlbpt3w0ClVFyredkg6nelqxVpB3um23QbhqJ4mkqLcOw
         kbq1mmD5McMNw5b5QZGNV5btAIhmkjFtrixZ9i9PCS1cMWXrKErlaXdqNsJXrw35GYDY
         tAce+lIcaWSIzA2NRuR6/oKP3id3zekBMuoF1soTfKvIENJw98xBGG3LG70d4mnNszIn
         pl7Oo/w7KOeim+EwO485+4fVkIxQKZrZ4TBYo7xPHfNnqv+Ffw1j+uIrcSzw9irMz+c5
         fmuw==
X-Forwarded-Encrypted: i=1; AJvYcCXHFr7TiX8145I5PXbQmL47H+t4sLDn196Xvz1+b50AZVTOpsSqIFXJUaBuUDzEdL4YuAyB7CbXQB29iP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bkCkhRaiEoCI1Q7DbIDwJLpz9JPdlwAgWzGzuuzKiD9D2jYb
	DwIWxG+DtVsjxIpW0vFdanE2CKPp2tLsOs4Kd4l0nsGPp2mkbexPt1nJ
X-Gm-Gg: ASbGncvB7KlN7nn4QZsqbxEMElcvSESMVReR4AftVu2k8OIak7Z9K4/S2ACzDuV36a8
	6OGmgTTVbuU9vV+YBrZ1VO6Q7nqsPDiaHEV54RvV32rFDRgO6OumPY0SAPvDFT9fJwjJaOxX96w
	Gs5GM9X2YH40FTNQGrkGIxNNoAUbEnqlZw/r0+gtc8aepUp+4pr0ExMbksEQILJ7ml+CQuEivlb
	IF9rbQ2JLpkSCbIu3jqaBcWqgE0/H9U0vRpsty9ji2rK4nSGQGIn/i+PU2d8hc+P9K1CBDjbzoE
	M/3vCNhZriUeZI5qM72KaWnzA9QSTc58bvGOLggL0W8IvgyHj1WVFrCQBZGZmfz/2uszfykCRi1
	48i8Tl3eBUqhzH9f+AYXcxGe0g4e4jNUOg+Wi5usxQmPSVB3BOtA/E8NjNBaWiipxKUIeaQd3wY
	mO1R6ebg==
X-Google-Smtp-Source: AGHT+IEdT0C5qPAQpYvvT5gBwcW+zTEsCEkcKCV8GsD4mlbpRYW3wavevl7sYSUR5UGpbsxfvQUkAQ==
X-Received: by 2002:a17:903:1b2e:b0:249:3efa:3c99 with SMTP id d9443c01a7336-29027305700mr93726095ad.61.1760025180843;
        Thu, 09 Oct 2025 08:53:00 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08eb7sm32372795ad.82.2025.10.09.08.52.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Oct 2025 08:53:00 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH v2] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Thu,  9 Oct 2025 23:52:53 +0800
Message-ID: <20251009155253.14611-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

When adding a request to the sort_list/fifo_list, the kernel assigns
{jiffies + dd->fifo_expire[data_dir]} to the fifo_time member.
Consequently, we must subtract {dd->fifo_expire[rq_data_dir(rq)]} in
the started_after function.

In contrast, Commit (725f22a1477c) introduced changes to utilize the
fifo_timevmember of requests on a dispatch list. The patch assigns
{jiffies} to the fifo_time member when adding a request to a dispatch
list. However, it continues to use the started_after function, which
still subtracts {dd->fifo_expire[rq_data_dir(rq)]} from the start_time.
The commit message does not explain this design choice, though it appears
reasonably justifiable since dispatch lists should inherently have higher
priority than sort_lists/fifo_lists. Thus, the default fifo_time set for
dispatch lists should be smaller than that set for sort_lists/fifo_lists.

Originally, {dd->fifo_expire[data_dir]} was exclusively used in the
deadline_check_fifo function to control the timing of scanning fifo_lists.
This subsequently determines the offset for the next scan of sort_lists
via {dd->per_prio[prio].latest_pos[data_dir]}. Therefore, a larger
{dd->fifo_expire[data_dir]} value makes it less likely for timed-out
requests to be scanned.

However, Commit (725f22a1477c) reversed the semantic meaning of
{dd->fifo_expire[data_dir]}. When adding a request to a dispatch list,
the patch only assigns {jiffies} to the fifo_time member without
compensating for the {start_time -= dd->fifo_expire[rq_data_dir(rq)]}
operation in the started_after function. This results in larger
{dd->fifo_expire[data_dir]} values making timed-out requests more likely
to be scanned. By default, fifo_expire[DD_WRITE] > fifo_expire[DD_READ],
which incorrectly gives write-IO-requests higher priority than
read-IO-requests and creates inherently illogical prioritization.

On the other hand, the Commit (725f22a1477c) merges the effects of
fifo_expire and prio_aging_expire on the same code behavior, creating
redundant interactions. To address this, our new patch introduces
numerical compensation for {dd->fifo_expire[data_dir]} when adding
requests to dispatch lists. To maintain original logic as much as
possible while enhancing dispatch list priority, we additionally
subtract {dd->prio_aging_expire / 2} from the fifo_time, with default
values, {dd->prio_aging_expire / 2} equals {dd->fifo_expire[DD_WRITE]}.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
v2: Add a more detailed commit message

Link to V1:
https://lore.kernel.org/all/20250926023818.16223-1-pilgrimtao@gmail.com/

 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3e741d33142d..fedc66187150 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -659,7 +659,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
+				- dd->prio_aging_expire / 2;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
-- 
2.50.1 (Apple Git-155)


