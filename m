Return-Path: <linux-kernel+bounces-894220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED87AC497FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8673AFB28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1C2F549C;
	Mon, 10 Nov 2025 22:20:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7723E34C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813208; cv=none; b=rQzTOHAWVwBKSc/0p6+zkSJbBdTt0d5JQTWEBpOM6fAX9Zs6UC3EeuveOKYYx6sg+oZzG4MV9Z5BtNd1g2bScYptulYCnkhbWzOMUp8sNPPWO4wPbpszhwb8VMifvZiWHpZ7InpBsp5HH/I5Qxk+8wr+vik6WLcBh5wuUb4D5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813208; c=relaxed/simple;
	bh=cQKzU0PJtIABz2My3fQO79gb34u35ANpSuTji6th3WE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RXMcYJ0nOjq4wnqHWwxKjIev3tjOEJcnfzJDocjIPbl9LDdpUGFnhnPBUFMri2AXru0B0zSv58swEMFqK6MdO1IxI50FyPnYsrIey9tMXtX23IqZlLD9zfk5uK9l9fne9ie1IxBuzZFzZTK3NYoUnTaAaVNtcw/ULELkL8Z9TmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940d395fd10so478259939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762813204; x=1763418004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkp224n0Ii3j4Snlr9kbym/EZNsAu41PVUF6x190beQ=;
        b=EFPqqecRH5w+BUOV8IQL1vqgZjYA9hFlBzsj3Kxp9KDiCE5nCpkMLtE62Qsh0RENLn
         7FUoqhKJgT1Au2sbFl+FfLVsyIbM/GohWFFLrvlKmG9peOFH5vi6PkCjMj580k3ur4eN
         KfHgu8my+WeXraplYXxjacqrNTME2VRiJsBrDDO5SOVpVbsXu59zyBY3M54dGitwlhj7
         rMFJIskLpUtJnzkxsKYwUZZqU02dEzGMwrHs30PUimPuI8+F6yq0kqNrItQjlDUDjGl8
         jzlP86s/0w+LINB2zE00x2lcEOvDim8keKH4qrYTjP5kw1LsOUnwUBftL8hGTAEW2GGf
         V2og==
X-Forwarded-Encrypted: i=1; AJvYcCW/97LVrSpXtYzuiKezelZ7tOJujTcHpZ6737DP+kSsWY2dnzoX+p9yx4RE9+r2zQ47XDScn8x0THODK9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07x0kmuIuI7j3jV92eIdJE5JKkjrBneAO5B1Zxh0V0g+x4eH7
	n84Zeu9QqCm/x5r6WIt/s8X3JdZ1EgOPjWlSbBTChgmFBRoCD+94amyaG+2zuDmk/dRzSuQ7GdH
	RmM6Ulf/vaItzvfTaHmA1s5KtUnjagAp8LtnlEhEsbHk+R+wwlEcji7oPFBw=
X-Google-Smtp-Source: AGHT+IE/oD0bq4LYqVxlWa5NvMtMUXWAJQznnPJvO8eC4MfXjZN+yobh7FiB3oT6AjG4ONInP7c//RM/B/efn35PaajeWc/GZ/Ig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152c:b0:433:7e2f:83c5 with SMTP id
 e9e14a558f8ab-4337e2f8876mr79723565ab.3.1762813203754; Mon, 10 Nov 2025
 14:20:03 -0800 (PST)
Date: Mon, 10 Nov 2025 14:20:03 -0800
In-Reply-To: <CADfthj1wOFy2SijFsSHPSCLBe7EQ7-b_AYkD39=83zUfYbQiow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69126513.a70a0220.22f260.0110.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Tested-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com

Tested on:

commit:         4ea7c171 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110d30b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122a7084580000

Note: testing is done by a robot and is best-effort only.

