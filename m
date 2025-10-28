Return-Path: <linux-kernel+bounces-873605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C639AC143DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9B61AA50CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D53A3074AB;
	Tue, 28 Oct 2025 10:54:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF92E7F2C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648844; cv=none; b=qZWGdPmyRbiDfQPhUf+oCgMAJIWpevT4lYtUj/z3Vkdd/ahYSO53QuxbdFp1qF49KJ5l1uA+vxCXbD+Gf60a+XCBEXMmQ/FAxG+3m3yiRTdu0QH+yEWU1xoco4DkKi8CyxZQL/0dUjZTVzSCEYv32k+OPSLApQps2A6YCk2VIe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648844; c=relaxed/simple;
	bh=UnGQQKWUa5DQxkJWecCfEOgqTPm+utcqV7NCyPct1tI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gQxSc/aG11Zdm/EgS7Oc+O3Ogx2LPu6y0Nt4N2qy/gf7/sZrUsJ+BMANKmAZf5ZpIt4zUXYJyzUK5mrb5Inz2JP0Eo4FgHED6Um0+AJGPckUDIKhZFHXgzXZhjM5kU09xDNf4orHG/M9dGQrKj8Md6jg7fbEvqeXNDOQBQT6guE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-945a4849260so862828939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648842; x=1762253642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0oI3dPUWnKo/UyVq88qVBTtjLzBjxNn+/ah1XRYiMc=;
        b=WBsZ9SrroUu1vTra7OcU0rk6MbGXHhS4ys0i/+RAms7NdI5fF91oo5fltrvUK6wVhh
         59iNVrp660bgJnkRvpGfNXnhfJ92yB6iCT0rgLIODMO6zG5m4aPJRMKQil6nkgaCtHgw
         vvDTXs1cZCcyY+wnMc4ZQIILvZO5Q5YCw4/pOh6ha4q0yHCw8pJLwVrAk2e37Y2QfHT+
         +iACA7ofYkT930nA8ZRQHnQRARbRQvXm8l8CY/UmJdlO7R7/BvZ4bZaGsmG4vmR5HoSW
         74aMerYUd3Y+d749CRHlvWi63WDa7EzoAReCFHIXjpD11FK08dk03muwB/H6Lbqa20T4
         PtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzuaVmU9wr7MKJxaBzFfV9VDX/RoDAhDz69xP+CVMfoP1A0J3r1q+bM0AuhBspKroZuK8kExnqHGbDXtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRoHEgeNVYGbGyzKCJYhkUlAJcvjhbCE8Bosh4Fmsj1mGLXpul
	WHXOg4Q2iqLRFHFJbvkJLyPE+KxM4gMN63beUfYLiJibbMwazNOlzxRhByAt3WsAt7H/7OTgXSG
	oHIECo7PHqf5gwwKvGBYltC1/E6gCHMSU8OnzVymaTzewmuNztc2gOoGI0GU=
X-Google-Smtp-Source: AGHT+IGsVSpAXI+5fc/D39yttmMsI+U/M2UCKcUdwRSPi2yNTcfxjUnC8SYicEUniUzGx0h7MVOQgtcv6/ODo4FFDywrALGHWezP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e06:b0:430:bcef:e0a8 with SMTP id
 e9e14a558f8ab-4320f86661fmr41585635ab.28.1761648842738; Tue, 28 Oct 2025
 03:54:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:54:02 -0700
In-Reply-To: <20251028104005.R1CUs%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900a0ca.050a0220.17b81f.0019.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fa77e2580000


