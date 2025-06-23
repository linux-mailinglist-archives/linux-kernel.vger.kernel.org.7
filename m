Return-Path: <linux-kernel+bounces-697644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61E0AE36CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB853A74C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458661519A6;
	Mon, 23 Jun 2025 07:30:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21FA933
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663833; cv=none; b=ls/mncNPbhc7Nfj6QGGGvcH8HIocwcOk/ZsO4jZo5SdJncJ8DGtRNqZuYwAMZs4biEp0BjhRlyvnV/QKi+zn5gR7xLZLmVdOhhyauu4CNCECjL7jnVUUK0iblQXVXv1G43hwPgBzNmQWgiyMUD+p0QIfBoRBTxgYHgCiJUYuHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663833; c=relaxed/simple;
	bh=1S3TdUlDFNNXFxkA43RV5K3Yn7LiyXnR2LNH3zCb0hU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L9aAaefWRktHcJmNQ93dZdCJ72Ij7cTtp6bpttaXO5dmXUw3x4jJ2ZEBFFSZUWaUf9K3gUWcDzFfx+Q6i+xQG4dFdTkS5lKrebJ0Y0ebtZQQ7GyTeEU33uZBwSDTIIByELPj9NAm04/bhbGl0V26HM7IY6uNrtkp+RHRYSxSfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86f4e2434b6so326215339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 00:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663831; x=1751268631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPiShnYvK8o2fFb4EMB55dKiZF/5fIIoM2XGynmDRV4=;
        b=uG+zu2ekJFjYiYoiItmt4kbx2xiCBlYGiakBK8JBMhDEJ5av/7bIjy1dyUwZXq9/tz
         NE5fu8/IWJRDCg/Zxr0OyucXU9T46sYnHyvyiVu2hONP1Ji0LuJL44EAfIlPNa81nyRN
         Fr1s9V6YgrjnUjRoR0JeIGk7gGzRv9tlPUTrf8NC14sYjMWEwScySj1jVzKOaP9E/2y2
         cx2AHoCwlr0GjP4n62OuSxun/mB3WQzIVfQdzNE3OSwISKHQV2ZYaAzlTjr72Gsz5l2p
         eu87+/a76nuH93Br8iqOfT3SH9b+Ykt7XYXeFazOheqdOAG06z9SOvfdwSpNtA1ZKQMc
         CchA==
X-Gm-Message-State: AOJu0Yz4Iv8OtFyUBqp9N8/K6Yo+rVYbUHeMzrEGMZqAoIP40r+l6iOj
	xWh7qamxcncVGKHhTjtWBZbYBSYYOFWpTWMk4I++cDWinWgbSiWqPMce8r6gREeUk3XhjO+AA/7
	/yyMQW1IE9l7GzgVMz1eyLTXPoySyKc9sPz7VJEZsBsMGZMUFKmioXyweaV4=
X-Google-Smtp-Source: AGHT+IEhXJ6BvD/GfUc+eThCtMvsiLdz+/BC3B8GbiwF3+Aq4iA291E3YynbcKhblZSuB7vSTBJYNbNez/v4xmsGrMp3107lZx2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26ca:b0:86d:5b3:3b88 with SMTP id
 ca18e2360f4ac-8762d1b0cedmr1036252039f.1.1750663831570; Mon, 23 Jun 2025
 00:30:31 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:30:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68590297.a00a0220.34b642.0004.GAE@google.com>
Subject: [syzbot] Monthly netfs report (Jun 2025)
From: syzbot <syzbot+list34e1f24b959854f814a7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfs maintainers/developers,

This is a 31-day syzbot report for the netfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 4 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 40      Yes   INFO: task hung in netfs_unbuffered_write_iter
                  https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
<2> 12      Yes   INFO: task hung in anon_pipe_write
                  https://syzkaller.appspot.com/bug?extid=ef2c1c404cbcbcc66453
<3> 10      Yes   INFO: task hung in pipe_write (6)
                  https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

