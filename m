Return-Path: <linux-kernel+bounces-851537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD3BD6B35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C144118A8193
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4632FBE0B;
	Mon, 13 Oct 2025 23:08:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F2211F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396885; cv=none; b=AZ2aa+hVfQr6ur/HFTTnRQWNNV8prWYGLKUAfV5M4MoCjSOUK1Op92lR0UedHH8amZ6w1WorA9AE6hHHhjts6JroxcMiBITQBA06+CRS9N2nJqh+NaPhj0ScvMFgTVU948yGO+z/EHtpXd3jWfXTJxUOXg9rfvHnbVNwdWvn8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396885; c=relaxed/simple;
	bh=zBkQ478+K36LSAkcSZveJY7rGORBRmRQ/doT42pp2j0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NhQb3SpfW3MhhRojJ43k8+SUIA4vQtWg6RrHaO9iWEJbfXXHZ8rPSR+dZw2XgI7bR3X3wBAstdRsW0kzuSyKQDRJM7xNM62zx8VtoFzb5qSollGrIT7nyaNLEYczcmFm+naF8gm087LTkZa/7oyPr+PPNvqS9NoNrJ9Xt5GmC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42f9eb73b34so105870165ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760396883; x=1761001683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pib7/Bm8IHc8byFCcc/QM6HccOi/uWbIhJOPyumbLsM=;
        b=T4fxpoHaWXJbpdm0vp3rgw2k1NZbrfRJIil0d1kbzvAeMnvIdHqHxpDQe6s2cBjD4l
         73XH49vvvAUgltBXiiFOGw98y3e+JIxH+O9uqdmsBqrpMFVN7SgFN0mexhofoSfOFmDo
         xl1edc5jzZOidL9VeHKf8k7MMq6hFXeWeDXaUMb3jkLegnX/b5urpuKhYEE4M8OHBP1G
         7gihC4pzZigaQDS1q5dQZ9IcNl1Bf0RaogmLXU00zqI2yZCrpM/Nwq8Oyu9iUBVaKdmx
         uFaKLv3fmfXApOaxGuEocVsP1stLlNZTeTVTNWS4I8FeDEvdorC73ATmU9gCNso6tb2b
         xFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8c1ajKQFL14lw91uVP8gMM7PtCeWafluA/TsAqLakeKDGtwWfwh0G29VVm+4BNKVyKp/Vq3JJ79AHGzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKf9FBqgYwRkYgv4ey5MceQ0FeGM9fZMSjUPB3NL/cLLI6g63
	ygQQvoZK1OqrLXITPnTScpefi54xsSEb1uNKaC1BRqICT6qJb5sGN6IILZm9QVyjsAqS8C/9mrw
	rNuTq4bGy4rsUQf3eKdTbR55bEpErtjdgTMzBr2UIACqgFPGI6ywAzyLUwoA=
X-Google-Smtp-Source: AGHT+IF1JY+z/v2LYh/2NcQyC5wDhxLgFoy4Ufrd207fFcOMHaNDZZlrf0z4nqfVA1AG7+lmvnD5+3o4f/29P8RdKW0td0sULMwm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:420:f97:7446 with SMTP id
 e9e14a558f8ab-42f8742055dmr208018735ab.22.1760396883666; Mon, 13 Oct 2025
 16:08:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:08:03 -0700
In-Reply-To: <CANn89iKbof0PsFsPgdhMFeizu9uEkgmqWSQggDQ8EXA5jfxMRg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed8653.050a0220.91a22.01f2.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/ipv4/udp.c
patch: **** unexpected end of file in patch



Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a479e2580000


