Return-Path: <linux-kernel+bounces-864748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F65BFB742
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94C956375F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652E328B56;
	Wed, 22 Oct 2025 10:50:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F261326D70
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130207; cv=none; b=OXtdIbqCbHpXqvS9k/2+rXEr/9iJmvBbXLylzfxg51APsarx+rndE62DiLwm1228KdHTM/TlvCQWKMsw97UqYamiDmYPUiHa2G4IkVjBqFsSuN4qGLaqFaSGZ2f0dSPEj5zkfR7Luec5FL6GVHvoOkgbmdmNJetPYnUB/PjQxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130207; c=relaxed/simple;
	bh=k1kxbnTkOspFwCXogVKWPxJ8Nw3kjdFUOP2ofcBUUbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IA1z7Hx/mMpzt9w8UmHYgTEOeHacx6WuYPrYNDW7/5GDpq7IOpAfpz9+TRcL+EWR4lgjQfLd4CI5nh1mBboTz5aAuHAtXr4RGM86rwt32VtlAn4s4mPehS76aIeu4cmO9hG/rorUeDrleO5KBwVZbyqJlisJwj94nwIoV/mCszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430da49fcbbso46399395ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130202; x=1761735002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3M8vIWRB6VOYtW1Xq3RNaw/PQfGnC//D4o0eSmU3v8s=;
        b=UcXKh0IZ+gfMCOVK8Zj8h9caPK5LazM3pV9VB22sd6N4ENafjXcRV2zzpFxPl4F0Yr
         fkoX2e7eTKKyOKT8zReicJTj/8SolxdVwmrPMzS2YH5K+6F3iwDilSG+tqRkDvf5h6PM
         EHcngOwc+n7/5ZhvIozj62A4UolgUYorrCevBi4XpvhouiJHl8TWB8ncTIs5Z6SgWVeU
         QRdw+36Vq7JbNbakwztA6uyGj6nFvUPDSrft0ARJP4EXwq1YtfTNW73XzZ6fpZhcpGKz
         0Yi0iUUIdL3QGYGMwTjplPQMAZtuRRct77jBpfWknvAa4kgcSnJtJFAsfoFaYEJr4tJm
         os4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgmgkYQ+C1LDjIIFhOZMj8SdRX9c0tR547Au6HMavl13idaVqgMqDGdp6aaMoK8b5h81kfyceHTf0DHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzY82hJ7rQkkdq/mB8DnBHM9D2Kuxvcde+4dpsA7ZX7QSNrrs
	B0Cn8KUcvmi5MG4oVGFzUk7WXaOlDWA44OVLOlVy48tpIOHhK5awhHlH50udCH6upWZonNOK8hL
	nW75yuZSCo9DeUgaKCZ0ljiE4S8ex+LPkZ8oEhVkUpFtdGhaYA23o5q2YuhY=
X-Google-Smtp-Source: AGHT+IH0CgNHOp0MaYuuCXbYygjbin07WKx43ZSBhjeVghpjOsxd4p2jOviEVbgzqWVO1ENpRih+jzXuHfoGiOqzrx+SnhuasLwU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-430c5263fcbmr308079075ab.13.1761130202572; Wed, 22 Oct 2025
 03:50:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:50:02 -0700
In-Reply-To: <04c36047-fcf4-4c08-a7d8-c70730dde502@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b6da.050a0220.346f24.0041.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1684e3e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ea9b04580000

Note: testing is done by a robot and is best-effort only.

