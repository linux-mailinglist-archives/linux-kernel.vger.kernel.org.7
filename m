Return-Path: <linux-kernel+bounces-869607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD7C084F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C1189807B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1F430DD3B;
	Fri, 24 Oct 2025 23:27:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CD219E8C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348424; cv=none; b=cXPguO4AScER3Ane4R/YNAdsfEkrOx7/5QmFDd3jGVnHhi1g2UjBAxr8lhPR6cV0Flhi23M5qvSNHoBQ79hCZHQGQMEuC9E2oCGCa/HE94ybad9sJio5s0r1Kr1Sw417B2XzFdgN9LvLXzt4A3YBUJK52p920IN4jgK5fw9Gg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348424; c=relaxed/simple;
	bh=3IzmtxV+k1CuCWhjKwm3ov3MDEiQQ+Y0OcMKRGuLLtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b8d3/PgH9e/IkvSfCY7mbhpM6EWP5xBepG64YIoCFw7sBSWmOi0NQ8Lr5cjnmTRNRCRk9m1imqiqXd/8M/HOJ42w5sicgNkUFeEEOtwXxclaFWp4ji/gFtDfvoV1qlFH/1AXnkCCk+LA66Kuh1AC8O4aRfU2H3UF7tynd4px1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430afaea1beso35417025ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761348422; x=1761953222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GblzFMUZu0VlIWrlaRVoWJh9w1MmpHUAGd1oa8PG1ic=;
        b=p9TMEg84S4uBqeKnxgXIiYV3oHlEA5Iy1us5t33m3uacKWdGPjB684+uTs5M8qkOxZ
         j0ho4sIWIamnBBP3iWES4ze8HsEIYj0AAJrLfqJQB1X7oN0i4YVSfwvKQ/9XH7DVgc00
         ujO+1UNGu/N2dCnflMWjJaAWcwor+ocHtBXiskRYbRShRVUz/84flyrUvCA/BxwzqzNq
         CFFfinLV0v9J8EaOuFtcs7u8EuyLBM1GJHudXDcizZmU+Wk3yYYry7P6vANGkinHJWqd
         BnpS09woFkIvJNTY9nhAOO44eHZR/FzfniNpDDkE2FGar9uMOlqtB018RpOzLkqmiR2N
         gx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXVNeBRMwMHF9mQO5VCyk9oAtz+W4BZu46lKRJ9HuZLSlDKvFxA/z00W1NHGlYA/OIHnejDliow44tOR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevVvrks6RzhGfD6AoudWto2kimxNITxETO19+5cAs3Clu8H0l
	mBWv9oxyBC7gD7J+eHPLwCfWqGSQxA+GAtjpElFxh14VrXSvXq36n1S6Kwc+8rw/7sT4FWBSjny
	+u0wPjAmWedFhnqJWTRwxCB3/qI3H5x1zUZgkNzHLzeTezHgBdxJf4CIvf5U=
X-Google-Smtp-Source: AGHT+IFFzFiCwb0a2CE6b5Vw4N/nWGwy/jlX6MQXaWDaY5FSRGJARWwTzmq3c6eQv4u+knwAAw3h/O+QaK9dBNlWXB7FJm6Or3uG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a27:b0:430:cfe4:6e61 with SMTP id
 e9e14a558f8ab-430cfe46e9amr398027905ab.14.1761348422373; Fri, 24 Oct 2025
 16:27:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:27:02 -0700
In-Reply-To: <20251024232459.8716-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc0b46.a00a0220.9662e.000f.GAE@google.com>
Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
From: syzbot <syzbot+2479e53d0db9b32ae2aa@syzkaller.appspotmail.com>
To: hdanton@sina.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com, tabba@google.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file virt/kvm/guest_memfd.c
Hunk #1 FAILED at 708.
Hunk #2 FAILED at 732.
2 out of 2 hunks FAILED



Tested on:

commit:         d2818517 Merge tag 'block-6.18-20251023' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=2479e53d0db9b32ae2aa
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14426e7c580000


