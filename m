Return-Path: <linux-kernel+bounces-731530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C21B055C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E0561E98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE532D5402;
	Tue, 15 Jul 2025 09:04:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D426FDA3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570246; cv=none; b=M752vXq9SjHaN42kblhLnPbBNNwCiy2slCjSKPklDmA0/CU5u8Td521tbkeNBZGQtLeb37+dBuQ7T1XIUefzu4rFATdvKYUc0aMEbTrwn8F6OTlLKo7Is2FgpaoT1/PPzRuFRjafsJyVJrIH+4TVIn4jGHKGjiKjPFGvL8/xjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570246; c=relaxed/simple;
	bh=Hgal95pWhIkm4ARgistTX7eJsI7PgXEc511BQLx+EBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PEq2SK522sfyxJ6oOZeIwO2ltPubyxppmI3dlpOenKKxnPichpImTTn0FjlLakjaLc7GB37IvLk7qJUcLSA4C0AzOfZu73pgW3mRwYr3F8PRltMew2Qx+fV8vxWCd8UtjWufE1rKoSkx4TGRetaPaLxD72v/hnfGUyBlTRvQKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-876a65a7157so484159039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570243; x=1753175043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0U04mN/2oj2v7b2IocpmISJyiaVHPDOdB924ZLvD+c=;
        b=BhrZ4enS+EkJ7tG/w1QRyzmyreOClfRe1xEHmkwapMg9IGqploO6YNxYC4sGDA0us7
         g7+fBk1n4nPaBg7tnOqKPjL6bOrRiuNjLvZ1ngoXI1i5spOCTuX6W7mKFzdq8Foq9GD+
         73ZFZx9VBtdhc3Y+uJMO706pheXipmwjBzedfC9ng+3lAJUI5Wkqdyb76r8Zi05a1Pge
         LAWkDk2AGDghgwqZ4ND1H26lqTlVTLMynidGhW05bNajvB/FvcU2Ds/1DNmh5droxFsA
         urL9mZEdWldCtFWDm7NVy4zU9lPFa6hxBm71auE4vaxWujKI6CjJYsdhwrm17jw3HqNp
         adxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNqPBiGMvkB2YeD+AtdwZHTpIIUwRr6lzMJCjAFGcr/GU6VRwXk8AxU/8gvSE36RvzLhYomcASFaQWrOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd80JY+EoJzFAbIo0v4Ei3eKjuWijHoWd+C1cc+PiE6anMwiE1
	UgJTn/TbTkz7rzTC+1Px8f2Ng/JxiGwTPV5exeSM5O2cTgbrkSQDbO1F3+AyI3l9F6E8SkpE9L5
	eE8yf7OaWE/ICEO+Uf/HYtqq7yB9U5Q3YLFZUVVwrEv74zjM7ksLc+ZR1kPg=
X-Google-Smtp-Source: AGHT+IHeQ5H3N8wnZgmrqa2EYv7bafJTEA57umdZbm+MpqzqcRX57CgS65kS+DLz5ufPqks7URiSthdf11Dc5H/O3430UHzHar9s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d1:b0:86a:441:25ca with SMTP id
 ca18e2360f4ac-879af0c6c39mr346281039f.6.1752570243090; Tue, 15 Jul 2025
 02:04:03 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:04:03 -0700
In-Reply-To: <20250715083157.2117-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68761983.a00a0220.3af5df.0001.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read
 in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com
Tested-by: syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com

Tested on:

commit:         155a3c00 Merge tag 'for-6.16/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15adf0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1292d18c580000

Note: testing is done by a robot and is best-effort only.

