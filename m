Return-Path: <linux-kernel+bounces-866504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41874BFFF16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2796188C49F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1527301008;
	Thu, 23 Oct 2025 08:33:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588223009FC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208387; cv=none; b=crE4jTRaenQYPqDldXjr3EuFuQfOy9aj8xdyg+xqXU8DEwPPCCeRkfH3FpU6GN8FafYg4++FIl2yCT8p8AP5e487ED7SVtwRqaphWItf09PRIdQ8GWvclf0UGqO73hAjpdbTC/5mfdzBibWjk6uaRqoEOm1qYNYEg9Wo88+WVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208387; c=relaxed/simple;
	bh=jva66kR4NZ3M1ov3McIzikQzcfgbDJM7ZZ0MaSesmb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KJ1k8ebeLiLq+Oi6hEjXdFgnTzk4f5MEPDO1iSL5KmS65amSbvKodd8KVCt73eT0GLd9hz6BvATALO481AqR4FXzfHRP000mmJ4VzAuAcun9gwARA4qIrZvC7016UslRqvpaQOC3LJks55fw/2jsJYQmsyX8rC1Z35N/M87PM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430e1a4a129so7652895ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208383; x=1761813183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo0duX95EeaqTX/n7Bu28C+Uf1XrNKZNf+CW/BIermM=;
        b=UffUWoNvMigfz6T/r9L6ru3I4boyHvmam4Zl0BK2jsX5cw1dI6rtJU1uHqPyQBMs8v
         S2hZAP/5LpsvD9s1puQfiIQWOgx6A3XmUKrC8PVbHzUKM4T2lqnqzy2+g1au2IxryWUF
         8kzxnanczapEK8S9i4lzro8GyV2VJhkHBucQjs6+4MjktVs2CIZynqtZ+psn/d8b3luS
         FBu2wD1pW35l/xpbjHYShiUeEs/TEEGarVsbuBofO0IzzHRks0Uun7uHBwa+mnHq7ftA
         AVZmkthvgELfon7sA5YTUPvhW9DaaQYHExtEdv3z95Rpqnt7VOUXjja5pMK1Qd/jV0K6
         xWzw==
X-Forwarded-Encrypted: i=1; AJvYcCUgUbOkxIcM09cIyhSCm9RWRw7+/eMAteC4p9sAFDDrn8XTICxqu3vPZf4tVOGXRhhjc0KAFY25ety11ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRD2ez5Cppe9tGrvrWcX8nbfw2af3u6pieU+gJkiPAQTSmx1Ih
	YMdo/eqck+/Bil0c37Ey5RqXsZt7CHP0ciGOc/1brJtp6qjMzzQ3APhiIHFKmkTCgLAUuHNNlhb
	BEuX2hRZaNfPQu/NEhcorpFoasnODXYjcykW97R8k+WW35nQuwgAix4D9u1c=
X-Google-Smtp-Source: AGHT+IHF6OvyWR2tzTt/jUjGg88oGb6mphS+JUm7X2abQm9CNSmCy3hN5F5l/ZA2IncHZ0LBqfVoQfDH9qSN/LL0ssgazN6DQVXA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-430c528fc97mr317958155ab.27.1761208383281; Thu, 23 Oct 2025
 01:33:03 -0700 (PDT)
Date: Thu, 23 Oct 2025 01:33:03 -0700
In-Reply-To: <000000000000cb688206213d1bda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9e83f.a70a0220.3bf6c6.0035.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_fiemap
From: syzbot <syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, elic@nvidia.com, jasowang@redhat.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mark.tinguely@oracle.com, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 04100f775c2ea501927f508f17ad824ad1f23c8d
Author: Mark Tinguely <mark.tinguely@oracle.com>
Date:   Fri Aug 29 15:18:15 2025 +0000

    ocfs2: fix recursive semaphore deadlock in fiemap call

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13bead42580000
start commit:   c330cb607721 Merge tag 'i2c-for-6.17-rc3' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=ca440b457d21568f8021
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133b6c42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b9a862580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: fix recursive semaphore deadlock in fiemap call

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

