Return-Path: <linux-kernel+bounces-815087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6FB55F32
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD742A072CA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D202777FD;
	Sat, 13 Sep 2025 08:06:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1D2AC17
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757750765; cv=none; b=Z3PxhmSrzWeLk9XXCNg89C3wRsz7qZV++vh6vgexckWY+R0KnhVIbfQi2Y//Uaquwym1vavrRxUD/5qP5qEfcKNvSwe7S4GL/F1kNhfcrtp1Z/sQU9EpqLxcUAnOKunQxvkEA+G6SKuTFmQXDGeuVsf8AVjEnWvUB57S78VBNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757750765; c=relaxed/simple;
	bh=3s9PLtSc9PtdseZ13zFzHEYn4NvL7vUG87Zb0cmxJpI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kUpUMgLw65/bs9OoS5KRzApl0r8feDAhYqSeINB4qIcrVpeagNOLYcEeniW05xTeY8dnKjV6JT8Vg7ymne5ykhrIxyby2auukiPjlD2ti3GaScH6beQ4hgpxjvvSeayMYXDAxorZtaBLJ+sVJi26HbL2V+LQob0gFqF5l1N2wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88de776aab6so223788639f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757750763; x=1758355563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYeBvDnPSZ9zbz1iT97mcLCS8g2XodPrYIhQglzCDzw=;
        b=Q5oZN5gwh/sJEXzcNzwiFCvl7fGmegcaooZcxBMp6dmmnl5g6Y1yxE2SgX8KEVAOZn
         nirVLMEgzaruKlBh/mQlk7l2J5EIF4kRChDfVz4h9HQmNh1jO0b95bJIMyRlHApRjUCj
         IzsO5wfFREDu1/6iLYX153cMmCtqAOaAjYvGO2JnTcJakfixer23c+oQqUvthQarUxp0
         0Rl6theRMEW8s2OO+527D7xu+MTbGSlpRTzawfWjNGNLwDVRnFOElWe+dNVz+FfalhrE
         erYZmdgGngEB9bSnXZXXoF2BSB+ne8Ed8Aqj5Xc5fpO7jZOnmdPBUxfLZFSnT7QH7Qjp
         ZFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjz/9caIce8j2kcOM2D1IrE78EqJlS9hVRueE6NYyE6UOtz5McqQl3VCELkolulXfXXcwh+ECiihgt184=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMe/ncNSpZ80cj6BbJoQdWhdPqIS0EqGOR6EXl1CbT1AiPl9ID
	1QGCgIDs1IiwHiw02bPCzn43gM0bOvxB/vC5YeooWupd8xHN3jHy2uknjw/7luo2Vm1Nr/hKavZ
	fD+Mi6EHnC2fUaGFVbcJIe1+vhRpI9u2m54Af7181A/CSy5WvFUEaiYKmxAA=
X-Google-Smtp-Source: AGHT+IFBtKLJbYVZqekGJFfRA79hbY30hBSUn2URLRjivwzNJhuFkWFdCp8mVJlHo99ikXhG1XypEJ7siww0SKXzlETLLZxxpX0D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2282:b0:423:f113:749d with SMTP id
 e9e14a558f8ab-423f11375a4mr6942415ab.4.1757750763474; Sat, 13 Sep 2025
 01:06:03 -0700 (PDT)
Date: Sat, 13 Sep 2025 01:06:03 -0700
In-Reply-To: <20250913072540.7012-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c525eb.050a0220.2ff435.0371.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14009b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1135d642580000

Note: testing is done by a robot and is best-effort only.

