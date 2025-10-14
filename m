Return-Path: <linux-kernel+bounces-851774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24DABD737A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AC19A2242
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F642FFF89;
	Tue, 14 Oct 2025 04:06:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740D1DDC07
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760414765; cv=none; b=hmxUe4METbELcPwKBMPoOa6sn5jc3D8s7m/sDbWaDItUm8Z6UPdtiHpS92JmAWZ/+xWPCbfECU9qeRA2MDilFxxVw4hOrdQOUUcHt2ADdlfw1C4Ha3n7EqaEfURY11ItT3UyWYX9xflQ99p6OtxKJc2N5OVFKME8vGavg+JGzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760414765; c=relaxed/simple;
	bh=OroM/8kj8dR5L0NLdhbN5rndWj/tLeKmYi3o+MStWhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XTNJOyTzwWjawXG61eTyFYPY7lj2YaoymA+k97SZJGZphFd8+hkUT90JZ8F0+toMHIQfdxS5XXUJ5/ldogCFrpNs1nIllvS8REjsi6KRmiGDJPYwEBSM1O4KYLd5DyZA+0EWKiXq4+scaldnrDhtUCYkKJ89l8Mkxzho+BezJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8870219dce3so1336574739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760414763; x=1761019563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUyTgX+domK1yk43T3Cq9LReD+PYjdellEIFFdEmbz0=;
        b=R5QfrhucE855/F9BRMTrj/IwG9dQUVaASlD9lbVhS577NhrvKjaNCHM7X2I2+pT9WP
         kqD46X6ivqbhVUwl0mPHfSnpSPfAxxrXxLxOQaZgoH12BBXryyg3TTxbJ6I63THctJ8C
         7EU5prQN+OlyITwKs6Vu54pmi4ahQbmYIEnmKWL8H555WCPtXcM1qrKI1rErLmgAbuLd
         JepauPHcp0dks/QZUBBTGfX9UkSVIbhLs2mR/gsIzTeVT+EJLGdDcqE3TyjnmWXXZCfV
         VdMLRlqhxgTCbAD70AyY7dKfmuZvbLBYMiQC1S7bAUjqhvu+F1yh4rnJB4bN67HC8WdB
         dhiA==
X-Forwarded-Encrypted: i=1; AJvYcCWwFWMp02wl3YRpVDxNJljgZpAi5fEJDIZXQ478AjILalWN7fpKW7gCCYL6OWtpGeZsqEkWzcXDxclcmkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygPHP/QHuHMtAdHsjhWmGcG43USdN/Kjw3s4LNzaZ3sbhiMeLt
	d8bOS7XsUqGf+lWw/yDMNFrR1mxFuZlh/vf7lJZfOaHEYq1uKJoZ72OvhpX127yGYhWCuRkr/OR
	/2YgPVwrrQ4kS7v+H1tdZPy+krTztM6NMmt2+QJNA6hYTK8cJOBzWL+uTRkI=
X-Google-Smtp-Source: AGHT+IG+ZMoWC3sw1qnaX1TNiIV/6PJYdcgeSwnLealuKHS8EldcDmzxuA8Xoh+0NzFKVV6YKtnk4+9nsk/mg7MLJOdnTe7LDA1l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6a:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-42f9eb775f9mr127776135ab.28.1760414763167; Mon, 13 Oct 2025
 21:06:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 21:06:03 -0700
In-Reply-To: <tencent_5962EC9ACC0878E66EC82C456C109494EA0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edcc2b.050a0220.91a22.01f9.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KASAN: stack-out-of-bounds Read in exfat_nls_to_ucs2
From: syzbot <syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Tested-by: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16aae52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1921939e847e6e87
dashboard link: https://syzkaller.appspot.com/bug?extid=29934710e7fb9cb71f33
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e39542580000

Note: testing is done by a robot and is best-effort only.

