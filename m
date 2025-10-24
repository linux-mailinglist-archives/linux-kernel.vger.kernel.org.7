Return-Path: <linux-kernel+bounces-868971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D8C069BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D75FB4FC109
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCC31D727;
	Fri, 24 Oct 2025 14:04:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD331578B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314649; cv=none; b=gE8IQIr69DMZshCymusBQyCcjpyQuY/MZDiqTD0HV48YFoBe6c/8QN7HSktDFW3/s89Q6x+KMuP1+OxHQL507J4IYaYKczvqEgEcrbqtBcX/Oe9UgaEJIL9po3qOnik7n1oVQuPEnAOuHQSptTi7x9/rwh4/qj/nLugTvFr1fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314649; c=relaxed/simple;
	bh=cYBqn3TWrhnCuaYiWCkiUnYtrCjo41TIcAf2Pco04VA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q8EsCU9m9QW45VKMRxRc0oQrb2+7Z0QSltz7kWYnE4eSaeVrua0EpKH8LNZ5VTqV1BQXHPIoMXoSI4IpIENipb3JNdWfxGcq1JhKNggs7WPdmlHdTLXc8knq2nDGnopkvACBZVnSGSYWoV1UHXK8zTixU21003WoAIdlcxJqOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c8321bc1so27786155ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314645; x=1761919445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4TlLKxX3pU5SExCQxzjOWKXxDTKhSiYNdz1jw2LYWg=;
        b=JnG8W9JT4HXqTKiYrdiKkiI+630IrRTHjMz0STRiNez561Xc/qHxnr/McK338xvGfW
         PcGAVt0vbLBuB6ZacXEgs50WWu5tPaSkcuiJARBPBe2rmgO5qHCpPhKWKzLm+o+PmwG5
         nt8RWll7sMxhNAZmv37hombsv8nxgdLXkeoswQfFNEal9bvgsQer5pQNFummZaX5K/ef
         Elu5CO/mdah3niqMZAKp1wmoL5c5+teDLeR1fBbonp3N2UTc2rYbCC5/XIJYrCird9nf
         P2pF9nFOPu4zKXS+V6/FEFpnhr63i7HbgAEhCwJUIIZ3SRKGdbVz7se3N1rcYWVx3ZuT
         xXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgqs6dOfQueWBSakXeMjDZBN6Y2jiNG4EpSZpPK7CqeJjHW1iVv/R88Y8A8LZP8iFX5o5FXexZJhTM5q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UsBCjBvqsHeaLcvxar1v/9kUa6XTh1IqeUkhVMNmXX5DB38y
	F7ZOkhGeJNC5tuWiwS74DmZb254pYjoZsZ9t6koZj2iFFHz9v200b1ue4iYABdpbRTtYDW/uZF4
	2UI+eW8uxoRBzseQprtK/7qIbqA6rtsQnu0IrWzY0hfk6S/DJ9VOgkwTDlY0=
X-Google-Smtp-Source: AGHT+IEZfHlrMIILBZtTSbnVtzFATDDyRwUfuIKWC/mbbmmuT8ZnYGPcT1CH+QdcY5gLt2/CaDs8s6WYrr1/b9U5R2YGCs7rQ+GT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f520mr203731385ab.10.1761314643732; Fri, 24 Oct 2025
 07:04:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:04:03 -0700
In-Reply-To: <20251024071532.gsUD9%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8753.050a0220.346f24.00f5.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10e363cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1729db04580000

Note: testing is done by a robot and is best-effort only.

