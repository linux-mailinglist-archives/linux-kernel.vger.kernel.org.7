Return-Path: <linux-kernel+bounces-823922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A025B87BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BC33B6985
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82D2472BF;
	Fri, 19 Sep 2025 02:44:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E15221294
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249844; cv=none; b=VaxcWg9sG/n1vw+gn19xsh67yjGCjvvJdbQHDAFWYXf4v5/ir9TEx1MSem8n1oEeW+yNN8UM4m/DcdKtAqOHYtvquRIQBKgTHcX+m9nFxRH+87IPf0DWJasFI196PxtOkZX3kC9l1IQX5haLoFsXUIP4/on4tfw056bs5svqqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249844; c=relaxed/simple;
	bh=qWLSbdYhZF6N4jaF7tOwLoOWMzvLIYzP0oFrJUtzq+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iQ2QukocFKfwbPHS0ktcIey1SLTGgh8wjVHsDrOwueYbU4Z9PMtaFoCSLGVLqUoYnQ4cXe7WTwieN8pgPgViSfjYJaaAedm41HX7Y6FVegxubtchf6GAuRdSJd6CB0yT3PECumkvA1XoQvdzyjb5DVp7JIX2udX+OkuLcP4psKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42408f6ecaaso22586275ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758249842; x=1758854642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSWEPjA29tF6yViPpxpj8zXJtFYi6+inhhKM7thvcBA=;
        b=tFvWDwK5kK4UWTw5OSil5K+jrHMBQFDgXAwmTh83ag1SdTJjOxHeNqSn+lfTgMM/zl
         mcw5e1aAYwtMPv90QrUDooloZ/WVe36HtTW2iYUu6rxOZdaZzf9vcTr9k1icIX1CFUuf
         2KH67F+WN7ZM+QXsPCI88Fe5ry3rfRSuAwPi1xDw89uXTIooemUIe4iH/ES/dpM/PN1R
         Yaivm7TV/zVX9JJ7k4GuctMHrPb0sGADxX9nxziytTEZuNPDiE3VKxiTNAPqSkRW71ZQ
         84iC0dyL9AQaz2t/5w/DUdJsypDqxEVu5ALZ77R+W4H6/MvhYb8rJIHDCTTCOldX4s8J
         I4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSaz12bx6m7Zp+K9BZZ4Kkrwe6nReB9fi8zXdXGDupd58J6B37/OJm6ffwNoor1U000azqoLt6MM4w2qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKvLgYymN0w7TCEzbWPztZouWatAF59NGqvVnrT5OBs4ka+fb
	pjodxnjzvFu7LIGsJc+x/0yfusvHncDFMin+Gu2CZIv/ZdM3BWNGmwNzF5tDC9H9h7u8uyZ7THh
	kY6W2+UHRDGZrp5lJc8IRcMfRB+d56x4R7nh29KZxhoZR8x90HJAnklPZSVg=
X-Google-Smtp-Source: AGHT+IGbAeyXjZWIbV4cZqSg5KeYT+LWlAjVRWjB8PNvFzOY2qIAiIDIzL8TCXWoFFKPoCzB0zPkIE+h6vsPpYDaNncgpQ+VdgbQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cae:b0:424:81c1:9481 with SMTP id
 e9e14a558f8ab-42481c1950bmr18050685ab.8.1758249842141; Thu, 18 Sep 2025
 19:44:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:44:02 -0700
In-Reply-To: <20250919021852.7157-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccc372.050a0220.28a605.0016.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
From: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
Tested-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com

Tested on:

commit:         097a6c33 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ccc712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1574c712580000

Note: testing is done by a robot and is best-effort only.

