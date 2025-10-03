Return-Path: <linux-kernel+bounces-841533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9ACBB79BF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E5A4864BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9632D2387;
	Fri,  3 Oct 2025 16:52:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5292BDC33
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510325; cv=none; b=JNX1GTes7EYUGTpucDtRAmAjjbenyYDO0lhXVIJSswx86hpb0ipmYtoN8ieGGlsGVUKCaObZ0Qw2pESmqcSHTe63hnLx4afOs5mb5khQp8hRev398I7qqzo0x8IZ7XShi0enVJuZAY2ix2GodWGqgwORPN9JEMzI9i2iB+QBLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510325; c=relaxed/simple;
	bh=JTaA8zjQAbMQ+/VFUovnfJxIi02YH2pRK1a/Jzh+wRg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NYnygIxzQqW+T0rX1csRNig8q7DiVWaF0iuiVy0DF9cmcr/37tcMQJWWvlXUDbBQ3PVxqEsZK4/ERzesECYdO7JDq7Z0OQ/twY5lh07GPH8WzZSgsH2IVXT1F30uOkp+93nwhSkhkwnTkQls3TFwdMEqloZCH4EVRUHqz5+I0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42d85031919so34400925ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510323; x=1760115123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKNPnLewPI4iofJmzNCWaRuSIl2pCIXr8sLsxWgGvvg=;
        b=VRkvxuGFG27wupHxV4lJ0nxuF4EGTX8ugQRESWXApK6IkM/sisMH3rMAnp9zzZEhAe
         OIGDWmg7a/Gqr0cktXA6fHIrn0Bn6Tjh3RbnP8+bpfqnJI7W+1PwkpxwnjfgCLFQ/v0x
         a4ibhQ0yieldc0EVwR5qlivPNIx/tGKLXJq1dRU31GkUJuF6bwLQaW6u8pvX+gic8HCp
         abgJybg5N9/Arp0A1lmp7gfwgy2Ound4DGM/9qGSLfxvQypKegXKtCt/RQzKh/HdG/Rs
         pjDKlhYrMB31XFsgLdvauU5HZM5tVppT4sNJOVrmqUBNGPMubvgsczFDoY/c0kOtDrHW
         pX0A==
X-Forwarded-Encrypted: i=1; AJvYcCVARUj+iFaVGUU7RD6QXUEGmeoUOq2Ba1vJS8AiWU8lyUVfctxxJot6qHU26zNatA/WXbOKlXXsg7sDU7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywntnzz+sn6x/Wxl+VcR4HUBedkQy4ijqNMgcdI7iwhzn4PbBbX
	7J6jM02oSfH8i6j5nt85vSJbhUdSPpmXViyNK04A+LykA2/CDKoSbLYmjIO0lU01ZDfpklkQirp
	22WWTkThFEUaAFHIhqGC8OYEiSGqhjyJdgEJXphUDytEDUk9mZktECfzTBMk=
X-Google-Smtp-Source: AGHT+IGyMt3kN5JcEi9YY4nqLAsT/n9PYISoq6h+V8MeG/SfU1V8Cix+jyrva6LJ5/WN/CygxsDCwi5O41t6twqA8t26AKb7bHu3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-42e7ad336d6mr52290985ab.13.1759510322880; Fri, 03 Oct 2025
 09:52:02 -0700 (PDT)
Date: Fri, 03 Oct 2025 09:52:02 -0700
In-Reply-To: <20251003161140.2960355-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dfff32.050a0220.2c17c1.0025.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: broonie@kernel.org, kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         47a8d4b8 Add linux-next specific files for 20251003
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b765cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5cc2d3410fac6d84
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cb9334580000

Note: testing is done by a robot and is best-effort only.

