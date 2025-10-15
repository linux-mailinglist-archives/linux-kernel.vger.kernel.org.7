Return-Path: <linux-kernel+bounces-853970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C8FBDD2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F443ADFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D793126AD;
	Wed, 15 Oct 2025 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNcM0fY0"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C99478
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514333; cv=none; b=DxONKKqEBlYOP+5hXKNuidNcUZsTbIM9ESMyObTxQ+S30Lh2woAbFC2OhZYGjwf37Bgwvpt8/Nli0GGnn0VI3doFVxDbwr+tMvZiM84g/sjp2q4uBGlwsOdgR7pcARzTUrG0TAdZh/ICQYjDfKLzfocSQxRET3IFq4LvC65Ls/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514333; c=relaxed/simple;
	bh=nM20uv/VH196Ela8AH318ePR2Zx9QQhvXJlycMg3X6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEnOevY7hzSY7fV0Qh6UmfY+cwBTBVZkrcgXpEMrX82T+ThzcpLaiqaCq6rL3TfDM/6ElC+hku2b5FhDgJvnWiYnOLB8+julxgXlWxIGBJg/ZdbGn8Hzpj989ASjP/zONpdWZH2s5UhLSTIUW0j2dBpNAom52kSyEcKVLj/6g1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNcM0fY0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-856cbf74c4aso1196365485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760514331; x=1761119131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ9JDtSuH57J136kYyFzp8dS4Bh1vYURNdTXyBWFh/4=;
        b=LNcM0fY0DxdSlhRQ0lnBngYnnywjqsYOOrDSm2bTcnTWXTtkExehg70tg1lnGd/Dmg
         Qtt5RbFjPTapYvStkPJafFDGWiKFAqQmc8rrIahnvYl0Ip6HfJSLx0sBZ2ny5/jdhOyY
         s32jZS9YtRV060FVv9dEpsyeAu5rpe2o0wMxOEsGZJcrZjUKjp0I+lEj/qgjofMq8gcI
         2KYTzXq1zwSKgs1wEYlbCjj2L1CKswUHnZesepdLDpzVp4dJCKcCtjCtBPePr13dsY3I
         XEjvcjzfBwGmQtuuR8fJqspAVdP1+S16xElftCGvpHzkyPmNYAwnn0tneTXv6atqt4Oi
         1XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514331; x=1761119131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZ9JDtSuH57J136kYyFzp8dS4Bh1vYURNdTXyBWFh/4=;
        b=vQdu1Wn1C5lWZrBs969iucyXQ+T4s1hwHmbJIMtZbhIYo4A7Ia4h65iszHjKNNR0dw
         vfbl7nYlUrZSZffNqYoVKRAZuUl5N8lgblI6HlSVSmi2AlX2kynOByHqJ2DTinxWM1bN
         4HDb9DLFY6OVfiYiucc22Vga0qzAPRwngCImVukHligvfgrcksMdxK8e3gg8U89XYcup
         bW4TtYstouk89Ddxd9SWXScZmVtdUCxenmYDiXpm11ok40EZMpVXG+auyyd+YNJX3eF1
         YHbpDijYxB+5TqM36a4LLg0zOqLmoTIe4sbG/J0H84ELzor2J4FXRmOqDGIbIrVufCQQ
         mlKA==
X-Forwarded-Encrypted: i=1; AJvYcCWS7cc3teE7UiEHyy25+DkT7bZtFhEFii7JaHQMDtX5hEegwn6vZ5n5fhMlQF94GHVc8jPDMhm+zqgXhzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY55gvHX+0afKumb4Pu3oHHIF0yyAmiOwlt8Sf8J2Ccec0dplj
	96qTXzLe0bhl2WDlBuw8+Pj0xAAeEHbggkHd/2hmOli/E0roWCw3Kyxc
X-Gm-Gg: ASbGnctxT4ROH1uST7DLqCqXUCAwA2hK/YeLQl3KKCgTpDQozPI0feqw3MAMeRfqKPh
	7ARrWSxgom8oXx3EOCa3EXpiiDWvriSkJg/tFelj+OpTQ5Ae1ZlqVRUfAYqHo/toYzSjePxevqO
	nNYKsCOjjPpkQEFZLHvX570d5dDnFF0Mte89VkFXoMh0yAbn+26UCC2hyaw1KBeYMcyN/Yg3rC4
	XueAGYri0rpSMs3HgCVabJdam+N2c9hkz4UcNay6H2OyllisEioaJ0EAieY4eHjscilyHG2FRDN
	Ur8z+AsGVTYgRGt7Kc8O9AnDtIMh2isSnP8lJxB3SNt6mA/JC/vNxDcyFE3ET+xP2TOS9sKrlFH
	F8XD7nQ+7ShiQn3IOP97KtaaN5jXwBeYEWzD5Jh339s6wPAOpeUXFbsXAYUaRn2t1Tj4fDmPx96
	pkJQSiVjuoNQk29aZvrmw=
X-Google-Smtp-Source: AGHT+IGpX5yjg/qkO+2av62Yooyq3wDMAKniS1oGU4fAngXkJObrfpK+Sb1QtvUDkHNKdfEpNV5PAA==
X-Received: by 2002:a05:622a:1488:b0:4df:c240:d596 with SMTP id d75a77b69052e-4e6ead6a348mr367541101cf.73.1760514330958;
        Wed, 15 Oct 2025 00:45:30 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c76bfesm13669971cf.10.2025.10.15.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:45:30 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH] dm: sysfs: use sysfs_emit() in dm-sysfs.c
Date: Wed, 15 Oct 2025 07:45:02 +0000
Message-Id: <20251015074502.3363528-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf()+strlen() with sysfs_emit(), the preferred helper for
sysfs show() routines. sysfs_emit() returns the number of bytes written,
guarantees NUL-termination, and clamps to PAGE_SIZE-1.

Reference: Documentation/filesystems/sysfs.rst.

No functional change intended.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/md/dm-sysfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index bfaef27ca79f..22bc70923a83 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -86,17 +86,13 @@ static ssize_t dm_attr_uuid_show(struct mapped_device *md, char *buf)
 
 static ssize_t dm_attr_suspended_show(struct mapped_device *md, char *buf)
 {
-	sprintf(buf, "%d\n", dm_suspended_md(md));
-
-	return strlen(buf);
+	return sysfs_emit(buf, "%d\n", dm_suspended_md(md));
 }
 
 static ssize_t dm_attr_use_blk_mq_show(struct mapped_device *md, char *buf)
 {
 	/* Purely for userspace compatibility */
-	sprintf(buf, "%d\n", true);
-
-	return strlen(buf);
+	return sysfs_emit(buf, "%d\n", true);
 }
 
 static DM_ATTR_RO(name);
-- 
2.34.1


