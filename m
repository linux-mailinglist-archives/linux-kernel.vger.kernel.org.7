Return-Path: <linux-kernel+bounces-859833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26ABEEB77
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B82B34E3DBF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22D2236EB;
	Sun, 19 Oct 2025 18:31:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F1181BB8
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898667; cv=none; b=nwdXUc2JmU/voti5QyCao1n5wnAE8zh1l9TUxGderndLlfRq9eoX0rfTY0HHJWOg1Rd3Vcl2HHKQGx9Zow3x6G5QshwXQ8xmeX0uBCmWlI85+xxfdUiaIgysbEpxYJdAUnBvYi7drz2spzHltr4cn5oLpejQzuZg0SKmZaYWZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898667; c=relaxed/simple;
	bh=cUQyr7vG782iBXQKkRv7D+TO9pqgk7ITFaJZ0cn8SP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H34/yGlg0j3COFKE2UoL8XVThDyKwfaWyVdfAwvImVGouE/3nbuZMqm/D3RVyOCgmFL0bWNHzV4c2ItorD4MNbDf4Mu9s/rciBtnPRxkBlrg7GzkGqxTiTpG39isr0b4hFCeX7ln8jE1sK113DTCnJzbPsZalFREO44dUpB7BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8e029e0cso331220239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898663; x=1761503463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/P1IUpV3W6H6eh0XjcCP7waC+cjWqhHH+W4yd3YSgT4=;
        b=mHmy5eLuRyV994+ryQnDsh9y/y1i4xWMw0gXPBSsXYse7x1LxsUM8qQd/2df9skhZn
         VKKCl/Okk6MywRv0vNza+U4ZQKql80mr3xEa6OrWdKuG+S+MMffYa+WyaXC/rfydv0JE
         kwy/kJyDN7t3J1kM75rw/0uqKSV8A/67a5d7TF4bfLfypCvloAaBWauNQUf1sqdO705Q
         rc4DWa3fbHQxaoLurbjieB3Bx+EJyXLb1SjYJw1ZtF+aKwGs8keNx82M5/1wVbV+iDH9
         Q7bjfCgpuWvqBw15ebQELrJI5kU7FgFIWnVKsXGCnx3RLlgGfe4cGN4wvGpQ3zCREUwb
         jj0w==
X-Forwarded-Encrypted: i=1; AJvYcCW1AdbjmeHUF7XYYCmCFXnz4590yVI8iSE5JxixirceEHL1jBaZcHtSkNaIU5CPRwAYUficQya2WzEGtBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUpdHHwQuoYqgnpb4VFgBEKk21X6297VGQEyv64vPN9Lpz6vV
	244Fvik4ri6H7JrEyFBEsctEcFXrS+LYmp+N5IMMlo8GtTyzpvTW5QyNfXFshvoekSxTII0dcDr
	pV/4cuXDoj6mYd9RmvVmB7CiVXMccMZJfatleW1uK1orBe8AzVi40VUpX0T0=
X-Google-Smtp-Source: AGHT+IE8B3luOlNLGqatfnnsIjgaNb3koElUXG48vn7nmYn4+HQ4svuH1lXB150BlQNstQ7yUqbeU7bO7/XwfcQkc1anmstp1kYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d1b:b0:93f:fca2:e548 with SMTP id
 ca18e2360f4ac-93ffca2eba6mr740722739f.8.1760898663510; Sun, 19 Oct 2025
 11:31:03 -0700 (PDT)
Date: Sun, 19 Oct 2025 11:31:03 -0700
In-Reply-To: <81eb1a55-dd34-43d1-93d1-33d0f24c7622@ee.vjti.ac.in>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f52e67.050a0220.1186a4.052d.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ssranevjti@gmail.com, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         d9043c79 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17653a14580000


