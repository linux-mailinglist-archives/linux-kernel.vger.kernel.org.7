Return-Path: <linux-kernel+bounces-825494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD7B8BF3F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56CA7E34A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B222D7B9;
	Sat, 20 Sep 2025 04:37:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2684E1F130B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758343028; cv=none; b=Cj7L3talTmGigm8tPdUeKTn7duz/SXTFWdriaSAwtZyfTiVo9munhzaDTO0wEeiqp1c8VzEYK/mXoqiEkzlpiugVCfzrWJ7g1aSHNzHysfg1bOvI401yiwvLfzqwrYJbtEPZL7j6npUry12I7qowD1nUjBYtQJmm7KFkJxE0t+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758343028; c=relaxed/simple;
	bh=eLZJJ4b5Hv13WnuF/je/2Gc/GJOLCP6cLSLyncvNLdA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H7BjjeyxdmsP7H2oJhnGh5ab0F/7/rO4DJaHemkwKfDBa/DV4a0J0Coa3Jb0wtd1lTZDSLOTCJhcsMcRaQ/MgvAvKt7j3g1fRkPDy/x1EjXNXyqy5br5K/nUgVXntpzqFr8iJoHe3ana0atmZK/kulFkqoHJhds3hbhfHXFun60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4248d44a345so3447235ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758343026; x=1758947826;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gja0G+YNMT4nfkxekGzUizab20nltKnqLeo3HZHwrLU=;
        b=HiVNX49Nz/wh7/AMbrEw7IuD65cQWsXC+RNCiByo+pYdjfsUHC5jff3qpvz1+DL/MF
         sCKWw53S06LsBGogVgJ4KiqYn4fnkqe+Jybz+Zy5g8fVffkstz6MWdRu0VeybDhpHts+
         LAG494TAW2JJt0OgS9LFYpwUDZwQK1Ht0HxO6K85aym20f8cnydB8y162CFFVvGjRE/0
         vlG8bWqQRugsZ3UrDbY565/kWwi7q24Y1254HWRLA608LDj4jFsr7zPGXcCZVErNM5Zx
         uUlbNsw0skilrqUU1DVu9C4W+JYIlksDyWjDZDNHE92hJedC+QCNJtY8dK0QmJzMnsA7
         hbpA==
X-Forwarded-Encrypted: i=1; AJvYcCWHuFA4tpQ/ZH1bxJjDOOVDfkAs9AIJBjLBROjf5bEcGe/i1ALiQDHE19ru8m7qM8p6E2Im9ZnwaaxtvTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIaLTBEsh4uvqwKPHIawgTEUlOkaipl3Cr+CBiUWhZIY0dUqca
	MAcildLMv0R15Ma4jzBq7h7kkQhRx7OhQobeNXLlkX9PBFDFIBI6C7Qm1CRiw24M8peKW9OfDji
	GRCtL1yzSlMZgg4ZYXCDcbAUNw7TCPrzEFepH0MnZsBkGzIn7AbJ7MAs8438=
X-Google-Smtp-Source: AGHT+IEboJPHmu/GmGIV1HX2yNQ77XkVwCngjKU9vicDDz+MZ7u0oRXuv26/XZA4q8RUdEr6/vmWleC4YNydH6JYZXyh1b78jOd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:424:2d4:585e with SMTP id
 e9e14a558f8ab-424818f920bmr87191575ab.1.1758343026440; Fri, 19 Sep 2025
 21:37:06 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:37:06 -0700
In-Reply-To: <0ca2c567-b311-4f0b-bb29-2b860b75f85e@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce2f72.050a0220.13cd81.000f.GAE@google.com>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
From: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wangliang74@huawei.com, wenjia@linux.ibm.com, 
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc.h
Hunk #1 FAILED at 285.
1 out of 1 hunk FAILED



Tested on:

commit:         cd89d487 Merge tag '6.17-rc6-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1381a0e2580000


