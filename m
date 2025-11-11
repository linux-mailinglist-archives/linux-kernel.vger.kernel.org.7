Return-Path: <linux-kernel+bounces-894809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C270C4C22E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AC024F2582
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2732BF4B;
	Tue, 11 Nov 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWPfgmYq"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DA29DB6A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846720; cv=none; b=oyG0eWNBOqdQBJ7trvmX8r0LV6IgwY8BoYtaAKpXRTsN4NnEykZYEOGreF5rf8TQcV+SMTh85VVAW+5mnUe3CFfLogMIb8M4KnALeQO62PWReCcpGwLx9ycUPbvKolK4m4MD7HuDvbaMv6/h8N7n8ugklJQI8dFSUX62pecS0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846720; c=relaxed/simple;
	bh=HvfH3RKp5senMnbC4tfcVxY2crG3xn8LwjbA/IOPgyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8gpWLTk8PMu4GJ4mp/5wRlVitR41WkFvoEHEOZPxHhHx6ia7eLla2hMjULrskttURIZJBX8vdCqBuiCGtuVW3rpyMVkEQbTmcPOp81dH8952RRqzAQWtw8JqRyPFb+L1Ep56s5uNjTosHdv598HQ39krJgYAb6L8SOy+BcGIRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWPfgmYq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2964d616df7so50251825ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762846719; x=1763451519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9ndsoTPDxhr1ZIZLS05/CvMhHBG4GAQRgkdZOfuzvA=;
        b=QWPfgmYqYWeChdpjI+TGv3LQcrjkc+X7iKsWK7ooFsxGmCMCS+H2Uavo6Wn7iwyzBh
         Yfiojyn5vbDVBfSby7jaRuD1GdkDeNW9naZFmbeY9gYqvCgmVeMyrE9xVdp/14cUSCiP
         ci6FLcD+8sOjHAcEEhZmMebkbs4BF3jQLFQpOcmLQTbMaq7pxENxNRC/28nGeIWmPS5I
         ytSmLMmb9O/X8A07Pbh39ex1sGFqre40b9EuwmRzKRx7z98ojNf5AVcYf+stltT9HUaC
         diPX1Pdt7c4vR0s4hkMAxfMBIBNu32C/pPGHq6BK/VInZfpG6ItfhNFm08nobB//AXtp
         fLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846719; x=1763451519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9ndsoTPDxhr1ZIZLS05/CvMhHBG4GAQRgkdZOfuzvA=;
        b=kDv9ewWHiQTS4Uc3WMvhN07bAkj7FqB7LhstZ897PO6AUs4pfg5oyMbgPStADD2wi8
         QzTQ5V4hM+Gc8FQLPkHqKFfIXXzHoN08SsrA626uGjJqJmpafL/UtBgOUiJ5oL8bccfD
         1lt3H0FhBUJpxG++zVUZXcy3Sn+3LKy3hftARnbuiP5sGxHslIYzSspCwOs6kO4/aceK
         FVO3QZCeAjqLwTGl7ksaWm10pHc8F3my7Lq0O+q6O3r5J6jMal7alYz8BYCh+4D6Vlha
         kxf5f+Nn+GUcd+OpiF8/fvoFTSyHPaovqLqI4fWvd85lZTJk/UDX5HPi02/GWE0Uwrt3
         2pyg==
X-Forwarded-Encrypted: i=1; AJvYcCXGpCEaXXsPZYdVnXugOdPnqNAXUB9lPZRSuNYZp1jpSRQ+TTjZrRYQ8jHUqbInz2NhpLCivWXsgwZw+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/6gJ6WMkh/G5mBB11EzWQsXEfQXamLXdjd/31KG8yHEjStD3
	Dnnz67X4pF2q0G/++mbF1vLD1EueigDxpLH5L57BOlQ3MZADXFdRqrrYq8vqkA==
X-Gm-Gg: ASbGncsuiH8wvz4W49XCAa8aqUphv8It4deZtKDTgoCYj2gqpfO7QI/hHHrADsFR3rz
	mPVjbtjigXbmNOg1/DrYIna5cU6CxTiTHqp8et25VnbCxucyTZhS55OA2vpCPiF7/evsvYemuIv
	rqPy+hn6oxKEfL0JsIbFZsgk2sQu3l+PyZmc8ZqMC6y+MqsJGPtXgSSaZnK1RsS9k/BjHuXaXja
	/+QaMU/XmKZdqgw4NFtkNc48Ug/kfh+TnVmbYbkhmTE7AVhSAzLWh+dG2CIjEelvvgQwsmnN+rK
	3LHuHInRjytbBwj88i+KlY9pbwrFFE9zzboLiEcK7N5jmdBeUy4vrumXXzqFYEyByJq1w8E6Rz2
	HSzAdbSR7uC7FzasrTE72pLx2FbRK8UcREoFUDpucaKPXcIUVGORjJ9xhLBI2YL5P5NsyOLvKGv
	4Q82N4JY/OmN4E9j9MEQxiMxY=
X-Google-Smtp-Source: AGHT+IHHGeaf2R5g2Vtakbv4+m13R1FK4/U22rAUMop0DbrxDVDpJHVAj4e9itb8L1DMyZ3Jt8m84A==
X-Received: by 2002:a17:903:2311:b0:295:9e4e:4092 with SMTP id d9443c01a7336-297e571bcfdmr147154685ad.56.1762846718641;
        Mon, 10 Nov 2025 23:38:38 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:a4ed:fc5:c0b5:fbfb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94abasm173051835ad.82.2025.11.10.23.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 23:38:38 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: validate xattr entry count in ocfs2_xattr_list_entries
Date: Tue, 11 Nov 2025 13:08:31 +0530
Message-ID: <20251111073831.2027072-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation of xattr entry count before accessing entries to prevent
out-of-bounds array access and use-after-free bugs. A corrupted
filesystem with an invalid xh_count value can cause the loop to access
memory beyond the allocated block, potentially reaching freed memory
pages.

The validation calculates the maximum number of entries that can fit in
the available space and rejects counts that exceed this limit. This
prevents the subsequent loop from accessing invalid memory addresses.

Without this check, the code directly uses xh_count from disk in array
indexing operations like &header->xh_entries[i], which can point outside
the block when xh_count is corrupted, triggering KASAN use-after-free
detection.

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
Tested-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ocfs2/xattr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index d70a20d29e3e..2caf63c6206e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -928,8 +928,23 @@ static int ocfs2_xattr_list_entries(struct inode *inode,
 	size_t result = 0;
 	int i, type, ret;
 	const char *name;
+	u16 count;
+	size_t max_entries;
+	struct super_block *sb = inode->i_sb;
+
+	count = le16_to_cpu(header->xh_count);
+	max_entries = (sb->s_blocksize - sizeof(struct ocfs2_xattr_header)) /
+		       sizeof(struct ocfs2_xattr_entry);
 
-	for (i = 0 ; i < le16_to_cpu(header->xh_count); i++) {
+	if (count > max_entries) {
+		ocfs2_error(sb,
+			    "xattr entry count %u exceeds maximum %zu in inode %llu\n",
+			    count, max_entries,
+			    (unsigned long long)OCFS2_I(inode)->ip_blkno);
+		return -EUCLEAN;
+	}
+
+	for (i = 0; i < count; i++) {
 		struct ocfs2_xattr_entry *entry = &header->xh_entries[i];
 		type = ocfs2_xattr_get_type(entry);
 		name = (const char *)header +
-- 
2.43.0


