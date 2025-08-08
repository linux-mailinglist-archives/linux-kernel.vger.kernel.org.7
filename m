Return-Path: <linux-kernel+bounces-760283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD37B1E8F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0167C16C8FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA6A27603F;
	Fri,  8 Aug 2025 13:11:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA5260592
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658665; cv=none; b=K7NMCgDqiZoaz0lukPOWJOrzHcBvW81J1Rn0qhzJXzPceJLpq9S+ijHzGFAHqV5wngPKQy0yZPCNSCEWzNWj77sP+LYGCpFvI3xN87mBs3yXO1mawdpHylkpd5E9RyQoofR4/yALEwKi2tpOpZxVZNfeHulPvinLJpTQ4cM91/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658665; c=relaxed/simple;
	bh=ZE0SEK60mtbsliMPxlAG8SnYeqvfSaBX40GSK/AanqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cCs+oSmfcPDFLjU4Sr6co7raoVy4XnC8PBIXSWT8z1PMUnB/Pil2zUA41dsaISPXhu5NfpDTog7pxg25uOi6INvUev91dIAj7nE9raS9KmGiprUZ/eMyvCPxZ5Yr0TUfvfrp3bB5/mzVxtkNKHUMoBhR3iI4Zpz1hkFxdR1m2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-869e9667f58so506335439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 06:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754658663; x=1755263463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhZx7zENkxQe5AbQJ77xeuD0BdDOYHSOItjPHuT1JPU=;
        b=mLNuqiiLtHuwzCNlL9CRGylCVLGWD0J8vWN91yjVYY4Aj2uO6+wX6rzH9LMz4EEQwe
         kskEqsQ1cUwuiNSO9T2BjpXEgjBwiQ1zSvtG/Gc/1eque2gOTjHQ807Oj/bh9n1sJJVQ
         RY3oeEWJNzw6gmNLBfW4G6Pyvbk/nlpJA25lGbRECpt7uwEadjPZwCCuLqi2nJ+kVRjL
         Rxg2qZ5rv7q0/7N+BEFlqqRiTAbH1/8JLDAInpfwyFKStWd588M+Yra+nEO8S2MBDClo
         5Gg9Bas09QPv51s7gTIdUk2GTtfH6YiprZv/8xL+UVNWD+A7ZUs6qn5M/4cHJZpD0BmP
         E1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZBrGEjib5YG2OvpAOPiaHIyiZq8C4HpSqj+svdERjzQe8EkFZ0f3iYumcS9EHfWan234lLsWwiheA28s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFezHhMkzeJBMnuugFYzwsdXnQrvjE6UPpRg/Ax1ZpiQi/M/e2
	dc7n7VAT3N4Rcj4SfMSjKlsJatVWsrHknnX1ktsJurmiUUa3JM5nX0jQTYdpkZ2HEwSmGPcpD9e
	8nGjWlTuLS0JNKlU0g4sS7qXlCi4WfgQK8EYiQU6WypsF4WOUR31gqVrO64M=
X-Google-Smtp-Source: AGHT+IFR/kg22snptckHcHi3WJ8VCMVs1g8tIWPbiYjf3ET+JTUIO003DYxMDbgSxq247KZH0Wmwh+F3efDO6l8FzFletuhXu46W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c6:b0:879:c9db:cbf0 with SMTP id
 ca18e2360f4ac-883f11b474dmr526446839f.2.1754658662655; Fri, 08 Aug 2025
 06:11:02 -0700 (PDT)
Date: Fri, 08 Aug 2025 06:11:02 -0700
In-Reply-To: <05795247-a9c4-40ba-b213-c2b4370f86a7@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895f766.050a0220.7f033.0064.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush
From: syzbot <syzbot+23727438116feb13df15@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+23727438116feb13df15@syzkaller.appspotmail.com
Tested-by: syzbot+23727438116feb13df15@syzkaller.appspotmail.com

Tested on:

commit:         37816488 Merge tag 'net-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ca61a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=251464a47fe663c3
dashboard link: https://syzkaller.appspot.com/bug?extid=23727438116feb13df15
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e13ea2580000

Note: testing is done by a robot and is best-effort only.

