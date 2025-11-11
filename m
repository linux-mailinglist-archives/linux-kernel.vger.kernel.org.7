Return-Path: <linux-kernel+bounces-895803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CCC4EF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF5D189F3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347E36C592;
	Tue, 11 Nov 2025 16:14:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216836B073
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877646; cv=none; b=SMSMKgA3x+dD47S1TxXn8+Zo0Qi3sP7Mqv+AE+4d9EjAe7FKBweNp6pZkTL6xTBgKa2pd4L07MFxEb/Bc6AmiRlyPpF5FqvBYEcPvLQTlUUtLZS+FyQgclf3jkajr5Py/WhjQcpBW0lpNHtQ2aAtpTagO4QWsceufzIozBWlhQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877646; c=relaxed/simple;
	bh=e1fItR7xlkF6B1r7PiNpZoKCLM2TIxoBsNzdDzi03Ps=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=deE3Sic5Zcg66Ev+B5+sTrZAXlJOrYpLyqWbBEtbtG8gIyIflMytZkRpCrFMVGU2DqNDcTaLtLbMNUIFMn9/Sn9DqMUWauZ7TM4VZj2EVU6t7y4Rx8Upl8144ce8/URNccmBls7uA5TsYAARlvS2KkuvDy2h/2fawByLeK2IbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43376637642so31896895ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877644; x=1763482444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsIzj5zeRN34MODne/Dex4pJnbVaec6z/SJRkF/VqmY=;
        b=I4SRydo9dVOyXiRkr72M8MmzWirV/nQyGLzTRR6CTH6jB0gvedqCu77NYNm4CKlDlC
         xn4fFGCXGA+NroXIh3kP1k2NCOSV2Qh/xYJMfdHAxer7l9l/eNaldkZ+A3k5DEI5ANaq
         +R8a7przroRcFlz6bBQfux0GOyFvFe1sSdiMZ3WcC6Cc8uon9trw2Wzs5jGkCcOEmncn
         Go1fxA2m+BVVKwjNUDTQfRqpcHBFpC8N97WfzqCEeDvR28/Z3edpWYi+O/yIxi22/Qpl
         XTvCXj3Xge1Y+fAuoKqi9qABj9hQO4T2iiBpNBPSUHe8BUMWcjBkOuPTAvsq7kBIOUIx
         +HUg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRsxJaOBngmz2F5BYOI74t6nUroGraEjQdoS3sME8cCuKhmYSrp/CGxK0aho2HU+mXml3CcvKBGIhIdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAAVUTbIsYB5U23S8E2Q0bazLGx7PhdMrc+KyCy+wFLyPoERK
	KLPKgzFaJxx7h7pRCMCkZ3uuBsSEi83MPI/HLgyKwxCSNVviOOjhCA9FCLWp48O5u0Bi8s1oI3d
	0nhdvDtMeXkuyrzlQOmkhpb+KCasirg24dbxzRMCjX7L/lRSh1HKcWI65Wrc=
X-Google-Smtp-Source: AGHT+IGhd1YIu4TmAb300ER5ywQ/phsKtardGYlr/w81752isCeFiUXjr5Li77UIL+5T2x/Jd6onzK9n8xsWrbfW3lALSN73fnOL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4914:b0:433:767e:8f47 with SMTP id
 e9e14a558f8ab-433767ec96fmr150345295ab.29.1762877644204; Tue, 11 Nov 2025
 08:14:04 -0800 (PST)
Date: Tue, 11 Nov 2025 08:14:04 -0800
In-Reply-To: <20251111-gaspipeline-getippt-9b19b62f89d2@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691360cc.a70a0220.22f260.013e.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Tested-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com

Tested on:

commit:         d2bab7f2 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=123a8658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

