Return-Path: <linux-kernel+bounces-785880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CDB35220
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9154A4E2AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316782D1926;
	Tue, 26 Aug 2025 03:14:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD127F195
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178047; cv=none; b=TYsVyvxjVo891gyGFH04lIqxkv8XAn+vWciuUiT35tvYJd9MZZ7scHR1F1Xf7ZQEJIxgJrgSI5Sd69K8WrhjCbijWBL669NVIWYNLtSrpEUfyNpro1UycfpQ7RJQTDWbR7FyE8I6/CiJachEAlNBcMLa/fIXEorv34bZR0qmKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178047; c=relaxed/simple;
	bh=Avv6f/IOGjAyppbPAipyoqpETbUD0zIFFPlK745zQIo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MMe5IJneqZkJxqmRzv7WbjnGD8fYWVbchUtXsT25xbQJ8G79JemXUHhten9Kw+E3AY/lcxX96PkV/+27wqKz6PZfyGKomlz4lOwukEnM6X+c9Ct6AX4tKyoL3q6nGnD8gRg+n96DbzPCMsIxlrnbIRTM5nmn8CVjMYu97YUT9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432ccc4f9so1169458439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756178045; x=1756782845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2VJJyYRtdGUjhpSARaZEyyeQ9ia1hjS3TG38IhJyyo=;
        b=xJ2GIne3ecZbUm3FwsQ+lfP0wmmfhZiwOpndKXdIyqDFWGbD1jcb3pjTKUXEqeCNlr
         DHJKOf8WQfr4TdCNv5AZAUbPzw/s3GbeUhQQ5YVA8/I5P17hbDZ0wl6gHx53ZCaERpbW
         CknOLu8EC6/6i2Juy9VAhSVNGQJs50gBp7cZiHZvZiSAsycjMX6smX0bF7UbXwHFQVFZ
         Rp5RCJYfBP5jdu7BHcmoHfT6Uej/bzVTikfSa4P5/MrHw/5IOI1CuAR3GFdO7U26lPka
         QsWuB3eBwr5GTnXmZtCUyCtuN/ZJU1xkaOf4G4o8QpfAT+aB98AKs0osmxgB8Cn4z4K3
         rBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF6jzPuGa+SMvxSAfwosmaARBN09AC9whR3QTc0Q1TjZCbDmvkdtnLMmMIiAvIMuL+tm3DBW2ScsOjqfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfbJjjSFS01iXAeB2k+TLegNRbbJ65gRdBlef4/tm/Lm7ucqx
	HTgcvWTeUvuEU7bjf4DBWBWGxNArlwsXpZh/yH2rRHJyG6WvvaqqMVXc1+jePGcDV2Jbpx4IEfJ
	M4SbYGMgplVyD4AaBzVcuFGF8SyoFhtEUp6ifT5/yn66OKCuE7tjbXoV0+C0=
X-Google-Smtp-Source: AGHT+IHJn0I/FiU/VLv+MhSHoayJNLL3ArewmbpqkncxW6AgGckoK2ZX/XuhUwV5bNX2wlIAPotwsIT16lSKNSO2rG/nJeJM1tfv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3eb:2b11:441d with SMTP id
 e9e14a558f8ab-3eb2b1146bdmr137711885ab.15.1756178045470; Mon, 25 Aug 2025
 20:14:05 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:14:05 -0700
In-Reply-To: <20250826015839.5533-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad267d.050a0220.37038e.00a2.GAE@google.com>
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid
 context in dummy_dequeue
From: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com
Tested-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com

Tested on:

commit:         fab1beda Merge tag 'devicetree-fixes-for-6.17-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dbe862580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141de862580000

Note: testing is done by a robot and is best-effort only.

