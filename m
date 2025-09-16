Return-Path: <linux-kernel+bounces-818157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFBB58DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B090B3A214B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E988244662;
	Tue, 16 Sep 2025 05:00:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B0242D62
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998806; cv=none; b=b7MCyGuTbeWX7Z1ZFFOOGz8cYuszBZGdycdrQ36YhnleWR/7m2mzVqr60dn9e7X8T4wIbH44G02NzyXYVZO5tNv4SO8ntEkgZm07hC1/pB3ETLXdiQ32ep69JmgDQloMkffeavvAAORiItSNKYOrcA9nLyZYV5Yfim5xTLo020Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998806; c=relaxed/simple;
	bh=LXbs3uxExj1VidQm+oOUXA+hiKdzL1QOLlrHWGOx34s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bI72CDUezfBH7neaA0YS9blf7DB5bSSjsS/CC/sdyxTJBX0T6ypNWuopXW0OYC4mHhvEAR4GS86e+edTiXccd4hOCs3xxO+LtGMPx+XlUI3Z3Gls3/t/LmDaokr+JtDW39w9ZIcm/Tx8T01rlnD4Ttb6X+PjylqmAYls7Jw8jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8875a8663d0so514714439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998802; x=1758603602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXnKagI9/M0wksY+ZB+zaWMdgsaoUSVvZxx78dphtqU=;
        b=ZQCs/y3MzFRpbfcgEFGxUwtivWJL7SUaBMrXhqdPebiWsxHThBK0DYSdpvukCOVjgj
         LwaF0Ztx5hhhYHmA3P2sZAeAherGMZDz6s6kHNe5mhkB8lbTQT0mfmSKWtHvdJWp6nR9
         nGe6o5bfDoclScgQRHIcotXW2N55F46jCKitsGlacB61JnNiHlEL/51WfPXQJvfxUl1F
         aeBZK0EUb82vsPk/jOdZxGHhK1dWwoKxqJwhle6jbhRIduRz4IZlVYYSjYZsbUtha0up
         i4yi1RjLilmdvAWkvGacE9IKZwzj1f3pmotvKBguTfEljk/ULQeonlm6TWu4OUL4Ogmf
         7y6w==
X-Forwarded-Encrypted: i=1; AJvYcCVOmv2fvUHU4oj03CzZr6Q6QLK9YYhc6xZKLGw61pGuwpaz6fl24ssHr4m2RpUi2yGT1XHzWAGi9RaSy+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY3FlxRzWebEYcqjuOn4ijcWLitMxkkCjWU4yO/vZBVg85PpM
	OGIMXU82tYOa1RRlahRku4TFO8vePmgvWarD7OvCk4lwE3fg5PZZMfVC0H5lTUK0F1H4Xj/ysLe
	KgYa6b74hiEYqNDtGh8LJoaeDfklbNtyNpQq4rh2p4KdcOauaPe7KpmhqGw4=
X-Google-Smtp-Source: AGHT+IGrltOQ93qfNIqvlkFcYNB9PZJRK0LDjntwEnMXBCBlEIn8VwfZL7D4WkPeA+LfAUVlXSmxLaRBtcZHGs5qNSrouwTauFoB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:41f:6b74:e238 with SMTP id
 e9e14a558f8ab-4209dad2ff7mr147961155ab.1.1757998802735; Mon, 15 Sep 2025
 22:00:02 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:00:02 -0700
In-Reply-To: <CAC_ur0rGRJhjm6Ps9zSD_O+dqCprXrgybPyPG+Lh+OCSftu8wg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8eed2.050a0220.3c6139.0d2a.GAE@google.com>
Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: deepak.takumi.120@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com
Tested-by: syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com

Tested on:

commit:         46a51f4f Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16af8e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=7617e19c8a59edfbd879
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10350534580000

Note: testing is done by a robot and is best-effort only.

