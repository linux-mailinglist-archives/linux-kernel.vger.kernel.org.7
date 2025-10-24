Return-Path: <linux-kernel+bounces-868841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC00C064A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B0F35C807
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890053191D4;
	Fri, 24 Oct 2025 12:42:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADA3101BF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309727; cv=none; b=puj+9TYTiTzm4WhV8sPo3G9YUozPUsV/LzD/SnFdTPbn5Wqz0aM5/aGYmfSsap+9XItoeABJqPEBqh9MT1riri+A1L1etDRUk10N3m8L3vMy8C9M+qM9br06qA858cR5RDGndMhK+J5aA6cFj0JvmuMozHJ1VaNHjpxNPHMrv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309727; c=relaxed/simple;
	bh=X++2Wh0qp0PFwLa/wZK5IWtguM4BpFC65DN78i3obiM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IYtPivi8C0Ouu3EHoxEJVrFGvzf03zlBmlw/Ah1VFyen5Ce4kb7djLOqTeSU6jl87/xr2AqQk4dGanZajLqg/Hz2Jb/D2e7FVALzw3+Kkns54NvMmaJWIZVLUJ4fkrY8qnJb/W2tjUzWdlxxT7O7CWaTHvh87rYqLhzcEvyduDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b3c32f75so21264775ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309722; x=1761914522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPfGnNANLX/yncoF2Qbr+vLUUjmZbKT9jCawQtB7U9A=;
        b=TFJ1vyiuG8OgAq8NcmkWkjsbLYDtl1bmd9iLDMiN4fc1JeOir2RWGHYysFt5SpF86P
         xkkq4EKm8tzxoy2Q8V72P9z1ruULtop0tGJ+v9YuWLSyaxmMJv5hx0XungH6ObjCsDLI
         PywGTYmUor4MfHpdC2BCr/qYnlTPtD4Ubpf0uDkO6wvEY0KRhQcyDL2LpDfIdNst0ihl
         AuZ8UmFf99JC9mXHg/XPYuE/R3p/y29ffVhq5aLtjj60YSF4JP0oj4NQUL8NAAcVEP0I
         LhaxYjoma4El0XcsSSCm32jgZ6ZWXOoiOktRwe/z+BeYxvhMtLW2mNsLeDOYUci3KiWx
         kR2g==
X-Forwarded-Encrypted: i=1; AJvYcCXRXz3f4eczIGmEzXGgyRlo1qs+HOCvrKd53ObGMS5yzoE9Xiuq28gkwpNr1smDlrB9tln94yNe3tCU35o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtXT+h+xa2MFB7EMaEQXKN9ghZf29o72ungr6l/gzKlTjZMZo
	FjzWGXAXasThX98M0lh6i7/pTLERrc5fxxZrs4hX8EBKyY0ifFESjvg5qW1h7rm8Qp1M9wH+h1n
	kIdcS1Ef2nmR8y4SmahDdcekD4mnxZXadLo3Mc09H0mLCFe03W7qrSquVZ0k=
X-Google-Smtp-Source: AGHT+IGj/KP0ce52YsqPtYtLBtc0BZwXMCdUpWPNNcuE5ZJ7OZ7dw0KNfETGSDTphNs0AqDP/3PLFl1ucI+K9PQg996zlu1GtIDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1947:b0:42f:9ba7:e47e with SMTP id
 e9e14a558f8ab-430c522f01fmr404820465ab.14.1761309722745; Fri, 24 Oct 2025
 05:42:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:42:02 -0700
In-Reply-To: <20251024071521.fbtQk%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb741a.050a0220.346f24.00dc.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14017734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167dc614580000

Note: testing is done by a robot and is best-effort only.

