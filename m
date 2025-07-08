Return-Path: <linux-kernel+bounces-720750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C4AFC002
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506DA1668B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2C1F09AC;
	Tue,  8 Jul 2025 01:30:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8961EB5FE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938205; cv=none; b=iOGAbWgM+ULQqOoL4xxdazdnhoNOGjkMhDGUduglbLNJQ6VD7IuFKs1X2Tc7Cnn75+KIUN6qlsWLsJXNTw0DkYmgF5BUnKkyZVI2rs8AGtBPYgLYbA+OwLk1WoX/a0VZHXGYpa7lI3q6KNIsbFfmlPqUdKqAg9P2+BMNlvzIpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938205; c=relaxed/simple;
	bh=cn4Umls3lfxi/pTRDdli2+o7x3d4DwLStY/xfIAwXlk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PVwL0BgZuZa3O40XD3Lrc/FCf6ER1caz4OEvRT6v4f/eNHLLiV5J5O+yIUjscEnRkLGfRCV61Vk6mX/Hx9zbhcqaJI18QOI5S8/YIbczY5B4GhYA/wP8V0Q0XLTvp3aBgcGNajzrKJsTAB7KlVXxf2osEJRO+KoZEcBjtjUhqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso37536855ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 18:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938203; x=1752543003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na3rsNJ9tcBsfAiKjyndpnCxY/jdNhe61LrcryKrOZI=;
        b=fRca70HhXDTqBaGzAFFE+i/5lY6MSBev+pPi2i4srVnR4JabGUe7X2q81X5LuGbEe8
         KDnZYASOWcD+oECyAtO5xLT2dYdGWNkmIYhKA0yXB/KkUGN8/HePANZynYDl+DpXq38t
         ISmatwctiOAV1E0S8IjyFMIJBkBkAuz8xczEaP5PXbFxv0jg515b96LVcL4kQNAYW7W8
         gtdoheM2twoLI6eaU+QEWyKI9U2foptJuZkJaEFPS9m3F6m5h8kVS8jNe4c6NT5Sxh4B
         0Zx2bRVvWAioZz+K5DGGppSKo3Qy1CVTUWc0LaLTA+Y+iL9iX5m3t9dAovySMXrIIy0U
         e9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3P59mftATFePi6DlxJ+Jvs+BMFEQOeST1nTGNRBCKJOHqc8dl9rpsbZzJZc4IotWu8KJD2AC7cke/gQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuA12T7L4UI73IkacpoX8V1M1vSlVBTb20Ob1f9MG5KJbz3Zn
	VWEE84hBAaXOBdvsYf866Z0AGpYJZ4Zxqt9812Viq5ZQhZszaHKpqc1Zz5XWzpLx/RFXm0vizpz
	jBBM1OVpw+LR7LXIcYEtlTo96oPdu+UEjDz56Eq4nVLPDo69lTWDLH57S4Fc=
X-Google-Smtp-Source: AGHT+IFcnAh1yP7YtVMAlmIYTMD2D+4K6Emw3vWQ0m8ijE3k+mO7kXCM6xHFlf7KPf68mWkFP736a/SjDuG2EZZXtEUuS5mTwVk8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:b0:3df:4cf8:dd46 with SMTP id
 e9e14a558f8ab-3e135564fa8mr104839715ab.10.1751938203395; Mon, 07 Jul 2025
 18:30:03 -0700 (PDT)
Date: Mon, 07 Jul 2025 18:30:03 -0700
In-Reply-To: <20250708005930.2818-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686c749b.050a0220.20334d.0000.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in
 l2cap_sock_resume_cb (4)
From: syzbot <syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com
Tested-by: syzbot+e2df3a66f7d16fa6ec55@syzkaller.appspotmail.com

Tested on:

commit:         7482bb14 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=158b528c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=e2df3a66f7d16fa6ec55
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f2728c580000

Note: testing is done by a robot and is best-effort only.

