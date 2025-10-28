Return-Path: <linux-kernel+bounces-873571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E99C14306
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A471A201DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112DC305E2B;
	Tue, 28 Oct 2025 10:44:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08F2FFDC0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648246; cv=none; b=cGjxYDLjC5PFRzkagCbEixfAptv4QxgCxPeQjyFgDqCkBDyHMG9VWmwTgr6BjAY2pCzck9eOPpltQl+hJjdEcxEbRAoi6f21+d60J/hbaZMj9dmEl+k9X/OzmjXOq7sF3mwf1THsy88F6WQCwOXRj6I73hjsk1j+bvg/yppMqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648246; c=relaxed/simple;
	bh=NQrV4VwV+FDfPB6BmlIlVhBq7QzWiZe8tXS01zjW6l0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aGrAO9wD5Pd6P1NrFchtjhOJve/DIobu60HCyLzdxgBBgFOnXnImZM93ZwKU8y8CXYClZlv1McfkwGs2KY1fsUclMslIb69/kr/aVOLQt17E8tHkDANlyWBbAxkXA7fSPsOsetALllRAjJxBIwK0l1wh4BlIam+W4NtC7Ao6Iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c3232caeso72086865ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFi9q+cPOcdcbub75ZXFcWW04ptyFzLFkTN7hcsV2Jc=;
        b=QyW5lsMLThQrlit7zjyijFe3JVAeVr7bpY5pbyy5cwlAihD47auYhSTQE1Db8iY38s
         NR2IY+zQ4pWTKSxoCK7nFWFnbXQFNoxKHCiOSZZH3V2tmGaXZ78ePx45DW+cAkINSFXA
         1YEbx4lZNxWfg4uVFMjM4FN/NQDVkOe9vKMfMoVHjlT3RKkDs60qxFkCmJI5yx9VwrkH
         HIWTvKL02lxv0sHj5byfRutJZHClDkgfbmQ+O2hI/4Aa77FsdaiywL3sIs9hlqjyeLeq
         uKdIrwtmHKm1H/EsSSS/MD3Q2/tsIpcoC2nZwQr/gU8mBge4S9VgO4f9GIdOaWj1iDcI
         77Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWoPWeaKFBmcfje9I2Xbp0YPfJQp7a6oBOHGsOM+AUny8TKoX5iM+Y8tZwci9ngGBiaeji7KurMuHRfQHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymhdpeh5zXpE8L4FNhZaVUf4bd2Dfag/tXbVraNSiUwEYkVhOf
	nXHBa1q2xUG4gM9sSYtYG4sIJFd1KPu9hjc2nxraDJyw1Z4fr+Cpyuyi2sLcBw1dFxwQHFF/aQV
	XIMeIRzMxJ+FnyYO4h8X2es/GjduP8163uOOuSIBbdDpYz9+IoS2Iy4V/ntk=
X-Google-Smtp-Source: AGHT+IGgjUOSGPKLSztjD3g5uJHyv/SF3XcTLY66fY6dd6pT9EUNd7RGjO7rij9B933KAvYHOM/LqEb8lENdzzjT6w1TmnVNBi4I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:430:ac27:c26d with SMTP id
 e9e14a558f8ab-4320f6cc7bemr49423595ab.12.1761648244238; Tue, 28 Oct 2025
 03:44:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:04 -0700
In-Reply-To: <20251028104120.ygCqG%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e74.050a0220.17b81f.0010.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f157e2580000


