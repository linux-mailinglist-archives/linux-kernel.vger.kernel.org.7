Return-Path: <linux-kernel+bounces-782828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A111BB325CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7357B4721
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9120B22;
	Sat, 23 Aug 2025 00:29:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C93987D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908948; cv=none; b=M7aXgNS7UMKXrv8LGNe1fsS9oo4ENaSYcvoD7koZhqGYStV0S67VrNGeDoA5KvCa2MmPkBKLfJW2Bh30C4tpaT5zwAbml7clFlHj0uYZWqD7LgCVQQqLeA0sAlPRIDcPyPaUDvOOkk5VxqTNFNND8alfhNhwg8NynesBEo0RkWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908948; c=relaxed/simple;
	bh=ywXI5dr4J5xhVaS6XuB8aI7IXZbJkfYJalqlnBDP7AU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UNEwCCoUaudNQv+mKqxQHAgBtMphhBH99FUH5h/vC/pZWHtOkp8GsLEuk+JR1r2ndtMyN6bbrVGyEDqmXe3VcNZn3SFVFxdpEdtGI9wNTdu5RqFAkFgjeZ8BT6XEMjRW0fF09zgXvI2eonNJNPHh/nmWx5WcBeSWrWRpI4CdLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e67df0ee00so64848795ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908946; x=1756513746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqgoBPFF928CVLiqx5fttfRUfAD+/m3W3Mi9cArNHeo=;
        b=jNKKVjxPouPmio9r6wtSaBz4cy/c82Vuvp98/bWy1Mb2s/ySsusmvQmZDgxltXjli5
         IBx74siOOontbmEzbSyCu9u47LQK/xaY/mSB8hEEriDWh3T+0CwspmMyMVoAeQGB/DU+
         7uxuGjzwHDVT6RMA379/Bxnt8FkE/4ZBhDbxtSEjxZYhuABCu29+Wwe64wzf9DHdBcMU
         hprifY46kKupCBqjy2x04Xf8amOctaG9GAmwFlfrOkkYErecRT2IlXJjQ/ukmIv4kDvO
         /zNH2SreW2P7QtVmjJzfgGvh3Y57Fh4HhsNeulYaGiJENUW3UK17R+2LVvnMDMIxlkIn
         ivRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUST1G9a/H3onNEtmJ34CWniw5yMCzHr2d4D9uCrnkiIp/BnCMXinXSnHLkgzOFcxd78SCjPni+sxtHpyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUZBRndTvB3e8GQUoL07+HfvNdQpMLKXs9vvSjexYcSbSBKUo9
	2EwzLh8URGijGVmZjSkcb2zCJga/e376VXkDyNn8iJnN0s8dw7zz2xrggqUrRfxOwgU6FDP6aok
	KluPMxcmsg0u0buCU7Ey1yTizFAo3RfW6Uq9rZRE24GnqjxUOdcCb3EkKmeo=
X-Google-Smtp-Source: AGHT+IE5GnCv4UDHYJhL9zy1QJVTN/1byJllnaHaFbJubRCbYVJZddUZ0e/7WI9RASM/GG6W1HEaBSEcoZPQJg/TB2qG+B8qOFNo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c5c4:0:b0:3ea:5739:5e4f with SMTP id
 e9e14a558f8ab-3ea57395e53mr17270065ab.32.1755908945847; Fri, 22 Aug 2025
 17:29:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:29:05 -0700
In-Reply-To: <tencent_3F826C402D156CCC96B0EA0AEED6CC7C7B0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a90b51.a00a0220.33401d.02ee.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Tested-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com

Tested on:

commit:         6debb690 Merge tag 'drm-fixes-2025-08-23-1' of https:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113a8c42580000

Note: testing is done by a robot and is best-effort only.

