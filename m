Return-Path: <linux-kernel+bounces-731019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713EB04D95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD624A7AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B102C08A8;
	Tue, 15 Jul 2025 01:51:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595782A1AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544265; cv=none; b=NlaiH6dKlx/woMu/cCU2slQzDPE/mlCkzwlyakwwKj3IpzWLj0LijgsMwzyGivoMP+rQ+3yIEWwzOYfpr6bSsk3758B/++Jg4Uk5tLi+kCXvY448jbgQfkV9AGT/YuA2sH9Aup06kWPbdhTVG+xLS+6beSpailje0twA2dEMvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544265; c=relaxed/simple;
	bh=4GpgeK2iWMlwbm/+IOg1lGLAZ/uLpLpo5VDUGVLC2D4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vBahKDOl9hGGfxgIvV2eV8TOlCFDYF3BWgja5YMS2mHFgFoUwFzj0MuTlHjh0o1U+X/qxX4ZfXsPV1TjVajRMcQBPtn+mdFbgmnlpVUmq3fW0/BO7NkDgq/KZCgvWyAa6UyKCOAB09N68StdeiYXTxFNSC9zk8yatCYacWZecw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df6030ea2fso102671915ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752544263; x=1753149063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reMjNMyNAxku8ZYvwvuVy+Vi7/An6GFVSbjyqiq/YJ4=;
        b=Fiobos61RgxnHySx8fPLphGWVPPWjAJoIQDGh8cA83oZgChmnf+IiN5R3BHzvCMUm5
         uVZbPCcIc2kV/e6TI/7ZtpcMriIDh5ZsDAZiijcjB2DpHLzZOGTyjBqN93RHtyGNm/Fr
         TEWRExW3IvbZ+U+o7ShKYvALIQBkJ5q0d/Myczi7BGDnvApqNupEy7KlEW38UnH3ZoqL
         5WrMl7Qz7WdX6/eZ2sBcElbJEsZCczBR2zDDv6dB3R9dJgGarj9fV2ZDeaSy5wzIbGvn
         oc7UBZOXhQprX36O/iy10pRVaR3NsOIMjRijYl5Q3U2WtRrTadxh1LCkKimMukl1fpN/
         cgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgDbTfzWKEEtMmu5W7B4yXcuieb9oG7M38D/XmFvqJKfQkXUKRuxGHyshrUwgknGxlz3PvR8jOzR3Ckoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUgqq5CfrxbXvASCIbJZjpkFWdld88NoX1KemUlVToC9bHmeu
	fT69FbLGVFexikFcxyDXjKEnJPqaQ6+ZD/x9zLLqh8xsQ5ZTGByD5Jl9tREX00S+xaGdIDcp3kT
	9/PERU0BFqQpiLf71K6FKwhaas+ZtKt8J/0MDVCkfwy4Gics4lklSBNgIp2g=
X-Google-Smtp-Source: AGHT+IFG6ePw+rgbhQJ3DObL+aA/CzBKOIoi/MmDiZPDt8329b7fDT6VCHpbMCSAk1DzscOtPUEk4+3MCFwJmlVRpChu3KUpaelP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:3df:2cb4:56cc with SMTP id
 e9e14a558f8ab-3e2555711admr133625635ab.4.1752544263477; Mon, 14 Jul 2025
 18:51:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:51:03 -0700
In-Reply-To: <20250715011826.4093-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875b407.a70a0220.18f9d4.0017.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in mas_start
From: syzbot <syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com
Tested-by: syzbot+ffe421482ad9d307c03f@syzkaller.appspotmail.com

Tested on:

commit:         0be23810 Add linux-next specific files for 20250714
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c5518c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe421482ad9d307c03f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a9518c580000

Note: testing is done by a robot and is best-effort only.

