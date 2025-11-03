Return-Path: <linux-kernel+bounces-883088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F67C2C73F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35584F3039
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C8281503;
	Mon,  3 Nov 2025 14:44:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3E2836B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181045; cv=none; b=ueJ317VfLUQknQmqpjdxdf00cf249CKDHb2ipD1Yma6M8Z/j74caRV+5SHo3Q2oZysGplLbvd0RGW2FSCPdITanufZAhYwFyuKuvGqEZ58ph+INUzztlumHzodi1UT5bs4S9gNF6BpYGMqxH1cI2q/LN6Uhurw2kDsw8WcL0ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181045; c=relaxed/simple;
	bh=A2AJ3ME4NKcSl5oDLakKks93M8jhmeoR7M6xrS9up94=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MgR/PlhbXROjZ/78aDWh/myOXruTe21f/t4zE/RZhksK62bPL8Tvygd59exxJSru4qn+gKWzhOkFyRA0qudjESKsK3qHRbmu2FSTKGStN/YFPfQkrNTJKWs1X6WDbHFgzBAH6skoBKJV/vog2s2elXtSlrCjPjVeRFtdYKRj59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d84fdb91so132450835ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181043; x=1762785843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSB3iAM0r+21imjZt5spTrlN01bbwBB1Y+hXz0xqLtA=;
        b=rWGOwzsl1yYnPl+X/Tl9U6VY5lZPyeYrLhrR3qOZ23E2jyk3S6Ibba4ThaTROlEFYb
         DHioCMJl0Uj3Uedv2Qxkza2X5kTpF2WX5CVVaVWWtLlUGF6F2trn7cj3OG4w2HjS5Cdf
         dBlifkr4rC5deh7Hi/P8LWrVQtqRdMa6ZMIxCnlFnw4CkygHQJYMsU2llJk5j37gfvO3
         /uQK5NTQyxxh3w16j/qGkn67iZ4bg+DDoE/586Fhen/XyAKTf/k7Wws3uiiQykNvqCpu
         Y4P2t0vBVr8hob1HaAs+kNQTaly2zUaDEA62U3UdjdjAnYnweICbM6dMwFDJ6A80EZbI
         PIuw==
X-Gm-Message-State: AOJu0YyWCIqemZ+emWDnjwtQy4NPpKvzd5QuzveHJqQqGBxoxenKUv8j
	JFPnc+u8MHzPMSUY2KFbVcIn8HLTfi1DaEnUHNLhrTRCSZkiKPn98m2a/mdFvHUrCCObKDu9ZNG
	lndZUOvtqPCTJhbQr+/FXpBREhr1IH28o47jXfieC0YITK4CCYz0bv50Lyqs=
X-Google-Smtp-Source: AGHT+IEc2JYnv57hb6R+hGRIJ8dyo1G4MxVtc1mPwVVZgOEaz4oLe2Un4cZPSyT4F818gi7y3WineFaGnR4OA+HsbWTmtrZER0i8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:433:3035:742c with SMTP id
 e9e14a558f8ab-433303576a1mr51370785ab.31.1762181042739; Mon, 03 Nov 2025
 06:44:02 -0800 (PST)
Date: Mon, 03 Nov 2025 06:44:02 -0800
In-Reply-To: <e7958eb8-05f8-48a7-ae71-bc15af6abcf2@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908bfb2.050a0220.98a6.003d.GAE@google.com>
Subject: Re: [syzbot] [crypto?] possible deadlock in padata_do_serial
From: syzbot <syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com
Tested-by: syzbot+bd936ccd4339cea66e6b@syzkaller.appspotmail.com

Tested on:

commit:         6146a0f1 Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16836342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f009a9a8d50667
dashboard link: https://syzkaller.appspot.com/bug?extid=bd936ccd4339cea66e6b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f3cc2c580000

Note: testing is done by a robot and is best-effort only.

