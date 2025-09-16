Return-Path: <linux-kernel+bounces-818095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C157B58C99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C051B262C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74C29BDA7;
	Tue, 16 Sep 2025 04:01:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E185C4A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995268; cv=none; b=T72mPUKW5j2tNuaGlda8GRxMrCycJvjF2dZZb0Fa94WZJCniVetzttVZSVKNlGbboM0ltoO+DRat4eh6p26auIhFJ8MD0q6ifRNW5IHp/EaqjO1W7a0xF7135IiMZ62fq93RxfpZO8z1JhRiMr1S+H/CFOBEiSFChegnFtYc284=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995268; c=relaxed/simple;
	bh=qfe0a7sILNSq5vDFlgejUEZUwllN1G+yo715CIRxNlQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R9xcTExL7UXP2A3hD3ZsGtV8MkSshOR2oOwUXryYjBzpuHw3/bJ1UOokFgmUw7xIdnWIwG/XU765rFWG3Eda/GjkbC6EDLVVbfSzjR0et2TJhNQxlw7LDMId8174PsD2rjIr7YOTRQk2C2Hum1vo/s49PQSZ/YMJH9THux9j4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424074f3f83so48305425ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757995266; x=1758600066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qF15vR6gap9rhB0dZ6K9k89kc8NqR81OjVhtZ5dfO1w=;
        b=vsr72w7xgqThq3TArdrrUgDkpIITgm0+JXbEkjEYeE6fdxWBE4r4kZkGKcb1ec831t
         K1IE7Xm0lA0Tc1WegXD8g72PwmbU632oVb9AnSYj70msBzkXL8Gk15AiCDyNERkyhieG
         /Wap+Q08b2HwXJAyGhrK/zCxd9YoxUBlUKMxYOaD14kFIAxA3seM61nMJcY158sgoe1A
         tB+JRnqYWWOOcJ/bIli4uvYs0QiMrsf8VhEcgh9+sqNnNvaWRqYSqUoLiWR4vdA9ETx3
         Rq0v4/iAll3s1n57A5RoFXBJ8QNu9q4+7AAEle172PjQ7DFfMZDkQ7X8j77SlFpiJWIJ
         kptQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWAESrj01MfBQIjpNdjVQ6S/OUh+21X0DmmlyLyxmO/Ek5XuBte2hgDBInEYANbZackMD3EHur8w58QlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziCzptfylaib10IORL9YOirL0Vng38RYHz6BntPpS2IpUvHzmm
	RHPVeBrgGXPYVHETuiKyKq9MjZzXO9z58LWHG/nrrNOwZeqIhAX++MKz7zaYKLbvBDPzsMfnZqu
	ZM4kcD8Fk2gqbgJcShmJLD1MS01anZm8Z+DxVvfDgYvYVwEUZFSSO5EZ5Srw=
X-Google-Smtp-Source: AGHT+IHQa4qGpCWAKai/DCosZO7eCr5uxF0avbYJrwL+MqW+QwNZ5yX1HR6h9z0lMas1IPcGORAXjE4UDjkprzb9nKWomco8UnA7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8b:b0:424:db:3f50 with SMTP id
 e9e14a558f8ab-42400db44a6mr67889535ab.28.1757995266339; Mon, 15 Sep 2025
 21:01:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:01:06 -0700
In-Reply-To: <tencent_9F73836FE96783BC44575767376BC6CFB305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8e102.050a0220.3c6139.0d27.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_set_size
From: syzbot <syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com
Tested-by: syzbot+bdeb22a4b9a09ab9aa45@syzkaller.appspotmail.com

Tested on:

commit:         c3067c2c Add linux-next specific files for 20250915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1605fb62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e269dbc7717119a2
dashboard link: https://syzkaller.appspot.com/bug?extid=bdeb22a4b9a09ab9aa45
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104b8e42580000

Note: testing is done by a robot and is best-effort only.

