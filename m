Return-Path: <linux-kernel+bounces-869579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A24C08369
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5400C4E3EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7CB31327F;
	Fri, 24 Oct 2025 21:53:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C630DD0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342785; cv=none; b=rN8S08qoHEPVrxgHdsWQtaFcHztxXfIfLCnoiE30lW9yj+OnPwpG7iuOG27HCotI687s9X+eFGvmDnZFHNqwPVTrv4AO0YgyalyZsBeHN+HrOQxixTrJityPwK1YXe7QXH+L3/yJUEWkDpYMvAqCRaLeuMkHEVEMDw6t2vhCqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342785; c=relaxed/simple;
	bh=hG1yguwtXFyKFK5A7cjVzd7Kn+fpX1polzYbEg06J+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NyIekzpl1tca9jsjc3BQEKRAiA9yRUuyWK0t6ocwji+Zg6F1F7VAHBIEPu6Xw5rirXvQpV0nMPpylI+Vq4jJDTh3ls0AvPCS3q0LfQqnZmhxadKINq+n8ngpnlexYr9Peqh+g9qbHhXYv7pey1F3gvRfFxgOpTBoSJ0thcJi5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so421941439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342782; x=1761947582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWhDE48GzQw712Y17dRSw57HIFKrX8PNWMSQ77dbZHI=;
        b=m8347sNMS7+ObQDtTuOahyET2sKI3xlxDMEotTL92Kz+lUqskOshY6Vc+Y3BZeqei4
         +cGt92M5QGe6KerhBB41zvrz2RNk84ElHc0l+1Tljktn5KYonyliVfLIo+dJ9jQZXJ1I
         WCRhrgScqAxp0/PHy8iCwYHLJOdt5xiwQ8LaPILg/6uCREI5HUk5ydc1J5lSiAzfR1Ij
         OxFZYBDyDutkMG7lnVS82+vfiMnkBacyohQsQYNESMxMbikD87ONa4SCGQD8eNoCMrrE
         kVDNg14tHzCcs4p2LtupBBsRIdVINCn5jOGCfmVyb/I7aCKrRz5o7dvuh28MgGTpOwEp
         +G4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnXOnXvICe9rLKa+Hc+bgLjeimyWx4/c1i3Lk3n7Mvk+rDnz+UYedQgz22v8npcyv3UbiJ44pQiAeQT1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZ2qrz/xXwuicv45I17CWJAYVzxkn59Y7BYl5vbLjqJ2mBNVq
	y/6cSqjdCUCGCmDgBN45RLLI9KJA7GcnaRGLeX4HAEyl+ANtx0oR89MQ6pUnEykKBJcs5JhzJCF
	kyDHJKcM3NDfavgBecfSekxDBHYdq4NjyKzjlJF57z0C6sFhiNNMV3lPxjQw=
X-Google-Smtp-Source: AGHT+IFq36IZ6Z3PZMmB28gqWuDTTHdnm2VunQ0kdW1tVnwNMZt3Jxni2t1aE0nwLPmYTQ3QjSvcrjwdmNvI68H/pi2zs9YYQux3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:431:d3d3:4771 with SMTP id
 e9e14a558f8ab-431eb623d7fmr64866935ab.7.1761342782225; Fri, 24 Oct 2025
 14:53:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:53:02 -0700
In-Reply-To: <74a1dd31-b2b8-4393-82bc-274e3de62836@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbf53e.050a0220.346f24.0184.GAE@google.com>
Subject: Re: [syzbot] [dri?] WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: chintanlike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

Tested on:

commit:         d2818517 Merge tag 'block-6.18-20251023' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160ce3cd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6faef7d1a49b26de
dashboard link: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1603ed42580000

Note: testing is done by a robot and is best-effort only.

