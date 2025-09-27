Return-Path: <linux-kernel+bounces-835082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E4BA635D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A87517D803
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7E23AE62;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751C2343C0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=JMyMqov/u8rQR/WxUU2jpNLcc83nIs3bnkBM/IjsTz4czuIXye6cVcAtmzCO/Jqvk54lwTNIGRylp/Bg4eV0QSJ0GZq05nL4LW+Jjz3Y72UvhhjbJXJvgsHzzKoOZ3j129Nc5GHT6h+FIpUCXtyMy25I7XLC22cRjCz9+Esh2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=qqBNq/oUNzv1hAru+OxUOa6rS5cuxigsQJFLGKWRZdo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MfDJVuAabIHmRQzrXS7cUrgcs/fJbOHB7cpa57d4un9ZhzYB6qOHuiIC7DX8g0ZbWXcm19pXwk8/KA35duwxoSuSnfofyCGKjh/34ru9cx9FayvheTqtQy2G+ZtQrqNFcq3P6SvYdx2bUW2krG0aJnNRKBSUf1ib0bud0jwtosY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-919d48f1869so188108339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgBEakLBjEpirRPbTwgwa5y0PQU9iFXK7podnyDdGFo=;
        b=J97mpbbPrW7KhXkfa9oIEqw5xEoo/ZimcSqRSsWkElYbS+c96X3zz3qh1lrhbnPIv1
         zmoja9du+MhUc1Bx7BMriZvZvzPWo2NBJRIjY+rB2mC3X24bYXWrrDZjp6YClkOSFnXD
         SXx7YfKNNeZIxJWSYT28uc6S1+lx1PzDJZclynytcDBQ9dPUNMxPWO2J6Lu9F4XxCes0
         LGSPmiQr+2AMOZq4W579jNkGAQilRQMGr+fXW9G939uk/VCmCD8hjTADD/JOYX6zP/yS
         VjKBPxyHFl0ShPpDCj2gK/3fkpAPpFF7YDL7JvLNiaW6Wvgr5Bh0zU3gvAvtaY41v+k5
         7dZg==
X-Forwarded-Encrypted: i=1; AJvYcCXdSHivHG5Uh/cCujRWVPA65JiAPWDrhM3PZcNPG50LqQAbk22W5vQN9cgzZrijAKXel87ksvoaRQTmDF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxEiwY/4mVYNaMssxBuNq8GUvFeaYzCECRB1TCncCRewVZ0t4Z
	e6UggVJup81nVdyQ5I10M8S1i5EJ/LX1qMkjLAly07+xSB3tbeS8lMA9qe/LkolVVlUezTSxvk6
	GNiLM0lW29XzB7XBRBCU+KQyMvas6JrS4lwwcul+OYMvntR9TnX1/S3LzKOE=
X-Google-Smtp-Source: AGHT+IHcWSgPNFSvO6mQyB/YDZRCjBZCIJ25Cpiocke9IOek7/btuCYSMPD3yyQtTw736wjaRKzMuhgG5Vt+bT39t1euh/0Cp1I2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc8:b0:428:76ec:b2ba with SMTP id
 e9e14a558f8ab-42876ecb4a2mr68817625ab.12.1759005812046; Sat, 27 Sep 2025
 13:43:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c74.a00a0220.102ee.001c.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Sep 2025)
From: syzbot <syzbot+lista4945a96c9c404d48254@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 454     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<2> 46      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47
<3> 2       No    KMSAN: uninit-value in fuse_dentry_revalidate
                  https://syzkaller.appspot.com/bug?extid=743e3f809752d6f7934f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

