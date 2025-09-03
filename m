Return-Path: <linux-kernel+bounces-798008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434BCB41859
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239E03B277E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6302E3AEA;
	Wed,  3 Sep 2025 08:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA22DAFC3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887905; cv=none; b=m5YVhr+GzBCCu9bBLU96NREEkfrTjTJB/HVaEVyjSFb/OZekiHkMzhcbSnr5l+NJnKDoIsk9e1dbkMxTdfjj8PzXY4bV/ZHaR4AkXplc6KK1drtZWTVqrh9s/ThnbsvRnvxqYFQZKwsNzh7GCFr6LiE6988EeUH6c3IErMWJAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887905; c=relaxed/simple;
	bh=1SG2Pmpaf8XCeDosOyXRUhxymyY3tfFtwfGSFD1UtEI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K3/lDdWhKJu7pqYL3nJqj19KKBs3YQBWpydeTIOqGZhKSUkFROG7ALiaDnHlsrapBNlELg9J9IrjrsSDuTFxRs6TS/CN5fH0pZBiHJutCAc+Ov6okuGAsrerzS9NUTzqy352EJv6gEbbwKkpqqA+pPhk+vg3/2QX2CkLURvvHd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-887146211abso409734139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887903; x=1757492703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI0ka6O6ZS6blT+a3/AcHhRWBhKlrnjhBV+UJLK4OBE=;
        b=s0EpKhdI/oskpX75LZtCcYx7zJ4y7cW1q5cQaqykIRUj7ZlOUmMFD6FoH2WSpOK1zy
         73cCjdqe86wz+bHezmwZuVi2dYoWxyl49RpLTwNfmC+cX0b7xlGsCJcBGTcPcRnysJhV
         VRRBagzkfItnwNEKW4C1sarciCuvwenkbSWLtQTIyI8dwIRZ9hEgRuf4iSiSe7+/NHcR
         hWdDcWguij0JqSfzSWK61NziKnrMAnCIIMmNbCcr5uqyc+DHuUyyc2H/lD+9QO0jRUD2
         /oCYCVwAGjPHZzBoItEhVLAPmnJl8lE/YSsn0MkXUYtgFAOLuJ5AqfvA0OLXF9lvlq65
         X3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVIGknn07+fuBU3ZDO80HStRrHUscg0B64nPEb1OhqTq6BylV2KCz1vMetKETyrq1RCEcnsr/0+6JHs2Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnPq36ZBIzxpmAeqhqn3sRgconXndJKCebaltoDk8OUhOQQ6P
	QWFViRcZAgNcN6BZdVdKirePUMARovJEDRKI/gU0BKKqggsXVpif0JqJgwADlt+GBZS68B5/bIR
	d+NCkoTc/xxYQNpmthi/Hlp2ZqBLZU1sFFuRvVdb3xdOMJGCzJ/LOLsBPopg=
X-Google-Smtp-Source: AGHT+IGw3/FCe5XaNbRj5L4aNHsUUDVQqUKVxCY/To4aco3gEMJZwKJi96fGvmuJsIbqcZFcKjOTt0PRcPYV+B28fNUW+0y8/NUQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b19:b0:887:1781:ce6b with SMTP id
 ca18e2360f4ac-8871f49957dmr2405010139f.11.1756887902950; Wed, 03 Sep 2025
 01:25:02 -0700 (PDT)
Date: Wed, 03 Sep 2025 01:25:02 -0700
In-Reply-To: <aLfal0B4HnWJVWz1@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b7fb5e.050a0220.3db4df.01e8.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_trans_alloc
From: syzbot <syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com>
To: cem@kernel.org, hch@infradead.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com
Tested-by: syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com

Tested on:

commit:         e6b9dce0 Merge tag 'sound-6.17-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145aee62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39f8a155475bc42d
dashboard link: https://syzkaller.appspot.com/bug?extid=ab02e4744b96de7d3499
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

