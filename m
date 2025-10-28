Return-Path: <linux-kernel+bounces-873148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BEC13394
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 391C04EA280
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208A23EA93;
	Tue, 28 Oct 2025 07:02:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED8611E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634940; cv=none; b=nnBwuQq7ua1gbOOBhtnrrohPFI8jeuaKERFlQfQUcKWvfsPZqNcLSBcvtMuHJ66YTbaoFFVBjN1/OXcHdZPblMMEhoDoQV0SNKHusgY9Gtivve0axl5VBmlA8DRTnfIhqynIZhW5YOWl4qaVYxWV++J2ti2DcwwlyQ9cSPf8SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634940; c=relaxed/simple;
	bh=o6vfYRL670UTzvEYI0IYtYuh5lvpPmxDhpGNxYD+n70=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rGp+MvRyM10SeY7Y1/7wgQH6qN/KEP03RQ5Oy9/UxdKIxr2d1y6WN7k6+3L1KtT0glyGPFMNAfIQxdYpyn/wj2zJMUsXWWBwnQlMLb/z+TLKF3jwdjighU6Nx0VCxR+62c5hUzlb+y7pSpjwjRnOaU1lL8/Fy1zw176hqH/lXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d4ed5cfcso205689685ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634938; x=1762239738;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjjKvb/C0MS+AEY/AcDfzOoViNt0lKgCZMm+iN7N0lI=;
        b=UDvyB2V0iIRwb+Paxt2Wf0iS3j6nOTg3KUjSY9R/jIVF3R0CesucC9ySIlk6eSi9HN
         jkGLPPxM9JzN2JX2QYdawkF5LZBeRsE/DGpJnhxB9DTiCINOz/Z8GrF5EGvlOd7t2YoJ
         pHEOVk+9bGzlPkG2pV2RVBDsKEwQDq0W05YE7nr9Kq01RkBmGglMq/0e3z+Bnbw584ub
         yXGU192b2tFeN0ULYBGPvLQDT1z8+SGw39UdmQlbnjAL2qEmEXK6NA+w7eAwAm1WIPA5
         wPU5MpEQyfBMt9P/VqQBM5HQWAO3Eq5Nqc73dO5NwnngOkN0JYsjK/BypcX1AlDXR4LH
         H+uQ==
X-Gm-Message-State: AOJu0YxRfyAb9+/9Hu/Kg9fJj6QjgcqlJtqCSTAGIVHbK7FPfLrIyzVA
	TJ757+cwDwlEgI6xUbStHZyW9aWOQvJqHAey39cnyh2N0r3dQfL8QlClI2O2HPZ7LTAYOm8pfVO
	RTuk+77gRwnFiFoa4ikrSTDQnA1K8eZD6K3jJJ05G3Rk3U/3/AkK4Cs18hYw=
X-Google-Smtp-Source: AGHT+IHF/fkg2AhKcwJ+bqPQzWK6av2lKXK6ngYQbQHua1Tfiv8g+K5YBQ9yJhhp24F+BahW+/QWib/k79Ue6Z913bpN/5DBcMka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:42f:9bb5:1c4a with SMTP id
 e9e14a558f8ab-4320f7a9115mr37882225ab.27.1761634938072; Tue, 28 Oct 2025
 00:02:18 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:02:18 -0700
In-Reply-To: <00000000000052138306204134f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69006a7a.050a0220.17b81f.0008.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 fd57572253bc356330dbe5b233c2e1d8426c66fd
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fd57572253bc356330dbe5b233c2e1d8426c66fd
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..1b6bdd9d7755 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1503,6 +1503,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+
+		if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_count));
+			goto bail;
+		}
+		if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list index %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_next_free_rec));
+			goto bail;
+		}
+	}
+
 	rc = 0;
 
 bail:

