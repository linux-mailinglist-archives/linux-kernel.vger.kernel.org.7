Return-Path: <linux-kernel+bounces-804856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC2AB480F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB2A1B21B98
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A41B4224;
	Sun,  7 Sep 2025 22:17:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21611187
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757283426; cv=none; b=UJo5XyZt1PhzU/cwiBOEKpN690NN+Qoq56KKXmztChFxyFRog2gQ8OY1gmy2ETYFjHfKE0l0EWiOd6z8RHo37nrM8c1/VJa8Aq/xn6wRgbkxkmDEBwThsVtn0V45eg6ekYHE4mbkliUuqmT9ZExOEg5LrSNTDB1TCe/FfbUkPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757283426; c=relaxed/simple;
	bh=+vl0ey0UXwTyMCp7/xWvj834t2oH7Cw3hLwqVXc2LOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=beGcKXkBxuJ94MZttUddsL1MBmSLI5AMRsrY5KDm0zFVBLFBMpF9wm+swE5o/bz2y61sg4zD1zzqbnpnzrvizioxGStgDGXY6h55Hd2lSNFjHKMDMwDyhyM5L8ykKb2Oy8qVg8x7sAcIzL8Szyt+ucmypUTq6ura8LdJTx0ensY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f9b69e54e9so26763505ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 15:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757283424; x=1757888224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5bSO7v7OsOgKTeauu2QRFglfK1xBJtjNFB+DPL1x4I=;
        b=KdaRx1CGWpta4mXey2/WkEcjvTcvLtKcwl0vlB8o6sXlhA8pmqQafLFYd7WENO6Ru5
         qc2utdZSBOvGRiDoAztYBZ3SSEQAIhOJ+tM6ZKafdcPr9DSkOzZFeDt5CojyGcw6EohM
         dHH+zt2o1fbFiLto99Jo7oK7oiVyNmzSscQwI94RR8THHlEn6+yxmyydlXk2hfOa2bhv
         PBUNDPS7YO861SKIbIAsIDBhEa6zsdyiM7H1hE1gcB36wXAPO36heK84fEQkM4GyPnQV
         vz+6rNz3Yn51AgnSOIuO+VUPg8RM2BrA4ZBr1ZLwXfDlekPi+cKxRZSWe51hh9kQVPq+
         IedA==
X-Gm-Message-State: AOJu0YytlzQ4hwzjzOlotq7Ru36XFwutXVMVxh4XHtZxZ67Z3TX7yOEJ
	zXGuBXNVJX7BDvQh1+3MQsjZmrzOIMFAuiSg2jPcVLuQCgxky3XunOKvGu4/Oi0sfjTwH1wfhUn
	zuRz7XRbeJPGSSLcrf/F05iJ8sFG7Oyh/tXhHuVX9TnI92cesYrBP5IeVG48=
X-Google-Smtp-Source: AGHT+IGpDyj3/+43TuNJW2FUanLHyjwA7UebmDazj54MzIAI5D60MvKERl8VUEn5Jk6GQfzx03u7tQKHBok5zMQ6aBiQb6eyAAnS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3f6:62c1:ea3 with SMTP id
 e9e14a558f8ab-3fd8925c54dmr109563515ab.29.1757283423824; Sun, 07 Sep 2025
 15:17:03 -0700 (PDT)
Date: Sun, 07 Sep 2025 15:17:03 -0700
In-Reply-To: <xb52gcH-aBgoaHrTJt9dVTtSOGhkj74ebC4qW0sGRe-uXFngQIjdHw2m34EjuC0uKR61elqaGsv5kGK6_XDffXSvueHkPVTFcRVLxNUeasM=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68be045f.050a0220.192772.02ca.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in nsim_fib_event_nb
From: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, maksimilijan.marosevic@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
Tested-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com

Tested on:

commit:         2871306d ipv6: Check AF_UNSPEC in ip6_route_multipath_..
git tree:       https://github.com/mm51593/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=11627962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526c01017a6b11e8
dashboard link: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

