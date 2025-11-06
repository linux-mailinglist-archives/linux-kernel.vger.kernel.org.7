Return-Path: <linux-kernel+bounces-889430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C24BBC3D889
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B19924E2B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF613081B7;
	Thu,  6 Nov 2025 21:57:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493893081B1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466226; cv=none; b=Tvb9VwhOmkPq0LMEWf+hdZppXswmO3o/kusbMiBBJ6hoIm+P01W9vtgqXLvxZAqOfU0wkDnu46WKYM42liGZzJ3DUvzzmWP74Zm7JneC52d/x1AIK4wq8IY6gf2hYDKKsNDGbemktygMDKnE3u64vbX12kTvINYkWmSjncRWN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466226; c=relaxed/simple;
	bh=nMBuniHz/O8qiGXN4IWxh8DDwWCwm/1mpwVRstYdTdM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dvIRyXJ+FZ+cwokKqSSrCrs4CD4onh43mkiCc9c27ZuABkUgH3LBh/d296Rp5KHTGHHzYi8O1SNrR4s9ZLR+BnN1vWWnJPnKIAJfjVn4uozlPBDNJ9CJLwZ4zKUheLq5JcpFu9Ep7XB+0cu7Am0vctJLWgV1h8ycDVmxBU67kxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94866b3853cso13263739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466224; x=1763071024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1xz94chkMqUvyPz4y2XlwzU7CWHm8umhkPUE3KUVv0=;
        b=YBNF2WoUspI+hjifNSEU2imhioY4UOSoyHVWmjtnaqYXOhKd1EEyOSN9UfQ0SJbgaW
         61z3N6KZNw4YZomXxcaDMmPs5dXAUDD2mN4lVeuaaWISqCi64O8H0bpShqrmt1/yEvfg
         dD2l62SAvugeDQZwMrpKiGy6yJeZmqJBnjR+tZ8jJSOF0R/jh9bv8/HDLFQGekFHrLgg
         IvITaw60YTJqnndf2TRoou5t8Jc5mE/TEE4ScX1crIzQi9FpsIBwlv00SCvH4Cj3f3y7
         DzBAaiz18mmvqrMXid/Th/2zXq54DajLS26wldJWu9KsNqF2ziNdAqWV8OMtPiAQgME8
         XoIw==
X-Forwarded-Encrypted: i=1; AJvYcCUZjsy27hGJh9Gxs9EgDUX49cImUtUE8EgWQNLj2+fAkv5po+AUu/aIvtdoIMgruHAu2cskWKkmJZwneio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKivetmJ0M3s5jkoL/ENwzKujHxojD5ZSQ+1vNgc3jhu3DUDZ2
	bv/W3mAz36CiBGKNmSMJ2Yia8qo6uoEDD+9vy9Q1l65Iu/1AgZErHsT/q8CFmOPz9cjWbROjoxm
	8qD2fRMgcl2nWQk8k3UonKj+TlY7QQqFJf0Z610aqZ+4qxTauh5z6HSv5DV4=
X-Google-Smtp-Source: AGHT+IHeTL7q7TxJdnvouf6FlvqphW/a04AVnqWHN5452qdKILI7Tvv7S7xa5k4MEUhehwF8UNwaoVVspvS+c+mZgejkO8OFN4sF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36cc:b0:948:74e2:b24c with SMTP id
 ca18e2360f4ac-94888ef8104mr140676239f.10.1762466224192; Thu, 06 Nov 2025
 13:57:04 -0800 (PST)
Date: Thu, 06 Nov 2025 13:57:04 -0800
In-Reply-To: <CAL4kbRMK8SAMKZVfwVm+CCTcBG0_diiQH2pkbbvdP8p0wrckMw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d19b0.a70a0220.22f260.000d.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Tested-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

Tested on:

commit:         a1388fcb Merge tag 'libcrypto-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e8e17c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168bb012580000

Note: testing is done by a robot and is best-effort only.

