Return-Path: <linux-kernel+bounces-893140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81331C469E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7664C1884E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24F309EFC;
	Mon, 10 Nov 2025 12:34:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9745223EA88
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778045; cv=none; b=VKR9VBuzn4YSlcXlYdtWXnwIMqFOqyDxvKBayMf9jJRS//lgOCi1bL4zZIR6A0FOWDUD+kXJKXWv+3CFTFrm0GJxf3YywpAZ/I6ayeV+p6CtdSbCvkKnnMQtPRUEUUtC3Z48/MUBet/cy/j46l9nKygHQqeku8o90XnBgicqMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778045; c=relaxed/simple;
	bh=H4aTEk4x0uicZGJRyOMveprMuyEHk+DiFnnynKCK338=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uv1C7AY6SItKkMUFiFXAy3DYxqn0Sa6emsTqTD/NTAQcLM4Dhk/HzezY6thHSz31O1JBOMXjlPx3/+UB9gqgtZ1k5saw2eYvFggn8dFx7b7xGq6TYka01UsifR64JPhFiuNIiiNEevjW90VYq1TvZDvw/Gcv5MDxYfAP9QQvpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso920566539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778043; x=1763382843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuCVQgIuzbSUpXMrKZsoqu8jiwRjlx+qtRH13QdaOQ0=;
        b=GYzViJaQVGaUXtHwY9h6X+XkD3+pZhtKNuWn6d2nE3ETWFH381HixEeq9ORa/y8rAp
         I9mTP+MC/EwXgHynq2B4mlCxO+ZSytdNvCVhLFbXXW5QHCixGx+SzhHw93SfNr++u4u7
         i8Dd1hVhtDceLs+qGo24KnmHDNNP1pJ2PGLZNebjyGiemuoRbCp6f3v+dAQdDk9XIdqI
         jzpwKFlicAGj3DwsQ/nkdO58kXsMvZtTXa/ntPZqsm4dWjsx/zKJ+W84mQuNIvA6GPsw
         DFUruebG+MdCAUAVLrhVPh+XGZsBIjbgtT2cmx23II71auWRAj8GBgelsoN/XFnI3o5A
         dYSw==
X-Gm-Message-State: AOJu0YxSmjQUpcPb+JKvf5IRaQWX26XRX3VEsP6e8rXUv+RPhuMJrMrR
	PPVLaMnlPMTPzvNWvy4rmP7ifJg0taQEKchbvcVD5b+yT37uv58q5qXY8UslMyXIQcsmKY8CETg
	XpioufYHQVjBgtj9++XVrE4Um0z/BIsUQQBUXQojv6sDVenWE9Mdg0VTXfwY=
X-Google-Smtp-Source: AGHT+IFme7LU0aHTE2q8/Rhsy32CbrmGkg4yluFGjZjtTwpyV9vvky3NCLrS47cDJ/yrosQFucYh2WYA8JZ8UwQlqbpwbkqKfGjK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6418:b0:940:d7bd:a850 with SMTP id
 ca18e2360f4ac-9489601ee28mr1076950639f.16.1762778042716; Mon, 10 Nov 2025
 04:34:02 -0800 (PST)
Date: Mon, 10 Nov 2025 04:34:02 -0800
In-Reply-To: <0df98fb3-9d6e-420f-99df-521c625f0013@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911dbba.a70a0220.22f260.00ec.GAE@google.com>
Subject: Re: [syzbot] [jfs?] stack segment fault in dbUpdatePMap
From: syzbot <syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com
Tested-by: syzbot+f5a5b157b7336d1fda1d@syzkaller.appspotmail.com

Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10473114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=f5a5b157b7336d1fda1d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108b3114580000

Note: testing is done by a robot and is best-effort only.

