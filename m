Return-Path: <linux-kernel+bounces-772372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B5B291E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5216588D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD5238C36;
	Sun, 17 Aug 2025 06:56:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F122BCF5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755413765; cv=none; b=sB5SOfavoUCueZDhzbPVMRPg4lVzkX+OeuxLkm+CXxe15cWu9kHwG77KtKSHvzxhH9ttLYw8rs8dSCt8DYcb6grDFbx/RYsPE+dK85yzCThgu0Z0HrrrN3A3M7tu+5zpSIEVA9C9DACtSEYKtfHLV6FPu1ev4al/4To/BOtd/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755413765; c=relaxed/simple;
	bh=kwphQH4Pqy8XPVmpwYwUAYtNH0p3lgwZvsDb3nEzP+A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xvv12hgC1a82X/QANRnx6KPK1DIuYmifJ2yCNtDJnpLc8egNYbPkdLjdEYtHV/1VUFxDpOUcFeTpxaNYlnYQieFEbirQ4SI1NBP4CtaJjsarhvUoZsgzhbXvlilPgYV2ZFNqGO0HaCsT0wUzPuodp4OY459s/xjw6FRHfRA2X+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e5aa43so375374239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 23:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755413763; x=1756018563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ/GP9P3XtH8OnUdvGdP39S8CD1AWoWgWbRklZEzQWA=;
        b=q9iAJsJB0PMIAQvfwv/q9T7xNRKHwvASjotKlQmoHPzUD9RXdHrMAKNtaAT+ZqDfpB
         7kCEGlByaVt/X7gUri9w/tl3j6CtKcmqfquZ3Wjkn8KyGnP7UzV9DWSKx9Msya3RNwVx
         o7mqwsetU/dhb1NBePVI7YBWA0CpPpvk1tja1rulFO+1shCkViDcun/V5EWqgvbeSQA3
         X3mfLqW0CywHV220zCV1luhlB98vO7NrrU4f/ekn4wix6OT7+JKnP7uXz5jHxG7fMUXD
         uJGrEr7tg93X3J0OFjfdq7L5mNRtYKg/wTJuJ1SBVHRwvZhTwefJBSo63ZRP8J11dcRK
         zbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVewPXYd9uE/CRf3P8QeNv74gT8eIOICNnZOlnfOxIkNYDuNA82bCQg25efa8ubwCCBB+6mRnqy5NowCrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4f2GwAckPJYzcZ0hqKgt6Q1eHv7UosUr09VK3sCGMD1BkQH7M
	AAfWUfQqWkJEmLLplmhuLIo7ER0uGPFQIDp5zn8KgkUToMA+j7uoMa4vFnLNmY81b2plavsYg3Z
	gjxwOHVK/9nltB9mxeR8bDWGOpc9Ofm5NzJWvaPYSVSFRiDpyS6masSqzTPI=
X-Google-Smtp-Source: AGHT+IEXxU6dWbEZDMkogO4vuaWfC5wm56/ED57vkOMIS3+L6f+5L3WHsuhVrxnwLh09wrHBAASo33OKVLOkiA50/5f2JWgw7csb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4813:b0:3e6:6730:9f5b with SMTP id
 e9e14a558f8ab-3e667309fc5mr25327435ab.24.1755413762964; Sat, 16 Aug 2025
 23:56:02 -0700 (PDT)
Date: Sat, 16 Aug 2025 23:56:02 -0700
In-Reply-To: <20250817060739.4907-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a17d02.050a0220.e29e5.005e.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com
Tested-by: syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com

Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171173a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6401f805169ac8b0
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108cc442580000

Note: testing is done by a robot and is best-effort only.

