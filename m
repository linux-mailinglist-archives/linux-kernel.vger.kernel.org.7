Return-Path: <linux-kernel+bounces-868141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA0C0475B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6A7C4E3022
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138120468D;
	Fri, 24 Oct 2025 06:15:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A526CE1E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286506; cv=none; b=NZiXUDAU9rhQpP6t97DBoxEjYOpyhgUjHYseV3RNKiVThaQoonsEA03kO7JIpJGMOYsLbAmmGSYq+l4cebREmq48/ynOToJELHzUr0PPElNxqHxrHZ/u8PYZ7gXPZgaeEOfu1YbgeL+Qj8/rKjlgI5B9O5pygzepkZ5VqUiGOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286506; c=relaxed/simple;
	bh=PlYC9Y2rsT1nOUWBFhwWoCZZT2QzHnsRz6hCh225mcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NEKJUnKblapZKfiZ8XxPZm1Bs8CaS3/I1nLIpPRoh9ZKlrKC48LRYzNb5+p1n2E7v9dEYiAyZHtpIccbootWWHCcF+EVaqcMVC71HGpqzy3G/bE1keSEBz/g64La8qJMWzN6TodarvyK+dwim62tvUwLHttKVzVRZJk42TiTQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940e4cf730aso472515739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286502; x=1761891302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CrCdCycFuQycYMA3WoSKuZjQldBlK8LrRCDJfBsvv9I=;
        b=apZ89aZZG/dhdcTfQuBkhZCUkNmA3tmuPv2mE2XQs1A2Xs43oApXQNQCjnMURT4AbI
         toJ9WG7jiXnlWgSoxQ2/zx5DRoEWRkQXAn6g4iDFglEi2WgYVrnAipyG2KvMKG3laaim
         wL43flCh27Kno/WJgxaxRjUNV6amci3Td3U69CBlhCj6Iple+zTibU78b8yF2CMk4fnp
         as+eqpIcRStKOY6XzNfbXQSVfI3aVDnotfVtw/5kmlUNpGqt8wZ5x8pVZuqg9DMSp5pK
         jO6P3KrZRRN5I4lw5RnaTNt7rFQTJOvngfPtXYEvaZGMNscuJeu70slgEE1GqzeJKFvd
         jTNw==
X-Forwarded-Encrypted: i=1; AJvYcCUm1aKOLPISBqar9I/9qKCSI9YGirbHtjS98GAoWyDpHSgq0imyhJozaeW4LSY0YeoETbhxa8IldM/hETc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMubOqfM3s+41e7EWI1ajAzKJ1vLNM7+rOZijcYaF5w5YX8rL3
	RCSDI2DxTeWgU8+iOiGim6hXcLOLCqNbHC13+4OvvrsdqbQ7V6+LV8C+D8UDJTUPhWSfbu1Ghn7
	jNKxU2F+z70M82xvKVGwUnjFcoByuI62eeJJH8MNK7GstJD+ED+Jl5PICV/A=
X-Google-Smtp-Source: AGHT+IHK4/0DJUb5fr7uNBIahozKYDiqOoq5eMeuCInZlkg17u5HX6X0T6DQB2yi5+29rTquc9Tc4D0IascxtvB3+NM8qfXMPTrV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1355:b0:892:6e7e:c59c with SMTP id
 ca18e2360f4ac-93e764a8547mr4673673839f.19.1761286502311; Thu, 23 Oct 2025
 23:15:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:15:02 -0700
In-Reply-To: <68fa7a22.a70a0220.3bf6c6.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb1966.050a0220.346f24.0093.GAE@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
To: david@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tabba@google.com, xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d1e54dd08f163a9021433020d16a8f8f70ddc41c
Author: Fuad Tabba <tabba@google.com>
Date:   Tue Jul 29 22:54:40 2025 +0000

    KVM: x86: Enable KVM_GUEST_MEMFD for all 64-bit builds

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a663cd980000
start commit:   43e9ad0c55a3 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11a663cd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a663cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173ecd2f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14bc2be2580000

Reported-by: syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com
Fixes: d1e54dd08f16 ("KVM: x86: Enable KVM_GUEST_MEMFD for all 64-bit builds")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

