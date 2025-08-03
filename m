Return-Path: <linux-kernel+bounces-754410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4387B193FC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C833B6A0A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36C825B687;
	Sun,  3 Aug 2025 12:09:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172CA48
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222944; cv=none; b=av1Om5dUdBpnnnrsQD3q6aewt/N1tOeslPPZW20apO2Bdd2NIlOos25qvMgTSAx4bPqZFeRL4xOB2+B4OJYnFf9q80N6glp4orwkX+sON8drC2fhKVWwYTy8tN8OtRU8PR3lEgb40NtNisD5siS2+tHZtGmQ16sK80P6eX4lbC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222944; c=relaxed/simple;
	bh=+BxCQVXtTe+xoz4eJ9sHAveL3+qt5++cybtEn1AaG/w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l0UJweqXPXCuFM/k4G2gkuyOWVXchBElNuGT5JCm4FjiiQAmBoWa+08sRv3X8OB1aMMtUn2/NyWFkaF92Yy7PW/NzSSkN5j+L9SGGD7MvAiP8Bm6tugsZO7bLj+Lic0wFwvsBc058g1MxzqcTv02pNTrwy0pCuGkp8M/RgtmBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3fcdbeb23so70022785ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 05:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222942; x=1754827742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5+xCIY68eQod8HShjZie1OqXUWvIMyxZ5G/valhey4=;
        b=AQMnWd3y6bkuRXbUjcYgP+bzKAmqPRtn6iY4E4CaoSiMjg2WxCDKJxwInszakr2rNo
         3YcF3Na66k7MMLCdF+BLibGfDDDAt6lNlZBnVdR8B8cGIlvV3YdYXKbvU05vYqxQGzFX
         gI1x+OABxQYepf6E/yfnBHUl1qAF33/rEB6B7GHDt2gk6BB89n3g6qAE2HutUfsFE7ZY
         GefpI8yhC4p3Z2ca4mE+l1x1kCQYq7xuFYDE9i4sZxR4SnJGPqswPBtQ5H+kDpvlhqEj
         W94Zwyax5ShE72qspC//MeZMSe8AzZ4qQ5V1liRg9yNDIE4ODRU85LlrNQOAkgMOquGg
         3CDw==
X-Forwarded-Encrypted: i=1; AJvYcCWOiSABgxzOrv6HPeGLM8v4HkW8in9rY98Bi9bMc49fMaX3G64MDIiHINlxVAATiOnVrdwp/vBYFxvt+CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBiVllQpE0E3ps2H7w6llzNWxNYrTJjNm+BgkcchRFhlF3LR0r
	KsuTd740e1+E2KqFjfZTu6+S7onwGSgEv+mkpoTJre60YuVwSX+dNkNWRzOfIXb7j3sv46M06pT
	yiu0Sz8zjlG+WGCY0SnK9gHsFsT3NFfvaIQGMlIYBEBKB1ebqQ7DnAyB06Yo=
X-Google-Smtp-Source: AGHT+IEI73yOX7LuYSonRTZStd7VDhDxkqzJkzexmNHlJCJ1YhLhqOvcqAg6Qh64hhfeEztD7/M6cYE5zqbG4QmcfI8nTwAfsPR1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:3e2:81d9:cbbc with SMTP id
 e9e14a558f8ab-3e41611a082mr111370915ab.2.1754222942254; Sun, 03 Aug 2025
 05:09:02 -0700 (PDT)
Date: Sun, 03 Aug 2025 05:09:02 -0700
In-Reply-To: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688f515e.050a0220.13f73d.0000.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, hdanton@sina.com, jack@suse.cz, 
	jlayton@kernel.org, kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	mjguzik@gmail.com, netfs@lists.linux.dev, oleg@redhat.com, pc@manguebit.org, 
	sfrench@samba.org, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit da8cf4bd458722d090a788c6e581eeb72695c62f
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jul 1 16:38:36 2025 +0000

    netfs: Fix hang due to missing case in final DIO read result collection

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cfbcf0580000
start commit:   66701750d556 Merge tag 'io_uring-6.16-20250630' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e29b8115bf337f53
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1400348c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b2048c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix hang due to missing case in final DIO read result collection

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

