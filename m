Return-Path: <linux-kernel+bounces-882317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E9FC2A2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1956D188EAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22428F50F;
	Mon,  3 Nov 2025 06:25:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C527288C08
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151104; cv=none; b=VDFRQJQJnYkJGZi/M8v0Ps08L9L5zU9T30IIvYTMVLX996OE3MOVYlP2LYWXKkfkSTMgZjsM/AAkAMKkdqyZUUm25up8wITqPJmaknNQ2TqDcYQf6qeDxbaKWNhzMs6rl2bxolzfGGDhmNUd8I2XlQDfHt6/TWCFcgeZMfW7Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151104; c=relaxed/simple;
	bh=G0SF0FA8j1hQMKUkz6LyPU9KxutSsBicIxNydWCQJAE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pI52BBxM9JL8cD27JQhocjL5RYDHcCK5cXUR9N3YHU7wN9Uth8+STCfJ6FZLp70PPnqHzDyFxE9HUuLpLl1g6VEvcBm2HU8fCUnYz3/rlfr+s/EV7dXm1Gbmfp5Ip3v4uVrYhrxpEmfIRqcsTevaeFX2aDvyvsF2lLo8T3pqo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso6345545ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151102; x=1762755902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng9wAdTFuvOiJGsNXijGwRlUW63QJkYf76ZQ4RWatcA=;
        b=M+rEa8Ze9tF99x8Q9IbUBZ8mdkyC8p1/EmXFFtW+CguT+I7EJ0R15jQztIGQth5PZ9
         A1uyJvQDcRbw5T7yZcKnqObTk6kplsv73fZ/w/RPHx42kQNOZ2WW54ZjFmjpKJnECVdY
         +9iLMn3b6SvT+9Wpsj5po8QylwXRqR3LDg+DkEhCIAtMg2L9Hfe+cf1IG+zasYUYT8gI
         JBtmJcr7P+KzsSfs0oJQb34UA+13fEv2qOs4JI1jOFka++b61OQONKqoKUakuBfYc+P8
         wru9HbfXRw8sieyQ46EMWWdBOW4OIr1xNh4/5QN6FRnFmDRu7GxJlFOVgjBkrgFHprq1
         0Xnw==
X-Gm-Message-State: AOJu0YwInDlGSI916oKJTssLReD74J6lqltS56yhXP+Lx903S3ojKatn
	gO+7nlsTHdIGWCen1sugFU5X4OZPOGSNMr/cR2q7LzqA74kIs0mCrN7S9ArnBkGHK0ZPFnKK91I
	SHhW89f2BefhBEV2HdB9gjD2qCfxXKwsggTuWvw0MyFrKlOH+Rvi4BJmBCvM=
X-Google-Smtp-Source: AGHT+IGUr7vKzgrvPob8GQmFYyioXNTqDGrABrL6sfTZtLRxKb88THshCzHUaSa41b8XOCo5Z0yPwoFmJbysrtYXawlOEV5JVRye
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cd:b0:433:246d:283f with SMTP id
 e9e14a558f8ab-433246d293bmr75751785ab.17.1762151102436; Sun, 02 Nov 2025
 22:25:02 -0800 (PST)
Date: Sun, 02 Nov 2025 22:25:02 -0800
In-Reply-To: <20251103054919.3377129-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69084abe.050a0220.29fc44.0034.GAE@google.com>
Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to run ["make" "KERNELVERSION=syzkaller" "KERNELRELEASE=syzkaller" "LOCALVERSION=-syzkaller" "-j" "64" "ARCH=x86_64" "LLVM=1" "bzImage"]: exit status 2


Tested on:

commit:         98231209 Add linux-next specific files for 20251103
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=55e89517f3847929
dashboard link: https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169fd704580000


