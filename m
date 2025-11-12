Return-Path: <linux-kernel+bounces-896479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2598CC507A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7170D1897C68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2442C3268;
	Wed, 12 Nov 2025 04:07:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D62594BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920424; cv=none; b=gEzB3QELmOoGTQGd2K8jZdBocc/5yLztvu8C5JYJgh3zM4gOatjONFVkZs8aOV2Ra4H9MrHXwQ3qQsdp8WSMcZj7ZNdvdH40GWuiIRSOzxQAYVW769bFLX+gLzPRwf8rgT8sxcOP/AvmfuVGMLAb+VzWtTN3QIpJ/afjUz5ltMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920424; c=relaxed/simple;
	bh=gWujzDmq797eIGweX0kiDqqhrTMmMFfgbWstpK3QQew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o+tM4sK8mLwIP6uP9AeJf410xB0yb27E3rYpCZhZwZLpyBlqU5D9s02VC5LWwYTgcbUYl88mXgOvDEdmQiuqbGsILrBTq5PCUhJSyvyoqO8EIM2oC8Pn4npH7qzwTsni9hkqpmBN+x/YCbfKLw9P8hOSnWaGAYZl/b2k8Ilb+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-433692f7479so12390145ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762920422; x=1763525222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZGC6srK0UBsNZVToxudO1JhINuHL7PrwcDUZk54PkY=;
        b=uop01aeDvftC75Y5DDWyLVn1O1b14TDZHsWe5rFf89LLKHb6stty54KdXtAJ7qZYet
         hAjQNaSwZtg08zf+Otw8G8yCEawoqZOgv+6KP+3UgffcD4nfWmmyaWBRjeYTArrfvOen
         lcqZnDUsMnhRaVzKCtXhhWMBoX5cWz+ACJAyzs6jXEnSYWhv/OOYjDXswvivm1d6hiMr
         uKMb/iP1zDzAUekyzpa9IR06v8X55vg/Du1VXshhvSFOmhqFYzmrSZRr1YwIei2o48wH
         bTnvpmRRaw+LflCRqEYUFPsrBsVBh/20At/8aJBT13ZeH4FwILXrxp/RT6Jo2/9sAh1J
         kndA==
X-Forwarded-Encrypted: i=1; AJvYcCWDuZ9GNd0AHkSW2W2JUbfU9gnTuDVCbcGtMYoezN0x96f0KbagLDf6VHlZ1PKGyOGZrEK6+0eqawI0/7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinTVw0+RtXqRZWRRBETmYaQjf11RrbrnN5NKJIiJ8W11uOaDO
	X+RVbv5mgOzfR7kLGFsztzkDskhyOT2cOeD2mn+51dVne0gEzupeE3zmBqjj322IJ1PAzcAI1ZL
	Cg69nYLRlDi85kkHmYCeiSDfS7tfjjXcVvaIx6OotsrXVAw5isjS3oQCnK8g=
X-Google-Smtp-Source: AGHT+IE//vwcBRSspew8ysSz1OrPytRuuCdUEkH2X3LmiXWwmf9pdLMY8BcXHD6hDRSHrbZTj8rYNzK12Q8f5xJ/+AUzZrrKj5YQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:433:2aac:c540 with SMTP id
 e9e14a558f8ab-43473d3c496mr23907955ab.14.1762920422464; Tue, 11 Nov 2025
 20:07:02 -0800 (PST)
Date: Tue, 11 Nov 2025 20:07:02 -0800
In-Reply-To: <CAKYAXd86eFyX5sVi_5exaFJ-wGn2U16n_L1c9ouDBnFGPuH_qg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691407e6.050a0220.417c2.0003.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c48212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a8d60a580000

Note: testing is done by a robot and is best-effort only.

