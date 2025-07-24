Return-Path: <linux-kernel+bounces-744100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9505B107FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE71B5828C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A4267AF6;
	Thu, 24 Jul 2025 10:44:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDB25DAF0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353845; cv=none; b=J3jcueCBnFcxaMh1pjOBHW2lUVBrYeA1/AhrsCyXeFCEopU976Rjr18JRN8YUrbWq4TQXy/Jh4No2Tlk9zoYomGdKgr7ZfVVYJjOZ4gGaXdOtE3MoKiNhOPtSLuHnW7R3QcqbVqby4OzKKTTnXyqmt+srQAUmvgzm/7zoG332ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353845; c=relaxed/simple;
	bh=y53RS7R1LdTpJxvnonVTbpOdOVAOO8GXJyXIvHfGX4s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KOgDKWuvVHqAYjpuQddNBmWhcosMQKPSjoeXz9M1YoSAXycXE7qRxyorYXebDbCKuDZ1kF+0WOGg+s6mkZ2/EXqPeabwZzwfi3FUZ1TZoDYSJYdAZUKtt+Rzy7q8zqs5GYgbgVOj2yhOJ0OIyy8gfLEiWP9CBpxAMK3Nsf9NLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df6030ea24so8794515ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353843; x=1753958643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HUtsCPS0RZojWVSFx3rmFIsUyxHXi0QChMc7QahF4s=;
        b=pzqg1ACukYlrjOMVjFuxQFs2JS5Uggh7j0BWEuK3jqZsijkdVMwr1J12yb0J/jIMgC
         nfCG5+hERzYGgUcUrhmHcKUkqP7/yUlb7E599oC+aoPVdfpUOqQi/vJ+ZQYmEHWLLBKX
         l/2ybsN1YgoGIJHsZyUjQdED0ySB5AB/LXCQwe6ZiLnolanepasCK/Liu4/zhHK/IUcD
         +54gpX2m8vebOqwyNr+tMZNDw70IdQ7l3WUPS1VNtngiNCqSpPRauWxYB348JV5TwwPN
         1F7P3/q9g4+LHk9+fxU1jwdY7UYuWefo9VhVDlDF17ZWqlEQT9+5K0t2BKugShe9/UKL
         EBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXsYQEH3/GeLOjUuYOg6ASTDTv6TaMdXtarpQW60RPVPyQKpMd5ci0Pvexz4e3LP5t0IarA2b8OJ5CUKEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZCvKOaW009s/IlqfxnXYZeey15WbhWWFC45OUu6iNX6mrEsL
	8s1Gg3Xer9rcyLk7JBigF2CUw5K7zQEmDXAZNtYMT5E2j1y1lZly6g5DCJN2dL8YPMjyGwC2KLW
	GK9qm8wMN4mR0F+lIlVegKJhHNGTVXv9A/5Pb9Lr6VktFW255tM+4oW5auUA=
X-Google-Smtp-Source: AGHT+IGrWUt4m8yooLDvQG/2rbYrcHLplq1aTn7O2hnr3FVaobtDpSgG8va3F8DWkc7p8Nlaqk5Nb6SMuHmWTsoKftupFSYs3w6C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:3e2:8a58:7f67 with SMTP id
 e9e14a558f8ab-3e32fcc3412mr103104085ab.11.1753353842828; Thu, 24 Jul 2025
 03:44:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:44:02 -0700
In-Reply-To: <20250724102300.2988-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68820e72.a00a0220.2f88df.0021.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Tested-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com

Tested on:

commit:         25fae0b9 Merge tag 'drm-fixes-2025-07-24' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f13fd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8adfe52da0de2761
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e13fd4580000

Note: testing is done by a robot and is best-effort only.

