Return-Path: <linux-kernel+bounces-897891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FEFC53E81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537DC3ABD67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E32D97AF;
	Wed, 12 Nov 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvdstYrc"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F0340DA6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971648; cv=none; b=ChgcXng8oPQ4L05Yy8A28ya+WJx9QwWfpDc1f3+Ohk8SlOPC+EL+tlDZh30XNFPBEJM6fm94eVPzLPjkXKmuPHlADcLALplp6mFkwld6hnlAmDMvRd3twemnhYQnKIkoToJQOV9kE6tNQgypjMXuqc6nTiDaoUnMxjsgzI4+H34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971648; c=relaxed/simple;
	bh=UWTVi+79biUDXYVbP1Zfv1jqXnj1FUi+MQ3m7OOq1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcXXEF08Mok/rqdwer259ZryWNNOjvS4qjS7rE5BzB4UXbFjbwKAZZJJ3RIi53oZXpYvYRlxvzvA+ElZQh9oMODFMIFyLoWkqyRQpRDcpdVMP08gUtlxklNe/S6xssLeQdN6ZVCJ5jxz2AR5vHQvv73x53zL/4dQ/yyrB2rbA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvdstYrc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed75832448so14497701cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762971646; x=1763576446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bm1UHN2KZxJ0B3W03H3cTsYhakxCO69X9Qr+GtDJfPk=;
        b=GvdstYrccqKxeRmF2zQbbG230Gziq5f2liMevtY97kPVichOYfm+4MneI5nSlYiwS4
         bpJqtz7zqx6kge8YfXnr61Te1lNSFP8OxLhEKIY1SGNoC6YsRWrttgTneX0mhK97pDr1
         zqnSqIM8CuAJG2qBhWO0Ph89HHWbGIxIg9oy96Rkx44Q2TGo5bTT35ERge2rha1/mQ/c
         xVpxahBH6S760pl/wbqaH7qXRgMk0cYLW5d3zBFCGBFEeJ+/aTa5paX6fhOhQnQ7rysZ
         xh+uZu+XFYsmdEYkR5sF6YQ1hp1gOqDcHjs1seKhAeO/yxMneKCXszFMdp7PlkmKTvqS
         SqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971646; x=1763576446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bm1UHN2KZxJ0B3W03H3cTsYhakxCO69X9Qr+GtDJfPk=;
        b=JWdD6vegsgOX1z5zKGNIv3g1DoF4GZRo+IQxfb5snRSZSum+sNYJvsPgljQV7qh7i0
         Td/Qom1pnhs1Wb/p2A2edtkLz5cQRgluj1BfICWmuE8ikIq/gFVbHb282pLh80tC0eDE
         v7EeYILb6Yo6JTILNzUq4mR1eK6N6dI8/4DVguNO0cAComuUA4fyzB2eH8OtZDVjZbAW
         AcGrCIJdPqqN7T3Moww3oTimiYbi7vp0t26+0B0p8G1wA7lCNmnxOrrpB3MXZtI05bFF
         7882MujM3E7qB7RHHTITlrVEcPPlL82BbU4tX99t5In9dNNJm83O282KvQaShrKxkYBG
         azZg==
X-Forwarded-Encrypted: i=1; AJvYcCXo7JZJPFDNTzlhJ9cQo73m5TdmaCeqWTfcRVrLpPyv1E2q55nmoaS3Qcck7zMbQvSniPDsLEwnRtTWfmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs7AfI9F6mFzRxqpQ1I8uv7TrIYuVZIHvmJn9SoZnvr9vU+sx
	X3tCxaFSE2TlJ6VQ9515PDQfsXdGOCkOLSGY+0Ht2iejd4G1yZg5UEMR
X-Gm-Gg: ASbGnctfcGZ02D5+1fHtoEKDJiC1CTZVuxaDbpp2ZCONFrHg6CwS5OTZgbNLxukIC+w
	E1SUZdqs9u2tZGNpWR4yBvh0VRitgKgeVNmLu9XmaX3HjoOXZlFoAR/hpSKfLwJw8gFhQWhq4wE
	O8SzldBzw1P4aNw+axjKh5O+bDkcblybBu8g7xn5gxJr+8E3a5Z9I+0dJ+G241k/x8w/yWKoqf5
	3ha2PSMcMPxVgS5Vl/lR6ifqY3WKl7Q7+VofX8egewcZ+UElqqLpEsAf6Aa84CfC/q+uUCs4hdC
	0DP0DTVo2GnAKfwCzV+p44rJ++wAJDoG6YxJhS+Cw8fshX8fgHQL4/Vu23sta/5IIjk72Lzpamh
	E5VdrCc20zcclRJ2cjd3u+ck5Rkg7iz8e21WWb2KbSjQYJ2OICp3MPoBkMZw2ptN0H6pmw9mwUZ
	oHmLnxUPtzKoq+nCeA1h0u
X-Google-Smtp-Source: AGHT+IEuXqC6cY8OV3bFmpAtTGXgz+fn2i6JPBVrYLRDN+Z4yHegy+UVfSzEKFMHist/CiPMcek+nw==
X-Received: by 2002:a05:622a:1ba3:b0:4ec:f073:4239 with SMTP id d75a77b69052e-4eddbc6a4f9mr52756321cf.6.1762971646334;
        Wed, 12 Nov 2025 10:20:46 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda5659cd2sm92260921cf.15.2025.11.12.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:20:45 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: cem@kernel.org,
	djwong@kernel.org,
	chandanbabu@kernel.org,
	bfoster@redhat.com
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] xfs: reject log records with v2 size but v1 header version to avoid OOB
Date: Wed, 12 Nov 2025 13:18:18 -0500
Message-ID: <20251112181817.2027616-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aRSng1I6l1f7l7EB@infradead.org>
References: <aRSng1I6l1f7l7EB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xlog_do_recovery_pass(),
commit 45cf976008dd ("xfs: fix log recovery buffer allocation for the
legacy h_size fixup")
added a fix to take the corrected h_size (from the xfsprogs bug
workaround) into consideration for the log recovery buffer calculation.
Without it, we would still allocate the buffer based on the incorrect
on-disk size.

However, in a scenario similar to 45cf976008dd, syzbot creates a fuzzed
record where xfs_has_logv2() but the xlog_rec_header h_version !=
XLOG_VERSION_2. Meaning, we skip the log recover buffer calculation
fix and allocate the buffer based on the incorrect on-disk size. Hence,
a KASAN: slab-out-of-bounds read in xlog_do_recovery_pass() ->
xlog_recover_process() -> xlog_cksum().

Fix by rejecting the record header for
h_size > XLOG_HEADER_CYCLE_SIZE && !XLOG_VERSION_2
since the larger h_size cannot work for v1 logs, and the log stripe unit
adjustment is only a v2 feature.

Reported-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
Tested-by: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Fixes: 45cf976008dd ("xfs: fix log recovery buffer allocation for the legacy h_size fixup")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changelog
v1 -> v2: 
- reject the mount for h_size > XLOG_HEADER_CYCLE_SIZE && !XLOG_VERSION_2
- update commit subject and message

 fs/xfs/xfs_log_recover.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index e6ed9e09c027..99a903e01869 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -3064,8 +3064,12 @@ xlog_do_recovery_pass(
 		 * still allocate the buffer based on the incorrect on-disk
 		 * size.
 		 */
-		if (h_size > XLOG_HEADER_CYCLE_SIZE &&
-		    (rhead->h_version & cpu_to_be32(XLOG_VERSION_2))) {
+		if (h_size > XLOG_HEADER_CYCLE_SIZE) {
+			if (!(rhead->h_version & cpu_to_be32(XLOG_VERSION_2))) {
+				error = -EFSCORRUPTED;
+				goto bread_err1;
+			}
+
 			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
 			if (hblks > 1) {
 				kvfree(hbp);
-- 
2.43.0


