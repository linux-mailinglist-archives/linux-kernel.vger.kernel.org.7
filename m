Return-Path: <linux-kernel+bounces-797737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160FB414A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216651B27B37
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B22D7398;
	Wed,  3 Sep 2025 06:04:16 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FD2D77F6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879455; cv=none; b=mQjef1uZKW39yjiq3AmDVsIU8hnAMfycZWfa9QGhyZZKZ5XqQ/o40yKz5b/58UvMYzlMJHAvsDJtEg/cs4bQ7Mqtod7qICON44e8ihtMfKW+ue5sHgM9VkEML9PoIHQwyvQAM9jffQOZEWBf3nBOAhcWgRvUkQS+/xKZln/Le84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879455; c=relaxed/simple;
	bh=pwP5ewIrHo3p9vhx09GxG9320nyXHCTGwSq1UycDJEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=a8lc0qZinmpjIghe0XGixhnm33eOaUFsVQrqyscc0bDdUPDGkbpaYjRqZZb88DKwg0d8gboBK8KWn7T4CGT4mqIj/0HCMDJ7cDJq64+K7pDHX1uviKdRHkVIkxfhHQYD54w5X/bCL/GbG5mNsu/WIgyhqc5QfGlwFpF9xQug5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed9502b6b3so72967225ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756879453; x=1757484253;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwP5ewIrHo3p9vhx09GxG9320nyXHCTGwSq1UycDJEY=;
        b=JTLiwwnF0jdRv2wLvNqwNlwy+5+AD3/0k6qMscsNJL9YNdyzlZ6vENqi0+XneL+zZV
         OlrmtOjK/57fwJYRltUuxfmlJ2CZb25PPImJ1L/j+ixv7jfABoHIkP/YATJ7eZdV4dyF
         U7FB9buFaH65UID+UZP6nWaIlwyGSv8gENmICbnffwrK9582yiaN2c6PKQe91ABqIUi+
         05nGr0Xk0ifEbXjOqvTXgmq+JW1jM7+BFJq/djyCp6+LiAY8kQjBRmtV4TKHUiF9rxyA
         /W26G4ibzEsocxD6dlUTpLsEx36CujB9qwKs4koGugHriPmBzELXzIhNGyyMh3rxzy7U
         AORg==
X-Forwarded-Encrypted: i=1; AJvYcCWZtvfgCR76nHeb32RkSQUmP0ta2DKkPcJHVq//Yu61yrsRXpbnCni7iyn5ERaMiASuw0EmsVyuVE2uvlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xGGtzTne90Zfcc54LUcqhghqaTSyxwfmTdind0yuDScbj8B4
	dQu0+qmwjupSWaMlmQopiU0ONT7ca0kcvIw4ExG+zExTeSK2IJRjPvZQsnx2kWuyRCSEsQbMnhG
	s9sYhotTPERt8V3RaVG6MNDDvHe/N5O2iZ5hFwfAQ8KQZV81ev42oFxcPpsY=
X-Google-Smtp-Source: AGHT+IEt6ZqiWWXxUWxDmlgK0/HVBVIHLncOIb0H6+F+B6N+xFAkygcb5Aaby3CE0mrnU2dZfc/kxoUv4gE8ixOJmMChKqZoxTS2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2504:b0:3eb:f2eb:6037 with SMTP id
 e9e14a558f8ab-3f400286788mr250289885ab.12.1756879453388; Tue, 02 Sep 2025
 23:04:13 -0700 (PDT)
Date: Tue, 02 Sep 2025 23:04:13 -0700
In-Reply-To: <aLfaWUYaqDk1d85i@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b7da5d.050a0220.3db4df.01e7.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in xfs_trans_alloc
From: syzbot <syzbot+ab02e4744b96de7d3499@syzkaller.appspotmail.com>
To: hch@infradead.org
Cc: cem@kernel.org, hch@infradead.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test v6.17-rc4

want either no args or 2 args (repo, branch), got 1

>

