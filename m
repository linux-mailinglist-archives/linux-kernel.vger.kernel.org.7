Return-Path: <linux-kernel+bounces-847532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B5EBCB1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEC41A62A84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE424286D4B;
	Thu,  9 Oct 2025 22:38:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0434B2848AC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049488; cv=none; b=MCTSfo0/IBkzXRfkC0iA0PxSt9geJZZSkfje0dQ5L035eVNdiz6jlBmLs/zWtR96BDkIVjPFtTHuecz4rraoE6nloRUURkjV6eyIJi+6Nhj3lymgFDIizXHjjOBd06zAQ1NRZw5vCDGHHN20mb7Tx/Dw9LgjMXlRaMe+WPiOyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049488; c=relaxed/simple;
	bh=HsSkW5OSK5Of3GZtY8aXCM3pxJLeIRMZY+YsySZrDSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZEWs5LszYWjhSbOHWKVGceRRiVW7lhQ5O97qkAmgEhNDKbJwjc05o+e9OUPbt8xLsGwLe0D10XnesawfUIInpsjjB6cq+aVfPxgrHHrKzpLBEmzucKr6XWvHXdYbjKw77avpS6qZc/9GDQcj1j67UAtbqMX/uvu6niFWN912CP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e347d26bso441865039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049486; x=1760654286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTy+XKow6IyIcolz+rmp4iUy02CT42XHq51o1WtUl14=;
        b=PZ+iZ4JjmgJI5fJ4BG6cZXdRTcv/tP0X/zUR9l7O9M2L5amEBQxH5tvvYUtUXR69OZ
         o+8i1DROE/pskt7WsBlztDGMSIXqTyDi60pZkKT7ZZCQnFBOvP/rOigMbwkPHbXK7uTl
         GEJUOCiZPQWV8BMMpfCUUhnnnNIred0yYlCN8wadE+LhWwdQKFNY1EcsamOJ86uGlBSa
         galyLn/bG1WQ3jcfVv7eZHGo627RLEIb4wTqFruveR48oeY0yDO8bNcXWmdJiYy/oknB
         eEQK5SsqG0PVBL/f9C9RLea36Hl5NQUVxXtR6PHugf29K6h+i4Fs3j/aDhVOBC9bcNce
         rSDA==
X-Forwarded-Encrypted: i=1; AJvYcCWNZcIGnluWgLntxN7yHojrzp9B1FGpNBZ/p19Nbou+HEh52HHLbF2LCgPQUC/L1h3S/5/Zq2ahhW2jtKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWclrjsKbJ8ZULEADnUYo6LSPhq6d2a4HXs0jYS1O2HiZJOGW
	lnITAYoSH0j/p6s+QyDwASq2TYmE+rQ93T40CK7o+dGR7Bj73mRzegvowclwTGD+hy4W3gVDEjb
	8Yld6KkJj9vJplfed7Q1pfA6LoWpPcr/uuKWFvVbFMLwR+y8s9fUiucLp3BU=
X-Google-Smtp-Source: AGHT+IEWfFNoN909hchbl5pWkVaoajQ689Q6xPek9pNQueJzmv7fwhme/2r/rY9K5Qg9PjzFyMj+md0ivvvEdloHA1x7kd/CBbn2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:88d4:0:b0:927:bb0b:3b5a with SMTP id
 ca18e2360f4ac-93bc3fd2fecmr1286169539f.0.1760049486129; Thu, 09 Oct 2025
 15:38:06 -0700 (PDT)
Date: Thu, 09 Oct 2025 15:38:06 -0700
In-Reply-To: <h545bb77v5thrxyp2d6tqkazozyjnd3bs44j4hrkrrp2lxvadx@q25uxgdpktg4>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8394e.050a0220.1186a4.0003.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: sleeping function called from invalid
 context in sock_map_delete_elem
From: syzbot <syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, listout@listout.xyz, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com

Tested on:

commit:         5472d60c Merge tag 'trace-v6.18-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1558c52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b842a78bbee09b1
dashboard link: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159c9892580000

Note: testing is done by a robot and is best-effort only.

