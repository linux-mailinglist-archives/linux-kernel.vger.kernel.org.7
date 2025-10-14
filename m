Return-Path: <linux-kernel+bounces-851764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C98BD7334
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5B5405768
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21943074A9;
	Tue, 14 Oct 2025 03:40:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338D303A35
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413208; cv=none; b=pB2fQJng5AZFA+BkhOKM3P8sfDOb7fW+35BuY+w04gwluhV3qzhWOJbZ0H32h8BhIuFQk21gIdlJHRiSL6GjHoIFzwfmQNsAlU98BaoQ2HXsXlSs+2OW32BSdhYscvFpa+FIuEq2ukw0YPmK7+UCtYX2QP/ths3IwJmA2ShCdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413208; c=relaxed/simple;
	bh=vdrYUcCr6NuqyUs/413P07x6G7IAtoN91QqiuajyB4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fCJvuYfiqVmiHzEyEqofy1vhkNgfCyEkksBgd9ECHePaPPQXM26w4QD7xqjepem0YIEeZw9Efm0Lqxaw9j6K+ZCuQIFTgjZ1Bsy8Lijv9Tf/ac//uBvoduIoQNZPNvXT++Md0jLGw+xUqMSHhR3KJyHTdIXpuSfZK+bXSfDBw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so1176568439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413206; x=1761018006;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lix5vfoEiesZ1voF/iZrjE9lM/ENTU3pNlIEqFOVDL8=;
        b=QhOrx8G5nfKdwnGxd6ar5U4ffXewegyIxbgTZ+Wktku261I4f0Pw2wAe054PcbuYq2
         yJzipFatrN83lgqXgOdWY4pOfnlJKDGU59EDKDIQBHn4gAUnz442fYVTTOLuNrWxVkPA
         UKIclQTR1SLIQhJqtf8zKbMS9JRJVpqNrbopavIy/5bv+ugpmNn7zW9c6BzuEUdkTKov
         yCXZHE/FmI3i+1nhI8EGkoqig+qcGpXms+y23mgm+qaFj4riWu2I5ruxm3ysSVLsS4PL
         +87f+pYj7czaJFYxYcMoPAYshk5RPceCPrzejEzIR7HT/n1HHMQQihMx4004SjjOL76z
         3pUg==
X-Forwarded-Encrypted: i=1; AJvYcCWEEv0HF3BZP5M3Z/WSjiIqyDvhI/9+HDRACQKGb2anz1ceGeWvBOePqRCeVENnYois/+9VHW4XCbKSF90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH6Gd+XavJYqHRAcu1D1HdDuoNam5MwYkNvlR+FJzDiHhXNE6a
	NiIB/Pan9kctsHg7EFk56VXYU+7C13BMdNWtHsPVunPCqovFL0obvUKke78zgKQ/xujJfrUlo+H
	xqv+WhOx8gVxvRPyreA1D+FJ98KEOG3DWHqo66hb2D0Eck3m/YmO+0Dtbvh0=
X-Google-Smtp-Source: AGHT+IE9UGCKARQRk/Ds4KOh7au7ZW2aIvoCVF+9fMMqOnHpx9ZL3skNbdtGzQCj8D4WoGVHwtOfcZsN+RjEH8B/lAE1rnCfwpqV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:42d:8b25:47ed with SMTP id
 e9e14a558f8ab-42f8736d49amr253014265ab.6.1760413205999; Mon, 13 Oct 2025
 20:40:05 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:40:05 -0700
In-Reply-To: <20251014033532.344635-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edc615.050a0220.ac43.0085.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hugetlbfs/inode.c
Hunk #1 FAILED at 478.
Hunk #2 FAILED at 496.
2 out of 2 hunks FAILED
checking file mm/hugetlb.c



Tested on:

commit:         52ba7632 Add linux-next specific files for 20251013
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1681cc58580000


