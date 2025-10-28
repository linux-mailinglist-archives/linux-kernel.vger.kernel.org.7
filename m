Return-Path: <linux-kernel+bounces-874646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BA2C16C75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38451890084
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5067333430;
	Tue, 28 Oct 2025 20:30:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E832D6E62
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683407; cv=none; b=S85UH8MNRbq4Iw7/wVZSpNErmj8UHuT9V4nAMAuIRTY902KCFk3IX1fExedUpfJ32J+g0ECzvaSS134vYyfqgR/V1zNBrZMFb/d/489ah4DLlA3S+H8ForbXq5jUJESWwX6C344uwpEZpT7xA4gTE7RSgxvhI4LNLAa3N6Jf2kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683407; c=relaxed/simple;
	bh=+WANvbq95ILaGYJ79JnL/2BWc+hI3JrPGy1TkZ9k8zc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nRMIfYw3GpfgpAs32aalB8f8cguIiumSgb0XfVUB7YZb5bsYals6ntLojOv6WwBcRXv051CKr1+t+OTOmqIdj9/rqrYqnixJFG7FlreMB8bP6zEDnNFa8fwJnBtEXHQRMNzJY4zpqS+x/Y73OOzcLSu4mS6hvFNgYFaEAmgUk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940d395fd10so1979312939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761683405; x=1762288205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDApLappwfIrWUPV4pHKHjQvxvB5iaZ5VNtpvTKWP9c=;
        b=vOqLyZiYk72mazn90ACw3k4O1DckDtjVQr2UEVzYRkgbgPYVGhEPKgX3pmFKWou6zy
         cny4Y/lO08derbBcXLmI9dOLWL54l/ZpTrCkv+UOeja/M/60UXQq8ZYDVNkXOM3BhuZi
         SNQdklWAiCsj0oZxX569qVm5F618/X8GoTbbaNeIiUEI6r/1JgF5/P2Ap6n2x0ceJ2o+
         elszj2ce5nXmiYfXpPEDboa3Abc8Wj9tMJpjmC8s9htyr9dlyZEWyQRLuTQGTSOgy/Hd
         rGT4y34QAPe0fgeInGxKMbhKDhbAfHT1WXntPegSeVX8XH5xipg1uO1YascHmvhNOtTS
         71HA==
X-Forwarded-Encrypted: i=1; AJvYcCW5N5GqYzexVuUTgm1011Ro5eYLiOEu0LNHkxzSQ61fz+dEXIeQUhXO6POfIX8Izz8uwDmsHsB6eykb0cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOorpesoLXKP9hsgIzcdeM2Ksmgb7aCTnXsWy3j7MfxgUArqr
	NliuHV9pSs2UTxIfpz+wLKTNEZiBdHrnl9TWBoI7L2W6Wnp+ABaqgNKeAVXQ7GvR+hIdFsVM67T
	IenlsElxz+yi9wZzrLYyz3VjEQr6A0lpb+PTBgEiQFqsRzszowMsRTvNGPuk=
X-Google-Smtp-Source: AGHT+IHrOkddEVxjRMYXhrfTA9vRN9J0JTHUrEaO00EqdQkrlzqene6+FMKc/5p7z5uwpeE9VGlCwiI3Mom0MMhxUGZYYZFVAxzl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3810:b0:430:b5b5:812e with SMTP id
 e9e14a558f8ab-432f8fac72dmr8189405ab.9.1761683405102; Tue, 28 Oct 2025
 13:30:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:30:05 -0700
In-Reply-To: <20251028182259.7syx-%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690127cd.050a0220.32483.01da.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1029c32f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ee22a53c27b385
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1589dd42580000

Note: testing is done by a robot and is best-effort only.

