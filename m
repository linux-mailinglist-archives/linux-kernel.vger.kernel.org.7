Return-Path: <linux-kernel+bounces-839840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766CBB28A2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E192C1C57D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389773C465;
	Thu,  2 Oct 2025 05:30:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C5285C92
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759383006; cv=none; b=WY7/tejbFG5Z5OawTqdbDLlPQpM8Kj9Ay+aCv6N93Ds/EsIA3mgQFzPgpoFDPPCyJKNUsYo5QOIi/ue02MoSQVQvfPCBmmeVLwZsmJEqyaYXSx1J3TkOXozDxNoYgWCa1D0ekgUiJ892yzb5Vlv7GcXVqItpV9+7Q8Wy5Qdc+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759383006; c=relaxed/simple;
	bh=ke2jUq0QRh8ddOFYASa8nmd2CrwHwg/IDRmNUIrd01o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rYeG78LFOIhEVSo2OBAgYz8PY4rZfGq9vqyseMiSGptecT9fT07RE17U3R1Tk7xU3JulCgtU0jgv8aubEZmKnfh1+44nwweA+cDvDjnb4k8h0DSl+1dtL/5Hxvl1tWld0YS9gpdFzapNCcdVF0kgMD6yRltE9vjEoKuwEAHspws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so76508739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759383003; x=1759987803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPSl9IV75rUyg5ZZ7fKG3wImUSSyTfbsWmV9btdZEjA=;
        b=XhAcUG7hu2q5zj+MyfLTdIDsjdDFgTUJBaLK0TvAkXLeoh6ETbRK2SfUZpjCCnMahn
         wW3O50jCs+WsYjplZJPit3msFdvwJm0Gg84u3xbTbOmOujWc/JcFIs0iIaRu3kO1idV2
         8tXolS4CSoumR3ocBDgVKubfCy9calqTD4ZB6VkkKBXS+Vhewi/ZPV8Nx+0NzPCvmQlD
         QKVAlAp9trU6vg7sjP0sfI4PqY4z1IVRJhHEGWsWoqdzaZAF13JmtiAFS6bHFG9108Nt
         iewz6NrYf2J8TQvXblNdl0/ire3Yic/GXsnJguYKXYwoLEdU3bfvEk1YVn/Nva4ZxgY0
         7B7g==
X-Forwarded-Encrypted: i=1; AJvYcCVe2BlidhFHrCEQVqkXN6yOBb6S3HVpfkUt3Eqj4nHTjkc9Q9Q7wVD5KO6ZC5nibZDmIWXrKscndQrsi6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbxzfHSb2QyFuAlvOC46IcIdyB/yiV2tNYb8TDSSh80wHF1Uv
	8X+mBgYAdlUq0l0lmb9f4DciCtdxd/+rppyezxO1UvudxD+R5pcp7W4WuPRpnfdnABNhYbdRF65
	aoX1b7FvJq8HdN+Wo7JGIrlEV6t8IKKPaziIcI3hNFQU8jSMiUK+nbkQcyOo=
X-Google-Smtp-Source: AGHT+IH5p10H99EGr58mLovCRuhteUEiVuwmb6UYuqC538qKfGAk10ZXhKcV8xBWaXwbI0Rt/9mRe+7lP86/TcQiTfr4i86hxMac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150c:b0:928:c6cc:3b1a with SMTP id
 ca18e2360f4ac-937afb06607mr818954939f.18.1759383003492; Wed, 01 Oct 2025
 22:30:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 22:30:03 -0700
In-Reply-To: <20251002050906.2082433-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de0ddb.050a0220.25d7ab.077e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a12092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0364a9e4a291ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d256e2580000

Note: testing is done by a robot and is best-effort only.

