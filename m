Return-Path: <linux-kernel+bounces-825648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E15B8C6CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736531747C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E52FB093;
	Sat, 20 Sep 2025 11:37:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5A228CA9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368226; cv=none; b=imo/gc8gA3rKUAa4kuO12pjLC7XfzbAEZY4sWGK1FEIdTzOlzY5hY1VHBXTwAhUAPjlFJp3X8kG504LBWaBABUTyY0WJ5vP758s36n0NkzVaXpMcvuqsyHvSDszqSoQixYkuuW5AIomLCLHi7CXjIYUsJOvmy1C4WSwS59jfYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368226; c=relaxed/simple;
	bh=Pd0NqbfZcCcn0vRHH9IfyM1C/NwOuL+bCJFFU46m7QM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nw2Hiw7gfWFa1q4yerrEgrSY85BsfTushKBE9Jdj7lye1Dh+eZYomBNmLSaXDr0T89g2sjeoLmAIY6qAg01B7mWVjFx8Ma3+SESNeeif+0vnpx7J1W/UXQoL56SD8GQgrwSs8eRrplInd5xYcWuwwX5uazC+w3jDTHIABmjtc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42407cbc8d1so38880785ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758368223; x=1758973023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2SMwj9fK8KtVa+Y2F7A413JKF+r5qt5nP6k1I8ioRs0=;
        b=fnLyNiMQqeBUxZLfE6EAz7T8DZ6cdtOPOnH+JPbRwOoi3S+kxAJxYypXTPyHe2JSe2
         V9e2tAUXt5m3/B/qQajiY/8oPX5WykQMHW1oXhZyEVh8+AzRAhDgRp8ygIhukdjzWk1x
         0AXNcEB+fOnY6IJQHmDaXwTsC7i2+Li9W+f7pwJLzpH87RA3LbPcJYkmVZHqUmF9yw8p
         yz/W623KvGTJvuD73TjUOEm8NRdpBk5D1dZWzr9EYRbg09qPW40ky0eyGqe0+9IB8FS/
         +nl8x9G+YbjbkkDMSnw+yY60BC+P9WPlsxCk1QA4Ls9kpCm5Ns+BdwffV36kG50ccmzv
         Av4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX806fo4jlKhENFq/yTdpCMUok4Ou7ni+U/2LHrO1V+BbEjxDXusmA/DZls/0o1W5JoF4DdOkaLH88NxhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJZvRAnxSl9mEiW6X0zQiCZ3Bh/cCWa2DwhOgfXtuTec8wjCh
	85TIcip3CCEYgINL0nd8LkuwT6o9ZpCd1z5ulZVLM1FGOVahu5h0NLl+q+fBKeRlBiQ+Oe+U4fJ
	iBBviUfL1543+HrXOZpxBM3kN9XOjDwZbqyQFbNBA0m0fMzUT9exQO8ZrWTs=
X-Google-Smtp-Source: AGHT+IHIv5t+0TgtKw/7XV8de/yPfzdajtmam580He33q3tYdzmUrMCX3yeVyFB7Tq3EYZLc82akNwmtEppjbJJAfotuGzVQTqyH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:423:84d0:7f7e with SMTP id
 e9e14a558f8ab-42481902721mr102080965ab.6.1758368223445; Sat, 20 Sep 2025
 04:37:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 04:37:03 -0700
In-Reply-To: <CAL4kbRMa8snwYuwi4zNjx9bNbrRg=MN+xkadQ=89Dc6URRCOog@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce91df.050a0220.13cd81.0017.GAE@google.com>
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
From: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com
Tested-by: syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153a9858580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1132dc7c580000

Note: testing is done by a robot and is best-effort only.

