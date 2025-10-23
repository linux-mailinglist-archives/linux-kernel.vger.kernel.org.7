Return-Path: <linux-kernel+bounces-867138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B24C019FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 380BC35A54C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA431985B;
	Thu, 23 Oct 2025 14:05:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA70DF76
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228307; cv=none; b=EJ010/IJsemIPXtegurc96FiuA1hsEgB6AM6bpHjukn+sv2TUPFLv8wPO/H5Z/6uv2PvdCd/+k7T1iI09KejeX7RY30SzLJ/sc0tir+Dljwe5uhCQRhpvX4fTlAQSUETF+4knWAgP+lsXS8hKD2xRpO2lC5zCCZLPW5lEcrVwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228307; c=relaxed/simple;
	bh=cAo/RJq7kUCbCMczRr3hlMUrJ4hya4KXVZZZcQlEeEc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DYKoiyowERceYKMSosLPk1/1dirHc+glRa1K2ht4bcgmxR89zUbovOoWheUjlbd0utsHg/XD+8YhYuArFW0FlbinimcW4tHa7iJQ4yvFwyP/RXbd/LUfdMPCo1KdXKFHbcXokpX7W4DMaGuBeTkTk8jfsXZv+ytom11PtJ5MCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c523ce49so10726955ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228305; x=1761833105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXmNaFymxGFoxGVFokAYpt74bw0lr2M1HEFPuRrsYmU=;
        b=NjYO4OBK84Fx4IdhwWuqWaTMzqMi4FeY38CB4+T/W/B/YsgW07mQrMhRGhpc7M9VhJ
         /6IK5Tbgt/bWIxrTeEvdkPQ9IDWd45ALs4xplhbdMLB59zmRxtH6A+GTofKL6QzGVWHM
         +plJIqzq9IBjKu8v1AErgVcusR7GJHMi0Ldx3kB5Lknyn+YLtZ+xLw8F/NWQ3Lqxpork
         pQEbU30MCoh+fKYyOZ/2JNbCMIiR1TBB6oIB9mVICsHtOBNNibAkU78YIrUVlTQ/VYFE
         J29xoI3C5R4+M/eNc8ruGNEtFXE2v9v4Wj8J02DklrFf4avM0H76CW11wIm6TIph2TMp
         mqGw==
X-Gm-Message-State: AOJu0YxIxqQpHukdX/zoN+SyKC+K+gKhl+LhDmf6jJoO6R9LQw3XEhRX
	fA10mgVcxdapSNxjGeI/mZrtNbVKoU35y+0SthMNkIoTWyDKlNuJICJFaFzdu8I4FLiGSJX/YvG
	PPoA/OxB7Ejk3LL3M5E6eAriTBohjFAbXrLnDd/7rUgCOWcJ+I1vZLwczxNU=
X-Google-Smtp-Source: AGHT+IFr+BdzLZyXiY2PmBZ1lnAQYjzo3Cg6nwEaj1bmRSSsoEzS1Jh3HmgeJeq262pKQyiDgQt/fWA/scceKWR/z5QUyNUXPh2Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:42f:991f:60a9 with SMTP id
 e9e14a558f8ab-430c51eb3e6mr285036265ab.7.1761228305588; Thu, 23 Oct 2025
 07:05:05 -0700 (PDT)
Date: Thu, 23 Oct 2025 07:05:05 -0700
In-Reply-To: <20251023134612.396121-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa3611.050a0220.346f24.007d.GAE@google.com>
Subject: Re: [syzbot] [comedi?] general protection fault in pcl818_ai_cancel
From: syzbot <syzbot+fce5d9d5bd067d6fbe9b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers


Tested on:

commit:         efb26a23 Add linux-next specific files for 20251023
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=569c5a67fe7b33e7
dashboard link: https://syzkaller.appspot.com/bug?extid=fce5d9d5bd067d6fbe9b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e8c614580000


