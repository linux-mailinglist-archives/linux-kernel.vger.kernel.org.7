Return-Path: <linux-kernel+bounces-835564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EABA777C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F61175CAE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E3327702A;
	Sun, 28 Sep 2025 20:12:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42D275B12
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759090324; cv=none; b=EM+IC6Qxksi0fQi+trH6wE644NQI/RUJJdsSKXfctLtS0qzAFK/MRFlaLS1Zxf60TZyfHTZf/d2bt7RDQXDcMgpQCGLHd1QJHMfrJThdoXvoZE0WH4KsTZS/8uvxLUwl3qXPHCbT3zbrJ9oK+Kl0lvZpyMET4zYaGW659y13KZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759090324; c=relaxed/simple;
	bh=0RbFeTDokiBIDFXYwXhTqeTngrPJxIKeMT9v6nJhPYk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u+3NE+3aAOAwkT86NO/gq40iU9sLNzCJ2Cp0f8H/hkh/fQ/+pCbx8xskVr+N2QWbLlIoqI289ShIhBEb85Ch4i+d8rA+nJ2SoqcLHk2lA4hSB5aVh8pe5HPYDFHM6KcRBRgbbdc1YJScQTC0+h664zH+Mxl+MlvkpHMMSG0FwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-90efeb58159so335721839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759090322; x=1759695122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaduVv8+j9xG9g2Olc4KfHdOBiR7JfOMthlP5Ksd0K8=;
        b=lRRGMlP0GmbqWHnWCewkHhezYZqFIUIM0jTutn08aChpsRwmxXZ9eBVZaviZFzaaeE
         molU+y6Xmiti8NgixnI4xGjURdSWmKjayXg2x5P3Vp0pOKWM89Bu/wMINmFKriYNrK6u
         ebnA8QuKqpQ7iL41t+AzOpRHflS172X3Vl1dTTGO7EqIHjki9siDJ5svjxBz06Bhhr+B
         IxcwdtrwIfC4HBKMyY7gD3iDMsFQ22fr/luU1zgVNcKlgH3zTJb8IQHcQU+eq5isdN43
         74cvil0UPlhZWWJksLzIYX0YF92GeWUs8u+8Noz/iH4YaY1lVEw2DJRtz410x7flro/W
         2T+A==
X-Forwarded-Encrypted: i=1; AJvYcCWTg9NL2YZkDzmvJnl57Mdv7S6t6bbftWYKQq47QRdCC00N9OKjnFWENw1GJdXeLS9PYdbo26eR37R2lkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa61RmQ1e45v2xshYKXyYk8/wpF1DVZM5iFiB8hdg1xIoy7Dp
	er3ubJXZ65PfNCEj3keZfTAecwZQcsRzsmNNdjbeerIeb2xJ/cZlr4ycu2Qbf9F3uH6t6eEXbGe
	GQqvV2YDSJFDETMJVty03L7u9DgepPO+yJ4rMWxRdphBf9J6CrBX3pim+GEM=
X-Google-Smtp-Source: AGHT+IFe1cPN5hHZibJvP6cJECKOPK7CIGqP3ONZivzTbEMVJkCeWmbblnq11+o6oAttzrZ2589qumHKCObY7OyIrrC974/LLSD2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c83:b0:426:c373:25db with SMTP id
 e9e14a558f8ab-426c3732a86mr162405485ab.4.1759090322279; Sun, 28 Sep 2025
 13:12:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:12:02 -0700
In-Reply-To: <68769347.a70a0220.693ce.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d99692.a70a0220.10c4b.0027.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_setup (4)
From: syzbot <syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, jiri@nvidia.com, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12620ae2580000
start commit:   347e9f5043c8 Linux 6.16-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11620ae2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16620ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138dfd82580000

Reported-by: syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

