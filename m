Return-Path: <linux-kernel+bounces-744508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69712B10DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D23177828
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6D274B27;
	Thu, 24 Jul 2025 14:37:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D61991DD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367824; cv=none; b=ch/ObUkB+a8VWjGtPqfkcEQmC1K3BkCr81vnMWbQinAZ/Fzf/WcghsZx+3G4vZ4IZOR0/c09HskPNgiyzZk/HITtssa2R9qNhn0vDHTwycaV0Ml+B1XLEWR2gcoy9QznELamp0ILG+IFUtnhc1uxJq5fpa5NU9y8wlpZIXktkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367824; c=relaxed/simple;
	bh=lrZGovMfzr3uWw6ywdu3gQ7QC2dY2ZiLkUdsg73gBYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YDMGbs0g8X02VuvM9M6hpOV0WB3lkyZw0NPEz67SaODgrM4UfofhijU5xOep94tBIPlsRDAJBC3iR6xvutB68L8nXw28fRTEw61/pbkZz2VcTOGIoIXkzil1CB64pad0KheFEJIR0K43ymiVmJe7r7b3/t3I0oIMo8NY0FQPIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e26ad54369so24747895ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367822; x=1753972622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnsYI8YKyGb65+gy6ObeUjKR0Rc4w8XZ4XYDxw2JU78=;
        b=CktiGHltEWexL537nuKUQmqcXLC2JxyzZxXEsOO6S0lUMGanqN/+zULG4epV32/kfJ
         MkCobG+R7PO1t7admyH2oY/jQeZ4e1nwq90ZaeBZCijGauIeFkGeVrbgp0zf/DlZPcoZ
         6J6fedvnViiTkH7CuHTcugb5nbrEE7fCQ3nbRTvuDj1DOF2vfWziy9X+gmrKh9spQPiw
         zfjirpyHJp6ZbBatIKLeamDc45Azq+0kjUyBfkdUq/vHIYmG6AjRyprI1Fwjj4hw+BVC
         yZ1p0zHyKZPmuI4esqbj/aLc9aGIf3vl8pQNQQZrxQzIlZR+KWFKfjR613g3gWhBbTyo
         neMw==
X-Forwarded-Encrypted: i=1; AJvYcCWtea/uj9wPqgLhffUqQ5K912P/Soa/nXT5nWAFvZs71K1ZFBQgbPLweYRiP1fvONAM1hS7ownnRVS1gaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJvg9rx+761b026qUsJ/4yQwh/RzsInpiqfib8Z+h5Y1ZfwtkA
	hNpgwaPjzd48JZlR2g8E+Ur5bFZpYudUvzbf4edz93LuIifC4wsPslMG3bLbRpaFDXXAzsfUgXI
	f/1/+FcdoFQutD0jDtj3IPXOMzUZmwushoNVM1ebQPY3gZ0Jrt2scyvrWSZQ=
X-Google-Smtp-Source: AGHT+IERoU1yT7l8iHA7Ue4j2KCrPAHlncDFmBiCxEjvwU8YdVsV4w5ZKsyuZX04fkC70WLhUX8b5zz2uwits1ygwE6y0PLFxSFZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3497:b0:3e3:b4ff:15e3 with SMTP id
 e9e14a558f8ab-3e3b97cf3bbmr31859135ab.4.1753367822441; Thu, 24 Jul 2025
 07:37:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 07:37:02 -0700
In-Reply-To: <681853be.a70a0220.254cdc.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6882450e.a00a0220.2f88df.002a.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in osif_xfer/usb_submit_urb
From: syzbot <syzbot+4687ab80180e5d724f51@syzkaller.appspotmail.com>
To: andi.shyti@kernel.org, gregkh@linuxfoundation.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 56ad91c1aa9c18064348edf69308080b03c9dc48
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Thu May 22 06:42:35 2025 +0000

    i2c: robotfuzz-osif: disable zero-length read messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b114f0580000
start commit:   4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=4687ab80180e5d724f51
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103081cc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ba139b980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: i2c: robotfuzz-osif: disable zero-length read messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

