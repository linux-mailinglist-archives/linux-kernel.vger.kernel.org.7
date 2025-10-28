Return-Path: <linux-kernel+bounces-874676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72292C16D55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33DDE4EEADD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3134C81D;
	Tue, 28 Oct 2025 20:58:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5125484D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685087; cv=none; b=G2mIYu2AHbbVRKD+02wAOReibvTCebiHsmGoDexcz4vrBCS9e5d55b5QBlKyRTMoJk6w5mpDKFJGwqcymhYu/qgkz2XT21lsyAcMWbxIbTJAwh1lEZcNcpSYnMxZPe4nGOub6SI5mTF3kquDk8WnhiC+bvjSRCijHPrxxw1uUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685087; c=relaxed/simple;
	bh=OPOVft2kfXVmldMiPu6eVGgZwHgKxK6qC2oV5ChvvOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JXcJxuv5+mSV1ZYxgwpZQU5wNrCLJn8jNBlNxVXRIBRS6EqZz7dR1uSTen5mnd4Xoy7WGXK2MbaXW/XhhEYIfLH9lttBZnpg41GvFb99h9+EfJysQHn8FugBw35JMcyMVRJ/TUPKQ9L1NPCX+GQyWfBU+iodKQ2RBwAH7Xn2020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-432f8352633so13435185ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685085; x=1762289885;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkCU+01vG60vIscjqe3ONOVw0a30hh2e/wtYVB0rbgw=;
        b=QbTmwCx/7tkLTEqGT7HYC11EdUViusqNLp3qxilLMvFZS8O4X2pc8Zp4fR5L+cRX3U
         WfmsTXMEBm6/JyH9tFbB7kkTzEN3sMrDEzKpk6FhDzOI/96f0BdyEiSCikgg46ga+kZ+
         0x/jkh9y5N3PJ0EM+cW0P3O6kJ36rEya+wzuU/jXOCMqmMAUyp+vY46OQ12HYNy8iAqm
         9mBsLDq66Pu0aAq/dtXC/MEgzhlq8nQWgWNT3/42k9XO5RRDf5f1Wrs4XYkCj/RhQAqM
         prrtG++uc5CC2Sjby9W+UE22hpUpc++FzjiqHNUoikGWolvk8vRsFVrP3LlS3PS/QVtx
         vadg==
X-Forwarded-Encrypted: i=1; AJvYcCVIyOS+Z7YI+8l33mJTnG/juj8FAqXCANVTEIPpLrNzld679nSEUu9FtmQ8CKx056MqVuHmB51RNRRTIw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FqYwcQUlzGxEEuTZ89D2V308BTTKJvj9Kc7y6KPTbsP69anX
	/gWz8ISALvb7mseVtt4CQpw+IndVDXYUF3++KdkekdqeExbdOSrl9Cbsv0MD4BPkdnKzdkqCOmC
	zaAL1gmXfBhK7zmPYg5t6/c6uOvgVcjp7woZfZcneG8tYUxI0OYuUjsqoI+8=
X-Google-Smtp-Source: AGHT+IFd4bKuoT/mU6K8agET6Ru8vbdDKGd++ge9nKSya9KDfIK3FmOlxEEqT/gM8olCOrYg7P4CTMPnb9TyToAmUtbvasq5z+e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:430:d2fe:cbf3 with SMTP id
 e9e14a558f8ab-432f9066439mr8783815ab.29.1761685085025; Tue, 28 Oct 2025
 13:58:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:58:05 -0700
In-Reply-To: <20251028182112.Uxb09%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012e5d.050a0220.3344a1.03ed.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
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
:487:40: error: expected ';' at end of declaration list
  487fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101e1f34580000


