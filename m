Return-Path: <linux-kernel+bounces-738010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DEB0B318
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A31E0110
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4CD41C71;
	Sun, 20 Jul 2025 01:31:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28B2E3701
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752975065; cv=none; b=GBVDF78E4VTORvuTRGbQ/rhF9xdqyxyCPxwsZsznmjVxNiVdk1SkX65GpWBr9WjTOT4Lup0alaYX90wpmQec/vu88UjpCjxN6qCia2BLgTOMNndNBgMni5uyYAfwdxpIb77WxysJInaXgBGuzE9BsdNpIvCeS5R0dARLdxomP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752975065; c=relaxed/simple;
	bh=mYTY33ig550ZQnBEhDOOIOtZsNLfHn/5Dp9NTJ52UFw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9NRqEHl6SZwrjUGLt55vRkYyETb3LMI4Sf6BHWlTwkROTtUuKhPrULpSvIs3H2J3j7csayVjSKZ6Ajbx8w3VTL85+slzslfZOrF8Slpu8nR14pIBAG3dyVYX2GuAqFXLhqsGFbWXaBF2/UNES9/s/XTWmSi7BGsipPreY9y/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddc5137992so32664825ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752975063; x=1753579863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJivoAZoAl6ShpiqYi/bsewA52aq4GvVMkfyfDVYBWs=;
        b=ujg07GPVh5xasWYLyss+uSbFJb62X8WHp81/XT+fBYdRPWc8j8Jd9I7M3d5s2DzHs4
         Aa4q3eBz+/95laD3tzL47v+wm6Xuu+2Uh1Fo62t8GgLOayNAc/Ztp4rQYBhUjYWelfXK
         +SlM5rLyhFnrwpq5gkWywp9gSoYK1LgIHPMvA0oQ77Myx7pwDzFVn93iDz1hQrMva/I3
         QOrFOhA8B3fOplk1V/4aUIa2/LUiPalWJdxUUCa83jRHpt1KCtAllI/uSgRlQZYglF7G
         wMqpUtsL6OJ51TehqrbqNvcaE0hcBSQ8/3TaaSGnmKet3AN+F55fiI6a+f0HCvA0simG
         zSsg==
X-Forwarded-Encrypted: i=1; AJvYcCVvFTC1Vb5/hA/rXCgI3O//HcDIAO4KDxH/tt2diqc5GMIIfDtbZJ0WUk+JHnGIETi2PyyzE7HfMKXXZBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyB6iH+zJ1Q0Kfcqzn0iFC2y6MDDwvKCHdVNND8TNCaTIS8Ty
	YtpdEjvkQkjWETXghWt9f9bgu482j/1/q+EFLM3w1gydVrRI5ewPdAY+yJLiLy3qmW5WxVM42Z9
	aAJnOLYJAsexa39NaxQ0I/EpJQg+QBvKHQjpT0fRSz0Ffhv1pcAMe5D/WzCU=
X-Google-Smtp-Source: AGHT+IHHo07+sL2nq6nEIYeHvoiWbPt/Xg3T6qmrr06jPDDATyCYhcYxcY6OzfzQwfLgZFCcJUnRxFBS8t2H5rRuA2StR36x08ZO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260f:b0:3e2:9f44:c20c with SMTP id
 e9e14a558f8ab-3e29f44c251mr40705675ab.0.1752975063384; Sat, 19 Jul 2025
 18:31:03 -0700 (PDT)
Date: Sat, 19 Jul 2025 18:31:03 -0700
In-Reply-To: <20250720011228.2536-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c46d7.a70a0220.693ce.00a2.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_poll_remove_entries
From: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com

Tested on:

commit:         f4a40a42 Merge tag 'efi-fixes-for-v6.16-2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130904f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa738a4418f051ee
dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ab37d4580000

Note: testing is done by a robot and is best-effort only.

