Return-Path: <linux-kernel+bounces-858671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7A3BEB623
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80B86E68C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEB30E0F5;
	Fri, 17 Oct 2025 19:25:55 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F924DCE5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729154; cv=none; b=asZMH7KTl+r3fOO0vMIB19ZIkE/B2iY3v8dihBxMm2ufSkhr9lQYeBx8DcZBB0Z9qisEOzaMiixJYDXTxKKm4TFz+jOEvRPmT2G4y+oLWzvaQzSbBwRI8Mx/1tmchbj/xe1XFI8RjCH5CyluM9jqiVOzcY+Na0vfDYZAit12u6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729154; c=relaxed/simple;
	bh=qugajfn4A2HznbswOFuuCDqy1q/iPINFo8m9nIC85S8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pnsoe7PczvDvmFtQ/K3jNt/VBxORProzJjS1+MNfn/KI0y7qxulJXZuVX909pwHZK4+evSKeiCM7o7uaERxUoVvw1pkinDpLfCMiQYjD5UkeRtinwb4BuJ7PYXbqLtzHRwJ2Bv6UxTtiYwVXPEF12ASqsGJzvoXY0s/n39esEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so6438505ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760729152; x=1761333952;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lfj+di4zqED1stdSmPza1BphQzJc4PAY+Tvm9T5UhsU=;
        b=eCU2Pc0qb8Bb++XVutBc/OIR4Ksvlnlq2UlK/uzOh6wmT3NRBVVOP+nklYCj+w+H1Y
         ZUnrEmw4iWwYvuYQJPc0IhrqzknK+ZwVRPtPl91SI0fKEYunGjBtGDGlEQeFIK+BbOmr
         v88dOJuKZ8UbQuJoNc90Tp/DoOSyiBtC3M7t9gBOo0Qkaccg3hG7gvuDaRmzHYxTdQJN
         C7m7hG8ZDqHOh9HGFggnhUTB0l7rWlMxKaQFdediDY0n33NuRCdcoctCC1rVY71j8qLy
         hMo99HH2unmrjzU6J27qTmA6eErxVLpTCEHXTBkWPeWiClfMo9cre+9JkMqY8HwAYVdi
         LKWw==
X-Gm-Message-State: AOJu0YxbtR/rircCNDY6C6uS7msvyBzzdXgOW0HwvKl2Lg1bz2xbsGQP
	aOED9KoZVvYTD+/HdmPECqal1C8AgADezNWZ8bfbYbDHnfIc0e4kjhazXg2mTL8xaxzJIVdMUJ1
	Wv/6hrP07UZPkC2kPVac4k6bWvS3XYFbkevdNgQmYwDTZ714x+tBCxWJ1HaQ=
X-Google-Smtp-Source: AGHT+IHID7O9AfvmmyTz1LMjaeIGlqTqveEb1vHbSgBAJ9EWkc9dWj/Xv5FtImxfmSgUVzomWGkpnpWM5XjzZn2VVPkxETfYqOew
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:430:9fde:33d5 with SMTP id
 e9e14a558f8ab-430c525f0c7mr83648035ab.11.1760729152413; Fri, 17 Oct 2025
 12:25:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:25:52 -0700
In-Reply-To: <68f1c794.a00a0220.361615.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f29840.a70a0220.b3ac9.0032.GAE@google.com>
Subject: Forwarded: UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: UBSAN: shift-out-of-bounds in dbAllocAG (3)
Author: hsukrut3@gmail.com

#syz test
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cdfa699cd7c8..477b332763a8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1372,6 +1372,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	dcp = (struct dmapctl *) mp->data;
 	budmin = dcp->budmin;
 
+	if (unlikely(budmin < 0) {
+		jfs_err("JFS: dmapctl corruption: budmin=%d", budmin);
+		release_metapage(mp);
+		return -EIO;
+	}
+
 	if (dcp->leafidx != cpu_to_le32(CTLLEAFIND)) {
 		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
 		release_metapage(mp);
-- 
2.43.0


