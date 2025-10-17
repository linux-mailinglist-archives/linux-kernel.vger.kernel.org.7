Return-Path: <linux-kernel+bounces-858758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45849BEBC80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD47219C7C17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FC27B34C;
	Fri, 17 Oct 2025 21:05:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFF354ADC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735105; cv=none; b=ir+HrgrbpqI6HCTNtiMu89Yhh9uzvjDFRgD17/HC4+2f2lEpGeidkOhva/p8ccV6sDLo+qGEIGADQujDnV7s7thNubpQk/Mag2/QwqWWwMMxeR4rnZ9IcVLFmX/mwM5O3mEpDsemRTThz5CyGcQOXrE4N1/Mez6ci2wsdLwc+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735105; c=relaxed/simple;
	bh=9Ry/qSQEyS0833g2gB0i8Mg7J0hJrwaUu3g/UC5yyLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GsT7+eqOkIdoWm6Tk7p8N+rES65tANtlYA3IIqe6A3r1TCI4cOggJTfDRC7C+T2H+o60DG+Ma3wWn51ElpxxzfkuQnP2OXFy+aoPLnoAAJrVxIZowUqpgGBaVTVN3Ciu4nl/x06gOw/dcT6MCK0EMDETml2+/6lxr8PF6uUKcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f610046d9so70388115ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760735103; x=1761339903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adG0mhvTpN1+jpp2UirgJOLwymm8IWY+niZoFbZbJ0Q=;
        b=rs7F4I7TAyW8nNiUMGEvMHwptJ3K+5wqwNCmxr1Zz3+Y9EsDSvv5VSne5htuN6Ggy3
         NWvvHZdM/DhJufMCljaCODlgWCFWDNo6HxUMmNRt1vdT79TamOxJxZ/Y0xFEzZbpn9Fg
         NbykRv7fHzm3vGKDvDIIVsP/Ep7ne15crIrXkFtWYl5ILFZmar7ABeSlhsgOEqZ9typg
         JwiJhCr/vMt6cbc2OoYQBOcE/YTQMtEiG3SWd51hWqzZHjKXTZxKvhxyLlYjA8+HNYvf
         ptQZ7NpraOxlLXm/IezhwvVoJkb6WgpZX7HgseleqCvI9XcK1xV93B4ibCg7CDkEKrYW
         U2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX9nd4Tf1Dzt8nNeXDIjr0/Y1EHMSSRywiGQpQh+LOWXCd1W5IpD9mXu3mDqqQRGWLyabReCi97x367Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3F40UuteLWA70SE+GsR5pm2qSGxq+hZ9O/sUnhfUNZYx034pL
	X/K1mS5oX8kNW/vq7cDi6Gm3QYsH5Dguj8FhRQF3iueipBgqyDlRNHmrqX0gVXxkubengmckeGU
	7I3Ccts7UMr9K/oWghbBCkuDCS50tXS6EBcyZ0EX/DaHcs9mG5gjakG/bOG4=
X-Google-Smtp-Source: AGHT+IGkyZ+qSVk4PGLlIKunjIb3OlZ37rbYpQMzX9szSVL29AfHRXTyR+eoJ93qz70d3hfY+oIG8vyMwGcQz79Wn7ZOt2wRBfua
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:430:a38c:b761 with SMTP id
 e9e14a558f8ab-430c52bee18mr66479935ab.21.1760735103368; Fri, 17 Oct 2025
 14:05:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:05:03 -0700
In-Reply-To: <20251017201304.218523-1-hsukrut3@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2af7f.050a0220.91a22.042b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbAllocAG (3)
From: syzbot <syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com>
To: hsukrut3@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Tested-by: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com

Tested on:

commit:         6f3b6e91 Merge tag 'io_uring-6.18-20251016' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1127a492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=4b717071f1eecb2972df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f5b67c580000

Note: testing is done by a robot and is best-effort only.

