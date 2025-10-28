Return-Path: <linux-kernel+bounces-874554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EE7C1690A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69E134EBB28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2934DB67;
	Tue, 28 Oct 2025 19:06:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B434321A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678365; cv=none; b=WWRaZtYt3OPKKypEun0XnHPJ18iAMJbljXLNOl3C5VVDg2MYxCZjvGBjOoP+VegSxvH0Tm+f1mXgTAWdLS2o8cFbzNQfqOd8joUI2Uq0onvLtPGEcI41AK/I3iOQ03gEw30O4XxRXjImU+xcuZD7bmwh5cL0OkpLJwmX2hAEGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678365; c=relaxed/simple;
	bh=4VTKdi9ZixQORLr0fQzWcWmruVfL7IduLmHfLpyIv9A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jjQsH50bXoMt1CGXtSOwVdHfaECaAQiwk5w3Ml/xBI0NvRW2v13mASR3175c5n9IEiT//lBNydIMELqJ5EWZ4uzhxmsVaAhWuObiDtWvxib6LNDsOVf5Z0ppaY6ok0wjEadwZwAY+T8OJjvKCTWCS5goQ7wxW5KzEy9XXdvfqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945aae1d9f7so305493739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678363; x=1762283163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuSj4naEV+Ce/A5q2G1XTFN3jr1EccBmB6hUKfTe2MU=;
        b=wJ3ktdmj3KgBLxSuSZ/DmI27urG2z1yo+LDnVfzkUd1jDV/C+HzlLZ6kJecCtEyFpa
         +L4Rymj0oDlWZXplhm5SJSmHoh0BP2PetBUlSe73/ykL/ukhm/zqNPnJAMFnifxhXN6E
         MQ05OQQCv7kmUyd9n6+eq7xaIQwSMhQ/PkFIHs91/pSccWXcT0sxSjqtFX1q4oCCmUeg
         Owx3SJjz8bVsz3et8Ssqvs34ZS0HzzMmH2NwhD2bYtbBFd1RL+VPBSrZGMX1ROVsXtLM
         w+dmpV9MMhxhGvsfJa7Ahmw9YQAsECZ3vryizg0Oqiq4XarOj6lYgqa+MjVxULVF4WJ3
         uRuw==
X-Forwarded-Encrypted: i=1; AJvYcCX2YVq/d/ccH9rg4eddBwH6bAHowGa9QxknyBqOrEGrDiLJOf6Sh5aDTV3uR1vKtD7k0h1dZqJ9vg7Ou5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQeh1t2GaZLsGSfICPXKa8VFMbLOGCUDnsoJ7WYiAumUcI8yN7
	dnBM6jSmB9PhZI+T72mb5hIFLnMl2t8Dp/uMy1i13HHbcI32Kl2zSSxMyNsssj3f1Nw97vTxAlp
	Vn2fULf29F8iH2C6RBlyIdqUx8OHshmGRdIjF5+28t/xt+1PPe0g/3DHEZFA=
X-Google-Smtp-Source: AGHT+IFpRlN7l7WM2zajN2rREseFw7Y+iUVfaqjFJ4erUfdfjeL7EhwNfloYyagRb0unJZaNrYw8FnPktmynnnT6aCyX6AadkftO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194c:b0:42f:991f:60a9 with SMTP id
 e9e14a558f8ab-432f8f94047mr4202805ab.7.1761678362717; Tue, 28 Oct 2025
 12:06:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:06:02 -0700
In-Reply-To: <20251028182106.pZlhF%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901141a.050a0220.3344a1.03dc.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:472:40:fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
  472 | /*10*/  struct ocfs2_extent_rec lfs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
 |         __u8    ifs/ocfs2/ocfs2_fs.hd_data[] __coun:t487:40: error: expected ';' at end of declaration list
      | :                         ^500:43: error: expected ';' at end of declaration list
  644 | /*10*/  fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135b57e2580000


