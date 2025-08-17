Return-Path: <linux-kernel+bounces-772617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6FB294E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442A1196806A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BA22424E;
	Sun, 17 Aug 2025 19:59:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8682222B6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755460748; cv=none; b=JTUmje4W9x12UfetvK9RjxK6/9SDxLcHFA0t+1NbalVeSZvax/wuoIHsYlGt8l2x1Nqd/Ibk7srR1GpPjNWSJAUc/F4v+1pUp5R5A4ZQCqyLvyHn0bWQl7IEzwLQt6alDj2YMlNzPAYxu9iftOdl4fd+iMEX5WBRwgy0eIyJUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755460748; c=relaxed/simple;
	bh=OoPbuFy+H9voP3auMUl1f3cd9ybv01HpYmdr1lSXwlw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YXZSm6iZ/6Ij17xp4MT2mFgijcEOWYhGXp8+2zOzRSOwcbsnTrirESqO9aCzshT5+S3owVllRCYrb7ZFty14Gi4UaFTYDBOkjz/xQTWxC2CvxhZdIvLTN3q4EjvJQPIWJKE2hsPDss9JA4gK9Xs/5+qxwiTPNyB1njAo3QSGAl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-884418a2614so567920739f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755460745; x=1756065545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgBX8FaFkdAywE0nZcPSuvylOu9Bub5DK/kif21MHqg=;
        b=DPpCsYV5GYWHuKKVNSXdCll5ZyJIG0emGPkvYk+a0U58VWK18ZlahPATKmpqHAOoPU
         GEp3yUygiw17x6pYCspZyOpkKXAFNlI2jP4SD6dhOmkODpi+4Sjwo7o/dAXWaTqC7ZVW
         eNJXRt4egw9yl/QvLyIrygZZV4W5IeYjtQ7ujQKqzvBlilCvQp11QxLJadmXbrGusN3B
         b4qYjGkJ5w4+3y5HxyLuqv5t5LWk5GBR4g2VKPkjfBWx0pKp+BfdBgGBlJq6L4dRGqJv
         +5aka33ccjI6/wnkFox2Vjjj1LOmaoWPWzzBNqy3YZKWtQU+9UznFzGMqR9r5vYVh+aA
         R2pA==
X-Forwarded-Encrypted: i=1; AJvYcCXsgxUiBnFQch9CXtjjxowLetLaCW8jRX4Rn5RBkAv3gQTxLfT9HjinbYJKlKJizw8xkrlKPPUqA2wloLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcR9lFRdGSI5TI71CcS3wLBRRnFY43Jpx7fr1uEnaZXS2zY+W
	QZw+Y5vq/O29rvzCjKagNYSwkG0JV9shdi0oQb4pWtk9VqJiGFk41TTXG0BRBHb0q9gDF6SDQTp
	PCz80Ei8bDxeDRB7k7pxqNcayNVHQYFnYvCUFyDweNKXkRVmmMH6C00897a4=
X-Google-Smtp-Source: AGHT+IGai3ByaaOwjjM/OjSO/nWESUo6aSGgKJVI6XUm6VaSxqlagCR0TWyRCRhX4OplmBTNdiRDCMqTNVoaP5nTc/xRciw+pcpk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450d:b0:3e5:7f54:dcda with SMTP id
 e9e14a558f8ab-3e57f54dddbmr127612995ab.1.1755460744900; Sun, 17 Aug 2025
 12:59:04 -0700 (PDT)
Date: Sun, 17 Aug 2025 12:59:04 -0700
In-Reply-To: <CAMV7Lq7rBzOwpyRZjjs9UkXFbfgw_YPX_RvN1gx0rwn0+e=V7A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a23488.050a0220.e29e5.0075.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: abinashsinghlalotra@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/overlayfs/dir.c
patch: **** unexpected end of file in patch



Tested on:

commit:         8d561baa Merge tag 'x86_urgent_for_v6.17_rc2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b91234580000


