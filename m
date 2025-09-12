Return-Path: <linux-kernel+bounces-814019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B3B54E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7917D387
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A023043B6;
	Fri, 12 Sep 2025 12:45:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A53043AC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681105; cv=none; b=uq58Rz7W5Mzh/WBIoKHLyzQar6nQNRCs7tajD6KKxlSbNAiCWggYrBKbUG6PzqxopZAV+zLXKsGaz4QueBSV3uhL8zth+LjAn0X5/EZ76c0uPEV3Myaoi4l1h3tr8KpaMRR4zSvjeI3dXmBQUfCc5M0hXLzNf7rzrF3HDZPSWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681105; c=relaxed/simple;
	bh=JimslxkBKmmSEsuh/VcjPWuhBFHjsfcA2xRBvSAvMKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fCdT49pvHm7aiiB7PEa5jNFE7iojgD7Hy1WNCKYoyMlGKqV0nW5XsPSrSBKBiyb1kx4gUCgH4/4pJHCFhhrRixDe5n3Q7nAIm2ySqKPQ9RHn7q76hZNIMvXdlJyV6F9Q+D2mIBHNux9LiymqWSJoj9ecrAPkQzrWZ56kMsjmsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88d4b38d080so178066439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681102; x=1758285902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUrx3XWpP03Ww2BOg/pvDh4VxWrXnW0Uew+pT+21gr0=;
        b=Ovn91a9WWAU28wUPF74uSHUfn75Y74LRbT0XebAKb5WWmoVwv6j/ZlEUf/nvvCN35w
         H3dUg6yq3GFZp1o9pBGs0pCJJH4keWoewLxyiV9oMNfNrFDGi1xE7zQZbJjuIomWQXsj
         Rw3Gou5vARbLJZzSigioA8sA7gMQkNKldeqBtgGdDMUK2z4q8SqHVZkEJPk0vykh+/fK
         6cM0VSaa0dpeniQmgvMJgiX9/AD2YjrdN2BzXtCtbOuePVb/l7zkAghJT+13hhUW2Iuw
         95AOiRweZbd7vj9c8Vegsi90u1BGq5UEpNq2QQuz+jXlVnl7YgR6o3SxUgs/kKHIa7Oa
         TfBA==
X-Forwarded-Encrypted: i=1; AJvYcCWIS7IhEPFRyUh/lTfq2Ed8y8z0ksVktQNjFniakNkj/rbwNbrkcPrDHudCjxpwMcHpSRFEb4HhdqGFoO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGJ8YDWAT5eHG0ni18SYy+OkxcZ2QGiAx46G0lAcM6eVphbqyu
	77vpE4E2hW5KfciQvsYTuS49odiApbvjbgO/I4Lmq9cQ9zeEA+h+kVE8xsYI+dfzhR8Uuz1k+g1
	joNUtqlNRmiX2eisCGP80ug2xGRM86Hn/e7LoLaeaJWuWQP+VobwwYPfu2M4=
X-Google-Smtp-Source: AGHT+IFy74u0vgNe8xFdnewZ+FrsrZg+QqBpRXwV2Tziucsou/XRONDuVT1xfSYwVqDyRvM6o4I+d2inbWz8rF5I8Yab5EH98fxT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2285:b0:41d:1dbf:26ad with SMTP id
 e9e14a558f8ab-4209d40fe87mr40390105ab.1.1757681102581; Fri, 12 Sep 2025
 05:45:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 05:45:02 -0700
In-Reply-To: <20250912093042.6843-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c415ce.050a0220.2ff435.035b.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: corrupted list in flow_block_cb_setup_simple
From: syzbot <syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com
Tested-by: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com

Tested on:

commit:         320475fb Merge tag 'mtd/fixes-for-6.17-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1236eb12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a66db916cdde0dbcc1c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148cb362580000

Note: testing is done by a robot and is best-effort only.

