Return-Path: <linux-kernel+bounces-871551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453BC0DA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F24FA10F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD49303A16;
	Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61D301471
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568448; cv=none; b=Hcqx8iXXVbqVCbhUk1wDWpX5ijlbgZo8StuBheUs08Rj2IxX1QTmP6wBYgTtBawWfqaVfQM6CIxIPCFfXJRQ8Dxu+5A3ftI9xzefHyR5+D9vwe1ZLgn4hEt/tPSiDRNa5OAco0Nlo5Yw8K3+4JgTqtgiU/w1ECWoy/5bh8cb/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568448; c=relaxed/simple;
	bh=io7mF9Ojy0BoRlwV+mjIXEtpy1VbwNZ3UMqr+9dyWFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ARa2xGafLQNsLvo6obpwoPWps+odCJplIn/ougcH+i4hplKWtEtn9QEpI2pSK5OyC7OOz+V10T5uePRgt+id6ny5hR9RicaeqG6ISVrE2MYfqWVRwaTPiTaGEbkfv9o5URMwyYjp3FK8jKWPZPuOuzcGk8TDe7gyv+WcXM9gbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d8643856so194889955ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568445; x=1762173245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYLF+k9f8VF3bSUqwqDFfWqYlJzvmKm55+2Qd1cz89E=;
        b=Oc9m7oRjfS0Q2w8LeXGQ0y0xtH6J9BCvTJpFjhgeTB+Q+FOcMe/VV55ymQuu4TJkoJ
         L1BuBqPlp7Q5hEESP68dhKNoXyn2lCC0Hdv5BEuQtW2JlCQafxhF7Ybiaxfx/TUITFxd
         /V+C/qgXk51Xo1PcAqffeqsjKgLKfRclRMvJFlR3pw0KU4ifcvKmRjZXkJ6XtiGhKKDb
         alneWt459Ad/49yyTLyAxAAyWB2+r2H2pTJRBsPrJzNvcWr0Gx11ukyHawPA7VcqskEt
         OFBabRbECaR1B3qsSC3VSCif4ETDr5YYAG5CqBnjVVZueF9bTPAdJa4itw4FjOvHjO0V
         g0tA==
X-Forwarded-Encrypted: i=1; AJvYcCUvUfDEghHv05hP+xJuP2rIyeqR2OZoL4qfIhFAF6ZoOn2aKI5DYTFG4QOxTgTPq87IWRbdq7jhVGm08Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw57BC42f0oGBiBfyC5jJLYyUqDs4CrXrQN/EnDsHH2XrVMM2BQ
	oS4qPvknxxbmk6FWFnT7IZXt0DsyHQgMkNlA7XuWCMUnOfXZPxJfYStTmeVmDPG75PVg2xDcpCz
	tdJd9NWcSYOLuIZW4DKuyM0oP/UCGp57PwB4dr0e/XNRSzFD9wnq5h7cAsEU=
X-Google-Smtp-Source: AGHT+IHZnxvZidojPJtc8IsUazWF1lxD/uEbFdFsLSvPouu/jvYpXzaWnpbe7fCYKv2BbYniOjAT0XCsluJ0EAEtAtVbJi17sTgJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:430:b32d:c1a1 with SMTP id
 e9e14a558f8ab-431dc139f4dmr207243565ab.7.1761568445190; Mon, 27 Oct 2025
 05:34:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:34:05 -0700
In-Reply-To: <20251027121326.8868-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff66bd.050a0220.3344a1.0390.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] divide error in ocfs2_block_group_fill (3)
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Tested-by: syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com

Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1316d614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=fd8af97c7227fe605d95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e8a7e2580000

Note: testing is done by a robot and is best-effort only.

