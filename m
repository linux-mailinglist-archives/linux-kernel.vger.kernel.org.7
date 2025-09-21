Return-Path: <linux-kernel+bounces-826019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4EFB8D56F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798D52A0F93
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D22652A6;
	Sun, 21 Sep 2025 06:03:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD1182B7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758434585; cv=none; b=YBZr0AsIWnk1BX/kCtQ3cUTvrtYVs+sGrg82lT0WOB1+oHmWZFNB3sePZFtMM9slmtQ/9UwyqGgTlRdVc0BYrFC2MPi65Mw1v/2R/HPSyjX98DHx1TDG727mc/Ns+LjLptYwqjjg5KsfwIPwuGASDzpXVXJ44qVzi7h7NZBLDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758434585; c=relaxed/simple;
	bh=psSr2bM3JnMxufeL/g3AsGHtXT6h1LwOif5UPWk/5xk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L3GRMmlvbKLf6ONASqGc6PNsIOC8Kjj7kf1nKQsjBXMzeUsK9SjoFVZj0WbvO4HYbXGnI1Pn6TNqFVsQF8660erl9ZPQoxYTylCZul+hGNJIrcprlr6Z9AzUCOh2S6sfNbgO3WN4qIdgOXAZSSFixbFX0Ihidp2Rp0N5ZX8lwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424828985d9so22419765ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758434583; x=1759039383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6dDx9Z14ty0hRGDOpEn56adgVcnRxlC2O4IbjHD4vg=;
        b=KkqAJQXoG8bgNls/zeHYB5X603z2knjbfISHIm1/00OwZn4Y6De4SG512U58DjbE2J
         CTsxgikM+z6X5vp3b7+3SHYYTA9My+vy7hBzGWdI78jF4OZtlhZvHn/hCoEbQQM1DESN
         qC2r594PqjhI5r0214O//2N5BynrqQlCleUWNH7Is9rUqGoFz3rahjalTRYyoM6dzK+c
         ov1jYzZpyy4BlBnUXZiDrH1z0TG5qtQTsJ4K0zuGVCN56+Sg8pb7LIwCdwoYFPTbosT0
         dVTuAhiVOFQmGXdGLmEtOlrP0Wfhcy9N5gkqYtuWh3xBfxv5DFOfc0TXEvn/vP6wJfln
         qHZg==
X-Forwarded-Encrypted: i=1; AJvYcCX6B2f4AhocUuVZhQxSkj775Bx1DJ+po54IGXCxpO5MNm5beBxuEkHh6W+ETEw2Dd9Qbz1I5mNQAVSNBkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbn0vyq+/MXfLGK2cVE8ruJZ+2jjV9pT8ewLa0HRkt/4b9ly4F
	4zhIaPw2j8GF0QngPrIAD668L4UBjvOCd2BuNIB8dRpdVXYi154rUtlvAOSlDKwvcUdpmGe454y
	KXTSNPy1BxcUcS5sYsgY1CWtRe500yOAc7i3ueBPjxXtcYfWX/uMHx+XlZkc=
X-Google-Smtp-Source: AGHT+IGWwS22f/HXMtlGtGzvUELXrtInlWeTZjRaQZNAq+YXsKmdVFMT1RRz8383+U1FP/Tbm08Nr8w9q7SdqTwnbPn/T1hJPuBp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:424:7e36:f873 with SMTP id
 e9e14a558f8ab-42481999b76mr109605535ab.26.1758434583227; Sat, 20 Sep 2025
 23:03:03 -0700 (PDT)
Date: Sat, 20 Sep 2025 23:03:03 -0700
In-Reply-To: <20250921052315.836564-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cf9517.050a0220.13cd81.002b.GAE@google.com>
Subject: Re: [syzbot] [nfs?] WARNING in nsfs_fh_to_dentry
From: syzbot <syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com>
To: david.hunter.linux@gmail.com, kartikey406@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com

Tested on:

commit:         846bd222 Add linux-next specific files for 20250919
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127fa712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=135377594f35b576
dashboard link: https://syzkaller.appspot.com/bug?extid=9eefe09bedd093f156c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ff1534580000

Note: testing is done by a robot and is best-effort only.

