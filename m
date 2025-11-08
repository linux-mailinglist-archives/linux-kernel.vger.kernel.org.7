Return-Path: <linux-kernel+bounces-891191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAEC421E4
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21531894228
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41EF1DF742;
	Sat,  8 Nov 2025 00:18:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DDB74BE1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561085; cv=none; b=eFWvjwG4fyDD2hpUm5YeQYNVHTlsyPpaDSLoZKbXkzSKungh/nUljekw9cAsh9ICEDHgps21+XHFUeZNZ5dqdvSOW9JBaXwqd7NoyzXspcINdSA4RqYD0Ji4tlmeK0u+1rooldUYrsL2jX2pH/H77dURclXyv9pI/jyMCHALBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561085; c=relaxed/simple;
	bh=ykdrF3raP3G3QSjDTkzVdVAK1Krk9b+nrl56xuCbTNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OfrTCRX0FUqPuHkk0KWSOymUmqxrE1fwvexsc/wfJesigpiWWVHHZoHpQBPlK129xhaGeZ8XS0EqWj0wuD8q4KUfGx/lTHh0hgrrroVbv/OkWMzRGhJuo+SzZ1GEkx2f81iEekFeaN9UqNB/Mxu1D318EC8Wpzb6weqnb9bBLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9486920a552so384645839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762561083; x=1763165883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HEPYAzLGKgN367tFqqHSC+aw990xB7Zc+iqxWnRAq0=;
        b=brWcc7HgLUlMxCF2eYNHHO8dWI3LX8ST7Efv0xgzwiGDEpCDzAcrjUY+ZtALZEjcFH
         5TX5AOxFNe9zn1lzuNgEyiG2m9LIWepskcGfMSDCViqMzH/eg9khIOo04gOStGOb1Ymu
         UkvknFMkzlsCg2oEaW2WvgPUsFgjQTLajn9XEjoiMJlUQTrDPUAxjuu375jYHvL2Uaa6
         ocd3/Arbqvvkx0NJo1+Mw3ODqAwNgGsaIMG41RcGh3RXgzg+ODSxaYaXLSlyxr92r3Rn
         /lKR8q6rhRJl+CzFpoZEewIdQ0XP4z+ely2slZtXgO9Bj/hjB/cs+7Xcy/+/FYkSZvxy
         PTTw==
X-Forwarded-Encrypted: i=1; AJvYcCU4q4Fb2nDBbUOeM8QfKlGz0xbZbpC8v+DQ3+kwVYv+C3o/XEUATPpdVCNRGfvRR4OBDnfgd4kBfhmwah8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAQGyE3dw75OjOm3ziOJy2nHTNQWJA5hzN7nVJR5QM0cMx1Fc
	L7tOSTXc9iyQKwvN2UoQTvkgBayyrrZL8g5MJP5KWAITYVXra0JybayTN2BF3fmIw5tkW+YoJGl
	lFI46VEJTdHdfDD+drOsXO7wEj8VUAyD5zyGDgxAzPURtjORFB8Yrbn+4kuE=
X-Google-Smtp-Source: AGHT+IHhPdOZCpqtix2JhPBg6nXzyuHzWwroLZuXTlecW0H4Wz0nUwlffrKRVWnTWkNG9c6h7KT/NFC92siXVftWRfloKzgl6hiD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:433:5736:968f with SMTP id
 e9e14a558f8ab-43367df3cd3mr22846745ab.13.1762561083264; Fri, 07 Nov 2025
 16:18:03 -0800 (PST)
Date: Fri, 07 Nov 2025 16:18:03 -0800
In-Reply-To: <CAL4kbRNoDiDtyhD4qBRWLqj6JoBxRWm6KdQca6DUYAfvNTvPuw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e8c3b.a70a0220.22f260.006d.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
From: syzbot <syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Tested-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ca2a92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf50e713aaa5cb0
dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1214117c580000

Note: testing is done by a robot and is best-effort only.

