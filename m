Return-Path: <linux-kernel+bounces-872840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1770EC12272
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1CC3B3A53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75261A9B46;
	Tue, 28 Oct 2025 00:17:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F41A5B84
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610624; cv=none; b=AXK2YpKZAYrZf54zumLlN17+ndescJ8OdBIEG6hAUGwNK/e7Pxc5nNu1gaZZYv6roMxy0UlNkOiAASQU6VSJBkmh74OcRwwWKsuSe+CP9sUrozzHhL8iX+kWP94IW5CTqt/VoNqmu9kXSEQN5IwhPXzNk4P6RWom4GCwedEvI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610624; c=relaxed/simple;
	bh=w8vq3OdCE3yx3J6crNdLW2+Hbc2+4qtG5alt131P2fg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u7MCDTwPuJ9k8pr/Gat9jJwSGefRM9OvFTfgFcMKLNAcl/vEmdzkscROoAY99knX82mrL6fQZnWzeEbdvgXmWQDzhXOqRS2kyjv7Lxr3ahUWxq0/pz8E+OHemfQ0OXN3nCu5gVOH+Rb0Xx2jZyoTceXRG6whXKF3tPFRzT6ATrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431f20be851so37425245ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610622; x=1762215422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+BxjPTeay4IQJxgholECUU0/b+Vf640R7FfR9OqLCc=;
        b=n9dgGZ9GSaZ8jACZbUnk7m6i4fNMcTCde1n+0KsSevqv39jYrs2+mXoX3hhMHLKMz2
         rN6uIkfl85xVyodlyDsW8a/2Y0M/oWrMPVyDlJ5mAt6ELnYX5EKKtxjKh7+AvSq4e15K
         Vgsbjy5w/k7Jer9ywBjDsjCMtEmj7JVtqQZAe1VpVBc1QAsctiMsKgTXIR9PoVSSyfwe
         XPWDtZ+YPDUCsl3vOsLIeA6ELR0K1SzOlqWjcS4lDhY7MvoB14zo35WnzYRxqFH28YGe
         8VP90hMpio9nzhuJQxaGiBEnfODWzotOfUKQmSWI91X9Zl2KCz7B+VmTaSGqmoD5U034
         AMUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKmVNQHzbCcyZrzcSKYsxzYmIH/442zpOesb1sExp3NXCSPepvlbxemjuSRz/F8WZEqhnyC+Ro71RvF7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgmF/IMr+8iG9m7a5n+dXAem4bK+fN/rFBrWDnSL/0Vbi88/K
	Wz7q/S2akMr8qZ+anjbrkPiCmF7n5tEazwEHd50+91GUI5plQ+ZSVbv3xziPM8H1wuE6bROc/dR
	9eAGYxDX33uDCrPTHbYDQuJTmerNLOkKHkkN7oluY0OMEZfyrYEZGUqZ7Z/M=
X-Google-Smtp-Source: AGHT+IHdV4hJ9MsxTO9lThudEXMeDmJmS7gRscZENNGnQ8fX706qkGKCmrQ9S9unumIWqysBZZuolAbCiElvh75tp3uFtbmW5NhR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:430:cfe4:6e61 with SMTP id
 e9e14a558f8ab-4320f7dcd73mr30898485ab.14.1761610622187; Mon, 27 Oct 2025
 17:17:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:17:02 -0700
In-Reply-To: <z742ziobbolobstu2ljazsv3hkp27pdpfghrtzj3vfr46w2v2s@jqdpqtdgy5qn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69000b7e.050a0220.17b81f.0004.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in raw_alloc_io_data
From: syzbot <syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	krishnagopi487@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com
Tested-by: syzbot+a894fe5447d0543e89c9@syzkaller.appspotmail.com

Tested on:

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1077d614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
dashboard link: https://syzkaller.appspot.com/bug?extid=a894fe5447d0543e89c9
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127b9e7c580000

Note: testing is done by a robot and is best-effort only.

