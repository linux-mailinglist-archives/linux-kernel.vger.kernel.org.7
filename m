Return-Path: <linux-kernel+bounces-874624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC0C16B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4923BA778
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2734CFA3;
	Tue, 28 Oct 2025 20:04:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AA218626
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681845; cv=none; b=eQd9gPwkTLmb2xB297Nnindz5DeiBCv0EZO8Vc+U7XZVovJilaZoQGfxAzKI+4ZkyihnOVl1361m4QobPMiQ0/I/jgNrSktW8g9OafwRoL6c+lJcJ9mtMcQnil+xZZvWxM9kC4DMonMVMpqtR2QD8Of2p4umhbgkHfnqTiC5Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681845; c=relaxed/simple;
	bh=CYyrxJ7bCx2Ucy+CoDvAw5HOydqvBCfFWvbUs2RmXsU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U6KvNYbPOyDdst88YvxNL2GxkcuYLFUnxN7G6u9bvVNPEhpdj8Sk/xa6jh1Yae5mfr+7Rn9u80SZbGS6NfKFE+TBDoJqS/OXahasatSdjdjEGlWnSCbNiJOq5najeh3BCA19J2mndMHZdF1GmrEcJ+WxhFgpYYSHAqFogXQ0Ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e347d2afso674623839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681843; x=1762286643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLfxstd+qAfn1Ps3+RhUFW/fWoB1GKYtG9qeUwSh4TY=;
        b=COxPcG21OWybUF+e/3iG104iIhpnwOzhW/oKmjcEh9/wHFeI6ckUPXpoTdb2OjfDeq
         D3XNg5Et8nL+g1ySMKXhSJKLoylEKvxQJA7LhXmyiTfr+hoHJqIAwp2lNeSrcQXIA7E3
         ctm/V8Dag5wL+iBXO/zJYcOd/STSMd6R4XzjP0Io8dzTiptqr2tAvianPebICOG/L40H
         wCGfkiRFID77dMeCAtxI54FKEPzBUc7M8hTcNyXekO8S4tD2OILF9S//ymHFuWfW8G8O
         vK18Z3M507KrvlxLQ8cREK7yc04ZRxyTG2swnXGMjFj6On03y3jDTSxVprQy2TINgWKg
         oIBw==
X-Forwarded-Encrypted: i=1; AJvYcCWqpgqQQNGjfVGnW1VA6HLhj0xylkY1yn2TmAzStFfeXga/ogE42ZiXDKtE8yjDaQ/WKS0znwr/YoOOSck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zdvhpjPgk9TlfJgUoq9ecC4NrAekKGlMcf3Y+tXW4M7dp3aa
	lTNaIIeaNJWlH1HWAmExU7wSFqja4cTmuYYOhOjUcx0PdDIn7Yve3Ra4O1fKivodxtLYoQh83Ld
	vE+VuXuYO69tt2BZ+4EBv0mWUy+fX44c3axaK+wUUq+pj50VORe3CZb2jMls=
X-Google-Smtp-Source: AGHT+IFWDvytnnTV5gsceUf+f8GF6LuAmIKlPht/QX+jDqSSuH3IPp88F2fjILgxDP1WWpeWMapeSf/gygnF9OjeN30bVgBS+ENu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f08:b0:430:ae26:7c37 with SMTP id
 e9e14a558f8ab-432f8f870a5mr8389655ab.3.1761681842880; Tue, 28 Oct 2025
 13:04:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:04:02 -0700
In-Reply-To: <20251028181941.KBqNN%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690121b2.050a0220.3344a1.03e2.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141d3614580000


