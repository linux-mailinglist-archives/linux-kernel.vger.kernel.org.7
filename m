Return-Path: <linux-kernel+bounces-772877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22DB298BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BAA1965046
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21326B0BE;
	Mon, 18 Aug 2025 04:59:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870C26B09F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493144; cv=none; b=pZVoeG3aHEfYakDtVFFNf11gy68L4jlUD5qYFyAWDHb+ssDSRAZocp97RxVUnmLvy5rcHCi4U6d5+yHw/qPlQkl1gMEqGNxm9MJv+967kGw92WI14UXDdBYZTMyb+MjVoIytodHU2SlYc/p1oRcUgGQ1ILOjTPfhilobP3fCeXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493144; c=relaxed/simple;
	bh=HL3iWKbyEVO0Z775Ic5A7Wxm/Bznen6sKLNxSCOAXU8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ecdfCrW/cE9tNozIgkwlbgUGZZRV7bNho62Qf2W53ePZ+jVQIFV8AGCQs6m8SNic/KtbgkeHPS7ZT59nbWslASjEFH40Zp3+um9H9acySDJHquUtO79MSSI4n6FHTClPD8vdCnH3j9eW7/9yPO/pK8qH95lNz4lDB5GljJrVh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e56ffea78fso53986195ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755493142; x=1756097942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nP4Bm4a53CiWwB4rTPw6X+44aVpGw9UzhNb1oaSLqWM=;
        b=uWy2h4f0LMpxxziE6H3cmm6URcCTTRy9zwiUmxR5QSgKK0gluEzwRbtwpf4z5BepeZ
         908OpOFUpOJqsqZT7opDnHM+hq1Kw9iLGjBqyGrC28EIChtwPQcF6hEJ2NWP/65cX1dc
         haaNZaPuEjFU6Z45ZWbsgIhp9Pc6MVNetn+5OPrj/6eTfSkjKMo7YDAZ0VZxiMWkDi7X
         vciZtYeVcVEygQ5ofTi/qbm7X4OUeGM6suEPgncRtkh52StBEjNBQcH4r1tn0b4GBN0x
         j4TFZZ2V6pV04U+J2wKyD5GcQmFMq6fJDgycCemyJ+r/aL1vGaT4m3V01cxaJ351tPdN
         /osQ==
X-Gm-Message-State: AOJu0YyxEmyqER1si52VGctMLX9qgLQv/NBGzsCmBTZ/iJgKXuUKw/qr
	RqogpcknFMYLqbw3Yrt05s2BYhmeFSNXltEgGHWhfeP3SBIxMXVLwu40LVwOyT40O51BGSEDQxJ
	BwlTY2In1bbBf3LOQu3Y/djBosr2ljQrpXlniek9ScgT9Ijjlq/stjHswCvM=
X-Google-Smtp-Source: AGHT+IEJlp5SHot7mx0VtmSTraBybkp7lXgu7HEBNI8aEvssS3E2IwepMU6nGLuCtAclv9yOZnP3Khuwi6c4QtQ9c5pHBFT2m3OG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:3e5:5e09:4484 with SMTP id
 e9e14a558f8ab-3e57e7f99e9mr220242585ab.6.1755493142445; Sun, 17 Aug 2025
 21:59:02 -0700 (PDT)
Date: Sun, 17 Aug 2025 21:59:02 -0700
In-Reply-To: <20250818040521.604-1-yuichtsu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2b316.050a0220.e29e5.008e.GAE@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yuichtsu@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/usb/asix_devices.c
patch: **** malformed patch at line 13:  		 dev->udev->bus->busnum, dev->udev->devnum);




Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce98061fb8ee27bc
dashboard link: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f61ba2580000


