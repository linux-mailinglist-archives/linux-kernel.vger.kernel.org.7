Return-Path: <linux-kernel+bounces-753231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136ABB18054
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17520583CF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B014C239085;
	Fri,  1 Aug 2025 10:43:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD354233D88
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754044987; cv=none; b=A0mHib96J8wK5QmCuIzkEgKTe2uIQKe6vnV/cP4q2FfY3RbBrzbYMyjzVF3n/rm69G0ZpQBTRELtC5uc3AsO/Q7QLUCtQFX3FFFDtDfw71kOsZZ6mwK+Hari5q1Bi/BU7LRxrj6X4XcAr+Km6iVTUQ44V0JytTTuyQyM4O/r9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754044987; c=relaxed/simple;
	bh=zjyj9ZoVbLtOedm3SnSBw1q0yHuF8I7QpJ+Senhv4wk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qvng+DQfgwzy2uqpPyelkd2+5Ezyy7XuXXJ2YPK035EegD4liIsEDxwnyZ96I06RLBrDN/MzvnXUh1x3JpKf4x46DMzG/8kHg7NbcNI8gYWjlmFAFz2xSA6xg0ghuHGiDS5EBAq4Gzn2m54uyBpbRYmJ+PxrwY5eJ/wzQWJVl/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3f75449b4so11344265ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 03:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754044985; x=1754649785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoQsNyoD90if1Yi5tS33Af8CsMkfK/KVVhqGF8eskKg=;
        b=n1Kw7l/XBrDryCskbQHoe9pw3JJUI3q0x0zKvzVItZtymnwB3twt/qeECrIONXxt2x
         lkHgpvWlA9pzW8fseMtVdE20icR4zd4EmLI2Ld0vnbk7/C3XIepcU878dWplIBJRiDEC
         jPnWoCmBvCrT0hv1cdWA/J+jL7EMEtYJTYBvbSrnY69MVhrps6OHgdpvMgoQYNVnVQq5
         I3cLvhorN7oBCZylnpQEuXqPwmvR2f9K862wOqkz71czUy/qq1z3ycPlG49zVnVjFspe
         V0eRbi45jS/jM8MUkNDCQhZUWhh9xEEyLM6YJpdbx/+uQTeo0l4jXQjjpS9f8iqjDRnp
         QN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTvPYQTz6CJtKPOvi3lYtx6B7A3jcJxksCs1doWZUEFRPjR2lZE+n0Bv3sds6PfQoNaSXCY+I+vYmHSGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9PnUJVYp7PfLvZOwQ8rgyYvERoknDhf3rBH6QiuWxcFS5xjW
	MoQmIYmVA6+ASvwqFt7z0JBzgTtVKff4fat7Ie+4QkxKz70b1ptyHeOSelxYT63ksXCUopZsl/z
	CINbDq6djXC5RJvMfAchz4I43NW18nbxmneQ5Lcae29wUXdnxCC2suylKFi8=
X-Google-Smtp-Source: AGHT+IFn3GqlqczW8Kp3yLnyoOXYouUB0OgxOv/K5MuUj3oqnh8jvj0ofAx18tw0dUCUJ0q0ldnZ1QbnYxPuSzxZXHmarLSHq4TC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:3e2:a749:250b with SMTP id
 e9e14a558f8ab-3e3f625d741mr152096705ab.14.1754044984117; Fri, 01 Aug 2025
 03:43:04 -0700 (PDT)
Date: Fri, 01 Aug 2025 03:43:04 -0700
In-Reply-To: <e9f2e391-5c83-481a-9fa4-727c25922f1c@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688c9a38.a00a0220.26d0e1.0069.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in trace_suspend_resume
From: syzbot <syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, david@redhat.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org, 
	sashal@kernel.org, surenb@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com
Tested-by: syzbot+99d4fec338b62b703891@syzkaller.appspotmail.com

Tested on:

commit:         89748acd Merge tag 'drm-next-2025-08-01' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114c39bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4e0e50eb954bc80
dashboard link: https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135daf82580000

Note: testing is done by a robot and is best-effort only.

