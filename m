Return-Path: <linux-kernel+bounces-874195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E37C15BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982B8188896D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E965133EB02;
	Tue, 28 Oct 2025 16:13:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B4722ACEF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667985; cv=none; b=loTiZ0E1Gco14HclWsiw8wgep9RqRwn6evcwQI1sz3uP4N9JIG+pBIPgXCoIOb4NnbZ207y0kZHvdfZ/abo6gxsPOA9p/TCpVj4dBssUIBYcj6KsY6lxf8ldP0MXRkEcFJgvNzCK64OKV6Bc/X8w9gmI/CDoxnAQkltbth3NKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667985; c=relaxed/simple;
	bh=oqqu4otCmA/T7lX3uu9gs/3AzOyTv6ZdvNeFEZbQmWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gTXWoiJqTnpHomiS6p3PdC+nmnTeR4FC6aHi7UGDFndem4nbZnuOC63zzWV0OWXkjvtYWn+ZTiS91E09x1kKj3TrYM+MBn9OKxHgC0HPriNH5e0tUQU3R5oIF0yElxGNBZYT36vdptnKr32XR7xNQ7ax2aGY/plwxuoL+3OOK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c684035eso373285ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667983; x=1762272783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+YeAFpImXWhUnsds4IeW3pbsh9/gourXJ6JpRK9Yow=;
        b=hInxSidrhtABlx6zIt5n09fyqYEHr8YFNYuc3azbbh4pg/xFfcqoKgaj8DZs4p0fXj
         tIjjudNQ1VwlPq2rnObugVuMdhcBwpRxQKCUluZMuGt0eDvdhPDbmOGJRLFBUz03Hfu7
         NebigGSCZ/dAsnx5IxPl83ObgGb70j5RfZzH0hDUYd+dJYRBOxiNLf2Bg7phFDMKQ6lv
         y23ymuBNRwh7/MQrutngTHgncF6rMqsGq6RuldLU+eKBcC3O6ufYvmsNSuK7K1vTluem
         /Pv3HdqyZYl1Jwquja2eq84iqePBm22SFpWSimdzOp3zf3z593xr3RyuIwr6rv1wASmU
         P6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt55IiR8FulcJVsfWM53K60szARyf5kff9SMG9JoDv3ONVfeXBBbsk5KaJ0yP5cME59LnFEXO3gG8cojs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbb+X4SptD08eJqZIdI7VP8AwLcqpYtPrBmCZS6QA8/uUrTe/
	ywYL1lAmwH8qIQ8s+sQKwqBPnpZpaAQPn9PVTr9AvYPbRkxakuWbV47Ac475XAUMq39nInrq6KO
	qnswSLFVk5qgpdi6KnuzzI/Bb/SLlp3sKX+ETqGppX3/+w0iCsAxcN82INTk=
X-Google-Smtp-Source: AGHT+IGxU7I46NrnQ1G5lMrieHQjuxdBJhP68CwSge40cmqLgTRISH1IFAzjtNRj/5O00dAsMff4oBHBOGwVw8AXQpl1uVq7F1JJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:42f:8bdd:6e9c with SMTP id
 e9e14a558f8ab-43210431525mr47145245ab.14.1761667983152; Tue, 28 Oct 2025
 09:13:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:13:03 -0700
In-Reply-To: <tencent_BC66CF1362C363496C83ADE45C377E776D05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900eb8f.050a0220.32483.01c6.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_count_dnodes
From: syzbot <syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com
Tested-by: syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com

Tested on:

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc67e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=7d1563afac6cb196a444
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122a1f34580000

Note: testing is done by a robot and is best-effort only.

