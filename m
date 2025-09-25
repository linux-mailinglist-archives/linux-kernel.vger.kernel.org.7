Return-Path: <linux-kernel+bounces-832043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC0B9E375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A04C2CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85527BF93;
	Thu, 25 Sep 2025 09:11:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE127B356
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791493; cv=none; b=FJHsyVcclJy6I6mwgCNRqmyTv3rPpslXaWV0O1gj09r0qAM6C2Ukv9Pblh4mdlBfvKsg6of6xoDTaGTHJ+mYTfUrjXfBZ6i/K64pwJ/7Ep3snuGG5sfSc/Masq0VoqGQ5MVxhpD5FBzYWLKscuRDabmDDtddQNwHY0BWqZu6xP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791493; c=relaxed/simple;
	bh=+XGeWHNm3PSQK86D3YHJdWjV/lVZTy6z0F5TOOk01BU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UyKOTwl7qgU+pHFM8UDcyJfaszX9mWqEnx6RJ8KCQ3CaA4g6d44uMn6zzSc5DNtjX/xjFUzi7HJ9TnshQbEIiho2PkBRA2LHAHlyz/yv0keHeEHhoMaQqUWlbZQq/tbDLMd2Vx5Qn8W68cjTzdEtL6Ofa697GqKWdu+xQAu+pT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424c8578d40so8521285ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791491; x=1759396291;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlXY4OneoUeMrJ6AW/ATXFHXzKe7yS3/r/fypSmNTLk=;
        b=bj+Eco4CSfGUPQ1S0IeYe2fkIjBY44ASWeOiZQe2uxti2GAU5T1+W9jw1pjvUGDexA
         fN0My/z6ksQ8WP4lJfMgb9SfAgktfOzpO0YstN/vXNklJ4HM6kOI9u8Eulwn2JCmHYaR
         Rl2C9jurtJfOiagUVW1oYKT2B5C+94RCBwSWWxV7AObxczAES7WGv5aAt+aFZnHrswml
         arj1a3vR88E9sMkJh46OUr/yMGf1LnaLX/hq/bEfuDbynjNMppnyCrz5HyKb0jWEweHW
         zMWk0iEPGoPuSh+m/UWDTv5SWAck0XHX6cRmn9Q8HPCgaXM0GSofalVAhFViiZhVq+BL
         AQPA==
X-Gm-Message-State: AOJu0Yzo+qsZcuNEe8AuCPZRN0pWq0KmgAUBI2pNXTxnOBZtp6kPZdO6
	oJIp0H2McuryXtgtI9wTTsAq0aorlpXQoLhmbrkb+L19iGlZPm6P6G3JF9oa2F1GY5XYDFQyVEd
	GpB8IwIzEoN89wu4MRCMvxuHP47HSRE4c7nK4deiWt99kR0XVb7VgpDzmhk8=
X-Google-Smtp-Source: AGHT+IE/JvbUrnsOh0luzxm2XY+AHWoIMThVLGAlXJ4SWPddw+vgs7/9X4FYkZjSFG17+ujMnAMzvkzTKmnXNDyedAfc7BzwSMdP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:41a:6194:c251 with SMTP id
 e9e14a558f8ab-425955af66cmr37501135ab.3.1758791490878; Thu, 25 Sep 2025
 02:11:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:11:30 -0700
In-Reply-To: <6894dce2.050a0220.7f033.0049.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d50742.050a0220.25d7ab.0007.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in
 nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
Author: deepak.takumi.120@gmail.com

#syz test

On Thu, Sep 18, 2025 at 11:29=E2=80=AFPM syzbot
<syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         86cc796e Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13d9471258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1b093ccee5a9e=
08c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D740e04c2a93467a=
0f8c8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D162bdf6258=
0000
>
> Note: testing is done by a robot and is best-effort only.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/68cc4866.050a0220.28a605.000a.GAE%40google.com.

