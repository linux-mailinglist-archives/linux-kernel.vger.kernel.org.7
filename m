Return-Path: <linux-kernel+bounces-875098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF763C18378
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 260F134E570
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E52E251795;
	Wed, 29 Oct 2025 04:00:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD42F12C6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710404; cv=none; b=W1jt3sQjBLVxEqmeq+d0zJTETkdDRz+X6rsJC0IoOuZkorMYlcyYgWd/IcKLUWXeXRYWtLcVn3ImlR1+jMlmB9RjduHiIfHFgu7Tv+WJqOhOKYQwhc/t7hhEwQ9Fjk5oAytFRrn2WGJ9VQSfB8stRdXbMD+gNVQksFyzNKA0k+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710404; c=relaxed/simple;
	bh=JNY4x/j31TcTSEB0lLqIWRe3c/NRRySg6Qg7ilc0EYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kEQ1/QnWmJXnNFsZ9XvBhlALP9NgxMCaFbX+6oz+ww7/2rou0wrqxmvnukwf03rmwDrNN4gc/g6d3tfLu0/AmBlUlcS3U0icA+1/7ID/D2zpQuMYwPe7avi08EtO23sFPS2jHNFj8i46mxjfmEpHe/NMe9MRL1o016OAycr6mAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so259726555ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761710402; x=1762315202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQXQ9QElYYkqaDpuZFh6tli+ro7wkq8ZwfLbX9XY2uU=;
        b=gPEBnXZKIiYsTk5BKX9AOEVEJkOctCYrv9MOfpjvEob4aDZoq5AcoWLqKyOyBIqP89
         jZU6utn6jKXERV4uFXMiFrOTKxWwpXMybw1qAPHcygF6fGAREBNWYDZ4hiKKanTNFYTn
         TFVYmcM1hfo+4sNPZ51nbkk6djvAK4xTQB0zBi8PUDGSl9lQghlJUCtBRuJXwfc/igjO
         3CmvByNIrzFmdgFMuGiI7Z5if+fD0UUGbm8vPMzzuTsbiPREthqYeAMaLVQDBV/M5hsS
         hm9SKsaFnaYsWDLtitk/0lkRnpjOG1btzUznNZrhZ1gmXJoAByM59cJ3SSpb/3nXxhDT
         ceFg==
X-Forwarded-Encrypted: i=1; AJvYcCUmo5jPnQRiNIrHw8wolCwPY3ePrdpFlJOQAVvWivY2ZrWYs5impDZ1+3meOpPEaBPDO2VFgXhT2SroCoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcrBP9+MULA33wFyOzUxbQxUx6LsTNZ2KgrVqqEMB4Z6i/Msl
	oUCOVhgP3w584X88A9Nu7xj2aDwxPGegas4J1PsLKDSVnOsCjbxrdgXBQKv76cPd5hgldvHkKfx
	5Wg0HOzkDkEMWYBwN8ZkLmh8E6Aw3pFpE4evets3ywV6L9rfNeKWgz0gePos=
X-Google-Smtp-Source: AGHT+IG/aAgzNPHbIV10GKXCeMaIylhQdo0xwzUqsxsaU7Hi+vbosc2nrPp0hBT13HJb3XKSCbZSktARLJ9KBzRp4oDukDADB0b+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4515:10b0:432:fbfc:554f with SMTP id
 e9e14a558f8ab-432fbfc5939mr2540485ab.17.1761710402497; Tue, 28 Oct 2025
 21:00:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:00:02 -0700
In-Reply-To: <aQGA0rVKnoH3PDXh@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69019142.050a0220.3344a1.0401.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13836704580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1009f614580000

Note: testing is done by a robot and is best-effort only.

