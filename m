Return-Path: <linux-kernel+bounces-849158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C013BCF4FC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174C6406928
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B826E701;
	Sat, 11 Oct 2025 12:11:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17921684A4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184672; cv=none; b=uFT6p7Nqnmy18hWtJ+kiV7znFot/V4tgFIJKrctSmnBRxTW8NEVAaEfWkVNtQOHsbifIIOLUvYn17nX974UHdCK6DJcH1VXwNRq0QgIkFH9gjqWWbZxW81gfpV1w2mrXccQ5URaW+rxeUm/WPq57cM2MO4WqAjQHSZUtSc2DSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184672; c=relaxed/simple;
	bh=ViLBxRzvncMncy4TnsZsFgcX2U2il8NJbKbCRKFML/M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UeSQE7y4gM2H3BHvvzjbYtebLc3RZK9iJudsI+ic9F8w4/042qUH9K5pTcd1tNbBEXFPP5HzfIjzp4iu4tJKKj/qDnOdFSjGa2/fLVQRFCikNXtMG2CaWDdpEDYvNVUh4WP7qLzwvVE+0lC35k9HFUFTl/WJOK9GlZDWytm9+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42486b1d287so226744225ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760184666; x=1760789466;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mj9iqvasaGaDRq383sgneJKHkYKHNGAemKNjEN6kCwM=;
        b=n0E4mk/GcmBJl8+8kUJMgWh2KQi88wFid9JO+B4/DsgB1KmfqzcS/48wuyVma/4yw1
         wF4IembZn7qhVMpaizu0c5Iay3rryybK8Echy2xqx/POM2lJ67CpM8C7468Obuvl0juN
         zHe23Oxj6TFNzw+7chgNiPdOhB0O8E8W60nzX23ioWoEBTkElmpy94vXzfnCTCy6UBsF
         eCg7hL12PTJrLMKY8W2Rf5WlUn4oXqBibM5dRVk6GyORbCGVe6VV2J0lcVveBOwomAj9
         DU0HRZUHQSMT0JPDdv0BesB4TC4+2we0aII16OLsG2/NUQVCLPsGXDVDSebNjbHBCK/K
         S4zw==
X-Forwarded-Encrypted: i=1; AJvYcCX/WyoEFnCTdvdR5M+RPnKJxX6PA/BJmzDb5bkSgMB0NwyOFAvJQGvUivlj9iufYmAHpAtUfdyoqHQM8cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcA6aXtFZ5vXsFYVCu+ZYqbr7dLy2KRUQLBFtLxJu97tEMZmq
	hCJZvk/HIvE9uK9g1G4VwPfbrgK+CM7wxawKPu+Z0QgDff7IZb5lZApvO2mhHrB3q6Y6YQ/8xkh
	0t7xADfdV+TywDPwjy/wXBluyQ/LnEOR3HnbGx8Vagb54PNkTie83b+lcI2Q=
X-Google-Smtp-Source: AGHT+IEjLzrx9M9XUNYNxzXxCP3IxprruqOtOxpvwj2or+6pH5lw9/7zVS26dX8ObP4eROHa29iPrWuvjxwy+GiZ/eeTq+68pGJW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a09:b0:42f:9501:69e with SMTP id
 e9e14a558f8ab-42f95010904mr117367385ab.20.1760184666027; Sat, 11 Oct 2025
 05:11:06 -0700 (PDT)
Date: Sat, 11 Oct 2025 05:11:06 -0700
In-Reply-To: <91f995c8-75e3-4b02-a7f1-be266a90b061@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea495a.050a0220.ac43.0000.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_end_io
From: syzbot <syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
Tested-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com

Tested on:

commit:         591c8102 allow to sanity check in f2fs_write_end_io
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=17b469e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9acaa7b581f88665
dashboard link: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

