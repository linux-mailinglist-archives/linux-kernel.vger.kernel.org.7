Return-Path: <linux-kernel+bounces-828736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD4EB954FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D3C3B188C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027223191B4;
	Tue, 23 Sep 2025 09:48:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D12E2DC1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620885; cv=none; b=XWaIPL8sSaoUy7lg2hkCVWrV3Kt+CfZjBtpgMJgEYz4qbb3GXPV/lJ0WfTVx1BYbSeZMkW6dAOdUTCMlvMXxh7J9az++Fv0MvnKBT/idbkABAbdsATDuWyNTNk5/Ba73ZBZYjLwJb9WHIy2i+bScmS5jUxvn7aX4Gr4/g+6ekb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620885; c=relaxed/simple;
	bh=iJfbF9SdN/Hpd9Osdn5sJLcgQ1JUvXWsr9hpIbC1s00=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Po5FVb+N4qt9DLYS8z860CYMiW/waGit7qpsJ4a0KGPS7uAAhGVnuVvmqUAqsgprhG+Y1s6avGm4MeTzpb2Vi55Cl4cwVJJvSFhCaqK+rcklhg5vnGnTI2Be/7sx/Gn3UZaOhJblEWDpdbVHzvcEIuoJPGTQTcr+lSmUlMmTNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8a559429a55so1143169239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620883; x=1759225683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cwy8h9G32YXL1DmlIAMD9s2W7uMLGM9OE1sZngoAQ6s=;
        b=cxKyzHhKuWozm18iJoeL9M7NjaUe/kAZJCuewIt2YZeHJ3D6fSu1eDvucWkpoThRDx
         MLgBqgjSdplw7Yz1Kr9dLnQ1VmAvNlQY6/peKpJ4mssc/5y9ez1d4rIf1dMprspHsVU3
         eXhhbBjuXvks4Y1QBVZ/xW9qeCtSv1StuX0BjJwuiye0r00jKhQWhOOUrtMwaVl1y13q
         FGVC+4Gl4jNyorQlik6zOSkD9B4WsiTT2MJt9TDnwm784LBy08vh0sUKDkc+sqpvkIN0
         2fQv81asht5VdUiebl705FTnGOarJtF6yY+QUH8rQOdDcVox/AKbssTBv3sjx/bv+215
         LVmg==
X-Forwarded-Encrypted: i=1; AJvYcCWwLrxHzNy4ruc+NNZtjjo4fy7dyMz8Mr4oQEaCfyK+dU5p1xPg8XXOi0IDqmB9Kdyqj5Vf7YIRzA2VH3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32n5cnL6GHwJ8QnYKDMs/2eu0Rv+CUIs928qDG0poQEO9oCLa
	EdF3d8jieIRDFWYOK+cxewJToLKahXYSuY46EanW922ptKDtszzO3K+kFYh6hgMXW8YOaHaIFHb
	/Kcr9vfvHSrHSseRp7HuC1P5faFlKnC6AOxSTXoNXubXjRQqZZM2Iud05BU8=
X-Google-Smtp-Source: AGHT+IGXIIYwcleaJGiEKDVhIVoKRVDTEPE+6zy6JfPjXPOzPDOt4w5G5HwxMzM/PhhFatDohnZ70xTXt5m2GZFOAGwkCwkKf2Ca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:425:7291:22f with SMTP id
 e9e14a558f8ab-42581ea5f4emr32032955ab.32.1758620883324; Tue, 23 Sep 2025
 02:48:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:48:03 -0700
In-Reply-To: <20250923073935.7486-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d26cd3.a70a0220.1b52b.02a7.GAE@google.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
From: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Tested-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com

Tested on:

commit:         cec1e6e5 Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116b04e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f34142580000

Note: testing is done by a robot and is best-effort only.

