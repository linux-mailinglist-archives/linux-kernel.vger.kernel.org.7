Return-Path: <linux-kernel+bounces-748893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72638B14750
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EAA17DCFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D072AF1C;
	Tue, 29 Jul 2025 04:47:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBA4A01
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753764426; cv=none; b=u9CMCnslc1CICcHm9ZJPA6lE60EX8UBcv5xjqgHVwmIdgdb4brIHVYC5AFFc/zT1zqXDsCdbc3Rdi+zzpQVQHasOq8Cm3F9kcCbWlwGVxD7bKI/ABBYpgEQx2DFgB2Q0+50gnN9p9EuGH8QfXxC4yIBw+FZixIvKdShW3xKh5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753764426; c=relaxed/simple;
	bh=F9qogi6VpHQCHUEQDmC7FTZNS81hv+ghQg1nqkYyyTc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e3pq4a1FCcScaTsxGufqicssePq+E9GqY4BiQvkOtVk35a+ZbJeczDA9o9kLDrNCk37iwYbAS4HbNp9xnCVC92RFdEgxV6x/PVEIDtjJ1YY0rctyMIrniQD7zPiXgeHiR9/erEYJh1MEGx1eQlrnd5EePGfwe2xsy0hKwy2w6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8649be94fa1so1064288739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753764424; x=1754369224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DE37bBcNfqDRgiBWzg/hRcBvVxig85zs1eJLgiJraNw=;
        b=HHojSpSZrOzjLtRB7fy0It3qC/Ju/ZncWUWIoUkIUusKS0TOx51ITn89vWCdKV1F+v
         8/A0jcz6fCDBZf3w4wEWjmqR7fXhedbpHHBn988P7ZUS5weTJxhxTGOjbJKoYyHzvJEu
         4M2xry194lTT45OviCwi1T2746DNvgOTZtLvKIq516ujhDJF6a8pphbs2ZhqYWS+s5IM
         Cv7nMVk+Fizu51oYpJC6FfgTLhAt+U0k9Hx5SB9SB3bCWbu3L8Q+6jdfEJYvkE8QALLW
         1hIJS6M+CfMPbxNezmmtzMZT2ErfBAl2JX1m6YqVp8aAWinFa0W7vj3XmY+5J0yhjUS2
         uKHg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Bh/a90CX5n15DOIXEgz3K3Nn7OZGrxXxRjmU7GUK5p2DIp6srfjH6bUsMF1CYqu8YHuD6wnOboGOvjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wcnGBdYhy5tLTchKEIDlHrRgQGt/+igR8zG1Pmxmrg70B22W
	2EKe6j2oHZhTF91qpveAeGbREZ2LzcRzqjEaAb3NYMroJ8z8lTrveQ7dtj4OkCgGzgBhdu+QJKR
	Pa4lHkbPRzC7b8deGPjpm8n6xdd6hfflzaHAwb2E44rDy4avnlV4R+1rQA1U=
X-Google-Smtp-Source: AGHT+IFE5lMR2y0yStx4KZzGwzl4aLvqSyYulQyG/1JeEaJmZqPWW6F6jKKbQJXJP1/8I2kzFAnWogq6tgMZaXw6txAxGE3H2fU/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c6:b0:87c:3990:5d27 with SMTP id
 ca18e2360f4ac-880228ef211mr2445116039f.9.1753764423822; Mon, 28 Jul 2025
 21:47:03 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:47:03 -0700
In-Reply-To: <20250729010657.3326-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68885247.a00a0220.b12ec.00c8.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
From: syzbot <syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com
Tested-by: syzbot+2642f347f7309b4880dc@syzkaller.appspotmail.com

Tested on:

commit:         ae388edd Merge tag 'landlock-6.17-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dd1782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=97ec33249d4bfda3
dashboard link: https://syzkaller.appspot.com/bug?extid=2642f347f7309b4880dc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133e94a2580000

Note: testing is done by a robot and is best-effort only.

