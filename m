Return-Path: <linux-kernel+bounces-754143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EEBB18E97
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780CC189F8F1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9023817F;
	Sat,  2 Aug 2025 13:09:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060C22128B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140146; cv=none; b=DI66Rc86ULjD9+1n3JsOtJ3iVFae6IJifC9YBbFhqnPFC68o6Gts4W9bcBcrAOW8+EGsyQwS2F16qezsplBL/qhH/hTNWzSZCWMTsvUxxL2EI9Pdx9dOIifmBdwKCPErrRWM/iLUnHnu3xzfwevMe+xP9sXvQO7dsz4npHv8c1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140146; c=relaxed/simple;
	bh=eO2C25IgakFheiXLnmkGA9oKSU9cWwlc5yyHhW7sPDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SWJgDbE1fvhIxD8DUsNCmwZtiSjri4FLYNLeLGmyrw9ievzIBB9xgCpvdk/KspTLrbywIS4GErt2sHBL+3oAwcyqW/fPnNI1XT2bXKg1O11GhFE5ZsKXM5NQraHlYzDppLNvn6g0ZtQMLexfS1BFosXLtBjFuIpeOyTt/WxjyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8816b8c2f5fso87245239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 06:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754140144; x=1754744944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kecL2aVgQyy4KXxETEgY9Q8Ye/ZLsk6U2AmOcUxvqTU=;
        b=bgrAIO8e4pyQc/ATT8nSKCAFGRY1BxquMCwL9tcf1xF9oH3ccAbYlhFubU4Wsqwvnw
         UyJYrRWCs2mTfXkZH+Tffbay4bifv0LDTqiA5dSoQKaHFn27Kkb6103fdLd/rGM3jmoO
         RN6CYV+Hu1hgXXKoV0HCpb5PBK2izPiImLCdPjt3OJTiYjVx3afb1K1jYg8dIfCuRk/+
         ACuUCaFhGxMkodAQvX+aKwqNed8iAjNFIhQo7t/EzHbP4MyGSg6tGp0ioSkT7UyoEEFc
         WusWdcAbwaBp9bnCemjIh3tuKZdRrnwpO0Uewyl8hSBpzM9qzg5RZKeRwk5N2GWr+76O
         Pxbw==
X-Gm-Message-State: AOJu0YwPXk+LCHQtAELqLGXzDekHMPQMiWfnXvjAX8yxmt12UH0U0qxV
	w4euXUIkztSZ31YkUvnNsz5NB3XEKTZGSteSFO77LsQ0aqOLVy2Ap6FM0t07+mKtTkRQaqyvftO
	Js+dUd19ui3xqUzY3vrDUnm2Fu8tc4fjYJPz34vavCsroJP4o9ltYvXQ6OpA=
X-Google-Smtp-Source: AGHT+IGWurdE7KI0BGnmdDQSxw5p9U40ZLMyS6+ctaqW/wNZ7eyzBobSTCm1CqC5GR9Lexbpz+47BTH3B9m3+OQaazvG9BWSIRIP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1b08:b0:87c:49fe:cafe with SMTP id
 ca18e2360f4ac-881683b3e5bmr443588439f.11.1754140143925; Sat, 02 Aug 2025
 06:09:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 06:09:03 -0700
In-Reply-To: <CALkFLLJjzTD3HpPLnaKwVKn-47rJQBghaSrpZCT8Nrbf3CiH9g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e0def.050a0220.f0410.013e.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ujwal.kundur@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file block/genhd.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a6923c06 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=921f306d77438390
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17bed834580000


