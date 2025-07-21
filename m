Return-Path: <linux-kernel+bounces-738553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81937B0B9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB44188A5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 02:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C71991D4;
	Mon, 21 Jul 2025 02:17:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E513208A7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064227; cv=none; b=hPHspGqgN9xCnV6FE0D2mq7EJ0LIxgwcB2nvYfeooJkcdTpOIFfhAXhFY4fYXM/bJpcwKT2SyDpBbhzUttoK7fDI2dax5T0NGG0Y1KQ9dSVfanmwTuWT23/Ghrhk5gtD5m29C/02CJyQTADxXI3gakoIdpKKWvNL5EIi7ZV6DKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064227; c=relaxed/simple;
	bh=8NYFVGqWAzwC2o+SlUP0QW+Adv1//Y7gVpkVdlO49Tk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bH0JR8LkXvdZ/0AMdFnyOwN1hjgdE4lDL44buwjuIIknD1Dockbj+b71GEvRR9+bq/Sin/iBcTCCudXK4e15nGcIPEhW5GI/QeXQ5mKmf5Zxx56JEAPXsvH7Kztz53vF9+ixyxWvfLVZU4CL6EIrUui5wRU3fS8LGd1GY4np56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df2cc5104bso74716595ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753064224; x=1753669024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6zFpJStBZvBBvdwmAvAIzBHOCPiq06fz1+5Z6R6+ug=;
        b=U1cpjdV1dStMk0zKi8m8GkkBMqUUBwNiJvsBToxXgSbNwSi3ih3cdqcfzcphGFrMvp
         EJELau9x6jm9rS4/KvOixmul8ixp7UTkDSjK5huLqIV4VH+m3eV3qrMOrc5DaB6kRF/v
         K16lahWosdUt3kg6Sj2v4Di7IFYx06Lp1srLzFAJxS/kXqbx0KWlKWoUyylJ8t+iy2sT
         3x9udJJCS24pelH8N8igzTJpnKGWAmYMr+qVhQM4YhpJXoI/guoC6zP6vSb3ORLZXL8k
         QIXzjpLrNfJsagg48pWz8F0kClrYfpRwjpMW480LtvcxvkwBkXQuWlA37Ncs0PPaFf/Y
         iO+A==
X-Forwarded-Encrypted: i=1; AJvYcCXXojU36bLx8OT+ISyrJjnDJ6Lhxc9robmVLW03fHV+zAdO92Nu+sGLYPwqUgAvaKYyGo9ovMYB3+kfxNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi1ynsMm07yIsM6hvlO+DAOILRwQHUY3kDOrWpLlSjuCfC+c0
	lsFAk6tcl22QvcL9zz+TElv99LIocdDLeUCF+Lj7z9Lml9PHhZZKmYN5hhjKA5aG/C/+YGfEKlH
	nfCh/m6QOmaI6ItsPqHXGgdxSWDeOWQ6+kx1pYaXpdySSKCVTu/STGjwvldw=
X-Google-Smtp-Source: AGHT+IE62nVRErYj5K28WXFysbeJDYEWYR1JK1kpEvqbpRVR5/58Bwvo7AqKlMd5Y1M5K/3k7QbCWDzm+M+fPr/vUc1h8d70IMuc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3df:460a:ec3c with SMTP id
 e9e14a558f8ab-3e282ecfddemr195453645ab.22.1753064224646; Sun, 20 Jul 2025
 19:17:04 -0700 (PDT)
Date: Sun, 20 Jul 2025 19:17:04 -0700
In-Reply-To: <20250721015344.2609-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687da320.a70a0220.693ce.00db.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
From: syzbot <syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com
Tested-by: syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com

Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b9d38c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12380fd4580000

Note: testing is done by a robot and is best-effort only.

