Return-Path: <linux-kernel+bounces-722693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF943AFDDC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CF11C26D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A71DED49;
	Wed,  9 Jul 2025 02:57:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300F1DE2B4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029824; cv=none; b=K0nvWhG8Uz67Xp+A2LcI365Mh0t+1W1mir1oNc+t4kRvAXFcutkFsQPubtrUv37RYk+E6N6WKy+E8yub1eJtfpyNUpJ5tjRiTZjCMQ8u/0cZkE9iR+fpIYSlWpun9ZcccgtsrhEkfe8DfCoOQCl1fAaMZe+HuoLP8FLY3J0LHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029824; c=relaxed/simple;
	bh=b7OimZyjFfTHFep/hWuZD01ukJarhr6o2iVODuwNjkk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WN0MQ8j8ITMDrq4ovFek8UQJek6MJbDtkwqm2KSRSgFnRDF4lXx1TpDdyqf52R7d16lmIMBhulMJv5oSid2EnHhU9sdn5KIxpxkevVGhgIE9URh9WbmmHrMmC+Q28SZxFbX3wJg4ENm6d9eDmmo6QlkHjUmRMFrMS0GYxYbjlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2d0b7c50so54454615ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029822; x=1752634622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqylW6xS4bt8Skmd3sTWlEsvnJx6vVusW59WybEHVU8=;
        b=l0ejvm9TIlaDM94KVbf3109Eak8FXe6limU6Gz5HYDog+hBaGRxeEXZamwuM87yOG2
         bOzhPzQHxwOBkOPVIRq/Ccz7D9JT1p6ZhRsgd1Z4zePuZjnl4l2YR1eWVQ4Fkjn3O/dg
         JkH/anF+dgRPRHCFQccbwY6vJWgYBdnwMt5cm3e2k2wBS3Q7iwGFX4fxPLO+B5G10HCb
         vYEXqpOE2CZf9gCkz3RhWkKXToDQnxnahcHLps+49GQXQrrF4cHhclgXqtt4mFaVC7p9
         sOvbre9m1QBZ2T45msTDpN92Axm+C8+YKYU2nBiZZHdI2V+G/LFUEBJIzs1FVylWQi1X
         QkNw==
X-Forwarded-Encrypted: i=1; AJvYcCWJPOlddBFQEa7ODKPXl5ckls+99KVCb8G9Hj/QPxlQNfZdidoi1JSUGhSwW4DOPh5MFcgoGOF81lRn74E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCrTWKSdBcmi8/TwgV6YuZU2mVBs9QlmRRnFXAlVAbl8swxlh
	mPemomnw9SPh03uH8gSqmPFkUim5Or+b9wcQo+ks4wB0g6JzV/JQsEs/L+oSKiKE1qdCu7EKSXK
	JaPm7SnWV9MnTj3soB/Vh4IyEL94cyxYSD+DqEZ7hhlK1wE9WVMTG2oBDlQg=
X-Google-Smtp-Source: AGHT+IGT/331aWdC1cpvMHrn3vypTjizFrSkZw5yyS/VyOb6elIzbgQ79VJmiCo1lrfiQgGcbbon7qMMIhAsq+1wJj7kQspkAfzE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:3dd:8663:d19e with SMTP id
 e9e14a558f8ab-3e1670b381cmr9176555ab.10.1752029822438; Tue, 08 Jul 2025
 19:57:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 19:57:02 -0700
In-Reply-To: <20250709020610.3080-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dda7e.050a0220.1ffab7.002d.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
From: syzbot <syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Tested-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com

Tested on:

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13687f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fa6c6703a4b2315
dashboard link: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ea3582580000

Note: testing is done by a robot and is best-effort only.

