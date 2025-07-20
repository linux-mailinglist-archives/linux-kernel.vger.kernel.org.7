Return-Path: <linux-kernel+bounces-738402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1AB0B7E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9F7188631B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A31B043E;
	Sun, 20 Jul 2025 19:19:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258F17AE11
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753039145; cv=none; b=keivvioR3H5BzA2dG0pqUenrduCBYpvJxEuRXFOjtv8h0ey9Gvs5qYtdJRcTJIBd3G8a0UhKaP4u8XurjnjUF6Mvq2Upc+eXIlFRUaKcBR/QNF0W4VHAKOY2NRpJB2+iGFzhGzB/U7REa19SmKYCheGVYI1HpGue6vEwGz5GrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753039145; c=relaxed/simple;
	bh=VtKbQ9+qN6GIwu4xdclsdbcCWXd5POtHOdGN/lRTarY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T24au2OUd7UhUgPqjmtuOGAznD5hw91mZkTYFVKOM4hXYxs+FN8hr0DFmsWaHKFOySCxFShPL731WaVGC+gGWJ6wqZNt4+THF1vQk2D7QF5lum8SstJhfSIbrLxy308C3VKx2re8jMGOBFzWfqqdG2I0FrxMqdTRInOSRNtbb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso84400005ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753039143; x=1753643943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8SLuQddmzuP2cZ8NG8v4gcEdsMfVVRurSpgt90oFhs=;
        b=NIgXAo/RLxac8SGBqyuosw2u4C9ObsCsCuzDjPT2AxzAzFWYCIHxFZmnZenxG6rgRH
         Eeo4woopp+W+lQRQIX+W/lm1sFsWEe2vdNLQ9hDLU3I5JocQ/fbM+3BSWKVptUgal89k
         QJE0ydg0N10g7UYTvaVlEZ4CAzSoDTFULnShjosYGNZFdZMxu4LInv1MxsP7cQ/I3t4W
         MwLgF5A5KVo4VMIkPPtoxfUgPYafcn7PKf+LJjTxJhOCQ9BwYXYMulz40toBBath4EyM
         f/RKUNonJETQYKvUgvVQY4MHu6EP5DwmXMKTkVuh55vTDkPymQQ1zGIYUhFELN+uII6D
         YO6g==
X-Forwarded-Encrypted: i=1; AJvYcCXl0GI1GbWlSWPs+Zui5c7q2Qtao0TWXWvvxjOGwVEpOD80EZiXW1cmppiBIP/PEP+fpiGuCzowxwWQ9Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtv+XbiG3mzS0QBmD+1dZFUyOIk4qREghegDYQ8DUoKE+Wg+BI
	r9nHWSwRfXuO7LPYUFPIc+dt1ADPKvImw+NwecJMD1uqh1buNO3yEI77oUgAwLxx7G2o0Sf3Sww
	oaxU3QVFKSM9Miz2+ADcAH3OYRd2gwThscYM4si7rxnlB+vKhSA1iBwEaDrQ=
X-Google-Smtp-Source: AGHT+IHUEHGbb1K9tPl/x0VXd051QPTbaul9g8Q9CEbZnpqU49syP8s07upj66fYqx72+o1caTSr8ZqheeYbvUoDj1cHpAnDxFwq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cb:b0:3dd:be49:9278 with SMTP id
 e9e14a558f8ab-3e2821ddae3mr182023245ab.0.1753039143001; Sun, 20 Jul 2025
 12:19:03 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:19:02 -0700
In-Reply-To: <d407c9f1-e625-4153-930f-6e44d82b32b5@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d4126.a70a0220.693ce.00d4.GAE@google.com>
Subject: Re: [syzbot] [kernel] KASAN: slab-use-after-free Read in io_poll_remove_entries
From: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, axboe@kernel.dk, gregkh@linuxfoundation.org, 
	hsweeten@visionengravers.com, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com

Tested on:

commit:         07fa9cad Merge tag 'x86-urgent-2025-07-20' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1086638c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa738a4418f051ee
dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a8cb82580000

Note: testing is done by a robot and is best-effort only.

