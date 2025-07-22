Return-Path: <linux-kernel+bounces-741221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F2DB0E19C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCE81C860BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87C27C869;
	Tue, 22 Jul 2025 16:22:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5AF27C17E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201326; cv=none; b=QDP9i21q8ctTK+rio9U4jWhrjZ7iphb85VV5In7D4lAgnuacH/tWjCZyGUyBvi2sDzTIU1pG358ObuX0BanfdoRBgo+BpgDC6GDWVnxNFxaZVsos3YcIUqZF0XDxnZ+1cYGbgBjru9oURTDG4LCJ7BHZ7u4N0dQh03QfAGSNH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201326; c=relaxed/simple;
	bh=iXjjiU6hqG+cYm5BeVToCglsiiSmbBhJwlbz/CzmH7U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GQg2xlepUW3MOwlsjN60EWbKhNlPgbKgx+J0fOehWbaEr6b0HSWCFixYGCYmTfkDoJIwsgBrNze1ZxbalWAgNkkycIbvsbU7XReSUHjJfib3Z7GVicx7Nte4SrTQnzdpwdsGQZ5IHXCdoAzjJfi0Jk59SztnM5hRq5DjgygokAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso397707739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753201324; x=1753806124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKcb9d5VYbBm3vwRPDTQMq9UG6EGDzgJ2Zl3aeuMVAo=;
        b=ImdU90Uj+Wl54RqCDqzI3E6UH3fXkc4FWZh/Vmgm6aeTjUkl4ndlo1fjQ7mVZ7HmXC
         VKFJBy+Ms2LraWcJdGFQTQ/HOxJl2zmKKyd3BQ681MMTLdzslXi9kbP++ip/UjDcpw82
         4iFYU3oFy4wenojvuDmqn6NjEm6p5KwCEBp7jU9hYpPbzEEzNhcNbWaayBkZXluyzCPM
         60c1BY7MUQPXgMpjs3hSC1TuEzk07DJliHkrrlBIjk2DX84Y/qmgMl0REeD2sJmAe92/
         /Im0LkkR9i3zeCjdVh3njyaa5fmx2oHCxqfTe800mes4rw3bThW3vK/kwss/Uw2LnqbK
         uNGg==
X-Forwarded-Encrypted: i=1; AJvYcCWeL977OTlf1zZ20MTYZcEXW5LDuOzXWLIMCbY291oppxyOBvVcQtwlzlpdrIqToDFunPDI6cOiYtaIfcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACDUOVn9ObYB0B+rHTbms7k9bomK3RE9rRiXz5LAFuIHbOxjX
	aGnSblPDxt9TOGiW8hEr0QGNrQAkX6ZdbS+JlOBrysR1jPT14ttmJkj7o3OCC6TIM86d/52Qu+t
	IFI5dh49bnRx2VB7xp+adF3u20l6iwzZfdY3y5YUDD6b6N2yXpl9TVMzelfE=
X-Google-Smtp-Source: AGHT+IEjL1mozCzBJQRzAzQ5dF6Q5DIYhGWoBlkJ4tgme0WaCm0pYazgz+pZKutlxb0ZteK9vhhdO0FWAt7myt02kxDMYp52slTN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1348:b0:879:66fe:8d1e with SMTP id
 ca18e2360f4ac-87c0138865bmr3099989639f.8.1753201324361; Tue, 22 Jul 2025
 09:22:04 -0700 (PDT)
Date: Tue, 22 Jul 2025 09:22:04 -0700
In-Reply-To: <4ca54a2c-46c8-435b-af72-7f871236eeb2@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fbaac.a70a0220.21b99c.0010.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in exit_mm (5)
From: syzbot <syzbot+1c6607097b258f18065c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, jannh@google.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, mjguzik@gmail.com, oleg@redhat.com, 
	pasha.tatashin@soleen.com, pfalcato@suse.de, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1c6607097b258f18065c@syzkaller.appspotmail.com
Tested-by: syzbot+1c6607097b258f18065c@syzkaller.appspotmail.com

Tested on:

commit:         b659a6dc selftests/damon: introduce _common.sh to host..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=171ecfd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e150e8ba2089ab9
dashboard link: https://syzkaller.appspot.com/bug?extid=1c6607097b258f18065c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

