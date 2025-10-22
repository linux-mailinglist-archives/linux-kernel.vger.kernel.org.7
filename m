Return-Path: <linux-kernel+bounces-865041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A71BFC0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E15188E85C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACAA330B27;
	Wed, 22 Oct 2025 13:01:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09E285074
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138068; cv=none; b=f/SPqKhGmVBswVK0oUQDUHhvVdoiGGwDD8CZu+vuDMR9/B/W8eDK9+H6PWbcJ57ADyZpjSDLwA9Zn+JjHoP0NQ/qL84eVctJnNyj5a/RooNMsBkuk/RZBna0ygCuqsc0q/af6bRoxzT82r9wTg0hKi/Y7RrH0IbORUHGNpVsLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138068; c=relaxed/simple;
	bh=iHO6ZzAwWZfF69Ip6Ncmzc5FEvO5bneOEyyyCmkxlFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PejBRacRQrHzhZKTe45bl/Hzt2bxv4ZYFial8d4NcuuJv+Xd5QGzf0xdv6UubtJb36Dp2RZx/6PQqT8jedALsFA0Mj5dJ0LFCNM42HHroOfaWsn2GGNAevUxChbCU3j1vS7h+nLuoAykClXjqsIrS/d4mXBi/WrhrEsNVLtohKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e1a4a129so45924925ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138064; x=1761742864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tn8BYsdzWxagQl8/qCYAxNVxJnQOlGQJy+L7EO5nzU=;
        b=pz/rFGDEMAVXP6jK95+R+EVppB8p+ldUBOGSGDpJTy7/z5QsPO5wZlg4XUYiQRJxeX
         +jEx6zG7zSum5SP/wT0voBUSNUIjtsVkefVlkgna5CAij/Mr7r44ZnS05aHiQK3rBl2c
         GS2X6RSgYtuZT3qFLvXQ5mkc2hnYoZNV4sRAxxKMevjrl0r+gnMVUqekp5J/STLG0S/E
         SpQ3kd7i3yd4Mn6PSagNCxXGtlyjFnvulrQocn4khtKBLrCVgKIjz6D3C3zckK2F6onn
         Sks/4oXM6gAqYWt7B5AL3Q77qTRqvWRC9KM7yUqp/KYBzivFJN2h+R8G7ebtNXvwzI9G
         VJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ra5EQ+29WyOJ4Z2u0Vihc+pz4/7IMyJA+q7/YkIWsITXpzKtAur4fVWZguuWWtDJ4walkctgv63nQe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6h7D4py9Pgoedk7WsCAGDA7iVcxWUUVrKjKgY2Q9e3Kc4vqs
	qEbFU6xtGNs+DbiApPB/KBdMuHAKhRQa/hE5gGbfVRSXYxU6j+LWy9XyCKEs2VdVOD+SyAI1+KN
	iC2q0QUevERQZiW+bDJoCiHrm6NERzChnVzqlwIEohZTjywWQB5P5ipe2yZU=
X-Google-Smtp-Source: AGHT+IGZDlc5gLWfgGehDegzTrYJw7RhuYOssKoc5TpdH7zts8UsmbA9ivW3sGNgqklVDlm+X5a+8MgMQqxGB6qiagEpJd8hnrT7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3787:b0:42d:8b25:47ed with SMTP id
 e9e14a558f8ab-430c51eb7d1mr310126625ab.6.1761138063761; Wed, 22 Oct 2025
 06:01:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:01:03 -0700
In-Reply-To: <20251022121354.-oB1f%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8d58f.050a0220.346f24.004e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1322f492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c601ba0b0d071c6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13103734580000

Note: testing is done by a robot and is best-effort only.

