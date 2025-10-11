Return-Path: <linux-kernel+bounces-849090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB8BCF2E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B151F4E7832
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3283A23D7DD;
	Sat, 11 Oct 2025 09:20:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B7207A18
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174408; cv=none; b=kyq4y/+lRXMhP5AjC59Ykqg3wVd4aVMLRwMmQ3g6phq36UpcU7CextrPC6O9bMQ7rQYZSKEcYxivdUP25Fn/4xR2ekmw+TbAcs3iUJw0qmz2An1antKaHTdhCRc4PPUeNtJucyEDmj6e2haLx5Rf3IFNO4J0iIne2V3tDaMGzc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174408; c=relaxed/simple;
	bh=uoR5iCl06TSuJEKybwo9hzsSRh9KKwCS+jO3rdPrtgQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TDjNHI6I4P0uQWlKzuwfzZK2s1OFI1/ZIY4ju6YZK1huGVYsOj9dBkntfkdFnpe1nAL+7hD33uQnJtuNKcKwyBl5bB0dgLztnHsAYZJFJ6w3HFQC3RH5sSr4KWIGualtLIGoGyW6HMIpgtVmBR9WuBo2kzkooo8gTpHta78hVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-919d48f1869so2092299739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174403; x=1760779203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjiTOOXYfrDkGuy+IGNqV7zuRFDvWxSpBbVz/rW3gRE=;
        b=Rsf31WAdBm/mQPOtm/wwLIZNK0bsa93tGDLizr5On7OnvPWu9ooVqH3YhlnKWznIbN
         fEnrom48gM0RCZtshHb+9TLr3Mzrhvh40MJKiGKo95l7JDpgSyQ6pCe6rTtmd4I3mV0h
         0wkyxlC3ZBimiP6JJ6I2Qq5DPyX7l5jvVYIzFn9bOWixhSmcr1bOTlTWQGkFvn+FBrau
         t8FxkvQTtO+VfpOXiUSNyputkBSYbL0litzLWlyFk9JduT1xV9X568yW0ypVR10pCgKM
         LPm/vK9Vu4bU3MBu7x/sfUZ+OkfW58GRGqtjmthFbZnTmr5T3Dj7nqSYqYYPYhAane2e
         JA/w==
X-Forwarded-Encrypted: i=1; AJvYcCXqYje8iWF/6ylh0sUgdC39DW4+qCt3rFTxk5OlOO5+okoZgmcQOs1/oFrUTpV+mguYCrXWkM04F3d+YRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0611kSST0UhysbaJ0XtdmTTsPeiBb6bREf/K48c9ke5QXFUs
	FqSKqUMxPZY1b+tnJkfU/7uMnelqcGkRFuLcxjH9TLNh3ncWxzlRsVg9GwQunWhYRIprNstXbFS
	njrZaPsGpodPxL/mY5ruTYALKQxdt5Zq6rNiysz26hFMEra65aPDiHcSb+KU=
X-Google-Smtp-Source: AGHT+IHIx/fEEScZKonYGrmBu/nBVlA8h1a9UNlBcPcUL2wzdKBhGjEU7W4CUUX1nYdvLnQP9G5mPRbKDsvNi+mV4kFtaIQ4J7LF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d04:b0:93e:2f4c:97be with SMTP id
 ca18e2360f4ac-93e2f4c97d9mr644131839f.15.1760174402904; Sat, 11 Oct 2025
 02:20:02 -0700 (PDT)
Date: Sat, 11 Oct 2025 02:20:02 -0700
In-Reply-To: <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea2142.050a0220.91a22.01cb.GAE@google.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
From: syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
To: eperezma@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	mst@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com
Tested-by: syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com

Tested on:

commit:         07394736 Merge tag 'for-6.18/hpfs-changes' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=60ff1a9f60b0f77d
dashboard link: https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a7a9e2580000

Note: testing is done by a robot and is best-effort only.

