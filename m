Return-Path: <linux-kernel+bounces-836047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E90BA89CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446E9162149
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435A28B400;
	Mon, 29 Sep 2025 09:27:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D286880
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138025; cv=none; b=f8JvWftR9ELbrUbYqvnc6t0DrS85lWlTUL6IBd57qrR46aA1WU3HL77Sv7jgnHCivMOkBRPQv0Uc+cssFcKkR+/IASUZvDA0XgJW/9p0tuT2r1YUBonM834pywnBMpKYxiraBf/FtaRA2QXvWuEzX0aQajIjKxV4KuappmsTrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138025; c=relaxed/simple;
	bh=N6rFEwa6PcNvhyr6biIgTaz7CkN/Gt0/xv7vhZcRO9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sn++/73zmIqY4JmLSfy9dJXRYt2VutnFLa/dh7SAjh8evMS319F6dRfVnlIeja3RX8iJ+G4s8/rk36hKDIf9XK5x1bNda8JCHJ7kwdYKx6myYvRxPFAEw6Kl/HbL0uRCq5EOELcMlloxCBNFzj6TR+JVaz6l8ZMSn4KqNrubxY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-426cea3f07eso117169245ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138022; x=1759742822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXWQyOOTTMwR05LBZX1h7rIQDPuOjg+ngcEVr6b5w8c=;
        b=BQS1JBBVGEvOMZ5g5NgOYvwOKZmwu+owwLV+FVIpldbCgTlWevfaJLE4WpgEOmgZ3F
         8v9o6maiChyE2mFegOH9+GH+6IveoyytE65EyMKKYe6Q+RMYYMWu/305R+J4uDNrksIr
         Ibr7coel/mu1NJHfLFV6fHkkMS3NvT5QP/v3HbpLuy3aTf6y4Ul1aGQdeRTrDJmA8xXa
         Us4KU9326jPGWHPNR7ZjVDDadgmOuDA0jFdXLs9vhNrsVZmu6YtAy8sAm00Ug9ZSGd2V
         rsvkXaTzcXn9uEKIIBUG0oEESjdhPPGvTjeCj7s8PqFjN2vLy1MZaXMdNVjT7PmOsi0t
         vDIA==
X-Gm-Message-State: AOJu0YyZ3tX2yTRqrG2NFd+BlWVPdtehJ7FJ5n00Ya5mVas5MhnmFblG
	j5mo3vkna4oRpL2nhpM52xy/ykZfX7FEbzfBJjSsv2rUqtKINFiZYimHApveHT0W+Do/FThq9QL
	Mphm6nS6JStAxKCYPuCiqKz4AD5xPQ3A2hzzkcz1qC89heGC2YbrLId+JWCY=
X-Google-Smtp-Source: AGHT+IFjQpGiUgO71HcNjDmxRwnttdJ8WEK9/EG4CointO1BK9mYX55EztHmEqld1DZlE9guZ+aT+zkLFLDEnD6ZIJpv10VPPyFq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1788:b0:423:fd07:d3f6 with SMTP id
 e9e14a558f8ab-42c6891baddmr14122735ab.15.1759138022620; Mon, 29 Sep 2025
 02:27:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 02:27:02 -0700
In-Reply-To: <20250929075024.115993-1-nooraineqbal@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da50e6.a70a0220.10c4b.002b.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-out-of-bounds Read in change_page_attr_set_clr
From: syzbot <syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nooraineqbal@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com
Tested-by: syzbot+e34177f6091df113ef20@syzkaller.appspotmail.com

Tested on:

commit:         26285807 Add linux-next specific files for 20250926
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14afeae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=997066872b7941b6
dashboard link: https://syzkaller.appspot.com/bug?extid=e34177f6091df113ef20
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114d2ae2580000

Note: testing is done by a robot and is best-effort only.

