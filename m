Return-Path: <linux-kernel+bounces-880050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE3C24C16
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764DC46509B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C4338599;
	Fri, 31 Oct 2025 11:18:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132092EDD6C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909485; cv=none; b=Rj8qwlw/rKoVqFhBh9o+uf5qFyhdspNMYuDabF5GH2bQP70MCKSm4CQr7KMOCYgo2SwE6eNvP6MNqEbtiKziVGPBhCYF/vsIeDKcczeMq4bvUvSHSWvEiPAo05vEoUfpbcoCvIXzboiDgFmdPRORrt8eUEHD5Q5WKvBGX6B5BzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909485; c=relaxed/simple;
	bh=9x/5m3b8a3Cg9xHnHNbqOVOFPxIzL3OFzeZjhu0dMCg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l+x8M+CvrIHxlZGSCZwz1UELD7btDkcpKcWlF9iMRXq64/CWAJFE5I8N1VqKY/Qy10KGUFeoIEwZFKU2+aWx4CBYRoeGmL1jmMrwSVlj86357H7sJmcVWVEbH+qL2zVGb/Di5r0cxEFuajj2bjz/R8up+cwW2yGWLvfB7w7wwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43300d247e4so21947465ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909483; x=1762514283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsTkKGwDP3exbQisOs/NPYCE96CT7vJtvnlSg8FI8P8=;
        b=MDCtA4/qW6Y2UzjUmMi8AglXRphrxw2iL/g9QsNsMJf4k0f+x75WQEuGhntF+55nBV
         7RWD4sYjFqmbTAoRLtodJLJwBaeSk+QbSHwBDBSuWY4aaneNbt0eOymdAJ6tjllP6I/Q
         GYlBMq1Jci2YmlW5aHif4/5Yn3lg5MIXQRaawdrXfpX6oIAXqLHa0DlNqEqvFGhYDCeR
         4AJmScpkoUAWFJ8QHX94CXAlRv5QEeg4dK5Zbx9yUks/JFdDrjCZ+fYQGyRg3Cr+KRi1
         fQQHDXYz2x+U0U4/Rs8ZHtu/WEfFYiMEKkCQ6YyJX/F2UcoqmSlqFh4R04Vu6yQvGVJZ
         scCg==
X-Gm-Message-State: AOJu0YywiEartj6OaYwsWba3TftIw4UGRh9NhFafQdaxqMlpRxAiqzYK
	rXQrnGEXynvyXCtqdnc8VjFoaSXHEzkXoEuFt2BVgal1Yu9590li+YRbFl0lKbLeTPdQ0T6SaX/
	AIvR14JtRUknmlQLRLINhlGRm8zdnq08UllJLQ4l4AhM0VhpWKsXR1w7gva4=
X-Google-Smtp-Source: AGHT+IH/W948k/p1gomhZRoZ9whacziP1BLMaMSfgjQsvc90/gB9kaj/oETINBhTSvA9ku9xitaNGSUlkzOEn0DjClUSawqMLrjG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-4330d143885mr50101855ab.7.1761909483089; Fri, 31 Oct 2025
 04:18:03 -0700 (PDT)
Date: Fri, 31 Oct 2025 04:18:03 -0700
In-Reply-To: <CAMz+-COzOAULnhRPuM=LeXzzG0n5VdbzfDhamiHak9FJaSWxfA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69049aeb.050a0220.e9cb8.000b.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com

Tested on:

commit:         d1271768 Merge tag 'linux_kselftest-fixes-6.18-rc4' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15275258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac9909540ee4e359
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1276df34580000

Note: testing is done by a robot and is best-effort only.

