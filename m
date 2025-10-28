Return-Path: <linux-kernel+bounces-874664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D9C16CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44DA74E5F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9534BA57;
	Tue, 28 Oct 2025 20:43:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD820B212
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684186; cv=none; b=TIzFe7sVFV2wY2xxsBZDNeyDXLqqCGUYnQ/xOYOWbVddYM3mNyPm868pGnwcW6cx0zpgpY1D98P9rI9ZfMcHtbSayXO2AJKSV69K/I3Fr4cTmjqp0aPjVxld99jczrBpY1vd6DqvAUHeeWyAQgbyZ8F4eXUcz0tpsNsKyqgp1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684186; c=relaxed/simple;
	bh=K15pBVtOP4CV2SzsXlk+hB41nNt3d4jjZT3y/h5gTu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D9TE1fsGrJLTVbL2GxGsq7I6XormzVdzH+FUUSw8sVcHLXnzrV/cQ9/W44H2kZNUAN/iWH5gOnsmotjkbXb1hjnFyFdpC5HsVX62uBEp/UKtk70iZcVPfmCH6ToLigydSgW7XmsPQjCYld1ePEosf1rpJ/VRuPz1xb387L03PNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d83d262fso255673845ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684183; x=1762288983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSnJaVVA1N+SjFWPLNW1SEhWKT5Xv5EWPHCw53NSxcc=;
        b=kEI147axpzBkUtpGR+Boggm9lHvj7amz84bwxufulxP7JwcU+ABNMDzB8gQFGTAF8P
         KOUbde4u6q8upaSuWS3yogVdNXgwUHfL+VkDP93QNa3IkY9ncMUkRZtxvbcvLyIaa7f0
         gIxv9mXSc3rqJG3ZJk4Xjp5MZDbbmKlAzlmch2NO/Gcu4HlzkjgPHOF3mCerMq9FoFOE
         RkXx3je85BFiLCEUF6oJlsF8R+HVPSJhS/J/QtnuEj80H0qLIvKTWo/0MtlVf2PJrjky
         raSaoudV7Ifv7QpwpL9fJZYaomcfHnpr5GoxdSQ1whMWptO/2hmt0zgyLjrfAsfGFQwP
         cr6w==
X-Forwarded-Encrypted: i=1; AJvYcCVkxrrk5CL0fqiXE8fCg84aOwalt/9X+u9/sYlZ5CamIVhdbhDcMbHyBlnsuEYme8SbpUvomnvoQ/eAmIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDjiM7Hx9EihVV4kZJDJdmBXE2iIUe8MYc+gp1XKk9O3BE3QO
	aIuULmFtQWMvkeP6YlZTB+h34s3WK0GjPMH6pmRZe+M4LKrDRntkAy7hSXOs17/8Q+6bcOOYodF
	jNHZHvoDyWt6eN2KcPazglRZQDkTMfTrZPb7cz4JllThuaOWM/eG/4M4yLe8=
X-Google-Smtp-Source: AGHT+IGWZefckDxHg7+ZDOuKRhwg5OQi6LoHXwp00u3HhUcvvIhU2J+MOgC+oU/QoHZMhnT7fwbNsxozZUtjZ6t9p6AQ5JikGVTQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2487:b0:430:c90d:10ae with SMTP id
 e9e14a558f8ab-432f9092a47mr8478855ab.32.1761684183621; Tue, 28 Oct 2025
 13:43:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:43:03 -0700
In-Reply-To: <20251028182010.VCEv_%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012ad7.a70a0220.5b2ed.000a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
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


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143d5e7c580000


