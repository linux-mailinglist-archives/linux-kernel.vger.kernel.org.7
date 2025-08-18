Return-Path: <linux-kernel+bounces-773397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE73B29F48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E82169A46
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB395258EFF;
	Mon, 18 Aug 2025 10:41:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF322765C6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513665; cv=none; b=bqVTKGpZ6jSrfAM5NprYB6FYG6LPpak6bRYX3iit5dazHZ5xeQ5yJM5tSib/7VMDsdjAbZ138Puq4mELvJ4gpDSZ6EoLE9VgCKHiHTn9I9mCMWpXAvblTTjq2O4GSxBzDbhKi8LHyV4Wf72ezEBtaqBZPZN0fhZ6klEpHseQ984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513665; c=relaxed/simple;
	bh=Mqo3UGE1Bme+tAtLCwb1TjVSd0SAvNdv83hNNSqLSRo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e227QFYLb9eGj1Qz+r3iKLc2GC/R5rQ2Cvf+1Zcdzz3yJxcAYRQsLxC47LvDMQLlJiU5EH9rmIIErZlat78C/3FJFFDdKY3iYKsQ/CwWB2WQmcs+RiKUn59wKr46bwd9xMsUiJCZ+RufH6wbJboBR/QmBrHtzIw1NAaHT7GBWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e56feb2b0dso126399625ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513663; x=1756118463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrG4Vx3qtfYQeDvjaRE/m7vDhTfLYlJ5GgLEgzLgGuM=;
        b=IdvRMBc1zFDWVE3vO+L8liPTduj8w8nXJ3N9/e67DFhOJB4rF/WO3N1/wWn+yzn8w3
         U+8tujyiInVzRoZSSYAOSXP1WCkYWDHdk6mskepLJcWMwjt7afzmBdG4sAGULPVCQU6S
         /ZoDvfvLgOjq+FwcZ054wAbhUNxyDLyT5USA4medVXq5UjvUQzgMdCiCzKD4RrtRr8ZL
         DCsHzwgJ3N4b/2Xxjl2pHJdj9kfGhdAaSZBp13hfhO8bIvoYNJ0bEQTUVXhpqQx8dX+U
         cVXla0adomLiAhxF22QKz4sj8yT/eB40I8wcoDnegYOzA6WixdhTy9DoHJv0ioiEXQ8G
         n4qA==
X-Forwarded-Encrypted: i=1; AJvYcCWIeeemdu6JwqP2utfeYTZI0ZGnlIipSC1gUFyRR8uufPUgvmagKwRH1j6HwXJigB8tPnVkhc8R07KIEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6FFlow3zVQIfRoejZs6JZsgktzImycIdC42n02AXl35ZAMnu
	ptQ+ASWrl0lZ0sLMtBGF7XHzQRRa161YCzcvNRaTOJBKtxQX4kEe0SYTo7AlhuU5LirSX4hsycx
	48gXMUgaQV+YfbCaL508O8+r+XiRbGjSq305cNQ5cewfPK6Jsksh0z24DBiM=
X-Google-Smtp-Source: AGHT+IHfdTrRhdyZ3XB6wJijBqmptBu3DqMxOJvCyZB34vSwaAse6RzFijYi6lrsi/1vwFX0auHyhwvXsWtaLfATYZ17mRqpsOtE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:3e5:5937:e576 with SMTP id
 e9e14a558f8ab-3e583804f82mr160391565ab.13.1755513663154; Mon, 18 Aug 2025
 03:41:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 03:41:03 -0700
In-Reply-To: <CAOQ4uxiPPb70mx0Pr4Ph6hw2j63Q8=PZaxBx3N0KP=d7Ko=1KQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a3033f.050a0220.e29e5.00a0.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_symlink
From: syzbot <syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com>
To: amir73il@gmail.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com
Tested-by: syzbot+7836a68852a10ec3d790@syzkaller.appspotmail.com

Tested on:

commit:         9e7e7e36 ovl: use I_MUTEX_PARENT when locking parent i..
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11d09ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41498776bd40da1
dashboard link: https://syzkaller.appspot.com/bug?extid=7836a68852a10ec3d790
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

