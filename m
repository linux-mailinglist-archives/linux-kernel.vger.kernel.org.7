Return-Path: <linux-kernel+bounces-868274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 648D0C04C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06DA4F3927
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD342E7192;
	Fri, 24 Oct 2025 07:37:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52F2E6CDE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291424; cv=none; b=P7uGVfM4oW5bHfhyRO7DWbozBRP5KelQYz66S9VS08FGFB8ybdBJInq9Wzy2lEaAUwtZXTy1rMUBpqedvMko5IY3LJ4Qxln/UGzrJd4BoDtrM1gQdQgzAbIgWEKDjXMtrssTP+oHeD82bExXEyKevdphn/6EqObYSKqA4ejedUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291424; c=relaxed/simple;
	bh=no19rIQBPIct6CYceTuhM/5wVPsa3HZHJY9dJC2fX+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CkQWOymuRCoz4zIByM4c4hR+h4owBN0m2HzrI34F+FenIRHgIQuMcOhIz8koMdt4eIxA3PQ9e9Z2693TkcF2o+vhDJK1PfDBCqYFhnT7eDsg7X5vJvEAFr73sBw3oaCYe4WfOowuTsLBYsisFRoaF4+aWfIE7TsWseu0ze5ofJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431db4650b7so26508465ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291422; x=1761896222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KvVVNbqO+ptsry3AIZYGGvrphIs56OJt1MhsJUJishY=;
        b=ILrqDW1PHYEI0Bl2cQ19WMNIWA2CIQVKJVy8s54iPswTBbbpO7CjqIBhD8Kxy9mhCk
         BVf38mN2/RsL1eLKitZgPY7XDzYplWXNDUNWBC6PYe/83xaNynrgUaEoJGdb4MkciL9K
         qsgxltdlvHVKQSF0nYwYgVAYvjl1lejnUGkGw6MNTNstyyeEYgYiLE6cTclNplyeNDdd
         yhmSb1Q5TUhh2YhpreQN+l8r2CJL7jCkZNbjMiSnJaK3lLMOIqXsX5eMbwPmWLwKlgoh
         8HUsK+LWeO902u64TM2NSn9Ud8MdLMXZ2i8v4fhIF3l+gCOQVhLvjSAiW07XSSZ8EJET
         WkyQ==
X-Gm-Message-State: AOJu0YznTdgKOFZpaLtag5Bsxxt720p2YFfKYUx+G0tJ+G6W3XLEmW1z
	AnIw6FQ+I4d+26D262iLMTEgzOR6wJAhUk1tVchwUxpC29sabbi7rzvROWM9U7X23/Dz/sznYDo
	ZcMn8D8za4/WE2Z8sn3DPK2LJh06XMk7omYujB5WQikbAqLyFFwEEU1eXCH4=
X-Google-Smtp-Source: AGHT+IGjuHqK8U570qWOZ3qqUMlSKNminrDu/0I1x3YYWbDHVsBeZM3YTL72YQRidi3JooV4YYNgpQ44UNn2NJqUBONsfdZHXwdB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:42f:8eeb:49a1 with SMTP id
 e9e14a558f8ab-430c523d6fdmr422864215ab.13.1761291422086; Fri, 24 Oct 2025
 00:37:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:37:02 -0700
In-Reply-To: <CAMz+-CPXOmOGTUXzSKO_fHKsDu_NT5SswMheeA_T3HuBNLf11w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2c9e.a70a0220.3bf6c6.0149.GAE@google.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com

Tested on:

commit:         6fab32bb MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10eeae7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141dc614580000

Note: testing is done by a robot and is best-effort only.

