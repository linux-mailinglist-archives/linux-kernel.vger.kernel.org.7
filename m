Return-Path: <linux-kernel+bounces-823298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB995B86123
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652C77C2DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE931197D;
	Thu, 18 Sep 2025 16:41:42 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797B2236E0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213701; cv=none; b=duYbO7+Ybmps/VVr6S0tIOEoeRM5N3vGKTP9DTxWN02tNMtmtvthDjyFE3ImCfwHVeYkPBuyn6qkPQRycyq8t4siRaB7vFw2Hj2JTxY3K+uMCAPdwKV3qbOMoMQ0vjIFLOvf9JQsNvDN/4yzIgNhO2GQmI/i1ZwM7Vl+U4AH+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213701; c=relaxed/simple;
	bh=UVITy6g4REstljntGma2zhA2z3VhpjnCQjdB+AyKrtA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CT7qRO/dK3eiinsDao5A91MDdvo8efPmWzko89TrwB4hlyAtu+17hj+o6rULp62wcBOUqgJtONgaNU4a5gjjtdHxyUIsyhNXtVd6e9TOHR84nO7OOY3w2PM58TeUD1oH6cKwR/XFTedvd+yo/ztti3MHsiS7OLMwYCEGSuzqlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-887ee7475faso226956739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758213699; x=1758818499;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze7sX21523LiREpR8r+SbU1g48MeWZgi0P9esnwzCZs=;
        b=wkrkbL+PAqdeUBi/0ov5uRjXK2k9qWcTYb65ut3bbpBdM0DzhtdxxscekKP6IeFfzz
         lP10hEqTyeb3DQi92PHQntgu2USNIEz9vgLDbllfU+3QbEfHDbNcnpvWdN/BQ+PyHKJb
         9vQLbWm1xeXN4WfmVhNuAW4fws8uoyNo9zxhkaqzphPTR8HHlyTp5kPJ/03XE3QB5BGb
         eResFGQ5m/fGuf1CSJdw9Gaa+aTK+nLRv50uwHeS11WxMAi16Gyg73VyQ7ydesv1VDW7
         dA8uhumbAplreCfJgEAViWisFcFJGkp+j6gI88AIk1BCVZxKHuDQwLGxSBy84BGklLhU
         wT2A==
X-Gm-Message-State: AOJu0Yxpsa2i5DcuFtciLsY7OX0rybZWeJZkirx/d2CWkcHnDyPszQOn
	ChmMgkCA4DDYV0HB+MvybDLsbNgQEynvOBqcCuyjmRs1Z+eHjL2cVaHxxji66m89FQNfTV464Cn
	e0I/GM1PEz6ElIXY8RFZFEUVcR2aR68riLTy28nnD1HIjtssiNVIbuY6KHrE=
X-Google-Smtp-Source: AGHT+IFNC0a8fiJhtl0XiGDmNgwibjR0lOAGvKqmpEW9k4V+1z5Cnn1UTDbHBshnnECEHJHxwr/SoIkb1taJN79gHnZOIS6JrMxp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2509:b0:410:f09a:28a6 with SMTP id
 e9e14a558f8ab-42481925dd8mr3778975ab.13.1758213699077; Thu, 18 Sep 2025
 09:41:39 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:41:39 -0700
In-Reply-To: <6894dce2.050a0220.7f033.0049.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc3643.a00a0220.37dadf.0002.GAE@google.com>
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

On Wed, Sep 17, 2025 at 7:25=E2=80=AFPM syzbot
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
> commit:         5aca7966 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14cd8c7c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1b093ccee5a9e=
08c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D740e04c2a93467a=
0f8c8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13dfaf6258=
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
-bugs/68cabdb6.050a0220.3c6139.0fa6.GAE%40google.com.

