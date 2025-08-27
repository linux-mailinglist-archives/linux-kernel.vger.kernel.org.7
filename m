Return-Path: <linux-kernel+bounces-788130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ED4B3800C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEF2076B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B740430FC1E;
	Wed, 27 Aug 2025 10:41:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDB26B08F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291265; cv=none; b=UJB02v2/F+zpYHxwCQKx4QA1OwMM+Vnnczximt/WnC0/SFe92uERirZawu4UMYilMk5fYFUHwebW8CbLpSlQyJZPo7lLLwAamZv1SRIy2SMCgbIKUAkkver5u+MVGBa+VcDFG6713/loI68RK9dzoBSqryAna0qztN2MKPWav+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291265; c=relaxed/simple;
	bh=1vx+fvOTXKdjV/vymhbmS74ZzwQSz90H3h3vzhMmXKo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DSDK2zw9b5FVkghce1Z9ET4bPSzppakFHAKNEBj7FD37tlhqt0fJYkkn36fOvWKmDSXVhWjVi6rq9U4L157tGEfyq2/LDnJhl3Eu4pxvE6NTKPhcVVdCsePcjAokPnabXx5ZAmfr+8TebhkUR/6y3J8aeTUC8CpI0KciNTaU3X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3edfbb8d391so66576735ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291263; x=1756896063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfjiQ8DugOemWIKEl0WlzxtmxBFzA1r8JZ9mocc8Lpk=;
        b=VVzrNKMd1is49p56q3gyiqp2ScIEUtLfBN+mdT6+FfAQUTqI8m/ldebW92sAUj1rBG
         QiZftfICra59gEgmOv2EvnvMv6EZ7Ku1KaI3ub/PeNMQudL/XHC86wvoBR0W1Mfj0Fde
         PkeGpAuweVIgHT525w80c4llWbJb9r/bqDk+gdoxIIMerTfnCBz4ckYQcM9CKcUOv4so
         /W1Ei5/cHJVLpbXlsEFTODkSdaX4Bmz9CdxIy9/miBmMeVc0uWGWEOhH/TH2PC8DT3SA
         qbmDdiIUkP1fYQ8DOG7thmTpFxlikLwhzIV93pBWL0DDBE3AvGQRuL5SLhxKQRMxrRng
         xcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7yHnriqV0zh6XjK6LaP44a2gS1OD23cucX91QkxWTurH4dcreOZj2gP4Fzzw4xl0t3OZ1Nnpz8sq88jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wspvjGTNrW1RoxA42vtvzRvqULMw4THprpMVXCUtUlMYkuT2
	8UAd8mHBtGuuNjG66ZYjC+YH1snd1augw7TNEJ4MyJu1ENQZSo7kVc2OnMjK+kmKuOLluh6LpCD
	9OjHTnaRLqsKtA1K1d2sLa9rnQMen9M/TA27Rq0cbKRxcT3kbpfMqs13lCz0=
X-Google-Smtp-Source: AGHT+IE5u+9EIb+Wu8g/9revYL+SeocsCivBIQTLrWSq2M7s+wW2rlJ15YR5JywhotkHnXSqFh8cEgdn1C+zne5Nt4FCg+VJf4EF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2502:b0:3ec:2c8a:f35 with SMTP id
 e9e14a558f8ab-3ec2c8a13ecmr127079375ab.18.1756291263016; Wed, 27 Aug 2025
 03:41:03 -0700 (PDT)
Date: Wed, 27 Aug 2025 03:41:03 -0700
In-Reply-To: <20250827100757.5864-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aee0bf.a70a0220.3cafd4.001c.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com
Tested-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com

Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11cba462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f9c634580000

Note: testing is done by a robot and is best-effort only.

