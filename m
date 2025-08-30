Return-Path: <linux-kernel+bounces-793135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14007B3CF1E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517183BBE32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287A258EF0;
	Sat, 30 Aug 2025 19:46:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CB230D14
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583165; cv=none; b=iPi6rXLZSPAk8gwgr86ft4WDRk+4ESHCRPRHi9UBhGAVasoTGlCQBvbasO+otH3hfj4rw9EepR6lvP31oMR/w/R2P6egksNI0m3R0GaiJvXNfRo0NQRGLxlPbgiKp7dCfTP814sjdtczfRD+/pzmLKAOceFg+687nbF7DPKJ+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583165; c=relaxed/simple;
	bh=G/NFYg/t2b9u07TWLk+8Ng6KzCACTuhSeDKr+awv8Fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lt/e+Z+BDyX09t/GkO5PvVlxX0dQQG/zVMTe8B3IdzQD1/PcASIcVv788rqI6blgfOLf2ilFIs1elYl0ciOUyGZgOwlu6n3Fy/nQSuL/gk3aDb7q3mAUjPwIpQ9xLHlxcFfEjzP8FX3tvx9L83fDFLODwxiCWB5J2vTsb/ItVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f29a0a7643so19318415ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583163; x=1757187963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr/bxMgdsQlwhIDx5QzIrgS9YnvAP9KAD6st5f1ma7I=;
        b=kg0ROX4MfhHrJ4GbbWKG16zRBTvDegGNiJpz1Q5QTtPzxUav8yG8hZfaSRMMtdQLSn
         PoMbZ3Pd1Uznwm+zIMUKDUWSdGPHxTe0gIEz2FX9EllYeOGIMMJWxESIL4weZZhu8+st
         U50WI0hNxfT138trln8C4IgenEgM4tQWNuDTZSJPEd8UKkLQ1or3G0t65POnTVhH/6Ca
         vHzvifYqBoHecWS6knRozeyhE0r1pCoUK6CCKicugEwO8kyEsc6bupdsUhYnRu/AMxu5
         Lt5jb0wTiN5SpcPyj/xLTXjOdi1K0WBv0/oJCOg9nDfZ7w57xUPv5XMeiwezP7cDvnjN
         8vXA==
X-Forwarded-Encrypted: i=1; AJvYcCV5YsBcH5rMU+d6tebJU0qmd1YNJsX/6zuQlRIYCSiytGLnwlrE7Ict9D+60YYeMHGGGPIlSdwHBlEIkkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zpGFW0fMuyoOWq8FGKMq4qv5EsblmlKUSRgkPiS2eMi2sLMi
	zJ9uuKLcnZ7Vy6m+25Y48Zkt3mHpjNbuwadKdj1TVFpCEXOFPsFKo191LzaccQey9RCMqAhIV0d
	j6vMtwN+PHsJoHwFfNqxWF0RwdsY7JjVoTvDMKcrBY4hA455Gpke5vPsOSv4=
X-Google-Smtp-Source: AGHT+IHGaTfzO/zyPLqOmvIEPO7xXis3LlXehfK06+eJfhE92mW/MZrp99cxDnhBfZKSjcij9aQD4e4p33ZBKwVBhmkWy4l3OTrU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3ec:2275:244c with SMTP id
 e9e14a558f8ab-3f3fd18b3a2mr59459905ab.0.1756583163032; Sat, 30 Aug 2025
 12:46:03 -0700 (PDT)
Date: Sat, 30 Aug 2025 12:46:03 -0700
In-Reply-To: <5e4ppwjfwtg7ruzkgyyke6vwosiro3vj6wm4hic3sjwh5bu7la@fghymhrnubbo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b354fb.050a0220.3db4df.01ab.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
From: syzbot <syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com>
To: ipravdin.official@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com
Tested-by: syzbot+4ed6852d4da4606c93da@syzkaller.appspotmail.com

Tested on:

commit:         02925b3b Bluetooth: Fix use-after-free in l2cap_sock_c..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=110b8e34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6b2ceaf54a94b5e
dashboard link: https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ab2a62580000

Note: testing is done by a robot and is best-effort only.

