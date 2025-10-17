Return-Path: <linux-kernel+bounces-858764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B47ABEBCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA960355434
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F833330B03;
	Fri, 17 Oct 2025 21:22:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81030BB9A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736129; cv=none; b=DcfBqS1UGTDhoFEfNV1zhch5Aa1wJDkGQrtnMyZFz4stBXtUyFKJrTFDEpfJOq9Baa6BlAGVzgs0DyJfsEi11z6JvxzoGIjhJ72J78oYvzPcOW45/iKMNGr1yQ460AC5KFim/OAlLfMl6F9doh7DQJzDmlaxpCnUz/HhkeNpMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736129; c=relaxed/simple;
	bh=Fr2RMCR13sERVjH6KRlQHWTWbjcJKbDw0IES+Ab9MKc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWkOm2E4XDAQXYGHDhx/AH1Akg2igBnB2TkxzC156HhiT5BZSs790+Mxv2ZomM5+/Z+ZtOrwwFhIcoDQ/nPQL94z3S1Jw1WJYokYBiPn4khTlUmsp+Z+cM93mGW5sjPu0FRGmuWhttrMRLX/9jaSYJIILB85SMzYI6PV4/LwRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so32709645ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760736125; x=1761340925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5TM6zrH+Z+jqJIMR36//J/TC8Hxq3FMglaYrh3aQ3M=;
        b=gU32RdMyqjDgIwj7dAoP5aHDudbdirU2oMwED0Npux3efOjCFDcET0efjk3+JqKweB
         RljtTRiRhmKs+z1Z/KuQMUMj+h6RiCRtWyJkuFXDx0ylLnUAqbXtJNZdwTFahHFEe3qf
         qpDkYsIHnLdBdEyv8Z5dnP9jagCHAE+g571sPa3hFU1/3t7f5m2hgl0bnhlgoR2N6tSC
         T1NRJTgsnNNkzpLtawrjwfB5QV2V6+3jSxZ1Jv7y1u9V4ZwwuH2fqTJboTQb7exV6KmH
         vqn4wvx4cDvQ1D8mggk82dgNhJJMl/HP5h6gOvIw6GYYGo+HEvSC0imAW4E1EwxYTBwO
         jHtw==
X-Gm-Message-State: AOJu0YzB6CmO1EDZPXi+45Ot4w18WVW30qS6F4TR+8IiT+0OSEVF7qbE
	fknhKRFL327UiCX+kcvWtYhrObR1pKApJRscwyNnXRqsXb1jpWMIwULRcG86CufRNXxfDG9lffQ
	vFlJCkxeU6rgN5mUp6X1jtg6tUhwI8YlQYu7jx4Ji7KULm4mmxCe6MwVsK50=
X-Google-Smtp-Source: AGHT+IG7IvsnDs+XbRkJCfPxhKkJqBXBxGl1KWXABhYsswuwvprpxWhBCgWaEqrL0luONXqh0fu873Na+la+O+n08BzSsvouUyRL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:42d:84ec:b5da with SMTP id
 e9e14a558f8ab-430c5226e7fmr92589235ab.10.1760736125559; Fri, 17 Oct 2025
 14:22:05 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:22:05 -0700
In-Reply-To: <20251017205546.262475-1-nooraineqbal@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2b37d.050a0220.1186a4.051a.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: vmalloc-out-of-bounds Read in run_irq_workd
From: syzbot <syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nooraineqbal@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com
Tested-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com

Tested on:

commit:         6f3b6e91 Merge tag 'io_uring-6.18-20251016' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1217cb04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e5ede2580000

Note: testing is done by a robot and is best-effort only.

