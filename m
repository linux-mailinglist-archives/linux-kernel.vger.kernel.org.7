Return-Path: <linux-kernel+bounces-721082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632AAFC47A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862783A38F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E0329AB18;
	Tue,  8 Jul 2025 07:48:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66D3FC2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960885; cv=none; b=PPv7EaqOH8NZUpUsy04j/QscFkpjz5Y8ZilmMAll2fLrrD0qo58U7cDdvEEHHxDnyy0XXgDfkyC1YKK779KwsuFSh4GVRHJbiWLSRsYQcPulxn9TGKVAoiKd9JW6SkOO8ryxGbZXLrIJz5bnfeTsXg0lCI/RTc6+Z2fcQQAYEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960885; c=relaxed/simple;
	bh=HzCRKcFQx6oR5088e0ZIRcDaq9eGE82mOpTpDFPQaZs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QOn5f7GtL9LTY/8jdW6Z+004SsgAMvWNUx59G8LtxtlzgM030lVVaoHmaLE88KIgsXvK3X+DVVvPYyK3kE2Quopt58Vb47QlS8cDnWr5BiV0paTuFy1hBH8AO4W3r61MOqKPhGX+eALx4ORn5+/qBV0n8qYmlTSFhXYdGDkzyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e05997f731so97026475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751960882; x=1752565682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD/7TqyzkagqIEfOA4HXNRdHLXMo2VPME/ykCcyzyjA=;
        b=vNOBiOkEZQKJzeGkimMTbJ8u+lDfbGVpvXtgXyAYfM+zunQDvwUpu0br+cuWEhkHoe
         qK9KBeE1zOhjBbzvHZK7zd6jVyyiD3OytNUNOrPYjBWtMlD9y92t/vamA73mu8smp6w1
         +lBp1nIPsZsC+QCx5aRxYU6izbCsw60wSOnmk8c8gKEP7CMVDX5Q7scE80lwalgy2tzu
         BGBibVXkH6ThR15LI3LUxcVGglfuhiZhfJV+4D7Dll5qoWkNSDND1kjUDNBpMi+fcA6l
         wiD9Y5c0vSIIVuZy+XezPnEvm+2IhiYE3HUMqG6sPxkYxVllXwDj8SBTtGDWmquPAmFy
         IKow==
X-Forwarded-Encrypted: i=1; AJvYcCVFUYF5aFsvwyxvzspW2LmZAyBrOVz1/EVCCq7v0iti2CO3AkDsbWLj1yhRjqhkKBLjtqR6Hxt7E/625IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32lmGbhcySQkkEFqa2Ht7xZwgmquP52DfYjmgBZSi0mf+iB1+
	yhYuAv3T6Kmz7RAsuyx2WQeEsgTLErGEv0JHtf9YaLACvcyxVozvzSBH3PvnY0/v9SowSh6UFni
	mB16ZGa5QWle/Pg9rZJpMFDdebk2g5AJb0RKg5z3L+xIxBFMFZcJYiyi1TQw=
X-Google-Smtp-Source: AGHT+IGH7oN2MebqNqGXD51wCgPBQ679eYQ0vdI4h4gNkEf7kobsOf7nd3Fg63Jxbnyfavce5qjWtX08SEfj0Eh4lCd8jrWbRSXr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3df:347f:ff3e with SMTP id
 e9e14a558f8ab-3e136f1fd9fmr144209375ab.7.1751960882617; Tue, 08 Jul 2025
 00:48:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 00:48:02 -0700
In-Reply-To: <18b04472-4443-43eb-8452-56b9a31df378@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ccd32.a00a0220.338033.0006.GAE@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak-after-free in usb_start_wait_urb
From: syzbot <syzbot+27fe438b6370f95de4a5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+27fe438b6370f95de4a5@syzkaller.appspotmail.com
Tested-by: syzbot+27fe438b6370f95de4a5@syzkaller.appspotmail.com

Tested on:

commit:         d7b8f8e2 Linux 6.16-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13a15582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fe1009b62db3e6e
dashboard link: https://syzkaller.appspot.com/bug?extid=27fe438b6370f95de4a5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1090f28c580000

Note: testing is done by a robot and is best-effort only.

