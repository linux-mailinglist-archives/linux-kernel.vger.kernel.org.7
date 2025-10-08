Return-Path: <linux-kernel+bounces-845341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB9BC4843
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E63BBFA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6412F6194;
	Wed,  8 Oct 2025 11:13:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9CC2ECD19
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921984; cv=none; b=jnfWCXnBOztY9HUL//+avT4BFx/ykBU+4F0yFgyYtwc7uy/uBcvM2CdimBGIoVCsSzLXW2jggMrPLQVQA+3tJ7h86Ga4J9vnLSq/WEoUJU0dBLs2AJTJT5ii4fzNHhSaANMWPIvKlYDh76mOqZtHdJ+KIYUSiK+Bxc0FnewkrDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921984; c=relaxed/simple;
	bh=FgpyuqyTnm/M5Ygn7dgLlENGe2+G/OyQohS1quCCeYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Onhwc+dobIY6wAJHx5lw2vqNsa1F8iXRNymvBDIvT29IZZpUbiEghhmdLudSOp17+YM4pAqLqG3vUl/7vx78WfmD7i9FKdwQCAr0jWo35uXzBueZsVAoN1ssUmN4u1T6JwYDspeBnYE/BTGARU+FGvPsbMK/OnGZhrnFrpybUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bbd28b4f3so385296739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759921982; x=1760526782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so831p3r3onT6wTG6rzKoqe+/e6TXHQSkN0OAI58eaI=;
        b=vCKtIdKXjdRh0qGYaagAQm/iRmU9ytmFHJYjLIJzMynwMSXSjrXZiFyU+irBgALpbn
         8jP6b6CxugzxnsMq0acsRU8Y3tRuR8DSv20UbyOpsNMiYnphXpYLXwtn2H/wGvSj3sV8
         LPgeaIuavd/V4pRBjAe1jrdiJ8pwc1GNBck5QqWxCq6+PFn5RYtda2ktXThIR5SamJpV
         oDovZABfEQFf1q6/Wt8bGyuVy3zpFuq2o1BYAybbhc/sFEoKbQWwhaPWOJUFGKFyxWch
         Qe1aXFxF+fU/PJuTUwsseracRC77BTeJVR0XPSnsacw9aXZgtIw1eltyAsD1luE11a4x
         n7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSEqNPHJ+XVKJp9b2h7vvjRqRp/ycqBeGV+oAVNKEvhO2DteRV6MlXGiKormpEisI+ntmCFCo+A6Qr1wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04Evlp4ThSaeURkLYBK9cI0dumrhBzrLreiwBfiHkveVd9H8I
	/tHOgtXnmR0hDFc4r1Vh0lnET83ajcr9Q25Zo8aJYzThsnvhhfjG2Ifsmt8I/FkNe/KyACaXs/p
	pvDuyN7R3JB4UgohXas51EmHQpvvTQcPzkPrNx1wYE8OQcxdzI72mJ+pgEDk=
X-Google-Smtp-Source: AGHT+IGyTeaXnC/kOmbcpdl9gJUs9pp8j19h/8Jm/PTcdgTMt/Bxww4lavcsKwB+xdnkce0TsKi2sGufunJwUdQma9fhFLhwHoL9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c11:b0:93b:a239:6864 with SMTP id
 ca18e2360f4ac-93bd1851336mr286154439f.4.1759921982405; Wed, 08 Oct 2025
 04:13:02 -0700 (PDT)
Date: Wed, 08 Oct 2025 04:13:02 -0700
In-Reply-To: <fbb0d602-f99c-44b8-a0a1-9d6ab5b3c107@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e6473e.050a0220.2430e3.012c.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com
Tested-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com

Tested on:

commit:         0d97f206 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16fef334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6fcded704acad42
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1085c1e2580000

Note: testing is done by a robot and is best-effort only.

