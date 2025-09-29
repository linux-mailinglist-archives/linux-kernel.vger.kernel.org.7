Return-Path: <linux-kernel+bounces-836455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F7BA9BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA573C41DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CE9302CC3;
	Mon, 29 Sep 2025 15:01:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDB2144CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158064; cv=none; b=OYDvRi5ChkHmx1RgJnRbL+R27Oig2dovieYZ1TCHmYMl88t/LzgBdLklHpXgBFA57sHbyb1pekm0/VlppScdX2KVKie6ABC8xjoqWGVVsURB67XBRj9PtK/+LtoMn8dIG+zVH8HLv95vIqWXXXuXp3HDnBPLwiDFz+qis8m8v9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158064; c=relaxed/simple;
	bh=kqKtiUctECn9kmKf5B6o9TfNpcgzAr3OYkuBP9r8mis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a3TqU9OYccF0qXXGxBgFYGKgaL4kolGouujG/e6UeniD1jefBQ1ju+E1tapNTCD5dty450uJox6IvT+XfLzK4X0jWcnX6pebaj1R0J+1oj9b/cdytSjVMtYyecprdQolCsC30FkIRjDeN8zM6qO7x3zFwvz+j8Pc/pYACcIw67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so354295139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158062; x=1759762862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94asxW8ZE3APUgWiouOWF2wnJhbUTK0rhduQOWPJzCc=;
        b=iTjJwvDShGOVlWwEKo1YQqJt56j+REe48iTtNTahsyyJZdjD93BOK+opB1vnsLO+fw
         J1xX5xFsxRIab8YV17dodgo8ixS1foWDXvP9p4woP1kz4vI1OQQQPv7q87EazIGHJYTg
         Iqe7TyZvR04xLh0Qc9SLMdNbLbAMzPMhhRzDCGrF9TiOTB5Wk73zkRhes3pmDkihz77e
         rlDbxISZButckfqrFyWkV0dT2SXJHP2Tm+dJYX+5NB9n3/djjOYkMnZl9SpoPwCi56A3
         prnSgg0UT6cysE1bv7HKKAHkXslKm0nrnjH/BbTFq77KUcOOHaQD4kul9nnG7tcXlbt7
         UC3w==
X-Forwarded-Encrypted: i=1; AJvYcCWIdz4l4d2ejUHByeW77+ctjy/ErWNIEQ+Z+m6HBz1SdBuJ8kvSNzUzIAf5imJgNUYxDJGC+36N0v0OlG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ntf/J5VU3Bsul5a0m6pTtwVv1tgf4yk6NFtMtS35yxyTtvpF
	7sFh9jBpOMfEWW+QXQG2jqJU3OoDg9QL2p7MJVWLMv9hMBClqSqTTk8qJsq4bxCZo0gyj52vrmz
	vIeVqlIKSPLmiW4SNXtGkM/xN9vxrm+aKBmOtoOhHKd5gSb2yLPHO1jXEXNM=
X-Google-Smtp-Source: AGHT+IFuPvF87bF0W0vGzdxp0+r5gMAnrZTwEsX0VRv9ggkGexpr3fQqc3SBajQcHP7SY/fvjuQlOM9A3wXbqtbe1P+TuY6rH6sR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:424:1e39:bf0b with SMTP id
 e9e14a558f8ab-42595609e3dmr235499725ab.8.1759158061630; Mon, 29 Sep 2025
 08:01:01 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:01:01 -0700
In-Reply-To: <20250929144049.359092-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da9f2d.050a0220.1696c6.0018.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com

Tested on:

commit:         e5f0a698 Linux 6.17
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e426e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1755fae2580000

Note: testing is done by a robot and is best-effort only.

