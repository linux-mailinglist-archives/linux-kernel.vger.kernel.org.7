Return-Path: <linux-kernel+bounces-873585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD360C1433C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A666208C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964D3126BD;
	Tue, 28 Oct 2025 10:46:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4023306B1A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648365; cv=none; b=sY5AEi96T8ygXlRlLpk8j1x/DKtF3xmne4RLpJxntXV4uMEi1FxFq2RWLtDJ8+g/lwkvkdoqs2oVrKTr32UYgnGlFRM9IvxvvYUor+p3cZANw2T46BA6WY9ndpgWToPFgFaog/nGwvkUofQ1DLPxW4UbmVZLHFfbFnNdMnb+9ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648365; c=relaxed/simple;
	bh=ACXUUsb5nGrCGpQ2hcQUun10KbaIDJxrL4TT0/208Sc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bBgVZRGqEtBhkN62mARILFFwKsF8gPlvkfqcf9s8zHePPpf1a3U6dEOHNGCA/D9Wh8zmMpSowC3uzER94+odRogasXM8Rs45IG/mTSbSXLqEk5rJFfsABSinkv9f9I9UFttAxxM0hc+e+8muDs85gNylDBcX4H1DyExvDvYCIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43210ca8e1dso8289585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648363; x=1762253163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdD590iKLwM0wtflNAfXvRT8mXrUh3FqNl1KhfFxejI=;
        b=cOuz1Ruh0yuYXR65Gxea40jZ+S514l1BEevj/u5qjgsrALrbhaU4XkkoWAvUC6k2pk
         t/cRvyF97DR37mUBXSQwF3vsIiCvxNwpElloc6kwOjeCkUU+ueVHe8mXwnRQp2qnbAuV
         TYYYXniOe+zrzTi/DzikLpAqxQAhev3l3BKu2el3wYL9OXMV3LLH4EOR4cvGu5JF7rKO
         cdDMxHs7+W9w7JoLIQ36yGhMFbz4EAWkfFiu0UaE4fG2JzifH8MC2eaMEvjDd6ClS6Vq
         fwZx3lxij3oTYGTr+lNokfr5MO66Mv4/0lcQ15gubYN8Hkq0jpHOv/GMqN9hXkwzDEeO
         12zg==
X-Forwarded-Encrypted: i=1; AJvYcCV6HNJj0njUiugVm9NGGQymcdxmSJgGYvQcXq6hKxl7kMBXLzF4B9LhOXzDpPRZEsOxhNZJW0OklkKZyBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBTEqdxlj+A+qDZd0nghK9qqwqq4vElTkQs1t0O5YRPNc5SR8
	yHqV0wcQf9U4I80rmFnoVA5qY8Xpknv0QEdkEMsJCGQTWSc23kdzt2h2YF1GHJLzb/bG8xGRxKO
	hB+mQ94DL32ItEf+tIkSllhgeRMkQmcH2N3nLbkXNYKnmeicLhI6SdCft6mA=
X-Google-Smtp-Source: AGHT+IHWeSye0q0sSy1opLtgutsp+5Jr/eDZO6IAuOuIWUMJu7e8e/9gF4HqXEQ74CXTsMu8SVUUyxkuqGqTFws43eINdZoniLBX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2586:b0:42e:7273:a370 with SMTP id
 e9e14a558f8ab-4320f6a770cmr38382735ab.5.1761648363144; Tue, 28 Oct 2025
 03:46:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:46:03 -0700
In-Reply-To: <20251028104118.9ui_4%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eeb.050a0220.32483.0183.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11746932580000


