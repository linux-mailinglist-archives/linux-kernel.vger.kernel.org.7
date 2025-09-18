Return-Path: <linux-kernel+bounces-821867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C06B827DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868D33BC5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C721E0BE;
	Thu, 18 Sep 2025 01:28:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CF21ABC9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158884; cv=none; b=nfFrwpUMc/JKH1qkJrQbcbWXqsJracD8PifWmzOhIX6kEScEfwcBAHZc+NKgNiZKeVyMYtBfczE91H9a7Kr9emJi3pf5gK6nkuaMRxsNg1H/8KJ/C7TJCcmUo6GJDi3Tq7C0OqUlNj8ibyCnirVquZVfHkUhUx2mo966DllNV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158884; c=relaxed/simple;
	bh=19IbYtW8l+TypAV5lX/tgnlVaKNS2anF502EuvTXCAw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=as2ArfBscW1Q4bVDfDZZl9B/ebGQbDQCDRDYw4JN96cdLa01sIwozB2PXtzWuTGys/Yadi/UKn1qMs1kiy3eSrtgCbgm9lHt00/2qPaS87b9B34iSX9MnUX3j1CiqU+kRUzAD11fu2cV8x1/CV3JInZOSncHIJsFfcI0+fDOIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424122ae369so8937425ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758158882; x=1758763682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLvdiujQ7v4S0pAY/paFyDPgfHdT0VEAh38g71bQSM4=;
        b=S63oB+aCCgyPVY7vIDTPOIEc5XJipZdTJapnhI8nxbrQdjBnCIojrdbDCoAlx+pD4v
         T74QE4RpXM1QneGZ2ESFP1FpCVURjYuXLWzLvv+5elS1yxYWMTBGi3lRhldEFE39wOim
         DVM3iYFPSgZ89vU+mGNWDBazlDoNq9SRWGQpBu1BcQLK2UbryNQ0zUjapFzAycVmj3CV
         yXKPZdAEnLP+AEjPOQEcNX3VW3x4J6z5kJqCoHVhgvzdOaifgbFE7YceUuFmijr1wn8q
         FsGkwwNfzyjaQtIyEpEaaNV3cYi6m1m6OXTck7ZYLav0N4TDX+KvSfR+374watt4b6i/
         Pw3A==
X-Forwarded-Encrypted: i=1; AJvYcCWEPirR59hYlQATQrUCAWqvxDyW3qfMTd3q/xp1QytW1pdwlPTDUVV/AbnjffalAyarvZeXRcO3Ep3C8Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpktpBVTBMoCeYVgSHMp17syRYv7sULZ99rJYYgaTpQTBYqVen
	VjbjWyT/Fw+IdrZYGs97mj6Ww3RgKm+kdG4LUq7PiSL+jho2qmz/0siXE5TqKuMJQ9lrsUmU5Ym
	NrqNxCznxjdLZAhRThngRV+BP9IkmYEc0G/Mg7A6Dhdvs5yLlq+332hM3ztY=
X-Google-Smtp-Source: AGHT+IHKShbO4O6X39J7xMx6G3aRzTJdlYafJ5BzIVrHr+2GZldLbFCYtNNF9QYliJO3GX1vkT2xKxFYjFac1Dk+BKV6Zh3Z7vQ7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:424:61f:acda with SMTP id
 e9e14a558f8ab-4241a5380bemr59603465ab.18.1758158882294; Wed, 17 Sep 2025
 18:28:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 18:28:02 -0700
In-Reply-To: <CAHxJ8O_F5ssDpCPi48eHRY=q29odqrjnOxfvdoOd5xppdhht7A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb6022.050a0220.2ff435.059d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Tested-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com

Tested on:

commit:         992d4e48 Merge tag 'probes-fixes-v6.17-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102e8712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b0ae42580000

Note: testing is done by a robot and is best-effort only.

