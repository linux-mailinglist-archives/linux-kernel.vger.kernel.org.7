Return-Path: <linux-kernel+bounces-751992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890CCB1700F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804883A8C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AFB2BDC38;
	Thu, 31 Jul 2025 11:03:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF02BDC05
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959787; cv=none; b=rRPN93D1uZq3DZ4j0CZpSOa3ZttS01GKatPmAGFm45ZwBlsLIoHKJYMKu9lQjIvoG3m51+q/ntwX9LWDilzvS8eGDMZ8uT2yq+/cxgSA60bfYuQZJJTgOzvO30mtNoGXTLhOGgaiwnlnroVyMd7y9mVQDil8TO6SGHv5oi7jQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959787; c=relaxed/simple;
	bh=VkL4rUHXrRzvzewGPC3ZyS/PBgGSPHiWTM/AT4MHe4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OYStcXFlDc+A/Bq5DvT291domComWjTuIgiqGn4cD/hyLHK9f9L+yrnSi83ch3Ac9kgMnNA4YsB2KaCxgAZ3ze7Deo7EGGNKuVRY8zmb3kiQ9nIoAtaKk4UDOFb6XDQnFnosjG1LZFraxcx5qPvon1VXx9XWP8ammAqfKDrYL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3fcdbeb23so16198285ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959784; x=1754564584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83YOx+VNTSNOGjTu6GlGev/mqP28FosNBl7RL4paq1E=;
        b=P6w3aeNk7yFKoYJzV/SR0owwS2rqpS6BH3AZ41BtROrJ9HCTkrCxLh+5yEaj/PiG2e
         fjCB1mHc9UF7fZ/vgC/nUeV3+PVyFFpAsezgtk0sxnFMIA1+dcy1V8E3zyG8nba6AM6x
         hf2CEKCrGT2PY8/ZDrd++/w6m4tBmmd+TyAjcILJGhpv8JH6VQoLVOvSI4xLGHIneiQV
         bcd+xHCvHBwlZSUx4emlctAxutWbzaB7uto2/I26dhuoXB3+c/6uoTKDhZxk3IJHIusx
         quOvjCoiV9kUQ5E0LIc0VyNri31yBWUR7OQRj+sRfl5a7xp1x+ApMvLb5ZslqO9B1FCL
         2gDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfNUwt9KPklm/WqPSNkmjVH3pWNoqa+TqGGqypDrU/U8ps6UvZkPj/3m7x8EUWJHi7puq3uqVW3I1kiJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/67+Ov+mgKIsBlaAgKVcy6IISRvfO7cmPh59+DebvGKe1hte
	3ll7l+sN/kdS2nbr8aUiwxKMk/MKMK0QzLqMwfmRnHtF/VxigWQNGR+8Gm9XRtJSxp9bY7t6NP+
	sATVwbfFHHDDgWh7WQid1lfj2t3fJLAu/tcXF74Q24J06fGhHJB0LekFe2+I=
X-Google-Smtp-Source: AGHT+IENsHzm1iMPGKfMKVGrcnUB2jLEYeg2CBIkxuul3cLRH8S+Tk0GOxoVhl+MXDVlft2BJ9WjbwEcndGFp4YEns7rbW5YVP4d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380a:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3e3f60e0508mr102876645ab.1.1753959784605; Thu, 31 Jul 2025
 04:03:04 -0700 (PDT)
Date: Thu, 31 Jul 2025 04:03:04 -0700
In-Reply-To: <20250731093913.3644-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b4d68.a00a0220.26d0e1.003d.GAE@google.com>
Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insnlist_ioctl
From: syzbot <syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com
Tested-by: syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com

Tested on:

commit:         260f6f4f Merge tag 'drm-next-2025-07-30' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c32cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abebb97635730ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=fb4362a104d45ab09cf9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f52cf0580000

Note: testing is done by a robot and is best-effort only.

