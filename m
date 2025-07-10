Return-Path: <linux-kernel+bounces-724779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76FEAFF6D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D67AA6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472B027E7FB;
	Thu, 10 Jul 2025 02:31:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C208450F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114666; cv=none; b=K9vw24hBybIfAq9rpW4uuwac+50TrexsQ+6rwzKV4RS7D0fDF/v5pbNlgwTYu7NvVQiDHuRIKCrzerMhxo/7n97YUEKvNAx1eXjIu4kEujIdt6NHsSxfm6LHc7LYJJ22qYOsybKe8YlV9hn0cEMoihLUQd8Nsnj47q6E6Ij7il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114666; c=relaxed/simple;
	bh=51AYRj8QKrgue9s974b6uALaEL7i0aZz0fmFYBMefoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IPjvn6M+9BRTQhyF0BKTZjaZlNiI08w+X18OiPAWSV4deu0yG0GONwkXyfmSzVre44bWPlxsY0KYP8PHa9OwrGnClle7OgRDZArStasYyql25hHk7GSojhq4zSpbsnTY2x5jJRFq9CcYn3VCI7w47NnenpGbAC/3gk3ZU81Kiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cff1087deso107396839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752114664; x=1752719464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDEw9f2qnWnTFtYQYGXI8VzL/jgMXkeeQJTL4uF5l18=;
        b=cx2fJRxfjWyxVJdBHRh5L2pRrrzE8+CaLNjVALDnpC17i+xfT0mRsyXfseqDcsE8y4
         IrYcV9YiCeHox+ze+zvb+AIcfhroWEU1DBqZspQybOZDM53IdhcexmF8FwhhWKAG5A5q
         WcJd9EVbZBQ70GbIF7MKuCHmknl4uG8xZcKXCT+Dmh8w7CQSovBzvqeO0z225z2qOOKO
         ddP0dYbhrN8X1tibnG3Ly712TnMu/hX6icjqadugznrIJ1TENGVsyHa60pSe6ybhF5vi
         2VXZsgARpREJphul8nWgBN4t3lR4G3+4mRCCZeT2u/9XjDXTDsYuzjNokiSAM33uPli+
         NRsQ==
X-Gm-Message-State: AOJu0YxwIHlJRiwgjkalRaMsCnlnnd+LvM6FaSC7NvV9UvrIo3fWFuqg
	U5T4zVjylhEl3M8XLC5F8FmIH1+yccSmNYFalmlenXj5RSFW7O5n8FdZetq6ERXBxAT2hT52EyX
	1NShboY2pqTZJ9gvImFfa6J/PiXXc/WUCWNaKbvrBpQ9KhRQTUqFsYB6UENg=
X-Google-Smtp-Source: AGHT+IFiFfotYBr79OtNbYK6f6ver5u8S9KOvo45c7L4PyINO10ArQtdltkjnHr0OF8qGzDN6syUHsHwrBDgsd3dBnR+98so1uyZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:875:b998:7ff7 with SMTP id
 ca18e2360f4ac-8796627b35emr272099739f.3.1752114664588; Wed, 09 Jul 2025
 19:31:04 -0700 (PDT)
Date: Wed, 09 Jul 2025 19:31:04 -0700
In-Reply-To: <20250710021243.1547487-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f25e8.050a0220.385921.0026.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Tested-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com

Tested on:

commit:         8c2e52eb eventpoll: don't decrement ep refcount while ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ae7582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fa6c6703a4b2315
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f67582580000

Note: testing is done by a robot and is best-effort only.

