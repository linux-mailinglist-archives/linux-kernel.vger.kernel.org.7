Return-Path: <linux-kernel+bounces-750566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F7B15E18
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C997A3C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8527FB3A;
	Wed, 30 Jul 2025 10:26:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA322156D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871166; cv=none; b=G/MkaSfb4oGP8pBu4y8seBqfVaSIgVfmJE66x3yAeNn5ha+pMmY8Uhi5jxzcGtDGqHW3Mpg5TDFhi4QgVvvrUoaxwJFTNQ212E+gaZ9nUaipM+MnWmONAUJ15ewesRBZiVT4zGXyVbwXH184UDn5qNOjsVjSe5LVWzhMKg/99mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871166; c=relaxed/simple;
	bh=XOvJh65RdtWV4wFdECQ9SgXL23uzgsk9JIXzMyMKGe4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CedjonyczNVp8WmMa609QdPrptYSTwVEZIKwLaQxt62PtR5EM6Lx1jVzcvMPcAFXnEsyTH2bTUoKxpgeQjCEcalM7T1m5KhaqniV9NBGt82ulV6cEN1oOsTah1hVt+J1VvHaLX40M6BhbilMKKuldpoYkNqTatX7l/O7rxShbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c707bfeb6so618786439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753871164; x=1754475964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YftpJCusFHmM+ZxDpf98ixSLOyG7LDsNvG+SHmPrLNQ=;
        b=iQj9oyAFIM8c6uYorAMelNH0lD487Ejmn4qpBkf3rZ7JZKQ5JoBJM4HTCDRP5q6KTu
         rZFpY1Ip9+o1NAFb5B0KfV5bnnCWF1OSnqhraeJzjIotO1wbjYTIJOgr1vYXXQ05lHXD
         nx7bySpCKUM0FK7grVn+oVgn8CkUo7xlzIXW+0u8phwc0rDemj+tD0dAILG30Z0P+Js0
         bhMDdDLByepLkUcVF0N1eBfMB1tyKb8REFuDApe4SNwruwOnHI+7wgfmwTkPyDIfEJ/V
         k1YmME0hQeD6xb7C5l6xZ9U7ZMWNPElnIgP3Ja5cbpI3MzM4CSy9nuXtE8vmYjIsx9AA
         nWVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5fvloWjH5PHLkyXnLaN/DBWxgrvEqE0VZqqDlgHk6xUsfo+LfUA56C8Spk/8xCU5wNybosXCYjnRnnfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTz0eQt4Gg2tZVM9LoEMFTbLBr7sX6xUnYq92ieASUXt8cat9
	JDa3M666omlTjM8HRmwlsMLJsIVJOHOTxLxhMHd36z1yUObzQzAkDYG27CzE8GdaJuQWIolGi07
	qGtIyGHBNLzj14eTEj2rd49f3YE7+uBxtd3q9Bxz8Np3LrgDLVDCUW6lVvDc=
X-Google-Smtp-Source: AGHT+IGA6nAPV28vYeT9Ais7QjZQoa2SGabz+hl0f9/JBolT0bpzPsuybKDiQ+Qh1+WfL+8gr1pRIMXll3OAjfwSl16o7OmfYiaW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd0:b0:866:217f:80a with SMTP id
 ca18e2360f4ac-8813785929dmr522595039f.7.1753871163788; Wed, 30 Jul 2025
 03:26:03 -0700 (PDT)
Date: Wed, 30 Jul 2025 03:26:03 -0700
In-Reply-To: <20250730083641.3512-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889f33b.a00a0220.26d0e1.001b.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
From: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, 
	syzkaller-bugs@googlegroups.com, xni@redhat.com, yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com
Tested-by: syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com

Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13420ca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dea300d7050f7861
dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12908834580000

Note: testing is done by a robot and is best-effort only.

