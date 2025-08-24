Return-Path: <linux-kernel+bounces-783483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D370DB32E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895945E27CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5C259C83;
	Sun, 24 Aug 2025 08:37:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520311712
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024624; cv=none; b=Lq9u+afgBta9BBuBGASISloeqH1hEE08HntIhMpAplkH/sydweS0Hbl/aB7snMSZonzzEZ19apHuaOTiiWffDxqnn740ygKdVLQXvA9+dlyIGrPYHCqLbPmsgF8RfZs9mY5QhrbYdYM1RMEU6eID/p9QW6tza4C3ksBicXFqSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024624; c=relaxed/simple;
	bh=0CJGSDgTdmS0OIbPOSL5uBYIt8BDW4c7QlhHEtjVTRI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qip8RyvR1djvSFACoFhZLO7NAaZ9dUBMUTxVx+Hj3i3pCp/c7EnlYO1qai09SArBs/+avlIvNc+T6ID9OazochOEda2TtVTl1izLUrkOAMPJ/LTsRghlwigWNrFUmJHJWegKWz/xVpEtd3heONcUEk5JoEhnZ7pEFeYEDnThM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e67e4b4ff0so37948545ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756024622; x=1756629422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7X3C81YbhsW1jEhXUBJW46YggWn/sMObCuouFbR2kyU=;
        b=h++FDkY4edRWvDDnN04o2Dq/gNgUQyjcZGxaRKpk0iyLyXk/co4u04MrJED/hJxxX3
         9d5EXc04HSc0dCRErOfStP0ei2q9uCIH0+19lkeDMMoDq9IfGmsfrlqM6CuxiRBsFPn4
         2M6v3bp8Z/1K50lk44Juu0vO4Jdd3OswOTOr+AxVvAUp1dEpn+Kwyzjgdq6pf7Envd5L
         uuJSUtBRKY3m0yfY1RG1kTa/w3fU0elu6TWJBvzKRsx+OBI/J8owXC29PZstBpY9QGvS
         GoUB4xTJT3u7SxyTwlZ5JoUbPK5CWWoCDv3CLGAWNvyQPedMBdbvyG0TJoPYtmQdGviJ
         opNw==
X-Forwarded-Encrypted: i=1; AJvYcCXXMO0CotEPcmVZy4tMigQlctMR8t6zFdzXk5uMh2HRFiNk6pxiGdRTyGFgc40ylJFcoptDMNFelWXnG80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSWXAFyDSW8u14wjFIrov+CUNBTSL/eF52H1x16oOOj2oUR5y
	bs9nkvjO8EoW9+1xhVm41SMdb5Jx9T3YfdNWb+G4kRuMj+Ubq5pNRjXJbuyC5vN+gCX8Gb7r1x6
	mIppGf9vhB+qLY473diWIKJc4cXo6H4D+cZNUx9GUjjyHT3a6BhDULhb/TwM=
X-Google-Smtp-Source: AGHT+IH6r8nISFoGXxzf1E2oXbyZ/CTA/ScVJxsB15ZGn7JJqAW+zEUUF0bh0XZqxJWbHkMRFxruoSHv6sOC3gXS8ntkgAyEvs8H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3e5:52a3:dafd with SMTP id
 e9e14a558f8ab-3e91fc28027mr116387315ab.7.1756024622142; Sun, 24 Aug 2025
 01:37:02 -0700 (PDT)
Date: Sun, 24 Aug 2025 01:37:02 -0700
In-Reply-To: <20250824080918.5312-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aacf2e.050a0220.37038e.0070.GAE@google.com>
Subject: Re: [syzbot] [media?] [usb?] KASAN: slab-use-after-free Read in
 v4l2_release (2)
From: syzbot <syzbot+a658d41cf8564471775e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a658d41cf8564471775e@syzkaller.appspotmail.com
Tested-by: syzbot+a658d41cf8564471775e@syzkaller.appspotmail.com

Tested on:

commit:         8d245acc Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c0ba34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=a658d41cf8564471775e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ef4ef0580000

Note: testing is done by a robot and is best-effort only.

