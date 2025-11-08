Return-Path: <linux-kernel+bounces-891370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58FC428D6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 08:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC23AD6DE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85326CE3F;
	Sat,  8 Nov 2025 07:34:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E814A0C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762587244; cv=none; b=QiLvVCOzTnTujFPUbLB4vnTa3Juijw3V7LDaEi4uKJrpiyNTDh/YtGk43jIIj75wD8a0X1O0k60ScEZQMmWMG6XccstkyFJWD12WKIHSEQ9qc5HYRusknGQW2fWLzAM4w6fVft+coxvBdh8WPKvFpz0Lc/aNxKS3XbQhIGImNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762587244; c=relaxed/simple;
	bh=/4SLitgfABOJ/ikCf5/gJToOxuGDOdxfDZkCi3jI7wY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tlvr8k6+W7V8XmTT8kzxcypx/6VzPUw+snPE+d74a/KnNrVgj0hVYKuPEubas5rei+HRxDxwF0gGcNikrFeqHBYsE5nH4cSj4EWUXg2rSOYC6BD+RAJDbSd7P9NgItxGJ5cKqkVMgi55wEWeCWsjbwnYNcErnY4OsFaRMcMcPNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43373c85296so376795ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 23:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762587242; x=1763192042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laVef2Mh3RcsXkV1dluoh8f4+51jG5K/EpjaW6ir13g=;
        b=I5Q4J1IsAYhkHOJFSJuBq7qlDgKNMp9XhT2oq6ulCe60vDzbQS7uKzn6xL4yGgaUYi
         G+fUcGLVC0wxnBD0a9H789y4ItnkIHaAZmgNU/0Au0PvQm7mD3KIw1sWbsJAxODfSrbL
         3ANI4/aUrjHaXL2xrZAsxlS07e95RNmumZpnhPBgFFj3qCCzDBdTbEGGehNVeSIuSY5+
         fS2e+zYJ6SRAWLGTi/vRiHz7T187EPmwgkOpjSDp2Up6BiucoPkSLEpxV7/WmuFGmpOK
         DW1Ldmv2Gyss/+QqFdzVYNiDpzn31QHYZlUnnlD0d/FEbPnEqRGhYDZoxYIXB7AZLIpu
         iXHA==
X-Forwarded-Encrypted: i=1; AJvYcCX9ovNAWkQYaTitJiRIaml8ac5SZdkrycPRXlDObEhdZdznuy7NHEQbvRvsODHWKf7UQG/zwq57IVgJmTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUyPkeiJD7npWz6mET3CHpMjcKNqJkSRAkXa3VlHYczjzCj/O
	eelmOO54DLhfkExP3VGpxsxPfnIDDyVX7vtBcMdDAgNGUGTvMFc09szuOYWGUb5OfSdWs9I59+/
	fNnawjkR4yojOgp6QX4RcXJcpyytt7j/xCnGCs6JSX0/5ysD4ACEFV5Rwm10=
X-Google-Smtp-Source: AGHT+IEoCw6K7YA9lbq2o2DnhkBdN9zwQ9XXBLqaYuftD5gjurl1q3PUYFcKOmBldeHa722UxsCupdbBl/Gs85Jz9Y9DoEWdD/3K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2413:b0:433:2660:6856 with SMTP id
 e9e14a558f8ab-43367e6a4b8mr26267755ab.31.1762587242502; Fri, 07 Nov 2025
 23:34:02 -0800 (PST)
Date: Fri, 07 Nov 2025 23:34:02 -0800
In-Reply-To: <tencent_AAB95DC599174FA90DA725958DDE1219DD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ef26a.a70a0220.22f260.0076.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] memory leak in gfs2_trans_begin (2)
From: syzbot <syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
Tested-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e60b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=63ba84f14f62e61a5fd0
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1549117c580000

Note: testing is done by a robot and is best-effort only.

