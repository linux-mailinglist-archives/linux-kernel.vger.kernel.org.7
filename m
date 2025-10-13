Return-Path: <linux-kernel+bounces-850586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D799EBD33AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFF234E84F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836803081B8;
	Mon, 13 Oct 2025 13:38:45 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3522157B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362725; cv=none; b=Y1qvwxx9miQz6p2HB6ABvkI8Yx+qd80Tfqp9GW5LEh4+xXnuoszNmRjJWI278IhvI4D3SegmZ1Ex2uJJ66oBBSflPqYreT85Muj9gKOJ0R2/XQiZOyAsernwYcaZ3Q1LbKyIU7I6T3tYtzniJO9RHaFhKtY+yvWHqvkAV9X0XNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362725; c=relaxed/simple;
	bh=S7Fb70TXIzs0qbb6ZlFOCVLDZaTOtNsKc2GuptJObZU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oLXznJYMNjXVspHD8J94uLIYBpJsHBZY5/TlZJ2qK8tDLjKHDwmNWOqbqOWl/PEH40IQwCJ3RdNpaqBdwFRt3tBceNiF4KPSvXHpmytQgvzqroISpviFqBhTzsVlgnTSUivxdsTgLJpC6+P4TQlHF14hgLMlfJWUK5ff5hCquu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so126234415ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362722; x=1760967522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/8RILITPsJoqLYBX0ZgpgBXyuLemkd8a6AOQEUgU28=;
        b=F8JmLtGoUIbaqDiw2TAxVn6M3S/lzpMINOwoj9z/gj/U9nEOWYwglE7XdYkWrewN4i
         l52e3jlhfGc1+4kFM2QMC4BRm37BdN4ti6IMpE9PbsO1nDVny4hEkcO7VC2d653j8Igc
         EZfqq1jMSvIrzqgH67ZpjiCQI5x84gaVbqQ3+ijb5qnvaQetIB3w6U8jwaiIyXg6eVKO
         0aXENgsY6+T1WMr1O+z4B6EAn8+zHN9rJkw3zfnR6dqkrv2oxOdB01kzDtyXPXEfr8tW
         +lHlPiImgugD0GBnhj5pXBrd0r65eL8HwjdP595TNmyl+pRy7pk+xLKIhEmetVmVKIpw
         p2Tg==
X-Gm-Message-State: AOJu0Yxsy6U7LqjufIWtwMaR9XbmIXfAjbnAgfHGtIm6QxJhl/urh7xD
	E5eFf3T8lCRc3hx5JxhLehl1xfp2sZ7gXoXPmO6Wfg0qtazHCwCd4lyHkBRjYk/HYXIGOWh7R5R
	DFPaUpzY6iSptqQhyystJ+qEGPmvMmr7xnwvzzv3Qwl85H+RiVHDgUwiI2nw=
X-Google-Smtp-Source: AGHT+IEG4OflKyrhsMXX9iOPCS05EBck1d+SbMY2Yf1ymHeCcyU9VTkPkSXFiFbHEgEWuAjAdp7Ez96ETGZNUO3XoWA44kwZvg7w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178d:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-42f873fd943mr179421355ab.22.1760362722711; Mon, 13 Oct 2025
 06:38:42 -0700 (PDT)
Date: Mon, 13 Oct 2025 06:38:42 -0700
In-Reply-To: <685ada22.a00a0220.2e5631.0089.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed00e2.050a0220.ac43.001a.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: jkoolstra@xs4all.nl

#syz test

---
fs/minix/namei.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..86779a6ec1a7 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -224,7 +224,7 @@ static int minix_rename(struct mnt_idmap *idmap,
err = minix_add_link(new_dentry, old_inode);
if (err)
goto out_dir;
- if (dir_de)
+ if (dir_de && old_dir != new_dir)
inode_inc_link_count(new_dir);
}
@@ -236,7 +236,7 @@ static int minix_rename(struct mnt_idmap *idmap,
if (dir_de) {
err = minix_set_link(dir_de, dir_folio, new_dir);
- if (!err)
+ if (!err && (new_inode || old_dir != new_dir))
inode_dec_link_count(old_dir);
}
out_dir:
-- 
2.51.0

