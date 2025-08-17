Return-Path: <linux-kernel+bounces-772335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62143B2917F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D036F1B23DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769911F1306;
	Sun, 17 Aug 2025 04:13:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7481C3BEB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 04:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755403988; cv=none; b=QnUW+Br6W74fYZTTcum5//Wfju9SAbCTLW0Nv1Xs9l8bU+AiW/TVQLTJ8/ch0f73M9yn+1PQ88uuD3UXvAot+WNMqfyqIj7fBYn48kTgZKg4oDydeYJNnRSiijk3NZ/HbL248E1xSU4Z4J54td18wOfxUy4AtUVSyEYOhaSRh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755403988; c=relaxed/simple;
	bh=46aUcqfVO3pCMJIACTc55IUfbiGPKoskdpSRs0lk1Wk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DmpU6jEvbt6GnSW2T5oTbf7hBKU/Ns3CTQm4uPavVqoW2c+15qI+Qs/hrhJIA7lztfwxTYT79UpPV+bz63Aklkg0M7kBwBHbIiLdUXYbFrqfEUXhe26Pr2XqzOhYmCSAx3fGP2qtg8nOXMIQ1UNX7O2cpyYDrIZ2NQ+4iKy6QyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e6670d5bafso10360965ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 21:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755403985; x=1756008785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=896C+BBvPR7FNworOurkczGjL2QsirgbJSwhGVznuBw=;
        b=vwkt+Jbo4oAjUNmGWjbPOlr0Wnx0qlqJsj9t9G84ygsTjVseZqOYKu2x6J9dL0w+H/
         cKsM83rwo+jkwn0urvHbgH/UQlC6gL49rsHZFTSK81ZNzBvS1MfvSMqOYpB+JE3XyJuD
         +PnfIKTDCQCfhrIFbzmeokTCyO+QNSb4vFPS6+cyXzSxcKz+Wi06FaEOv3PNGCOGzJxH
         JpCb1SPzTQUBjOVj1NLGFA2piMNIjND350Sg+Bo8H3+Vs/FkAsx1WoLrKxVl8uLp6Xqu
         Xx+0WXn96cCZcK5O105q5Vtc0gYJIScxhcbtShxfsodA/296/H5pTwNb5/Co1jrXxpdI
         ynew==
X-Forwarded-Encrypted: i=1; AJvYcCW43SHOUzR0UKfF9SU6gvcmoRHVcQ0P9/2lilmrU8fyXLuXcv/7cVjseNn2h0CrV8U5dynewxyrEB5DGfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgXzDw7Zznoi74Rfw4jwHLM5de0hYVnE9kcHD6k6oU6F+hz3t
	c96idpRzJpC7UkBhU9NLbB2z7NCZ4h41zOF8SSBen9XJ8WGfpiZYD3h397RPFLutFeueGNKoZYG
	8jWgc5+cEfu1daVCxfSGm07svAUD9CfX2Or5o5BT1YSR4wa30rR1UPou90rI=
X-Google-Smtp-Source: AGHT+IF4kc7jnWsVJTPS1jcDq22ltdTyrdLstJput6bS2W1uwx0AbFK13ZSSA/Gq+HHKdDOz/KBsuR0WReD/z5F3X/P8xPcv6HmU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2709:b0:3e5:4e02:a561 with SMTP id
 e9e14a558f8ab-3e583905a1bmr73539875ab.22.1755403985292; Sat, 16 Aug 2025
 21:13:05 -0700 (PDT)
Date: Sat, 16 Aug 2025 21:13:05 -0700
In-Reply-To: <e5ee313b-8770-446c-9dfd-472740f01bc1@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a156d1.050a0220.e29e5.0059.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] general protection fault in f2fs_check_opt_consistency
From: syzbot <syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, lihongbo22@huawei.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	sandeen@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com
Tested-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com

Tested on:

commit:         b3b0143b f2fs: fix to avoid NULL pointer dereference i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=108473a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13f39c6a0380a209
dashboard link: https://syzkaller.appspot.com/bug?extid=d371efea57d5aeab877b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

