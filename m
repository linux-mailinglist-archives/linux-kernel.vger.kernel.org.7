Return-Path: <linux-kernel+bounces-794777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9423B3E713
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CD93B98A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C46341AAA;
	Mon,  1 Sep 2025 14:28:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF3341668
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736888; cv=none; b=ECDCI5xaNyx1BLw6Z4eXZ/Tx7gL5ckojcVdDiRJSCvu1fhXthiAOUKalYfJmlnM7B4ASrdIaWgpDDcJ+t1gNWkTRZd0P5jiwtv63Ib3nv1gz6UFL5V5nEVFeqUJsyC82HkcT6Y7LdY9QZ0FzAUO9oU3PsJv46sNrBOzrrAOSxZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736888; c=relaxed/simple;
	bh=SswYK8NK8/NBuIlxZPEINe8a01YkBoblyh0FZHT5vFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s8js7fyQhSS5YK83u+O6YSQmTaqjZUZgyNBtezZP7jbfQAnaM6M47Up0X2hjU3F3NWeUVBuTAgIIW/TOzfFOWsJmE6I8mVsyeVohJEPswbxfVlTeQPTMaTDyQBY+4o2BmHRALPZe9Fs7d5zE8Gv7v257zXJd9mUHturMsYAXMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88717723bc0so268005239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736886; x=1757341686;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzoS/rFpWfbjyEKOrpfdLItOmctXoSuOQ4sdGnPwuk8=;
        b=mJMF6cQ6fAb27f6ji5AQHXLpMZeavX27LOUMOwBZDlu5Z1Chn4NfGxiQcpRtT7jSIc
         T5oP+WK/RhsxrD28AqL2ccsNZgp0B4cyv2JjiTOAqX1z/yjrGrYNL2WK1W7sagsE8RBy
         DwBSMSIZBE2Q439W1Ux41P16P22m7TvmCAMb9H9G/vvdi//a0eeZl5QPxOQIkPA8S1l0
         +izhdhmBQ0OY0hI+XPUKW+QSDitnHvhT4GpnAO/NbwFp7E1uArfsW16V61WIeHiMpoBF
         RdITBSdRDkTq2UtTGF1bbwWLCeg2JQgTf8wyj97Qg8+y+V9VUjvIAlQw7/8qVJ89hbR6
         3N+w==
X-Forwarded-Encrypted: i=1; AJvYcCWgU/ohuX03b8QLDMZWetBcFPzAXxOuzdBHQSRQ0DkdxesuShsuTUpPvfNUOcj9D4d95f9e9YSKTRoPpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMeTqTW3tSwYvmH8nNiGfaT3kEWNIgpy6e765n+1+NmqIQSOW
	RHpwd5gDnkoiFLEJt7D3nRfi0m8/ZdHcqzHr7slBCRhEQABP6jQqR1LkFGagFmB03ZR4wJwfWEl
	rztqhhzb+0lsNETINB08LEB+JPhBIRHdyDiOP9fGZZpCiasnXFjjLerzpi24=
X-Google-Smtp-Source: AGHT+IEiesIfDRZe1XchjiZ7FWywLU9bIPuEeclcfhByJXEa2ihgbeBdxEOAoCYTZVWipvfw4VMuDkEPiCeKFq7XWlsmXrNjYa8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3f3:cd20:d7e4 with SMTP id
 e9e14a558f8ab-3f3ffda2be4mr162622435ab.1.1756736886309; Mon, 01 Sep 2025
 07:28:06 -0700 (PDT)
Date: Mon, 01 Sep 2025 07:28:06 -0700
In-Reply-To: <68721d9e.a00a0220.26a83e.0074.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b5ad76.050a0220.3db4df.01c1.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __bch2_trans_commit (3)
From: syzbot <syzbot+b6ef9edaba01d5b4e43f@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d0855e210675b8018f4e89ca77cbfa133bce3a71
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Dec 12 09:03:32 2024 +0000

    bcachefs: Kill snapshot_t->equiv

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f2e242580000
start commit:   c330cb607721 Merge tag 'i2c-for-6.17-rc3' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f2e242580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f2e242580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ef9edaba01d5b4e43f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163eac42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136c1862580000

Reported-by: syzbot+b6ef9edaba01d5b4e43f@syzkaller.appspotmail.com
Fixes: d0855e210675 ("bcachefs: Kill snapshot_t->equiv")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

