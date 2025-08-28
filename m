Return-Path: <linux-kernel+bounces-789934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2CBB39CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93561B26727
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB72DF6F4;
	Thu, 28 Aug 2025 12:18:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE19312819
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383486; cv=none; b=sR9QothyecmeHc+t0NgjYYUN8xa3ZvTzWPYk6wwBgJ6XI8A2MDysS8AuejCxn8Ks9YU/bD4ZmCTnc5uOpdaUqlA0Vtd/4BwegP/he+p4sSucHeHjBghmGyz58Inw0vQuS/s1VSp+PK/omfzyuty+6SYG+ofADwy6j3uxZV76ZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383486; c=relaxed/simple;
	bh=iOuaKF1dNbboduL/nL8OpyfvwOgutM/lVkzdd5cm3PQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d+QLWLmklASL5v6FE/v1LVF9bFXoi43/2DbL1gzwznve1KrUuUzPeVvUYTPHBNbKvPL9tw9HB2oxR3BM4KLb4yY2+vKop04CE8SX9hM7x76jRrNsvfoFeCCyHtHGQQleWClXglofKyyptIy+yK6nHmGnyUs6ACg14IaDNfREKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3eea931c037so25224695ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383484; x=1756988284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6y42r4UWmGPFciOY77c2je+m3ndimMjmMLvFBVeH1k=;
        b=osy+l1GLx9xggwUMy5wF1VsRkAekbzcQSN4PVD/DUJ+s7lgD3te3vaYnorwkbmqYZi
         lcekZfWk/DLkzPR5YMqy9JvISTE7hXm6YAKflQ7AIoDdE4QdToudH0CnGTTPFPvzfN8t
         VO1FVvfHoxe1VaOmW09h+wFpZsIkABHTIZP7jvkOswEBGMG48SCf433na5x3QwkjE3TY
         4JNiR90Xl0f9ScktYwfQ9xJwUKg0+Qf9R4hoLnaczv2O1TnwLs+wnhD73sKWNzcTvfRq
         zBXCbbvQPmegUfwp8AAHEEqorVLZbVFYOocTCVrVf0PyfUSvLiFvM1xunHI2WMH62Z8N
         IH5A==
X-Forwarded-Encrypted: i=1; AJvYcCXTqaNtoRzgJj54anIdG0coWlco6+nDCtr/qD+Bzbe5vueSD1yUDvZ+shbqZKoSeEUFm+RtMSemFo7kvGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia07bU1DJLtX+dMzaqXtFZ5IFGgkgfqThw7rTd9exBQekAkiR
	gOq6JB1HjNr1cZ/SzCHrfnMnZ/kNNzCWFuqdfoI3w9qMx7fHWbXr/McvzTRUf6Zm1U9hATCE5vM
	JEBktdjLOn/EyDmhVSUoA+hQOX63Lnr2hNkBOS/PDS/puWY6o6h+P0tCBiLE=
X-Google-Smtp-Source: AGHT+IEZOnalZCmI58HXdruc8D3MRyh/f3UUrFI3lDaW6leqEiaH32dsi9AapXpOdwvs5P+ZRf1n+S1namnobrH7XAugHUhcFrKT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3f1:a5b9:4a32 with SMTP id
 e9e14a558f8ab-3f1a5b94bf4mr15170655ab.1.1756383483799; Thu, 28 Aug 2025
 05:18:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 05:18:03 -0700
In-Reply-To: <20250828114755.5981-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b048fb.a00a0220.1337b0.0007.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_process
From: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+69c74d38464686431506@syzkaller.appspotmail.com
Tested-by: syzbot+69c74d38464686431506@syzkaller.appspotmail.com

Tested on:

commit:         8cd53fb4 Add linux-next specific files for 20250828
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13053ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e373077dd6283453
dashboard link: https://syzkaller.appspot.com/bug?extid=69c74d38464686431506
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a93ef0580000

Note: testing is done by a robot and is best-effort only.

