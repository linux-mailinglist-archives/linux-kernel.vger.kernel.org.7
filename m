Return-Path: <linux-kernel+bounces-772987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83037B29A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8D07B10FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE57278158;
	Mon, 18 Aug 2025 06:53:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AE207A20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499985; cv=none; b=hEO3AtOXiqn6SJtEKOl7fP7WYkuDh4fC8CiZ8m0grbmeu+OjRQ//awjVCN69teLlQmKd8r2zcOfgC20DSSSWvXiDgO3df1cMrbkLrISsRXL4xfvdbQEGWQtcTXjPJHIcfwC3q44lFrxK1xzq0kLWQgOIMK9pVFDWQ35dpbQGKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499985; c=relaxed/simple;
	bh=/ob80odb7KO5pCRvNaIlCDhuGvAwOHSYzGGV5W2yV5k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HSoTw0RQ1ZmjjBJ5hs7ZK4Qr5c4qkNOoriNVjDvSBtvYbCyMghakWM1Qkm3FPgJ+ZSjMNAZka4rUjc6WYL/v1cUPnmSYkGnbquzgY1v1i5YqRmhcM+eNYkegb7NFGOVeEKx8x3PWkO+s2HHl5tgbH6Vb+uIvFiJjodJP7AwC48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432cb7627so391666439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499983; x=1756104783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTOpmTrDtQNaIlskACoqAyIcBXyQL/w+QtC5+BMkGn0=;
        b=WR+dj3QVRHYHGQyJ61I0mTtEPqcQ7AZ5yFemvFY8Ohhg0+sDGnOEVTTCUY0fLCCn82
         P2PcfHZnBdJgqjNSt4MbbXXRSzdP0vHPIUjOGSCct1HsSmRYOF/7Tppj+oGKpiT6nOGa
         fPxO9/CCjrqXbrd17EEexJ/cckTziYogm9kThZi715FPErL5J8/YQrFhQkvvO3rVtJZz
         Ic9/Xzw2AKO0r4e6PSOEGcJNYFrKndJWLimJelVVpzDKs7xfjGVNOvNbtoYZ0tg4bwM1
         eTBtj94eh2XskUQG8iOUBPK/7olAa9K65JADJDeicNA1fTIuzlaK7MLUgCTllfuFjW6b
         dc6Q==
X-Gm-Message-State: AOJu0YwoJSZgyPMSw9CbfF/3VsVLYyK2+HgbBFMjvNeVIIscaivknc+n
	z1h+Z2znnjyqtkOmNrPQNAcI0P+zDeT1Tr7bmkJcE9rlBNdO5wUJhVflV4AKdNz1N1LL9bYMDs9
	QfzXmYYPewhLdWvAEBlOq5efyERvC3K0HCluFo04U0BgbGOiLnUZyM1yIOcg=
X-Google-Smtp-Source: AGHT+IFc7dmb0tNJdid6u1v6/LhPYA9LlnGP8EVvmYs4dpqAD0m6plK1O7Hz9DdEpUTh/4aqT/mE55zX/gc6/S1hAvylx1aoO7K4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:3e5:7dac:d696 with SMTP id
 e9e14a558f8ab-3e57e9b4dfamr213947765ab.19.1755499983591; Sun, 17 Aug 2025
 23:53:03 -0700 (PDT)
Date: Sun, 17 Aug 2025 23:53:03 -0700
In-Reply-To: <20250818062217.1231-1-yuichtsu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2cdcf.050a0220.e29e5.0091.GAE@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yuichtsu@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
Tested-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com

Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d8eba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe8fc1adb24b215
dashboard link: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d99234580000

Note: testing is done by a robot and is best-effort only.

