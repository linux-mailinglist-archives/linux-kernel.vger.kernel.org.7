Return-Path: <linux-kernel+bounces-868514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA81EC0561D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722F23B1AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988F30B515;
	Fri, 24 Oct 2025 09:37:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED072EB5AF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298627; cv=none; b=HTr9jMC/xL7coyqJYMAdzp5L4vjK5lPhuZfBpjxZyL0dHG6sioUOqKwTJXcEJ9iiHhQEy3j9AO12nL7s3va5fbyq43dD4Lmz8ewgAOoZIMyBk0WyvY+GVjpsQPRpzB9nOVLfejCki4sCVOn8nyux+UMgpxR2d0kOd+/LFqZOSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298627; c=relaxed/simple;
	bh=gUMkv3WQUcuabIn0FKGW14E4Ddh+xxYYgV25BA6CSHo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cYAzfQSLZWklPI8qyYhYqaE2/Xguh2Qz2ytyjus1sil6c8bu4fzXl+JoY/h7JOpalfWb7Thxnyea9pZY+3Lxojhcl/QlhV/BpvG3TvovLGIIqfaPLTmvOQ85OxVn0WG6i0C27g7yIUSZGI9sO4br7DLVrGJ+9srrJWcrTHtz8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430b0adb3e2so23924215ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298625; x=1761903425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIoRaJs5Uc2PPX0h2m6BzXMg6q7dMXPOStsmDt2TF4E=;
        b=bT+qlGr1DY12YuKeBzUH6tgrylGMdiVCBDhrgVp44jvny+mwVc5cELrLoe0WTO6blb
         CJkbglMM4ES30Y8bu/jSLCHg1gvsxEuqrkJB7pILr9h3IgoFYCdf+1DcDlPaENST9eA3
         h3OTZqvUYC30QBbQy5IdO+pRryhnuoTY0C6JPh1NGnqNT+ynNnlbAcDrkN1seN8avDb7
         W7FCVereWvwQf0YQk8g/Med0KxILM6R4ElgKv5pzy+YUi7NL5V1OeRS2QBt68JRYW8nK
         FaaZgedwKFshE1WJqfZaGdWyky75nVfMFFrBmS85VXOuopRtaqPgd/H8W+QMP3inm02o
         6X1A==
X-Forwarded-Encrypted: i=1; AJvYcCWv3TQmhtsLHjNWFfByJKy7XxW5rN5L4Vg6gdMHzOv3ktdv8Zg2u1s7gIpYA2om+8bCR4RMzXjNL1EV5xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZQ5o35xQoUK4D7cdaVDdgTdnNqwxJPH2QCK/vNn52lyJ3z2+
	NLcJnyABdb9gIlYruAQZKU7zIol55vKcVDhsCfLUYFkFXa18miOW+Gg3j8PW+plBudSjtPWwN/J
	0QgJrDRPVfAK9aGhgYMvKF05GSzqzXgiGLj26tBvYe2yFRQ8ZjaJdaj/Y/NY=
X-Google-Smtp-Source: AGHT+IHS0I2o4KaM0+rN6T68/ROE5GAlWqPi9Tho6Qc+h38IHlinrtQLskQ6UOf25r8uYm6XJlMCUdFtwolxAlNlp8fN4xTTqUvq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4801:b0:430:b4e1:bcb8 with SMTP id
 e9e14a558f8ab-431eb65dab1mr21791015ab.13.1761298625462; Fri, 24 Oct 2025
 02:37:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:37:05 -0700
In-Reply-To: <20251024071529.h1Iuk%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb48c1.a70a0220.3bf6c6.0182.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=15a19be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae55ec3582be8d28
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117dc614580000

Note: testing is done by a robot and is best-effort only.

