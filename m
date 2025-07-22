Return-Path: <linux-kernel+bounces-741391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3889AB0E389
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361CF3B0520
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8B28314D;
	Tue, 22 Jul 2025 18:31:52 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581231B808
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209111; cv=none; b=LHKuOBzvqdGNWYv1xFJ6neYclspGsCWC7J7XJTpG/7cwj8IIoh/E4Y5vocn4GiNOMTyslJmmTFEY9zJlTRS+SmIxOyJtuNqTTMvNQeLyM/M2GS9pzNUTW49/26Ip8lhS5iqABrVI8hCHUyQwPlFmqS6iGGoivf8VIFKs8h/jEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209111; c=relaxed/simple;
	bh=8G+PJ9AkxPqCpKvubTDKjKrCzBtO9UAbgBkZzkXv8zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U5uKtOMWmkC32YELC2Az1q7V9SNyYo3t+Im/hULE6NaljSQ3UGpEv1lG5VRsbrdLMrdLy6kHvxOMk3t4DafKUFpIIqe5v4W2v2SiKwV/D3GdTlZ34V/x2fG22vCIFaZHGKmeQBQ1YX/lkg+wn7uwXQLnmsfAgwU/iJ4jlCZMW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8794f047611so663463539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209109; x=1753813909;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ZaElkY5hH9PchxC/G+FEOAnqOWCAgqwXTeN+pp5sc=;
        b=A1+BRL4cJpAMtrVc7JBofd/a4/WRPgr74mOCZgpl6az7mtfzIwywMC+fE/WvwT0o78
         zxuXIJuu64gzzknH9AEP3PFPDCpWQgyk9VmYLWdPsh7DmYGm0SeRamLNMQST47Lzk+qF
         WkSGxxm9AeJXYeSmOQpraDuUPQNVViDLs4T1NFcLrEGD7N6QTlg1Jd9qTyzuVAlNEE0k
         Kk+d2UljqB9UN43Vp1p0nwQ5QYxugPf/e6UFPYKrv8CJy3cwYk0ILX1uh4VBit0Scfc/
         fIwxz1qDEltVPBdQ0uvq6RZqGVCJXmBKJC9nZiYoNjiUr3/+07I/SXjmhcu+Sx+lL+7x
         CqIQ==
X-Gm-Message-State: AOJu0Yxa3HwgbJj+ck4VMuau+adGrlRLVqe8dUN8VUUZ79eHyZPnTsLq
	u30692FT0OgmB9+j1KW4z17oiPTJKwJZqx/CC1k2F7/rB/6hAFu7biebKgAOpwtL88jN36AwkYU
	wOxvsDGs+rT9hZIr4bmZJxdiw8+IdmQAbZi8k4jYsIvPQjSkFtBTMj0avDi4=
X-Google-Smtp-Source: AGHT+IEY3nOYtKGsgZm8QcFZ9LIYPY8Xw5lshLpVzcuezYmx2GdtgEwti1gzfLhFyh96KZ+jpAFlCEDjiAE3XLrVFP5oUM+owDvf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1643:b0:86c:f0d9:553 with SMTP id
 ca18e2360f4ac-87c64f956e1mr22660239f.5.1753209109482; Tue, 22 Jul 2025
 11:31:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:31:49 -0700
In-Reply-To: <0000000000007a211706185338b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd915.a70a0220.21b99c.0013.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: mm: memory: extend finish_fault() to support large folio

