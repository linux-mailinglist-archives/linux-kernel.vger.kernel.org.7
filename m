Return-Path: <linux-kernel+bounces-829602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1CB976D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E09119C5312
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6E3019B9;
	Tue, 23 Sep 2025 19:59:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6E2FFDCB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657544; cv=none; b=NsB/vYvN9jgt63f7t+KfLrzFeyH5UwSsSAzCnIKieCKGxpSuxFvPe5Vyjs42Zj/+NS7Ew2QPVp2L3nM7YlEOFLGLSY329WbX1T31m0ZQ6aXVuqdPlUkd2v9mkFrnORoZWiMbEPrQT69LprqO4n3ArQDAr43DSfb5LAhT1qsEvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657544; c=relaxed/simple;
	bh=WbRxxvPu2PII9+tVZPTYHIku5xjnJJfqpOzcsOGOcTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GxmZXzqMyplCvNX9vOYBZGxrurFEpJXngxq98Ab7A/pwDN16ln2pBzC1bgUdYc9CkKGoLgykUDXzqyoXmqPIR1R5OCLe0OcMYTmKPMsdb0wMKXSQNvLgoOVfAtBoAr/rZKJgeRBTpXtnwWd8IfHlvamtDaYQlmMyHGkECk+p1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42486f6da6fso62901675ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657542; x=1759262342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcaaZPCV5Qrgwa3vKDEUNa/ct40/p9wKCLJtyWA+kyQ=;
        b=UGyKFFhWa7hlTMHDkCGFgxmsaDasBuoeB2LgczAfxflvSBFgKyzIyQsH5IhDXxGzFl
         j5fWK+ZlgkUpDlKb7dawd3EG7JBYtu7usTVfpx1qqQOItCDezKwN4LTSVQO/EmEELx6v
         u1N30VLjipNRn66juhsAPzRyZ47+iyNF2HaLpDNMS48pMRL9hHbA3xSJs78hGjF51gV6
         YOpv24amI14/ngAexpAoGqHR5rhpvEVEI5S4+MWusJ36Q5+qpAiswfJ4bJkmyB7MStnt
         BaHway/DfT/vTtqcecHxAWjUOAp4A9V5qb+IxWhT9XV9jL24Q2jMy2yfUOd1kfB9azZL
         BtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0JMXgTx8vkMIaUIFghhQV2wufrZrM5HiP1+n3jMaJW9l2nJH01T+NUWT+VVCodmJFYSio6DL6XIWVVGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIYcmwbCYjA0D7HGdEOKptXj6Cis5hl/v7aCknKXbrOI2vhW/
	a1WHB5KR8T+HDJZWp5jwYl3qtlNGWCoC1bznfgeiPI1gXULnzk8cL9zBTaAeq7qpLpkm066DF9p
	pRhOiSZpa19zYtv8X8fase3PRRdwHYbeWLovgl1o6ASXNYHmYOffEvwPwXDY=
X-Google-Smtp-Source: AGHT+IH4ryecd7+jD4K6kYGAIwNEyzeiCtIWaDcMQ3DqckIrtsaX5FHyU9Wx/aV8dwEqItA12eZFVdFCQBiegXhWf5yf0gEyZVTH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160f:b0:423:fcd6:5487 with SMTP id
 e9e14a558f8ab-42581e28b8emr65860075ab.14.1758657542574; Tue, 23 Sep 2025
 12:59:02 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:59:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2fc06.a70a0220.4f78.000d.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, danielyangkang@gmail.com, 
	dhowells@redhat.com, eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, 
	jlayton@kernel.org, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lizhi.xu@windriver.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, netfs@lists.linux.dev, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a3de58b12ce074ec05b8741fa28d62ccb1070468
Author: David Howells <dhowells@redhat.com>
Date:   Thu Aug 14 21:45:50 2025 +0000

    netfs: Fix unbuffered write error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162dc142580000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix unbuffered write error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

