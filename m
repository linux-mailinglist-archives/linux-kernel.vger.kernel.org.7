Return-Path: <linux-kernel+bounces-890361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C6C3FE77
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B713BD512
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC625223DD1;
	Fri,  7 Nov 2025 12:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D91CAA4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518905; cv=none; b=aMbuxM8vMRYvzXIcRCBjIc8a6UXx8DIzuu17IkbpcpUcHTKYRzFqDKSqrK5TaqW9RU4IJKIXkaggwnlCrpUeQXxT+xP6m8mSdqac5TETt0CrJd5gcPxjcOK1Pnf2UPauLh9A0D8+4uK6MEZI2y0CFWxdzj1DHvtlYxBIlxhqTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518905; c=relaxed/simple;
	bh=K+VyL2v6Xb/cjJfZDQcGx99HvhCh8sI8pgEiyV6H/I4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bbHOpq2s1tvzqn4MgoWlb6pJyJYN3rjgX3/uU1vNdy2JIjfHBnPQ9b5YeLBWYIqIrzYLXy8BEsUCAgMe810FH5cZvjXjOvk8+5jTsUFlF8BO/NLBHOxlMx40ZHDlGS0/UGiI30IaV84f1CtGvgv6JYBpWcGTM1N5LF6b4vZF5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43331987addso17910485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762518902; x=1763123702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DDx+cyiJJbix0qNr6hQXptfaBVytR7OdoMyRh65WPI=;
        b=uyQzeJ39y2kMhsYgtO6p/vvwtyWw425f56lH8QvlkrdnjKc6e0Tze74cELlMch3Ms3
         ksFkqkLKzZdoPHY3cW3BhCcmKwAxJE2ghQ1tSoLg2SsM9dXbALq5kTkJoqEACUdGd/WB
         75HsF/1hVR6hiRbomIK5aKHcfkxBrFwdB9p9DF0ejH2xuxP3Wy6XA48jT/lO9gLEcDjk
         ljKm/ICU3JWJ1CnaFt0BY+eiVYoUW9J8JFszJaPd0vCWbWziZphehY12oSoI8AG1rzhq
         gzuxcTWhG0BWHAHcTLuUy6V/mH82Rvm/gAKVjdZxKBB5D0A1Jj9sZRc+1kY4QBYotRPb
         5QoA==
X-Gm-Message-State: AOJu0YyyEN+bdvfltyEc2AIpFpMKCkPNomuUNlL6rTbi1CxJUkBAShDi
	DCyIMzrDZ+mJWAxxofW2b4kIhMUsClvceO0TqI5h7oLvJVagKq3mKgzJqxXpBIuEpoa1dYFvvyE
	WPHZlWkdd/jUWp/SiC+DGsyJhjl4Mf5Qd74yzRip6n9UsH3MqCKYoYxpWf+M=
X-Google-Smtp-Source: AGHT+IHgAJE3Mkk8U3XCEmhD76/hAiNcTbgK6lZ4X/uqXuxa16vyzmAuAyXwdi8MYMzuY0VGW+ATHQvF/afD1/KvIYzSuCDnKDpI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2788:b0:433:2a9b:165c with SMTP id
 e9e14a558f8ab-4335f5a96c4mr41635405ab.27.1762518902327; Fri, 07 Nov 2025
 04:35:02 -0800 (PST)
Date: Fri, 07 Nov 2025 04:35:02 -0800
In-Reply-To: <b646126e-591a-43e9-80cd-03cca126115b@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690de776.a70a0220.22f260.004a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
From: syzbot <syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com
Tested-by: syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com

Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0aa58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0a0feb49c5138cac46
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11015342580000

Note: testing is done by a robot and is best-effort only.

