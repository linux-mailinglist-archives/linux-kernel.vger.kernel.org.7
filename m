Return-Path: <linux-kernel+bounces-864145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4FBFA07E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8163F1A02FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E782E0902;
	Wed, 22 Oct 2025 05:11:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656C2D47FF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109864; cv=none; b=rRT0+Fcpty4si632E7MBXmQmUICftHGN0N38BSvwi3y4JO4r059MXaZbeKO1mrUdUg1WLsgPO8lg/YIrBNctULSr1flSpDMsgB7xYUFHJpAjFk2wxiBYhIYm2vyyzT3NvgZuy5TrGNjpRLfvEgn8L/qDGuhEAF8JyhGXtb12hqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109864; c=relaxed/simple;
	bh=McIaP1rcTmdAz43EJgcG5qyhWa48o1nyUW0xBvfLbMI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LehRYIxQ8Kzw0rNcmeXmWkFv2AIQ3cZ8AdYn7I7/iu4rtISJ69Lg9i7GstZwdJBE/t66tqHuNf4i1vJk2Ya3U5t2wNUQrLCPB21erDYTeCHQHxQ7dFQxKbCNTzdCf4zVMtwg1wJqJd6edMofwE+qGJXGqUZ34R/WuSATFIn5QXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d3a4db56so25347735ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761109862; x=1761714662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IivaJmnHo4syQl/695R3OTIJR+0q0/+G1xkvdlq/z5Y=;
        b=ElIUmpizLheDfaBWem47k6LEdu+/iBdDe4a3JaXnLkIICLLTwRJxVeWtw/n0gUXgqy
         I54bI/OHoLTOUXRUt+jgCXh/GwB1WB9Qp/4oUcbMJQ4kQsZKajGowo7p9AatjustDK14
         CA/9yyQxSBxT4l7ItbM9fjdjjQv+inVp2fy50oorzEFLosBk1dCG8VuS3j/K0XZsnQ6Z
         RYGbbPC2C3D/9JEWIIx90H0P6bv7jG6SBC9+KwyamjYSv/xPeGmxuKbUt6jFpEHEnI7b
         2D/fcFgg86JHEAqPv7yXc3gN2VJbmppIy/JI1C1hVzqSYJYZofds0vRzA0mWmT+peMDH
         kQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/mltzFJ5bAnHR306y7UIYP4KifJQET/VEFT58ZugqHg7USFAjiA0Y66642vga7MDSJe4yg+nAlSLfG5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEI+ckG7waYeDpD2h/y010t87RlKrDqBE1HMflytE5NQ4GbQxa
	44iDQ/++GgFNyPdx3pkJ8LaTTX2mjgAbmDqM9SLaZNdZZ/OMsJZE+LvsE12eaOefUHOPiB6hjXY
	MgCDiAasgi6efnDBFbIqnUSuOr27aAC0czAXvabky9MJlK6XPle2MDDJAkLU=
X-Google-Smtp-Source: AGHT+IEuYEbcUq2iViHxwbIcLJwREU+NHy/aGMazE2pCPSUJiA6VW3Z0lFa/ew+1fIeuFiizNILvQfoTBfbLNPgyyoQMqpDGVR0G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:430:ac4a:4dcc with SMTP id
 e9e14a558f8ab-430c514b650mr283326985ab.0.1761109862606; Tue, 21 Oct 2025
 22:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 22:11:02 -0700
In-Reply-To: <CAHxJ8O-aa8eM1u4J_E6B4Rk6S9fsnLsKdU02+n2FTSdnhDHtvg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f86766.050a0220.346f24.0034.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Tested-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12689b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1215729170d20fc
dashboard link: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16971b04580000

Note: testing is done by a robot and is best-effort only.

