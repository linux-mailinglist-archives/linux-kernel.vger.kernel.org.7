Return-Path: <linux-kernel+bounces-823530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88541B86C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EB07AAC37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE22DA771;
	Thu, 18 Sep 2025 19:47:00 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3B2951A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224820; cv=none; b=IIOuYgcp/wDhHrqxCBgAH2D4qCtdpvFeOmRXVPaIhlWKoD3alkAN9J+PBAxMzXIp0mpF7LG0zzKqi4HCBCXh67Yk1dD2m1pG7POTOcGeI2oj1wGSevgOk6NPoerqypZu4mBQebJwkIyJk7bM8r9HElYc15iSwDhyZvRxM4URS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224820; c=relaxed/simple;
	bh=Zmve0uGZuciolv3j19p7n7UHO6gZ7x9yFsoGWkkq6eY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ak/VB+l0GKf/qL1ZSlxdCfTp+9B8cI8a0fDrRsVOSAin69jkiUQKzG8Hv5gX7fQN+X8ONa7XWqbI+6lHsW/qQnrUB2Ls6jhDmMlQyZiVcalX7WxLsT+//JRcACHiHZgKzQB6PHTot6/73jZPn/pEWpPhSIjwilkFuua/FPEB74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88c34279992so115675039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224818; x=1758829618;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbEwN6/iX/OxXmI8d/rNGwDAozfjHBd3/wXLlEs8T7M=;
        b=DbOUTgnV/4/vlNM5dE6DR2Vst3rEi5NyxwvSex20os9quYHFeedMsA+tzZRrwjo2eF
         xmk7zI3bMHu2i1Cs8GOTAJ44iSU2/VIx5FXmjphWRbGNHSdafY+zreTNJjml2T2meXjY
         uaQ0mP5HE5z/DHvBBrjCb7ZMqI1MGhVGQNJjy+cZLBPnV9FQTLGSGGO0RJDcsifcjdH9
         0o8VnNmCLl+EyQ/Sbc8pMWAkioUzZb2BaKxkoJmerxUWlmhjp3UR+I8E4Ly0twP6ifMF
         apLkMXLqv+5ClC4q6iYanbYLQtqC+VVFc//rVoq8F2KnE1zLDeOkPAXbPtSdsoyiM63I
         3/yQ==
X-Gm-Message-State: AOJu0Yz/G6LmmKHd1JW/ShDJBuH5y/0KtgMvA65sllM5PC3ccF/Q226/
	fpnKTGgoWW4slnCGwGkMNGDcZT/rIYogEwuGYwk9UqAHfFpZ2U2yECEObVWp6SXagKnXBlc/aFZ
	VZ+f2Z+yU/XelY1u2gI+Pqp/l5ys5BpA+sR+PulAUUC6eTcJOGvGW6KCQm+8=
X-Google-Smtp-Source: AGHT+IFPUmkbeqMtCn2sKoZ00zbp231iR42dhKe2NlMurk9ukA/jzgVpNf1hGHKVxoxvjqL5S/MkzZ/8hoUNXtmvuO+0qcTZTBsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8e:b0:418:a784:5e1f with SMTP id
 e9e14a558f8ab-424819961ddmr13081435ab.16.1758224817711; Thu, 18 Sep 2025
 12:46:57 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:46:57 -0700
In-Reply-To: <0000000000008441d006180678ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc61b1.050a0220.28a605.000d.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: 
Author: kriish.sharma2006@gmail.com

#syz test

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..a879e8030568 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -760,7 +760,7 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
        u32 bytes_left, bytes;
        int x;

-       if (!length)
+       if (!length || length > KMALLOC_MAX_SIZE / sizeof(struct
gfs2_bitmap))
                return -EINVAL;

        rgd->rd_bits = kcalloc(length, sizeof(struct gfs2_bitmap),
GFP_NOFS);

