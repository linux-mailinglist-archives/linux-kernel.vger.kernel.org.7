Return-Path: <linux-kernel+bounces-867063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CAC017CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78C66541DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69170330B3C;
	Thu, 23 Oct 2025 13:36:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B033030D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226568; cv=none; b=hMfkMD2Ruzg+6jwjuXjh15uVUwxI43L9MhNh5TFtq8C87gEbl3CgjYM+5HM8DDstm1xqaaaLA/86ZTfsWAPqx+vpEwnhlE4Omexv5drEYOuDdT1NumxrlJTl563r3BVy9EZnQU85yBMTKFOwm3goQOu8sYUt/m+Mow6YYGgVvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226568; c=relaxed/simple;
	bh=i+ZDwLqCNRUenRv3NOfF7KxC1qMy/N0EOnft+gGHMyU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cYhkdAgu1Ml1Da+imrSD1n8j+I1oineYsptEhgU76NFgoj5VsUHL28oVQiqY18VjLoZWwNAfgbtDTG3zTP3MljaZkRMwlLPaMGQVINj6QnFyXANukHDdpMwTdicqbuRBD3LDC2lOC3j89uwjw9dAodpJsQJ0n7NhtPM4jbKP1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d777219bso10525095ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226565; x=1761831365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t88iK0z3dm7KTu80deyw2AORP9SnbNPhZ/c9YGsugLY=;
        b=G/fY6p4UiMgdaIOyDxdazf7r2r82HHImUNgybuRr//kbJglVxWV2frMhY/yHI/7lhy
         zcgZdi4T0cPCrKuKKy1LdRYVZko3MRwFVFk0rI4DcV/JzwQuK4dDrkIvqCvq9iSgaQas
         7VOaFJ7BIav2p0uKx4qR2dZxw/S/OD4ru4ZBNJjVnNY90+iMqqpBP5e8gil9+6yNHNiy
         CD7tJ3pYTcCo7K5lvz081Jd1KguqnRNieopPDQb1IrOgHbMNsp2NaMjoUHttSf959vrQ
         GfvEkV69JEkyslf9nrfo1n9wIGptyTHgNc3EzkFBSY8CfBmU41w+5BPvT+YEQf1LDOf0
         Vedw==
X-Gm-Message-State: AOJu0Yx8ttOppM5AXmRfJs+OxGPTXm/at6/7DWWxP/GRBDeqDv+IX/qf
	SDM8Y/138IAEx/pwT1ItqN572SHauo+vfHVUNdpQwWnkxgsSOC/nMSG2dPQdkPqIaQaYokEv5E7
	K2w8KA+h2HAPyC0l4fLISBsH9SHZeMdYDj8MDBhaaiiKmMTt2WrTJWdl0fIg=
X-Google-Smtp-Source: AGHT+IEgUU/m/HMkciMgLeZV5BV72dXaPCCc/ybUWAFE9drHG1Q9Uig/0UdOYnpTzO7Rhz3XNqt2Ahoc1ilSET3vJ2aX9MXBLdOr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:430:ae99:e501 with SMTP id
 e9e14a558f8ab-430c527db5fmr319218875ab.16.1761226565556; Thu, 23 Oct 2025
 06:36:05 -0700 (PDT)
Date: Thu, 23 Oct 2025 06:36:05 -0700
In-Reply-To: <675e5ede.050a0220.37aaf.00ed.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa2f45.a00a0220.9662e.0005.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
Author: dmantipov@yandex.ru

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fcc89856ab95..5fad0a56cc98 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1503,6 +1503,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if ((le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
+	    le32_to_cpu(di->i_clusters)) {
+		rc = ocfs2_error(sb, "Invalid dinode %llu: %u clusters\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le32_to_cpu(di->i_clusters));
+		goto bail;
+	}
+
 	rc = 0;
 
 bail:

