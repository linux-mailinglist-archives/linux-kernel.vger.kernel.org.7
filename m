Return-Path: <linux-kernel+bounces-772630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D120DB29518
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6410203F2E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E021C194;
	Sun, 17 Aug 2025 20:49:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8C217F23
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755463745; cv=none; b=UHfNFvAqmdQyDQwI3aHEiFJZFVynvHRrlOMG1xXnxJYxlWAw1gpy47VKn2iSO2Wb8+U98lOX8D4kjCaRz3V5GWFtwVBRrl5zNzWNsLLv3zwmaypAYKa3B6JpcGQmgntZ8B8FS7v9iIJsh7knKwuwKjb03DhTwAvR8lt3TeSjSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755463745; c=relaxed/simple;
	bh=2Kx1zgwIIBL+9fuUH+h3DW3zZOdL4Jcny0pzAvWuEMA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RvVMXazL6Yug0X1lYdkSESNRmyyOJ7gtwXnRqFrS3J9FqAfWuXN/uQaxxMz7UmHlamEaoY0p8o2mZZbxgJi/ZrrKi6A7rymMIGCSxn9YmOFzPej83fN4wKrUfDxsiQVO3eGtNWLaw4ddarp2G6DOw5oj+M1ZYcezRcOwtCMT5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e33c84so1038595839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 13:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755463742; x=1756068542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kchLK+S5t1W/C5OwakkJrRxozTYQHPngSHdTJJbSJ4=;
        b=PH/jiX6Q2fevezTzYYAQckmM8+sLm4mxRglo7U1Qw0TgYm0tDZGQU2owVL95CdZAbZ
         NlhhzXqDNG+02tcgTJq8YbBxMtYi1m+CX7LP9jc/CuX9FSReBVvpG9Pbv50XFocgOVlw
         1ZfbtqBezGKe1JYmdVCNX4D6jor/h1yqoVX2xcnaPs2eyFTXnkPxqCkqm5oIIyi0Cu9u
         DVH+Yo3rRi/avPxe4UcHM+005G6tVEdz4GYIM3tVafQxdEsQSNpXiqxOYLDdXR28D4Wo
         Cnn37/eUjt0at821CdQk9uy0zR7KVW+jShBTbEeH3LYheAQIR5tiEO2XO5/HtGDq6YOe
         PbLA==
X-Forwarded-Encrypted: i=1; AJvYcCUENmGHG9oo3U2vHnHrJ2wxTBFhPRjPje802ICBeyf9MaSE0Ir187ZhFaTNFrgVDtHyrVFgOlxTshQXGKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFYq7aIBTvvTMLBeVXhOCjzCmLFPA4YUVHSkyjx9EnNpQvlXZ
	vleT5kr/9fqI60nrHB4Xbf0wvjNbYFFfz12SILaVg4dVrYgcG3vykkscyjHwBTAzd18ApzKUyua
	+Fl86n26aKEiwX4EkJEAW0b8p/bWAPodxlCVkVtT16aK0eG7ogqO0M/5u3k8=
X-Google-Smtp-Source: AGHT+IFlZthwjE12bH3G4UT2hUET6hZTRAgXBwb5Er88gU7SHdFfBSj4mg8H0QCSa1MRNan5PCxB2dXhUXkHj3LWQrRRpRywlg3e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:3e5:5af7:7c99 with SMTP id
 e9e14a558f8ab-3e57e7daad6mr223634705ab.3.1755463742689; Sun, 17 Aug 2025
 13:49:02 -0700 (PDT)
Date: Sun, 17 Aug 2025 13:49:02 -0700
In-Reply-To: <CAMV7Lq4Uob0YMb+rZQNUApX4YYPQyqarsDCA1pVTLMV5=vUgQw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2403e.050a0220.e29e5.0076.GAE@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: abinashsinghlalotra@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/usb/asix_devices.c
patch: **** unexpected end of file in patch



Tested on:

commit:         8d561baa Merge tag 'x86_urgent_for_v6.17_rc2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce98061fb8ee27bc
dashboard link: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1272aba2580000


