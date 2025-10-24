Return-Path: <linux-kernel+bounces-869178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED680C07399
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F76E3ACCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5139336ED9;
	Fri, 24 Oct 2025 16:11:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCD2D131A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322268; cv=none; b=Qc0mHnwFdb/UCFwtk52Mv+mxZYn7lsOJCQiAMopl2u8pR/fOk4NOJcQEm5iMFEzk5wgYx29Dztwu+tzquxUP2pyfJyWv+6/1vn5F1mosj7EHCfYYsjo+0QZFgO5sPkIyRQQcSxd3WnX7osuyq9pb906/EdaagFP6cUoTQL0G5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322268; c=relaxed/simple;
	bh=BC5aFy3k/K++PbLVWO+MK629SLL81R86SkBFueL9Qtk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S8GMGFoM0ywQm5NaY2sVPPEnMo8wxJrFAjkwFQyfkzVrjmpZNWCKPqQVvDQDlH+Q6seVSQEdizgIGXgMBjkJENRtXcAQ2wpuOaQvcr80miLNeRjYRPnDgJsPYh7th7FZQ/rspNwbTu9lZ46ZBqxG/s2N5bjIEq422GU5qQo58Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431f20be851so5065945ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322264; x=1761927064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1SC8BfNfeTKMm4UVr2O7lCJEknD0FRcakvsh49uVg8=;
        b=nfmL2c4KuBA1GFz0SqLx9ezdnUb891SB761AP368BQaZjw2sTG2Hjn9EGz2MwV+c9u
         ln9Ufg2SWlfYxYXf6JgE/5Mxm6vTSxcYbZFzb/rd/qHvZ+lUUZk29Gt2dbhKcqz0MYmm
         n8QpR2VVUzwwJKcLv2MBW2ogh9xUtqv7bT0PGfOsP8evYV5M8chYtjuCfWUE1nKbYfD7
         M+FCbmwyH1l4ecSnKZ/p+Z8zbF8Ast9a/Emfe/cXMbx/jycL/UhU4wZsnzI5v0MI/Ddu
         j5XF7ssAf0n+EdFhW+dnHjpTGuPwKyd6B09kxAwXRTESkO1VJrymkG+h9s36A9UBJK2i
         7W9g==
X-Gm-Message-State: AOJu0YzY1SApMhGT64BASMBL/YCSvF6PEws5uxsRUcbGWzeYI9dA5jwf
	6vA6HxmjRSBrSTf8hJZnqkZTRSyfxuoYrx8trloSC6fv/FRFOnz4iS5VKY5KClKqR2ns6f+zSzh
	3US1DZFP1G8g88TtJZcp4+vf6mG1mMm9VI0qYo0PqjCc9D0E9a+/WI+lHkiw=
X-Google-Smtp-Source: AGHT+IHg/oHatCLCzaR81LnKZoJz5U+lB3Ya1R88cno/Y6Ky/md1gEFFvrvvuALkoF33Gqtf3yAypxyGJDnpaYbEItwO8NlcmAmX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id
 e9e14a558f8ab-430c514e290mr422258935ab.0.1761322264079; Fri, 24 Oct 2025
 09:11:04 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:11:04 -0700
In-Reply-To: <aPueHB4AaBdRL9hL@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fba518.a70a0220.3bf6c6.01a5.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com

Tested on:

commit:         6fab32bb MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17292d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed2b1ae1fa9a0fdc
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15957734580000

Note: testing is done by a robot and is best-effort only.

