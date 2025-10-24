Return-Path: <linux-kernel+bounces-868937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E1C06899
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BECDA4F994E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72A31C580;
	Fri, 24 Oct 2025 13:39:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CA25C711
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313146; cv=none; b=h3TBpZ6ZeLyn9Q+Kyb97DvLidbyTic8seKkYqbY/3RDSWXn4rw/Sd0rsrCRdA79phjTEvD3j1l4kDMaDAX+FRaVr9u7a3XOrTEDPrTDsyvl0X61gJAHiyQYnb+S/bbEhwTNZ9IEpJBdvpSwVEYUciLCnDdI/kufrRIMLy52dYyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313146; c=relaxed/simple;
	bh=duWTU6tlUM+PoLb+VUPa3GtA+zBEO3fS7NJWwL+2jMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xj6d6HKvSr+C1024PkcGQ6mndSnGiphElmIRgBA0dJeyL1p+MUp/7nP2bOTPGhUmg9OXSaVPXC72k3fgfYxffSV39BanWMF7a6p3T9S7JXuV6r4r3Ov6QUj6Q+eQm0TkVgJ5dwKrC7xpgUfvEVxq3dvrg3S5h0zAg6EI6TBDhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so28694715ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313144; x=1761917944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YumG/ceh0rF7kTvAOcNRUGtTYJvPxccvgaTh2ovyfQ=;
        b=f+FsVpTPUYXv0RlzSR3LKZ9mWVOvo6hthvoGbzaiMWxWxGorK7p4s+piS1M4xQTl0M
         f4UvgJsSi+eUc39Qx7GywL+fxcN6OAQEFmatQoCvv9XRbmqgnJ3VEc6hiMoqhlHT/oPo
         KImHuk2F1mVIj3vnNaPIItDKLYKHt1ac6cHTe/+9L7yp8s3NTKwefiB4ADPZ60FILKZy
         e6CxjDm4LlRLOmf8PPu4/LrsYzBDiYAM55qx+zTF9102DCIUI/L1rxVgSsPtZ+jqdnUt
         xDaRXFmrC+O+IO0A4AR8Bzi5SNz+wGyiKAbeK8H48ahT7Y79byyOYz6TESwR6ODOYoLw
         od4g==
X-Forwarded-Encrypted: i=1; AJvYcCXIWnKL1+fJuL6vG5wawViXS4luOdBsnhE+QJHOvtu+uCaX/CyX6vcsM7oaIVis1ONpmJ5H5rlVdmebGSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZxMX436TiJ3OH0ErkmsExpIt/uis4qMbz2Qy6p0vifDjXedm
	H6hIehyO9PYPK29SDX5Fr5DB1+YkHK5njCvAXR4hxveVucfeMw9kVj2LOXwdsern/dUHFqBsiWL
	CuYLBpaW2fPNGbQCIai21yYsXMMG5QClvF2nf18KRFs9eDu8lA094jlepzu8=
X-Google-Smtp-Source: AGHT+IF1W+ULo2K7tfsx3jFYuPl8uIewJF5QOYnmJoRc0h3+lOjd6x/DbgRGMvm1ilXCBMwFfGvfqdhcAgLyIud78D9AREa0VR8s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:430:ce63:4180 with SMTP id
 e9e14a558f8ab-431eb6148e9mr36419395ab.8.1761313144208; Fri, 24 Oct 2025
 06:39:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 06:39:04 -0700
In-Reply-To: <20251024071530.lavdB%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb8178.050a0220.346f24.00ed.GAE@google.com>
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

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16b98258580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fefde68860cfc8b6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ad6d42580000

Note: testing is done by a robot and is best-effort only.

