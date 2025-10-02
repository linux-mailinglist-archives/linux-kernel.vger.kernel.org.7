Return-Path: <linux-kernel+bounces-839871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59568BB29DE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6D964E0300
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60F2857E6;
	Thu,  2 Oct 2025 06:26:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98F284880
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386364; cv=none; b=M0dTpg3q13dwYZHsMO+Vz8kD16JxMM01Rn3c3jt9nsRxe7PBL7C2gEqdNo4kf23IIa/RUBRFQrApeI+Jg21PP3F+TVsyTOxzFFMAupaxjzwRoLwWuYelzh3IQvpyS7g7u9XVXP4P8JiZ3Ua/640b0kOmf1YHShTTK+2ns7P8XEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386364; c=relaxed/simple;
	bh=pgLV0bE1H8CBgh0ADFB4mGXCCcffd2/D6JAd63iKvuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fldOY/OB9pgO8ZigNMRm6k2p2EmguQX6/b18+E5286uSbgeFPHNLZ02wjaanOSvgkFLztW9+9gWax2K6QEeR0vZ2SAutFeEFAsH9QALRiBgqCrPhpAK7KfK0o0+RI4DfGOopmQuMkB4DiFJ0aSwElyJyHgresPvHrHd/EfXJhWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-425745467d1so9628275ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759386362; x=1759991162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6poAbfoeRFY4vBnVRtx5TelJXI8BZwUEby3bNwlA1Fc=;
        b=iEsN9/GZHabh5z8Z9YK7Yxg6FU9WBGtp2ArseofSiTxqqZFd41YsPBzKCTiaTAXm1L
         Czr2y2OrZOb4wvlNhvRsuKYDHLoudFngJY70dbqhKKp+twNPMNzjBJEwq5zLbkL/BeE/
         xxs5vq7ik3ufZ7tZwUg+peDQw9MutL0FYuNMoFHXiIh0SOtVXIalQgC39demDdJOHMLZ
         8Qru0E5mNMLvgihONMiVWHU2Cki823tdrMJa7ohhHlqLSvngHGnPOh4GaUrcea6lvAqr
         dvLhekTLURfl6c3G1JtR0JX65LYuiGRoL3t+4/Kn0je/wmvxTB8PITbvZiagm8XTM8Ma
         Adbg==
X-Forwarded-Encrypted: i=1; AJvYcCUEu13RRyFHBsgRFKY5Ob1g6f0iz/93dXGhCRvnj0oPPH0vDB3/5l4pe7x022nZ/unv3CXNx4QKHFD5eQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYAnCp2USjbC9Quazxe0VxrENPgUZ5NU5ULsJMw6IEeXcRqEZ
	kOclc4nENckPsmYjbTvKgCTGHNVnyyXeGxXlyTuD6n6fULGWvWhJwgANpaF2qZfSwX7uNAbSCqT
	OqodFlRrEYTUVKPPFEDtp46gtgn6cmu18D2/TpIf1rNoYEFnVyuk/rfUV/Ig=
X-Google-Smtp-Source: AGHT+IGF7E1s52ZDcuQHmgS5l0NDmvxZ8ZioJDYEerGV0eJcZ0TXw13XDEqHoWgDqKau8IC/q1NYsN2U16qKnWSsUDGpJ+wpQtEk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:42e:5655:f54d with SMTP id
 e9e14a558f8ab-42e5655f6e8mr3945645ab.22.1759386361806; Wed, 01 Oct 2025
 23:26:01 -0700 (PDT)
Date: Wed, 01 Oct 2025 23:26:01 -0700
In-Reply-To: <20251002061821.2163863-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de1af9.a00a0220.102ee.007c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ext4/xattr.c:255:35: error: use of undeclared identifier 'EXT4_XATTR_SYSTEM_DATA'
fs/ext4/xattr.c:256:30: error: use of undeclared identifier 'EXT4_XATTR_SYSTEM_DATA'


Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159a56e2580000


