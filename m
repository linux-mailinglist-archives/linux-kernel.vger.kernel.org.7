Return-Path: <linux-kernel+bounces-760073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6ACB1E62A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871683A8176
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319E26FDB7;
	Fri,  8 Aug 2025 10:12:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B0244697
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647925; cv=none; b=p0KC4J8Cx1aj4tgXX3MwzAyu+QZsTAIdrFvb1UhZPCt7Z4prylfh5ka89dICBvB66o/ZR4ILRjyV3pR2tdYRhCdUd8vybkdo9mGq/vLDsYkEPDTdRMOzsYW7MNzuFsrMxoevhXFvklk7WadlIizaTwPCwE3N3r4biY5qyuINlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647925; c=relaxed/simple;
	bh=ofqEPgYz84eCMqoq5/ykQp79iei1YL/zHuokFvUXxNs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TwBpv/WtT5huFJMg9cpA1pGrV3EDB+NM4bbXOK2WEIBEcUqqMkU+/H41fWkOkYYcEJ8Tq0NwiPzoyhDYrtrBGnW9jx7JEssb1IecvWzUSq4IssRV+6BTWkcAZ6yjMEY7Qvt9mNUfRVq/nU9+h2mS9Kh3wbFhvSTcsgnCOjg6Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86463467dddso207158839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647923; x=1755252723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twWFXuhRQyVstCOvDFpwC1CYSoFxAVC5SXmWu7KDflk=;
        b=AUSxjk4ra+wFDuXva8IBeaLNC3Q4gKDOooljHynvvZtipUjNEGDAVRkfOznUG96NUt
         0bCx9c16m4dVHx0yWW7FrJyKn7nEz2TwsuDHNRRqgSu/EhOzOqHrdBKtWOF4itfvh+J/
         oZKilf682A5TFLgE9rIu9iDJ6WEmllWj3Nsr6j5COQdSs6/Mssa8e3XDMPuZqgU47Vod
         sQIrIWM6h7zgQxRoSzpWKIGx4fMdgTICkw4cv70jA7HatltSaDTDE8D0V6DgKZW9cdZV
         TtnBUmtKuRm7z8Cv8EWFeKY8QVm8EI+CNRXnpZ5x1gZW43C8td1+Ay9/Vcvld/GSiWXf
         Ga2w==
X-Forwarded-Encrypted: i=1; AJvYcCWH4HxMs9BM0cGXk10pOB7RkAtBIHSFTtiAzxZWqSgg1soY6F6f00/8Jxcx/R6AH2YWRHUT24D3YhraKV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx216ARukUzjkGkB9MN0dLLsOdl/0aGjbRLvZI9lIs2yogXIsTG
	UwIvVE4WrhOxhOaVyKbkA3uEyh1RWqFH/FBWnrH2gNW++OXf0IIIBiVW9uwo9KI0kaa8/V5NT6y
	54wv/qLC1lY+mabIzewoiyvlxD4Jkck/pscxnoVmXI6NRYRMsfZorkI3mzSA=
X-Google-Smtp-Source: AGHT+IE8vc2ddi2YStgugfLCw1l5QWN4IahGwFSDWmZAbINPHjIjK7E/N0DRuQVZDGTcoGGjmQy9wj0quraAI+UBaPjMPPeJoikR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1546:b0:881:8979:93f4 with SMTP id
 ca18e2360f4ac-883f127fca5mr453469339f.14.1754647923690; Fri, 08 Aug 2025
 03:12:03 -0700 (PDT)
Date: Fri, 08 Aug 2025 03:12:03 -0700
In-Reply-To: <EC82157D-32AE-4456-9134-51B6AAFBED19@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895cd73.050a0220.7f033.005c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in invalidate_inode_pages2_range
 (3)
From: syzbot <syzbot+de1434c5355cc909b734@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/bcachefs/fs-io-buffered.c:283:2: error: no member named 'dep_map' in 'two_state_lock_t'


Tested on:

commit:         9191195d bcachefs: Don't lock ei_pagecache_lock in bch..
git tree:       https://github.com/alanskind/bcachefs
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a237c32900fc479
dashboard link: https://syzkaller.appspot.com/bug?extid=de1434c5355cc909b734
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.

