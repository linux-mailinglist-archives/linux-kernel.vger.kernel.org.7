Return-Path: <linux-kernel+bounces-784556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A3B33D55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A4A48537C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16A2DECB2;
	Mon, 25 Aug 2025 10:57:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58E2D6E40
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119425; cv=none; b=n9SJ2prMo6ZI/ARlOTo/a9p91N0YhGVwetyOdsaN2QbKlCZDpdaz98oZslWYK+SpPxtS++PY0BxfGQs+O0jFDtsY0pfBH8izjXmOV+GvFY8kcmoWN5if9nkwSNmoPlqJYayt4LIHhQfH08Iy8R8q6IHjAJ2a9corCdeVXdR5l4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119425; c=relaxed/simple;
	bh=o1drk41h7J8qeCol4O3/CIWWWJpjSEzM12xvBMF02Jo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qoiWsclARg3KsB6fNzcqEy7BhDYS8tYvljPBmrMnX+dpMrjOpba301Sxf8geKLK+LNx1vjCTqsj2TmA1vAdX4z8y8BgviQNYMXzJAk8v1yE/GHv8hmgT7BWHFdq23lT7DwYeONgsHlOCooUjY23hRjPkRMsxMAPGGCCZejQ8apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed3c254b63so5472065ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756119423; x=1756724223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnAEdxUVLyR7bjk0zgkr5LAOrPsrp1slbvoQ3cASm0A=;
        b=jY6DVAI8DgT5yyAv0GCIKtUjCBI3hir5FRgGs0tQXVG7YdUwzsbaF1WJtFUZE9QvWj
         lT2KC7Ba7WWTqlmfyygMyYWTKQawulusmn2AVTmxScZ4Mh2/wsYwza3y2P/NPvH65q1d
         JdDkMTlBvmfGNzi6EUTj4LyTmMN83k9ybGVK23GDLdDfOlZXo5AdAuq75JD9RKCmPZuF
         G1bV1sNU4YuAv3Cy/ksmHgOkB4Y17nfnLVWSEctCwkVJI8pmo572+aGNexsLBVoTcFkV
         FWnkn6lvKhNUfPvggPU8Pt6Z+9Hxs/gXzshVraHJQh8IyceOwB7D5fnmgbKWusJD/9GJ
         pZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXabnhwJ/QfqGvXFLmJDoX3QiV9Dx9xrf3N3xxuNdKqkUtgBQDf6aiKcfil32b9IkWZFY0Yjs4Ja/pTKzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4MU14gEu3X8LcFgHfX2IReltIVhdzZrWw81pXxiZluHTZ80K
	bovnFpumMBxMcgNVO733335qmedk16B26w4JGuy6HiSL/KsDS3CgaIZTmxYw6NAKyFwjQD0mKRw
	1o7mSPpdraXPNtj1rUt/d8rpFGbdOs4udh7t3bTAWh4WxFFuH/O26PBocvEQ=
X-Google-Smtp-Source: AGHT+IEQWqLurzZuZnFZmN71S+pzCidDLgfEOupJpOfz+FdDU4Bj+KWNpbn38fN+c9gGxXYqrL0GqZ3FLKgYicvQFxvQt4nABMmO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc6:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e91f93e0dbmr154146905ab.4.1756119423016; Mon, 25 Aug 2025
 03:57:03 -0700 (PDT)
Date: Mon, 25 Aug 2025 03:57:03 -0700
In-Reply-To: <1ebebfcf-99f7-420d-be00-606204aeee29@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac417f.050a0220.37038e.008c.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

Tested on:

commit:         27ad5346 erofs: fix invalid algorithm for encoded exte..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1506ec42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

