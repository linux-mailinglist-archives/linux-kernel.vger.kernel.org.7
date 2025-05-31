Return-Path: <linux-kernel+bounces-669172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98DAC9BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B2617C800
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB1188580;
	Sat, 31 May 2025 16:20:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688222094
	for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748708404; cv=none; b=HfH4pGQG2kA4mD7tmTkNE7eQXCVcmmjU/0HXOxhS8L3mHI79de4kSmfQ+52uZEMsxq9D00uZUlRLG3blMnH4isILIPczTGzWGAp32Vrj5r0gXE8lL8HSZ0g1REHKhEa+jtlaQ/5mTTdLxf8IH/g/jiBxqFCBXnoNW7WYLqbXeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748708404; c=relaxed/simple;
	bh=sgPA9Q230YlwYNsgLsUAGT+EIJ3MJXCV8CkuV+njEC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h++K/4vpIsvYxikqgHRuSKSL0BaOQGLUGXCSsWkLQB3Eiq/92MlvaQXyNMwlvfLdB5/qZiUtnC1q916U6noZAfNnIkjUDcKI2mjjyLRZcVcwOY+JsN7HXhc8/HCfnTKA3WbX/Q8O+ncaNMufKhF6h2MV+yZaWBqhIorK4Thk9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dc9cd70437so37060045ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748708402; x=1749313202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOT3+3dtKmIMbjiKp4WKPYIYOuy19lzYdhT8ETpxuvo=;
        b=qVeGp8fJwHgX4Xc+8c0MNs9aM8bT/eVBzO0sTE9uUCKnRpK4qXzvWy09HalvurNBOp
         CXILtdgktLlxken89yQ7eNV33Zd6O661Edum5Aii0wLkyJfEDZpCJE1Xhib/F5mKXc53
         HlBYwtXWgIH9d8QfHQqVqMAxakhHb5JUiesmg+qXRRX7WOWwTsE400U8aQf07K48BdFa
         3x6LknYWySmfRb2DA1FdjlEYSeYpij0RUUKocw0PHX10g8bBIXz6CB/6dLGIHr9OAiFU
         zU2porlUtLuYRCAxHQVHoyNdlfeawqfexS5VaFq0D2foO3BP00Wgk6O1LOJjSRTiOc3H
         +Prg==
X-Forwarded-Encrypted: i=1; AJvYcCXSWM9uZJxxKeVYSvjFcQ3FFzunKOtgj2LG6De7rwoArmHxtK3/YTSnRN9aP4VrHikZOKLlMwwf5aGLXLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDSUHmQQ3OkgaOWwVlhVJGFlu4SwsU0zznlN7ZP2WPUf32dkR
	Ehit3DrVCGIkpi85j7gkX2Wsqd3D9dSfRQe3WMxLecrSwR8QTRG4OjRkxy1F4pME9RnZ1ZS9AP1
	Rai3kkyN/RE8cFQNWgqzYJDi1v+LQlmIv/YeytroHyJlvEV+/7YaT5mVrdvI=
X-Google-Smtp-Source: AGHT+IGdap3ueor/+dC4QVfuI3dEjhxnuRezgHUx4IFWYUjshQSu+2Ssy2m7Z8B44GaIOMUzHwVmDX58Z5+KnBdSnlu+zMS+qDxq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3dd:8a06:4db3 with SMTP id
 e9e14a558f8ab-3dda339232emr19169295ab.19.1748708401944; Sat, 31 May 2025
 09:20:01 -0700 (PDT)
Date: Sat, 31 May 2025 09:20:01 -0700
In-Reply-To: <000000000000ec1f6b061ba43f7d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683b2c31.a00a0220.d8eae.001b.GAE@google.com>
Subject: Re: [syzbot] [smc?] possible deadlock in smc_switch_to_fallback (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Apr 7 17:03:17 2025 +0000

    smc: Fix lockdep false-positive for IPPROTO_SMC.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13833ed4580000
start commit:   47e55e4b410f openvswitch: fix lockup on tx to unregisterin..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14832cb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e17218580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

