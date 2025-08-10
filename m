Return-Path: <linux-kernel+bounces-761475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2307B1FA98
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30803BCF4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3DB262FE7;
	Sun, 10 Aug 2025 14:50:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2829CEB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837405; cv=none; b=oV1zuTowa7Q0yDy9O382wHJqMUNXZE6ugNDHKGj098Vkdvl4ru57Ziwefet8UVAmHS9bJgh7YTYayrJoGG7LzDC6aXEXX+I/eo75ZX9YV/my8YjVss8fjbemND0sClALm1xg8JL0y/+6KXCfqLQhEVFisLUaR5yhnkmrjBwCT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837405; c=relaxed/simple;
	bh=+pEXslFSW8f8UiaL/v+ygF+Q81rPI5CbwaLn9YRGf7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KH5XVwb91PGs26XynwePq2wEQnbxLb3zSsqOCNcIEY7QXjE7K6y9DkbyngoxuAGd4A1zkO7RxxANTwikNdtAmCbitC37JqnRZIFm0odNmiDHQUN9P56iR9Knv45RuUL9umg3u1m+M71m8QGSkl54Ykm5VXsKzAQ64eDZX6wN/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88177a20e0fso778685839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 07:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754837403; x=1755442203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60eUBaP4S1YM8bshFqm4Sr3laTofYKn/0WXOd9xAoMg=;
        b=YWRe17E6rshR4y4zvPSxCeYI+n7AWtKNn/Tq8pkikQZY0gsHysNrSoFbBqbuq/Dk4R
         LYHMBxk9wpJgPNtULfh/Qw1Wkod+uDmTQrNv8ywd2jcrd/DVuPtuMzGhF0/b/UfV6lOt
         eao9/jeNnsBhkzli6rYi9IMMJ+9WTg3GMekvcNZOnh+6G4NS4to/+g1WwLfbkCsmso88
         oDpb39nlatg6jJR166+prYLcuxkR2+9UntjClVTbrtI3SAzfqWi0CgKyNuvhcylOfZ7g
         99GNsyEV1it/NNKk/3TWxMnyjsv+qhcoHOxYrAH9rnsljLWFhywNmTi67I4YpfMLiJCw
         VZgg==
X-Forwarded-Encrypted: i=1; AJvYcCVTm0/+enf22WTM4QBI9UZ65W6E/gJl1jdKeBldXZsS5U3iI0IjdwCrA040kXy+M1mYiCMiXEfUQlZSUUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2uIg5g3krVEbd5fMmLEr3qhHdxE5PAEY1wLsvGnSCunBMRoD
	1tcZ/MTtvXfEjpb9/CpWrxqgKKfEX5zUp7RNGjQddyZymxZOC4C4ZnAgsXcs5nnoD+IFEIENDDD
	iDV8NIjlTaRy00WzQbUh2+/e4G7NUKgDFEAXDhpoOSskkB20HLz2g5snu+9k=
X-Google-Smtp-Source: AGHT+IGf9Dq1NnHv965MWqAJj5twYpG+w/zwXyElvrhHtv8GVEAHg8eBNnkmhJP75MeCWIFzQEBVoBse4UZb0smPCb1kIzGobyZe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9ac1:0:b0:87c:49fe:cafe with SMTP id
 ca18e2360f4ac-883f1255323mr1470374339f.11.1754837403031; Sun, 10 Aug 2025
 07:50:03 -0700 (PDT)
Date: Sun, 10 Aug 2025 07:50:03 -0700
In-Reply-To: <6897b156.050a0220.51d73.0082.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6898b19b.050a0220.7f033.00cf.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
From: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	dev.jain@arm.com, harry.yoo@oracle.com, hdanton@sina.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, riel@surriel.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit cac1db8c3aad97d6ffb56ced8868d6cbbbd2bfbe
Author: Dev Jain <dev.jain@arm.com>
Date:   Fri Jul 18 09:02:43 2025 +0000

    mm: optimize mprotect() by PTE batching

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ac8842580000
start commit:   0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ac8842580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac8842580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

Reported-by: syzbot+63859a31071a369082b1@syzkaller.appspotmail.com
Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

